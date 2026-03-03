Return-Path: <netdev+bounces-263319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCd5E2QPp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:42:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36551F3FB6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F4FC30A25A9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D34F796B;
	Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSsS7bZU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B44F7968
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555713; cv=none; b=jTf1KKmgRbWwsWB4LQMA/2bdtKHcgFSKPaqNDWDxTl1YTQTvPbElDLrJLj8hp85JdDiCiO8gbVKGZwB6xEAUHd5mKVwSNp90gtNqZO+VInGGp4SM0rxYa854aBci5fDThc5RSmUO1iNgkIU54i2cW9kcH84AiOfwa0h4JUrczsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555713; c=relaxed/simple;
	bh=ty0BBQ1YXGhKJpNbHV8J3KZ3VU+7rmQak57fG0mQpZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww8gd/SuQbhC7RwONaaJDuGTbT2vD/DaddQ/jJm+cXwTtypqcp8EARj/Ri+2li64axx7jcUIUtWUYFqQyDCME1UPPmD/6zRF3GhwhVxZPBZQMbZFtoS5iy2IYLIzh+1HY+L+B+ML6pqw1YAWdg1rHdl4T4BrPuuVh4pkV0jw9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSsS7bZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F3C19425;
	Tue,  3 Mar 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555713;
	bh=ty0BBQ1YXGhKJpNbHV8J3KZ3VU+7rmQak57fG0mQpZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSsS7bZUk1RO+eEhXcqAcD9f0b0EHT/cDlaYbKeaLGDZgySU1Tc+3Oexsz49x7UFk
	 qwzWO7eGkeTgxIanLwr+B5eca/Ts76JRpLxToJQHfBRmgpJQiyehj42QNkwaNq6syp
	 ZYuZtmOEDECQuhPPDTs96wDAx+t3u3rc9aD50ddrwMTBoUetTBxu7PSWh2CdqwSF1w
	 FV/RVL2XxCW4tm2WRquAK02kc3X9I/fl+qV0NYV1VYJYv31TdA2f2c6gD0ee/7vd/D
	 vhuMoiPD/pOLXVVShHXLykF/+XUj3vxGdL1rW7on09q34dBJ29SgrWbQCs/gXY6/eW
	 DX4LKn+F/ccOw==
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
Subject: [PATCH net-next 2/4] tools: ynl: don't install tests in /usr/bin/
Date: Tue,  3 Mar 2026 08:35:02 -0800
Message-ID: <20260303163504.2084981-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
References: <20260303163504.2084981-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B36551F3FB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Until commit 790792ebc960 ("tools: ynl: don't install tests")
YNL selftests were installed with all the other YNL outputs.
That's no longer the case, as tests are not really production
artifacts. Let's not install them in /usr/bin at all, and
mirror kselftest format more closely:

For: make -C tools/net/ynl/tests/ install DESTDIR=tmp

tmp/usr/share/kselftest
              ├── ktap_helpers.sh
              └── ynl
                  ├── test_ynl_cli.sh
                  └── test_ynl_ethtool.sh

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index ee4362ca286d..5045341300e2 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -14,16 +14,15 @@ all: $(TEST_PROGS)
 	done
 
 install: $(TEST_PROGS)
-	@mkdir -p $(DESTDIR)/usr/bin
-	@mkdir -p $(DESTDIR)/usr/share/kselftest
+	@mkdir -p $(DESTDIR)/usr/share/kselftest/ynl
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(DESTDIR)/usr/share/kselftest/
 	@for test in $(TEST_PROGS); do \
-		name=$$(basename $$test .sh); \
+		name=$$(basename $$test); \
 		sed -e 's|^ynl=.*|ynl="ynl"|' \
 		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
 		    -e 's|KSELFTEST_KTAP_HELPERS=.*|KSELFTEST_KTAP_HELPERS="/usr/share/kselftest/ktap_helpers.sh"|' \
-		    $$test > $(DESTDIR)/usr/bin/$$name; \
-		chmod +x $(DESTDIR)/usr/bin/$$name; \
+		    $$test > $(DESTDIR)/usr/share/kselftest/ynl/$$name; \
+		chmod +x $(DESTDIR)/usr/share/kselftest/ynl/$$name; \
 	done
 
 clean distclean:
-- 
2.53.0


