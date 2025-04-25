Return-Path: <netdev+bounces-185827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A19A9BCFD
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7903BCFA6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BF18A6A9;
	Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVa84/En"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A6189BB5
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549006; cv=none; b=UIQ/Noorfm6damEk5h/iQMJdKTLS9oq9p7WG6J5tkJJlmUX8dtX6UfH9F27Z97OVQ7GQx8UtPmrB8qLkWJNpAW5RrWC9oWzgsC+/zVvksxSxmQeguDRa6dJGyXFUN2gbS6FydSgjlslTfuk+8WZ8unnT8PxY7EsYKQqWRHLiZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549006; c=relaxed/simple;
	bh=f6jLlIxaXM5o7pkELmS6KQUbgH0w6d5GslQQx2pWcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF3qMDG8BEM6U4ukAcf9U3Ql6l96PaQZlkoSbcqBx5kWKKfW8hhUG2JRRx1pO+erabrT61prBiktc6acaFhsqE5e+IsKgKPbCVNgkB1Fp3XtN8flTBBhKcPmrpwUPidxQB+laXfBc/sdEIaJ0pyypMbzMygitLJoJSgX3OGkZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVa84/En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CC3C4CEF2;
	Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549006;
	bh=f6jLlIxaXM5o7pkELmS6KQUbgH0w6d5GslQQx2pWcn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVa84/EnfU5TtpIxbtc+r5QnV12kTtUAK3KZdv+gDp9QT3+aKuKNzgOpv5w0DQ7pG
	 Xaed1WvSjcRH7H7CaszXBa0AxU9fxSaNwzQSg8NEQpwvX3kHdujWI5HN4suPdud6Rn
	 cwcTQdq6LltSTvgQ1d1dugoUheAa85JADI9GQzm9VGeeefLdNK8/B9i/cmR6qIu/l0
	 LurMEbu/SPpaDDB6msbU+Tu0HayFZ9Oq5iRSmWNTy779OCbKI5bTaanKHXDF99LHLT
	 U0pGb41P+2TW7T2gRm48P9JtF8v06ItE77q30NcCTnKfb4wDQ6+Rclkr3FqDwPcb0A
	 gA16Jnf2wl4JA==
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
Subject: [PATCH net-next v2 06/12] tools: ynl-gen: support CRUD-like notifications for classic Netlink
Date: Thu, 24 Apr 2025 19:43:05 -0700
Message-ID: <20250425024311.1589323-7-kuba@kernel.org>
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


