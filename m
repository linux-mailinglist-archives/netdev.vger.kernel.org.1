Return-Path: <netdev+bounces-89019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D98A940F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B14B21A85
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B256462;
	Thu, 18 Apr 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Wz1a2St"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233D7441A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425576; cv=none; b=UcvnE7uqxOV+agBs+r9r/BxXVb/3BcepicM1Hd9HprdjdCqOIpnxBuT+0bv7E+XpIEas0OKmG+6lb/4/btw+hAC89SH5wMLoTKx44wI2nTMtu9IE1dMpo14PQcjYPoj5lLYJTXs+hGKNA5SRIwjopRtgk/vnMzTX7DoejYqtfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425576; c=relaxed/simple;
	bh=VA3q+py6+0bIP4RFIUYyvmm6mwWK/L1YqBrFYQUkRv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NIZz2yGysh6gq8X+MAXba9rfNc/FixpNToEhdb+EK/9KFefEP4vcErK5ooVK/Ht5n8DhchthTfJn+JLkk/6uU3NznMlHdUieyVggudBNLkMKpUyuKQIQNvYILzetHY7bKx3MSI5ylJNRoSqo2eAPaFXSpwb/tQ05o6PkyawQUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Wz1a2St; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de46620afd7so775513276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425574; x=1714030374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i80YcpXlTakcqdlswld70FgnUZ4IoM5N9iASZpSALs=;
        b=0Wz1a2Stj/zweAAu1j2mrlQ9p4SjlO2ipiZKv6nTKPFBCxAckzp9uQXn7YO6WU3JSd
         4jrpoTrRYwGHB05NE0vBShhhAI8HlFOoz5+aCpN/eHptBwx7SRAsEaX/Us32gpJy1wZh
         F8xWTvbSbyZeI0TQi3/irUqrLREufLNsKj9BGENQK3qh/sbC1teZAYXF68PifRSHA6hr
         yyXuxd1dLOEPceWIZPY7cNVjW+dy9RNA2+x+8W0cPbW+BH8KuyMSvOv07g98KxkHi/do
         F+2jNDjchya/cW5uukEFAsqtIyDJ2EKG8P1hRfQ19JqXfoacQ01wr6awSVHwgNmsw+b5
         oZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425574; x=1714030374;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4i80YcpXlTakcqdlswld70FgnUZ4IoM5N9iASZpSALs=;
        b=kqn9CDK/y98xDEdEQw1OAoBkSsdD/xyeHm0u97ExbSmuEjJZ+FAM43YVSpGSLOOysY
         gWOxsjRzEZUi2qxtFXuild7z8VMvSsLCeBHmdFz9VcHFTiMz3EU+8UbC9f+UF4KUmNJb
         C11YcEKvUX2xN+xBb3bwwQt13HfdelPEHifI3ZcT6kJK5HXKVXTzCObX/W7w4l9wDuDA
         niatA++fnFv1VCBh0y/oIADvqshqKYY9S1+gIF2Dg0FBb45pkM4y/5rVlD9/xPbuNm+V
         2C9cjPJ2LAIsaDHKxtBstNMSlczO4KKf9eVPTqzTfYmpGuabcsZiyoC3Ky+f+nWxaSCE
         E1IA==
X-Forwarded-Encrypted: i=1; AJvYcCW7kMH3mdzvOePDWfyOdurLjbyZkrXuB2ziG9m0z2EwFWubLPN8iZYgwyfvhRCubdYxcTAxhIOnHsQ1E84zvQtPpVLTM0s5
X-Gm-Message-State: AOJu0Yxfd3bk2SehC5wmBMw/jwSWTIFvIZdxQVCmi2Wb3oGQWqYVvG0p
	Iw4+tqg+xnLD9cX95VTblaxyLi1TNLR6mPjGUIs3JtbP4GT62Q1Zy7Bwaa1zs2uelu22GpxX2VF
	xYrSdtif2Ow==
X-Google-Smtp-Source: AGHT+IHZwYse95tmVltlJAH+GaM7RmC1SmhKBoxpsyzbg4o/QJ9IFo4f5ZEuoWUFGvxrwV58x2KahmgiDsLTJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1209:b0:dc6:dfd9:d423 with SMTP
 id s9-20020a056902120900b00dc6dfd9d423mr207227ybu.3.1713425574110; Thu, 18
 Apr 2024 00:32:54 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:36 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/14] net_sched: cake: implement lockless cake_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Instead of relying on RTNL, cake_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in cake_change().

