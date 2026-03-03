Return-Path: <netdev+bounces-263321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK1TKiMPp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 467361F3F73
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56523313C399
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111A4F7983;
	Tue,  3 Mar 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjod4l3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04F4F7981
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555714; cv=none; b=rwEKps4Nw8C/C/KhJ8m5jc1C4pP8rC5c5bxaPLEszslQNKyDKiF6/72NpCvg0Inws2FP/VJtT4Qjly/QAP1NUzgsPT+Z6mX5Lkvs8M02pez8DEmbXFgkYzRbFaPdBV2YDrwgMgE3pfJDcQXk9rDDdn6JnVKsjpbRA9xpjc8ymcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555714; c=relaxed/simple;
	bh=HlplGT/l6PV44oPogvA5atwZJaLKzDi68foBcG3/p64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAHRW1Xnin7HoC26gCCTtBPT5jYtxEvDHimQsUIFRlMsorhpUzdYNPN5I2JbfC5GlsGfAuxA1GY6kUmOcSpSTk+kaFEYVA26lG5w4u1MNhtcxjV9n7RfN0ItMKLaHtZn53hQhkw1oVdyfDAdh8pczXXtQtoWzKtOsUgmUz8iqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjod4l3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F65C2BCB2;
	Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555714;
	bh=HlplGT/l6PV44oPogvA5atwZJaLKzDi68foBcG3/p64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjod4l3IIsF3VLuizrggSOKzjgEVXm9vbmRz/YsJJGeLqiq1cQm0sjnDp2GOUdjwy
	 smL+415Uf6F7nfaqunO2J8kC0ayl7QVlB0zRRAIQgiP9Ct3CVIYE1xA02Bm0Ty7+1s
	 E9FOncDqEIeEIhLjEivJvsmr7JlZeCwEDIP7WkWDSFPOmMq5bF/KuYDKBTwqLCOyK5
	 pihfa58baXrUJYrbEW2K/GwN/9NNZh/bsxvETyIGyv5/pZ8rRpI/tmnzomAPWGE4d4
	 PjOXFe/uIwH/B28QlJuoG9G2EHBDvSi1pkd2BRs9JWuYvFZSvWGU/eNtCAQ+g3ba5k
	 QMe0p++bqvRNg==
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
Subject: [PATCH net-next 4/4] tools: ynl: produce kselftest-list.txt from tests
Date: Tue,  3 Mar 2026 08:35:04 -0800
Message-ID: <20260303163504.2084981-5-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 467361F3F73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263321-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Executors will need kselftest-list.txt so create it when
tests are installed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index ee717db12dff..eb166c9550db 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -26,6 +26,9 @@ install: $(TEST_PROGS)
 		    $$test > $(INSTALL_PATH)/ynl/$$name; \
 		chmod +x $(INSTALL_PATH)/ynl/$$name; \
 	done
+	@for test in $(TEST_PROGS); do \
+		echo "ynl:$$test"; \
+	done > $(INSTALL_PATH)/kselftest-list.txt
 
 clean distclean:
 	@# Nothing to clean
-- 
2.53.0


