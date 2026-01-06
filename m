Return-Path: <netdev+bounces-247392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D7CF95FB
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8F730086F0
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F699217723;
	Tue,  6 Jan 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdD/zCHP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B041200C2
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717273; cv=none; b=HHbpdhPpOe9bnJQKN15KG1l/IUOvyBNgEuiYmm6WLwvczIArQ5dAyKG/bGj0j86iTJJsc6AudGrQXbkHOXklwXYhKs+BZ1PWujrXfVJQTuBtqd6aqtIgJRmTO9qYATTaYUFOGEQ6SX94jbeDCqfJ5n5oYQhotVtedbk80yjvGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717273; c=relaxed/simple;
	bh=1R0TtNThQlUi9aB9WSzE1jk1+/sCa0UdWD21gkJ+nCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COuXwRKnK6BlAJ5shz7EjmecJJjt8T2nTqf8v/RBjd3ODQbTzR+VMbfh8KHzLEfQkzCiGQOcTApeUhIoWJfYfDjb1xiuyLEh7wrE6fX7mHEMYfrhs5RvOzyLH5eihX/SY2lV/gbm2j/MU9VA0lI5Gp58uLQy5Jwu9u4xTypfEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdD/zCHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FCDC116C6;
	Tue,  6 Jan 2026 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717272;
	bh=1R0TtNThQlUi9aB9WSzE1jk1+/sCa0UdWD21gkJ+nCs=;
	h=From:To:Cc:Subject:Date:From;
	b=CdD/zCHPaZ3YOAl/jnfuFZ2eecb+UmC6lc/bhH/8mOmEYa8QW20P9uY3n1tvn5uFU
	 B160nJq5klxvtv1Vr4QkYEdApLJv3VdUX8REOnGW5yCcrfO5a403zk45MErBa7Adeo
	 O3NUE5yeMkGgl7B1Yk6jzl4Vd6FsIZlpRlXkq+zsu+Sl7fmGEGWHL2cCIRy1+NvKFq
	 13iXpAHX9AkcpTn4GMg7PE0Q7d/BOsXVER8wB7bWCFB4om/gonviaiAoxlvNTPt+o7
	 W2kjD0TNCdWApWAj4TWykZDFN5ndQCRMFX8/0jfhPB7uczK60VcWMmKGM23iPG1iSq
	 YLelq7y+atGrg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jstancek@redhat.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org
Subject: [PATCH net] tools: ynl: don't install tests
Date: Tue,  6 Jan 2026 08:34:26 -0800
Message-ID: <20260106163426.1468943-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make's install target is meant for installing the production
artifacts, AFAIU. Don't install test_ynl_cli and test_ynl_ethtool
from under the main YNL install target. The install target
under tests/ is retained in case someone wants the tests
to be installed.

Fixes: 308b7dee3e5c ("tools: ynl: add YNL test framework")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jstancek@redhat.com
CC: liuhangbin@gmail.com
CC: matttbe@kernel.org
---
 tools/net/ynl/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 7736b492f559..c2f3e8b3f2ac 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -51,7 +51,6 @@ install: libynl.a lib/*.h
 	@echo -e "\tINSTALL pyynl"
 	@pip install --prefix=$(DESTDIR)$(prefix) .
 	@make -C generated install
-	@make -C tests install
 
 run_tests:
 	@$(MAKE) -C tests run_tests
-- 
2.52.0


