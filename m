Return-Path: <netdev+bounces-209412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D14B0F8AE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21998960CB6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DA213E7B;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va0BPlLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC452116F6
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290661; cv=none; b=GmaNIrPHeEyaRVlQJHYnQB7Wx4+6CpPDDDA5z+VCoq6ZFHewZbfqVRwOLx8RLOIyC37sogcJ/A2ys80rKtStd8Y2weg3D8D8mZ6zU60F3GMCDC9LAkkVaLkhClYv9dS1EALqR6926C3+HX36JSX8TJ6oWvmbEtb9NeMK4IX219M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290661; c=relaxed/simple;
	bh=HdkizeptFTrYY1FKcCVLjEIf9F228ofAybnyzRfF6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9hLKrgVj6QGzRXxUUjjdPlcvs6sk9PnMKCoVmNjFwxBqduC9Q8BoM+f02E1wpgQ5ZdWjPoW6ccPxOJXac/hp4UbbrVuhlGiaLLJfgW1p+aG700qhexEjdD5bDR+nAHGOkwkIH69xRWa1hZDlrx9JXAHFS0CXhn+lSGORHyrh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va0BPlLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B48C4CEF7;
	Wed, 23 Jul 2025 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290660;
	bh=HdkizeptFTrYY1FKcCVLjEIf9F228ofAybnyzRfF6rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va0BPlLOmqKhTu1jR8hvDDOUiYm8e6jAjGs17pbG6UzYDp4+H8/EJ2squcigjPGSO
	 7AHAaaE4Duzzs4jUXdsyHB7HIxiTobFNYLounDV19MY9sBsIb+mnj4DJNyuzipXIOy
	 djVZO+9huk1JEjB4pjX6tieYJ/G18qwxIZdvSwVkVWHmUbvspSJTMdPM+HSChHV3qQ
	 HAHrAbiaEkGW56avTT8oRtrJguC1c2YwT4G5VC3UM4jT6JRigfIo018motmEUrcDI4
	 ffq+ggxLgQ1uXn35rSvH/ndc14qRiglTupczgejnm/8oTX9V7PK2fTbuP2Lxi3sJyj
	 hxsFONJesR3vg==
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
Subject: [PATCH net-next v2 2/5] tools: ynl-gen: move free printing to the print_type_full() helper
Date: Wed, 23 Jul 2025 10:10:43 -0700
Message-ID: <20250723171046.4027470-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723171046.4027470-1-kuba@kernel.org>
References: <20250723171046.4027470-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


