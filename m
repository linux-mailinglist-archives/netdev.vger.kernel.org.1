Return-Path: <netdev+bounces-49902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC67F3C8C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FEE282B89
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C832C8EA;
	Wed, 22 Nov 2023 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9I2K8x9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024DC8DB
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A57C433C7;
	Wed, 22 Nov 2023 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700624669;
	bh=u85xHyLUUP2c2kSBZmRu+sfWWRTC5Fw14x3bAnG17oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9I2K8x97/WC24AMTnBdd5QalRJnxz+08WZll2DPxg4+8bq0/oWlTYDTZTKcbsC76
	 oBodJWadeGAIGsZAD6AvY5PV3eAD80it1tCt7V/k1ymNXlEAKLXHC/c0plPQIZmFpS
	 /kBBsduc2ffhJMV5WymGV1fn6+R99Jw/CUcTqd7D4IpdHqIPz8UCByy2FSuE66EhXZ
	 GPtZn1BaxN+xucKGWP1y/LQetEBGs6+h6zIkCmX1054kJQiiWD+kwURNq0KRe1vvEr
	 2rF3GZferDVjd0naTsUJHbRdBKFOydG+sOZ9ILk43ma7ePBfwbgnn+Y0e+p3R5DeiF
	 U4wLHpCyyVWhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 06/13] net: page_pool: add nlspec for basic access to page pools
Date: Tue, 21 Nov 2023 19:44:13 -0800
Message-ID: <20231122034420.1158898-7-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Netlink spec in YAML for getting very basic information
about page pools.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..84ca3c2ab872 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -86,6 +86,34 @@ name: netdev
              See Documentation/networking/xdp-rx-metadata.rst for more details.
         type: u64
         enum: xdp-rx-metadata
+  -
+    name: page-pool
+    attributes:
+      -
+        name: id
+        doc: Unique ID of a Page Pool instance.
+        type: uint
+        checks:
+          min: 1
+          max: u32-max
+      -
+        name: ifindex
+        doc: |
+          ifindex of the netdev to which the pool belongs.
+          May be reported as 0 if the page pool was allocated for a netdev
+          which got destroyed already (page pools may outlast their netdevs
+          because they wait for all memory to be returned).
+        type: u32
+        checks:
+          min: 1
+          max: s32-max
+      -
+        name: napi-id
+        doc: Id of NAPI using this Page Pool instance.
+        type: uint
+        checks:
+          min: 1
+          max: u32-max
 
 operations:
   list:
@@ -120,6 +148,24 @@ name: netdev
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: page-pool-get
+      doc: |
+        Get / dump information about Page Pools.
+        (Only Page Pools associated with a net_device can be listed.)
+      attribute-set: page-pool
+      do:
+        request:
+          attributes:
+            - id
+        reply: &pp-reply
+          attributes:
+            - id
+            - ifindex
+            - napi-id
+      dump:
+        reply: *pp-reply
+      config-cond: page-pool
 
 mcast-groups:
   list:
-- 
2.42.0


