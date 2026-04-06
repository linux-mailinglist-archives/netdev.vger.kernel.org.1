Return-Path: <netdev+bounces-275662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lm/HOTs02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:27:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38983A5AD2
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F92F3028EF2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166738F251;
	Mon,  6 Apr 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="p/bzefhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BE39023B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496396; cv=none; b=exIr1evsNtlzVpPqW0zUmsbdOwG/4rZo2JW9KWY22pC491euUoPbu2Hh+UJjwE7Gw+56X9kEnbYIpwAW/7MafkUz/TjmtELsVwyvpzv6DsDQQvsvdIdV/cEpt04Tvb17yFspHrVH3LxKvAXfrFMIS0kVthSYv4+Fm1iVzqolegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496396; c=relaxed/simple;
	bh=16nOUvo30Xx6RphIquFLVbUUre/sfINB6kQLQfOEvuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieW2IsWVU0CwwVhN3XRNGD4oLatD2sanu6Wrjbxmg5eIEqRe21ss0F1F/T+QK6z2Dc/qzb8XGoVsfE0hzRR8ibu1fXZRgcLSSEPYb8VTC7Kib0C7mqPUqKjnUQBIr9EKAkuySZPNnR/gY+ABKuEBNkevqYS9Y7snXqO+9yqerhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=p/bzefhQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbfab4501so15885135ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496395; x=1776101195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15NUA2j8qXm6cm8Ry9Xt40KGlrVm2FzPIK6vLdfNXBc=;
        b=p/bzefhQSu3va5aEas6OSaH+ywWrKivM0MBVt+0BqAx4TvUxpErjSA+3r9ws/i2sYV
         zCV93eAiz+K8JfCQzfjQNAtX6uRlx620jMQi1eBwY3BcCzyfLtjnNzDGXesespjLwyid
         argwea3BovM3EQScrS5U+8DzsV5j3ZHIbjdhZjlOLJy3Fp4ICB9xK6n0U2dW7f9KTgRI
         w4VEada/htqn64WX8HyJICJETJtVC7EpGfcdnkUJzoLAAlDtVi2u8OUk4tJBlSHKdtj1
         zUHC3w8GaXn0aP+VTGlAyWGOh8mU/RdsReEJthD9kW8pLtxyvEgLznDRPQxp7XlhHqDn
         8eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496395; x=1776101195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15NUA2j8qXm6cm8Ry9Xt40KGlrVm2FzPIK6vLdfNXBc=;
        b=I2lr9yElodyrCoNXBMRJdI8INnUIl59HvxMfweD5TZBZIKa4PeFfNNIB735N0MW74i
         +/es/iZ/NkgXNiytZfv5i6zfSOgQERWa9/En9FZBMKO06da/A3DoeH4/5gbjw2qVgS5w
         /auD0llgcUki6YbjRC/8hHodoN6HlwVzkKgOdVUPDpy5fNqotFnHe0eoyxAk66yIjj2S
         GPpaQIwuecPg5GUNyHaNx0DBsOH8ACsRH2+QnIbI/zcQtXSHdR/BzwU4Q+fmrwziI2LN
         ofshkB2bp2wUEAMPVX4uEbGBDMmIq+yDw4KE5FkXILp5moQbJHTngR2fGijv40hcvyvN
         9qsw==
X-Gm-Message-State: AOJu0Yw1wiPns2Db/XbelCI5YEERvhgBsPRwL8vMcfTQWgqOztyJsyqF
	AqHtauwBXcWEO3JYLOGgmwvgJbM/0ew/+IynWqDom5KVu+J46u84UIfMd5MFMu8O0ZHoofGS43b
	QF8eG
X-Gm-Gg: AeBDiesjo513+JPxAkDx9skFgSTmxjwBuQNpTWB0uh4eQ5xWOvS9CL73tGEJ43kI6I8
	WiD85hW5GIty+mTaJmPF0ZdOwi9zxyfJUoYfTGDA41bLI5nUi14/IE/SZ9E8YATEJd2wQO8DXGh
	GmBSItOBmQsSSycF7Hcy6KDwkRc4GH0qf01uljURGRGfnmTJeJA1YHmNPKbbhnZeo6VRQIu7bGv
	o1HVwNZNpfBgLgDxmwViGJO7PVUG89y9crPmsZ/K7JD02erkMc4cJTErJ4AUu043JUIfAHWVy93
	MB9Flf3bWkufX+jmUoaEvPA2B6m4n4Qq98SbmybPYrwruS8/F2/rLm3Z/tgMAn+HuHO2Yo4axs+
	WanV6oKfO2OjriDfzWXqaBi3eSQVPC6SEYKtANcf2EMVkP4gf7zWuXfUsJmmkdDHuiQdshFBb8O
	G0dMWpO/TADJGS+UzLtwmYe5beSoTLGDbk
X-Received: by 2002:a17:902:c409:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2b2817ce5eemr154161095ad.7.1775496394915;
        Mon, 06 Apr 2026 10:26:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:26:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v4 0/8] net/sched: netem bug fixes
Date: Mon,  6 Apr 2026 10:25:08 -0700
Message-ID: <20260406172627.210894-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D38983A5AD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These bugs were identified while using AI-assisted code review of
sch_netem.c to analyze the packet duplication re-entrancy problem
(CVE-2025-37890, CVE-2025-38001), which are addressed in a separate
series.

The review uncovered several additional issues:

- probability gaps in the 4-state Markov loss model where
  boundary values produce no state transition
- queue limit check not accounting for reordered packets
- PRNG reseeded on every tc change, breaking reproducibility
- the core dequeue re-entrancy issue with child qdiscs
  causing HFSC eltree corruption and DRR class stalls
- missing NULL termination on the tfifo linear list tail
- slot delay configuration not validated for inverted ranges
- slot delay arithmetic overflow for ranges above ~2.1 seconds

v4 - split refactoring and fix for dequeue into two patches

Stephen Hemminger (8):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: refactor dequeue into helper functions
  net/sched: netem: batch-transfer ready packets to avoid child
    re-entrancy
  net/sched: netem: null-terminate tfifo linear queue tail
  net/sched: netem: check for invalid slot range
  net/sched: netem: fix slot delay calculation overflow

 net/sched/sch_netem.c | 245 +++++++++++++++++++++++++++---------------
 1 file changed, 160 insertions(+), 85 deletions(-)

-- 
2.53.0


