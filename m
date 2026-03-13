Return-Path: <netdev+bounces-267603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOUXBMt+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:16:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C128A13B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F98300A7EB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F25366DDB;
	Fri, 13 Mar 2026 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xHrLuRMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4032D0F5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436616; cv=none; b=Acraqys93lUchvm38m6vU8HXzToc6G86Xq3U4XjgGT5MvjIPCQR8jhTI2EJPw6WBhzVkFep/slBoEO7XVvblTzkFHoEzQtEwgoKXeWf2OBxLVG3Bd7Hk2mP5zNsptS7NFv4kR4gL/eY8YOIlThKP6JfcdIVUQOtlv8KbGHaNkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436616; c=relaxed/simple;
	bh=eQfIYN4GbvFu6UA9ULp8eiVff//t+eMqXCXbSvrRc+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfZz30Jz64MlKr2j/Pvkg/NGdX/ZvkRCYe48reGQoxavUPheBJAgcCrRUe+hazGBO/YOg+y4kEkp3RVFccImse3mu8ZbPUEyKqaPanQ7FNZSX6QzV6g/j9JdrF7J0kzIMUlpPMPHiS0mevbEtQfrsWgOhjeNpxLM/L5K+ZgnVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xHrLuRMf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaed195901so13065515ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436614; x=1774041414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuqBXdlXf4e+rC//lnngpZombr90MC18ngsqsjbpz5I=;
        b=xHrLuRMfMz6F+lc0re7XjuV1UZ7suOTumGKwqIkn9XWiwxOuoqnkzmy5qITUBvujRd
         mJUlJHnD6BFgOD4m0tXjv8xPg3ohSw1lruV3VDADSyDThhcUDBVK7i3rwKVKtSnxIRZ/
         wG+HkGApQnSDgWpL/4rnuA7oJbdfiS8svUY4rUsDdJN4AMsalh4KibfWZ9P+YdFWl4b8
         YViiqxfOlzUPLrUwAbPuVguXYfgsHkJsX/qTd+aCNCzvK3xdX+We4RpVRHmZVgpbqxiF
         AGdMszMz0JumikIGQ7WPSqmaYKCQV5CtyqnhF+TJd+UtNgQl7ZV6syvb0jFhLiOPCStU
         kkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436614; x=1774041414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuqBXdlXf4e+rC//lnngpZombr90MC18ngsqsjbpz5I=;
        b=Wm5/Pcx9lYrATEdVz5ptdAWTKK0J+WZ7Nx6It6JDA6zTgMX7TUmLdwL8mZt+0SJ3Mh
         OcqzKWJ+42/OTEblIfZOtGRCflHO0HHcTQpCx8jAsczclbG/ipv8CCbUIE4bh9fzQEXK
         9Eu6Y4t2ICJMY7CaP/L2urSKE+RcX9u/jmdlXFQlaqYU4bVzLCCPRuNbIFNur10huk1x
         4vUUuzkKcnMipAiYzDqoawF1TNYX6MU0QpW1ONsdv84sxKbakLBHZjCr0Kd6bBiD9mVU
         nxkr80lVdkJ9s+lDyxozfWEymhJUxXHdxHOU2tP4xQXNeX+OhYxR5sXmhznZIrpxapQL
         AzNg==
X-Gm-Message-State: AOJu0Yz+mMA7iFbZyezZFxZe96RoRcdUF0gty2p1vT4Gt9Y+Tr2YlEUo
	R02gc2TalLQmGtvk6nYxNbLujCIJbea4BcRH82h51vYAIlefp5v+cso4T1tAFHG6O25ZHYruayi
	0U1uePlE=
