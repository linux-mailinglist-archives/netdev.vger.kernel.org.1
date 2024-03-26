Return-Path: <netdev+bounces-81879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949188B78D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62FE1C32E83
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C264128807;
	Tue, 26 Mar 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgCUriP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E983127B5C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421050; cv=none; b=eDUOWQoZHXAopX6sJkitp0FsjIuhfGWQag0vOby/kdOPn8HNZViJfkU/EBG+xUR82GsfoxevJEUtUael0AId1wq1XjmzACDxdo+PoxRcIbe5S/A9AI9rBZfMvFjU+W/koWZNg48hIHx43s+pPxREMxDXjRYTcvFNVJSQWWQFca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421050; c=relaxed/simple;
	bh=+2h6UDoj+abyeTPA/SOoPTkVJck5zAVgAaweiJ5HNSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+e9FraUmdWl3BMlqTdqUhHhb30pVGWsuSuv3QCAZWQJ2s+CH+qhc76C7+1TSJscQ+qbnR5mw6Y3RlJIaXfdLSewcxBvyD0su/FZDgpjemvGspZ9w90opNewBb+jiYuglwK7o4Py/yPiLdHzOgLxTD3cvdOMKVVKuvZhQfDruVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgCUriP5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so1988346b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421047; x=1712025847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z6GDA1U0Mv97zX08pGAQIqg+JHkvn/okL+baWjyxlw=;
        b=kgCUriP5qJ70YdRZwIdpHSNPbYK9zWE0QU1LL+7O1nHhCk2cJuFhOF5RhLHRzXsWEg
         /HANSRJzhFjLJy6DrgklVOXkJv4ZttnKB4SPzYjL2vNSCFrnb6fhjdWSPja8maQu8hDG
         ljfSLfvXAaj5efvuU+bcLPVRmzmss7xG0pHVTNDnwGx9zRxkkDAdOZBcuCPzkdkcqxvk
         +inWqGTgyv/ypq3BVjdAyFOyU2xhIc/p/4S/RvhM+M40NDZGp/7s5xMBZ9yA+s5qxGM0
         K++LB/oD1oUOfa/yPB2QFMNlaWRWaLatp5pKd8pShYvRtWMdfZ1diRkaMYq4ezrqOP8s
         Gx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421047; x=1712025847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z6GDA1U0Mv97zX08pGAQIqg+JHkvn/okL+baWjyxlw=;
        b=F67YbfeaVM4eNehR82ChS8h9T8NK0AnEmz4SEX5rEp6WfbMjXp0SALU8TqinIk4bF2
         xKBfXn7m/mZcqvZlghLApMyaTzMSaIwFb0pyvCLaUNxe/sK/E11sOcLF8PoTOQWQbQ6L
         1vQOyJPjmRk1nUNsn+2C99zIFcA3IiCRXUGmwLmAmQ9Z/sRyyc1uLJdP7QwrYpPz0Yqh
         gwX/jgomQUd4+EyWchCsi4GurCAJictJn5AvALgPJJfuc1qzS2suIUB+A1HqxlY4S2WB
         c+9d89ZOYWBPRWuMm+ETOJmgXnZzB7r8KMxpPNVI/wEZnO0GphkjYl4kuyO95A65w8gr
         PiGw==
X-Gm-Message-State: AOJu0YyUbPrSaC2NXrbhg35uJjGyMBCPfs+OiRfG/JXz1/22i/opXuNF
	fmomCFMZqPiOZrIUKD3Gs0HjUEilItEiItC7HNrb1ExYQ1VoTe4UcAgvKrP0IEabMKJU
X-Google-Smtp-Source: AGHT+IF84EM9Xyv6QN9GJtCfuuEoy1ALA2Q2ldK9lS07dqeIZER+PD/dLxDQVFyvTYKBLU76XzOUAw==
X-Received: by 2002:a05:6a21:9210:b0:1a3:b619:4dad with SMTP id tl16-20020a056a21921000b001a3b6194dadmr7983826pzb.0.1711421047145;
        Mon, 25 Mar 2024 19:44:07 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001def088c036sm5499193plg.19.2024.03.25.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:44:06 -0700 (PDT)
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
Subject: [PATCHv2 net-next 2/2] doc/netlink/specs: Add vlan attr in rt_link spec
Date: Tue, 26 Mar 2024 10:43:25 +0800
Message-ID: <20240326024325.2008639-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326024325.2008639-1-liuhangbin@gmail.com>
References: <20240326024325.2008639-1-liuhangbin@gmail.com>
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
     "protocol": "8021Q",
     "id": 2,
     "flag": {
       "flags": [
         "reorder-hdr"
       ],
       "mask": "0xffffffff"
     }
   }
 }

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

v2:
 - Add eth-protocols definitions, but only include vlan protocols (Donald Hunter)
 - Set protocol to big-endian (Donald Hunter)
 - Add display-hint for vlan flag mask (Donald Hunter)
---
 Documentation/netlink/specs/rt_link.yaml | 83 +++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8e4d19adee8c..41b49f15236f 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -50,7 +50,16 @@ definitions:
         name: dormant
       -
         name: echo
-
+  -
+    name: eth-protocols
+    type: enum
+    entries:
+      -
+        name: 8021Q
+        value: 33024
+      -
+        name: 8021AD
+        value: 34984
   -
     name: rtgenmsg
     type: struct
@@ -729,6 +738,43 @@ definitions:
       -
         name: filter-mask
         type: u32
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
+      -
+        name: reorder-hdr
+      -
+        name: gvrp
+      -
+        name: loose-binding
+      -
+        name: mvrp
+      -
+        name: bridge-binding
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
@@ -1507,6 +1553,38 @@ attribute-sets:
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
+        enum: eth-protocols
+        byte-order: big-endian
+  -
+    name: ifla-vlan-qos
+    name-prefix: ifla-vlan-qos
+    attributes:
+      -
+        name: mapping
+        type: binary
+        struct: ifla-vlan-qos-mapping
   -
     name: linkinfo-vrf-attrs
     name-prefix: ifla-vrf-
@@ -1666,6 +1744,9 @@ sub-messages:
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


