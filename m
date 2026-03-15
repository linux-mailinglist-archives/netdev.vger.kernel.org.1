Return-Path: <netdev+bounces-267876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h8yZJX76tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD6228F9DB
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556DE30A5DE9
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66617BEBF;
	Sun, 15 Mar 2026 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JBR90tpt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E229749C
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533819; cv=none; b=tCm5eHFPZN15yoaHzjUOWxI/ayorr8UYcUlHKBRocdVMuA/0O3z+fw/8E5V+sl593yiB5qfU7LVOFSIMSq8FpiuV/fOiDz5QOYQWsGu7PuvnilqeHh9D9XLzMRiGUwJ2QwgWvUF6opnGpf5/7cty9tTXSShOEhdpWV/7CFSKbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533819; c=relaxed/simple;
	bh=eASr7U2YVaDnMQZAr288nuqFHZyDyDOkNGnTWq0FgFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROALlVKpkc6luWVoOmx6UTwWGqrM8UYWEyg4VySIL4D0RY09NwfRujtnDYcgiUXikAmZWG+UVJTYme6z9T/zR0AGfGPQ5zHdrspOsx7AuPC4BrVamEk1eOmY6xeOdsOcWsIgnqMoIa+rchVytmhAexNRX7JuCKJbwQXK+ywHw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=JBR90tpt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso1243446a91.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533817; x=1774138617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQBzP4b71nO+anqvIzhwir7di+Y91TQxPVmrIDCymXU=;
        b=JBR90tptENjmpe94wDdevrD1kOFmT2A5ReqdJcOfaki7ygcY5FbvxpLPQoa0JKdWPC
         /lB9j0+DkxHe8jw5P4stbqXwoAkkLWWcaoHk3DLZzsBFo/G3H6djFyaOEmf7ZCZGh7B1
         YN9I3gNLHgH4t9EllgiG0ksefOSgDTjtp5o+0uGF9LlQGwqVw1gge3NWfNVEVZdBLC2R
         9ElxbQZ0X7spe35hkAcpPTnPARqHQa8iu99DyPXcSAiUt5K8BMvYTDuDtFT5XhuUBr/d
         LOTDTp7TqU6Hu26ZIlfuEpT8jiArk9KftNSllLYphNp/R1z1Gs0i86pWFUyCm04gchZN
         tJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533817; x=1774138617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQBzP4b71nO+anqvIzhwir7di+Y91TQxPVmrIDCymXU=;
        b=bVy7pueGRepBr2nldfFxt1QLLzhLiF1TrrL1iPe3b8D4rRgY98FhnA4rcudVddvCfl
         g/AbjFcSQz4fqL6VXEbGvzA6uNq7kOkSXNj4EEiPCN8LadIqjLs7h7mAJYchSfsM6Jj7
         /B4IiOpLuMapUNnmuzXmRRlw6K1ou5WWQu1VBtFLsYi/XPa1XLZKNVPDn+x93LJpXT5Y
         k2DjARlMGAHCbhMOVgXbVOlj8PpZVYJPHk9onA3KtxNCqrb7UtvaEgSfqPML8EoAZnPs
         qyp0rbdu8osUrxW073udR93F4dIzOXLl1QR2rI/GqTf5Y7NRVZxrgEk9pQU96abXfQMd
         iocQ==
X-Gm-Message-State: AOJu0YyO4bwHM7GBtknuBmKlYCwho6CuWrFFYQ2KtojcyARzXRJyt/K2
	8pCxV6DV0YH0tq0tn/ZyoGQWYI2bWTCgyIWXF3HXudyLV9WuzpetUG8NUC11MfrvzzPfhmshfFp
	ds5c4
X-Gm-Gg: ATEYQzyny6pjDptr79lCgxP/OIupo/LuARC6gl9nMRCntTNFTMfgPGCHeTG1NtWmFBl
	U+5MWaid/arGi3YI8X2mKVoEpbq2K94VRL0Npyoae6LeDeEQGnnswmLUttwEMr5YfJg3WOOSRCp
	bMczBetOKi74tzC54JGoAcY7+WFsETfpRQUpJKq6kJqTLdht7LRH2Z5YbQ0dWbN8G2I9e6Cgl+/
	Dhfg9GzFoq3MsJK6wylqwU42s+bgdLGnh8p6DRhSbXMBY0QbAXnr2Sp/d6hs/cuZmD2tcwLznPR
	ZU2OR2Xyt/sBIgRmi82QED2PmdXdk79Jncd2niSydOZ4mZTxGJ2Kx1oiJSMMDjHJhVFC2RVjbNq
	sepvPgI0I8xRBxEkNwfr7v7dRXMpNoFBvXoDQTKj/SXgZBrTFbr3b8OagBOHcFzOhhyai+91upg
	oY6Z4ygFx9y2/Cq+0XIGZUVInngaQWnh7z
X-Received: by 2002:a17:902:e951:b0:2ae:c5fc:b2ea with SMTP id d9443c01a7336-2aecab1ef18mr87966605ad.30.1773533816849;
        Sat, 14 Mar 2026 17:16:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:16:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 00/10] netem: fixes and selftests
Date: Sat, 14 Mar 2026 17:14:04 -0700
Message-ID: <20260315001649.23931-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
	TAGGED_FROM(0.00)[bounces-267876-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDD6228F9DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The check_netem_in_tree() restriction added for CVE-2024-45016 rejects
valid configurations such as HTB or HFSC trees with netem on multiple
branches -- including examples from the netem documentation itself.
This has been an open issue for over a year (kernel.org bug #220774).

This series replaces it with a per-CPU recursion guard, restructures
dequeue to fix the HFSC eltree corruption, and addresses several
additional bugs found during a code audit.

  01/10  Revert check_netem_in_tree()
  02/10  Per-CPU recursion guard for duplication
  03/10  Update tdc tests for the revert
  04/10  Restructure dequeue to fix HFSC re-entrancy
         (CVE-2025-37890, CVE-2025-38001)
  05/10  Fix probability gaps in 4-state loss model
  06/10  Fix slot delay overflow for ranges > 2.1s
  07/10  Include reordered packets in queue limit check
  08/10  Null-terminate tfifo linear queue tail
  09/10  Only reseed PRNG when explicitly provided
  10/10  Add netem configuration and traffic tests

Tested with tdc on 7.0.0-rc3: all netem tests pass.

v2 - merge new tests into tc-testing
   - fixes only in this patch series

Stephen Hemminger (10):
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  net/sched: netem: add per-CPU recursion guard for duplication
  selftests/tc-testing: update netem tests after check_netem_in_tree
    revert
  net/sched: netem: restructure dequeue to avoid re-entrancy with child
    qdisc
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix slot delay calculation overflow
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: null-terminate tfifo linear queue tail
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  selftests/tc-testing: add netem configuration and traffic tests

 net/sched/sch_netem.c                         | 164 ++---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 610 +++++++++++++++++-
 2 files changed, 689 insertions(+), 85 deletions(-)

-- 
2.51.0


