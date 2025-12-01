Return-Path: <netdev+bounces-242928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 106CCC9689F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0926334549A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0B302CD1;
	Mon,  1 Dec 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qa+ZLQfD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkgG4uBu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD435302761
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583236; cv=none; b=luwxf9dx8VBSsbTO+XHVad45k3t9ahGIOuhzPnDGx/Pl7+6dZ8ddwoo90ApzwNgZxZ11I4f3MNcXE43Yd5xI3UB6D4C8nI6zjIx1CT81GHLe89pl7ZGEQOFha5HWqGHKMd7lij6SXOurIumjY4+tiUEysUK7ydk2cty1OC1zoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583236; c=relaxed/simple;
	bh=gbwyC+/Ku5Kf0YJuQw1Bgn0H6JP1j9LFV5nZv/R83bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqmiEO2ESdOu9ZOGgxVnMYMzZ8XqGvquEfIC3eYM1bSZzv/gg9OcA5U9q00QNqxk1kCEl+qfwBfzuuMgKX06rBrN/aVkrXvUq2FSuzX9lzvj48PC1tuQZMMUUUEYPBzsmX5Bvf4c7Ee94SdTQzEKM35ywz0rIqhc2YN3AQRTFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qa+ZLQfD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkgG4uBu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MyMLorfOhFH+uS2vDSK8eZtqEiibj8Gd+VQaEj/EJY0=;
	b=Qa+ZLQfDOWs1tbcjQvBy/j6xjkLw5ebO13QBSCOAXPb8wZIqNzuam+fOnajFaD8rPSiQIF
	/jeb8U+L7VMLAh55NyLvvoMkW0MRaj7ELOtZf3YW0elSyUbJKVkx/OMo/gfK+/RhZS7TfX
	RTJjw2Xme2Ok90Pw3S24QpA00eA1+Gs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-NBOAyJkiOGalUCKE7zNAmQ-1; Mon, 01 Dec 2025 05:00:32 -0500
X-MC-Unique: NBOAyJkiOGalUCKE7zNAmQ-1
X-Mimecast-MFC-AGG-ID: NBOAyJkiOGalUCKE7zNAmQ_1764583231
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7689ad588fso408777766b.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583231; x=1765188031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyMLorfOhFH+uS2vDSK8eZtqEiibj8Gd+VQaEj/EJY0=;
        b=ZkgG4uBuJ6LqIH4z51O42tsEkqEoPL/fpdBJu+MuFO+8Zgws+wDPCwoDYNxjb5gvkp
         zbXXlt09aNqsVV4m7IzhKXS91MDC8Fv15V1XEIC+tdLZLF3N6vJmv2vAixEOYg0g2bLr
         ZJRfjnZt3Uep6iaKihrtpPGR1cPged4l4+AT8crQZ4ChzmwJQn59jm1JngIGQM+6M5iP
         um/yEvGiSAisvafdnpM6pplkYeAuSmtF4VwmocMtPSZbtsmG6mk9r7MYt0gkS29t2rJs
         VzWyF2ALPEWDsS64POQqBby1BRP+wqdQ1eUPcqTez3i5o120O2w2WN6lxC7UwAy9pQID
         Ustw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583231; x=1765188031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyMLorfOhFH+uS2vDSK8eZtqEiibj8Gd+VQaEj/EJY0=;
        b=ttqsNL0RZk8YBBGY59j62UcyJMSYhBoIabGHakbPIiGroN05Mb0My5sDIqvjjDm8tA
         4wRmkBgH4rbCpjFPv40f2xxFPoZHyMhnwksh0nGXK/97rV2ysCUIBpNuQ8qHnWTfOoJB
         EHuMgeIu5HajmQqqfsmu1E94vlDJslCwUeMGSKS9l+/GhdIuNbsIVFj6Vv6ZHCr1sSL2
         CRSoTDh/lzI9Gubz4A6PPboNbidRo1atiV40KQE/+26fwkZgGv4LtubGgfXDYQbGv5zp
         MfAb0qqLzTM9ZCl31002wWOi4RAKS+ToDUT62rc52N2RIYRqH3rXfCZoMq+Sb/4/t+Rt
         04DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjTxVZW02rtb6IO5C1BzUDpmrXANMfommGj/lW1fVY5zI/8lIg2BTnPWLpD3SmDUwx8XpIshA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy3Pj7+2L44XJhVMFUWmuPWGRJbi7yq7VJmbpq80ZesV2dh1E
	MBm5v/PNhxVQ5N2cxYdjsRkJoPb4Ku9htMdnX6QTG7EOSH44FEPnUTG4vhuyCEvG5QbBMoD1vOd
	4fTENfLwXCUw+xyIDrF7+s8cbahWvPp7cB1AtVJPSqAyiGlkvwcHSsgfp+Q==
