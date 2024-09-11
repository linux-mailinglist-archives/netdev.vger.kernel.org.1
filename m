Return-Path: <netdev+bounces-127507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0D9759AC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA35B21A79
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACB19EEC8;
	Wed, 11 Sep 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="PpWRZaDq"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129815B10D;
	Wed, 11 Sep 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076789; cv=none; b=H2ASsFpzlBpZD7nUHVEEJaJF3iKatouwIPjhQV92LRJ4bd7Yf0GOsqs5auO/9D9QKRcIHYSN1c2Bl5UY4k6YyV70IeixJMX0j/tvxRZkwD7G1M1a0iDbC3XAbnilmdg22sKwf2lrqO4CQKUEfMh1tVoqLFKGOza5Rqi4OUcJmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076789; c=relaxed/simple;
	bh=2EZuhwqwlaVEZenQ6niO18+EPQVDFc2Q0ATXWEgQic4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWkjTvZ2hnbdMBGSh5vte7hEY5Wr7pUEeiMI9MC/TprSeFhcpeD6kzi10xmqL0LfEouZ9jEidXZrj7TdRvtslEOChZdyQKEXHwxnyyb2ZMULl8UTtMPH3znXKVLHOaGQf3hT1phWTeEvvQPhY0t+pGx7OOc4EFY7N/mhksroNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=PpWRZaDq; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B6FDF200E7A1;
	Wed, 11 Sep 2024 19:46:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B6FDF200E7A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1726076778;
	bh=I1zZqRCsPFbWtoY+PNGPf4kKde4iA92klZrH7tTx2y4=;
	h=From:To:Cc:Subject:Date:From;
	b=PpWRZaDq3YBNi9rUITzoZXUg94TID0Q/PYQwGXVdB7a3kFfbRxOLvl5E/bH9vhDpZ
	 82gcoaFUNp/KK5eacl3D0BpfJL5mhixtVjZf9NiDVBbF62zQXM/whGgrgtX0Xxnpe/
	 lSyVDPq8S3fwqIeq+gH5yGiI0pDNAGvFtowYqR5JKnQSSXPPeGIQOJsPYkj9S9hDH0
	 59Cj795vN4U0DVsWXHzjOb1JePubGj8IXa+eT/9AkB6CY5ArFcfI73Q//24SPP+DRA
	 UuBDk0RCxbGstO2A1fxVX1VVREOqmVJpGWdpCWQC/XyXfKOztZLZfDUgXel2+KiVcs
	 B3aDsKfj5gKiA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	alex.aring@gmail.com,
	justin.iurman@uliege.be
Subject: [PATCH net] net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input
Date: Wed, 11 Sep 2024 19:45:57 +0200
Message-Id: <20240911174557.11536-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the skb before returning from rpl_input when skb_cow_head() fails.
Use a "drop" label and goto instructions.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/rpl_iptunnel.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 2c83b7586422..db3c19a42e1c 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -263,10 +263,8 @@ static int rpl_input(struct sk_buff *skb)
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
 	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
@@ -286,9 +284,13 @@ static int rpl_input(struct sk_buff *skb)
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	return dst_input(skb);
+
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int nla_put_rpl_srh(struct sk_buff *skb, int attrtype,
-- 
2.34.1


