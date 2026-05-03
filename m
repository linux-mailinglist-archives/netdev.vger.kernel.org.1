Return-Path: <netdev+bounces-283667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DhsI/+n92k/kQIAu9opvQ
	(envelope-from <netdev+bounces-283667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 818824B7316
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 047E33006D60
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB83A7835;
	Sun,  3 May 2026 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="tSAmSDja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE63A7F54
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838038; cv=none; b=MC+KhZynUDkx413vQM5cVdunirOo0FeK9yDNAtXCHR7rBa/K1siYikzvagDuIm/C2ZU0GaghWflYLMQqZOnwH71UzdoxOsYcbuRQj4yVTtVs2AwoesGdYf07VSlL1XlEHs5NYYOYbVrfjVWGQG/6dFfzQPAZDKKrZMLs73fBm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838038; c=relaxed/simple;
	bh=zPWzcjNBVfWN563IAAllTK7KuKnfkuk377h+1o6H0AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h46YZdwcuac98oUrJA5nvEkSFav+FEMsOiFntR1JkoQR4k9EL39ld9+dzdmmWrcukGw3pFb4MOrPt8qxSNmsjftyN3wHcoVbTvPObO0dHZvE4Co87eNNAkW7sFaSg30fVCXgSLjNGsKqa2C17YmC5IrPVK6v8/I4VUmmbwUzrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=tSAmSDja; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3643257eec.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838036; x=1778442836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMjTGKONR8PLpGGHjXOaaygK5+2iJT7FnTbkmKNmKlA=;
        b=tSAmSDjas2wCxjSjJ5mOmlev9pcmYX7zdGfkQ8Dwa1SPt1ZyXi6ZemoD+mlyAtKmQ+
         QpuUVuc9nIoaLwbqXCbYBKFRrz9dUI8Yw4uRhOejdUEFE4XRG8JMg9MhMsDp0jE+g5QS
         PKHmRzSR9HwzPT3EWda1sX0TFr7Qu4rMR/SYbMK06Ta24onJRQ9PySYRwhvZLmUV07l9
         e4V4XWRwqKCZXMzesvGtIJ1Am8Xnz2whI5GFBNnXWGW46B2tilM8KruheZc3fMJAP1Os
         lMe7IyTVwglcpqsH3mHTKgYEmVlVZrN1obei0eq8gFy3sk1SUtXQzdkbpWNgMddjyAKJ
         snSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838036; x=1778442836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMjTGKONR8PLpGGHjXOaaygK5+2iJT7FnTbkmKNmKlA=;
        b=DuTa9t3zrIgddIh93R2bhbatRXNOTItuXoo5o5DTyiEhC822lYIM9RGQN+Xck0qR8S
         wqe0WiJ8cRUMZrK1vTE1VvtGAjv2q9J6LaY7W+22VAqvaTtEd9Ig4r8/0rfzmlZyqbbz
         ke9SGa+dVGdTsEtZUNfC4GQw9FqnAat3g0nBX6JdKBM2kmC2tnblkRIFnYPK63elvO4b
         1fuvmvNXoHJCqWNf14d0s9ZWj/BzAhnKXH4jMDS7Lt03SJpt4BA6jo3XNcmLQ8iybU4B
         kAiL5bBC/wX4BJ9wdg7XyHum/LJnMEafOAa6QunEOOcNgM/T92/zJYV4qZNsyAhBWD5h
         nfNQ==
X-Gm-Message-State: AOJu0Yz4O77AOz77aB1kXMU9aSRKKKNiZBzT4f9qrIH3FQu4S7hSFbzr
	AkFghl2qJv3JUDaR5+IwL6QVAPs+pfHu+9fvgLwDfV7jTKdV7A67YuKQoJRgOqojkRT8quUctYj
	bqGR6
X-Gm-Gg: AeBDies05+gWpzvh+DfpB5NdlKUIrLxih4CPjmX/cZ/u/beVMxxztc5xYpSnM9rdsxz
	ZxcLEa3hzFIdpezaDErxOisESwRd5G5ldHyBz8IM9XBPQv+x/1/9lhnQdHbCbU9PEv0bW6sKX0P
	HG1pRp/iP8EbQGOhXHZXrLDnfnbGRrJOHEJAaCuRy251rEMPXek5WLv7Vkd1vW1yQgaaqDnopgQ
	5xxDholtoSshZ6UhViYX6lRG3xpWipa5HS0Lcy3rZ0oghZhys0IvNiGilq/59CKmBTDM3IrvG6n
	/knB1J/IEDd9xnxqISlb2oe4Sren9EA8PzvrWHNU5mtc9+Euzgf7TMrswiKOwynfLl+LPxfuU5Z
	EHHPQQhMXS4LPhBjzgEbe+7eiYkc4yqvZUo9t4S8uni+v3aPAVGW/LlGj0YjgXRy4nXxi3ox1c6
	hOIv8wSV8oFJZHeDp7P+CDrvU314x6rRHfsLe+br1KIaI=
X-Received: by 2002:a05:7300:a94b:b0:2be:80c4:2c8c with SMTP id 5a478bee46e88-2efb82b2276mr2891767eec.8.1777838035858;
        Sun, 03 May 2026 12:53:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 3/5] net/sched: netem: replace pr_info with netlink extack error messages
Date: Sun,  3 May 2026 12:52:01 -0700
Message-ID: <20260503195348.521225-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503195348.521225-1-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 818824B7316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283667-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Use netlink extack to report errors instead of sending them
to the kernel log with pr_info(). The error message can them be seen
with tc commands; and avoids log spam.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 2b0b5c032e70..53961d1e70d7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -921,7 +921,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -934,7 +935,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, la,
+						    "netem: incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -953,7 +955,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, la,
+						    "netem: incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -967,7 +970,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_ATTR_FMT(extack, la,
+						"netem: unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -990,19 +994,21 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, int len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG_FMT(extack, "netem: invalid attributes len %u < %d",
+				   nla_len(nla), NLA_ALIGN(len));
 		return -EINVAL;
 	}
 
 	if (nested_len >= nla_attr_size(0))
 		return nla_parse_deprecated(tb, maxtype,
 					    nla_data(nla) + NLA_ALIGN(len),
-					    nested_len, policy, NULL);
+					    nested_len, policy, extack);
 
 	memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
 	return 0;
@@ -1044,8 +1050,7 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
 }
 
 /* Parse netlink message to set options */
-static int netem_change(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
@@ -1057,7 +1062,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
@@ -1097,7 +1102,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1193,8 +1198,6 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.53.0


