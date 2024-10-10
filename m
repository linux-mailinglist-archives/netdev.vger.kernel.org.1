Return-Path: <netdev+bounces-134419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C69994F2
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B27B21C9C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B831CFECC;
	Thu, 10 Oct 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imYWSHyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A60188CAE
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598113; cv=none; b=G0V9TWFoPr+Ra7LBpBeF/Png6Uchj2HmLtcoYawAEX+WFGA/Gc8ixaN/BKURWWHGH2zTn22pm05HFn4XrVBCFj2A9CUrRIxiR6EQfjpjvs6aAhD56IyA+j+hBHCtZoVQUHuOeqkRiAAONi4K3WfpeVqEmX9+TA/RZDcTbhfP/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598113; c=relaxed/simple;
	bh=Ece54W/mP9qWGA+F3wl87bPLozoCtYXjR3gjBlwOF4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mlkyw+IX8SgoU2Mu1YzOARgQKVUhYkKOEUlG8WP05JoqN6pCUPokVvW3jcC0/vOb0Zq6Zo7N90AoNvWJlq5AtICxb3v8utpAR44+fb89p9TCtPasCkEPkJYdEnoXh31FLzNswgIgWEgFEry9zJbcUo/G6wzZH5e7Qy194mPlO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imYWSHyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24984C4CEC5;
	Thu, 10 Oct 2024 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728598113;
	bh=Ece54W/mP9qWGA+F3wl87bPLozoCtYXjR3gjBlwOF4s=;
	h=From:To:Cc:Subject:Date:From;
	b=imYWSHyCi9sKhJyhK1K67SZuIFWHkKXaJMKsv/UZPh79HL6xQwDRRiwZkGLHsM1tj
	 ENEU7uzJya4EwDe+uK8yAkvFU1jeL7vzjvna4vM6oN/hduEXGpaJMRdrpWRE18uj7i
	 no6q8ni1x7S9b40FsOMIdjYv+Vxmm+w3ZbsYXX6Q3a1bB32WvlWlZ6fymHOd3Nlxft
	 JN0XJ8yJ8XSkZ5EaNl9S2gpJSYk6U8NbnbXgMFlCjyNkcYpM/AEcy6v4ej1oJ0xOk6
	 F9ixcLnTos2XLGsWpyU1a45rhq1dbnho0okRt1ZnppKz5/uAi78rBK2n5WcxIkcb4W
	 oB0AVvxk8gKXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@fomichev.me
Subject: [PATCH net-next] selftests: net: rebuild YNL if dependencies changed
Date: Thu, 10 Oct 2024 15:08:26 -0700
Message-ID: <20241010220826.2215358-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
---
 tools/testing/selftests/net/ynl.mk | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index 1ef24119def0..07bc011e6d9a 100644
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
+$(OUTPUT)/libynl-$(YNL_GENS_HASH).sig:
+	$(Q)rm -f $(OUTPUT)/libynl-*.sig
+	$(Q)touch $(OUTPUT)/libynl-$(YNL_GENS_HASH).sig
+
+$(OUTPUT)/libynl.a: $(YNL_SPECS) $(OUTPUT)/libynl-$(YNL_GENS_HASH).sig
+	$(Q)rm -f $(top_srcdir)/tools/net/ynl/libynl.a
 	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
 	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
 
 EXTRA_CLEAN += \
 	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
-	$(top_srcdir)/tools/net/ynl/lib/*.[ado]
+	$(top_srcdir)/tools/net/ynl/lib/*.[ado] \
+	$(OUTPUT)/libynl-*.sig
-- 
2.46.2


