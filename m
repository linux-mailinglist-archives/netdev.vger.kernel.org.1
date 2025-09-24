Return-Path: <netdev+bounces-225952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B88B99CD8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F504A42E9
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74A2E54DB;
	Wed, 24 Sep 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C57G4g/K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0A14EC46
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716321; cv=none; b=fgJsIe+94PZgK1sHpXeSZQ0OBXW20e1XDhlRhWtFXUoRPgOwMNsjo9FOQYVfJd9yLOaMf83rlqsFctAzgA36y5+1IExRRHE5J27ON/PjznlMiCYqD/9M3qSNlFMA+xz/KYYNsJaqTGhJE2kgQDXMUwZrXbbfL9e75kzxRcAlnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716321; c=relaxed/simple;
	bh=XWkVIYtKWgIynvC2NXIYEZbYB+dWICINZ1f0K+Pxz1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdT+qH5uZyz/yRNhSpkcMWJV3i7llkFv1A6yMHc50wKhqTazl6vkTnoytGmEhGJ/KiHFiAeZYm5HSVCR87/0m6tm+KkEpW0SqJuDw3HrAxPKRZe63jqtNDvMaZ61J6HKeDrHJVj183i6QszHg4H4vj9OeIE6covVXqZDK3uLBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C57G4g/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+E/emif6LBt/7nt68sW5WJ36jrr3DK5g4rTA83tY2Uk=;
	b=C57G4g/KElWsPKt/jLdBHDzTty48Wlkx5+1bVtzUpYJZTLwI/qiwixZ9O61iuqMiov3j/P
	6H1bXJ6w/aCULSJNHXmd+RospFbaQODM0l4YMY3RNiCOo3R+BmlBRErJGiqQpgoV0+laCH
	Uv0qzePNjbZthvIIJ0QgPVifUtf1DwA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-6RoWAmIENPaJRN9YRo9DRg-1; Wed, 24 Sep 2025 08:18:37 -0400
X-MC-Unique: 6RoWAmIENPaJRN9YRo9DRg-1
X-Mimecast-MFC-AGG-ID: 6RoWAmIENPaJRN9YRo9DRg_1758716316
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-633ba385714so3489073a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716316; x=1759321116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E/emif6LBt/7nt68sW5WJ36jrr3DK5g4rTA83tY2Uk=;
        b=jqFBI/ITqwFsfyt5W+O/uVzDhFDZxWLpAh0/VVOm8VVDLhjaOxCrqXRj/3OZuyHgL8
         HF4hGh7bZ5kzsvqqmuFcqIElHrz97CB3/zj7zvcQ33rAq+Le0DpcB2wBqta78WhoiYYJ
         WK3TUR8EpsjNvEHKBMWYsVOe8+zswrmxLgPNoQ5A3HcfMwNG2ZA1E3cSwZ0lCBLw/uz0
         FwReomxSBt02b9tBXnajbUYfWAgI3VJdrb73eUQvuBByEfGQQG7ejj/Du0lnLEN4wB7Q
         B7b0Vqaxyuwktm+M7fu7iMcLz3nrSTgAsdAEC5FIMXSHKw3OyEEBhb8KXvWugyHLm9ji
         faYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6UWYJTTWXIK+AC3Hav8mdZN/QzVQukfyPb20r8ZlKvep5CAb+/gdubxrfAes5jCJNh51i/YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjrKnO7lo2Boh1WrknAssfVNqcZwOCUiUzziFlCQpM1lGV+vm
	27RrBD9ZOpALPLkbWmwWY9kbx7vAtn2nWYgl6q0cSHC5YZlwu4fm0Y8MGyed9A8Qw4lQB8+SZ8v
	613OBXdV+GpA1psUXu8jAdVw6FBvwpWJ0jnRcT4NLieihUktuCb4WELcP+A==
X-Gm-Gg: ASbGncs4N2ONYqC8mGAFyuaQ4VexYHFdcKgzmV9amiuI67u8s0nrhN5GponIOp789RE
	hcFd+RgUhaBop9q05zkVB/IZiXj+XdWJtFWkGdDgu+ad4BtH3XAVpo+WkfcG1rSpRwIZ6+WUwfy
	Z+7eR/t1cRVVSp/l9K+9/sWdibx/Q9fKJf1tNfw7O0l/vGYMg72CVQLcW9ZRLMdvk4+foqUpnSJ
	Z1IxECb4Nx9behAyOF/CK2DxvOf2LvAX1bG3adpKUfZh3bc5qZC3M6hr4HMr3/9nu7pRYqM/usj
	EdjUPTGbdG0q6Nrv8uQge8tRMRM+agL3x9fyknFdYJuoUC4vmUTYHL9CYZUJxcOjp1A=
X-Received: by 2002:a05:6402:358a:b0:633:deec:8b57 with SMTP id 4fb4d7f45d1cf-634677be071mr5879414a12.16.1758716315962;
        Wed, 24 Sep 2025 05:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9E5NPPn5EyU+BGrVw4iPAGkdvSO24PBm+IoydDS+ahtddb431NOHsnjoUrbXa+52CMhmaeA==
