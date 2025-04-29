Return-Path: <netdev+bounces-186779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF9AA10DC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916EA5A4818
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001123ED75;
	Tue, 29 Apr 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+Bzz7EQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2D23ED5B
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941633; cv=none; b=RR1s1FGfbVuYv4GR4kSLo8havIEcPOUtS8TLnisTuen5RNrHLRDj9kx8lHjdHPNA+PSZPamVcEKvaGMxwW9bSXPmWhmUMid/EpwlCbVscZhiNcPHUDKkLF0yHOaqu5ft87ekbCZWf2dNdg1LW0A95QM1a+/1GO1pTYIukKcNFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941633; c=relaxed/simple;
	bh=7XG3fGbIBnbbSIhw3joteeN6+fvx+0kvlLI6N6XQqDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXHUsEiJNfmUcTvSe3zdprIyMX5dYy/QTu/J30z64aRQV1TdzKS7mcP1oKVqsGXlrrLH58TYM1Il1s9O8u7U8wgD8C6571EvsMVFvVd3oqZcSJoYEMvpsO2XG+8IYjt4Pmyn2y+a8phpNUU64FlAmJekcKRBIqgHx4Cf+oa/GlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+Bzz7EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A736C4CEE9;
	Tue, 29 Apr 2025 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941633;
	bh=7XG3fGbIBnbbSIhw3joteeN6+fvx+0kvlLI6N6XQqDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+Bzz7EQ6s4nGcuTECO0ajJ5qQH/AcCFATEDKnoKrj1NB2Qez+ukmvXdQ5Lm9R/Lw
	 4YuUP3hZ6tNZG1JWFjtKLSKZD1Sp+pzcP1AvkXKMPQnqjdJETtmiiamJaJhqLXHic1
	 cEcyk8+NG1uAagpB3CnvSH0NvlfwEv7yg9Po8V7Lk2XCYThNAnmb5TaIYN3pCZfq/E
	 5dtUMKY7roKrIABEa8Pg5uQXkekUCo0k8khEvO3NS1JrQ6i2FSsKedMCKLvHZGr34t
	 LjKeeeFlki8i3Zo/iNGWcWQxp/IKO4vv81nVzh6wwwArydSktEsTKKZXuzftr1CR6W
	 V9TBZTGArbgUA==
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
Subject: [PATCH net-next v3 03/12] tools: ynl-gen: fill in missing empty attr lists
Date: Tue, 29 Apr 2025 08:46:55 -0700
Message-ID: <20250429154704.2613851-4-kuba@kernel.org>
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

The C codegen refers to op attribute lists all over the place,
without checking if they are present, even tho attribute list
is technically an optional property. Add them automatically
at init if missing so that we don't have to make specs longer.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use Jake's suggestion
v1: https://lore.kernel.org/20250424021207.1167791-4-kuba@kernel.org
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 90f7fe6b623b..898c41a7a81f 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -938,6 +938,14 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 class Operation(SpecOperation):
     def __init__(self, family, yaml, req_value, rsp_value):
+        # Fill in missing operation properties (for fixed hdr-only msgs)
+        for mode in ['do', 'dump', 'event']:
+            for direction in ['request', 'reply']:
+                try:
+                    yaml[mode][direction].setdefault('attributes', [])
+                except KeyError:
+                    pass
+
         super().__init__(family, yaml, req_value, rsp_value)
 
         self.render_name = c_lower(family.ident_name + '_' + self.name)
-- 
2.49.0


