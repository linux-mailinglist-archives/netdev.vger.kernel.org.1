Return-Path: <netdev+bounces-82465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D488E4A8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BA281392
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5912EBCE;
	Wed, 27 Mar 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPgLbVyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1A1EF0D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542710; cv=none; b=t878A9BGiTVorA38F1klrSSsU+Zm+aOjksmc1b8ReIVTk7Y+J2wgLGVrc6eDMwWZQnroUUg8m2VWbanwSUF4vR+a+yuJTXFdjgUvXearFTivjnPw4nDaNwY86YuMvmTNfVNV7v+JR663oCr5XQZLUxWQ4IomKUtBIBvmQWycHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542710; c=relaxed/simple;
	bh=R5dmpsAMWJZ29k7krm/vAFrzPjEWM20cOR1D6qiEdCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSmv9cqt9/Oo0KJE3IoNNlQXogDnjIWTPaC5N/z3EysI67LbEddrwypVmmzp2sW2u0jAQ7WxsMndgzTfxgH3gqo7BdHARa+SxQ3fYPNhVXX30a/TIkYaUOwUXg0fOZ+ZvhKZqYCRMctAm+tTeCqfvrBHPxc7ol5OQJp2G0r4ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPgLbVyZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0878b76f3so6647295ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711542708; x=1712147508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzSDuj4+MczrI+iCc3I4wXOJsqZz8d0kjIIpIQGRFPE=;
        b=iPgLbVyZx1LIgycQ/KMBqXjwDZt0Y6OG4gX6oGeja+OtdBrUtzRhLFhX8y3XytIImW
         vB6V1HObJNmXxj5tuw07YP9ybPbWn2Od75VP5HHKaBGzlInRRtLSq1IXQ65yCDBJllLo
         V2+LjGg3tc2wmaZqryOfKZBiheTpRH7ljUCK8GOrPamuv3S73jWygDybHoTppDHjgNpW
         pyrcGy1nbV1w5oiDp9fsFx/v2BXqIlwa2BoCK62q1cnxvsGLJe7T3DU8ZaIj2Qu3w77l
         Iu24l++EDePPGe9iSC2f9N8lcX8TXYalqCr8zjIbgViZ7cIdVBSUPo1wTGlE0AgixW8G
         SeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711542708; x=1712147508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzSDuj4+MczrI+iCc3I4wXOJsqZz8d0kjIIpIQGRFPE=;
        b=rBIldSJ9epofoqx4jpAekng6pTkCaEC7wlUkf8SJiMaNEev0mjJL9zyJEfR2JpX1Rj
         RliMpzv0rRVD32NxFZGi7kTIL3nJiyn9GPmTmmMJHcUpOVsgylqOfpTYUH6XRjB48t3t
         BJOzwmd7Eu/OzDw6K2wTloH2ZrrWhVDJx8qNXK7nmDT2sC6UptWTcrttGS2kgDZK8mbq
         STcnWD35Z5JmnAf1gGTz8two7HzSL878aonboCzOiYznm7q8pIX00Zyrxalt0yAO4XNG
         8ZwSGIksdL0hkh3XJ9RGJ19dx27OY9wcwR+OIsBdmZSFi4nmZ2ax3xZF3+ru8zI6/S2L
         TCiQ==
X-Gm-Message-State: AOJu0YxcpmXxlUImrPTP4m1SoGNhTRzXmWMx1RzNS4FCtHIsmUzSWY9Q
	7lXo1clDQNhyhhnAiaxrrctUyR9Km0JywjiHER5GkLlfDdFHRn1/J0+qttmFO/9v6xAJ
X-Google-Smtp-Source: AGHT+IG2v4zW+JbY8/L3njlDOiPXCQ4m4zRrnuqYz69sJaSAZR3urcqx9RIeSGtbjB9IDE/Y0CheHA==
X-Received: by 2002:a17:902:d2cc:b0:1e0:dc6e:45ed with SMTP id n12-20020a170902d2cc00b001e0dc6e45edmr7403948plc.15.1711542708108;
        Wed, 27 Mar 2024 05:31:48 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709027c1100b001e197cfe08fsm1356771pll.59.2024.03.27.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:31:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/2] doc/netlink/specs: Add vlan attr in rt_link spec
