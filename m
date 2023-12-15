Return-Path: <netdev+bounces-57831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA618144AA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65014284975
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54384199C5;
	Fri, 15 Dec 2023 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoRIDC9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569131A27A;
	Fri, 15 Dec 2023 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c236624edso4901775e9.1;
        Fri, 15 Dec 2023 01:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633061; x=1703237861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu7zuUOhyRqM3tfmUwz0DGtPsLVtk8tuiEIzfS/Rvv4=;
        b=QoRIDC9MBOjFTftJiyE2TYkT+GwlxEpC7ZP8HzRvJXM06K0VA0Gf18dcqmWI79gMnC
         PCYepLuEqDJ7/ifutZl9lfS95BingDrXY5UQZ71kN4Bsu9dWPFVAFwdBG0SIxjqygMeL
         JDyKFejROkcAqWFBNZPwN1iIuWF5/b/T+6Gu3KOuh3tYD5owzdSKdXowXg//SOLSmiWs
         Soze3ImcDCpD0wpZa0+/zMQc0DIujIPN6jTZYCACxB11jGI1YbT7TDrHGeSEKhwct2eK
         TXBHzqZaiRairvjabCANIUx0hpdNrGGLHzwiW0zD+4Iw9v+ImF3k/hF5dgmj0BlPuptM
         4K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633061; x=1703237861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu7zuUOhyRqM3tfmUwz0DGtPsLVtk8tuiEIzfS/Rvv4=;
        b=Hu2PYGI7dTukoWT3EvE+2utMUlacdzQkru3xGwn38sRTYBvkgk9Ed5iYfchrDruEa3
         iDs+HTIjcjuvEe5enuK8mIJhgavLJfYfc82k+Imqhbf/ydOVmQl33/hb9aWJEKie6RD6
         b7POjCTBRvW3VqbHwNdqp/uWog5r7ein4/wRe6r8FQLXpzvBBhgccmvCQCYi/bvnSYoP
         oFEH1ZjYgWBOZ9xgrNJj07cJN+Wl+YB3qIoAWwA05yqpsMAXqkyM7BUSkkdUbC0tEMMJ
         dVa9p7ElD8A1k/cKLzuwPZGoLq7li1O78pmRbnThtRgpb7ce4tFNOXfvlzPk0s48SvCg
         P1vw==
X-Gm-Message-State: AOJu0Yz82Tq47bjLZLT7vXhuRGIwz5AEDqzihK1m5D92Sn8pzX44S75b
	DC2nFtz6U/dGo5/RwVuTjY4/Ap+J9npJow==
X-Google-Smtp-Source: AGHT+IEruMmH3hOfGju7km3xUGp31ipyGz1C3JJdKoTldi/F9RoQPABNV7nzeTu2qAE2kEtpvn35Kg==
X-Received: by 2002:a05:600c:2317:b0:40b:5e21:cc2c with SMTP id 23-20020a05600c231700b0040b5e21cc2cmr5721763wmo.87.1702633060887;
        Fri, 15 Dec 2023 01:37:40 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:39 -0800 (PST)
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
Subject: [PATCH net-next v5 06/13] doc/netlink/specs: Add sub-message type to rt_link family
Date: Fri, 15 Dec 2023 09:37:13 +0000
Message-ID: <20231215093720.18774-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
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