v2: addressed Simon feedback in V1: https://lore.kernel.org/netdev/20240417=
083549.GA3846178@kernel.org/

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
---
 net/sched/sch_cake.c | 110 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 47 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 2eabc4dc5b79a83ce423f73c9cccec86f14be7cf..9602dafe32e61d38dc00b0a35e1=
ee3f530989610 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2572,6 +2572,8 @@ static int cake_change(struct Qdisc *sch, struct nlat=
tr *opt,
 {
 	struct cake_sched_data *q =3D qdisc_priv(sch);
 	struct nlattr *tb[TCA_CAKE_MAX + 1];
+	u16 rate_flags;
+	u8 flow_mode;
 	int err;
=20
 	err =3D nla_parse_nested_deprecated(tb, TCA_CAKE_MAX, opt, cake_policy,
@@ -2579,10 +2581,11 @@ static int cake_change(struct Qdisc *sch, struct nl=
attr *opt,
 	if (err < 0)
 		return err;
=20
+	flow_mode =3D q->flow_mode;
 	if (tb[TCA_CAKE_NAT]) {
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
-		q->flow_mode &=3D ~CAKE_FLOW_NAT_FLAG;
-		q->flow_mode |=3D CAKE_FLOW_NAT_FLAG *
+		flow_mode &=3D ~CAKE_FLOW_NAT_FLAG;
+		flow_mode |=3D CAKE_FLOW_NAT_FLAG *
 			!!nla_get_u32(tb[TCA_CAKE_NAT]);
 #else
 		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_NAT],
@@ -2592,29 +2595,34 @@ static int cake_change(struct Qdisc *sch, struct nl=
attr *opt,
 	}
=20
 	if (tb[TCA_CAKE_BASE_RATE64])
-		q->rate_bps =3D nla_get_u64(tb[TCA_CAKE_BASE_RATE64]);
+		WRITE_ONCE(q->rate_bps,
+			   nla_get_u64(tb[TCA_CAKE_BASE_RATE64]));
=20
 	if (tb[TCA_CAKE_DIFFSERV_MODE])
-		q->tin_mode =3D nla_get_u32(tb[TCA_CAKE_DIFFSERV_MODE]);
+		WRITE_ONCE(q->tin_mode,
+			   nla_get_u32(tb[TCA_CAKE_DIFFSERV_MODE]));
=20
+	rate_flags =3D q->rate_flags;
 	if (tb[TCA_CAKE_WASH]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_WASH]))
-			q->rate_flags |=3D CAKE_FLAG_WASH;
+			rate_flags |=3D CAKE_FLAG_WASH;
 		else
-			q->rate_flags &=3D ~CAKE_FLAG_WASH;
+			rate_flags &=3D ~CAKE_FLAG_WASH;
 	}
=20
 	if (tb[TCA_CAKE_FLOW_MODE])
-		q->flow_mode =3D ((q->flow_mode & CAKE_FLOW_NAT_FLAG) |
+		flow_mode =3D ((flow_mode & CAKE_FLOW_NAT_FLAG) |
 				(nla_get_u32(tb[TCA_CAKE_FLOW_MODE]) &
 					CAKE_FLOW_MASK));
=20
 	if (tb[TCA_CAKE_ATM])
-		q->atm_mode =3D nla_get_u32(tb[TCA_CAKE_ATM]);
+		WRITE_ONCE(q->atm_mode,
+			   nla_get_u32(tb[TCA_CAKE_ATM]));
=20
 	if (tb[TCA_CAKE_OVERHEAD]) {
-		q->rate_overhead =3D nla_get_s32(tb[TCA_CAKE_OVERHEAD]);
-		q->rate_flags |=3D CAKE_FLAG_OVERHEAD;
+		WRITE_ONCE(q->rate_overhead,
+			   nla_get_s32(tb[TCA_CAKE_OVERHEAD]));
+		rate_flags |=3D CAKE_FLAG_OVERHEAD;
=20
 		q->max_netlen =3D 0;
 		q->max_adjlen =3D 0;
@@ -2623,7 +2631,7 @@ static int cake_change(struct Qdisc *sch, struct nlat=
tr *opt,
 	}
=20
 	if (tb[TCA_CAKE_RAW]) {
-		q->rate_flags &=3D ~CAKE_FLAG_OVERHEAD;
+		rate_flags &=3D ~CAKE_FLAG_OVERHEAD;
=20
 		q->max_netlen =3D 0;
 		q->max_adjlen =3D 0;
@@ -2632,54 +2640,58 @@ static int cake_change(struct Qdisc *sch, struct nl=
attr *opt,
 	}
=20
 	if (tb[TCA_CAKE_MPU])
-		q->rate_mpu =3D nla_get_u32(tb[TCA_CAKE_MPU]);
+		WRITE_ONCE(q->rate_mpu,
+			   nla_get_u32(tb[TCA_CAKE_MPU]));
=20
 	if (tb[TCA_CAKE_RTT]) {
-		q->interval =3D nla_get_u32(tb[TCA_CAKE_RTT]);
+		u32 interval =3D nla_get_u32(tb[TCA_CAKE_RTT]);
=20
-		if (!q->interval)
-			q->interval =3D 1;
+		WRITE_ONCE(q->interval, max(interval, 1U));
 	}
=20
 	if (tb[TCA_CAKE_TARGET]) {
-		q->target =3D nla_get_u32(tb[TCA_CAKE_TARGET]);
+		u32 target =3D nla_get_u32(tb[TCA_CAKE_TARGET]);
=20
-		if (!q->target)
-			q->target =3D 1;
+		WRITE_ONCE(q->target, max(target, 1U));
 	}
=20
 	if (tb[TCA_CAKE_AUTORATE]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE]))
-			q->rate_flags |=3D CAKE_FLAG_AUTORATE_INGRESS;
+			rate_flags |=3D CAKE_FLAG_AUTORATE_INGRESS;
 		else
-			q->rate_flags &=3D ~CAKE_FLAG_AUTORATE_INGRESS;
+			rate_flags &=3D ~CAKE_FLAG_AUTORATE_INGRESS;
 	}
=20
 	if (tb[TCA_CAKE_INGRESS]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_INGRESS]))
