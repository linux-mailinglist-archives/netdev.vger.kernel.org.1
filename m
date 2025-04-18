Return-Path: <netdev+bounces-184049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24EA92FD9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D081B631E3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2FA267F75;
	Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyLH2ZQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE93267F6D
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942640; cv=none; b=JWUU1TFlLe7P1c7RQhIQui4sjofvKtDmjPcL0GLx8fCYhqyYwNEt6rfurq7wH9121R6EIhkjkQMIWkWU4N9FrpGk7DV/o6fzA9R4MEoa8lJDDUirXyTHvz/XU+JS8RMMzk6dziuE3B6DgyKEaaW+2ZQX3JRbkXTkv1Qgxv79G94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942640; c=relaxed/simple;
	bh=bnCY7bTmY4BGeKOaV8L5kCUiCbBV8xUgCzgaT+Mznco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVVd/Rc6M5NIQ0VK+tl4WBkMIo9DsuLd4kEfBcSlm5Kp+/qutql3XHzeHA80g3a+s8SfhFYAbh1ag/mErPSV04UlZk8wwKHLeSBhLuPqDmETvtB7fE0I77ZGGlVRZNQFd7MmchclGpe1TWmE1lYHAzqle3shVjQWdWpglrpCEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyLH2ZQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BE2C4CEEB;
	Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942640;
	bh=bnCY7bTmY4BGeKOaV8L5kCUiCbBV8xUgCzgaT+Mznco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyLH2ZQbUi5wq2liDPExVfsHm12ZKIStmM/FV3xekBn7kcMoEG9sbk1WtDcyAiMqz
	 6BmCZDGeZLZX7o97iqli/ej6Hk20efcxAQGDvt5sC3JKaNKSYgpGK1Bcu2ALXZ79Q1
	 TjW7dNGSFMAnRgljQmE819xbOZM4vdqZwBB/mwgDVA0YBR+iLnIYNKqDvEN9s4C6QG
	 vnlfsLMd0rVn9MgpahhfUdlUVi8RPyi9yaX7tn9mPIGUFXXktexGBafSVNLNbK5ot7
	 D1ZeuaVgzkOrumWGxW43+b3g6tbQplZKc2pR8F46VLH60Uh/FxKQuHokFSwZ2sBjIB
	 OsLbmAiPTRQcA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/12] netlink: specs: rt-link: add notification for newlink
Date: Thu, 17 Apr 2025 19:17:02 -0700
Message-ID: <20250418021706.1967583-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a notification entry for netlink so that we can test ntf handling
in classic netlink and C.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 4b51c5b60d95..25f0c3c6a886 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2420,6 +2420,12 @@ protonum: 0
             - gso-ipv4-max-size
             - gro-ipv4-max-size
             - af-spec
+    -
+      name: newlink-ntf
+      doc: Notify that a link has been created
+      value: 16
+      notify: getlink
+      fixed-header: ifinfomsg
     -
       name: dellink
       doc: Delete an existing link.
-- 
2.49.0


