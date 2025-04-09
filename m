Return-Path: <netdev+bounces-180523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8775A81994
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C044C47E8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D292A930;
	Wed,  9 Apr 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZsheJtn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F08F49
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157064; cv=none; b=ZBAuaKp4bVQzUQNnd8dbzFO8rishDLqsnI13pOoTt2G4f8pubERnvNRw/YuVOaid8GnemaPYly7EFvWTZRLNNbu1IBAIvg7u1iW9m3ntjUck4Dvkh/Nfn7F3Ap3rwP4wwQLgz3De7om165Lvq0MH7KDTG/gRvobL8IkOh21gHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157064; c=relaxed/simple;
	bh=viTtah+BwETnGA/bn9KzFmez9S6x+dIYA2XwKKbZtys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHDsiVdElryLkinNYFF6CUDqkMK3Wy+O113jygI/X5cB8zs/3vpHnGDRbtmSSuF3hp5QB2ltQbyBDSvJMplpBp51NqzuTW/zsCdbV+IVDRYrYloA5y5UlSWN/HFbv/zqYAc6OlrlPeDV2yoITpZ78q0PctVs3g/GLf2fZhLSiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZsheJtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D284DC4CEED;
	Wed,  9 Apr 2025 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157063;
	bh=viTtah+BwETnGA/bn9KzFmez9S6x+dIYA2XwKKbZtys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZsheJtnh0HcqcLemWqsVPG4GrKL90etUviURf86c6J3LlGKTUxmVZGHFkpvQtpnI
	 EAoNjrxwErVsLo0C3tU0k13aZNJAFaY4D2ls/tSQ3Jlui75gwaR1z/vmdz5ist2sEx
	 RJt/ZYS6MptSpdWIHgIyJk+PolFxBS+k9lktOivuwBCn0woTh8OgH0ewQOWovy+DvX
	 +QJzmHM7Zcp5bBaG9toDZNWQtpJF4xAK7JFWOj1NLTDBgRhgqkYt3t0AV+70VpLodV
	 5rJwTwCuNF+NawRXdfoLwCnTJrmSzCH8qEbivksHB0yllMnCLZxEKHx9Vqt9kHnGwP
	 RcU3HPsffTcWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/13] netlink: specs: rt-route: specify fixed-header at operations level
Date: Tue,  8 Apr 2025 17:03:49 -0700
Message-ID: <20250409000400.492371-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C codegen currently stores the fixed-header as part of family
info, so it only supports one fixed-header type per spec. Luckily
all rtm route message have the same fixed header so just move it up
to the higher level.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-route.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 292469c7d4b9..6fa3fa24305e 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -245,12 +245,12 @@ protonum: 0
 
 operations:
   enum-model: directional
+  fixed-header: rtmsg
   list:
     -
       name: getroute
       doc: Dump route information.
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 26
@@ -320,7 +320,6 @@ protonum: 0
       name: newroute
       doc: Create a new route
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 24
@@ -329,7 +328,6 @@ protonum: 0
       name: delroute
       doc: Delete an existing route
       attribute-set: route-attrs
-      fixed-header: rtmsg
       do:
         request:
           value: 25
-- 
2.49.0


