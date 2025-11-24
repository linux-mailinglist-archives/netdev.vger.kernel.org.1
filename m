Return-Path: <netdev+bounces-241195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3BC81390
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35B764E1D98
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B7295DBD;
	Mon, 24 Nov 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFPuXulq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4nmnAaH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0222877E3
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996642; cv=none; b=TQLAvxNvhDGP611MFDffxXJCCvlICxq2rOYY+NiHKsmFF+VDjDILn+L6oPvHx4AP8vi43RT7nSpQFw3xbM6s0Lb81Is7L74ItqEueeARNyrL8Q/0bNhklvaj+OCQMWZWEiwQ6IbNGzj6NPsa+G55LsNYHkXVwUHeRg/EnUSZcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996642; c=relaxed/simple;
	bh=0SjpOS6knSSZJRdCIy573FWRZIzMChfxGhyRT0aiw+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e82O8VoJqZoYzj7CTdu6V5/H1AsOHtTyNAGg18wtHemTK35HzDXa09khNzJH3fIqB8etaUdzeCx2y5P6TGVJhUAb+BOlkY+huuXiN4Ugp+Z/ZKdutJz9uvLczL7+d9sBIE4iivvdGuSZ60nhTZGiIE8vKFact9enLTRte9NNCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFPuXulq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4nmnAaH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763996640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fab3ghcqMPmabLPn/2RxPN0f5b6T/WzY219cWGaIJhI=;
	b=DFPuXulq4Y06vE9VxMqi/CvCvP3ykkE/OAZruwo1tqpJzxKjKNtZwbL9sTGbfbw+n6KGK0
	XGT7HHJvb5vxVwCwGsPCrLcTqzkeIbuOwkeGcNMzwGaNnjY4VfxxWqviTHZdVoKQWRBN1F
	7xteQYJkPwM+JM9aOcwYuE08Pj1Ajww=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-yIJ5mMgoM6uy5oEbxSxrlQ-1; Mon, 24 Nov 2025 10:03:57 -0500
X-MC-Unique: yIJ5mMgoM6uy5oEbxSxrlQ-1
X-Mimecast-MFC-AGG-ID: yIJ5mMgoM6uy5oEbxSxrlQ_1763996635
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b763b24f223so232459966b.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763996635; x=1764601435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fab3ghcqMPmabLPn/2RxPN0f5b6T/WzY219cWGaIJhI=;
        b=s4nmnAaHXKF4wrRfyN7tgb6Tfy9O+LJIXurmdwhEMIMZz0un8NVwtGx3ZXbMzMF6sS
         kigaLP9DLLL9QECtGILhv9Y4BceLXTCzRbX+VNvg7s2B9h8IWYIDCbI23w20IxY3tH2p
         DLmzgylYenfmWPDwkzMWm4fXfO4lPnqyWnZt5qKcxDJI8ItlHdguDpMtqpF0+7TDn5Os
         AYVbQHt3K2zga5lJilp8PTm0kQYY6filE0iql9kjGWSFOfLgJkRD/lcX3CJV5KxZb98g
         lhWKPhosUdnwa4FmBqBrbOHG4+pkdPlECb0tPY3Godda9Gpn6exf/+5OgItqrB63Tb3Q
         pJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996635; x=1764601435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fab3ghcqMPmabLPn/2RxPN0f5b6T/WzY219cWGaIJhI=;
        b=SglYAmouQuu6nrgQIi9MsStLQ0DkmFGtN3Uu8HrcF56upJJe9d3eos+PseBcm9zlWo
         RKFRs5zXLH+j+etaTPrlyRNDM0foX+elbhgNrKBCjQNGWHgr4vmMKrJJYAJMIqwX4Dp4
         p3BzmzSFWnji/PiCDmAnl0iKxUDzFcBjqJ9K5laxKUCEWuJ7Rr5MozbU+xm62ZxXKmWR
         QD/mweyci2iNTXD2VtxqOpqcmG4PApPMTrVeEaDvdRkPvL65Z8pfDXx35kyz8mPXqEMK
         8KE57FubUJ8LimeldcdlsUWN2HVJ/aLJgwM1dE8yaFTOakZFlYZMuycvuqrdJkfbJIAt
         uxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN5oQYoMTv/32CRz0DgObMeGKyn5xbFZ3rtlYZ920ihsG/xqWN9Vrqz25/pG6TiLpaAN+piGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8vSMXoZ6gLcpJaOMh3oOTLdvDgRwW0SHsbsJHw9yyZebJ6SO
	CaXGS/bV6pTtiJFKP/0kheobdvptLm0o352Y43orWostQSZvCtD90YjugMGjVzEiubaf5VHhc0Q
	3mdcYDls3bUQxzkrsnKewKoJHb2f+X5oVBMYSlliOQsV/NNiMulL6iM0/2Q==
