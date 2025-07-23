Return-Path: <netdev+bounces-209411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F2B0F8AD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C4D1C86BEC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61680213E6D;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob6dLv1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC721171B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290661; cv=none; b=Uoy691YvnvSPnklf1r6XBiSJ4QuMAyBtUx33tQGRT2ViertWtOGGbQkb0/0k9SiAJtN76L8JjDYJ19s2vfEzJIA5SeJwr07mITiLwmvN+MzFv2UhffzgtFar1MPzcm4qeTbXoCqApPJZCNan6Qt+lCpQf5LhH5yCXXQbZwmOHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290661; c=relaxed/simple;
	bh=V7lcjYQcg5BbKySzi4OE+Q52nh0eSMiklp4w+Od9ZaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPzjmAJ4ELgQWiLTKWGMnM3dNWj07n7sMoVnjLlEEBSjk9FpPK6tJ9J3t5tYDEo/FFJhjKhzh5pXGXdsSl+Q5aGCydIS8AkuE+EEcn3h1gXaF0I7B0SFuWK3Gc091WD5P1VEQ8Rzjq8wZg2pcUcn+M1km7iy4sKf8Gr/b1OaTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob6dLv1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217B7C4CEF6;
	Wed, 23 Jul 2025 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290660;
	bh=V7lcjYQcg5BbKySzi4OE+Q52nh0eSMiklp4w+Od9ZaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ob6dLv1s+30GaNK5Gs0Ew8ben0q5nmN3z6J3M2LFgWSvtt3g78CtszqbFFyGcc2+/
	 bWLUDEW7QVSbX91QOSNZz+8CAWbncEciMTIzPqAPZHEWT/DQ1bPjTzd+fbFnKCx94I
	 8NeHoro/h5fZLBz7VjX0iUiJ8YUvp7jnxzehUolijfbeN7x5W01yiYU6kiuwBCZUB1
	 TQu2E8NlRe3UC48BiHG0TFDTIeHAF+wlzBtKSPkMJigL1bi1tD/tcPdtY5rNxqglB8
	 YJr8P9Xle85zNoEqC6vhhycPjn/P4CLjwhL1XexiWC40Pzl6+2Fuhu8LC7ECfXANts
	 bruCjCgVvVUKg==
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
Subject: [PATCH net-next v2 1/5] tools: ynl-gen: don't add suffix for pure types
Date: Wed, 23 Jul 2025 10:10:42 -0700
Message-ID: <20250723171046.4027470-2-kuba@kernel.org>
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

Don't add _req to helper names for pure types. We don't currently
print those so it makes no difference to existing codegen.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 76032e01c2e7..1bdcc368e776 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1879,7 +1879,9 @@ _C_KW = {
 def op_prefix(ri, direction, deref=False):
     suffix = f"_{ri.type_name}"
 
-    if not ri.op_mode or ri.op_mode == 'do':
+    if not ri.op_mode:
+        pass
+    elif ri.op_mode == 'do':
         suffix += f"{direction_to_suffix[direction]}"
     else:
         if direction == 'request':
-- 
2.50.1


