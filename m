Return-Path: <netdev+bounces-186781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E41AA10DE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400001B67B92
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B624167C;
	Tue, 29 Apr 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZioSFnSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1324241671
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941634; cv=none; b=gwOvhKQh0oZFVRcbEyd1QrNgKL2DWJwn4ASF47brMnq34c6LC/vCH7zBg3Amq7Ceue45Cbv20QhV/K5VHcJWCsOV0d62gjT53ui9rzMNKIIczTK1BvVUq1BhiUT557pxalgaNSYn8qn6AiMooXM15tAL2Dwa8kuoir+uezbSwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941634; c=relaxed/simple;
	bh=Lo4MeD9fljKCJm96mCHkGECOzZ7x3WJewZOJSmSjEu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENuaHI+FnXwEH5yfxjpY9/EbbHrg2veKxaFCaiS8xo5zqldY+iLJVNjWP4UOq85S6kC+UKqaoYlRNjNGYCuS7UeMmubpVStMrK+bPT8+n4Kg8/H23RPuQbArguC/2x3bW0ZU3DKm4WspeiC1sLiWbWXfEG67Da/udugAYHm67Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZioSFnSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A7C4CEE3;
	Tue, 29 Apr 2025 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941634;
	bh=Lo4MeD9fljKCJm96mCHkGECOzZ7x3WJewZOJSmSjEu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZioSFnSdKcm2XPMOYKIE6OYR1kSxs6MTls2QDZM8ECtR1RufoU0EEsIfLQim3XpFb
	 8JKb4EjaW4cI8mZBO609Dc7g/rBYVWcalMBy3tA5RAmWhmWWhis932q1u17lxmnBF3
	 QioSmt9XldSN92GCDeWAl7UvjbwfJeoQru8YXJJ2HridjctupUORMjd4xWxyP7A9JJ
	 XZkSqpf3L2mgWTt8SKGEPObuC1rXafhCOCJG6eFaigd/71pOju8hTgkSHrRTALVbK/
	 EOAtFq4BiN1cPyi2u/0gl5KBY3RLqohlSLc0MfeEly9WYqr8tkiykA0/kK0YQGn1wu
	 MGuTCS4FkDtkg==
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
Subject: [PATCH net-next v3 05/12] tools: ynl-gen: support using dump types for ntf
Date: Tue, 29 Apr 2025 08:46:57 -0700
Message-ID: <20250429154704.2613851-6-kuba@kernel.org>
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

Classic Netlink has GET callbacks with no doit support, just dumps.
Support using their responses in notifications. If notification points
at a type which only has a dump - use the dump's type.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c035abb8ae1c..0febbb3912e3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1281,7 +1281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self.struct = dict()
         if op_mode == 'notify':
-            op_mode = 'do'
+            op_mode = 'do' if 'do' in op else 'dump'
         for op_dir in ['request', 'reply']:
             if op:
                 type_list = []
-- 
2.49.0


