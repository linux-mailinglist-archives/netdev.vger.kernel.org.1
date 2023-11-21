Return-Path: <netdev+bounces-49471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F67F21DF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19B2282785
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BA3C07B;
	Tue, 21 Nov 2023 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqo/yMSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76C3C077
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7F3C43391;
	Tue, 21 Nov 2023 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524861;
	bh=u85xHyLUUP2c2kSBZmRu+sfWWRTC5Fw14x3bAnG17oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqo/yMSyh8/WTva5m9N8yetLB8uEMW7qLeINDhU1FJZzLMAllhx6qKJRuHk7lOWG0
	 ZNLr2jnQYPIuRm85kXnC0hXl1wOE34b4pnnK6E1o2ChxYHa39H3mTQSScLfvPo1Kdk
	 PSVpd2Iwh4nOTwbV22E4zJrQx/zGQe5gYk7umeHogIcH97fyCZYisFaLBcPu0RGxoF
	 TYB0U16ErU7hXx/hslIWkp7thx7rRgsJ+sz6eUP7BUpWVIj2dMVsNe1Hw9SpVcS9JB
	 5o4wU7eGj6dPvGN2c2XEP3rLKMyyv8ZG+zjxzaOJGlTjLJTazCfiPIee59iVPWaOyg
	 tgLwA+xr0tKXQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic access to page pools
Date: Mon, 20 Nov 2023 16:00:41 -0800
Message-ID: <20231121000048.789613-9-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
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


