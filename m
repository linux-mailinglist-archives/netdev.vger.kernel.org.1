Return-Path: <netdev+bounces-51167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBC7F9648
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D01B20A6A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738B1775C;
	Sun, 26 Nov 2023 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Neo/A9kZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C117744
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28181C433C8;
	Sun, 26 Nov 2023 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040100;
	bh=2vVlhq8hDF7D9qmgNvYSLltLTqZuJXRhMv92BmJbOl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Neo/A9kZvNNceymy9ww1vifHut/Nj4EQUhWloB6AaGtLtlgcosMgCG1zs8VwKBY3+
	 47BE4AAfOoHDm4lYv5xzxWdO+970wbrGP2l+nbno3sMbN6+nUPVg3gflxYwmVLJ9xC
	 i89t2cGg3s9ig5fBYRwg7d370PWjvZTihzXTbWuWw9m6EpvKyZLOsubEAT3fJyAQjC
	 qzB933W7ZtuoGVuPv45X0fnpBv+T4ve4z+45oYCoIU6ivCDpJYlAU9B0GDoq/tuRKn
	 TpDCiMJFtLd0W6S+3ZG2/c6XIzF2vcftXcBnsby3x7ky3nNQvPDN3npAST4zH1u8yY
	 mluk/4gMUNmmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 06/13] net: page_pool: add nlspec for basic access to page pools
Date: Sun, 26 Nov 2023 15:07:33 -0800
Message-ID: <20231126230740.2148636-7-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126230740.2148636-1-kuba@kernel.org>
References: <20231126230740.2148636-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Netlink spec in YAML for getting very basic information
about page pools.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
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


