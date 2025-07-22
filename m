Return-Path: <netdev+bounces-209045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93675B0E18F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BE81C86027
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8E27AC44;
	Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG7x8cSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C427AC2A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201183; cv=none; b=MrkdkXALgPa1bNq1KUC0HRWBew8W6O63l9upWodwY4vrcK5QpGQQKeoxqbV2Jqf4B6Pd1kYHaVFz6bJsIh20sbkxDUycK7jLvtFzEdsvWjYS4szGXx2cm07v/UwzhFon99M/+uvMlIwsoaIr01s2M+CqyqHr0jPRJFa3QoSh9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201183; c=relaxed/simple;
	bh=n3Txx4MwjB9erpsBZOGCfS1YN8GOjkiup7eK6L6koA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRvnjUvUirxdfuBF4GPdam7iwxy6u45PVIeH0N+z2OP8BHhfZc1dyJ8r/bjiCeEf9MJf3G+mw6ZQh/0Gd5TTOhbdeJ3cXwxQsI1/ZVCO+/oVVLb7ryUTjeKpwWa9A92OBlQ2YWaL0bUD9yXbThyCO4mlOy4kiYnx4RyqgCFqlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG7x8cSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF616C4AF09;
	Tue, 22 Jul 2025 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201183;
	bh=n3Txx4MwjB9erpsBZOGCfS1YN8GOjkiup7eK6L6koA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG7x8cSDqkfpYX+LhD2PTuFKAK/bG6ZeglodgZM88YSZ8HlKehGr+9LsHh6p3LfLB
	 2J2cCwgygxFNAQsl2bN8ZvTZLY7Pi81tyqdyRuZF8ue1JlJ6L25MLWrfa11P9HTnN2
	 MNWjCAq6KFiSFtXBL5tbHJYZVxZPBgOOnIQW6aGz2J5nbXDC4VjhyhC5Mnmkmnoe+f
	 E/Yt4uG0RIM7iRfG9UMlAzlSgntm2JeiFgBZSA73cGBy3nK2jnu4ko4hzxMS2uFYjT
	 2//rluT5wOoZY4TriNIHb7W7pdhfOTAqLokxMl3E2ZsUbgtvkwMdbeVVsWWuxCY5F1
	 BJxsriwCQLO4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] tools: ynl-gen: move free printing to the print_type_full() helper
Date: Tue, 22 Jul 2025 09:19:24 -0700
Message-ID: <20250722161927.3489203-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>
References: <20250722161927.3489203-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just to avoid making the main function even more enormous,
before adding more things to print move the free printing
to a helper which already prints the type.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1bdcc368e776..dc78542e6c88 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2546,6 +2546,10 @@ _C_KW = {
 def print_type_full(ri, struct):
     _print_type(ri, "", struct)
 
+    if struct.request and struct.in_multi_val:
+        free_rsp_nested_prototype(ri)
+        ri.cw.nl()
+
 
 def print_type_helpers(ri, direction, deref=False):
     print_free_prototype(ri, direction)
@@ -3517,9 +3521,6 @@ _C_KW = {
             for attr_set, struct in parsed.pure_nested_structs.items():
                 ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
                 print_type_full(ri, struct)
-                if struct.request and struct.in_multi_val:
-                    free_rsp_nested_prototype(ri)
-                    cw.nl()
 
             for op_name, op in parsed.ops.items():
                 cw.p(f"/* ============== {op.enum_name} ============== */")
-- 
2.50.1


