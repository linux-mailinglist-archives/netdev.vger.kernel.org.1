Return-Path: <netdev+bounces-247345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D585CCF820B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01C430873B8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA7333421;
	Tue,  6 Jan 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMThdBje";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uONg7Zoc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CFB309F1C
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699665; cv=none; b=Qpe7N8jJxVUvlXZMGqguXwIdznMRqTI+mrDAjt/TciRs1Ii1XKTxfhmhS73kDDY5JM9S4ia/BBxRFPZ9xeHH8n9ZCtETuwooEWr863jJLjbHf7LI7r/RuTzIFNuFbWq0uUXf3e7Zx4+ODvsw8z885Ojex96KOXfCVLGwD71JCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699665; c=relaxed/simple;
	bh=ZFPdm0Sb23L2ABZe65OIwzquhIyIuoO02xAh2o3DK2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtP9X+wuyencQ/0MkvPm2/jajqbHJ0OYj0DQVOY4GeKc7FaUqNqvm51343MfKAxny3pztM2d+oPp/frwQz/i52OOgfwwVJg0/N6uvPSx4l7Clqz6Ma2NX6PE63aosoBeepnZjxTo8H91LlmKIipCwocbv0/iX3+wmFfyCgj7VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMThdBje; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uONg7Zoc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
	b=eMThdBje5ECjx9e4K/KOYXe9jN464ypKtcMJWoL9va7DeNBDrfT2d5UN9g5VSj0azr/o4u
	TResirK9blAs/lmEEqL+nxfis1qJnuEYU9puOeNs4D2B6XmrymB9VzYXZ30OJ2u7x1a3l1
	i+X4q6tKRfkg5fSKwdyEmfVdf2Lb4uc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-U5I6ybtPMa6e8yR28g1N7g-1; Tue, 06 Jan 2026 06:41:01 -0500
X-MC-Unique: U5I6ybtPMa6e8yR28g1N7g-1
X-Mimecast-MFC-AGG-ID: U5I6ybtPMa6e8yR28g1N7g_1767699660
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70b974b818so94095866b.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699660; x=1768304460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
        b=uONg7ZocbzvnSmd9C/9pneltG7YsSSHKG9aLm442nHlrxTQX+taxhG/QuduC4Pqf+h
         qScFKGEHaVnAYuxFBrjP4YCP5OUrgE6Tprv2Yjus/rzm8U2tZsG/a0EKt827tokm2HzP
         SDPZQid/jUr2GN3qxojPPtqOtpEDLNLVH1KTIHa+kI0nxleZr9KwUvaJYZZxUtN4Cp7L
         ro9xFVnzfdlW8etuhK9h9NRvBuUvxle/m1Rugff3qHOG7PHKZhfwuvcMPls/+nVXguo8
         KJUrrnJl7VFPsIBB1CWv9VLj04H3WKr+UKPxISHZ1QxarWmUKBXoFaqyn701qJiDuojg
         OEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699660; x=1768304460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
        b=WtL2Rh/LZ8BGPknn4VwkcBQTGE1K0TNFImhqwNI9nRMJdIfqJLWnTVK+CLCN9X5uUm
         52iLAzVPETXb1Ie6/u3f2xmhojDKgXrXdq2h3s0HV1oA4VzGqmuOXxlmbgSpzmAyn/x3
         JNcURGwFYOtEe11osduA9mmYvCtz9aPOJe7swNMUQW9aAe6EFY/6oILhzk9DGCiPmBCB
         dVxlT4bqG5IX73x/QMBFb21mLI9lvLv9CAZgiCMGwhwtGb4UtJ0D5bMvTvXlMt39k+t8
         K7BAv/lPp6HDEHwCMvd0Ar6RG87HuzjT8MJcrhn5sL3yuOiS3+nRdFuh0NsJu0lCm39x
         XS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAWiuVbCcuQdylAy38peoPAaIriZjQKmwHGZNMZpcXM27Sa9X7HwpnRoh8xh/1cTsX8KMV6DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3HX/DfOAqZFb7Bjr3PjPF7HYwekrVsOit9ZGhJZ+tQCyh2VU
	xgeMBtyfhRm00ZgZ93FzVFT0f5eVs7o4VUvGsE1vs8NkaxRt/K0gFp+pVRNVI539nq05419rgsv
	sSZlO66/aqBoKHkilNPzshg0SiAMyRoqAnwnKFKv0z8U1jw3HuazDKbtI/Q==
X-Gm-Gg: AY/fxX5UNp8gV2ZJBFhz7wDy1+BAmgi6L6nNS3wyBaZAmqarwUbtBRjNF7TKb7HNR9Z
	PTdVtAOwU9DAtcgaH7cY4jxbvKb6Iv2p42q69D2or3Jba944ODtzHJHERwuvrgaUR+D9cegv6bS
	dDifl6WaT/87hUgoEWattefdRG74TAOfFVZJrNo8yrEFEGbdhff3xlLivLnd3AW9ofAIHpmbk24
	y4OjX1DLk4iDKqohgF1Rt62yptoqvK5/x/dUMKEcdSOKNJhCVtSVntW0FgpzDkW1FrP/paSYqWP
	j3Zh+ryy5/ynfqq7/j5+VcvIP3Sx1v1gtpCUnWyD4ul7vNjX12VFACCFhAeY4WRBuK6+/toGlbQ
	QaRTWYr2Ln+/oBgNdTa4oxkmSlY+omWiSDw==
X-Received: by 2002:a17:907:9415:b0:b7f:fbb2:baa with SMTP id a640c23a62f3a-b8426bf1f67mr253289166b.51.1767699660097;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlVULk1XKrDpRHeMIX6aAH+s57+iirbmjB8Kbov2BA90zJ31sPcUIIaW53vwIp3ock1/A0Mw==
X-Received: by 2002:a17:907:9415:b0:b7f:fbb2:baa with SMTP id a640c23a62f3a-b8426bf1f67mr253286166b.51.1767699659630;
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51577bsm200967666b.56.2026.01.06.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B12AE407FD2; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 06 Jan 2026 12:40:54 +0100
Subject: [PATCH net-next v6 3/6] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-mq-cake-sub-qdisc-v6-3-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
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
 net/sched/sch_cake.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d458257d8afc..fa01c352f5a5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -67,6 +67,7 @@
 #include <linux/if_vlan.h>
 #include <net/gso.h>
 #include <net/pkt_sched.h>
+#include <net/sch_priv.h>
 #include <net/pkt_cls.h>
 #include <net/tcp.h>
 #include <net/flow_dissector.h>
@@ -3157,14 +3158,89 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
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
@@ -3172,3 +3248,4 @@ module_exit(cake_module_exit)
 MODULE_AUTHOR("Jonathan Morton");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("The CAKE shaper.");
+MODULE_IMPORT_NS("NET_SCHED_INTERNAL");

-- 
2.52.0


