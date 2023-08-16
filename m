Return-Path: <netdev+bounces-28273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A977EDED
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5058D280CBC
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA801EA96;
	Wed, 16 Aug 2023 23:43:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0331DDDE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBD9C433C7;
	Wed, 16 Aug 2023 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229394;
	bh=9wM5w+WCv5paZTd5n1eLTaL3R0OlBV1SGaej2AKatXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGhsdJWwOY4RQMHuNRr1ayRCq5yRbrcDX2Jbc4POla28I8J0bi++vimiZKNlQ+562
	 Q518CloW2buOpEKU3pTV5reoUA1RBL6oS52cugrDdjjj9m3KjY2XXXrJiW3PWHfShU
	 CSRhR2mzQ9zkvhm8pVVrUl6s7adxu3EDUSZ0fzSGoPfyAYhk31tGz3ivqzGrXbm76x
	 YWR5YD+e40HkgYOij34klpuQcfTK7syeKsQ92T3WWj3LRnPVMqBjZ7Fw0F24pQMy/B
	 i4+Z2DNAokVy+JVHaJ/xKTL95tX4LZN52on90qiLMdMUS4ndOiwD5nktgKQdZFbQJQ
	 s7Q6ntpnimfag==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 08/13] net: page_pool: add nlspec for basic access to page pools
Date: Wed, 16 Aug 2023 16:42:57 -0700
Message-ID: <20230816234303.3786178-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
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
 Documentation/netlink/specs/netdev.yaml | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1c7284fd535b..ded77e61df7b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -68,6 +68,30 @@ name: netdev
         type: u32
         checks:
           min: 1
+  -
+    name: page-pool
+    attributes:
+      -
+        name: id
+        doc: Unique ID of a Page Pool instance.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: pad
+        type: pad
+      -
+        name: ifindex
+        doc: |
+          ifindex of the netdev to which the pool belongs.
+          May be reported as 0 if the page pool was allocated for a netdev
+          which got destroyed already (page pools may outlast their netdevs
+          because they wait for all memory to be returned).
+        type: u32
+      -
+        name: napi-id
+        doc: Id of NAPI using this Page Pool instance.
+        type: u32
 
 operations:
   list:
@@ -101,6 +125,23 @@ name: netdev
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
 
 mcast-groups:
   list:
-- 
2.41.0


