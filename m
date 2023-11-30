Return-Path: <netdev+bounces-52717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75897FFDEF
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D801281708
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C55B217;
	Thu, 30 Nov 2023 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2bMpSdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478110F9;
	Thu, 30 Nov 2023 13:50:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333074512bso49226f8f.1;
        Thu, 30 Nov 2023 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701381014; x=1701985814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AK8QepPskxCil5g9Uq2zBTi0Gm4T10NxAWhodYVXSQ=;
        b=T2bMpSdVP/z0dedvvFUpcNNaf365s/C3OWlEZso81766L1Z2/L7ulYgPkguvb8eT2q
         DlhfSpzmxyc6BJZKK0+cJwFtNwFbs/AxDZ77VM4WG5Sra7UC+wo6+lbIfCn8KiR2SHxz
         jENcjj6wi9x6NG7lF7oyqcMTinGplgsfQCSVETAK49Cqst6884yah2fq+sIAj59Jyeaf
         IGC637WLsIwyg6szVumVNJd51kbXYHv5ilptflQHxHD2VZVEyWWvo7ovMVLDypwHlxrJ
         j1XurjQg9MuNnI1DRE3Kn5VjyqNXPN5rkUQMkIDOa2piOJ9F+dXBn7oWzicX2iVbci2l
         SI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381014; x=1701985814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AK8QepPskxCil5g9Uq2zBTi0Gm4T10NxAWhodYVXSQ=;
        b=NtvvvH1UvGd07CWvgEKx0pjs6M0UDSXL3c4PIw0SawOY9GYQixJg9kUZ+itt4gmbBJ
         2qWMThojElMlbV+pF/skc9Z6d2BzN2k53zMHqVlz+UvtxtGu6M8vjjMGPIvZetMKZLJ5
         hwVaCSZalcxWN6ajarFmb7gmRzuXPN86Q9YO6AozMrNAAUD7OhuguSN2RuFh6CIS59MD
         rJfXrZAn2fsOhbzB1Zmfc6jTZEDnkYmnditZST+ZGFxlTWdZySi8NSmxTZU77OBAKmq9
         Cop4tAgP7GXlMP4dPpuiFE0M9yJkFeqdtEMEtjsmxMcsOB3IUD22XYAQnqNn033Oa8ue
         OCrg==
X-Gm-Message-State: AOJu0YwCd5ZmRHlK5PPcocpliZHrBEwam0e5HSDCJFcTmrh0VpTIamlf
	llcK6jUv7bCeRb8lBtCgS40UKRLBMzSodQ==
X-Google-Smtp-Source: AGHT+IGygukuT4amMYOHFuo5nl5Ufe7EodDMml936EklseFJyM0Mc9VSPgC/AN4vtZ46s4PpwC1xiQ==
X-Received: by 2002:a05:6000:1004:b0:333:2d31:50e6 with SMTP id a4-20020a056000100400b003332d3150e6mr113624wrx.14.1701381014485;
        Thu, 30 Nov 2023 13:50:14 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id dd10-20020a0560001e8a00b0032fbe5b1e45sm2519237wrb.61.2023.11.30.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:50:13 -0800 (PST)
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
Subject: [PATCH net-next v1 5/6] doc/netlink/specs: add sub-message type to rt_link family
Date: Thu, 30 Nov 2023 21:49:57 +0000
Message-ID: <20231130214959.27377-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130214959.27377-1-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to using a sub-message selector in the rt_link spec for the
link-specific 'data' attribute.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 273 ++++++++++++++++++++++-
 1 file changed, 269 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index d86a68f8475c..3a6a97b5f50a 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -966,8 +966,9 @@ attribute-sets:
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
@@ -976,10 +977,10 @@ attribute-sets:
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
@@ -1123,6 +1124,238 @@ attribute-sets:
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
@@ -1241,6 +1474,38 @@ attribute-sets:
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
+
 operations:
   enum-model: directional
   list:
-- 
2.42.0


