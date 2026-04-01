Return-Path: <netdev+bounces-274138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDihJtE4zWnDawYAu9opvQ
	(envelope-from <netdev+bounces-274138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1537D044
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66E5301DE21
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA692F546D;
	Wed,  1 Apr 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="js0hHjKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76330FF36
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055217; cv=none; b=D9RPAAvgxS892oL0YbN+CcD0Cj1dyR8EIze+NWDWNxyBiDtI+AsUC1763thGUcX3Pp3BS7UprQ2wA1LmxRH0yxeoLKlmF8EJ04S/OKXEy9zHx6tYw7ucxEcCqSM1XPm9zI+VU9GU6IcFamojPEmnjIGHzRE/M7YHxKiUCPGzd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055217; c=relaxed/simple;
	bh=Al054+aFBMdht5DaHuhTTDJ2XBm6lHkzpBg2AdzX85s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyX5+ns6RPTRbYMwAoR73QEINnnFVOwft6vEMVWYBpUiyQkmNvoK7/4tkad6IE3oogU9eEvqawltYRGy2v0R2yd8MhkMoZe0Z/SyyKn3FQ/lll2Reocqntw8guhiZJjHUoJCV9NdFC2VPMXKr8ObySpGPezVPQcCfQ8mFsl0sF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=js0hHjKQ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c7e5f38b37so2592796eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055215; x=1775660015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVAwx/GHOFQcTLTpyOOCs9PGOthc+iSHNhYTbVMENec=;
        b=js0hHjKQ/OJhcoid+GFlm9mu6S8RGkVAd/oHvNupDQ8P7+C0ZcxEG5Ij/wR6/ad+3G
         v6QKx04xEg0lrFcAe/FcSrZyYk9GZhABa1t/ouCbvOmEiC/gtFdTTcyFgD7a2SiQG0S6
         4qFAasd+jHDCD0263rolWp/nbOlVaKPF4E93rGZkAQ6Q1ZHk6XxhBGncva7dzu3+S6iy
         YYhEQ/Z7DbYnBeOnmwbA//RvPNmp7TKhr5j4pkIRzlDOIoad0qz+3CyF9P5diVVR1LIG
         ZvpVYsrooWbX51dDl+q6V6qqh8dIpgWazsx4lT0uZoIHG+Slsley40k1/3vkIldc3uRO
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055215; x=1775660015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVAwx/GHOFQcTLTpyOOCs9PGOthc+iSHNhYTbVMENec=;
        b=Q8blcEWVQImvG4qgsVek/My5Vc5H7Lth9j2tduzo09XO65jwMUoP/JzLfvUB8O2vay
         AM6GeLw2ZSgp01NFf345gwPnvDreH8wCuZ9/Rg68brOWwijWYEiv6yUyYWUJ8IFq9X3p
         EVy37OjnPmZr6aNo7DmRxORZ3WKtu9m/EhW9eDIQjI8LfR97qF8cUVFhWbBtQCh/8iKk
         wbdo29+BzKHPNM1uW1X8lLNaiMMR/vfLrVyw/5ufNjHZSpNBb1kn5l9rkTUbcayP2yJH
         93dpRsDMzgblthnUjYioMKPJebzhT61h4IuVolhY+4dQRxjMM5prOkfaEjM3rxdVno5f
         SjLQ==
X-Gm-Message-State: AOJu0YxHphw923fDGZLCTQScD+SYm0HJPRVMXTxbWSuRUmtcBQyxnR9Q
	uyYeJH66ZDYfDX+QQGdYsWbCTYnzk3ZWdeWcfmtJvsV2Pe7axbPvmYqU06lAokZpXCSQyT+Sequ
	dP1lM
X-Gm-Gg: ATEYQzwqYl0sUnG+cW7CmtE3UlDbMiey3h1l4SFNKD79WcUAOseFpw0lRJ01fNr44iu
	j0ITJaO2GA1gOeqEsoLxfMijmCVTFgpwjwwRqjudb4z16PFHFRsliWV3h/PHBLUIuyc0PVQbidZ
	Cdgx2ZcyQTAZ3jhCdp21ZpN64eLjFnQK5QxwIDs/AusnK6/I9aveDCr0w3oZqxOa4u338eqDhs/
	2MI8I+ghsjJJYYBCnJxoJhnLPlPbWvJrsoRC9UQyBhnr/3WVPNyXkQnUmb4sajhI+vw+677rYzW
	Zukdoj6p7htwxSvbNyHqcudz6nYUw0lDhGPaGuqC6Ip6GsXK2hI4UYAmu3X/C7AyRBcafkOkrHV
	IvyO/8XJGS1O6Z+PeVhYhVDp+6NSVC2IKTvjSdyYH2uVAmwnzDoxRj8upawnD1KmYJFjtoNUblz
	FrmKhBUa/AFFtzHo8Le91Vr21jQAxnS9Mmv8i7840UJsU=
X-Received: by 2002:a05:7300:cc12:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2c9326a9fc1mr2257328eec.21.1775055214832;
        Wed, 01 Apr 2026 07:53:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net 0/7] net/sched: netem: bug fixes
Date: Wed,  1 Apr 2026 07:51:52 -0700
Message-ID: <20260401145332.78285-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274138-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0B1537D044
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

v2 - pickup the slot related bug fixes

Stephen Hemminger (7):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: restructure dequeue to avoid re-entrancy with child
    qdisc
  net/sched: netem: null-terminate tfifo linear queue tail
  net/sched: netem: check for invalid slot range
  net/sched: netem: fix slot delay calculation overflow

 net/sched/sch_netem.c | 244 +++++++++++++++++++++++++++---------------
 1 file changed, 159 insertions(+), 85 deletions(-)

-- 
2.53.0


