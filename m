Return-Path: <netdev+bounces-188853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E469AAF127
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D661BA3FAC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D31DDA09;
	Thu,  8 May 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHfd0jwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88EF1DB366
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671328; cv=none; b=b61mqYqRMqcVapXAWyffZu9p4Q+M9g/dhlywkJ+Ugmy6IAi120OZ7iNDcJWFnSR6/wcEYsPdPJ/PEi0s07FqVAPS/bxYQ4fJdH4Ns8JK9a7wUzVzMFWLO2GhTFHjDivBZILg5pyhJZzb0YceAkPeKhq93K9rGBCCSVCHjLdWmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671328; c=relaxed/simple;
	bh=RpPy0bLvW0vAOAaqgYz66QW5S/v2aK2/yiay92tFfjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMOi6cRFzEzD2AABFQ5t17RrkaMRLzll4Gx8ytFssY3t2DXdpc7D+rqXDaR15OJMGqHhwiC3nnZCeQxmxIRUj48C+7NKnToPk3E3Hsaz1G2oEJy/AZGDAPL/RMqmw1gWwMTq9vY0TAzn+7QLdvNmSzl9vjQ6DZ9k0oS9GjElvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHfd0jwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2259CC4CEF0;
	Thu,  8 May 2025 02:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746671328;
	bh=RpPy0bLvW0vAOAaqgYz66QW5S/v2aK2/yiay92tFfjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHfd0jwbaRMr777M/5Xard0uNyrobvIta3V3JcjkXSCLmJywYuZkJyecf+Mg8G18E
	 5k6pkQJ802ww1fyXErdkUyjo96HS6uvm9jr27eDDZoD+a0BbjHHmAHtRj4CbFEuVTd
	 4HHvG2S4u9s+PYho1FtfXfTRgaPKC8BYimXPAnlmZgDMO3cE/a7UzpGTK32w4b5qPP
	 DXdeYjLDq0eebGCXn1NBY4AXHy3ndJBvuPgafwJVcMlpPJEcg9zMpNEZtdZAaokUbv
	 pTMjJEOAlDj+ttXOTs3husMIkm5z5mkDk4GhqkP56Z7WtXnZhiW+lQOrSUryIz6qwB
	 ydTkJYgGsu1bg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] tools: ynl-gen: support struct for binary attributes
Date: Wed,  7 May 2025 19:28:39 -0700
Message-ID: <20250508022839.1256059-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508022839.1256059-1-kuba@kernel.org>
References: <20250508022839.1256059-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using a struct pointer for binary attrs. Len field is maintained
because the structs may grow with newer kernel versions. Or, which matters
more, be shorter if the binary is built against newer uAPI than kernel
against which it's executed. Since we are storing a pointer to a struct
type - always allocate at least the amount of memory needed by the struct
per current uAPI headers (unused mem is zeroed). Technically users should
check the length field but per modern ASAN checks storing a short object
under a pointer seems like a bad idea.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index df429494461d..9c6340a16185 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -529,6 +529,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def struct_member(self, ri):
         if self.get('sub-type') and self.get('sub-type') in scalars:
             ri.cw.p(f'__{self.get("sub-type")} *{self.c_name};')
+        elif self.get('struct'):
+            ri.cw.p(f'struct {c_lower(self.get("struct"))} *{self.c_name};')
         else:
             ri.cw.p(f"void *{self.c_name};")
 
@@ -581,6 +583,13 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         else:
             get_lines += [f"{len_mem} = len;"]
 
+        if self.get('struct'):
+            struct_sz = 'sizeof(struct ' + c_lower(self.get("struct")) + ')'
+            get_lines += [
+                f"if (len < {struct_sz})",
+                f"{var}->{self.c_name} = calloc(1, {struct_sz});",
+                "else",
+            ]
         get_lines += [
             f"{var}->{self.c_name} = malloc(len);",
             f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"
-- 
2.49.0