Date: Wed, 27 Mar 2024 20:31:29 +0800
Message-ID: <20240327123130.1322921-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327123130.1322921-1-liuhangbin@gmail.com>
References: <20240327123130.1322921-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With command:
 # ./tools/net/ynl/cli.py \
 --spec Documentation/netlink/specs/rt_link.yaml \
 --do getlink --json '{"ifname": "eno1.2"}' --output-json | \
 jq -C '.linkinfo'

Before:
Exception: No message format for 'vlan' in sub-message spec 'linkinfo-data-msg'

After:
 {
   "kind": "vlan",
   "data": {
     "protocol": "8021q",
     "id": 2,
     "flag": {
       "flags": [
         "reorder-hdr"
       ],
       "mask": "0xffffffff"
     },
     "egress-qos": {
       "mapping": [
         {
           "from": 1,
           "to": 2
         },
         {
           "from": 4,
           "to": 4
         }
       ]
     }
   }
 }

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3:
 - lower case vlan protocols (Donald Hunter)
 - use abbreviated form for vlan flags (Donald Hunter)
 - set ifla-vlan-qos as multi-attr (Donald Hunter)
v2:
 - Add eth-protocols definitions, but only include vlan protocols (Donald Hunter)
 - Set protocol to big-endian (Donald Hunter)
 - Add display-hint for vlan flag mask (Donald Hunter)
---
 Documentation/netlink/specs/rt_link.yaml | 80 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8e4d19adee8c..81a5a3d1b04d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -50,7 +50,16 @@ definitions:
         name: dormant
       -
         name: echo
-
+  -
+    name: vlan-protocols
+    type: enum
+    entries:
+      -
+        name: 8021q
+        value: 33024
+      -
+        name: 8021ad
+        value: 34984
   -
     name: rtgenmsg
     type: struct
@@ -729,7 +738,38 @@ definitions:
       -
         name: filter-mask
         type: u32
-
+  -
+    name: ifla-vlan-flags
+    type: struct
+    members:
+      -
+        name: flags
+        type: u32
+        enum: vlan-flags
+        enum-as-flags: true
+      -
+        name: mask
+        type: u32
+        display-hint: hex
+  -
+    name: vlan-flags
+    type: flags
+    entries:
+      - reorder-hdr
+      - gvrp
+      - loose-binding
+      - mvrp
+      - bridge-binding
+  -
+    name: ifla-vlan-qos-mapping
+    type: struct
+    members:
+      -
+        name: from
+        type: u32
+      -
+        name: to
+        type: u32
 
 attribute-sets:
   -
@@ -1507,6 +1547,39 @@ attribute-sets:
       -
         name: num-disabled-queues
         type: u32
+  -
+    name: linkinfo-vlan-attrs
+    name-prefix: ifla-vlan-
+    attributes:
+      -
+        name: id
+        type: u16
+      -
+        name: flag
+        type: binary
+        struct: ifla-vlan-flags
+      -
+        name: egress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: ingress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: protocol
+        type: u16
+        enum: vlan-protocols
+        byte-order: big-endian
+  -
+    name: ifla-vlan-qos
+    name-prefix: ifla-vlan-qos
+    attributes:
+      -
+        name: mapping
+        type: binary
+        multi-attr: true
+        struct: ifla-vlan-qos-mapping
   -
     name: linkinfo-vrf-attrs
     name-prefix: ifla-vrf-
@@ -1666,6 +1739,9 @@ sub-messages:
       -
         value: tun
         attribute-set: linkinfo-tun-attrs
+      -
+        value: vlan
+        attribute-set: linkinfo-vlan-attrs
       -
         value: vrf
         attribute-set: linkinfo-vrf-attrs
-- 
2.43.0


