Return-Path: <netdev+bounces-180525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1FA81997
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDD24C6B8D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA21C2BD;
	Wed,  9 Apr 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwa+b1ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA108F49
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157065; cv=none; b=ISxd8Y3JNAbliwTDeupxSeXgohtzUp1r8+XlWaQ0P3TCjpcOYDVAUnqQjX0kaYvCu8JGj+iS/gzIH4MxRmMSvjbpvr/3DmhA/yzagOs5SNRvhAUVewbklAqc3SELWhJf2bY2Xwuz/D4Bptv7SkX79m112XFqf+5HHbxvEvJ3SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157065; c=relaxed/simple;
	bh=gaL7d/mBc9klAtCmlScXi8qVotLt1K6MtMMFkUs85Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNqadjOsmTeSLhSZ0J3SyGXGtn7dHYA3P3J78ssHREkaEMPhh9O8peQ+/1Zs8fHWY2+U/z+4ptB9TpevBbFZVAMP2HfXRktySWktCUbiEWJIBdV3mi+nDZ+Zk5UNriFjSO4CUHKx4sIml8xqbg1i3R8/03q/BogV/1oKa4Kx/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwa+b1ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB86C4CEEB;
	Wed,  9 Apr 2025 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157065;
	bh=gaL7d/mBc9klAtCmlScXi8qVotLt1K6MtMMFkUs85Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iwa+b1ja6Nj+RJkS1G0fPMbUS9Q3ym2nAvmjwo4ud0W8KxKemhPsLtGqr2CDeVIS2
	 pXqpcNbcndTKA9ElSWqep5wzy6DMXx9LaleLR+iPa8a8i8dGQDDoTy1E0ZGlSSPAmI
	 6TC52qKMJqDuPH1WDJSNGdU74QsgiQxQfJXIFFbRzCeHzmlz+nDR50HqlCRIAGYhDL
	 I0ZLmphR2jfG/vgpY81vjo2CLAPiK31sa8TqkLucuYnjKtT9DcQOwcXVxIQg9FK4hD
	 KvkHh2Bxr+Ll4CRlrOPS9FoBeGazuuJG7/dMUzNsrruxMN9q3JK9SSeoAFJ0TNo2ru
	 KaInYbN5lx7jQ==
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
Subject: [PATCH net-next 04/13] netlink: specs: rt-route: remove the fixed members from attrs
Date: Tue,  8 Apr 2025 17:03:51 -0700
Message-ID: <20250409000400.492371-5-kuba@kernel.org>
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

The purpose of the attribute list is to list the attributes
which will be included in a given message to shrink the objects
for families with huge attr spaces. Fixed structs are always
present in their entirety so there's no point in listing
their members. Current C codegen doesn't expect them and
tries to look up the names in the attribute space.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-route.yaml | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 6fa3fa24305e..c7c6f776ab2f 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -255,11 +255,8 @@ protonum: 0
         request:
           value: 26
           attributes:
-            - rtm-family
             - src
-            - rtm-src-len
             - dst
-            - rtm-dst-len
             - iif
             - oif
             - ip-proto
@@ -271,15 +268,6 @@ protonum: 0
         reply:
           value: 24
           attributes: &all-route-attrs
-            - rtm-family
-            - rtm-dst-len
-            - rtm-src-len
-            - rtm-tos
-            - rtm-table
-            - rtm-protocol
-            - rtm-scope
-            - rtm-type
-            - rtm-flags
             - dst
             - src
             - iif
@@ -311,8 +299,7 @@ protonum: 0
       dump:
         request:
           value: 26
-          attributes:
-            - rtm-family
+          attributes: []
         reply:
           value: 24
           attributes: *all-route-attrs
-- 
2.49.0


