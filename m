Return-Path: <netdev+bounces-197837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E16AD9FC6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE093B56C4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97F2E7F01;
	Sat, 14 Jun 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaQTNpsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BA2E3385;
	Sat, 14 Jun 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749933788; cv=none; b=LXsY/rFa8d2iP3C1IspBw5KrSrLeGULvFDlO0SCA0Bk3Nb9SKVRgeNhOJGKuuu43QFTmdG5cwJ2vVH37SNyQ1IpAkx1zkPNnN8De5KWSXfnBBc/81UNTqmEGWByu0ZsY0qZTmVJbLM6nPGFzDdCgzmzdBrTtwY5ErxfsoKeeKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749933788; c=relaxed/simple;
	bh=qS4oEaHzD7GsPMWS2dQmMO3ZxNs/Q+H8A8oCIx+TqkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwTsr+WjzShDUgWfU9IVk6t5WDv4YbVXv+TMAS+KLjs3V+Nh9n1r4nJ7YdqFZ6kCPO7nDmzIu391VV2Us6owTUwkQNCClVIBe8du78hQwrOg4moUZAdPUKUx5KNOqxSgwQ8LfnWI4rmTF4KB72+v3izSke7dGJQJo2ZK8+AHEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaQTNpsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7CDC4CEEB;
	Sat, 14 Jun 2025 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749933787;
	bh=qS4oEaHzD7GsPMWS2dQmMO3ZxNs/Q+H8A8oCIx+TqkA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZaQTNpsESTKa/UcQz7kmxedAmEVVtBrZUXGhjiQ/YhO7v54om/ZLv4KoAT2M2iFl5
	 insgo1BpypgTHBJyIFSZAxu3EMxofaLgf7+FK4RUgWZeoOTklPToH0ZdKozkCdiEz+
	 YLwsgn+T3R2NilCBKUYrW4WdvJx7/gWT64aC2R0oJ2bzSNX+a1gaLzJdiOzsL1ziow
	 Xg6wcNVoxAEMKQIP40TI3e2cQDtkqE2TLqS2gEvlfHtPCldTLtnhUeiPiYmeAUEwXo
	 Zhf3ChsieekR6JuJrBl+ZIPpNHtwD/wWHPfvsvaHATwZn1gQQch/NmvxPuMIqJgPkA
	 ExHS7dVFPj2DQ==
From: Jakub Kicinski <kuba@kernel.org>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] docs: process: discourage pointless boilerplate kdoc
Date: Sat, 14 Jun 2025 13:42:57 -0700
Message-ID: <20250614204258.61449-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that folks "less versed in kernel coding" think that its
good style to document every function, even if they have no useful
information to pass to the future readers of the code. This used
to be just a waste of space, but with increased kdoc format linting
it's also a burden when refactoring the code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/coding-style.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 19d2ed47ff79..d1a8e5465ed9 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -614,7 +614,10 @@ it.
 
 When commenting the kernel API functions, please use the kernel-doc format.
 See the files at :ref:`Documentation/doc-guide/ <doc_guide>` and
-``scripts/kernel-doc`` for details.
+``scripts/kernel-doc`` for details. Note that the danger of over-commenting
+applies to kernel-doc comments all the same. Do not add boilerplate
+kernel-doc which simply reiterates what's obvious from the signature
+of the function.
 
 The preferred style for long (multi-line) comments is:
 
-- 
2.49.0


