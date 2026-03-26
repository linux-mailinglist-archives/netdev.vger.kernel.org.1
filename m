Return-Path: <netdev+bounces-272192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EElxCOp5xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:24:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFB33A068
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0542C304C7EB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BF39FCA8;
	Thu, 26 Mar 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="w5KZ3q9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0352848A7
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549032; cv=none; b=GpBSz4wc1IxrZgOCDlg14rz3QccRpKZsIpea37FUGQ5BUDhEC8iLv3HgZUjWyZ5SwFAIr0QokHOdq/9AF50Ye5XLDBac2GUjoOOPIHZ+RcyYwTpafeqENutARa5TT9Ta5e1n3wbjqDTtSVbymMkfLet4FeTEGW3BEYY5xGmDNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549032; c=relaxed/simple;
	bh=Qo5Cm4PCGKHqP3PTyQXFXIsqArS9qV9odeX5q/iHOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcj11g2twPFk68LIcCB2LUSezjkKwvHhDig8jQ1GGfLxSuCSXU4EPy0Ndb3pJgknWROsW73Ql1hWWMO5EhN51gPs9cEJ2eUOsLlMEiM5NWeU65xlrh6WKmdCwphaCftxJE1MSuPI75L3YhBGMy8pv/kH/jrT0qo6dGlr9STIIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=w5KZ3q9K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad617d5b80so8466635ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549030; x=1775153830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFxlBVx5yscJEg4lFLZYL2roAG0vg1jGmC9bdNCeta8=;
        b=w5KZ3q9K5vyCOpncYXaZ03vJ6aUVj5bBAF4Dge6CvoEZ4bAKABhEblmMOJEb9vxC1b
         mUN+e7vyasxaAn4kxP3aemDt9YooWYalwHhKtpK0rJBr4CNWeesa5eLnRQ+Pxd30wFHX
         FDOq9FLgfeE3Vs/RKqlMhaEWvp2HOoy+Pfapu8mcxvaHCaVns++z6gUZLpLgX3Wt68Lv
         piOmThlDXHXFMet8EXCRcHGbAY6yMizw69D5K1dUewIaeSnbrszjsuPKvfHS37q1RIMi
         g6pzSZSLb6Q0Vsdw04LDlEkqxFTpp7SNzQEdmklKU7ynBGeN4J86vVGCUFLoT9Q33Hcy
         9Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549030; x=1775153830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFxlBVx5yscJEg4lFLZYL2roAG0vg1jGmC9bdNCeta8=;
        b=QjwnjFilhdV/H5dsy1A2kKHJ17XaxOL5VDXIJDSUHeqsKDA5qMIbwLipG8fSdc5R/f
         uqJn9cbxcDhG7oFcRzq+CG+oLSIZ0vHa1rU6h4ktWWOnf42RBkzQOpyIdPMBgEp1SYV0
         0Bu75OjOItDbzQhERZy2YqIvfpMfk+rsfoOvjsProSApVkQmbNzdtzXo0knSljy3gz+W
         l8Y4tgE/wKHiWjNISraAKbX8iZhK6q0vUHBTMS7xqyRX6ETx7/eCto7TkmEM4DjNGIk1
         hNqXF08CkYTqbXTS4AHXQIXDuJudgIokdlj3qXsq7kLpsOZ/scLx1A6JHtc0Mq8kZzoU
         Zc2w==
X-Gm-Message-State: AOJu0YwN+btsqgT2M0nObqDt9f3ftoSJppZ1BVo52eKmXDUare0IhDiI
	fWzD+iG8eIIkHUhBDPHo8MBT5SYjSJXawCurTSg4wZcT1a6Yy5rFfWK7n2TorCQUWvbdG/8bKlo
	i3mL0
X-Gm-Gg: ATEYQzw1kdNpyTACiPMNyJD+3m6JEc2ll4+X0T2nbW4E+ERTbvaaQhZjkVJnsyEh8pP
	H3ky9+SV1Px7w4qYtq5m1EvxJq1Pk9E6lN2Huna6mFrRNFpbyH6NCSR8qHfCEqopee5yg6Ixxcq
	a1dQke7DWyoes0r7MSCwRXZcL9XgZK/QlJVzfwYImfVB0C3onbrh+4xlqeFJreS9Mhp1VMIYyy/
	O19zucyVmdVMkgu/tv7ueHBOG06oBLrI5mDqDqnDlSu5FpVIFvibLXUFjVII9rtPINICok8RBLB
	5Wiam+a8PinlOjO8xon6F7/kBA0VRC/MlvSGgO8BgCJIS/kxPAxUR4LBJamGUI8ArmLblZ/pI3M
	4HS7ERLRUt/SCs27Dee5EOC7z570puNZ8Dm1FkYmpyNjaTJfLV49kt+9Cn51+5IDxub5Ismstng
	3NLQ9Zuq5dK4lNthN7QkDOeFOOK9ZLGmKn
X-Received: by 2002:a17:903:228c:b0:2b0:6e8f:8e79 with SMTP id d9443c01a7336-2b0b0adf54bmr95336515ad.42.1774549029619;
        Thu, 26 Mar 2026 11:17:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and netem
Date: Thu, 26 Mar 2026 11:00:59 -0700
Message-ID: <20260326181701.308275-1-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-272192-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2FBFB33A068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This a minor revision of Jamal's series that
fixes packet loops caused by mirred ingress redirects
and netem duplication in stacked qdisc trees.

The core idea is a 2-bit per-skb tc_depth counter that travels with
the packet.  The existing per-CPU mirred nest tracking loses state
when a packet is deferred through the backlog or moves between CPUs
via XPS/RPS.  A per-skb field covers both cases.

Patch 1 adds the tc_depth field in a padding hole in sk_buff.
Patches 2-3 revert the check_netem_in_tree() fix and its tests,
which broke legitimate multi-netem configurations.
Patch 4 uses tc_depth to stop netem duplicate recursion.
Patch 5 uses tc_depth to catch mirred ingress redirect loops.
Patches 6-7 add mirred and netem test cases.

Thanks to Jamal and Victor for fixing this.

There are additional netem bug fixes in the pipeline but those
are held back until this series lands.

Changes in v3:
- Renamed skb->ttl to skb->tc_depth to avoid confusion with IP TTL
- Expanded commit messages
- Split mirred and netem test cases into separate patches
- No code changes from v2

Changes in v2:
- Do not reuse skb->from_ingress (which was moved to skb->cb)

Jamal Hadi Salim (5):
  net: Introduce skb tc depth field to track packet loops
  net/sched: Revert "net/sched: Restrict conditions for adding
    duplicating netems to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net/sched: fix packet loop on netem when duplicate is on
  net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

Victor Nogueira (2):
  selftests/tc-testing: Add mirred test cases exercising loops
  selftests/tc-testing: Add netem test case exercising loops

 include/linux/skbuff.h                        |   2 +
 net/sched/act_mirred.c                        |  47 +-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 6 files changed, 676 insertions(+), 137 deletions(-)

-- 
2.53.0


