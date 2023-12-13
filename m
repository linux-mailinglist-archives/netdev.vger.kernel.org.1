Return-Path: <netdev+bounces-57098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BC8121EB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2291F216E6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017188184E;
	Wed, 13 Dec 2023 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+XUWI5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BB1BC1;
	Wed, 13 Dec 2023 14:42:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3364514fe31so214634f8f.1;
        Wed, 13 Dec 2023 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507328; x=1703112128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu7zuUOhyRqM3tfmUwz0DGtPsLVtk8tuiEIzfS/Rvv4=;
        b=b+XUWI5zY4imRfuOIsDJsu1tlb4JQBHQjIxPKkTOn3lCZxoDgHIA0VZh4XI53H53N4
         UYP+iRajLmL1F0mcNYd+u5q1//hDOCwcpYiYt0RYnil3EDNFDos0FUhdzP5JTvI9OcZ7
         GrLFrgxChEfLk3ExBce4NqnQPMEiVHAgiQrwDOFHG6m7/iOaztwlf0LwrUBy8opzt1cU
         xFjPk8mH1BS3RRd5ThOW4X24xyG/4pyTBe5S4eq/ATBPHNhxBzCPxj2MkUoE31E7SHe4
         C+os2IYTa5PfLaB8fRc6Patks3sMSz2McDfOiba/FEbCT1Et2N0SnwZWOi0Z7VAIBsaW
         WtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507328; x=1703112128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu7zuUOhyRqM3tfmUwz0DGtPsLVtk8tuiEIzfS/Rvv4=;
        b=WJMx68ieym6B66j9W5TfOMstZLDIvicEhlSSrqc1qO/NX9YG1fL2W569uEvDbvJVms
         nyCXk84u4XOSk1Byjel+1Iiz4mhcwOA4QgqRG0gietZRuJ5CPaCp1pTWHYjFCR5sqfwE
         ZseHeDiGENZyjRufcwXckMRS2EJ7BCh3LtGihwq5HAydaJITMRJvT6IdjomjtyftbdbJ
         T2lMoCN2GGpLrpT4EC7D9WvP9aDmHzd/hx2crxQngn/tJHBTOiz7P9O2KWRdRWG77aMS
         RkjsrG0H3+/lvxOWWS6yTMKDW/v/3n7c3Sa39lKa+vnek4jeR7ZSkqgvFhVrvUwFO1P5
         4zPw==
X-Gm-Message-State: AOJu0YzAgOQ+It5vP5ZoPk99aiNLhK8TySVmHivq1fGvdMhFOhHCRSg/
	Xd8U5iPNR1IptfCFi+JrV9Eo31L/0OfWIw==
X-Google-Smtp-Source: AGHT+IGR2vzF1fcQaycD1QRHLRxQxUZRiUuIkG9NRo3YBVevmNUKI1ZEf0oUDKKw6OFs6yyDzakzpg==
X-Received: by 2002:adf:a1db:0:b0:336:4725:b5d2 with SMTP id v27-20020adfa1db000000b003364725b5d2mr11685wrv.41.1702507327626;
        Wed, 13 Dec 2023 14:42:07 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:06 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 06/13] doc/netlink/specs: Add sub-message type to rt_link family
Date: Wed, 13 Dec 2023 22:41:39 +0000
Message-ID: <20231213224146.94560-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start using sub-message selectors in the rt_link spec for the
link-specific 'data' and 'slave-data' attributes.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 436 ++++++++++++++++++++++-
 1 file changed, 432 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index d86a68f8475c..ea6a6157d718 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -82,6 +82,18 @@ definitions:
       -
         name: ifi-change
         type: u32
+  -
+    name: ifla-bridge-id
+    type: struct
+    members:
+      -
+        name: prio
+        type: u16
+      -
+        name: addr
+        type: binary
+        len: 6
+        display-hint: mac
   -
     name: ifla-cacheinfo
     type: struct
