Return-Path: <netdev+bounces-67599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77C84436E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584FCB251A5
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA7B12BE93;
	Wed, 31 Jan 2024 15:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from haven.bi-co.net (haven.bi-co.net [37.200.99.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129D12A143
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.200.99.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716362; cv=none; b=ajx4gtod4z9XeOyBObyvm91IZtmJMwvIWCYkSDQ+NEbN5jrFVF1OI5CY9FOr9TFAW2aqXzJlqPhrklY32k+3mITafuOl7JzAzcP7ZhJigeP9hF8KVa24DWJ0LjkCBZCCl9w6KT4mlhzYOGYUNG+BZFfEmEoCDB7UotnGcp9CcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716362; c=relaxed/simple;
	bh=GyS6q6H2fs1wNwq2b3HeOM5li7TSUnmbnd5bd5Tn8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=og8kLZoL733n0pPkYZHDiTQ9GukunDSj5hLEKS1B9RtBl27J9RQ5qrlrNuO9esLxK4YHa5NkkHfAN0Ll588ALhTkmiGwUo74s4KFwc99wiqSa/b/UAeztGRZwFpf5DwU93Td/YGfRhGbkhM0tc7eU5yRmght+XeeJM0XZ7qUhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bi-co.net; spf=pass smtp.mailfrom=bi-co.net; arc=none smtp.client-ip=37.200.99.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bi-co.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi-co.net
Received: from zenpad.fritz.box (ip-037-201-146-158.um10.pools.vodafone-ip.de [37.201.146.158])
	by haven.bi-co.net (Postfix) with ESMTPSA id 8B3852006D;
	Wed, 31 Jan 2024 16:52:38 +0100 (CET)
From: Michael Lass <bevan@bi-co.net>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	regressions@lists.linux.dev
Subject: [PATCH] net: Fix from address in memcpy_to_iter_csum()
Date: Wed, 31 Jan 2024 16:52:20 +0100
Message-ID: <20240131155220.82641-1-bevan@bi-co.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
address passed to csum_partial_copy_nocheck() was accidentally changed.
This causes a regression in applications using UDP, as for example
OpenAFS, causing loss of datagrams.

Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
Cc: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Signed-off-by: Michael Lass <bevan@bi-co.net>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 103d46fa0eeb..a8b625abe242 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -751,7 +751,7 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 			   size_t len, void *from, void *priv2)
 {
 	__wsum *csum = priv2;
-	__wsum next = csum_partial_copy_nocheck(from, iter_to, len);
+	__wsum next = csum_partial_copy_nocheck(from + progress, iter_to, len);
 
 	*csum = csum_block_add(*csum, next, progress);
 	return 0;
-- 
2.43.0