X-Gm-Gg: ASbGncsBuRWD9+mTuIX9j5o/gDovEcd05/jZ1+9xRZ6Ku0nmoIeoGsjfruZsq/rm5Ew
	bnA6rBjtVtfMMoR4awOe3rBZ0R0fm4PSy8wHRqApjkbmOWBtfc7ry3JvtfGVFkXJ5foAJoH9vrF
	qs+9cFnlj4FqEHnOTcDgek4cIQpXYao2KdlK13UC3SJL0dGsM//IDywatrPjx7rMUt0hiGRSb2C
	x8e1CZEhb4v9tHoYGKG5DubMsNz7TdsiIrS+AKRl53iMVK5a4EHHPxM9u0K0qNvY6woZuNnVoVz
	kaYVoUgSAoMZUadJP4QLQnJcM1/dc3ka+E3NK4FSD4kqig9ZlcQ4/0S7+sFjoC1iDuUpoDEvlzV
	YhTEin2WE6B9Xt1NagX+xiyCqa6UbZL1kHA==
X-Received: by 2002:a17:907:c1a:b0:b73:9937:e96b with SMTP id a640c23a62f3a-b7671891d69mr1336702466b.52.1763996635116;
        Mon, 24 Nov 2025 07:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7AoO5zFiHMXS9tyTRQTlOiu0XJMrWIaRCrzfV15suEJEy0uyvFxhhi7/1+AhlinnnFGLzHg==
X-Received: by 2002:a17:907:c1a:b0:b73:9937:e96b with SMTP id a640c23a62f3a-b7671891d69mr1336698466b.52.1763996634698;
        Mon, 24 Nov 2025 07:03:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3fc0sm1337659966b.46.2025.11.24.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:03:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7FB4632A807; Mon, 24 Nov 2025 16:03:53 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Subject: [PATCH iproute2-next] tc: cake: add cake_mq support
Date: Mon, 24 Nov 2025 16:03:50 +0100
Message-ID: <20251124150350.492522-1-toke@redhat.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

This adds support for the cake_mq variant of sch_cake to tc.

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 include/uapi/linux/pkt_sched.h |  1 +
 tc/q_cake.c                    | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 15d1a37ac6d8..fb07a8898225 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1036,6 +1036,7 @@ enum {
 	TCA_CAKE_STATS_DROP_NEXT_US,
 	TCA_CAKE_STATS_P_DROP,
 	TCA_CAKE_STATS_BLUE_TIMER_US,
+	TCA_CAKE_STATS_ACTIVE_QUEUES,
 	__TCA_CAKE_STATS_MAX
 };
 #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
diff --git a/tc/q_cake.c b/tc/q_cake.c
index e2b8de55e5a2..1c143e766888 100644
--- a/tc/q_cake.c
+++ b/tc/q_cake.c
@@ -525,7 +525,6 @@ static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *o
 	    RTA_PAYLOAD(tb[TCA_CAKE_FWMARK]) >= sizeof(__u32)) {
 		fwmark = rta_getattr_u32(tb[TCA_CAKE_FWMARK]);
 	}
-
 	if (wash)
 		print_string(PRINT_FP, NULL, "wash ", NULL);
 	else
@@ -667,6 +666,11 @@ static int cake_print_xstats(const struct qdisc_util *qu, FILE *f,
 			   " /%8u\n", GET_STAT_U32(MAX_ADJLEN));
 	}
 
+	if (st[TCA_CAKE_STATS_ACTIVE_QUEUES])
+		print_uint(PRINT_ANY, "active_queues",
+			   " active queues: %25u\n",
+			   GET_STAT_U32(ACTIVE_QUEUES));
+
 	if (st[TCA_CAKE_STATS_AVG_NETOFF])
 		print_uint(PRINT_ANY, "avg_hdr_offset",
 			   " average network hdr offset: %12u\n\n",
@@ -827,3 +831,10 @@ struct qdisc_util cake_qdisc_util = {
 	.print_qopt	= cake_print_opt,
 	.print_xstats	= cake_print_xstats,
 };
+
+struct qdisc_util cake_mq_qdisc_util = {
+	.id		= "cake_mq",
+	.parse_qopt	= cake_parse_opt,
+	.print_qopt	= cake_print_opt,
+	.print_xstats	= cake_print_xstats,
+};
-- 
2.51.2


