Return-Path: <netdev+bounces-274682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFUOMc3Pzml/qQYAu9opvQ
	(envelope-from <netdev+bounces-274682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119A38DE78
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EB7302DF65
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B96384232;
	Thu,  2 Apr 2026 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="gQuQmyMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189C2BE02A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161246; cv=none; b=YDAZTQI7wmxIKPegLgRPXqSaTYyNNPuo1WiQ3A2xgNThIFKzxh76+OpVvhz5FqBCRo5uZ69Wbl9tvoCHJ0EcaTWI+ACU6w9X7tB0aH0HZjFH4Brv7jB7WUrNvGDRO6pExsBe7mbR8L5zd3VsbwZtj872IDy4C0zGGE4UwVw2/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161246; c=relaxed/simple;
	bh=KXZeBdhJblW4V3V8vbE2JQwq3+obVX3Qz0T+6aZYetw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mW/CIV5tfe5tqtDTehIYgwcVo9Qv4IjiR1V/pR7v0vQuBrGeeYp+RO8mVu3pz3MjmS/6kBb9kuj78OS0c3bUlyamHfc4LJwOEsOllllDkaSvnzEo2D1agvCZ5i70nT1nDhMSJMRBEFkGb8PZhWEPTKAassQd5xWt7m1GYJMHfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=gQuQmyMd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35c206f0481so1164748a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161245; x=1775766045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZuPSgFoYyVg3JOWNho7OlPmlJypLyKccFEN799V1sQ=;
        b=gQuQmyMdq3yRoWF+uST0wvZNt4LPBngmEE+mqiG4vQoB1ZVzh07i4XE6LMWYLoQ5AL
         rRJOGArza0iF6b8vdflCSWvElXBZxOAkFVT5DWsa28637Cc7DYUrtP+KdMkZfhUx/OON
         3/Wt8SlpjaQ31ZS+5BICHNdhfT0lNDAYA3XmxS5Qhz9UfppGM/rfjkJk0AH1cVezgbfm
         d0oCor14npkbA02FSloHyV1wjk94yuUmbAfkUgPTiWXpEotQOhXdhzTfbD5ZMziZfZD8
         wbZryuXiavuMhBI/5biSHrors/P3aiKW/PblzyzX/M0D/NlXhcegNRAzh1Od18mq+A+H
         h7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161245; x=1775766045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZuPSgFoYyVg3JOWNho7OlPmlJypLyKccFEN799V1sQ=;
        b=hbmzDam+wSIW34oXcXa4LVurjQ0bQGX46mlvClO6yXQY2DU54+kpT2OSnqi927MOwC
         B20QZTs8ac8sh231Z6IITHlQ2j4iMxUzZ/WPwt6wWl+rA74vBTJ7W+Ypbf44v15b8T0+
         uejzl9wy0lEAUaX5TsyGDMxzVQa8lWzk8i423JWx9U9/6WVYLWLWqazR3DqKZjU6l3Ln
         0jGqrmIC+uJS8A8jY4QA+VqDeoK42C+fhrOfqNtY8/lL2pwjF0zl6knJBawhy6eRFvXj
         T8qmEXLR8RFEkdjNyCfpw1bxKp76Ix94+PLVMzsc4h+jInXxBavmDQ5itUkDSPu5X+8r
         //cw==
X-Gm-Message-State: AOJu0YxC9kuwJHZ153sJFygOktWNLSjnxcJ1geSQWwUIkKEz1DHJEnW+
	uMcX0DXIPlAi/zLszLcj/Pbt28wq+Yk2OaPFReKreE56AUKO284YIRuuJM9NtRSFjf/bGO5tbvQ
	PMheZ
X-Gm-Gg: AeBDievieVR6lnCTDU2TLHCFm1G8go6e7+uviEXIJPV6Frx3pN+L+BIE6YdqBIPK3Kj
	/gDu2n3h8ovfkyQuOHS/H6MgZuoRbByJ4LGXOHx4/j21XhaeQq2sW+P6bpcCv9scCJqnV0wZbzZ
	eUD+Qaa6VuApFZ9AF5mWpLwPI5ynzPUWg5pDWFpTVN/ueLwA2CJ5Ece+LiyaY0T1nrg+e6MGVm0
	3Cen9hGdhANV8aDw0PEJugxfH3IeG9d66YachtmyPIgxamzSbQJpxtVJBv8PjIbnDf9XKO0ZJFe
	lU//YJZzC6F9b9cc3AaFW+x+UHY5ZPJAS4wR1rJaN/FVEBPJf4taHn5KoE2HVxQ6Urm+mPwdoGB
	b9nkn+a6Aa00gipoOkg9GqN6tFXf5ZsXyzmr3WUFu0Qu8MOVnO457d72gb7ibr6Dp0S6/AO3Hmq
	/qT/dcVYd3LmwcSn6JG2dgc+B4JX0pCTcL
X-Received: by 2002:a17:90b:4fc6:b0:35d:a299:7150 with SMTP id 98e67ed59e1d1-35de68ce8f2mr290003a91.16.1775161244782;
        Thu, 02 Apr 2026 13:20:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:20:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v3 0/7] net/sched: netem: bug fixes
Date: Thu,  2 Apr 2026 13:19:28 -0700
Message-ID: <20260402202037.176299-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274682-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4119A38DE78
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

v3 - fix blank line after Fixes:

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

 net/sched/sch_netem.c | 245 +++++++++++++++++++++++++++---------------
 1 file changed, 160 insertions(+), 85 deletions(-)

-- 
2.53.0


