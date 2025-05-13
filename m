Return-Path: <netdev+bounces-190268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EBBAB5F40
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1821167CC3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47E1F9413;
	Tue, 13 May 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taSwjS/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8C53365
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174816; cv=none; b=qydw4pEOKBePF0TjRNg2pR0l+yXEtqQw4gYJTmH3mdUieKt2nwWjQ+64i3ICF0mTw5n4YnnDXA+qDA1+o7OYQHt5+KmOeo0/BGPfNMYB7AySxPBht8EJLxuqC3gOqQt+Np+ZID4Qf4UYY8S//nHOGxn0HXNbVPUAgaEhtrBM9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174816; c=relaxed/simple;
	bh=WPPN7fPYfchc/GTpTB5BvV8M/s/sbrvYCRihiP16ZHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uE42J14GUjw0GXef7GiA7stupW3NexeItglEYR4ovBLNCAhcznsHP53J0mQILQqflTGQRj7Y2OE+C1InrshhKFCu5p+DOSs2hZbG9BdfzhN/M1+5tlbXLUEVUyBRs+gwBDRWXA7MhWh/wMOwoQJnhaPYmmDMN0hAXgLap0iPyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taSwjS/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6FBC4CEE4;
	Tue, 13 May 2025 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174813;
	bh=WPPN7fPYfchc/GTpTB5BvV8M/s/sbrvYCRihiP16ZHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=taSwjS/e5uPMHYP44ZdXuYb/o+88JZbVHCfW644dka+q1pig0UJaFpialtpiDMyHK
	 r1saLYZ4mp2yihkUMmeAp+nMa7wOd2tmL+erKBjayb7BjfKZeK4W25NB1w2YAjqdlM
	 T1ST580yl5IoA4EvNiRbGJWL1OAix0zdAIFt6JK1i+T+d72GSy7ZStSsyzxOP59aRy
	 9+0+v+t9NMITEZEOPc7OHYSKXjAmRJW8vU+sSoKPTUgNHTZ3MF99GbwliYgs65qi7F
	 i32lyh9qMQbmcS0gEmGf4vBOyKV3BkVcg46HtMgtGLlaj7fVpMBGqHGBfqmYR8RTkD
	 i4TzRAelFIZGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com
Subject: [PATCH net-next] tools: ynl-gen: array-nest: support arrays of nests
Date: Tue, 13 May 2025 15:20:11 -0700
Message-ID: <20250513222011.844106-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TC needs arrays of nests, but just a put for now.
Fairly straightforward addition.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sorry for trickling out random changes, I need
396786af1cea ("tools: ynl-gen: Allow multi-attr without nested-attributes again")
to reach net-next before I post submsg support. Otherwise there
will be a conflict.

CC: donald.hunter@gmail.com
CC: jacob.e.keller@intel.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 3b064c61a374..cd150d704e28 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -825,6 +825,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif self.sub_type == 'binary' and 'exact-len' in self.checks:
             ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
             ri.cw.p(f"ynl_attr_put(nlh, i, {var}->{self.c_name}[i], {self.checks['exact-len']});")
+        elif self.sub_type == 'nest':
+            ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
+            ri.cw.p(f"{self.nested_render_name}_put(nlh, i, &{var}->{self.c_name}[i]);")
         else:
             raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
-- 
2.49.0


