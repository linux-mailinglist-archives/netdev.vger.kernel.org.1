Return-Path: <netdev+bounces-250507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9904D3069B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7028230E7A42
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336F374180;
	Fri, 16 Jan 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="itdFF9Lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6537418D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562769; cv=none; b=NTYrjhEprY0XsMLvP2yiSVEyt2GvAcnEbjkWQzaZEpr28OpyeRI4sya0Omj1LEMDzy9gLL/5eg7mC4wWf7F4r+exBDV7qQ25eWxC7wtvSgJtY2l8Eh6EFJjlfXcV/0FIY3IlCcp6I46HYPjIQ+ZhBjcExN9gBYGDBxIuWdZQzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562769; c=relaxed/simple;
	bh=zdiHlYJ8NQr9hXbgVZfkBKaaFWpuWlnl/jkpirsAbXw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDFjc63xtQ8Eyf6N7yQtumiJ1u08lyuMu7zzpdinSN3XTmKqIYGstix7U/BBLg/ZNgcuc0pJK2o0jwJ5GirP+YbjpTOy/ZU++8mum/MCEY6HX4r+Aykt0yPHQbX/Tkn4tXq9yeoEN30ZsmV5j54BHYt/NK849uhebClkJtQCnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=itdFF9Lc; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768562761; x=1768821961;
	bh=q9OPNZ3H/4O+lqsQae4dVC4ZnXx8HKyabeUbOeUvzK8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=itdFF9LcULQ6Q8f/ZMtCq6ZhO9Bk3AbnD10geHNpDGIJWemD1mevNvsldXWJjXwSf
	 QQmvEe96SRAhv0/tgLzH7RAEUL3IlPs+QOdvBHx0182FjxN/MtkqawSWS8+vxVvVvH
	 z1DnhigpQbdyTgaSINSWdg3+0SoOIUZzeivOL9CkfmygHHrzRAtK1rL2NWj0ke6Aq5
	 Eq5nQ+Qxspc4IJbwZbsDo1dAH+C9JgbekOIlsTI9LuWY0nglFV5gz8qzcdr97TC9R3
	 2mbh61ve5TxuOztxkib1lXwPvYS9spkOdB670R+kuwQ7+04KIwfx3RBLPhsyyYV4WB
	 sp/9+PGtm/p4w==
Date: Fri, 16 Jan 2026 11:25:57 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Paul Moses <p@1g4.org>
Subject: [PATCH net v1 1/3] selftests: tc-testing: fix gate replace schedule
Message-ID: <20260116112522.159480-2-p@1g4.org>
In-Reply-To: <20260116112522.159480-1-p@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 981d45c83cd46b280db1492083d9aab205ded966
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The tdc test case 3719 ("Replace gate base-time action") fails with:

  Error: Empty schedule entry list.
  We have an error talking to the kernel

The test runs a 'replace' command while only specifying 'base-time' and
omitting the mandatory schedule entries. The act_gate action (and tc
userspace) requires a schedule to be present; replace is atomic and does
not support partial updates or inheriting the previous schedule.

Update the test case to include a valid 'sched-entry' list in the
replace command so it matches the kernel's expected behavior.

Fixes: 4a1db5251cfac ("selftests/tc-testings: add selftests for gate action=
")
Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/gate.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json =
b/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
index db645c22ad7be..67e406e4eba33 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
@@ -131,7 +131,7 @@
                 255
             ]
         ],
-        "cmdUnderTest": "$TC action replace action gate base-time 40000000=
0000ns index 20",
+        "cmdUnderTest": "$TC action replace action gate base-time 40000000=
0000ns sched-entry open 200000000ns -1 8000000b index 20",
         "expExitCode": "0",
         "verifyCmd": "$TC action get action gate index 20",
         "matchPattern": "action order [0-9]*: .*base-time 400s.*index 20 r=
ef",
--=20
2.52.GIT



