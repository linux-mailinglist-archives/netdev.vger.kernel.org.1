Return-Path: <netdev+bounces-277658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKVYEFnZ2WkItwgAu9opvQ
	(envelope-from <netdev+bounces-277658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A76023DE630
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DDF4302F7C0
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82C1B6CE9;
	Sat, 11 Apr 2026 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="rMM6EdjU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAF17B425
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884630; cv=none; b=WtRwAL3enSCgU1UQV2LS+C2fiqjkPF7UMvx4HA6dviLhXP9ttIWHoUSQ7DNW3ueVuN8TgdJJCjhACgKYrof1l0qOFLKsm5/S/yVYjTua5+2gbiFEMytGfRyLQmdu0zpSgm515gbBzaredu6I0MAVtrqksveIiVu31ClkDYO9AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884630; c=relaxed/simple;
	bh=+5cmyVBngjtirzmI1ixD/zNwwxiX9r2wLQ7Mm7myxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh6D07ChiHJwtZ+jADpySeTfGlHuJIkLDy0EM7pLiygj9NzMqdcTW7e97djdY2JalhNV82EkGS1S05bBJ3AEGkHUW35e6y3wpqLXq6nZ+aLfGZt5JWf0a8DEQ/6UMi6mLGI/hfSaVEiXA/Jd+dP11OXsemLIIaOwMwhWPvkUIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=rMM6EdjU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so995963a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884628; x=1776489428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4K+j0HFzcE4tUW+MAnU0WDu48PUayY5FoZBhp8lrc0=;
        b=rMM6EdjUrB8OhgpUBFBVGSHiEcS/9gEW0dfFTL/TrlklVZ7GdmTwSdjrZNM373Tu/b
         7u5Jbt8eRazIbtSznyR54wl/UzKtFNEml7SI5EKYPj15yHYvffUfq88P9CVGBgW33odK
         QQjm7beeq/wRWbhS9KXDGOUJD6fbSaFDn+YLRuK19oDP/r2fpEqMHFsYsqCMyvUv6Hgu
         7ZBlU6li//4pEvsGYfAQBnArl/gDuQ/1Cc7hbzGt/4tjqPDIXkl6R5GgBJKYTNiniKLZ
         yIM5YEtYxtr9l3StGBerS55/yZG7ZsaWwZECcoIC0Tf8SyFuF5RT/ufIgwFDFdc7hSvl
         0ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884628; x=1776489428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4K+j0HFzcE4tUW+MAnU0WDu48PUayY5FoZBhp8lrc0=;
        b=Ak2lXU0/zN8VauB9izKSPMLVgkbkIqH1VFGX+9c8atidGAqmH4FaxWTdpGZSY9IB/E
         MjxqSVs/fu5a1Q3l5h4di5i9TJe+facbD9XzzQ/P+ie9X16AZKAbFzYSQMz+be6LiM1e
         NWH/xpe8mvj6Mnm2MUosFm6Mpx/nyAHNO9qt0r3rxKKJAp47Irnqt3jyfGwWXxnUzs5I
         FVlIgOpvd+S2U0JdbUnh8eTILUigWo1WsHb87Di82f+8WfBp+agP+zvQWiFeJOEI1wEU
         cW88HObv/KoEx4kSpq26Bi+l/68odJs6ZyshmviVd3HY87ufopygenAMSfmGTLuS16N3
         Wafw==
X-Gm-Message-State: AOJu0Ywvs6W3ttBpuKlPG+dCo37kEZpQu5Pcp0+exsO5NgbqSjrStW1W
	kbaeVdPHiz4A+gIvMvAEeBjaAfWtcN1DEEQq6KKZg2QzFwz0hnmKNg3Riwon2WGxdqA2eebZnxR
	oJtgb
X-Gm-Gg: AeBDiety9Ah8vZ3EXre75Dh5FG+ZSBif8BOVdNjY48632N5NN+/rFYvJ24p3JXrsQlW
	OP21VGl+VQQhBx+eWfUS8c7DuXVImdzMPUHbArCQbqeZE8apFE4vdkD8FFRPrIS1Q0YA1OeEqbx
	wQ4otldjX2Es35nk7CiVbmMz7oQypfhl2c+mFoKl/1yrvXiwBzEQVievJjag6U2klV+eQiGzr8M
	nUdre1ZD+631vIj/Qkph40Vp2C+o7iciZ0NYY8iKoSjTgCXlOJVtHO9yG7apmo+HGc9iWkcoAlA
	pYTMera58UmWkHOrnGOzoSUX/4XUkooDB7mKKDCYjniaDDrPUFqkKoXAIJLq9e5RAjRGLkST6fq
	+SLKpVrs0zI0KASKjpoVxV6uO2beb1uRFofOJkanbi+F0u+2m2/ARcz+zjzlaKAGrGaMGkPThPV
	akDUItsiDgKgaqobMLUgrE+044C2+VJ0Yi
X-Received: by 2002:a05:6a21:9987:b0:39f:1f92:28d with SMTP id adf61e73a8af0-39fe3f1d7fbmr6658156637.29.1775884628448;
        Fri, 10 Apr 2026 22:17:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATTCH net v5 0/8] net/sched: netem bug fixes
Date: Fri, 10 Apr 2026 22:15:49 -0700
Message-ID: <20260411051700.311679-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:mid]
X-Rspamd-Queue-Id: A76023DE630
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

v5 - fix slot dynamics in the dequeue change

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

 net/sched/sch_netem.c | 238 ++++++++++++++++++++++++++++--------------
 1 file changed, 159 insertions(+), 79 deletions(-)

-- 
2.53.0


