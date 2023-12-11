Return-Path: <netdev+bounces-55992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6AA80D25F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF181F218FF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56F4E1A3;
	Mon, 11 Dec 2023 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGihjiWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956B8E;
	Mon, 11 Dec 2023 08:41:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4462656f8f.0;
        Mon, 11 Dec 2023 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312867; x=1702917667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjWb38MkJ1jdcSSF4FkwC2/jqoGI9gTr5GiOB1jVnes=;
        b=VGihjiWiS05vs0S9RrvVR6SmztChAgQFRkxYD3dTwXrxWMSY160AbUlBI0LuG2TUxf
         ehSOlKi6wfg8ztZBRfVwK61ZG6FRE57rs/M8aaBGDpyOJCtPlq/hPGXsdCQoZmlaiIkB
         dGApGncv/0tcGi4NT9Oap9rge7H2y56isFT2KE47VO93LBqTIyvfDrcmOAraWm9WY9DO
         UcoTGThF3BMLBucN3eWRcgv8HMPbOi9euVaol1nkI1sOfIqgnsoNorxaqSDphGYzYbQ3
         i50S4JomWVy072xwWLiDc+ypFIrOqmz75jxFhIFU5PRy/7e7foQXH1/Ehl/xAODEm8FA
         6O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312867; x=1702917667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjWb38MkJ1jdcSSF4FkwC2/jqoGI9gTr5GiOB1jVnes=;
        b=vjwRuKrhgq0Q0EBj6RbaPmvRdzvMkB/yyyz+QKMs5krpGSiRwZViNdYcCahPH1jTjt
         wL6hQ/tK2MFI+tkrP2QCWxHHCk5LmIRmqXFvZdB+ezeDpH8LyUoBDnKOcZMUV+nUcZvw
         q0zzc+57OCh8QWw8RU72r7tUROiEMlBC6bmVnONLwKYMXyhqWSP98CVnIq1ZqGa49+43
         q0WM35lwQ2b0jfvTxtevdNaFckAmu+MuoodC7C7qihTd/DjuxdHhR4t77r+9oKLvJ6Yf
         sinYL/zMA/sFTyYn5t0YT/NLeLxS7dz33bof5EN/aLBY5p0JJW00SRigoB3K5EG4hx8o
         DU1A==
X-Gm-Message-State: AOJu0YwUQJHnXSwnXg1wlSYr4cfafeY1S0EMrMj3oYa6FEZyrzAJ+IVW
	Pn9V0CloVcbNDm3ZV8P4rXj6uFqZLM9q9A==
X-Google-Smtp-Source: AGHT+IGUKz1BDaHYLY4V8HI+s0Ne9ESI/2SdEDtesp36hdf+r0c+hnkD+B/8+v2QB3969e3x/XfReg==
X-Received: by 2002:a05:600c:a3af:b0:40c:361e:a28c with SMTP id hn47-20020a05600ca3af00b0040c361ea28cmr2293046wmb.143.1702312867415;
        Mon, 11 Dec 2023 08:41:07 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:06 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 09/11] doc/netlink/specs: add sub-message type to rt_link family
Date: Mon, 11 Dec 2023 16:40:37 +0000
Message-ID: <20231211164039.83034-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
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
index d86a68f8475c..028a0de8edd1 100644
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
+        sub-message: linkinfo-subordinate-data-msg
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
+    name: linkinfo-subordinate-data-msg
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


