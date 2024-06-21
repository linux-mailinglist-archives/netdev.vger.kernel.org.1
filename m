Return-Path: <netdev+bounces-105632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D399121E0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB8A1F28BB2
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF56176258;
	Fri, 21 Jun 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPfFJmdS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361E17556B
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964718; cv=none; b=CMOqcl5b+979PFhrRRg3o97v+ZEqpfDrYYqufQ6fP7bjVEKIRkzQNHrxhvduzDxFF7aD7NDI50kJM3YBlk+p4INK5FOgq+lgDK05x/5OL5SlgXljLVooUoOcTbSmq4L4mB1KvSCM2vU2FDV/OWCBWHWN6MFI9qzMXXAuUXA8C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964718; c=relaxed/simple;
	bh=z4Yy+U4uehQ++A/G5l/zIQt9seE0IMgFku5riP5EMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETRJZh0jUntCM09JR+/Vja5356Uxb2gKllMMh1g4W+8yOQ7+3YM1zhPj15VxMpAx1HqVG6HIL9bZqJ9AtWj8gD/0Trdx4kDCPP+dgvB0iLwZKyL2C0az3naKO6EYYtdUZpXEPZf4sZm9DSxiuFTZnnxtN1YXQIX125tbMp+NquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPfFJmdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcxrhhFi5l+NUgOTWEhyXPFPi3rVOzg15nAozasXi0Q=;
	b=MPfFJmdSx+ldTLmBID1WSpZ7AjsKH9wORQHnTsOR2a0p/NHKSFxujy0mpqZOA29RrUIXWY
	Ga/azcaFXVu1Slwe7WGucLO574O+4fnQ7zcPFiyKJvhk7CAR4N2vKa8QjRcIoFee3lIzSV
	ptruHPHZdHxut9K8M650Uo57jcdRv+Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-EPKcm_f8Pl-XGhDp1OuTSA-1; Fri,
 21 Jun 2024 06:11:50 -0400
X-MC-Unique: EPKcm_f8Pl-XGhDp1OuTSA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 598B5195608C;
	Fri, 21 Jun 2024 10:11:48 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 591941956048;
	Fri, 21 Jun 2024 10:11:43 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 04/10] net: psample: allow using rate as probability
Date: Fri, 21 Jun 2024 12:10:56 +0200
Message-ID: <20240621101113.2185308-5-amorenoz@redhat.com>
In-Reply-To: <20240621101113.2185308-1-amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Although not explicitly documented in the psample module itself, the
definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.

Quoting tc-sample(8):
"RATE of 100 will lead to an average of one sampled packet out of every
100 observed."

With this semantics, the rates that we can express with an unsigned
32-bits number are very unevenly distributed and concentrated towards
"sampling few packets".
For example, we can express a probability of 2.32E-8% but we
cannot express anything between 100% and 50%.

For sampling applications that are capable of sampling a decent
amount of packets, this sampling rate semantics is not very useful.

Add a new flag to the uAPI that indicates that the sampling rate is
expressed in scaled probability, this is:
- 0 is 0% probability, no packets get sampled.
- U32_MAX is 100% probability, all packets get sampled.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h                 |  3 ++-
 include/uapi/linux/psample.h          | 10 +++++++++-
 include/uapi/linux/tc_act/tc_sample.h |  1 +
 net/psample/psample.c                 |  3 +++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index 2ac71260a546..c52e9ebd88dd 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -24,7 +24,8 @@ struct psample_metadata {
 	u8 out_tc_valid:1,
 	   out_tc_occ_valid:1,
 	   latency_valid:1,
-	   unused:5;
+	   rate_as_probability:1,
+	   unused:4;
 	const u8 *user_cookie;
 	u32 user_cookie_len;
 };
diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
index e80637e1d97b..b765f0e81f20 100644
--- a/include/uapi/linux/psample.h
+++ b/include/uapi/linux/psample.h
@@ -8,7 +8,11 @@ enum {
 	PSAMPLE_ATTR_ORIGSIZE,
 	PSAMPLE_ATTR_SAMPLE_GROUP,
 	PSAMPLE_ATTR_GROUP_SEQ,
-	PSAMPLE_ATTR_SAMPLE_RATE,
+	PSAMPLE_ATTR_SAMPLE_RATE,	/* u32, ratio between observed and
+					 * sampled packets or scaled probability
+					 * if PSAMPLE_ATTR_SAMPLE_PROBABILITY
+					 * is set.
+					 */
 	PSAMPLE_ATTR_DATA,
 	PSAMPLE_ATTR_GROUP_REFCOUNT,
 	PSAMPLE_ATTR_TUNNEL,
@@ -20,6 +24,10 @@ enum {
 	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_PROTO,		/* u16 */
 	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
+	PSAMPLE_ATTR_SAMPLE_PROBABILITY,/* no argument, interpret rate in
+					 * PSAMPLE_ATTR_SAMPLE_RATE as a
+					 * probability scaled 0 - U32_MAX.
+					 */
 
 	__PSAMPLE_ATTR_MAX
 };
diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/tc_act/tc_sample.h
index fee1bcc20793..7ee0735e7b38 100644
--- a/include/uapi/linux/tc_act/tc_sample.h
+++ b/include/uapi/linux/tc_act/tc_sample.h
@@ -18,6 +18,7 @@ enum {
 	TCA_SAMPLE_TRUNC_SIZE,
 	TCA_SAMPLE_PSAMPLE_GROUP,
 	TCA_SAMPLE_PAD,
+	TCA_SAMPLE_PROBABILITY,
 	__TCA_SAMPLE_MAX
 };
 #define TCA_SAMPLE_MAX (__TCA_SAMPLE_MAX - 1)
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 1c76f3e48dcd..f48b5b9cd409 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -497,6 +497,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		    md->user_cookie))
 		goto error;
 
+	if (md->rate_as_probability)
+		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
+
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
 				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
-- 
2.45.1


