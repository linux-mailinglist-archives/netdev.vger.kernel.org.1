Return-Path: <netdev+bounces-52253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2B7FE05B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2B2825E3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9835EE7D;
	Wed, 29 Nov 2023 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7T8Lksd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C25EE79
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64211C433CC;
	Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286587;
	bh=HJkAwUzCcHSDpmbt076xC64L/HORRKbuLH/E0PEtH8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7T8LksdtOeA6WJuM89EqPTbPnJgxM0UlNrnrB6Hgny8yofiIfXJVbXnOwQu8nrtu
	 z2k330LnGtiW/r/qFGek/Yf17rSDJXhB5mAEgQnV2Sv5MUNx7pj91Rkseoh0XQ+ZAG
	 tpUNjZNQvw0e+tqkAuuQqr1el6OBCLuewdlu3aQAzCXeg9thSyUqgHzirurURcDZEc
	 ZN7FTXgQgwDN0V++/3NPSMKEZhpVbQAzhM7T6Jyp3zwh3ZZzYZem9180hJt9X42VsW
	 tvaetWcgSR3c/X2BkQYJyBCc3BeB8nXnqDfrtsUOXvDKibjYVpx5pL6NeydzTVd8bK
	 UZk6ssiRT4Txw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@google.com,
	willemb@google.com
Subject: [PATCH net-next 3/4] tools: ynl: order building samples after generated code
Date: Wed, 29 Nov 2023 11:36:21 -0800
Message-ID: <20231129193622.2912353-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
References: <20231129193622.2912353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parallel builds of ynl:

  make -C tools/net/ynl/ -j 4

don't work correctly right now. samples get handled before
generated, so build of samples does not notice that protos.a
has changed. Order samples to be last.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@google.com
CC: willemb@google.com
---
 tools/net/ynl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d664b36deb5b..da1aa10bbcc3 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -4,6 +4,8 @@ SUBDIRS = lib generated samples
 
 all: $(SUBDIRS)
 
+samples: | lib generated
+
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
 		$(MAKE) -C $@ ; \
-- 
2.43.0


