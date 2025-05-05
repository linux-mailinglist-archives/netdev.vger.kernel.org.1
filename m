Return-Path: <netdev+bounces-187778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0369AA99B7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C8616B747
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415E268FD5;
	Mon,  5 May 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raVlz6mq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066826771B
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463940; cv=none; b=ChVHRvaHSOF+ImH/EHcwex/yxcHhz3i5i+n2cWuzddIgmd2wu617zzdV6o6i3fcFLCtrgH7r3UJg3PkC7rPrtu/jXJUPO7c4F42uEXVaCCvvO9WRtHhMVuRAOQEu2pcFMSuJByFbdrRtOjRPhPVOGUKY5TiU4e98ykAH1pdN7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463940; c=relaxed/simple;
	bh=k1V/jcVz/y1+kY60jVhOOfVLoRRy6qPcGkR3Ype9hoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Csyx9xYU8eInmZcDpfGkmly/rQ3Eay9ms0KHhAu++DYf6P4Kn4NNdXq13X40FkykwN0exVTB9S/qFGEMDz37Ol1OnSElHY1aj0OE+z7rLdhdQNdpz+75fdYxZpxu7fggoKWuBDzYZOYtrlquOxrokuMYQ/FabrteBUcSlLhmNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raVlz6mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E873AC4CEEE;
	Mon,  5 May 2025 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463940;
	bh=k1V/jcVz/y1+kY60jVhOOfVLoRRy6qPcGkR3Ype9hoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raVlz6mqvEqy1s9nr1PCEdn9COx+vxyZfNUcS61AEADypwgLC7Jo1CSP44FRASbPs
	 BdPMIjHIHEHgBwIJ9QHbAk8sPoVcH6ZHJl5ihm8nDKVJH8SKxga09/dl2BkhTdnXmw
	 dAIIFF5YZJlAKQpcbJ+LmloqstgTNqMX13XadkDPzlJ0p93bTz4y0/PqRTsGtbB1uZ
	 UVNsYPwNPHtj9cL25hPN1tJbUiXGsJE+bZ6M92qyP+nIL5UD8Drtxs1pyk4cVbvk/v
	 olF4h8AVW8ubZeydc2AaxHPhe3d+PSel7jHm5l0AXRmyBY0g8s6gwyIIXUYsRISw8H
	 72zZIDwLso/0A==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tools: ynl-gen: rename basic presence from 'bit' to 'present'
Date: Mon,  5 May 2025 09:52:05 -0700
Message-ID: <20250505165208.248049-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505165208.248049-1-kuba@kernel.org>
References: <20250505165208.248049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal change to the code gen. Rename how we indicate a type
has a single bit presence from using a 'bit' string to 'present'.
This is a noop in terms of generated code but will make next
breaking change easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 09b87c9a6908..f93e6e79312a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -142,13 +142,13 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return self.is_recursive() and not ri.op
 
     def presence_type(self):
-        return 'bit'
+        return 'present'
 
     def presence_member(self, space, type_filter):
         if self.presence_type() != type_filter:
             return
 
-        if self.presence_type() == 'bit':
+        if self.presence_type() == 'present':
             pfx = '__' if space == 'user' else ''
             return f"{pfx}u32 {self.c_name}:1;"
 
@@ -217,7 +217,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         cw.p(f'[{self.enum_name}] = {"{"} .name = "{self.name}", {typol}{"}"},')
 
     def _attr_put_line(self, ri, var, line):
-        if self.presence_type() == 'bit':
+        if self.presence_type() == 'present':
             ri.cw.p(f"if ({var}->_present.{self.c_name})")
         elif self.presence_type() == 'len':
             ri.cw.p(f"if ({var}->_present.{self.c_name}_len)")
@@ -250,7 +250,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if not self.is_multi_val():
             ri.cw.p("if (ynl_attr_validate(yarg, attr))")
             ri.cw.p("return YNL_PARSE_CB_ERROR;")
-            if self.presence_type() == 'bit':
+            if self.presence_type() == 'present':
                 ri.cw.p(f"{var}->_present.{self.c_name} = 1;")
 
         if init_lines:
@@ -281,7 +281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             presence = f"{var}->{'.'.join(ref[:i] + [''])}_present.{ref[i]}"
             # Every layer below last is a nest, so we know it uses bit presence
             # last layer is "self" and may be a complex type
-            if i == len(ref) - 1 and self.presence_type() != 'bit':
+            if i == len(ref) - 1 and self.presence_type() != 'present':
                 continue
             code.append(presence + ' = 1;')
         ref_path = '.'.join(ref[:-1])
@@ -2183,7 +2183,7 @@ _C_KW = {
 
     meta_started = False
     for _, attr in struct.member_list():
-        for type_filter in ['len', 'bit']:
+        for type_filter in ['len', 'present']:
             line = attr.presence_member(ri.ku_space, type_filter)
             if line:
                 if not meta_started:
-- 
2.49.0


