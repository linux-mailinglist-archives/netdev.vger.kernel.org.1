Return-Path: <netdev+bounces-190882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B6AB92C1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6F1B62B2D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E66293449;
	Thu, 15 May 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsxCWqcs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDF29291F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351029; cv=none; b=mAJagM/Rhg71dLe4NxmvuZF3Hh/29hpCJnF1DGfKG0aO/FoO72R8CeMscGdfV/5Ftwy80dR5aQQH1hmoGYAwsJl+RaLRQfhRKD6CReHC5JN0J7HVTnGXVDwW5VwJzg3LLHSf7HkUPh5zxGr2cFXGW6UjSMzaJsCAYMB7u2sQTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351029; c=relaxed/simple;
	bh=SpWSTzRDJAjaIiZrEmhChDP1tfUagyP7SutfJ2Y2W1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoezSIybKDo22UoncsoQ7r6CMYc2AsJYAkK/SCn5efTWDTquVdLV8wohgECIRUuXcNqkjb9dV8+W20EJnbqNAOrZijvtb8tLtVzM7eoRaxquS0a9Tn/tgzm1PJZKNauEL7csGrp1g9EHkYamXDcLxyWR64zdnh4wczaoYu1qHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsxCWqcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7B4C4CEF0;
	Thu, 15 May 2025 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351029;
	bh=SpWSTzRDJAjaIiZrEmhChDP1tfUagyP7SutfJ2Y2W1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsxCWqcszji+XwIKX9RNdpfuMaNk9vynjvGlwS41mVgE0yJuxauBIiJk/x/8IVA9h
	 iogfFo42RgxSyPg5/WTfAO+rePAgteRzXVPiSdfms8+8AESFZ4ILGtaW4xdPN7x/5N
	 2REO0pCZneAB0IcbfJrOddnzgDppKCwQlzsqm6dG05Z+yuO/LumRAIBHJBGK/JKI7J
	 fU8oK62j23/ysn3IF0UmHTbQrB88cqiG7hUF7iYbbNCHv84bc0LcXoO25wkz+K0rqE
	 mRKtmamPxRhYdp5rvS3ndLYwR6UbNA6v3uBg7iE8YtP9h9ehusU2XZsa8I2VptHNNc
	 FZbyyCVsw0DLw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/9] tools: ynl-gen: submsg: plumb thru an empty type
Date: Thu, 15 May 2025 16:16:45 -0700
Message-ID: <20250515231650.1325372-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook in handling of sub-messages, for now treat them as ignored attrs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/__init__.py |  5 +++--
 tools/net/ynl/pyynl/ynl_gen_c.py    | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index 9137b83e580a..71518b9842ee 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
-    SpecFamily, SpecOperation
+    SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat
 from .ynl import YnlFamily, Netlink, NlError
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
-           "SpecFamily", "SpecOperation", "YnlFamily", "Netlink", "NlError"]
+           "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
+           "YnlFamily", "Netlink", "NlError"]
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c8b2a2ab2e5d..2292bbb68836 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -14,6 +14,7 @@ import yaml
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
+from lib import SpecSubMessage, SpecSubMessageFormat
 
 
 def c_upper(name):
@@ -872,6 +873,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return get_lines, init_lines, local_vars
 
 
+class TypeSubMessage(TypeUnused):
+    pass
+
+
 class Struct:
     def __init__(self, family, space_name, type_list=None, inherited=None):
         self.family = family
@@ -1052,6 +1057,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
         elif elem['type'] == 'nest-type-value':
             t = TypeNestTypeValue(self.family, self, elem, value)
+        elif elem['type'] == 'sub-message':
+            t = TypeSubMessage(self.family, self, elem, value)
         else:
             raise Exception(f"No typed class for type {elem['type']}")
 
@@ -1096,6 +1103,16 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.has_ntf = True
 
 
+class SubMessage(SpecSubMessage):
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+
+        self.render_name = c_lower(family.ident_name + '-' + yaml['name'])
+
+    def resolve(self):
+        self.resolve_up(super())
+
+
 class Family(SpecFamily):
     def __init__(self, file_name, exclude_ops):
         # Added by resolve:
@@ -1178,6 +1195,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def new_operation(self, elem, req_value, rsp_value):
         return Operation(self, elem, req_value, rsp_value)
 
+    def new_sub_message(self, elem):
+        return SubMessage(self, elem)
+
     def is_classic(self):
         return self.proto == 'netlink-raw'
 
-- 
2.49.0


