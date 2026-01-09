Return-Path: <netdev+bounces-248496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D0D0A4F2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2550A300FEC7
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B161DF723;
	Fri,  9 Jan 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV0Ce6k3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/1AVh7K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10A1EA7DB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964544; cv=none; b=gQR/wDz8XNM7itYeUR6GAGdTogwY9o5uqOrcZNrbIE1lJoDQNh+LnD9/J9wxWqj6zKdMuDcP3jSRhZmBouCo2/cIZ/Sresms957CpwzGoByKC9dgcBdi/yx+B57h/zAVpuKRPz6H2DssRd6ti64jYKX+0axvlgdRCk9SLKQvIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964544; c=relaxed/simple;
	bh=IUpFxFDFneXRPrBN5rYaUUt5kHq4md45xveBt6EZg5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdzXioF4WTVo0oXD4rFkKroVUTHwy307FRxK4kqjaSwy4A7b/8F8ulRwlMaH6N2foy7DWA8/2tmbqbOiDe1qx2hXgvWHUJhdkF1nZdHWJWO3VO32fdSMkYlkWNT7sdxJZiEl/JR2tCqvAC6V8vOVJTEVI8ySAAmRRkN1ltZDz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV0Ce6k3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/1AVh7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6v7LIDmlBSSLIwJFDsDnkCD6163g5qbTTW+W41NUR+s=;
	b=gV0Ce6k3wdqINQszwRX6O8MVhuv16gVr0ZdzI6cqM/iTm19VLsxMfjTI5w9rhYbGupbvGi
	9kYq9ANCyWRJ/gmVR9T7Gf9FJnLPIoSCb5erc7xyAiz2ouB/WoYnxAeKLkfq+GYvUF+VC6
	W/mQ9XQFVXSX90kR8JqjqI6uA6S7/Zw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-3ABGxoriOGC4ED68DAqANw-1; Fri, 09 Jan 2026 08:15:41 -0500
X-MC-Unique: 3ABGxoriOGC4ED68DAqANw-1
X-Mimecast-MFC-AGG-ID: 3ABGxoriOGC4ED68DAqANw_1767964540
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79fcc35ab2so351784966b.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964540; x=1768569340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6v7LIDmlBSSLIwJFDsDnkCD6163g5qbTTW+W41NUR+s=;
        b=Q/1AVh7KuC0ZjSNlH2gxQgiYfWmHDWPleEKbkW/0XVv0+973rBULzx64MFFWmFjXp+
         J0Rr6wQ8BwNLly3H9nv65AtjIZHnOy8mwCqCv8FS4ydspmBe069yt/44mu90qBWucgDP
         B7gsQBcNdB6hyKws6FEXqlwcSbUuvlelistrpzdgJDNvK/McjX6kRc4ylyH/s60Tj9mt
         iPLyLqRXTarUOcMib73Eygv1cDAjselC72KRtAMARMsHcTpHvN069mgFMDgTu6boAavh
         EhhaqvnbTgESByOzU6NRkXPcscg7i+1v6kdefYvjqqsk6OFDfQns+c2bnTD6riCq7LKi
         J3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964540; x=1768569340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6v7LIDmlBSSLIwJFDsDnkCD6163g5qbTTW+W41NUR+s=;
        b=pkMKrImJYCUfKqT1tgf1yPC423fo5saIJ85vV547NMswtb6/3bkNGRSOhWwlto73Wg
         yeFJjK/iegpoCREvlLYxp8hi62GnJZ2pqpQMl4WFuI8BKHk4TIk+aWaafU25hMvYZzEM
         b+YAP4WQL1g2Q4uGgEw1XFGAWsS88UKAt2jH1JFvMzjEbquC7wkKXeeTQEMv9bzBDVVX
         q9OJ7Of+SC8HM6CjwGNXOHQ+0Y7D/l2UqGNEs9r36vepNEOFEe2CXJciY6Jr5kkjYPhQ
         jGlmNfiNdq09R3Yb2sRdSs8If0DozyMlXHbulz/YcdzxhUEpOtzaRXQ9iBm7QYRc38Dn
         Fnnw==
X-Forwarded-Encrypted: i=1; AJvYcCXd3f3enaL11xBOBnrej/vsPedv3F++7m6pyaTNNRmcxUxQ6ecfgiT9aqr8anrLJ0AyyVgPHEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyAO//YfWWur+ZlXIRlIaTohdh1WjBfHp62+vINfq82VTryg5
	IqW6M0JJyHke2MJdEWWnoURRbxFxQTWV+CRKKnmJR1Oi6MG8XsAiRORNJfcEZhvQLefOACTUuuP
	npdgahRqN2yjN1zATT8Vvz9G2aTNu73iZlREx2QFPc7HD1MxW5GIjsYjIlA==
X-Gm-Gg: AY/fxX7P1fuvJ6oGb8wo4G1/Fc9gOoQpkjQ50/VvLHtFkxbwpb/YPF9hzfAnbzoB4ev
	H2ppfroSr2tNFqmnwfmDDo9tS7GfmPbmtYQnu8erkYuOAClz6aiWRxUCEhZ9JTs5jDcEKI5QOk8
	NqDJQKr/+CnPMInMN/jYfP3WQrxaUBTAP8/bnNPpQuOW9eizT8UHwk3JvIIvH8pjAqY41G4eBgB
	9aOS9IZiLXMrkx1eHzJXNm005N7CCSl0c7ZkzVmjtROsJIFPVdYwFud3D6pxrg/qgTFs3qvOf+R
	MJfwjtSfxNX5TT5BB/o8E34OnNfaJhFghar8PWpHpU73qkfBINYVIq1d3aCjobD8I1NtyXis5kP
	PlV1D+GkuK/YKEAxA8eINl4s4d4+TtAk15U81
X-Received: by 2002:a17:907:7b8c:b0:b7a:1b3:5e5d with SMTP id a640c23a62f3a-b8444d4eab6mr1016401566b.8.1767964540125;
        Fri, 09 Jan 2026 05:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHuPjoMEJqZfbLiGY+Ot+KJUEOv4XZBJF8HqzJPsLJiPaUI6xualgZff0FVz208JYKVjAtJA==
X-Received: by 2002:a17:907:7b8c:b0:b7a:1b3:5e5d with SMTP id a640c23a62f3a-b8444d4eab6mr1016398366b.8.1767964539641;
        Fri, 09 Jan 2026 05:15:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2ab77bsm1158358866b.25.2026.01.09.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 28350408631; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:32 +0100
Subject: [PATCH net-next v8 3/6] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-3-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
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
index 8171674b160d..2671481d8e01 100644
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


