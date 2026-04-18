Return-Path: <netdev+bounces-279452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NP0HEoj44mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC241FD2B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 932A9300C38D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84C283FDC;
	Sat, 18 Apr 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wfM8DTVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F11B78F3
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482434; cv=none; b=AfM79nFfEHoyxfMqtIMl4jexvvEkvk9TdvRM9JW/IgEXYVSxFp2j/TQYM/6slK/aqWz8U0/brS7kHyUtcObIa7Mr2W63XFO7NLEpw8ywBxiH4uTw+DvbWpD668FY5t/I8Fczt3SmLB0xdwrBk0KJQyeYLBgbV+CWZDDUMqx4MNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482434; c=relaxed/simple;
	bh=Y/M04qElWcj0Nt61DAtpNAKCLv65xb4+2dr1r8WnHF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khm8gUwdIqr1JIZLlDFQWGipz+GB49uE2DXITD8GhevMykgr0KrF8tbUMKlO4inQgug1lYQXxogjcoE+t50FFVYAzCycXWdRuayD3KpN11C3Cmg1nUC0fsyGaeWDX8dqRRTclNJtTGkK9InIWylZ9LMCw98azQIWB279U1l0/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wfM8DTVe; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4795222965cso864294b6e.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482431; x=1777087231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qicb5ecn7n7dk1Db6U0s6wyKPPl9m/tKxFu/bCw6xM=;
        b=wfM8DTVejiqeqbl73En71UYlpRLo/9jd7pazXcoIHJJaMLqeiBm7lQPMa5Ft70/iEI
         Ys5yVfO1acu+jhZ8LbwLdpq5lKrfte9i3aEsSGmgs82g835EyWYHJuX1Xqdsg77wdAcr
         2ItIGbvhS4KQB56r3XSHIuYBNmo6S+o89WAEceMkgL3u2VQFZzVa34PG7pkvofGQUenU
         YBO8zFA/QZT/CK1T97tZq0lrKh7T4EtgOhOnuO8Lz2JAvBqGp2pDnoUs1lhxjAcaaY6K
         GiSWAbiGjAdtOvAZM08zSsZes4lx3b+ATVpKuodV5uS4BFNTQ50mYGD06mDaB1kTUKUW
         55Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482431; x=1777087231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qicb5ecn7n7dk1Db6U0s6wyKPPl9m/tKxFu/bCw6xM=;
        b=HiHUI/PbACikYjDlgwuDakbQRxVX6JtpgXG5pCg8wKDfR6L7N+DUt1qdXbjHamBPkf
         25lunXJ/UONWgOT7ZnxpqvxfAoPg/lOqHUEJK35NblZwIMoF5BR/jdJn7yUrvf2I1lZd
         Wo9uDQPUJdJQFP09jexx1D8FO0e9Xio53NdVz/QjBF6aENz4XPbmm4r97irD9T7l+ves
         t0cr5LiXaXKlzObBWj8o5itWzslEIj0ii6WMszoRRgJ4sXOoMjLovo2ufTff3PZ/seSN
         SmRznMt/rhoeGzwxZz+9qYpmGs7h4NSIVOR47bUIpW0J0LiZSamy4y6pmDy+b9Fqbmdr
         Ynbw==
X-Gm-Message-State: AOJu0YxsllBrs6qh5CAVibOhoz5MWTqb/OGQE3TUbN1QfpmjD4vnyOBI
	FxseR7ldcdlrslusgicHSaij7BscEealCk8IAa+cF1sB3keCwIo56CYPCD2/pWcZ0MjZkuG+7WK
	OYwS2
X-Gm-Gg: AeBDieuqXaLG1Lk8tuVvLnbqFDA5A+Elo1cLyUBq1Uh6ZWNCpkC+iRWi1Mr9iFWD9Ly
	WOCE1rUqJvqHvLd0pT4w9wSzY1xWuJc4aggXmpxqsPnJdZrE+xk2u4OHCSn7vCYd/pIJb6e/Eel
	+hcZsfqOcONFmPXU6/o/E7bgA4/9u0mldr7i47WrDpYBGGIL4QlyXONrLOSwB0KNYnUudml5/jx
	cWnLAZyqipmvJwxjtBkq9Tvetp0Ofuk1XEZ0QyNtzgSxpE4CxlFDdE3J0lhxLx/BgdLnkSy6Fdx
	IAY8XFdKM4VBU/xaAksscZTKit5cbXiNGFi5xig6nve95A5/QSRqdcgHmA5BcYdc3bYUhTEbJbQ
	MnMBrk9mHy+7IYzzUXPQpeXp1M98IeJxkpHxbOMvPnXNGav95AA6AHW0EA7TlIH4Il3WsoAt850
	+NFp+nHkeC0QfDsz8P++3WwZ4s7B9n80awb4gPd0WXccg=
X-Received: by 2002:a05:6808:6f8f:b0:45c:881c:e0c0 with SMTP id 5614622812f47-4799ca846fbmr3172228b6e.47.1776482431049;
        Fri, 17 Apr 2026 20:20:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 net 0/6] netem: bug fixes
Date: Fri, 17 Apr 2026 20:19:38 -0700
Message-ID: <20260418032027.900913-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279452-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21AC241FD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These bugs were found when doing AI-assisted review of sch_netem.c
during investigation of the packet duplication recursion problem
addressed in Jamal's series.

The fixes cover:

 - probability gaps in the 4-state Markov loss model
 - queue limit not accounting for reordered packets
 - PRNG reseeded on every tc change, breaking reproducibility
 - slot configuration not validated (inverted ranges, negative
   delays, negative limits)
 - slot delay arithmetic overflow for ranges above ~2.1 seconds
 - negative latency and jitter wrapping to huge time_to_send
   values via u64 arithmetic

v8 - added check for negative TCA_NETEM_LATENCY64 and TCA_NETEM_JITTER64
   - extended slot validation to cover dist_delay, dist_jitter,
     max_packets and max_bytes

Stephen Hemminger (6):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: validate slot configuration
  net/sched: netem: fix slot delay calculation overflow
  net/sched: netem: check for negative latency and jitter

 net/sched/sch_netem.c | 76 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 12 deletions(-)

-- 
2.53.0


