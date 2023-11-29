Return-Path: <netdev+bounces-52086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE627FD3B5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06342B215EE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B389199C4;
	Wed, 29 Nov 2023 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWoH+C92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D010C4;
	Wed, 29 Nov 2023 02:12:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso2933655e9.1;
        Wed, 29 Nov 2023 02:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252757; x=1701857557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNRtIfPDAXy/iSMm8fC7H/C6Gm/957WZE4QOKoqhkm8=;
        b=nWoH+C9281AVuW9e9YsJNRZb2qW+7BatfvwKXT6L1VR8D6nRko3O/4hs/xjpdYDmzr
         VYxvQ4r7hHMxPjk2WejPxj1s4u1bLjmOUUTZ3Bmgk4TsUXNlv7LYyyckc036k5hOIkjO
         M6dmcMtDMuvoN+Y6Bcy6EYFo+fn6/RD48Xq8xn5Qc/T9K6ee8F27r5WMrc01R4bZUVZJ
         QJgoBw5EmGpTd5/stOIcSvARxRInq41+0LdBfOUzj1knIInr64n+UKIB0WW4zb7OGi+C
         UubUj2VDyil2kLPAX8CC/k7tU6PUprVALZj34+oyvkSJYDfGF96xf+jsbvZ10Y6rOaqg
         H8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252757; x=1701857557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNRtIfPDAXy/iSMm8fC7H/C6Gm/957WZE4QOKoqhkm8=;
        b=MnYHyMCgwmd1gAfFkln3aq3lSQlIg0xzwuf4uUR3vQ8S65lzWiOpcbJ3NWFQ5sbmZV
         1a120re3AdUNtY0SBYS+GhIa4pvPEiDiia2uIhCU/ThG7qRyOyuUXqwMTaWSs9zK4YyE
         OMNEazqE0oTfe+bRtj91Nsrk85p58l9C6L9IpJn+PSiBGQUji2dU4HtykC70LAt1GD7V
         1bQAn5FqjsAXRxBcDJTdSnPqfhiM0ro2VwkMmtddcswl6fcqf1plzkSsNIIVDqaiqRpW
         es+mDxn+ESzO4a66GHlRrD5GtQhm3f0Y2zO8nX7rdyZSDaS4pqCyzUadyQVCdflgDrJz
         +xnA==
X-Gm-Message-State: AOJu0YybvLrESrvpnTJKjAkwhIbbZI757Evp5rHXodzX0eqWN099rMzP
	DXwLq98gJXYfgkumRugXiIBIp+QjsC3m5A==
X-Google-Smtp-Source: AGHT+IETEMw6tqKFHXlN1Eyu77dsNeWbiPUtYoSe/Kl2sgyBHIHNIG6G2jcQhuucaX7xnzcW+y4xIQ==
X-Received: by 2002:a05:600c:1f8e:b0:409:247b:b0ae with SMTP id je14-20020a05600c1f8e00b00409247bb0aemr11853226wmb.36.1701252756985;
        Wed, 29 Nov 2023 02:12:36 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:36 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC PATCH net-next v1 4/6] doc/netlink/specs: add dynamic nest selector for rt_link data
Date: Wed, 29 Nov 2023 10:11:57 +0000
Message-ID: <20231129101159.99197-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101159.99197-1-donald.hunter@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to using a dynamic nest selector in the rt_link spec for the
link-specific 'data' attribute.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 278 ++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 1ec6cb6a0d96..498d3ce38c91 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -965,8 +965,46 @@ attribute-sets:
         type: string
       -
         name: data
-        type: binary
-        # kind specific nest, e.g. linkinfo-bridge-attrs
+        type: dynamic
+        selector:
+          attribute: kind
+          list:
+            -
+              value: bridge
+              type: nest
+              nested-attributes: linkinfo-bridge-attrs
+            -
+              value: erspan
+              type: nest
+              nested-attributes: linkinfo-gre-attrs
+            -
+              value: gre
+              type: nest
+              nested-attributes: linkinfo-gre-attrs
+            -
+              value: gretap
+              type: nest
+              nested-attributes: linkinfo-gre-attrs
+            -
+              value: geneve
+              type: nest
+              nested-attributes: linkinfo-geneve-attrs
+            -
+              value: ipip
+              type: nest
+              nested-attributes: linkinfo-iptun-attrs
+            -
+              value: sit
+              type: nest
+              nested-attributes: linkinfo-iptun-attrs
+            -
+              value: tun
+              type: nest
+              nested-attributes: linkinfo-tun-attrs
+            -
+              value: vrf
+              type: nest
+              nested-attributes: linkinfo-vrf-attrs
       -
         name: xstats
         type: binary
@@ -975,10 +1013,10 @@ attribute-sets:
         type: string
       -
         name: slave-data
-        type: binary
-        # kind specific nest
+        type: binary # kind specific nest
   -
     name: linkinfo-bridge-attrs
+    name-prefix: ifla-br-
     attributes:
       -
         name: forward-delay
@@ -1122,6 +1160,238 @@ attribute-sets:
       -
         name: mcast-querier-state
         type: binary
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
-- 
2.42.0


