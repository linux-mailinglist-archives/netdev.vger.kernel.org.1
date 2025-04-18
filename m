Return-Path: <netdev+bounces-184047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B56A92FD5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C874C8A44F4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED147267F43;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7QyE0gp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7815267B99
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942639; cv=none; b=X/DC7Zc5Dz9sS2Wk0o/nnlZ0g0HlWiz7GKyVjry9Oe1B2Nkw0g64v2m4K+whmMv29bDlghlHvsvKh307ZYG8pRIjNyV2DwXGVaTKF4owV7Pue4GrBA4SL6s8A/zvhGx5iDbKptXKiSsEWeIfXw/+y5yt+6HJI971RLI3/ASLbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942639; c=relaxed/simple;
	bh=EqkKB/v0hT8THsotiVZRpAd5PtP4deLrOAMcqXY6pmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnxlVE2SwyKz8JkQ+hlaIwKcVs2hPeG1Z9WjxDFBj3fRam3R+DuV+DdcTn7KjOseUsv/JeHsP2vG5uy9XxM8jeVJ8KIxSJ1EugPlWiM9rqpNMuGJkoufEjcw/xuaopZtvCy/UoYWTq72QHsm/PPagySm2Hh3Anr0HhhFE5vkhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7QyE0gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1706BC4CEED;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942639;
	bh=EqkKB/v0hT8THsotiVZRpAd5PtP4deLrOAMcqXY6pmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7QyE0gp3eGka73Z0X7iV3En7yrCmC6yCnZm5NoVxlfnilxiKWyWF5YWlZ32kLJWW
	 Pn3yeIgbx/ZP/6sqoNomn5vtNSwENIoGD/ZizJA2XYABvEhdHLyTdE1rIAxrVgrZh8
	 k+Jmyhzu8jjFqFXNv1k6/odjmdF5Kr9lFvH5egtWmxXx9C5geyQpXE4lkrxJUlazII
	 Z6D5mlc/SOks1TnmJ67Injyi1VYPcaxvZWcnLJArgrTxCLkiS4lvbYAdptdZlFn00g
	 4Q9LowpllT+Wt7n7FkqHED07AEbGU+Tm/XOVTimUYLghOx+ntK2xE6QgcUirXEQUaG
	 JAR18lda7T+9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/12] netlink: specs: rt-link: adjust AF_ nest for C codegen
Date: Thu, 17 Apr 2025 19:17:00 -0700
Message-ID: <20250418021706.1967583-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AF nest is indexed by AF ID, so it's a bit strange,
but with minor adjustments C codegen deals with it just fine.
Entirely unclear why the names have been in quotes here.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index a331eb5eecb2..6ab9b876a464 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1188,19 +1188,21 @@ protonum: 0
         multi-attr: true
   -
     name: af-spec-attrs
+    name-prefix: af-
+    attr-max-name: af-max
     attributes:
       -
-        name: "inet"
+        name: inet
         type: nest
         value: 2
         nested-attributes: ifla-attrs
       -
-        name: "inet6"
+        name: inet6
         type: nest
         value: 10
         nested-attributes: ifla6-attrs
       -
-        name: "mctp"
+        name: mctp
         type: nest
         value: 45
         nested-attributes: mctp-attrs
-- 
2.49.0


