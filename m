Return-Path: <netdev+bounces-110528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1592CDEA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C3E1F24BEA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673918FA1E;
	Wed, 10 Jul 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr3U/Ttu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534517BB20
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602484; cv=none; b=FYojZM+EFd1J3U5bw7jE3wUW+xbwpVsI5WH3zi6/8dDGyTLdxPVTrxVABzslBUBQMdkg9f4QCc/yCpl/KrySXqsRLrA/ioeOAb2zbwgtF+vVxtXiaVm8Ek7GGdlBSFwba22k3/8Tl3bEmvEPdem3cVM6hjzaysJddUaqrdEyews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602484; c=relaxed/simple;
	bh=PNr8+CnhM/2U7tIVgxUJ/2XYsvJvXzRxPg4eal0lEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhZNa1S7WilrSGqbBx4M63jGGhCvik/+95bU4vENvdjgruUBL9nhEN+4yfWEwVcFTY3ZQtgzc8Vke1Gj8k44P951q7FrQVSIDcFZcieJtEq5M+uZxJQpTfctmYqzgPZLjUh9KpdcSXwrTNJ+qaGfMDzt3BHdr4kh37/vZdoAO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr3U/Ttu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KleRwxeUd/xYw7yMlB9Pv44J4tuhsIQNdU/RRGJeFU=;
	b=Zr3U/Ttu/Gi9H6jI/N9MDvkmlt9HAaBU7qOXZeaG9o4oOdA7Bs59DZWD8YqNRHEhxB95Xw
	0mKbJYRb/q6Uw/1mHqt0mnNsfC6/DGSoBCpvfgZuXfaQtaLRRFPJFgjaJKkImGs9sV3Mtu
	muEHxTIvrD82YQ1vozJ1HNZwq5jwxz0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-eaUg1uOYP4-Fmx3hGQtKtQ-1; Wed,
 10 Jul 2024 05:07:50 -0400
X-MC-Unique: eaUg1uOYP4-Fmx3hGQtKtQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A01A1955F44;
	Wed, 10 Jul 2024 09:07:48 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC07A3000181;
	Wed, 10 Jul 2024 09:07:44 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
Date: Wed, 10 Jul 2024 11:07:42 +0200
Message-ID: <20240710090742.1657606-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
sk_buff.

Fix the error and make the input sk_buff pointer "const" so that it
doesn't happen again.

Also modify OVS psample test to verify the flag is properly emitted.

Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h | 8 +++++---
 net/psample/psample.c | 7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index c52e9ebd88dd..5071b5fc2b59 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -38,13 +38,15 @@ struct sk_buff;
 
 #if IS_ENABLED(CONFIG_PSAMPLE)
 
-void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
-			   u32 sample_rate, const struct psample_metadata *md);
+void psample_sample_packet(struct psample_group *group,
+			   const struct sk_buff *skb, u32 sample_rate,
+			   const struct psample_metadata *md);
 
 #else
 
 static inline void psample_sample_packet(struct psample_group *group,
-					 struct sk_buff *skb, u32 sample_rate,
+					 const struct sk_buff *skb,
+					 u32 sample_rate,
 					 const struct psample_metadata *md)
 {
 }
diff --git a/net/psample/psample.c b/net/psample/psample.c
index f48b5b9cd409..a0ddae8a65f9 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
 }
 #endif
 
-void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
-			   u32 sample_rate, const struct psample_metadata *md)
+void psample_sample_packet(struct psample_group *group,
+			   const struct sk_buff *skb, u32 sample_rate,
+			   const struct psample_metadata *md)
 {
 	ktime_t tstamp = ktime_get_real();
 	int out_ifindex = md->out_ifindex;
@@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		goto error;
 
 	if (md->rate_as_probability)
-		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
+		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
 
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
-- 
2.45.2