-			q->rate_flags |=3D CAKE_FLAG_INGRESS;
+			rate_flags |=3D CAKE_FLAG_INGRESS;
 		else
-			q->rate_flags &=3D ~CAKE_FLAG_INGRESS;
+			rate_flags &=3D ~CAKE_FLAG_INGRESS;
 	}
=20
 	if (tb[TCA_CAKE_ACK_FILTER])
-		q->ack_filter =3D nla_get_u32(tb[TCA_CAKE_ACK_FILTER]);
+		WRITE_ONCE(q->ack_filter,
+			   nla_get_u32(tb[TCA_CAKE_ACK_FILTER]));
=20
 	if (tb[TCA_CAKE_MEMORY])
-		q->buffer_config_limit =3D nla_get_u32(tb[TCA_CAKE_MEMORY]);
+		WRITE_ONCE(q->buffer_config_limit,
+			   nla_get_u32(tb[TCA_CAKE_MEMORY]));
=20
 	if (tb[TCA_CAKE_SPLIT_GSO]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_SPLIT_GSO]))
-			q->rate_flags |=3D CAKE_FLAG_SPLIT_GSO;
+			rate_flags |=3D CAKE_FLAG_SPLIT_GSO;
 		else
-			q->rate_flags &=3D ~CAKE_FLAG_SPLIT_GSO;
+			rate_flags &=3D ~CAKE_FLAG_SPLIT_GSO;
 	}
=20
 	if (tb[TCA_CAKE_FWMARK]) {
-		q->fwmark_mask =3D nla_get_u32(tb[TCA_CAKE_FWMARK]);
-		q->fwmark_shft =3D q->fwmark_mask ? __ffs(q->fwmark_mask) : 0;
+		WRITE_ONCE(q->fwmark_mask, nla_get_u32(tb[TCA_CAKE_FWMARK]));
+		WRITE_ONCE(q->fwmark_shft,
+			   q->fwmark_mask ? __ffs(q->fwmark_mask) : 0);
 	}
