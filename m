Return-Path: <netdev+bounces-263320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNELJyAPp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E9E1F3F6B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE22330936C6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830F4F7979;
	Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeCp5FRJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC64F7975
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555713; cv=none; b=BLFlKG6QaexspznD/xO56JxDfxvsS7bByw0WGslkrqxXFeCjdaJWN3Y6b2nmQnsx+ufcwoLvX6dQCOlWdGDNLkkW6X1DS2SdsOD1Bak84h8w+6AC22sMhsbFkHkUbXUen6hi3C7jsxBJso433GfnDJ2W3Sy+12XsWfsTvyfNujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555713; c=relaxed/simple;
	bh=Pd97o6PNL8bJaGUwL4mW3MsME43UwB+VL5sQEI0ZVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmCU/us7e3xMSCPmN46/HfJVC3CVeylHyAwvwRBXjd0683u3RmcEhjQKZNH+13vumTXQ+I3FU6L/webJjRu5W0FJ6Ug2oZG/c3UQe+AXOmX1MWNXtyFwndG8Z3qA0vJSCTW+YyCGZZpwmYbnWsfElD91t8synzYL3+HpKi1RfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeCp5FRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2E9C19422;
	Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555713;
	bh=Pd97o6PNL8bJaGUwL4mW3MsME43UwB+VL5sQEI0ZVUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeCp5FRJ/6TGBZCCKBIIvXaC7NT0mijNdTz7hLM3E65dvLdTzngYAnD0t8cA98V8G
	 QlnTmC+KXY2xqKWUnyVIda3zs3MMSmsyD0enhVqtu2jNUMziJJN5GZ8sl1j0IgCVdg
	 foQUjX3HbHjkTjm60XdKyrXf6tJNZs7mvcuABRLY9GNwzNPGmoRn5ltieIBVj7+OOr
	 ry6VCarggIAQ0QHg5zpA3pWTZOKAlQPv2U/eqJIxIXhCOPJl/TWfJtPL2fsysMw+7+
	 32ZMP13Vma52TMih/OPuOMjp2zr66PTbx3iDSHZpReABm5Ppbpnr4xveHFfrCu8IZ+
	 ivpyOF5st9pxA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] tools: ynl: support INSTALL_PATH in the tests Makefile
Date: Tue,  3 Mar 2026 08:35:03 -0800
Message-ID: <20260303163504.2084981-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
References: <20260303163504.2084981-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3E9E1F3F6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263320-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

We have modelled the YNL tests after ksft to be able to reuse
the NIPA wrappers. Make sure YNL honors INSTALL_PATH not just
DESTDIR, ksft uses INSTALL_PATH.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 5045341300e2..ee717db12dff 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -6,6 +6,8 @@ TEST_PROGS := \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
 
+INSTALL_PATH ?= $(DESTDIR)/usr/share/kselftest
+
 all: $(TEST_PROGS)
 
 run_tests:
@@ -14,15 +16,15 @@ all: $(TEST_PROGS)
 	done
 
 install: $(TEST_PROGS)
-	@mkdir -p $(DESTDIR)/usr/share/kselftest/ynl
-	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(DESTDIR)/usr/share/kselftest/
+	@mkdir -p $(INSTALL_PATH)/ynl
+	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(INSTALL_PATH)/
 	@for test in $(TEST_PROGS); do \
 		name=$$(basename $$test); \
 		sed -e 's|^ynl=.*|ynl="ynl"|' \
 		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
-		    -e 's|KSELFTEST_KTAP_HELPERS=.*|KSELFTEST_KTAP_HELPERS="/usr/share/kselftest/ktap_helpers.sh"|' \
-		    $$test > $(DESTDIR)/usr/share/kselftest/ynl/$$name; \
-		chmod +x $(DESTDIR)/usr/share/kselftest/ynl/$$name; \
+		    -e 's|KSELFTEST_KTAP_HELPERS=.*|KSELFTEST_KTAP_HELPERS="$(INSTALL_PATH)/ktap_helpers.sh"|' \
+		    $$test > $(INSTALL_PATH)/ynl/$$name; \
+		chmod +x $(INSTALL_PATH)/ynl/$$name; \
 	done
 
 clean distclean:
-- 
2.53.0


