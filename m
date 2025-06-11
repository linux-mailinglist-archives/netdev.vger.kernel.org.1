Return-Path: <netdev+bounces-196704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2295AD600C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E11A3A876B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FE235348;
	Wed, 11 Jun 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KTGAP0oJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E1210F44;
	Wed, 11 Jun 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673666; cv=none; b=VdhLCjlGZ96kY7r2BYjodCjAJp/Y5edAQPrMbJ1YUVa+1XzAoYm5qRhcCFfBWR+fqGIvrJmGR1kDELlAU/3TZ3ADhj/m7p3VbJlFU3yzuyypI3QrHkxLjQWEV0Cykan0jwSeCfXq5fmiJXgtXpwjg4aPIXarJudMaVGf5ftGdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673666; c=relaxed/simple;
	bh=MU8Zi+pntPYytdt49KNwDwq4ACCf3lHI4qQsBgK7E6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qd8o+onRBPh6GAu8RFql6jbvYWcKiU/BafGOJcF9bR1JR32k+K0cuUrx0pjz62cRaO+0PipPyattUWvFxS7kiP124eIg6444SRo+GLVhKjMx2bPsDxgo+Za8PObujsz9xIJ1uvjqxUkDsUuQ6xWasUa2A4eUdV+sfFIv2QgYJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KTGAP0oJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZW-00BKls-1R; Wed, 11 Jun 2025 21:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=d1QaSFHfEh3cM2Uv7I3zUqxXFc1eWwgg2qbFxn/xMxc=
	; b=KTGAP0oJ7ZLO4T+XONPBBuZ8nO5acq803LvkagTvlFsHLizXcHUUNHkwSl4x+PGiPriobqTJk
	u7/5LM2t7Zl5CEIFaelft39YuLdSwumZCY01r/tWC+BAHHYS+URDpJtzj/HtTIDwyFW7WPlV4DuCw
	tPOvDs0TGlQfuKlKAT0WeYMGAJr20p7ETXT+X9AM8seNzlgFswC2upqvafnuOMRUD5MVjvDRQSQXC
	XwEGj38a2lelMCjiMdrAjvju58mc60qkIdxrWcwwSgCHHsjmurFyx8trG98niAVYf4B1o9oO7ViPV
	+mDGsjgI2VFjP7GN0mqQDw0b8KAAtHdJX4d1AA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZV-0005DR-G9; Wed, 11 Jun 2025 21:57:17 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPRZH-00BycS-19; Wed, 11 Jun 2025 21:57:03 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v3 0/3] vsock/test: Improve transport_uaf test
Date: Wed, 11 Jun 2025 21:56:49 +0200
Message-Id: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHfSWgC/23NTQ7CIBQE4Ks0rH0GHqVFV97DuCg/tcQEDBBS0
 /TuEja66HIymW82kmx0NpFrt5Foi0su+Br4qSN6mfzTgjM1E6QoKMcBSgr6BdmmDM5r0KGAksg
 lojJqlKQO39HObm3onXibwds1k0dtFpdyiJ/2VljrGyyQH8GFAYN54oKOl54pZW5RhfWsQ8MK/
 gPyEECgIOdBCNVTI0b9A/Z9/wLGVSFF/QAAAA==
X-Change-ID: 20250326-vsock-test-inc-cov-b823822bdb78
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Increase the coverage of a test implemented in commit 301a62dfb0d0
("vsock/test: Add test for UAF due to socket unbinding"). Take this
opportunity to factor out some utility code, drop a redundant sync between
client and server, and introduce a /proc/kallsyms harvesting logic for
auto-detecting registered vsock transports.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Drop "RFC" prefix, rebase, amend commit logs
- get_transports(): don't look for a symbol that was already found
- Expand testcase comments, clean up the code [Stefano]
- Streamline `enum transport` and `transport_ksyms` [Stefano]
- Move KALLSYMS_* defines from utils.h to utils.c [Stefano]
- Link to v2: https://lore.kernel.org/r/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co

Changes in v2:
- Speed up: don't bother checking EINTR or respecting timeout on connect()s
- Introduce get_transports(), warn on unsupported setup [Stefano]
- Comment the code, drop the sync, introduce vsock_bind_try() [Stefano]
- Link to v1: https://lore.kernel.org/r/20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co

---
Michal Luczaj (3):
      vsock/test: Introduce vsock_bind_try() helper
      vsock/test: Introduce get_transports()
      vsock/test: Cover more CIDs in transport_uaf test

 tools/testing/vsock/util.c       | 80 ++++++++++++++++++++++++++++++++--
 tools/testing/vsock/util.h       | 30 +++++++++++++
 tools/testing/vsock/vsock_test.c | 93 ++++++++++++++++++++++++++++++++--------
 3 files changed, 181 insertions(+), 22 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250326-vsock-test-inc-cov-b823822bdb78

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


