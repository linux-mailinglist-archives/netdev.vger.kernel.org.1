Return-Path: <netdev+bounces-185830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D8A9BCFF
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DBA3BC70C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5E192580;
	Fri, 25 Apr 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTKdqOnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D21922E7
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549009; cv=none; b=bbcJ6jjYteptDCxJznK3BXcst74lxTlRojbc3OpjB3Jilguj3PpuFHhgtvn0BcKjQQS0OaBEGe+eIlLtsOBcp+TE+VRVH3qE6/tXoCr1cXSe1h0iuKugWIzDcT1gf+gObnuIs5jLXx8kclnm9U9YWG07enSI4AftDnTMJ/lodqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549009; c=relaxed/simple;
	bh=YXi39LTIdZctiknR4pnqXNAfAw6V8PasuhBF5KXlwOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmIyjhAi1uJH3gvoMMnPkt0VOAIoEaPZ3DCaKUZvTal57u3UKlQtH6n2pJLcLD+bBC3sGxiTOWdnOiRrZCI1NrvE18lwZ8nNSuHnwnBb9po3s1SM8YbgEqnFhs65jMhMF5COHXudLwrSjIjvUxpcBlvpMyCWYQQ2O7OpeYl22dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTKdqOnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1434DC4CEEC;
	Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549008;
	bh=YXi39LTIdZctiknR4pnqXNAfAw6V8PasuhBF5KXlwOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTKdqOnT2dHSdPKbUEO86F+rvSEYiDS9EUKccN0WSSBz2Wi5ID8SajzRyDzfHOhKG
	 F5pWBLSQK1XHAjnfokzjUVlA9UKV+CxEx+iDQhpsC2GjcwCbdviDlGUUszADyQ7JPC
	 i7SPFJdGjTMvLI3FE1c7+JXoN60wmn9m5OmHEKZWmg+NQxdw5vgfwYh2zgoRx29eNx
	 5hyj0Twi4n9NDiJQeJqWeZOxBHBnxAM6pjCCOtxkyL/Kns4cEzMDNq+54RdjxMFFKJ
	 wf2WvWX2zYezmMsNRUIGAD28qOSMddbbtNnWaiG/cMD+vjnQEWL0hQFEW/PGkP5jeH
	 2YGRr9EwfkZtg==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/12] tools: ynl-gen: array-nest: support put for scalar
Date: Thu, 24 Apr 2025 19:43:08 -0700
Message-ID: <20250425024311.1589323-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen supports ArrayNest AKA indexed-array carrying scalars,
but only for the netlink -> struct parsing. Support rendering
from struct to netlink.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index a969762d557b..a4e65da19696 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -747,6 +747,23 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                      '}']
         return get_lines, None, local_vars
 
+    def attr_put(self, ri, var):
+        ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
+        if self.sub_type in scalars:
+            put_type = self.sub_type
+            ri.cw.block_start(line=f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.p(f"ynl_attr_put_{put_type}(nlh, i, {var}->{self.c_name}[i]);")
+            ri.cw.block_end()
+        else:
+            raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+        ri.cw.p('ynl_attr_nest_end(nlh, array);')
+
+    def _setter_lines(self, ri, member, presence):
+        # For multi-attr we have a count, not presence, hack up the presence
+        presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
+        return [f"{member} = {self.c_name};",
+                f"{presence} = n_{self.c_name};"]
+
 
 class TypeNestTypeValue(Type):
     def _complex_member_type(self, ri):
@@ -1728,10 +1745,15 @@ _C_KW = {
     local_vars.append('struct nlattr *nest;')
     init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
 
+    has_anest = False
+    has_count = False
     for _, arg in struct.member_list():
-        if arg.presence_type() == 'count':
-            local_vars.append('unsigned int i;')
-            break
+        has_anest |= arg.type == 'indexed-array'
+        has_count |= arg.presence_type() == 'count'
+    if has_anest:
+        local_vars.append('struct nlattr *array;')
+    if has_count:
+        local_vars.append('unsigned int i;')
 
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
-- 
2.49.0


