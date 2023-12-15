Return-Path: <netdev+bounces-57708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB14813F82
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9636C1F22A99
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF1808;
	Fri, 15 Dec 2023 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/xRSads"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6E806
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F3C433C9;
	Fri, 15 Dec 2023 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605458;
	bh=DW6aeAVrUUcoT5UIDObho/O1VZZdjq4IereQi4wPgzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/xRSadso8NAyi7LNYYA25nwNGA4cM+vnE8aPWDoCRaJb4kt9iWW4LSpWa9OWE/yf
	 MUHTdOV6vcoD8W0bObmmJWmW1MpdRiD+gIUk5NC1HJH2R4q3bxRCJ4nWITRvvt/kti
	 ECXragUEIGERai1U5RfZv8C7Qfa3x+wfBEPifc9tEslNLKCB99wymT8DmUVz8I2hqw
	 7aZqzyGD3C8cCwSAOhO5wSChhKFNHSJw6oyvuD0xBoJEOhgRTvlXyrtVa0dgfk+0p7
	 /W5Coqkr/fYgL4cEyhKn+LmsnSHR5EHDAkJCJUil5NLiRUISpuGsnq4esYZgb8APy0
	 9fkXwUSnFKVyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] netlink: specs: ovs: remove fixed header fields from attrs
Date: Thu, 14 Dec 2023 17:57:33 -0800
Message-ID: <20231215015735.3419974-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215015735.3419974-1-kuba@kernel.org>
References: <20231215015735.3419974-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Op's "attributes" list is a workaround for families with a single
attr set. We don't want to render a single huge request structure,
the same for each op since we know that most ops accept only a small
set of attributes. "Attributes" list lets us narrow down the attributes
to what op acctually pays attention to.

It doesn't make sense to put names of fixed headers in there.
They are not "attributes" and we can't really narrow down the struct
members.

Remove the fixed header fields from attrs for ovs families
in preparation for C codegen support.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 2 --
 Documentation/netlink/specs/ovs_flow.yaml     | 3 ---
 Documentation/netlink/specs/ovs_vport.yaml    | 4 ----
 3 files changed, 9 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f709c26c3e92..067c54a52d7a 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -142,7 +142,6 @@ uapi-header: linux/openvswitch.h
       do:
         request:
           attributes:
-            - dp-ifindex
             - name
             - upcall-pid
             - user-features
@@ -154,7 +153,6 @@ uapi-header: linux/openvswitch.h
       do:
         request:
           attributes:
-            - dp-ifindex
             - name
 
 mcast-groups:
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 109ca1f57b6c..29315f3538fd 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -947,13 +947,11 @@ uapi-header: linux/openvswitch.h
       do: &flow-get-op
         request:
           attributes:
-            - dp-ifindex
             - key
             - ufid
             - ufid-flags
         reply:
           attributes:
-            - dp-ifindex
             - key
             - ufid
             - mask
@@ -968,7 +966,6 @@ uapi-header: linux/openvswitch.h
       do:
         request:
           attributes:
-            - dp-ifindex
             - key
             - ufid
             - mask
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index f65ce62cd60d..86ba9ac2a521 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -135,7 +135,6 @@ uapi-header: linux/openvswitch.h
             - name
             - type
             - upcall-pid
-            - dp-ifindex
             - ifindex
             - options
     -
@@ -146,7 +145,6 @@ uapi-header: linux/openvswitch.h
       do:
         request:
           attributes:
-            - dp-ifindex
             - port-no
             - type
             - name
@@ -158,11 +156,9 @@ uapi-header: linux/openvswitch.h
       do: &vport-get-op
         request:
           attributes:
-            - dp-ifindex
             - name
         reply: &dev-all
           attributes:
-            - dp-ifindex
             - port-no
             - type
             - name
-- 
2.43.0


