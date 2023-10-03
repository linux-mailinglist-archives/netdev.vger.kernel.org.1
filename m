Return-Path: <netdev+bounces-37730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934F7B6D3E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1D9AB281CBD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98EFFBF3;
	Tue,  3 Oct 2023 15:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442F37164
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41329C433CA;
	Tue,  3 Oct 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347276;
	bh=qJ+WAxZQln7FvkqbzSm3At+d5QRQNkbxknPP7HOsSxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDjLWlfp+RsW6e4jIWIjgTTYWXP9ktxibbzEZ5+3OUzNqZ2nF7JHzuPA3Ajz4hZCA
	 9NINy/nPJDQKEZ2Hu5RTJ4K8jN0OaWWbqyzwnLZx6A4CX1R/v2cATRKbqEHkAC2trt
	 ZIOh9jYq/dkx1HL5OYApjwkvYA5DV4Q/5JGF8550Te8M5y48UljJ319o4lGWKzsNMq
	 5mQYwqQy0D9ItbtZtqBJ0KduaFpFsuwf6s3Yqmyu+rvmpAamwbmd0y4Dw+opd2k1lB
	 vb4wCy0yYDOnO1otbSgmEGzj7DTjQKh4ven8t/N9q7hoNanitcuRefmKovUVxqyHJ1
	 Wn7M6GDv1dUAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@google.com,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] tools: ynl: use uAPI include magic for samples
Date: Tue,  3 Oct 2023 08:34:16 -0700
Message-ID: <20231003153416.2479808-4-kuba@kernel.org>
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

Makefile.deps provides direct includes in CFLAGS_$(obj).
We just need to rewrite the rules to make use of the extra
flags, no need to hard-include all of tools/include/uapi.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/samples/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index 32abbc0af39e..3dbb106e87d9 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -4,7 +4,7 @@ include ../Makefile.deps
 
 CC=gcc
 CFLAGS=-std=gnu11 -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow \
-	-I../../../include/uapi -I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
+	-I../lib/ -I../generated/ -idirafter $(UAPI_PATH)
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
@@ -19,6 +19,9 @@ include $(wildcard *.d)
 all: $(BINS)
 
 $(BINS): ../lib/ynl.a ../generated/protos.a
+	@echo -e '\tCC sample $@'
+	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
+	@$(LINK.c) $@.o -o $@  $(LDLIBS)
 
 clean:
 	rm -f *.o *.d *~
-- 
2.41.0


