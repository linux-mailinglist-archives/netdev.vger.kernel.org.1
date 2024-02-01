Return-Path: <netdev+bounces-67806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE3844FE8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2941C22F1C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132C3B193;
	Thu,  1 Feb 2024 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fwze6OxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53183B182
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759227; cv=none; b=iQyVKNZAf7TVAy64KivYAUEnP4D0h0iasn3KCfbtswitc+EDOmdlpwyKDNSxJ1CgexIF0zY8Jul3yELbo4oQqfLcFrg9CHGY5/ejZrehGmdCRc4nnKXA1LTicwKxgxbe1CA55in8Dj7Pf4nKwSDA0YJkeKSOExy5WBCf2QxKJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759227; c=relaxed/simple;
	bh=AoFfherpr4to1DIFIPcKXhBrv/xGkl6LTDUKV7Q0gSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDTFL+R1KJUI9VWJjE6tPBJg7uK3Xv6EZ0WWZYw3jLS0evs4Ggzz+aLdmys8K7UTLwzQVEQ8Y0rWiYPX5fxWXfRGwgvUcgmJMXwRHvmRkusgss9b2eASMiwKmmSqhI0N1NO4bwMzIHCAL2/esNrT+MVmQXGYqX4yR7quahw3J7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fwze6OxM; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3be3753e002so263696b6e.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706759224; x=1707364024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8f/1/rAwFZ7NJWpi1dKByH+ArzJcXZ3FPX29zy2S4w=;
        b=fwze6OxMUYE6mvhCJ8TuxY9ceJflK9XkH/oKT5t6Fi7wNI87zUHBJ2gfYwhH2LiIGM
         lZeZ6CyTKe6bAObqbmurqQA0Joe8vSUsEvnuVlWiymGPAAdd8kyt8c0jKYeekf9vQk56
         X+Hjg9LjNUr4g17RA8jGK6kLb0vw011+7SssGIbRh7majV0r6u3xrsO5Bh7W4F+DJ3PT
         fgvBUdLjwjeaWZzPMJx/N5+JO0AFFatxG4jL1oeLRXorFBZYxcAfUKyZu+tmv729kb6L
         pcBZRc1OSd8dsdrow/WMI+AhfOaegGtUqtW0X/lrRfv6VMzT0NO1ZEvhBQVDlW+okJv8
         28cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759224; x=1707364024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8f/1/rAwFZ7NJWpi1dKByH+ArzJcXZ3FPX29zy2S4w=;
        b=a7OrXwgyAW/8hJ/HYUfjsZIHKBVhwm1kkwGylWy1N9rj+RYqr2+r9ukl4MtwKmk/bS
         qvIIZvzk36SKJDZesGNj5dZ2Vsf1mec9dNdZ3ZiVy6AdsNJge5E63zSRxCrml2scPecD
         o7v+HHbZ1nIV0ERduqDlvrAWGv5xATcJk/6CjOKjV/9rkqRE7Tpozgc3L3p/EQbpmkzS
         Y+V37HyZKAzc5PARYU0QoRWQ7EQPgijSebZawJCf6+XseOvWGxbfgDD3ZwtXX0CohEaF
         UsvWoBTykQZCdYLidTar0Lg4qnu6TYYfHBo4SSgzsRODBHiVw7k8orBlanb418Ys5KBV
         HI6A==
X-Gm-Message-State: AOJu0YzIoHTnGY8A+z75zwNQQrEU4hN2ffn9SOzhaQ4pZuaAUh8okXNH
	tkwJY0Ssu8sABJ0F+/giWFAD+SPmD3jXp+1EgGLL2El4ZalcinSFwpnRA0HHzNZTAQ2YxaGCSmT
	O1yc=
X-Google-Smtp-Source: AGHT+IHvzaQmRyiXOTUnq6jVhAf3wm4u08KLbGSwDYVzpD6OjN0xDa+9CqzkMpH4GJ465o1rf6K70Q==
X-Received: by 2002:a05:6808:16aa:b0:3bd:a8a3:7237 with SMTP id bb42-20020a05680816aa00b003bda8a37237mr3944310oib.10.1706759224647;
        Wed, 31 Jan 2024 19:47:04 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hq24-20020a056a00681800b006dbdbe7f71csm11052857pfb.98.2024.01.31.19.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:47:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/3] net/sched: netem: use extack
Date: Wed, 31 Jan 2024 19:45:58 -0800
Message-ID: <20240201034653.450138-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201034653.450138-1-stephen@networkplumber.org>
References: <20240201034653.450138-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling in netem predates introduction of extack,
and was mostly using pr_info(). Use extack to put errors in
result rather than console log.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fa678eb88528..7c37a69aba0e 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -782,15 +782,18 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr,
+			  struct netlink_ext_ack *extack)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
 	struct disttable *d;
 	int i;
 
-	if (!n || n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "invalid distribution table size: %zu", n);
 		return -EINVAL;
+	}
 
 	d = kvmalloc(struct_size(d, table, n), GFP_KERNEL);
 	if (!d)
@@ -865,7 +868,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -878,7 +882,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG_MOD(extack, "incorrect GI model size");
 				return -EINVAL;
 			}
 
@@ -897,7 +901,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG_MOD(extack, "incorrect GE model size");
 				return -EINVAL;
 			}
 
@@ -911,7 +915,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_FMT_MOD(extack, "unknown loss type: %u", type);
 			return -EINVAL;
 		}
 	}
@@ -934,12 +938,13 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, int len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG_MOD(extack, "invalid nested attribute length");
 		return -EINVAL;
 	}
 
@@ -966,18 +971,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
 	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
 
 	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
@@ -988,7 +993,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1068,18 +1073,16 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		      struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
-	int ret;
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 
-	if (!opt)
+	if (!opt) {
+		NL_SET_ERR_MSG_MOD(extack, "Netem missing required parameters");
 		return -EINVAL;
+	}
 
 	q->loss_model = CLG_RANDOM;
-	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
-	return ret;
+	return netem_change(sch, opt, extack);
 }
 
 static void netem_destroy(struct Qdisc *sch)
-- 
2.43.0


