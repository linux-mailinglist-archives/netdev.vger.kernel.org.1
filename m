Return-Path: <netdev+bounces-257668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNkvGP+IhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F310453D
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22EB3056153
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEF225A3D;
	Sat,  7 Feb 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzksweL8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB7221F1F;
	Sat,  7 Feb 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424519; cv=none; b=Bjr1Pkx2rhG6xbv72C1ZQ1G7hRYrfnMleBI5ZVt1iizAu8doLjwgvXpm/BSq61SJIb/taezbjk5zjfRlMKvyVmTbUOnohw2mifUAcUTVxcxZOns7Yk2qhItO+J1pMYcqm80shykgYaEpaQyAmCtCqKvIXS1+IJy5c+3kME4yJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424519; c=relaxed/simple;
	bh=DbyS2k5rztlqTZWs7e1DMavW9jIObJ+iKAMewPfvMJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFycjsYBeFLsLZU3Y6DY5BG1PGu6ZoTIz6DYBqwNJ84iU2JEP3Pq3Yoy3VzCLykLUS14MJJwfqPKsG3D8fyTIzotGmZ9SD62QSR61bbeFwcsq8MyqiHoIByLZxzthLlfu3Xqdciq8ZX7fl2stC0zQexzUiYi3jr+cdk6xcc+aBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzksweL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7F8C16AAE;
	Sat,  7 Feb 2026 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424519;
	bh=DbyS2k5rztlqTZWs7e1DMavW9jIObJ+iKAMewPfvMJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzksweL8pLrNjgejOI8noa1wXheRI5HGFGVtrX4PP9XV+OymRKznFBEDJC3c8Lm4R
	 JZP1B6UsPAmNNg4PRTmffZELB4u8x3KgHV2OE1PaaHzOcsR3DoKripuzeocs5TwHig
	 UZtKE5c99S3acE0mhZg131yWpfSNIndBY8aRYH8GBg2hawhYS3YMddJJevE2jps2hJ
	 ZpKllTUm102t3ACnaFZQuJrSPWXoG6/Hwtcvzt6QZwk5gm5jy187OhOXMkleJP7C+c
	 xjUmWG7bHmuGxgOXJlEisUF5UBK17E3GRrgq/gWqu31gYNfY0AtJy4XrjS4SfJLdsn
	 QLdPxm812WAhA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/9] selftests: net: move gro to lib for HW vs SW reuse
Date: Fri,  6 Feb 2026 16:35:04 -0800
Message-ID: <20260207003509.3927744-5-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257668-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,lib.py:url]
X-Rspamd-Queue-Id: B43F310453D
X-Rspamd-Action: no action

The gro.c packet sender is used for SW testing but bulk of incoming
new tests will be HW-specific. So it's better to put them under
drivers/net/hw/, to avoid tip-toeing around netdevsim. Move gro.c
to lib so we can reuse it.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile           | 1 -
 tools/testing/selftests/net/lib/Makefile               | 1 +
 tools/testing/selftests/{drivers/net => net/lib}/gro.c | 2 +-
 tools/testing/selftests/drivers/net/.gitignore         | 1 -
 tools/testing/selftests/drivers/net/gro.py             | 2 +-
 tools/testing/selftests/net/lib/.gitignore             | 1 +
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/gro.c (99%)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 8154d6d429d3..7c7fa75b80c2 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,7 +6,6 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/lib.sh \
 
 TEST_GEN_FILES := \
-	gro \
 	napi_id_helper \
 # end of TEST_GEN_FILES
 
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 5339f56329e1..ff83603397d0 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -14,6 +14,7 @@ TEST_FILES := \
 TEST_GEN_FILES := \
 	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
 	csum \
+	gro \
 	xdp_helper \
 # end of TEST_GEN_FILES
 
diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/net/lib/gro.c
similarity index 99%
rename from tools/testing/selftests/drivers/net/gro.c
rename to tools/testing/selftests/net/lib/gro.c
index 3c0745b68bfa..02e29509fbea 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -77,7 +77,7 @@
 #include <unistd.h>
 
 #include "kselftest.h"
-#include "../../net/lib/ksft.h"
+#include "ksft.h"
 
 #define DPORT 8000
 #define SPORT 1500
diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index 3633c7a3ed65..585ecb4d5dc4 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-gro
 napi_id_helper
 psp_responder
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index cbc1b19dbc91..2da53686354f 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -117,7 +117,7 @@ from lib.py import ksft_variants
     """ Setup hardware loopback mode for GRO testing. """
 
     if not hasattr(cfg, "bin_remote"):
-        cfg.bin_local = cfg.test_dir / "gro"
+        cfg.bin_local = cfg.net_lib_dir / "gro"
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
     if not hasattr(cfg, "feat"):
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index bbc97d6bf556..6cd2b762af5d 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 csum
+gro
 xdp_helper
-- 
2.53.0


