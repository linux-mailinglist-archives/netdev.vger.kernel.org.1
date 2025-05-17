Return-Path: <netdev+bounces-191245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814EABA751
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E75168740
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851735973;
	Sat, 17 May 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWhmqLJW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B6339A1
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440815; cv=none; b=t2ODchrTE1Fsu67VHnRpPwZgB9ijjz5GBWbxApqVOVtEljIOAv7rL398W+pDY7hWuOI2UlRZiyqx0d9wX7L032XUvx4wr6NXJvg95gHJ+IIeEkRX8zeDkxBOIIe+TLMkMshrQsAqf3Sl0gVhGjceLqQVaLdGz5RfD04TLuvG8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440815; c=relaxed/simple;
	bh=qwzJv16yb3meOQ2TVHev3i7z77jZR4JsyBDizGsacF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC7OPQQtDbff4U6gGEn501U6Jvn1Qz4rIdDPwtqkruJCzTmHmpkVo0cS+5OaUS0kujED89hUyxWPcAfjsLBQA8fDCF1Z9DbMHY/WE8ybhYQ8r+AbJa9WNPNCiyzfxBsZiPm0tkvQ/JWl30HpwppblmzSdEK9gVFziu5COZJiQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWhmqLJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FCEC4CEE4;
	Sat, 17 May 2025 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440815;
	bh=qwzJv16yb3meOQ2TVHev3i7z77jZR4JsyBDizGsacF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWhmqLJWD6qkcOtq1waXsA2exBuufGHORW0xrBGBC6DdArd+bt9ghoI2eXZJb50Gr
	 6m4MssG++FAOqdcHLX+2AFH7NStouiFtliEQkMe7lmGLAF7iWG6c8ITdUQSJxlUOxC
	 ub3Cga9gaebd98ydN3p92L109JRcUaWsc13vUGYLDkW8P+GZ2ZkrKX/qHVE2aBfpH8
	 G+ln56dO/hEvclc19yaRVgro9gRi8W3zATTsRsG4T+GHCqXiJT4PylfUxp3Xk06IE5
	 yDYsSIEPXvfnCT04Of9Yh6aLZyMRgxJ4NrZEOHjmllFIoCcBSbbZnbM+Iyhiy3q8E+
	 3L0WJFGZwbIpQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/11] tools: ynl-gen: support local attrs in _multi_parse
Date: Fri, 16 May 2025 17:13:14 -0700
Message-ID: <20250517001318.285800-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _multi_parse() helper calls the _attr_get() method of each attr,
but it only respects what code the helper wants to emit, not what
local variables it needs. Local variables will soon be needed,
support them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index bd1fadb2cf5a..f2a4404d0d21 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2214,12 +2214,16 @@ _C_KW = {
     parse_rsp_nested_prototype(ri, struct, suffix='')
 
     var = 'dst'
+    local_vars = {'const struct nlattr *attr = nested;',
+                  f'{struct.ptr_name}{var} = yarg->data;',
+                  'struct ynl_parse_arg parg;'}
+
+    for _, arg in struct.member_list():
+        _, _, l_vars = arg._attr_get(ri, var)
+        local_vars |= set(l_vars) if l_vars else set()
 
     ri.cw.block_start()
-    ri.cw.write_func_lvar(['const struct nlattr *attr = nested;',
-                          f'{struct.ptr_name}{var} = yarg->data;',
-                          'struct ynl_parse_arg parg;'])
-
+    ri.cw.write_func_lvar(list(local_vars))
     ri.cw.p('parg.ys = yarg->ys;')
     ri.cw.nl()
 
-- 
2.49.0


