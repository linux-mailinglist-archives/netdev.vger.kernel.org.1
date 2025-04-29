Return-Path: <netdev+bounces-186782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2797AA10DF
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37BC1B67F2D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067B2417C5;
	Tue, 29 Apr 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyspYP/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91D241697
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941635; cv=none; b=mtaUqHOxFDLboMQ/TECcBKaxOS5/zRPFv829hSYHDU2WXKK+BtnLvh67qTt/Bkk7tg/oqm7fEWj8UK47JxPM8SBdKH5kamuXkHw3/866UZTfjaU2uDSBcxLiUYhBS47DwBEc6B+jEMFxdYkUcbjEpoFl5QUXUND7ZRCt+301Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941635; c=relaxed/simple;
	bh=7XykclKn0yVuXdyXubA4+rlRTnnb6ND2R616isB5Jao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvbvIdpx7hclrV3GO5ctOJDWu/QT/t4xY4Ij15tfTBO9UjwE0S+9I32/dmQTekdb36POICJBpm7fJ8czKiH3vvMpIekev/MKwUdWJ0wiNriW65t0H4+8NHZtbx6MP3/HLlYBmSxLJ6XUBX2awPw2gddOHEjpYdiyN1zHamZ00Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyspYP/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D225C4CEEE;
	Tue, 29 Apr 2025 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941634;
	bh=7XykclKn0yVuXdyXubA4+rlRTnnb6ND2R616isB5Jao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyspYP/67GPvfLxy7YhKqcykT/PG25rxCv87MbQaqE9wbENLwoADVGx+pvCamz1bd
	 fIBYofBztE55UQHm5JsrAxwLL3FJsWQ/Z/DKppdkzZltBtFAbxA8mpaDk6Dp/CffF6
	 kpD+G/HSnBwcXmaJGndskaCG9RJIIQssjq4dsgZVk2Kg2G+OqBzvlVHGwS4XW6Hmlx
	 TBF/nV8VJnXRMaS1uLsUFmT17fKOwyEMcyRtmCee7DAHbrDs+nQ/2Cdur0bDep3d9k
	 gLDrX3oICBT2dkvlnvMJH89EXSlWs/IhWwnyEPSA7SmkgVnH313+vPS3fOMYQlO080
	 dU1FwGuZJCpXA==
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
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 06/12] tools: ynl-gen: support CRUD-like notifications for classic Netlink
Date: Tue, 29 Apr 2025 08:46:58 -0700
Message-ID: <20250429154704.2613851-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow CRUD-style notification where the notification is more
like the response to the request, which can optionally be
looped back onto the requesting socket. Since the notification
and request are different ops in the spec, for example:

    -
      name: delrule
      doc: Remove an existing FIB rule
      attribute-set: fib-rule-attrs
      do:
        request:
          value: 33
          attributes: *fib-rule-all
    -
      name: delrule-ntf
      doc: Notify a rule deletion
      value: 33
      notify: getrule

We need to find the request by ID. Ideally we'd detect this model
from the spec properties, rather than assume that its what all
classic netlink families do. But maybe that'd cause this model
to spread and its easy to get wrong. For now assume CRUD == classic.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0febbb3912e3..31e904f1a2f0 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2787,7 +2787,11 @@ _C_KW = {
 
 
 def _render_user_ntf_entry(ri, op):
-    ri.cw.block_start(line=f"[{op.enum_name}] = ")
+    if not ri.family.is_classic():
+        ri.cw.block_start(line=f"[{op.enum_name}] = ")
+    else:
+        crud_op = ri.family.req_by_value[op.rsp_value]
+        ri.cw.block_start(line=f"[{crud_op.enum_name}] = ")
     ri.cw.p(f".alloc_sz\t= sizeof({type_name(ri, 'event')}),")
     ri.cw.p(f".cb\t\t= {op_prefix(ri, 'reply', deref=True)}_parse,")
     ri.cw.p(f".policy\t\t= &{ri.struct['reply'].render_name}_nest,")
-- 
2.49.0


