Return-Path: <netdev+bounces-43923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09007D5744
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAC7B21163
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9983A28B;
	Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxM7p5GU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF503A27E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241DFC433C9;
	Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163364;
	bh=Rq8SndcZ/W9+UTaffLwtZA7dwWBWF0utXnuRiR9kxtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxM7p5GUrPRKcHSeokbLY//NDeOoTThI68PwstJnxO5TTsJbIjsKY8/fFeLtmXOyC
	 F8i6VKUisOKRF3O0ILPIRHbAAuHniOuQivxzF5WcwDKh/vqTusib8NdXFfNbb01TUO
	 KmxjqEtZzG33IV3Ah3YohvCNwl7M61BYUlZpGX2s/YvSmDWCRoyGljEkgmApabX10W
	 Lm6mGa3uQzae5idiuvLOlX8/0XejNZBAeOkBskhe55viPHsaAxtz3rJlpdF746Spnh
	 MWJAfkWz2gMTZU7v/9/0iqzQIVHACJDA1Pcs03+gYbcR0Gnzx5qL/4S2Wip35AbSDp
	 /xaBPL3+7Vkhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/15] net: page_pool: add nlspec for basic access to page pools
Date: Tue, 24 Oct 2023 09:02:13 -0700
Message-ID: <20231024160220.3973311-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024160220.3973311-1-kuba@kernel.org>
References: <20231024160220.3973311-1-kuba@kernel.org>
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
 Documentation/netlink/specs/netdev.yaml | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..cc9e87dc36e9 100644
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
@@ -120,6 +148,23 @@ name: netdev
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


