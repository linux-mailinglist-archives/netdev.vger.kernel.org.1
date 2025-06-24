Return-Path: <netdev+bounces-200842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FBAE7154
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933393AB6F6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234025A2C7;
	Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umCD+tU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34625A2B5
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799410; cv=none; b=OUxFDoxF+Pev9sdbr2wu0kXfX1TA5t+8YZJPSTZScbViRPrL7nfFvQBe+dO8/WUzrCIczG7nDSS5KvmaB5qBtKax0JzWtaRDxwVaczpO6g7NSi4CnLCOaAKAodTBP5mEMBoM+n3CvMvRQrvoILKJ5VDK8Mul+yabCstlMbhxPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799410; c=relaxed/simple;
	bh=hThcuAebSgAVlXPTP/m8X766xGY6NR/QMfjkisRY3Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUjCvQgz+upKVyn/lVwy+oTG7UiFR7UlnjfdMYO8HU6oegdv/6Z7BKoFPCjEQF4G3TFHvTpniUXDgB6J2rifpuWSyocKxL96ncsWzaqf6x9iOASGhEwYzyatOGQ1lu2QAj1pzYXNmKtV39YFB3Udn+LmTyE337kgwRw/+RyPAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umCD+tU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6155AC4CEF0;
	Tue, 24 Jun 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799409;
	bh=hThcuAebSgAVlXPTP/m8X766xGY6NR/QMfjkisRY3Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umCD+tU/f9jqZ/jySgEwxUpa9/guTT6DlHncukfnfmcLo1hPCl7jBtyVqs2hRwvZn
	 4IbeeGQUD7Ik1YVJYlwtDSw6Jp22Y1vU92UNDnCXKMQIurFG9WwM8rWFjrLPv4KOP5
	 1iF21ykAKFNKsXxmhvcSKNIy5bDhfPXsg0w1juKpIOkmDUmhPfXB6d0u/E8cyYQA5s
	 +ilORx//D36VBBnARflJKX6I/QZAShZpaHxYsgMCifue4RGM8uZ+DSavHcBx2dkI/v
	 H71XT5KjZmZH1vXwJcUp3W/CyFZsW5gOYA6+211ejK77mQXVqHLOF33KLdO7nu1L9i
	 ma826BFBINyGA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	kalesh-anakkur.purayil@broadcom.com,
	saeedm@nvidia.com,
	jacob.e.keller@intel.com
Subject: [PATCH net 05/10] netlink: specs: devlink: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:57 -0700
Message-ID: <20250624211002.3475021-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")
Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
CC: kalesh-anakkur.purayil@broadcom.com
CC: saeedm@nvidia.com
CC: jacob.e.keller@intel.com
---
 Documentation/netlink/specs/devlink.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 05fee1b7fe19..38ddc04f9e6d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -38,15 +38,15 @@ doc: Partial family for Devlink.
       -
         name: dsa
       -
-        name: pci_pf
+        name: pci-pf
       -
-        name: pci_vf
+        name: pci-vf
       -
         name: virtual
       -
         name: unused
       -
-        name: pci_sf
+        name: pci-sf
   -
     type: enum
     name: port-fn-state
@@ -220,7 +220,7 @@ doc: Partial family for Devlink.
       -
         name: flag
       -
-        name: nul_string
+        name: nul-string
         value: 10
       -
         name: binary
-- 
2.49.0