X-Gm-Gg: ASbGncuMwrsM+fOqzQmbyVgQYrWqq33drxHuEj1t5l2X8lJh0YUih1RiwqnuamKzmhu
	D4CD86LcSdSQUEeV3ZMFpT7TH2Zf6NudD7GgVpIHgPjHXcgUoBz9HV5JabTWh2VO/uOcF9JSv4+
	Ri7VRMEQZUaDXVfYW8mW6KqUnhbOixycxa4t/MWRKCIx7gwm2dBiSLPuqCxglzZDr8F3kTUyzth
	Nb8vLifwSAvU+KtidFWXA+qikEyW5TBLehnJgtk9v0zvQfw1BlFu8HhiuTk8fZnJKCWkg6RXxHu
	5Y+7dQgn/oavhjemLsclBvfhKPDWfnRpe9RZiN2AD8RXR7/WQBXEhDtyr98acxH3oYEzOj0+zHH
	Sm/4812+Bjkm/sLfF8CyexdalzTb1OXKJvahy
X-Received: by 2002:a17:906:c115:b0:b72:b8a9:78f4 with SMTP id a640c23a62f3a-b7671701537mr3906331566b.39.1764583230900;
        Mon, 01 Dec 2025 02:00:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHITPsfRcSRyog0H1I8P4PG0ThYZogak/QUa5BxkqYnsOWUxeuzMPCq3pm6yp45THvW7vgScg==
X-Received: by 2002:a17:906:c115:b0:b72:b8a9:78f4 with SMTP id a640c23a62f3a-b7671701537mr3906329466b.39.1764583230474;
        Mon, 01 Dec 2025 02:00:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aea6bsm1155273566b.35.2025.12.01.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A28FE395D57; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 01 Dec 2025 11:00:21 +0100
Subject: [PATCH net-next v4 3/5] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-mq-cake-sub-qdisc-v4-3-50dd3211a1c6@redhat.com>
References: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
In-Reply-To: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

Add a cake_mq qdisc which installs cake instances on each hardware
queue on a multi-queue device.

This is just a copy of sch_mq that installs cake instead of the default
qdisc on each queue. Subsequent commits will add sharing of the config
between cake instances, as well as a multi-queue aware shaper algorithm.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 545b9b830cce..48830e3ee8a4 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3151,14 +3151,89 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("cake");
 
+struct cake_mq_sched {
+	struct mq_sched mq_priv; /* must be first */
+};
+
+static void cake_mq_destroy(struct Qdisc *sch)
+{
+	mq_destroy_common(sch);
+}
+
+static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = mq_init_common(sch, opt, extack, &cake_qdisc_ops);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	mq_dump_common(sch, skb);
+	return 0;
+}
+
+static int cake_mq_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cake_mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
+			 struct Qdisc **old, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "can't replace cake_mq sub-qdiscs");
+	return -EOPNOTSUPP;
+}
+
+static const struct Qdisc_class_ops cake_mq_class_ops = {
+	.select_queue	= mq_select_queue,
+	.graft		= cake_mq_graft,
+	.leaf		= mq_leaf,
+	.find		= mq_find,
+	.walk		= mq_walk,
+	.dump		= mq_dump_class,
+	.dump_stats	= mq_dump_class_stats,
+};
+
+static struct Qdisc_ops cake_mq_qdisc_ops __read_mostly = {
+	.cl_ops		=	&cake_mq_class_ops,
+	.id		=	"cake_mq",
+	.priv_size	=	sizeof(struct cake_mq_sched),
+	.init		=	cake_mq_init,
+	.destroy	=	cake_mq_destroy,
+	.attach		=	mq_attach,
+	.change		=	cake_mq_change,
+	.change_real_num_tx = mq_change_real_num_tx,
+	.dump		=	cake_mq_dump,
+	.owner		=	THIS_MODULE,
+};
+MODULE_ALIAS_NET_SCH("cake_mq");
+
 static int __init cake_module_init(void)
 {
-	return register_qdisc(&cake_qdisc_ops);
+	int ret;
+
+	ret = register_qdisc(&cake_qdisc_ops);
+	if (ret)
+		return ret;
+
+	ret = register_qdisc(&cake_mq_qdisc_ops);
+	if (ret)
+		unregister_qdisc(&cake_qdisc_ops);
+
+	return ret;
 }
 
 static void __exit cake_module_exit(void)
 {
 	unregister_qdisc(&cake_qdisc_ops);
+	unregister_qdisc(&cake_mq_qdisc_ops);
 }
 
 module_init(cake_module_init)

-- 
2.52.0


