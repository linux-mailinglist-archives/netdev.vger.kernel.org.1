Return-Path: <netdev+bounces-52252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF07FE05A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B540B21191
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D675EE6F;
	Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qws1/eYA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B265EE6B
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FEAC433CB;
	Wed, 29 Nov 2023 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286587;
	bh=P1BoJ0mtHfkZSveD/M1JKXhg6UwGCu9uN0Id4fIXOno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qws1/eYAmC1Ciu3YphVILSxbqEnTLvtR/mT36JUdQUIv7WFEVFKANdirWm5oBRVCp
	 pufdUf6WP+i9vPNEEtjM+9I3lR9htsL2I7sOcVDy1hE8TXZ1ssj7eNxKWsk23Avuuq
	 01hkgGntCUj02EBSNgehNkjrTAP5+0v2O0sQbfWd6g8DsfYLBScoeTSm55tzG8ujWs
	 4YAdzYxmfippBttmzVQM8Qz4YVKCPjIzNtVVdGcMaL1hyNC3kedyOmNgjZRRi9otYz
	 Nu58TRH2YjIuY/+lUFetpleAFjugQjSL/G5KqPkV5X8/vNxqyf6lBbTX1CGdNDPYiu
	 3c9clooPpG2KA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	willemb@google.com,
	sdf@google.com
Subject: [PATCH net-next 2/4] tools: ynl: make sure we use local headers for page-pool
Date: Wed, 29 Nov 2023 11:36:20 -0800
Message-ID: <20231129193622.2912353-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
References: <20231129193622.2912353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building samples generates the following warning:

  In file included from page-pool.c:11:
  generated/netdev-user.h:21:45: warning: ‘enum netdev_xdp_rx_metadata’ declared inside parameter list will not be visible outside of this definition or declaration
   21 | const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
      |                                             ^~~~~~~~~~~~~~~~~~~~~~

Our magic way of including uAPI headers assumes the sample
name matches the family name. We need to copy the flags over.

Fixes: 637567e4a3ef ("tools: ynl: add sample for getting page-pool information")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: willemb@google.com
CC: sdf@google.com
---
 tools/net/ynl/samples/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index 1afefc266b7a..28bdb1557a54 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -18,6 +18,8 @@ include $(wildcard *.d)
 
 all: $(BINS)
 
+CFLAGS_page-pool=$(CFLAGS_netdev)
+
 $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
 	@echo -e '\tCC sample $@'
 	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
-- 
2.43.0