=20
+	WRITE_ONCE(q->rate_flags, rate_flags);
+	WRITE_ONCE(q->flow_mode, flow_mode);
 	if (q->tins) {
 		sch_tree_lock(sch);
 		cake_reconfigure(sch);
@@ -2774,68 +2786,72 @@ static int cake_dump(struct Qdisc *sch, struct sk_b=
uff *skb)
 {
 	struct cake_sched_data *q =3D qdisc_priv(sch);
 	struct nlattr *opts;
+	u16 rate_flags;
+	u8 flow_mode;
=20
 	opts =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (!opts)
 		goto nla_put_failure;
=20
-	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64, q->rate_bps,
-			      TCA_CAKE_PAD))
+	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
+			      READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE,
-			q->flow_mode & CAKE_FLOW_MASK))
+	flow_mode =3D READ_ONCE(q->flow_mode);
+	if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE, flow_mode & CAKE_FLOW_MASK))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_RTT, q->interval))
+	if (nla_put_u32(skb, TCA_CAKE_RTT, READ_ONCE(q->interval)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_TARGET, q->target))
+	if (nla_put_u32(skb, TCA_CAKE_TARGET, READ_ONCE(q->target)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_MEMORY, q->buffer_config_limit))
+	if (nla_put_u32(skb, TCA_CAKE_MEMORY,
+			READ_ONCE(q->buffer_config_limit)))
 		goto nla_put_failure;
=20
+	rate_flags =3D READ_ONCE(q->rate_flags);
 	if (nla_put_u32(skb, TCA_CAKE_AUTORATE,
-			!!(q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
+			!!(rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
 		goto nla_put_failure;
=20
 	if (nla_put_u32(skb, TCA_CAKE_INGRESS,
-			!!(q->rate_flags & CAKE_FLAG_INGRESS)))
+			!!(rate_flags & CAKE_FLAG_INGRESS)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, q->ack_filter))
+	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, READ_ONCE(q->ack_filter)))
 		goto nla_put_failure;
=20
 	if (nla_put_u32(skb, TCA_CAKE_NAT,
-			!!(q->flow_mode & CAKE_FLOW_NAT_FLAG)))
+			!!(flow_mode & CAKE_FLOW_NAT_FLAG)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_DIFFSERV_MODE, q->tin_mode))
+	if (nla_put_u32(skb, TCA_CAKE_DIFFSERV_MODE, READ_ONCE(q->tin_mode)))
 		goto nla_put_failure;
=20
 	if (nla_put_u32(skb, TCA_CAKE_WASH,
-			!!(q->rate_flags & CAKE_FLAG_WASH)))
+			!!(rate_flags & CAKE_FLAG_WASH)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_OVERHEAD, q->rate_overhead))
+	if (nla_put_u32(skb, TCA_CAKE_OVERHEAD, READ_ONCE(q->rate_overhead)))
 		goto nla_put_failure;
=20
-	if (!(q->rate_flags & CAKE_FLAG_OVERHEAD))
+	if (!(rate_flags & CAKE_FLAG_OVERHEAD))
 		if (nla_put_u32(skb, TCA_CAKE_RAW, 0))
 			goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_ATM, q->atm_mode))
+	if (nla_put_u32(skb, TCA_CAKE_ATM, READ_ONCE(q->atm_mode)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_MPU, q->rate_mpu))
+	if (nla_put_u32(skb, TCA_CAKE_MPU, READ_ONCE(q->rate_mpu)))
 		goto nla_put_failure;
=20
 	if (nla_put_u32(skb, TCA_CAKE_SPLIT_GSO,
-			!!(q->rate_flags & CAKE_FLAG_SPLIT_GSO)))
+			!!(rate_flags & CAKE_FLAG_SPLIT_GSO)))
 		goto nla_put_failure;
=20
-	if (nla_put_u32(skb, TCA_CAKE_FWMARK, q->fwmark_mask))
+	if (nla_put_u32(skb, TCA_CAKE_FWMARK, READ_ONCE(q->fwmark_mask)))
 		goto nla_put_failure;
=20
 	return nla_nest_end(skb, opts);
--=20
2.44.0.683.g7961c838ac-goog


