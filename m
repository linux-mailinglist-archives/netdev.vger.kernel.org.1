Return-Path: <netdev+bounces-213812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA4B26DA4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29EDB617FC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0D22E3FA;
	Thu, 14 Aug 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkCYUApB"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAB301019
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192228; cv=none; b=Sv7++R/fUEkwna+g6a3sj0KfXjV6X31AmFGDf5eO9qbEjGwGgCr3pPoMeD1pHvTZlO66Yc1XzQh6XMQctko9y61QXv+wjEq/i2lmZexMwMYXfoRowPXHkrgs+teyNUbKyDHWiQzlmqEbuukCzm1eJ0jyvYWQvpoztv5CkYb2vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192228; c=relaxed/simple;
	bh=8T9hXYsslvnQ0x+M49u1H8Bp3TC/T9xUU6KTqJNKmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rS60wiek9AdlboJAM8DuJkCSEITM7TzKLdtYruCvbwr6Y4a22f48tl9qysw3TEmbarBmzTQ3ZS1FE/4tGjM90SYE8V4usvg4Z7ZFbcq2IGLLWZnoALkdlBWiTAD9AOYmH1SUmFtz9yxftsp0inARuzOmxLITf25nY7F79UkFzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkCYUApB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755192214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wUIpu2gykwNNadNywpAPLikctcfGHY/K7iBfQRFKykc=;
	b=VkCYUApBXox3XdPftctuM2j4AL2QFxde0Cd0Ntp2U+hTVTt8l+cU/nkdyjICuqIGEvzJ6q
	TI3BLyCZZIvJJ8TbW5FEHCfjf7Jotj+KdQY1az4XEZ85fUOUvKqZSoLNGy+TQdEIAWHIBq
	BUviOXFRck8isunloIoclP87+yqOE0o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: pktgen: Use min() to simplify pktgen_finalize_skb()
Date: Thu, 14 Aug 2025 19:22:40 +0200
Message-ID: <20250814172242.231633-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify pktgen_finalize_skb() and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/core/pktgen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 0ebe5461d4d9..29ff079c0c36 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -114,6 +114,7 @@
 
 #include <linux/sys.h>
 #include <linux/types.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -2841,8 +2842,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 		}
 
 		i = 0;
-		frag_len = (datalen/frags) < PAGE_SIZE ?
-			   (datalen/frags) : PAGE_SIZE;
+		frag_len = min(datalen / frags, PAGE_SIZE);
 		while (datalen > 0) {
 			if (unlikely(!pkt_dev->page)) {
 				int node = numa_node_id();
@@ -2859,8 +2859,7 @@ static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
 			if (i == (frags - 1))
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0,
-							(datalen < PAGE_SIZE ?
-							 datalen : PAGE_SIZE));
+							min(datalen, PAGE_SIZE));
 			else
 				skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
 							pkt_dev->page, 0, frag_len);
-- 
2.50.1


