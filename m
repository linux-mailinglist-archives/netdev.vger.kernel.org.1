Return-Path: <netdev+bounces-134728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD699AF01
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A91C217E1
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920901D1721;
	Fri, 11 Oct 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxDJs9Sa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7F28EB
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687797; cv=none; b=u6wu3eSXgQFviBLaSciO34Lsw0N8MX8C395Z1B1zeshBu/A+riA14LM7W8lIVtdITMLJy4t89QtdadA5+NXc8jo8VeTfjDC0jg0I4RrGOES814HWAQgVl26+1uPz8a7wY/esjbBI/jSxcL9GJJH5IzbX0Wr19JjFh+rWY1NIQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687797; c=relaxed/simple;
	bh=wEoszMBmFN4UafOMeXdT4FosiXT1Cil8+SZNZE6DNlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hv+WyRUnN7skoJGDB3M4soIjOhUphCrc6+GY85yAhrpo1FoMlpHJtyAfG11+fcZbuLLC1jnAgf8jgQTcjyUqnYPgZu+JFitdI2Rode+OOsaUZaekQj2U38zsQw/6Gu9DUf8moNO+5wyvX4gMNmz2a2RsZzrv/PqEIhUzTliIwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxDJs9Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49147C4CEC3;
	Fri, 11 Oct 2024 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687796;
	bh=wEoszMBmFN4UafOMeXdT4FosiXT1Cil8+SZNZE6DNlI=;
	h=From:To:Cc:Subject:Date:From;
	b=hxDJs9SaozIxhxl9e8glJdUDRguBBArAq0czVPd4xTUQpM4QBUf22uOSnn9qJ92yq
	 3vXQcTpyq3ZuxvBrUHjpwrROdsCzsucLtNsf16Ak2Tu5AKTjxTDfTL+dRcu5ejPH9z
	 wjCetF9evyHqzWGOVHl11PQxpKs4FsWHMyE5OAw/mhLtT1DqvOTV9A7QNuti4AmiNK
	 dmS+ziiliiOpaGkdmcufky+2wxBysLguqULSNuwILIz7mHEcNFcS43BZD/9G6JVi6v
	 v4SR8smDctsV4zdlY5IKyQ1K0qWr1NH27240AMJPhgZT1scVQp7X0LzG4Woe8ZZicU
	 fmHiR7T+NdizQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 1/2] selftests: net: rebuild YNL if dependencies changed
Date: Fri, 11 Oct 2024 16:03:10 -0700
Message-ID: <20241011230311.2529760-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Try to rebuild YNL if either user added a new family or the specs
of the families have changed. Stanislav's ncdevmem cause a false
positive build failure in NIPA because libynl.a isn't rebuilt
after ethtool is added to YNL_GENS.

Note that sha1sum is already used in other parts of the build system.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use .libynl-$hash.sig as the name to avoid having to add to gitignore
v1: https://lore.kernel.org/20241010220826.2215358-1-kuba@kernel.org
---
 tools/testing/selftests/net/ynl.mk | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index 1ef24119def0..add5c0cdeac4 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -9,6 +9,8 @@
 # YNL_GEN_FILES: TEST_GEN_FILES which need YNL
 
 YNL_OUTPUTS := $(patsubst %,$(OUTPUT)/%,$(YNL_GEN_FILES))
+YNL_SPECS := \
+	$(patsubst %,$(top_srcdir)/Documentation/netlink/specs/%.yaml,$(YNL_GENS))
 
 $(YNL_OUTPUTS): $(OUTPUT)/libynl.a
 $(YNL_OUTPUTS): CFLAGS += \
@@ -16,10 +18,19 @@ $(YNL_OUTPUTS): CFLAGS += \
 	-I$(top_srcdir)/tools/net/ynl/lib/ \
 	-I$(top_srcdir)/tools/net/ynl/generated/
 
-$(OUTPUT)/libynl.a:
+# Make sure we rebuild libynl if user added a new family. We can't easily
+# depend on the contents of a variable so create a fake file with a hash.
+YNL_GENS_HASH := $(shell echo $(YNL_GENS) | sha1sum | cut -c1-8)
+$(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig:
+	$(Q)rm -f $(OUTPUT)/.libynl-*.sig
+	$(Q)touch $(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig
+
+$(OUTPUT)/libynl.a: $(YNL_SPECS) $(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig
+	$(Q)rm -f $(top_srcdir)/tools/net/ynl/libynl.a
 	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
 	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
 
 EXTRA_CLEAN += \
 	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
-	$(top_srcdir)/tools/net/ynl/lib/*.[ado]
+	$(top_srcdir)/tools/net/ynl/lib/*.[ado] \
+	$(OUTPUT)/.libynl-*.sig
-- 
2.46.2


