Return-Path: <netdev+bounces-12856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B41739299
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718FF1C20F9B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6C1B901;
	Wed, 21 Jun 2023 22:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A31EDC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A247C433C0;
	Wed, 21 Jun 2023 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687386927;
	bh=EWnSd7bjG7PilttbL5ZZpTzcZo8e3vUQoklthxd0EVc=;
	h=From:To:Cc:Subject:Date:From;
	b=IKHFCF5e2D0cFFU4Tg/JNKd+613yz0i7qT+vcb6XRp1cNDYKcBpNVmCQcCCFy0iry
	 cuU9ee1Pzqo6/i/PF4WEdVsxYGxb7WTLvA7ZYotJoZxuH3I+WGlQKXozTfcgYwki88
	 LLOugFruXBP2E2r15PlBMzWTUaizFWJ8F2+qn3NjN7JiSuTu70htbTy2OdM+Dez7fU
	 4Hx5ZZ4Bs3pM6ANyac8pGO8GIvO/HjUd3cuFthjdguT3esRZweqJcWX9nOnJPS5eUW
	 v2noU+NcQapPNwuvDGjWdVzqgcKGqzdrSg2ptXkBMYc6A5/bm2xGjkUdmGSt1ZchcF
	 Sh9Wfvwqbqw6g==
From: Jakub Kicinski <kuba@kernel.org>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	arkadiusz.kubalewski@intel.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH docs] scripts: kernel-doc: support private / public marking for enums
Date: Wed, 21 Jun 2023 15:35:25 -0700
Message-Id: <20230621223525.2722703-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enums benefit from private markings, too. For netlink attribute
name enums always end with a pair of __$n_MAX and $n_MAX members.
Documenting them feels a bit tedious.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Hi Jon, we've CCed you recently on a related discussion
but it appears that the fix is simple enough so posting
it before you had a chance to reply.
---
 scripts/kernel-doc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2486689ffc7b..66b554897899 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1301,6 +1301,9 @@ sub dump_enum($$) {
     my $file = shift;
     my $members;
 
+    # ignore members marked private:
+    $x =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
+    $x =~ s/\/\*\s*private:.*}/}/gosi;
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     # strip #define macros inside enums
-- 
2.40.1