X-Gm-Gg: ATEYQzymNfM1eJyAdoMq58FrRPeMyDO/eiZ4AXkOtgx1mnr+9pGqmaV5Ag5DsHU82nn
	uDn4TN4Kd7tyGoYU+MO0I001TClBEMhfglpNdjI9LsQb6IQG8Okuk9dtOTK/AlZpa2we/oFLVO/
	2yZPXWgx7uWyrBhK1WRS8mqSypik+WAscEkSboo0uHiDQEQYIOjsVmR/gYp6d9M9ooRImZ+eMTm
	lhFPsX77pY2BImYAjoKLUQGXvQOU7CqRz7t26dvM1JLjD2DD9kg0ixutS/tWbH3LSnbz0yx8S9H
	TLe1IWhrx0VRALaKWqEfu2o2uqawfQbUFD5i6no/ZMMuCGBVFEEG/NL0TobX3h6K+ovdp0ReG2J
	JubmIYMlZYEfIUJCIBVeIvzeTITJ4scfmN+7GwTCQrJosxdxAYGbe0LFIpkOOXqyAX/UvKqRfVQ
	/aIw0G/4Z5OWNuVAhI3siZp1nhBE72OfDx
X-Received: by 2002:a17:903:104a:b0:2ae:a624:cd57 with SMTP id d9443c01a7336-2aeca92c3c5mr30803675ad.7.1773436613356;
        Fri, 13 Mar 2026 14:16:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:16:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/12] netem: fixes, cleanup, and selftest
Date: Fri, 13 Mar 2026 14:15:00 -0700
Message-ID: <20260313211646.12549-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267603-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid]
X-Rspamd-Queue-Id: 588C128A13B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netem packet scheduler is widely used for network emulation but
has not gotten enough of my attention lately.

The response to CVE-2024-45016 introduced check_netem_in_tree()
which was a clear regression. It rejected valid configurations
that have worked for over a decade -- HTB or HFSC trees with netem
leaves, including examples from our own documentation. A fix that
breaks existing users to paper over a bug that only occurred with
hostile misconfiguration should never have been merged.
Several approaches to undo the damage were discussed over
the past year but none landed, and in the meantime we've
accumulated four more CVE's and user bug reports.

The kernel management style doc says "the name of the game is to
avoid having to make a decision" and to "not get ushered into a
corner from which you cannot escape." Well, four CVE's and a pile
of user bug reports later, I'm in that corner. Time to decide.

I sat down with AI (Claude), reviewed the prior discussion, and
put together a working solution. While I was at it, I had it do
a deeper analysis of sch_netem.c which turned up several additional
bugs that have been lurking for years.

The series:

  Patch 01: selftest covering basic ops, multi-netem trees,
            inner qdisc combos, and crash-resistance scenarios
            for the CVE topologies.

  Patch 02: Revert the check_netem_in_tree() restriction.
  Patch 03: Replace it with a per-CPU recursion guard -- the
            approach that was discussed but dismissed prematurely.
  Patch 04: Restructure dequeue to eliminate the re-entrancy path
            that causes HFSC eltree corruption (CVE-2025-37890,
            CVE-2025-38001).

  Patch 05: Fix probability gaps in the 4-state loss model.
  Patch 06: Fix slot delay calculation overflow for ranges > 2.1s.
  Patch 07: Include reordered packets in the queue limit check.
  Patch 08: Null-terminate the tfifo linear queue tail.
  Patch 09: Only reseed PRNG when seed is explicitly provided.

  Patch 10: Move state enums out of struct (cleanup).
  Patch 11: Remove useless VERSION string.
  Patch 12: Replace pr_info with netlink extack messages.

Patches 01-04 are the CVE-related fixes and should go to net.
Patches 05-09 are additional bug fixes.
Patches 10-12 are cleanup and could go to net-next if preferred.

Stephen Hemminger (12):
  selftests: net: add netem qdisc test
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  net/sched: netem: add per-CPU recursion guard for duplication
  net/sched: netem: restructure dequeue to avoid re-entrancy with child
    qdisc
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix slot delay calculation overflow
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: null-terminate tfifo linear queue tail
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: move state enums out of struct netem_sched_data
  net/sched: netem: remove useless VERSION
  net/sched: netem: replace pr_info with netlink extack error messages

 MAINTAINERS                          |   1 +
 net/sched/sch_netem.c                | 219 ++++----
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/config   |   3 +
 tools/testing/selftests/net/netem.sh | 802 +++++++++++++++++++++++++++
 5 files changed, 923 insertions(+), 103 deletions(-)
 create mode 100755 tools/testing/selftests/net/netem.sh

-- 
2.51.0


