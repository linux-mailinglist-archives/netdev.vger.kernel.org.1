Return-Path: <netdev+bounces-242838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE6C9549F
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A83A1D6C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F72C11E7;
	Sun, 30 Nov 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWXnBA3u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oG3IAeoY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375728F5
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535053; cv=none; b=Uv+4Zps8cHdAlnZTSrKfPwk2P3w35ZHGai1TN/QELRq7aaIpXMz9q87eN8t9nWqyp8H2EP51Kk6A5/lUsrn7xX7c1GI71mHUewHTIbRy9RQI34nsKtInQxkrO4ZhxfxTGakGUZyAWAc0RP7WQx2oxTPxOmnHzaX/hQT1Zh0tzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535053; c=relaxed/simple;
	bh=4AuPxE/QDI6IITye9LtzQvtxgdORRTZ2wsxFFmDACUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxn1hOgcOYAkL1jAIzAznJus8DJHu5YPrBARq7F3Wr8cw5kLHQoH8i4LmptPeYtlWSBVkf2Da+nHnLO5+lncfVGkMgkqKCtYmys0xUoeW4nDaPk6tRMdXBwuyucDTw7lY4vCNrNJPibSEiFUiT5/XXsljPFLyuc3VpFM0jFMtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWXnBA3u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oG3IAeoY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764535050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CKwso0sYMJQqO4VfFGMWxTfY6Mo/xzbtN9lClbYs88=;
	b=EWXnBA3undkKRMHUeXcsr10IkVZ2Dxv0WoDvCb6socWPO/SovPSeFvKH6d8FqWZsXDQ8Kp
	gSuburqacQ+2MSS5K+ORztg7SrbCye0Y+u5IFpFt+9GMb5lCG72xfjuOQrB052CW7uvu1f
	aYOW2HHiA8plyYADpkL1UOXwYIq/xV0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-cwML6jOLNcmjIgL82HWk1w-1; Sun, 30 Nov 2025 15:37:29 -0500
X-MC-Unique: cwML6jOLNcmjIgL82HWk1w-1
X-Mimecast-MFC-AGG-ID: cwML6jOLNcmjIgL82HWk1w_1764535048
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b73586b1195so391960666b.3
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764535048; x=1765139848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CKwso0sYMJQqO4VfFGMWxTfY6Mo/xzbtN9lClbYs88=;
        b=oG3IAeoY9ij/uWWJfUKcA0P3DFlDpfRcpU68aFQGbbEk71EHbF9NshALwlQlZKOth8
         l6bwgkt8tfKu0SYb2C1fjPzKK8g9cwm4gkXxX0vcYd6IkqT4yvFggGoLhw7FNCGn5eP1
         2+IZTDKwk11+EfzhEdtnA3tB7O7G7afGVhpUIdzoHAm8I1qYLNoutca8oq1gDxgKd0Bn
         e9pQNNrmymcaXwrmYbdfndcWLYcLchEsM2ocqQiDz30niScTld2Aj4AKp3eB32h5i+fS
         5eZIbLDbZtn2XoASTwNUTrvQiZn6Vs9EOD+WZ0eI1FSz8B7kXiSzC7mNWi0aOH51MA1l
         BxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764535048; x=1765139848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5CKwso0sYMJQqO4VfFGMWxTfY6Mo/xzbtN9lClbYs88=;
        b=A04sTHRkRyG4ooefZqcmu7ravq/YR+UcepPXapaGMuIvbcscu06h3OK5sXlXAoBOrK
         D8QdAjMmlS+CcA9/xOoHCce7k2wf81I/EykbU3uKPj/5nTNjbnV2I4UqX9TWDZSP37O8
         TrVWMKKBcsald1sbIbmpEC2EbzolFhiRhJE0FTZcfrfd5fVqVHgHgfFb9QM1xPkDAwdx
         xAymhiBt7n+5cSdU4m8xRyuxHQ+VcSLfdvHPOch2kgbc9aMrVpJBRDtWaUjceQzXCFZd
         iezxgmrw2BDSAr18XeZEhV8bvT+JanRG65rNMmCk1aQeu3yy9OIT0Gld/RBNQNN/FS+6
         X9zw==
X-Forwarded-Encrypted: i=1; AJvYcCX96zgER1E/W963ynmC1muKS0mthEXj6MByL9cyRlfyhb93w0U7nKEQTVNa9idtc5sAf4blpVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Gad+E9zeGahYmvg03bdTScF9qetZMvoLZURf3pF5JVb3SLKl
	wf//IB8DMinJ7Z8nUEjF3XQEDky0TvoyB0RjcDHEzH01kG/oqVdrbw1wVAukG59lAnozvdwbuvz
	JkNd+nqrtVnX3HaQdETGpyemfkxcUO4H0HR34M+3Lki9kquU/iYeQk92e2A==
X-Gm-Gg: ASbGncuY9y838MYn7utaTWh+JCiAQkeilkTgmlNoayPFg0MlN9KkEWUVoDyGBOG81sh
	ziqmvSc96Yw+cSr3/uLfl3hotYA2fJ/sHm36Z0t+ZuAqk9kW8oow6n6IDxJ0EwAgbMwWISIGqmH
	xkLAs9yayEhYR7NHXN9qziRz192+5qFq/KfEMxJA6LcYjsWuy0jpJhBBiafARLdcf5bybGWRHPp
	GIrbm1S2ySi6kZbHmStofFblSEulGM1pVL4b38togENPQzZi85bWs30jjksOSpzzxzbp9eJQu1d
	Ln5zQcC5HD2Nu/+YlTia1LIpAPE2AddhzsS7n/B7lwgocRCIP4K4d7Id2TVm3OQxHx0F8ylwfjC
	ad3KTlIyLvCZGo8nAXW/2nFAGfsDbGHbRbw==
X-Received: by 2002:a17:907:d92:b0:b72:588:2976 with SMTP id a640c23a62f3a-b76719d749bmr3522248966b.60.1764535048048;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElmJmo4hg/2Kqg0PjWd9+E58vVUyFL8EW5kQTkceKQlL14rTfVMDP34XY640Yj4moSIuKAZw==
X-Received: by 2002:a17:907:d92:b0:b72:588:2976 with SMTP id a640c23a62f3a-b76719d749bmr3522247166b.60.1764535047683;
        Sun, 30 Nov 2025 12:37:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aea78sm988661166b.36.2025.11.30.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 12:37:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41FB0395C27; Sun, 30 Nov 2025 21:37:26 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 30 Nov 2025 21:37:20 +0100
Subject: [PATCH net-next v3 3/5] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251130-mq-cake-sub-qdisc-v3-3-5f66c548ecdc@redhat.com>
References: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
In-Reply-To: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
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
 net/sched/sch_cake.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 545b9b830cce..d360ade6ca26 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3151,14 +3151,80 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
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
+	return register_qdisc(&cake_qdisc_ops) ?:
+		register_qdisc(&cake_mq_qdisc_ops);
 }
 
 static void __exit cake_module_exit(void)
 {
 	unregister_qdisc(&cake_qdisc_ops);
+	unregister_qdisc(&cake_mq_qdisc_ops);
 }
 
 module_init(cake_module_init)

-- 
2.52.0


