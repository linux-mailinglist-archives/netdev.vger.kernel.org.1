Return-Path: <netdev+bounces-267612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PWyNuN+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBE28A160
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D656930217F6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A513371D1E;
	Fri, 13 Mar 2026 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DUK0ddhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DE382378
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436641; cv=none; b=Dg5DXNTvXFTt7J94NGd42JIs8fTtwf0NLLsnbrliVrHLodYT15OqBVzvI+Pu1dYJXSLXvxkrAjsTUP2nqwdkHR54HpD49EEhABMlzO51yZh1egjFyhgYUMrlP3HaxIqNDk+lTxvbwveuJo/pdQ+xEMryl/evJqPR+Pzxs/w9nhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436641; c=relaxed/simple;
	bh=ON8sRRb1NSXU6us1gc52Sj5k2+47WH6wEUI39E401hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx18J6yiTDQJqaKpe65dSMtjiz9SFpw+FbQQbImtC6rkOtj0LCQHjDNP7E4VPvdPlx8yb0/WNWFcZP2/wfse6W2itH7ANtrJhAymhqx8sgkb06hCrI9C34CPua4AFqDzuPuY2mxpDbnjr1Px0Kjl9JwKPvtzXJ5OQsB3TGIIgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DUK0ddhZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab39b111b9so11809655ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436639; x=1774041439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haJbIiZckhGuph+XlReBmXs7q/DKtkyuAyGVHF9DSos=;
        b=DUK0ddhZ03srR8IddJ9Q2bLxNZi8aJqS/MrJpREy7NithRbEHnV8S1kZxftN6fYUVm
         TXccYLKiLP4yk9H2M6wTSsYvHlKgxBdql3b8zO4B0yCTH9h2QvDhyZVQg1Dscx05cElZ
         yoZWXCVJorSr/VRvSXRQAKzDBjufHmjrC7wcMacR5RcPRQayPja2pg+NkP5ZMilFTEBm
         qq+VS+br2/x5hqp1ck/S4ovxnqnixkKbYr+AhZAdUD/bqEct+rhP5eNN84MsevP7fknj
         E+6HZ6BjtGkPitDNxxwe6q3MC6SVMiUlVM5BBcF5S5MH5VBt3xri9D9wWruDWmw/ADj1
         NHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436639; x=1774041439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haJbIiZckhGuph+XlReBmXs7q/DKtkyuAyGVHF9DSos=;
        b=GnCwEx8MvNS+HEu+7K5gmmIrxK74efTTZJrU75OssA89/0k3F/X9GG6W9nNDbC4LLG
         kUhpDXjXW/mu0D7FNrjhII7OsOQX4K/ANUn0lBwW3P7srmwewlJeHyIj+EX9SGNrgy3J
         ZTEZS44qy3u5uE+i926l6L8R8uMYavuEKKKJzyf75/vz6ErZhhf2gJEPR0tMYpvZJf18
         J+RNOQ8TrK8mQsS+mrNSNu4wqNRXct3+cN+qSeyKdtxF4KuyiG/nv/MJ9XSko/QJMJvr
         +mpjiSWnTpuZGn3KKOv/ytKofhhIvIYagZuM0Ve9GUvqytg+bkOwPLgmpUZm3kaMAb+P
         +eng==
X-Gm-Message-State: AOJu0Yxn90qoiFcpDu1P4DZxk/YWJuhMERb7xQepXlxUzB1qSxjXbhL4
	3T9BtkJDWyfVIEX448AgfuofgKkQAWdwGc/U0eeVol0sNnnX3t9az0e0/Tx0JoidxXCRtrH31Ps
	TAOhJZkY=
X-Gm-Gg: ATEYQzyuS4pvNTp123X75g/eaUuTltiBVMn7TEptPz4UboWhfK4JU4k3f6E5esgQqQ5
	jb5bIObcyA/9NJXrx42NZhMxBfuC99KYBbpoX5lD/0dtMe5YQ6+KYanMHkvK5mlI7yPJF2V5zHU
	OHxaJmXqLeKgznYx/1pSDIq1KJroddDva28PsDpc0oH5ekrWRD71rrlm0VNT5i4RAXH0K+VCfdu
	sYcLVqG+gLwNHSdO5MIqVPAUKja132STxDiP3SAQooK7F+c9cKMtIBesiGHsfVkHu6CcrIn59tC
	iRm6W00IRdXDRaBLuMGlavqUa5q6WbcvtHZ6vm0oAnp2HOAUiZ20As2Ex9y94DWK/VvFzN7SC9F
	AE6FHqBxwmUqxm7cPyW55+MefG8pDuEL6rvn8DO8F9UELBMhopotVUhIT6QwWHzMIZplWucFntx
	9Mv+ulQk3M3+k1X+5PiSQmUnJR3fV/Ue1QLpVJsxTRDKk=
X-Received: by 2002:a17:902:e80c:b0:2ae:a786:6663 with SMTP id d9443c01a7336-2aecab1e86cmr46422345ad.26.1773436639277;
        Fri, 13 Mar 2026 14:17:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/12] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Fri, 13 Mar 2026 14:15:09 -0700
Message-ID: <20260313211646.12549-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267612-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 7DDBE28A160
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
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0f6817a472e6..dd98778ebbec 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1123,11 +1123,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1150,6 +1149,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.51.0


