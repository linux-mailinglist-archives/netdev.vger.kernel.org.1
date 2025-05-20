Return-Path: <netdev+bounces-191956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9FABE07F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1125188CB76
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96C26C390;
	Tue, 20 May 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puE4vJB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8C26B2CC
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757965; cv=none; b=Pzw2VxuQYSTzWTRL+pZ6+ZUdPfwB0nWodAVwj69zIVnzRBLJUIpCr82MhPcWML+xZYH4ox8YSUHG7k55HleWyAIzHXqaV/qI24ta+CLtr+2f0oIReL/ZF39Bu60OEMeNrMtpK+dTB7zxpnRMl9t6q3LBrmXbaUQAzg6jz49LBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757965; c=relaxed/simple;
	bh=wxv9AKQjl9WMM4rA7/JIW7WYWolujE/bF85Hotp0w0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WceG2Z8ZLiBikzwS184brmDLSeWDHb10PoNF3mamjXMPOuHpKCvPUxqMpM9wMGPT3PQw+Oa3TcJiOiXKp27PwuX+B6IP98cH58MfL/mfsVS11dlB3EvhBU1Is3aVsPhsOVrvvUZH/aDVpcqxB2s9PQ7njVEz9chtlwJsPMOuq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puE4vJB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B67C4CEEF;
	Tue, 20 May 2025 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757965;
	bh=wxv9AKQjl9WMM4rA7/JIW7WYWolujE/bF85Hotp0w0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puE4vJB+FyZj9mJS/pgcn69mTlk4Q9+H+g6oaxVlXbNq+pRS5q6JJibf2wy2K2WCE
	 gtBVK4CcH0WpkFXHwZw4W46VKrWLPRGaQzX5tzCZ+T5J6f5RIhjXU+c0vzpkCgxYTz
	 a+E1onJGZqqoIeWyp0YSHrTJwgVKeHjtX276WlGTj/UXZBIjAv9aAOYdkCP0S53lgj
	 bJTvLydzQd5jsnIlIlG3puqpcht+uFgD/CYsYJ0EyX+ys6CgbDAhIrZis0GSIRc1Tv
	 sp6zoPhp0F4ioW9i9W8zsAYw48+liSxYVpmaBMaPQ/n81JQu87l+Iga6qBCLyBhLgj
	 UcH4T227yaFRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/12] netlink: specs: tc: use tc-gact instead of tc-gen as struct name
Date: Tue, 20 May 2025 09:19:07 -0700
Message-ID: <20250520161916.413298-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a define in the uAPI header called tc_gen which expands
to the "generic" TC action fields. This helps other actions include
the base fields without having to deal with nested structs.

A couple of actions (sample, gact) do not define extra fields,
so the spec used a common tc-gen struct for both of them.
Unfortunately this struct does not exist in C. Let's use gact's
(generic act's) struct for basic actions.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index c7e6a734cd12..697fdd1219d5 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1186,7 +1186,7 @@ protonum: 0
         name: firstuse
         type: u64
   -
-    name: tc-gen
+    name: tc-gact
     type: struct
     members:
       -
@@ -3457,7 +3457,7 @@ protonum: 0
       -
         name: parms
         type: binary
-        struct: tc-gen
+        struct: tc-gact
       -
         name: rate
         type: u32
@@ -3480,7 +3480,7 @@ protonum: 0
       -
         name: parms
         type: binary
-        struct: tc-gen
+        struct: tc-gact
       -
         name: prob
         type: binary
-- 
2.49.0


