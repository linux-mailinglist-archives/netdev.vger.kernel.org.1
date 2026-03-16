Return-Path: <netdev+bounces-268316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPSxFTSJuGksfgEAu9opvQ
	(envelope-from <netdev+bounces-268316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:50:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7712A1B72
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EA8315643F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3848377EA5;
	Mon, 16 Mar 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0hrTIGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0079377575;
	Mon, 16 Mar 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701113; cv=none; b=of4wQOnLbRG2g9C33zKMeO/1uSY9IPM4j0C2fOcRaovU2EMthUJ/5/tTd5ZP3GP40anSlLdrfsgsOAq8SGo9Mu+zEXxnb6uJYlRVqMTNDPcwNPvIGKRXYe+yMegoLI7Ee1j86i+4tpD83gdha4qUDdhllqczFK76y7cbl8IfTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701113; c=relaxed/simple;
	bh=0sqywE3OZJ1/hZ7YhT0MaHvx4kTn/UJnrWinCgnLjSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiqyCg/ZGmFJRbR3xpN1xp1uzEi0DmIP0Ev4hIZCiFNTbg0By8Uuro8aknq7OpUwImi6fyPT767FCNAgg7BoR3gYNZvYKDNUitznA+270Vmd0K8rLDXPMZxZf4aUZsVWhs9BLZmCm55/1VdUZzEMKXibn5MntKEbrsOV7ohoy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0hrTIGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D60C2BC9E;
	Mon, 16 Mar 2026 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773701113;
	bh=0sqywE3OZJ1/hZ7YhT0MaHvx4kTn/UJnrWinCgnLjSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0hrTIGlnWittZddl5x0gr0bEHcCdLhtnt1EhrPe4DRy0nr3znuH3aW4DGJUAN8kb
	 xCEqpcsvlmFhTOwK459zMW4fA4A+KL0LjpSR7Oe5QmU55XKlsVWj3bLDDThGyGaSdG
	 YjaKpatHcJOBBlGF8p585/9mDHeRqkc4D0MWBydXbCrNrSqfM8bKemxteR5hBk6Fcx
	 NSiirTfH/FVCUqIAAaE7wG1FH3FAgHcgtTtZiQQmJ0BEQ89T49nF/3Q/35MPPuOVK9
	 a1cNmBgc+eCMjswRVX243jHN3MU4Nf/Fo0Jsa1voOg5zCq3Ewnr+M9ajjncUppH3CC
	 AffgA5sizRJKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	mst@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/6] selftests: net: move gro to lib for HW vs SW reuse
Date: Mon, 16 Mar 2026 15:45:00 -0700
Message-ID: <20260316224505.279672-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316224505.279672-1-kuba@kernel.org>
References: <20260316224505.279672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-268316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: AF7712A1B72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The gro.c packet sender is used for SW testing but bulk of incoming
new tests will be HW-specific. So it's better to put them under
drivers/net/hw/, to avoid tip-toeing around netdevsim. Move gro.c
to lib so we can reuse it.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