@@ -966,8 +978,9 @@ attribute-sets:
         type: string
       -
         name: data
-        type: binary
-        # kind specific nest, e.g. linkinfo-bridge-attrs
+        type: sub-message
+        sub-message: linkinfo-data-msg
+        selector: kind
       -
         name: xstats
         type: binary
@@ -976,10 +989,12 @@ attribute-sets:
         type: string
       -
         name: slave-data
-        type: binary
-        # kind specific nest
+        type: sub-message
+        sub-message: linkinfo-member-data-msg
+        selector: slave-kind
   -
     name: linkinfo-bridge-attrs
+    name-prefix: ifla-br-
     attributes:
       -
         name: forward-delay
@@ -1011,9 +1026,11 @@ attribute-sets:
       -
         name: root-id
         type: binary
+        struct: ifla-bridge-id
       -
         name: bridge-id
         type: binary
+        struct: ifla-bridge-id
       -
         name: root-port
         type: u16
@@ -1041,6 +1058,7 @@ attribute-sets:
       -
         name: group-addr
         type: binary
+        display-hint: mac
       -
         name: fdb-flush
         type: binary
@@ -1123,6 +1141,376 @@ attribute-sets:
       -
         name: mcast-querier-state
         type: binary
+  -
+    name: linkinfo-brport-attrs
+    name-prefix: ifla-brport-
+    attributes:
+      -
+        name: state
+        type: u8
+      -
+        name: priority
+        type: u16
+      -
+        name: cost
+        type: u32
+      -
+        name: mode
+        type: flag
+      -
+        name: guard
+        type: flag
+      -
+        name: protect
+        type: flag
+      -
+        name: fast-leave
+        type: flag
+      -
+        name: learning
+        type: flag
+      -
+        name: unicast-flood
+        type: flag
+      -
+        name: proxyarp
+        type: flag
+      -
+        name: learning-sync
+        type: flag
+      -
+        name: proxyarp-wifi
+        type: flag
+      -
+        name: root-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: bridge-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: designated-port
+        type: u16
+      -
+        name: designated-cost
+        type: u16
+      -
+        name: id
+        type: u16
+      -
+        name: "no"
+        type: u16
+      -
+        name: topology-change-ack
+        type: u8
+      -
+        name: config-pending
+        type: u8
+      -
+        name: message-age-timer
+        type: u64
+      -
+        name: forward-delay-timer
+        type: u64
+      -
+        name: hold-timer
+        type: u64
+      -
+        name: flush
+        type: flag
+      -
+        name: multicast-router
+        type: u8
+      -
+        name: pad
+        type: pad
+      -
+        name: mcast-flood
+        type: flag
+      -
+        name: mcast-to-ucast
+        type: flag
+      -
+        name: vlan-tunnel
+        type: flag
+      -
+        name: bcast-flood
+        type: flag
+      -
+        name: group-fwd-mask
+        type: u16
+      -
+        name: neigh-suppress
+        type: flag
+      -
+        name: isolated
+        type: flag
+      -
+        name: backup-port
+        type: u32
+      -
+        name: mrp-ring-open
+        type: flag
+      -
+        name: mrp-in-open
+        type: flag
+      -
+        name: mcast-eht-hosts-limit
+        type: u32
+      -
+        name: mcast-eht-hosts-cnt
+        type: u32
+      -
+        name: locked
+        type: flag
+      -
+        name: mab
+        type: flag
+      -
+        name: mcast-n-groups
+        type: u32
+      -
+        name: mcast-max-groups
+        type: u32
+      -
+        name: neigh-vlan-suppress
+        type: flag
+      -
+        name: backup-nhid
+        type: u32
+  -
+    name: linkinfo-gre-attrs
+    name-prefix: ifla-gre-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: iflags
+        type: u16
+      -
+        name: oflags
+        type: u16
+      -
+        name: ikey
+        type: u32
+      -
+        name: okey
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: pmtudisc
+        type: u8
+      -
+        name: encap-limit
+        type: u32
+      -
+        name: flowinfo
+        type: u32
+      -
+        name: flags
+        type: u32
+      -
+        name: encap-type
+        type: u16
+      -
+        name: encap-flags
+        type: u16
+      -
+        name: encap-sport
+        type: u16
+      -
+        name: encap-dport
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: ignore-df
+        type: u8
+      -
+        name: fwmark
+        type: u32
+      -
+        name: erspan-index
+        type: u32
+      -
+        name: erspan-ver
+        type: u8
+      -
+        name: erspan-dir
+        type: u8
+      -
+        name: erspan-hwid
+        type: u16
+  -
+    name: linkinfo-geneve-attrs
+    name-prefix: ifla-geneve-
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: port
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: remote6
+        type: binary
+        display-hint: ipv6
+      -
+        name: udp-csum
+        type: u8
+      -
+        name: udp-zero-csum6-tx
+        type: u8
+      -
+        name: udp-zero-csum6-rx
+        type: u8
+      -
+        name: label
+        type: u32
+      -
+        name: ttl-inherit
+        type: u8
+      -
+        name: df
+        type: u8
+      -
+        name: inner-proto-inherit
+        type: flag
+  -
+    name: linkinfo-iptun-attrs
+    name-prefix: ifla-iptun-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: encap-limit
+        type: u8
+      -
+        name: flowinfo
+        type: u32
+      -
+        name: flags
+        type: u16
+      -
+        name: proto
+        type: u8
+      -
+        name: pmtudisc
+        type: u8
+      -
+        name: 6rd-prefix
+        type: binary
+        display-hint: ipv6
+      -
+        name: 6rd-relay-prefix
+        type: binary
+        display-hint: ipv4
+      -
+        name: 6rd-prefixlen
+        type: u16
+      -
+        name: 6rd-relay-prefixlen
+        type: u16
+      -
+        name: encap-type
+        type: u16
+      -
+        name: encap-flags
+        type: u16
+      -
+        name: encap-sport
+        type: u16
+      -
+        name: encap-dport
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: fwmark
+        type: u32
+  -
+    name: linkinfo-tun-attrs
+    name-prefix: ifla-tun-
+    attributes:
+      -
+        name: owner
+        type: u32
+      -
+        name: group
+        type: u32
+      -
+        name: type
+        type: u8
+      -
+        name: pi
+        type: u8
+      -
+        name: vnet-hdr
+        type: u8
+      -
+        name: persist
+        type: u8
+      -
+        name: multi-queue
+        type: u8
+      -
+        name: num-queues
+        type: u32
+      -
+        name: num-disabled-queues
+        type: u32
+  -
+    name: linkinfo-vrf-attrs
+    name-prefix: ifla-vrf-
+    attributes:
+      -
+        name: table
+        type: u32
   -
     name: xdp-attrs
     attributes:
@@ -1241,6 +1629,46 @@ attribute-sets:
         name: used
         type: u8
 
+sub-messages:
+  -
+    name: linkinfo-data-msg
+    formats:
+      -
+        value: bridge
+        attribute-set: linkinfo-bridge-attrs
+      -
+        value: erspan
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: gre
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: gretap
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: geneve
+        attribute-set: linkinfo-geneve-attrs
+      -
+        value: ipip
+        attribute-set: linkinfo-iptun-attrs
+      -
+        value: sit
+        attribute-set: linkinfo-iptun-attrs
+      -
+        value: tun
+        attribute-set: linkinfo-tun-attrs
+      -
+        value: vrf
+        attribute-set: linkinfo-vrf-attrs
+  -
+    name: linkinfo-member-data-msg
+    formats:
+      -
+        value: bridge
+        attribute-set: linkinfo-brport-attrs
+      -
+        value: bond
+
 operations:
   enum-model: directional
   list:
-- 
2.42.0


