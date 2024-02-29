Return-Path: <netdev+bounces-76020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BC86BFEB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25CA1F2225D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3159383A3;
	Thu, 29 Feb 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TOZCjyNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5E13D303
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181507; cv=none; b=GaDlPBrMxW5grniupEOA4wVdvNI6CCwOsuniB1/vKS5wHrcXMR1iiiY4EqfqNjZxayqq0BueCcM5vnFjWZ/yQqZ2U05nnUIPPAL5OgG1pEU8QkgeKSPPSQaFzauflZdUOjSKX7J9Jf1BmMVqnhA9Swx/3mxpsIK237QSH5sXi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181507; c=relaxed/simple;
	bh=kX6iXYF5mitTFlDYEEF3tGm9VXgEmsErsXCI35GJCWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZuth+KssdvhwUa8bTNj/QagdDl4eRDx5vYFibOVMaVLlui/kv6LmlGtgzkRyl+IKp55IP7gr6INUCcFkybbLRucKlKm5lUb68ds/hhmHPxQnEAL+CRW/zxzSDgOme9fAzJChLTJG60SyQLI8ny09KSFswU8WxQTbQSmBrngCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TOZCjyNJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so299192b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 20:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709181505; x=1709786305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lib4owO/rKSDQG3XQkteGV2m2ztu5hv4XkAZX8rpGBc=;
        b=TOZCjyNJ7r6uG6Ib6rKwNmzvWDMeMBuFCmxstce678lnzQTNsQRdhd3YOCypXZxvrL
         R85keUnznylPn59CcCpjuyguJsRQlQPqop+iVWqvftMa6OW312/+DVXDNaMTx3Qj4mIG
         k0qRg8Z5WKH2PCJQ5nCpKzaJjOXF3WLhulzvO/LzGJACpXR7XJ5SKymKBm7rJPLHXbml
         STSQY0rSWXoEyWgfctJCGoEJaj2ROPxY+RvnIGg8yrA0rWSy7b5y88Ka2JUvNS9BAcC/
         sCBeKLp7Mjoj+7sA9pMnktPp60XSwpGuA/vQAreogzZQwD7lgPEGIef7MUOd4hL6Rc/o
         2BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709181505; x=1709786305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lib4owO/rKSDQG3XQkteGV2m2ztu5hv4XkAZX8rpGBc=;
        b=L6ofWSMU9ZAHtKo1SwQwNWvpmDAmOC0ST2nKnAywiUAyJ01Gct5KlHpKq4bLwcnC3l
         so2EwiUuZVkCEx7dvL7+vEa2ZfiXtmUpm+l/FYHI8siYpGDrgHB5zpU3SqDMo8PAO6ry
         6yWB7+jEiPNHYfckNor+6Qyxdv716NhA8+p3b6/KNMVTF3c5frCKw0KpKSrD+vodqMka
         poXe8LVLDIdYjA/zijo4sNzh2l/H6dQdqgy0l2iEj+u4E2Be9hCZtWC+TEDCmoIScWwz
         /eme+RV6MqT7gaNoCgxZ1a5RF3EAnvb3612TSrZoXhuFQA8vRQiaIxc2rzOeEodBZRR9
         P1mw==
X-Gm-Message-State: AOJu0YwhKez66R819Du1bwj+WUYZJKTXA758zzWFmc9n5oj3miOvW5Yi
	QFI6nW9MSwqzkx7tPePW87x5x4SBCItEXrBZ+qVUmhyA7qhkj6x45ODfOipmZZQp5UPsU9d+4UD
	w
X-Google-Smtp-Source: AGHT+IEoOWsn56/dc3xSaE2GagC3aht8pm6Ot8l94s/JEOkHAc/8WZo1FXQFXENAQozNK5DWiug/yA==
X-Received: by 2002:a05:6a00:234a:b0:6e5:96de:d659 with SMTP id j10-20020a056a00234a00b006e596ded659mr244364pfj.28.1709181504889;
        Wed, 28 Feb 2024 20:38:24 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z30-20020aa79e5e000000b006e4c100a381sm269932pfq.176.2024.02.28.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 20:38:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ifstat: support 64 interface stats
Date: Wed, 28 Feb 2024 20:37:28 -0800
Message-ID: <20240229043813.197892-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 32 bit statistics are problematic since 32 bit value can
easily wraparound at high speed. Use 64 bit stats if available.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ifstat.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 18171a2ca5d5..caa4a07f62a9 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -51,7 +51,7 @@ int sub_type;
 char info_source[128];
 int source_mismatch;
 
-#define MAXS (sizeof(struct rtnl_link_stats)/sizeof(__u32))
+#define MAXS (sizeof(struct rtnl_link_stats64)/sizeof(__u64))
 #define NO_SUB_TYPE 0xffff
 
 struct ifstat_ent {
@@ -60,7 +60,7 @@ struct ifstat_ent {
 	int			ifindex;
 	unsigned long long	val[MAXS];
 	double			rate[MAXS];
-	__u32			ival[MAXS];
+	__u64			ival[MAXS];
 };
 
 static const char *stats[MAXS] = {
@@ -74,19 +74,25 @@ static const char *stats[MAXS] = {
 	"tx_dropped",
 	"multicast",
 	"collisions",
+
 	"rx_length_errors",
 	"rx_over_errors",
 	"rx_crc_errors",
 	"rx_frame_errors",
 	"rx_fifo_errors",
 	"rx_missed_errors",
+
 	"tx_aborted_errors",
 	"tx_carrier_errors",
 	"tx_fifo_errors",
 	"tx_heartbeat_errors",
 	"tx_window_errors",
+
 	"rx_compressed",
-	"tx_compressed"
+	"tx_compressed",
+	"rx_nohandler",
+
+	"rx_otherhost_dropped",
 };
 
 struct ifstat_ent *kern_db;
@@ -174,7 +180,7 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 		return 0;
 
 	parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
-	if (tb[IFLA_IFNAME] == NULL || tb[IFLA_STATS] == NULL)
+	if (tb[IFLA_IFNAME] == NULL)
 		return 0;
 
 	n = malloc(sizeof(*n));
@@ -182,10 +188,31 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 		errno = ENOMEM;
 		return -1;
 	}
+
 	n->ifindex = ifi->ifi_index;
 	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
-	memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS]), sizeof(n->ival));
+	if (!n->name) {
+		free(n);
+		errno = ENOMEM;
+		return -1;
+	}
+		
 	memset(&n->rate, 0, sizeof(n->rate));
+
+	if (tb[IFLA_STATS64]) {
+		memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS64]), sizeof(n->ival));
+	} else if (tb[IFLA_STATS]) {
+		__u32 *stats = RTA_DATA(tb[IFLA_STATS]);
+
+		/* expand 32 bit values to 64 bit */
+		for (i = 0; i < MAXS; i++)
+			n->ival[i] = stats[i];
+	} else {
+		/* missing stats? */
+		free(n);
+		return 0;
+	}
+
 	for (i = 0; i < MAXS; i++)
 		n->val[i] = n->ival[i];
 	n->next = kern_db;
-- 
2.43.0


