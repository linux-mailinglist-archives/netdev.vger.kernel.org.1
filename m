Return-Path: <netdev+bounces-191961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEAABE084
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DDF3A9317
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B1927B4F0;
	Tue, 20 May 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEbbh60D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2327AC30
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757968; cv=none; b=VDeKR2/8iqVs0m/0z5s0DKbAD+mBQTXMp9BJ6t3htKKEfP0rYqAcZWLC7ezAoQaMWYTIkhl4SyBSl5pfjygGPHu+5R1mAsLALrdADckbLP9CvM5sftwOVpp863xmkpdrf4Y4OAamRbR7WV0GNrJH2Za4n4wcT2I/W8ySciTxojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757968; c=relaxed/simple;
	bh=YfI1iVrHJX7BOYKQFckOsT/P6/TJ9R+53QbA9QpCkw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnftF8R43BwmxmbWfuMj2ud+ftBhm/Xn9uECswPSZdfQ9eidqHRMd+aL5Vr88JWQbQVtPJD7cIILn/H0cG1o6UEko8jj60PFzp82nAxYR7a2KqbxitCGwupCIB4DnA0wfNaHsYNYax9DQ+oZeR3R/r/GqZlle4G/MkKXz7jLQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEbbh60D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C15C4CEE9;
	Tue, 20 May 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757968;
	bh=YfI1iVrHJX7BOYKQFckOsT/P6/TJ9R+53QbA9QpCkw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEbbh60DaIHVNm4TiaaLWHqm9nr/TRTZNg1qobEH9Kd3Nu7osLz26FwNtSBfhYnD8
	 oIVtA3Te+4BZNfgseFGaV6jTykuBuo2oXmMvc1gTVIpnd4K7X57nD3mTKbtqXCFX0Y
	 AxtkkT/xip80TqZfm7V/TzCS1EATLQlk8u+ruG5zQAK9BhArzbRVewKaCEYSTF4SyJ
	 W5DX+tmqlnWRzTzbUwG8eZABM/a5yLSOs2dA6MrFhrznsoPjMTkYljIZcSo6BaoKV0
	 o7RR8AG7i2fBBDik62DeB+/pI5nvolQcsZ//n2O+vZHN6LuEq0+S3aOSB/cESMGrpx
	 jlf5tuzL+FOaA==
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
Subject: [PATCH net-next v2 08/12] tools: ynl-gen: support local attrs in _multi_parse
Date: Tue, 20 May 2025 09:19:12 -0700
Message-ID: <20250520161916.413298-9-kuba@kernel.org>
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

The _multi_parse() helper calls the _attr_get() method of each attr,
but it only respects what code the helper wants to emit, not what
local variables it needs. Local variables will soon be needed,
support them.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


