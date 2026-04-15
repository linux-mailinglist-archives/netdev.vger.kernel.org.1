Return-Path: <netdev+bounces-278798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDW6CLqh32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4B405535
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBFA3117A94
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2F3D47CD;
	Wed, 15 Apr 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OY1Qm218"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4283D47B9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263312; cv=none; b=LLy849WdviPUYW0y7FziteCJXEpFpIKxY5SEzNtkyU2nHXnLqdV87uVrzOzJOIXo7wi7c1WTGOUOYyztA357zQh4/NLGsLLvIU9sIVYWnC4TlXt2UWjYHKNJLqcfkag0pnR9h3+vIk5KFo6Suw+yjA5M1/XNcXgfAcMl09AmO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263312; c=relaxed/simple;
	bh=fL0OfMMtDWSxHR0JJrLSv+7El8c9nsPcZEBdX0sgkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DySYYWxrwJqRBSruBMiL/anLDOUFO+dATvP8InKC8tMpmEuapD4D7nO0ZoCbABDBPyY1FOX3cbTZIUgEWM33P2utAHUdR+MjW0ZBpAiQoFTavwUG0siKY/rb2UlvWOEj5WRqEb0Kf1/ycnOCA2SdkcM4KPdr2Hpym7tf8GJFmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OY1Qm218; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4b77adso16342802c88.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263310; x=1776868110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=OY1Qm218VSxg2KVB/NhsvK34zkj8KEgbpNi1DfepTF55FAPt9daahNqpsjInS7TKem
         sjYIODoPNaXdyDmePui8EsGXH0KoK3g6zJxVqsSGd+0w7sU8F6gUzvu0E8Vda/IQBaYd
         wZL0LG5XfnxSiyMP5crSS0rxkMQwisDWXGGKhfTRd1CUNHGjhMTijeCL1+1nL8CFVnQ4
         0l8WPqnBlv52PCI6vbl2fNSnp0kB5hp2Y8HYVTHks4dzuGnYZXLijnMMvjaXExmk7M13
         O/OQChuCR1lq1qPku9M1EoFsLrWH9ETWIfopekGpNf6bioIO1PDpVKk98C+U/o9TncDv
         Ht9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263310; x=1776868110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=qokLIApDOAcCXk9q5BS562VcXXSgzxMbBWTHULaaFFe6ehUWdx5/Kiu4/fEG8zvu8L
         0xA+SrDHvGkWx+VB0OxEzpg1T/QSpqDWxxnyZa8T1f8YOT022f1qNfszzQ9hJl09xJbA
         wcTdkiaJf593k1YLc0VlEtGjWrJOz23q7mgcLWGri6rS5zDYtXvXR9Gb0cItjWyOH/DD
         h2bc/K1HzF8WSPbsg9z5SOL0NJpHfX7K7MgG+A7+08Ld4zme0qju/5RZKpJGAx3LLx/9
         tRjurs7jKvx9CBTiSZAKtji5+CgA2O1Os8yIugEiNXrgMU8MV5bb8TCz/NLh1zPEQzYK
         hbIQ==
X-Gm-Message-State: AOJu0YwDw1Amrcjrlp+h8gADgU1ooIEf33bRCoithmv9CVSi6CgT9cYu
	K743DpTLn/mxKMFd92saYkyywUlUHMU+Bp0iq1Y9uzCL1DLryovp30ojs9MYqPrV3emQR0KDhzI
	3nTvz
X-Gm-Gg: AeBDievIc0YPBb7cQ9vhg263ocU/j0TgENZDIZ4s3H5kyNYHfjJqF3mTJCvtFfXPOUU
	z6unPxtj1o6TpN9/0NJKHHJ8gMlrpTLlatc8RfYM6XyVzINdBA5X3CUxkuV5UF1DnEFIljAnNtk
	53GIWbNCW25EVjqIEdKGIkQxPKHiboa+SMGJqKnrMttYyQyv46qwtA3QFZIIpS1TRtfaK7bu6Mh
	6Pt3U7chTog8odNmbiQTrRjJt3KLsksTUKPYPZZFj+LtQ1ly9gZvfvNnoOJLtOITwSQ3AaSUuKQ
	Ek/3EfVi+Tg7zjXHs6SuW8TewF3Z9kPInBQ7ceneKIuigaSIToyisIzPUfpyyfwyhCV8E/qZUr3
	8BNYGVni7sGO1UmPAxqDmieZL4n9Bp9CzgJfskfbEvrR3kLQGWdUo3WPGFW2MpRykI59dH0reQf
	pxfYrokoGKuerZL2UUBt/BTw6YsJQWGVD7mLNtEb5cIqE=
X-Received: by 2002:a05:7022:eac7:b0:122:2f4:b251 with SMTP id a92af1059eb24-12c34edee1dmr11440403c88.21.1776263309605;
        Wed, 15 Apr 2026 07:28:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/5] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Wed, 15 Apr 2026 07:27:06 -0700
Message-ID: <20260415142822.133241-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278798-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FB4B405535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_change() unconditionally reseeds the PRNG on every tc change
command. If TCA_NETEM_PRNG_SEED is not specified, a new random seed
is generated, destroying reproducibility for users who set a
deterministic seed on a previous change.

Move the initial random seed generation to netem_init() and only
reseed in netem_change() when TCA_NETEM_PRNG_SEED is explicitly
provided by the user.

Fixes: 4072d97ddc44 ("netem: add prng attribute to netem_sched_data")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d400a730eadd..556f9747f0e7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1112,11 +1112,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
-	if (tb[TCA_NETEM_PRNG_SEED])
+	if (tb[TCA_NETEM_PRNG_SEED]) {
 		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
-	else
-		q->prng.seed = get_random_u64();
-	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+		prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+	}
 
 unlock:
 	sch_tree_unlock(sch);
@@ -1139,6 +1138,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.53.0


