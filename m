Return-Path: <netdev+bounces-214086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E63B2831B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4491C86A39
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B0306D58;
	Fri, 15 Aug 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIPcYaWT"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EA306D51
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272511; cv=none; b=o3BEzpR7fEd6Kc+W5BaKi/wIlfPH3WdumNdeayY7Ff+EwUdpv7YHf8I+TQumnjByxoHyK1yQTVuJg2FM9Ej8QY7TmZ5QRcmBcK2FjOtiKjoNtliuH72C8+Vscv6f5hVLJt8UfB8tdAnti48EIs0yY9Yd4UiSlk9+E4RyqSdbfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272511; c=relaxed/simple;
	bh=kWIeKW/3+LZqeCGlBxC1tJztJxOj/OGJgM+qI//Vx9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3jLHdimmnSlz6p/1OL1M15xfRS6W0BlBUeOyiFnYWS1h4+LS4GavGqPyWegZ8mha+G3oU4f/yvBXRh2pFuyTfzdoDd5pp/5zV4/9gHxRh2RhcvciUJHUyaJSgVp+aj5sV4zh/jPp01P9jz4qhk3To3yPuKiEykz7UixSbQ8TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIPcYaWT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755272498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XoTQC/MqUTM2TQEXO9Dy4N6Bkcqbv/50Gl4TO7GZo+k=;
	b=uIPcYaWTHp3Ue8B4JNxoYifSJQXbTMFYo9VBbbhuUTSstk5ZvuJdzCAtUuFfOurlsrUn3c
	+K51SfEV+p6egayGXTyYZc6XuCNDDCg7z2eA4M3TrXfYExajEDUOl/nPNByW2irNW20+Ks
	+xwwM/CUWKRjRbiQ5cAqOTW74MUjhDc=
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
Subject: [PATCH net-next v2] net: pktgen: Use min()/min_t() to improve pktgen_finalize_skb()
Date: Fri, 15 Aug 2025 17:33:33 +0200
Message-ID: <20250815153334.295431-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() and min_t() to improve pktgen_finalize_skb() and avoid
calculating 'datalen / frags' twice.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use min_t(int,,) to prevent a signedness error
- Link to v1: https://lore.kernel.org/lkml/20250814172242.231633-2-thorsten.blum@linux.dev/
---
 net/core/pktgen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 0ebe5461d4d9..d41b03fd1f63 100644
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
+		frag_len = min_t(int, datalen / frags, PAGE_SIZE);
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


