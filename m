Return-Path: <netdev+bounces-180995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D766FA835ED
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB69E19E7446
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A361D9A70;
	Thu, 10 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFE/or86"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642381D88A6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249635; cv=none; b=ZZLCSDz4blmOVy2QBciIWFwemKa3YObinagN8L6v/d1fCS83JT8tDyjC+8JQ/0AMK/8Zc7C8s5HawL4kzYqF/enjkhBzF7tgy0gmKL7E6yhnF95J+5iqAUGRfGeKlmd9PkFU5CvVlwsPxjvCjtCr3BMui6L7/FugB1C1JmgkStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249635; c=relaxed/simple;
	bh=R2hc2/Mm4VbD488z4wUPb+sssP4MJRPRpuL7TS21MQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5kZpLf3vb0Dp5AI4ZzZhPkyKQK27PhBAzbd9eFxM4PajqXbTfkF68PDs5Zs2I3wAVZhXqhWc1dSYmt5MCgXtElIsP3I++R/OgXvwYGnZiv5KKIxYg4fgqQ7JHv/Ef9OdZ2K5IqpSrAlYVHRSXnn+q5d3I3ENneAPaV5gMGegKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFE/or86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF837C4CEEB;
	Thu, 10 Apr 2025 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249635;
	bh=R2hc2/Mm4VbD488z4wUPb+sssP4MJRPRpuL7TS21MQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFE/or86BjEjfWBryFD+GOtvNB2SdKNiXFkd1sMBv05c2J/JUTnEWkcAJObC4o8gg
	 Uzve51gTcLr2UMHDqzWFYeaica4ks52JJtIcDoh4169uFglRIabvGevGjkeX6O/ye6
	 62/f7JLy8N4Q1WMwlXEQ6XK4xar6v3ZariNs41XLszJL6B1i9KwsYnUQ7u1K42hmWZ
	 5RFyvKWaK45vwBd0IDoscbCF+f8hLKlfwrRoOpS12Nkm9Yli29dKR5p+mIOY2Vzx7C
	 PkfbPAr7ar/pxkswjjs42cjW8hmbInfAPXeeAVNjgnwFlOzgnmHIjIXYLW+JeGz5Xz
	 IfPT7RHc73e6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/13] tools: ynl-gen: don't consider requests with fixed hdr empty
Date: Wed,  9 Apr 2025 18:46:53 -0700
Message-ID: <20250410014658.782120-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen skips generating the structs if request/reply has no attrs.
In such cases the request op takes no argument and return int
(rather than response struct). In case of classic netlink a lot of
information gets passed using the fixed struct, however, so adjust
the logic to consider a request empty only if it has no attrs _and_
no fixed struct.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9e00aac4801c..04f1ac62cb01 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1247,6 +1247,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if op_mode == 'event':
             self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
 
+    def type_empty(self, key):
+        return len(self.struct[key].attr_list) == 0 and self.fixed_hdr is None
+
 
 class CodeWriter:
     def __init__(self, nlib, out_file=None, overwrite=True):
@@ -2034,7 +2037,7 @@ _C_KW = {
 
 
 def print_req_type_helpers(ri):
-    if len(ri.struct["request"].attr_list) == 0:
+    if ri.type_empty("request"):
         return
     print_alloc_wrapper(ri, "request")
     print_type_helpers(ri, "request")
@@ -2057,7 +2060,7 @@ _C_KW = {
 
 
 def print_req_type(ri):
-    if len(ri.struct["request"].attr_list) == 0:
+    if ri.type_empty("request"):
         return
     print_type(ri, "request")
 
-- 
2.49.0


