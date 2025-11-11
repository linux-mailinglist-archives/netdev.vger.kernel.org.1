Return-Path: <netdev+bounces-237689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE0C4EE06
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2E4E249A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992642874F1;
	Tue, 11 Nov 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss5u53/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550526ED5B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876340; cv=none; b=SR53A5v1w4j0oxLlM9AqvV5Uqw/+UXOyN0Y1aPy6h56fI7Wn1eVsQ2zIy2Vk5nBf1XLQe3SKS1Zaca9mQgnWUOQCt9YNepHaKN7GEnVQmdrLY6YaTw70ynAkHrmXTdGAZS8pJ5jf2mNDfMCb0KBMSsSbTZSix7nb/bnvqQ9AgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876340; c=relaxed/simple;
	bh=BH57U+xI7apJJ8XIr24uI8/HvtjTfVN9mWWLcLL3r5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRXXR40MiT8v1X1Y2Dki7569ygsGznd3kyeojkbsUnrluPunKOrLs+o5fGBlEoExK7RX6Ub+PlhDiagXMbYBDljKKkUeFoP3m7KMmcx6zCMRboClShy/tXuUrlLLG0dJmYVv/m0DGxiuNBW++omsFFy63l5Nkm/PGXkophrdUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss5u53/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A85C4CEF7;
	Tue, 11 Nov 2025 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762876340;
	bh=BH57U+xI7apJJ8XIr24uI8/HvtjTfVN9mWWLcLL3r5o=;
	h=From:To:Cc:Subject:Date:From;
	b=ss5u53/itZC3g9kUe4z0BdHxGFD2Ytphilbl+tPb6eq12det49HZv4XVpYAnRFhXJ
	 JDV3Aht9MdGec9/zlsYYFESYCIfg4wQsFZpyv7MzQb6okBcvLii1XebUj40T63MT5O
	 FWnT+ICDhy3AUiwmktx3BVNMjUWWnViHJQhqsfY7QuPpdp98APQGfuceuuQoSBHGWV
	 P4ZE0N/GHM6ZDWNZG65JQhN+/o5mCSmwxnAiXyaDFQP7vta11tvw46L6WsE6/BuchC
	 EwoDZgI/A0MTqh35R4NJ0mXsH0/tA+YoLvUi4Rm8KGb3lhYgHudPSbq+FBltorzC0x
	 sdsKGWeTYXtBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me
Subject: [PATCH net-next] tools: ynltool: correct install in Makefile
Date: Tue, 11 Nov 2025 07:52:14 -0800
Message-ID: <20251111155214.2760711-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the variable in case user has a custom install binary.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
---
 tools/net/ynl/ynltool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
index 86c30b7420cf..5edaa0f93237 100644
--- a/tools/net/ynl/ynltool/Makefile
+++ b/tools/net/ynl/ynltool/Makefile
@@ -49,7 +49,7 @@ distclean: clean
 bindir ?= /usr/bin
 
 install: $(YNLTOOL)
-	install -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)
+	$(INSTALL) -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)
 
 .PHONY: all clean distclean
 .DEFAULT_GOAL=all
-- 
2.51.1


