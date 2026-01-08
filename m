Return-Path: <netdev+bounces-248186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE3D04B2A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D69330BF30C
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F62E03F3;
	Thu,  8 Jan 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtDW6srs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTS+uQtb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25F2E2299
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891486; cv=none; b=dgs4K9jv9omw2KtXvAZYkNh5zs8VUbgq1a84oP/J9KLn94M9eatkPhT8uRBlhhtJF7ymVg8u31pJlPW6fnqomrywrmCZGRSN+9w/8qNm4bq8pVFL/CbFvrLvebQvlPvDPSg0ProhnRypNm8QiU3XEXtshz7HAMCvMxTwpZyypq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891486; c=relaxed/simple;
	bh=rBizgM6oPSUltRQAf6X+Bsv0WZ0pAr3w5jX23tUPajM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryu1nobwmyC1tr/Kg3jwcJ85eUy7Zo38FLKnNLwXctLYHPswfVhyeFar3T1cLNxdb8xOjOHFvTxGiky0M4uY97hSS6X5GCyOpGdPRXMaEheSjHfYM/fdT+nuppezDCZxOVSifrXKNle9SXBahfqwpruEYADqV4I1dX7cVtCPV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtDW6srs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTS+uQtb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wh1VqkQP1gk0pNHOMt+6AH+4H573bSntIBzy73OL+jk=;
	b=RtDW6srsrnXOJcSpHMx/a5D28RQ6PMNe79B1PaqXwh6KQVXC/a3gWHkywLO7o/j3M7PSRJ
	AJ42onS6a3DQQ0gpDQIhi0v1J8REpdd3yhes1qSvrvh+ZqWmA4/za2X7u13t/jLJxwdPvv
	+IGDVlNRGHCDccSMMELE8tfpunk+bbk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bu-aPm_ZM5G-oQfyWA4sug-1; Thu, 08 Jan 2026 11:57:56 -0500
X-MC-Unique: bu-aPm_ZM5G-oQfyWA4sug-1
X-Mimecast-MFC-AGG-ID: bu-aPm_ZM5G-oQfyWA4sug_1767891475
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b72de28c849so320018266b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891475; x=1768496275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wh1VqkQP1gk0pNHOMt+6AH+4H573bSntIBzy73OL+jk=;
        b=BTS+uQtb/PnPg0vALB05I7NcLmM/pJeAbOHIP36niLQHn18AKwuFxGSocGwiT7ouS3
         I0Bqd5yIXwjLenS4qnYi8NyrN8KHui91zNaNj5dFRZBsV2XQOALbglVhOxQnedZDtwHr
         x7oHF3PIzJ8VN8CLDUZ8PlMMnw0s4/wawjpySwZqOO+DtOCwTJjWPwsMhDNB2NRcnh23
         ZwuibkrqaydLI0dUM4AJSS2HjkoDaV2I3aQj9Pcuvam1zc/TQw9ikdWX4stgGy+hYFkq
         7GYbafXrzZlX53BEm3YB7anE5MWsfS7AwHNVpCqTr6EjjkWCvU/u7uIKrZvuZY2lGYGX
         w3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891475; x=1768496275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wh1VqkQP1gk0pNHOMt+6AH+4H573bSntIBzy73OL+jk=;
        b=SwP26Wlg+SB1/FSFr4cLRKsQRmq1GufRBHJwwr1VYkGJJ+uK7D1xc7+h02THRW9KsK
         YU11O2WdPVYytJcrPJV1G28PyJQ8h696Zu4Hfr9e+DiuxsyBXCe7LTFeEfzdFPrcgX5Y
         yGjOZQKdiLEOcjhu4/SxVYayLQ0dGZkv+7GggvPdLutMZngCnpSqc/oBHNciNpTDus0y
         Kqjh0XMpo0oxzAgc8WAO7H6ODrGM941HW1QhJ/LGvpwy0l0cLW8lagNHSNm6i2zXLL+b
         /EP7QqHyCwQuO+g1ilWGRR2Vgvu3gcaZ4LAPPERArjyk51fLrOmXSiYiTUuiDA49cEjz
         FVgw==
X-Forwarded-Encrypted: i=1; AJvYcCUacJJJGzNnOKhBmMUo+k3Q5gjBij6lFXIE8D6UDBH5nK6FUSgBjqVNp/dbbRn3dxgzEqkvBVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVin/PqvACG0Ymh3pLG+OVlkZj1+vLOtGhJVkKca+rTH96A3m
	wQ5jzBERhZ8fzMISUmPLKJpgcrxScg7v8Xm23sxSLqFr5L+pSyN2KI/qtsbXttZPwmIuFfag0Zj
	XKlw80TVu64ZasswJPwa021jqjmIWAZRIMmKkFWJJQBki6osFXW7tqYaLPQ==
X-Gm-Gg: AY/fxX4hvO4BNm4VPDjNoRxOfxkPQbNAsteSLaQMTvkqKvDaAIhKSphal8Le+NXr3aN
	kneHk0BlKallRdOye8PLRK5ISatWoOSO4f0oJaTkUrjOMWrSCWSwfSe5fuT1RnOwxkRXrMRQALh
	b4gC0k0xIRRK+h7YTRe8sBQwOfnPnQZ/9QGeYwNvwNJ/g9fz4IQ+3q7OAXiTDcp3lHIvgB+jF71
	hFSYP+Ne0ALYjh637oGOzRnrPQ0D/L5jvZHmrhdH1zMIgWSyYCb8fXgwG5ubZkkFIx8KIZmF7WV
	jc4bp4uTFuvxpmcUbwfaqvuHmi410dHWkaU7IPqPV4eTz6yuL2rMF+u+y5eZKEHd9a6Y8h/K/8X
	9CUGNIJy8QdEPc4UWlQKfflLiAj3Zk1fQXUoJ
X-Received: by 2002:a17:907:a08:b0:b72:7cd3:d55b with SMTP id a640c23a62f3a-b84451694e0mr693883866b.12.1767891474847;
        Thu, 08 Jan 2026 08:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpN/Wg/3Km1w0bHJaXWYeWQDozDxMAJZTeWqqFiDTwbUSPWelypBSxAvhvi+h4gddZOtf7TA==
X-Received: by 2002:a17:907:a08:b0:b72:7cd3:d55b with SMTP id a640c23a62f3a-b84451694e0mr693882266b.12.1767891474435;
        Thu, 08 Jan 2026 08:57:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cff3fsm830534466b.33.2026.01.08.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CC51C4083BF; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 08 Jan 2026 17:56:05 +0100
Subject: [PATCH net-next v7 3/6] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-mq-cake-sub-qdisc-v7-3-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

Add a cake_mq qdisc which installs cake instances on each hardware
queue on a multi-queue device.

This is just a copy of sch_mq that installs cake instead of the default
qdisc on each queue. Subsequent commits will add sharing of the config
between cake instances, as well as a multi-queue aware shaper algorithm.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index e23b23d94347..deb9f411db98 100644
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


