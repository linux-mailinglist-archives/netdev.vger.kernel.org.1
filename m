Return-Path: <netdev+bounces-135972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10D99FE10
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5FB26DCD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BB3A8F0;
	Wed, 16 Oct 2024 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVq9HOVS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCE156E4;
	Wed, 16 Oct 2024 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041134; cv=none; b=bFeVp3aJ2b8pGZ8/K1nzyL2bj8TYkL5hCerothQbSpX/vZ4frw2291Rn8rFeQm1rpp7Acj7biBBtbzp/8TzeDuJxXFYhLVbD+AFMySpwvmQMNtcP+GiDtV51Cg5oBR5m5Iafg+8DUeThaNhIn2fTgzFwnujr39KJajK/4XX+8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041134; c=relaxed/simple;
	bh=VemgeqR6PLt24NUX7NJuOTaNEAKcqD2LL37deiSOZS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSbDDwTqBTEHXRTqLsyjrZhc22qX9wErMcj16/ydGn1Esl5XfCD/3IB54mRZ2tB5QSNXbdc+e71lnWteYqhmPPdkuxIAGn4c8tp//nk0yRdFC3Yb54du9qSViPvmRCxLjjdGq1ujjX8sjoD9F7a/wAJivYZT50PA078YLBdwmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVq9HOVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E89DC4CEC6;
	Wed, 16 Oct 2024 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729041133;
	bh=VemgeqR6PLt24NUX7NJuOTaNEAKcqD2LL37deiSOZS4=;
	h=From:To:Cc:Subject:Date:From;
	b=QVq9HOVSsVLytn5g1cE0DOfJl3A3Oh6tAMcm7iPpJFya1KSsxH2h6uoTqY7tdYpoh
	 Pz1aVx2jdO0/6igu4M+7LN7ciwk+k3OEu5hE71jIRnuV9C9b1l4lKprgU2vl6f67SU
	 3gdd9cZq4mvmz7FY0VZM7yU9T+z/OWLfHQ2pHEPgUyHW7LwEcIsmAQ1bKvqRojYFGk
	 6vBW01LphTfmDKLeZBi+tA3E9GC7VzFNAcGUSgbX45IFvRgn9r4OnF6kgPI8oXTy6B
	 qLui/fZ22phIpQx2NkZtUCIIEdWd01Sm3WKGLHJJ69rIRcFiu2NUogDRajwije3WB5
	 0R9tUWc5Kq+3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: paulmck@kernel.org
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	matttbe@kernel.org
Subject: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes effect
Date: Tue, 15 Oct 2024 18:11:44 -0700
Message-ID: <20241016011144.3058445-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
added CONFIG_PROVE_RCU_LIST=y to the common CI config,
but RCU_EXPERT is not set, and it's a dependency for
CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
indicate that it does catch bugs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I'd be slightly tempted to still send it to Linux for v6.12.

CC: paulmck@kernel.org
CC: frederic@kernel.org
CC: neeraj.upadhyay@kernel.org
CC: joel@joelfernandes.org
CC: rcu@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: kees@kernel.org
CC: matttbe@kernel.org
---
 kernel/configs/debug.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 509ee703de15..20552f163930 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -103,6 +103,7 @@ CONFIG_BUG_ON_DATA_CORRUPTION=y
 #
 # RCU Debugging
 #
+CONFIG_RCU_EXPERT=y
 CONFIG_PROVE_RCU=y
 CONFIG_PROVE_RCU_LIST=y
 #
-- 
2.46.2


