Return-Path: <netdev+bounces-180990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333FA835E8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2C19E7091
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AE1C7007;
	Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brXjfemC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCC1C6FE5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249632; cv=none; b=DX60AbDsaJx2qiVgj+UKw7kR1Y+dp/MJvEKpp9h77B9J2/P7dNqbjlgU3yvgZUWpfx+CzAA8PhTziaRP7RBN0t595BRjubm8VyRmTy6kQYixRvOCEdxWXa1x//bFKYPxSwrdCETWqheW8+Rgal+XCkuLgIVFLx5vU89JBxufvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249632; c=relaxed/simple;
	bh=oeKoTMmCUvR428RJX3ESWZLmppEv/uJfUKEwolPvzmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNTcdHq7RScUHN4NI3/hRcdCbOgcW7GNfyG3pgnyycGIEQjMGwCryK1kVegabrNql7y65eQwAlPfMMa/u3Ifbt2pt3tLPPp/StRDjbwkoMfsjCtAAvxRxFEz8x+MWbdkHJpmQoPSEP9mfy/X3fT6F1tJKRBqtIH2jBl0bUeLIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brXjfemC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C0C4CEE2;
	Thu, 10 Apr 2025 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249632;
	bh=oeKoTMmCUvR428RJX3ESWZLmppEv/uJfUKEwolPvzmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brXjfemC00Vdy4xBL4b4c0O35bq/wE/JoO3NhPaNCvStfmcgLfLxcpydSXNmDei47
	 19hNR2+ofguejRIvKMOusQ13I/tm+ubUbaPh8XZ2s1SP+FGHp4W7p9Dn62zVGTDjsK
	 X3Zctulrje0Vlq6+mlZbExcfiX8/jEF/jPbRoKiqJZNeVsrciHtC85LNDb5a3S+LS4
	 y8zd+aRzXBNvsyEFJIvjjEeqUuZUAdE4grAuv3trdpIgQubeUUgm3jcOQ+xFCBr9xU
	 hZrrT1BlqhK8WUG9boNOqs2m2MTK5yHMFy0ZGPerC3i5BNJCS9NPq3OXG/IHOm0DuQ
	 7PvfTSEpW+4xw==
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
Subject: [PATCH net-next v2 03/13] netlink: specs: rt-addr: remove the fixed members from attrs
Date: Wed,  9 Apr 2025 18:46:48 -0700
Message-ID: <20250410014658.782120-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the attribute list is to list the attributes
which will be included in a given message to shrink the objects
for families with huge attr spaces. Fixed headers are always
present in their entirety (between netlink header and the attrs)
so there's no point in listing their members. Current C codegen
doesn't expect them and tries to look them up in the attribute space.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: reword the commit msg slightly
---
 Documentation/netlink/specs/rt-addr.yaml | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index df6b23f06a22..0488ce87506c 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -133,11 +133,6 @@ protonum: 0
         request:
           value: 20
           attributes: &ifaddr-all
-            - ifa-family
-            - ifa-flags
-            - ifa-prefixlen
-            - ifa-scope
-            - ifa-index
             - address
             - label
             - local
@@ -150,11 +145,6 @@ protonum: 0
         request:
           value: 21
           attributes:
-            - ifa-family
-            - ifa-flags
-            - ifa-prefixlen
-            - ifa-scope
-            - ifa-index
             - address
             - local
     -
@@ -164,8 +154,7 @@ protonum: 0
       dump:
         request:
           value: 22
-          attributes:
-            - ifa-index
+          attributes: []
         reply:
           value: 20
           attributes: *ifaddr-all
@@ -177,9 +166,7 @@ protonum: 0
       do:
         request:
           value: 58
-          attributes:
-            - ifa-family
-            - ifa-index
+          attributes: []
         reply:
           value: 58
           attributes: &mcaddr-attrs
@@ -188,8 +175,7 @@ protonum: 0
       dump:
         request:
           value: 58
-          attributes:
-            - ifa-family
+          attributes: []
         reply:
           value: 58
           attributes: *mcaddr-attrs
-- 
2.49.0


