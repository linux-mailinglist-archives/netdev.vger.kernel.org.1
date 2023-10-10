Return-Path: <netdev+bounces-39692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2E7C4131
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE704281323
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0931592;
	Tue, 10 Oct 2023 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B14+mq9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B73158C
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BB8C433C8;
	Tue, 10 Oct 2023 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696969636;
	bh=XokC6/oYLtqZfJB/YbntCJQILp4syJTZQMWSbm7nnZE=;
	h=From:To:Cc:Subject:Date:From;
	b=B14+mq9OIpFbmweG/2ZO1RU5ShLVoRi9fFc9dKL6hM0RJvctWNCz5AKDm7S/48HNb
	 wfbZPtWNLg12Qb/1pgJ0HuTa7y4dqDpbPGpUrZmE/74BVHsz9xPD0+Hw56LWfdXRIY
	 4FhPfNqJ0fdb4G0/TuVLzM9ti1gGNKFNla3ew46HroifKsyTDWY83CO7AO/yCfauTi
	 PJdniVUHDks9y3ILAru8JZwkvpvcLU3cXaF0bt/Yznpk7o423HMULDeENOQI/uZSYq
	 YpMcKze7EMcLz5PLg8qokYdtS2DvHQAf7j35Rla+kwW2jXtYsbmfW/Td/eF2xwUosH
	 17KYhgpoa3ISA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl: use ynl-gen -o instead of stdout in Makefile
Date: Tue, 10 Oct 2023 13:27:14 -0700
Message-ID: <20231010202714.4045168-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jiri added more careful handling of output of the code generator
to avoid wiping out existing files in
commit f65f305ae008 ("tools: ynl-gen: use temporary file for rendering")
Make use of the -o option in the Makefiles, it is already used
by ynl-regen.sh.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/generated/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 0f359ee3c46a..2f47b9cac757 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -27,11 +27,11 @@ protos.a: $(OBJS)
 
 %-user.h: ../../../../Documentation/netlink/specs/%.yaml $(TOOL)
 	@echo -e "\tGEN $@"
-	@$(TOOL) --mode user --header --spec $< $(YNL_GEN_ARG_$*) > $@
+	@$(TOOL) --mode user --header --spec $< -o $@ $(YNL_GEN_ARG_$*)
 
 %-user.c: ../../../../Documentation/netlink/specs/%.yaml $(TOOL)
 	@echo -e "\tGEN $@"
-	@$(TOOL) --mode user --source --spec $< $(YNL_GEN_ARG_$*) > $@
+	@$(TOOL) --mode user --source --spec $< -o $@ $(YNL_GEN_ARG_$*)
 
 %-user.o: %-user.c %-user.h
 	@echo -e "\tCC $@"
-- 
2.41.0


