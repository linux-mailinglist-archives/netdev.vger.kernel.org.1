Return-Path: <netdev+bounces-180991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8991A835E9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2AA7A7CCD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86C1C8639;
	Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de90upEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1F1C862B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249633; cv=none; b=hW9fPrfwNfQnHIWGH5+znVTKZJ4Z01w87u+SZ7eG3WTsXvk2n1foakvMAaNO04wL1NVH6fecWNnj4W6CK9S+7mevakLZ/bwSz6rNEi/2/JugbmOJXAA+8vAr9ZBnJo240HmNFEp8FuWwSaBIxwn1uJZ85LaQh2XEFBDPLeqjKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249633; c=relaxed/simple;
	bh=/6tCHRAoP5tO/9i4ylAp8iHJdVFvaYilk1BVzPcu8sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJa5OT2uCzLfZWkmebJn672O+wELVLLhfA/y+KOF/5SYZprW6Z6aA5P9LbyGM3fCDYzIzyBTopsjGAqX28UIAXq+D5oKrGlX3ABhRpB+k4YcgVbmh/IZ26NGyjCZhtM1SpQIlEqQ9+6na2lisCWnmzoqZCf15SELzBtLM8Ev2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de90upEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B393C4CEED;
	Thu, 10 Apr 2025 01:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249633;
	bh=/6tCHRAoP5tO/9i4ylAp8iHJdVFvaYilk1BVzPcu8sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=de90upEj7ZA1zOsMEf52kwZTtVHhE8eD09iGlCe34Fnnpv9wTvr2nF+HEw1XD7jwh
	 /BA9Qz5L3qVeJKWYiZwgoFq8fs8PwoJr9Vm7ojYuKuYi4fLnbDwPYBmS07r5Qj8yOP
	 oaZE0D97zYEhb2/A8j8OCuwoymrMTthtXykZza8H5C19ggv4Krz6T9STmSavNdg8QK
	 7mM5k5XAtvYtEjU4iIW/AdjQSxP3C23cR3pDdfOfD5sFz6e6xS64x8UpaCnzdT0F50
	 DkqgmSZdKvCFst27FDW4SWSxeH9ie3LPifMHX/278zLrlCluUtj4JM12gdyep/cmO9
	 QUT62SGvGa0Ag==
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
Subject: [PATCH net-next v2 04/13] netlink: specs: rt-route: remove the fixed members from attrs
Date: Wed,  9 Apr 2025 18:46:49 -0700
Message-ID: <20250410014658.782120-5-kuba@kernel.org>
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


