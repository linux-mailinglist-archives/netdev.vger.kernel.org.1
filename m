Return-Path: <netdev+bounces-37729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE127B6D3B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 094B51F20D6B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778837147;
	Tue,  3 Oct 2023 15:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C73FBF3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B9AC433C7;
	Tue,  3 Oct 2023 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347274;
	bh=U7UwCnJNHkRUFf5osaZ7CxOOvaUPx43nkZJd/Vg+/dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ri0iYAkA+q6ro/CgOQUx3uhpEcCk2KTE/cfjpzCJv8jaybgdzfEoIBZ5w3trgTlVQ
	 b3iM2knG9dJ1Dk5fzSZ+qSjTucrnCtnSl88WncqT9i2IEQBqg8DhTRl0V+rP6vr84j
	 ZWQ7n7veoEybztp3noOIT39OK8VpH2fXABdIDOs7lD8YYVEoArKd9juBgnqulXFh9E
	 DMt9ZK8TKQXFgIPGrbSJzPEN6ZjAN3T2uUeyk3L/XyblIc8Y3dt2WdDkjVNPCD5S6Z
	 XKnFa9tQ/YHu1l9h9zJam2cF3EDL+JS2NKh+A98DXx3yj0+rxOMOb3KtFekqQaFEeI
	 dBbzQXA2iRJBw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@google.com,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl: don't regen on every make
Date: Tue,  3 Oct 2023 08:34:15 -0700
Message-ID: <20231003153416.2479808-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003153416.2479808-1-kuba@kernel.org>
References: <20231003153416.2479808-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As far as I can tell the normal Makefile dependency tracking
works, generated files get re-generated if the YAML was updated.
Let make do its job, don't force the re-generation.
make hardclean can be used to force regeneration.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile           | 1 -
 tools/net/ynl/generated/Makefile | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 8156f03e23ac..d664b36deb5b 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -3,7 +3,6 @@
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS)
-	./ynl-regen.sh -f -p $(PWD)/../../../
 
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index f8817d2e56e4..0f359ee3c46a 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -19,7 +19,7 @@ SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
 
-all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) regen
+all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
-- 
2.41.0


