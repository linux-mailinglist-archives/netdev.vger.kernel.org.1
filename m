Return-Path: <netdev+bounces-134727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309999AF00
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7161C21590
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8E1D151E;
	Fri, 11 Oct 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIfLyeer"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD71D049D
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687797; cv=none; b=d7sH4qdsDBDFxweWOWjEZLVTg9/6K5ERUOwWynziT5hcQipKknyIDUyZ8OdVWq2GgJp4hB5vRT89SJkZMfxUCgSmhQ6pFR66bmtQsOjXhd9gaELwYTZlwr/MbDmPY+Kjpwxc9EKwswBrXmauSPML+j7RITT4WKsOGLaoXvZp9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687797; c=relaxed/simple;
	bh=qwbp9dDov6OLftlst/qfGoIZ1uSZher+ccmeeGqmftk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amkFspbMQ5lrep3mG3MQaiUA0y/FagISmQK1+9OnIPTyY/CiauqTwsKr00cW9OqfV/bC5/vO1svpc1871u+oTSGqtbrs6Hgb07DcoB+Ul/oB7ec5ItlM0/LU4393Ia+aguDWwgLkKP2pjapcV5oP4jF4LJm5FzTLdXxGM/D4lzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIfLyeer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA46C4CECF;
	Fri, 11 Oct 2024 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687797;
	bh=qwbp9dDov6OLftlst/qfGoIZ1uSZher+ccmeeGqmftk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIfLyeerIt+RdBxIB0B8Z+yLjoEE7b6fIJmxn270UPLyvp6/HXWjxWIe7/PUUcKR+
	 GK+2MrArI9PoHPlCbtaEZB0hfX679w9PZ+aBCB2BT38KEB+0kwMDyT7JS0uQPcZfQr
	 DD5IecI/edOBnnGHVDl6XlA07ULrgS/WUWgQ3vJlHwQTGl7BDg8rfzZS12EVD7YmUy
	 F7Yp3xCcrKfpVnOjW7N8bMvg+pYguKW0EPW5xER0xB58HcsoDHpS3yX6GvnBYc26ao
	 21Xz1qNNzgO4CHD1eD9+6mtv1iSndJNMa6kL2wGfZIu3ttFOUTjvct1/DbpiNlYVKw
	 rC6dkvdaQTx1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] selftests: net: move EXTRA_CLEAN of libynl.a into ynl.mk
Date: Fri, 11 Oct 2024 16:03:11 -0700
Message-ID: <20241011230311.2529760-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011230311.2529760-1-kuba@kernel.org>
References: <20241011230311.2529760-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1fd9e4f25782 ("selftests: make kselftest-clean remove libynl outputs")
added EXTRA_CLEAN of YNL generated files to ynl.mk. We already had
a EXTRA_CLEAN in the file including the snippet. Consolidate them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - new patch
---
 tools/testing/selftests/net/Makefile | 1 -
 tools/testing/selftests/net/ynl.mk   | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 649f1fe0dc46..26a4883a65c9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -98,7 +98,6 @@ TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
 # YNL files, must be before "include ..lib.mk"
-EXTRA_CLEAN += $(OUTPUT)/libynl.a
 YNL_GEN_FILES := ncdevmem
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 
diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index add5c0cdeac4..d43afe243779 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -33,4 +33,5 @@ $(OUTPUT)/libynl.a: $(YNL_SPECS) $(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig
 EXTRA_CLEAN += \
 	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
 	$(top_srcdir)/tools/net/ynl/lib/*.[ado] \
-	$(OUTPUT)/.libynl-*.sig
+	$(OUTPUT)/.libynl-*.sig \
+	$(OUTPUT)/libynl.a
-- 
2.46.2