X-Received: by 2002:a05:6402:358a:b0:633:deec:8b57 with SMTP id 4fb4d7f45d1cf-634677be071mr5879385a12.16.1758716315494;
        Wed, 24 Sep 2025 05:18:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fadb1ee79sm12367114a12.33.2025.09.24.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:18:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 16535276E30; Wed, 24 Sep 2025 14:18:34 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Subject: [PATCH RFC net-next] tc: cake: add cake_mq support
Date: Wed, 24 Sep 2025 14:18:20 +0200
Message-ID: <20250924121820.186373-1-toke@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
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
 include/uapi/linux/pkt_sched.h |  2 ++
 tc/q_cake.c                    | 37 +++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 15d1a37ac6d8..f85a5316f372 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1014,6 +1014,7 @@ enum {
 	TCA_CAKE_ACK_FILTER,
 	TCA_CAKE_SPLIT_GSO,
 	TCA_CAKE_FWMARK,
+	TCA_CAKE_SYNC_TIME,
 	__TCA_CAKE_MAX
 };
 #define TCA_CAKE_MAX	(__TCA_CAKE_MAX - 1)
@@ -1036,6 +1037,7 @@ enum {
 	TCA_CAKE_STATS_DROP_NEXT_US,
 	TCA_CAKE_STATS_P_DROP,
 	TCA_CAKE_STATS_BLUE_TIMER_US,
+	TCA_CAKE_STATS_ACTIVE_QUEUES,
 	__TCA_CAKE_STATS_MAX
 };
 #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
diff --git a/tc/q_cake.c b/tc/q_cake.c
index e2b8de55e5a2..60688b3478ec 100644
--- a/tc/q_cake.c
+++ b/tc/q_cake.c
@@ -82,6 +82,7 @@ static void explain(void)
 		"                [ split-gso* | no-split-gso ]\n"
 		"                [ ack-filter | ack-filter-aggressive | no-ack-filter* ]\n"
 		"                [ memlimit LIMIT ]\n"
+		"                [ sync_time TIME ]\n"
 		"                [ fwmark MASK ]\n"
 		"                [ ptm | atm | noatm* ] [ overhead N | conservative | raw* ]\n"
 		"                [ mpu N ] [ ingress | egress* ]\n"
@@ -93,6 +94,8 @@ static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 {
 	struct cake_preset *preset, *preset_set = NULL;
 	bool overhead_override = false;
+	unsigned int sync_time = 0;
+	bool set_sync_time = false;
 	bool overhead_set = false;
 	unsigned int interval = 0;
 	int diffserv = -1;
@@ -340,6 +343,13 @@ static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 					"Illegal value for \"fwmark\": \"%s\"\n", *argv);
 				return -1;
 			}
+		} else if (strcmp(*argv, "sync_time") == 0) {
+			NEXT_ARG();
+			if (get_time(&sync_time, *argv)) {
+				fprintf(stderr, "Illegal sync time\n");
+				return -1;
+			}
+			set_sync_time = true;
 		} else if (strcmp(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -399,6 +409,8 @@ static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	if (ack_filter != -1)
 		addattr_l(n, 1024, TCA_CAKE_ACK_FILTER, &ack_filter,
 			  sizeof(ack_filter));
+	if(set_sync_time)
+		addattr_l(n, 1024, TCA_CAKE_SYNC_TIME, &sync_time, sizeof(sync_time));
 
 	tail->rta_len = (void *) NLMSG_TAIL(n) - (void *) tail;
 	return 0;
@@ -421,6 +433,7 @@ static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *o
 	unsigned int interval = 0;
 	unsigned int memlimit = 0;
 	unsigned int fwmark = 0;
+	unsigned int sync_time = 0;
 	__u64 bandwidth = 0;
 	int ack_filter = 0;
 	int split_gso = 0;
@@ -525,7 +538,10 @@ static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *o
 	    RTA_PAYLOAD(tb[TCA_CAKE_FWMARK]) >= sizeof(__u32)) {
 		fwmark = rta_getattr_u32(tb[TCA_CAKE_FWMARK]);
 	}
-
+	if (tb[TCA_CAKE_SYNC_TIME] &&
+	    RTA_PAYLOAD(tb[TCA_CAKE_SYNC_TIME]) >= sizeof(__u32)) {
+		sync_time = rta_getattr_u32(tb[TCA_CAKE_SYNC_TIME]);
+	}
 	if (wash)
 		print_string(PRINT_FP, NULL, "wash ", NULL);
 	else
@@ -574,6 +590,13 @@ static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *o
 	if (memlimit)
 		print_size(PRINT_ANY, "memlimit", "memlimit %s ", memlimit);
 
+	if (sync_time) {
+		print_uint(PRINT_JSON, "sync_time", NULL,
+			   sync_time);
+		print_string(PRINT_FP, NULL, "sync_time %s",
+			     sprint_time(sync_time, b2));
+	}
+
 	if (fwmark)
 		print_uint(PRINT_FP, NULL, "fwmark 0x%x ", fwmark);
 	print_0xhex(PRINT_JSON, "fwmark", NULL, fwmark);
@@ -667,6 +690,11 @@ static int cake_print_xstats(const struct qdisc_util *qu, FILE *f,
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
@@ -827,3 +855,10 @@ struct qdisc_util cake_qdisc_util = {
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
2.51.0


