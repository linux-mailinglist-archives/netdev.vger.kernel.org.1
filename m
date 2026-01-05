Return-Path: <netdev+bounces-247038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77940CF39F0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA793013993
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D62137932;
	Mon,  5 Jan 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFMn5eWt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="igHcxm7N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C017736
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617501; cv=none; b=PBOuLUllh2k4z0hVRtTTcPEFeILS/WF8WmYrS+9nYM3rQb78OscKkZo+fEnijGVtvmn3oWD6P+17wyTRFOB0Trl1lrkjW8xzy6QaKaNOOhgPhR1JFigJJRyiM9CkUE8V2tUjB/BKZZzmLQojXkh+2anOYYB57rzvYlDbRurSQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617501; c=relaxed/simple;
	bh=ZFPdm0Sb23L2ABZe65OIwzquhIyIuoO02xAh2o3DK2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgT7IinOXkXDMOrGWLs1qdVFG+dbQpTH7I9JYrvCsDeJK0LpxZJkH2Yy10xzPYQiUe5VE/Zk8useYtmnV1ckIONv3g7S8uaV97QkQeOA8kaZReTkQGTc3+n90FwdjmXK//9cKfdauFCGOGnfcPELF74dnKXHdYHOkI1eBuOpUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFMn5eWt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=igHcxm7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
	b=TFMn5eWtrktParnGMMOUTV2ksfSKRPDN74rTuMt0OM2xa3Wk0rwc1pg22DJT9+bTzl+fIB
	6romkDIXA+CAAtU2zKQ/GWWiMx55R7Nb8U5WbilDRU7aP479qtt8ZCwf0Cia2D+cKLVQXa
	hFElEGn9RQDfMpUHhSnePGur5b7a9zQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Dvw1tgrxNV-UQ-XRYPD3lw-1; Mon, 05 Jan 2026 07:51:36 -0500
X-MC-Unique: Dvw1tgrxNV-UQ-XRYPD3lw-1
X-Mimecast-MFC-AGG-ID: Dvw1tgrxNV-UQ-XRYPD3lw_1767617495
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a29e6f9a0so1298292366b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617495; x=1768222295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
        b=igHcxm7NdaimXmWgzLbcqqeRkqIz6te9rVfiDj28eKCzRxqvJo6W359NXEgu8ZKDBw
         snbXg8VBSVCK1W7KhjC54D3Ajdl0l1YnvBhVGqyA0lKa/9/uiDRxqueWqZVCET96bsLs
         SpnhFjth1BYjvy7ptVwAbkQKyg3vZwvNg606l7ugkYizTKEHx3gPAL+QJZ8laqsgzALG
         S4znUrFfZ80RdGIcWsVDPcTko5qKV7kfj0xWJ64B9ZoH6ORlkwlnDLgutiBJqaTo5VcJ
         jICmjl0CUxqAKZxgU5xOCDZsXTePaAuUTzUv+Goi5BhclctBIJ+h0Hf4ar4vZn777eCe
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617495; x=1768222295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Evx6wtPcCJFwdSIMBNf+/3/a6Yi8p7xdbfzr/rqU+gE=;
        b=KZ7Md4+TbJ2EJf/DHM6HHuxuexuQQIv/9kib87DKkhPTxeL3l/D5Y1Uc6I7Leh+4SI
         5PIeauj4Pe5yK59+3Lb0eAKkp++FGgoe6dJorDsn+kYS3IT+TIX2mbs1Om00ToTTfPrG
         Ecgvw4tUnAHKUpuoMtl54qFBQ+81pMwfa7+kKLxdkHGlSYEC6CFSAOeOAjOZx05/TGBr
         Dv7EmBl9OMbT+BYcXbs8bhcU0TWQZwKkGQpK6AiYjhTjcgDosNEmtX6UN3uAwby68fcQ
         yFpmHHbx92uxIs7WcTk6wOY2AKTOw5es0cFl052VMLDX0CvR2uYj/9R9nU3f2q6MvF/Y
         o4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUsIQKzdQceh8E3uHI8L9Lr60vkReXeTQw3hq/ro/LdCRGJzxmiuW29iS0AQHmoZMQyvE7sHwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17KD/EJ4UsYDam7Buv8OwogJ42g5liH5/RMoFWbZKBW2rQzqz
	ix8wCioW9j0fDTgzElSg2FxJFMVNI4DuiR7wTMKJpa2ILlnqQ+DDLJ453gWYS1PsCkujlLVBL+g
	rUWMiEh+ghqINd2jo/KDfTSBWO8M/m2LVg05MDV+rQ0GWLXWFWEz+3ZciwQ==
X-Gm-Gg: AY/fxX44OkfmonnJf2mb4f05I+wa+fxmWjy8rQtrKSGpsEHw2dpEWuIDgqUMdV7Cbuu
	GKSw+eGJzr2PBmRkNwG2Fuw4JD0NJvvaMxr5b+pWdpn9v27u5jtmeg8xBSxGLicAofceh64S3bh
	XTJWEV1XifqLb2Ajad17rXmpSEg1cr3YU+6YkT26KCTZ+0Ww2ISx/UtQOGerk4uBLEevGvi2+l6
	0GtvaOa74PsdnavAbiwwzM/sQ/avtZVi18+REhQIe91S5JxgHoJU1bWIT87chKmmdF955qHzXUF
	yRFwRMmT6QcBAMgZCY0J7YHmt0wXy2i0q92II4o5PmAG8dsGMBK23orJu6i9QPKarNTbpYCVMva
	hwqya+cxOybGvzLvaNneetrIwuZPxMFf8Ze2N
X-Received: by 2002:a17:907:9627:b0:b83:3773:dd96 with SMTP id a640c23a62f3a-b833773de14mr2964139766b.3.1767617494982;
        Mon, 05 Jan 2026 04:51:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOXbjsSlZFaPDM/FXGXkx9MWaLhSgGGIxFPxpgOiIXxu616QC3Up3Xge5emeCV8z3dQ13mAA==
X-Received: by 2002:a17:907:9627:b0:b83:3773:dd96 with SMTP id a640c23a62f3a-b833773de14mr2964137266b.3.1767617494570;
        Mon, 05 Jan 2026 04:51:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b841fc8f2a2sm91451766b.63.2026.01.05.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D8A9407E93; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jan 2026 13:50:28 +0100
Subject: [PATCH net-next v5 3/6] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-mq-cake-sub-qdisc-v5-3-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
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


