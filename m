Return-Path: <netdev+bounces-74784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDE862C65
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C081F22024
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1218637;
	Sun, 25 Feb 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoBL8czm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913C1B81F
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883196; cv=none; b=sF3tKORW+J3D8Gt3XM1l7epJQlq6q7qK3/9vTmHkN14ng/z7nIxZX9T8nakCnZkxsHhCIvmYCzn22JEL0u6EilTehkjlhn/UjaH46lwRN+qR+dcP26ac6oO2IgOwGts6WNB0eLStejj4I7IDfRdMQkjZ9tpSnAbOURnMlxnH9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883196; c=relaxed/simple;
	bh=kfe4HpCH0d+q+EvfM6duVEk83pWc0BGQ45dvVujXJvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKs3+6/cVPW7Tws34T9jheQXfsVhxWBBLsOnYWfCXi8xZNfQ5nV8hCgoXFScMoaYNm87QU0PAaRnR8152OgMsa1+78dBKqT/qppO+vUQapO8Wjgc85CON8/pXNFQNBBT+UpCCWxsjUNSAbMAXFwJZn54K9hcIlWQ3jSj2cvZ+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoBL8czm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d244b28b95so24693601fa.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708883192; x=1709487992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6bvvlKB5zwzfC4uoFyEjiBUofV+xlR3N+nGTzzLbrU=;
        b=JoBL8czm8a1MzHsmltYyQV9v9t/+uguyuQMOjW5HRrIIbj2EhtxgQRFARXJugWqcn8
         WOH5rNWprKsETHL6jlxdReYIJjH9ZYdx8VfhhTIXyq3vot27gadyCkUl3+uz+g0sk4k0
         mUOjMhgav7rLRbtGYR6MBf0dzCoRHr70HHkaUDuS8SgndXWCnKv9qBy/xUdiAucs13fU
         iEek8PuTKsawXLBXTnvT8VEcAZhzjIKPJjFkGAw42etcXyxszYAv/zOpHigrTHqd+AkB
         vKY//7EcsgGI1XXHEKAYqGj51Ppes/5Ktt49/+Zvs5dY7mQX1FLDBiN0dyT5IhvQD70t
         OKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883192; x=1709487992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6bvvlKB5zwzfC4uoFyEjiBUofV+xlR3N+nGTzzLbrU=;
        b=SBHyBpLx8+FVCNoTA+negrOqzznQgC4rVUasaqH+n6Yw7sf9k3e1Qz8uMZO6t6ayh9
         khigmQb3mm5afI1SnvAmYH0uwd1eJrzXVIYgq7eAqSAX2S2iHIuudZjE2KPi4WzzNmUk
         RT409qp+DAgSaSGGlSy+Y0bxXueTQ1bckG0gGhHWHKC6MgfFa2XKmpOU8x1ySt6jXMCp
         VhuVUQcto+aFt60TSPsPmybih+EBEO4xAD41fQh4wPzs1nccKBaK7Dg1mdE/KYC99eFP
         fpO+Gc9FDa+7ysR39+iLPzPrOn9GdOL08rRs++RXgf9cCPROJAbuykspcI+zaDUc4gpW
         Q/rw==
X-Gm-Message-State: AOJu0YxHqLR14ykCU1/d06Tt2YBJ/yrY/m787xACYx2QOPJ6HAgmmi2T
	YBu/oj8npLa1srKHNFTfAoex2AmRvuh18GqFeytC66f0HdO/hPXm7Ih/7L96w4E=
X-Google-Smtp-Source: AGHT+IF9yMl3oaHO9OBmLnWWXTGHsBkGJVPIYE5k8LceAAFEiwIqPrT2tB7Bb8RfC7XMk4tnsszBrQ==
X-Received: by 2002:a2e:a984:0:b0:2d2:8048:884e with SMTP id x4-20020a2ea984000000b002d28048884emr2694698ljq.7.1708883191575;
        Sun, 25 Feb 2024 09:46:31 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:907c:51fb:7b4f:c84f])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b0033b60bad2fcsm5558729wrp.113.2024.02.25.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:46:30 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC net-next 4/4] doc/netlink/specs: Add draft nftables spec
Date: Sun, 25 Feb 2024 17:46:19 +0000
Message-ID: <20240225174619.18990-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240225174619.18990-1-donald.hunter@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a spec for nftables that has nearly complete coverage of the ops,
but limited coverage of rule types and subexpressions.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 1292 +++++++++++++++++++++
 1 file changed, 1292 insertions(+)
 create mode 100644 Documentation/netlink/specs/nftables.yaml

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
new file mode 100644
index 000000000000..74157f296f71
--- /dev/null
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -0,0 +1,1292 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nftables
+protocol: netlink-raw
+protonum: 12
+
+doc:
+  Netfilter nftables configuration over netlink.
+
+definitions:
+  -
+    name: nfgenmsg
+    type: struct
+    members:
+      -
+        name: nfgen-family
+        type: u8
+      -
+        name: version
+        type: u8
+      -
+        name: res-id
+        byte-order: big-endian
+        type: u16
+  -
+    name: meta-keys
+    type: enum
+    entries:
+      - len
+      - protocol
+      - priority
+      - mark
+      - iif
+      - oif
+      - iifname
+      - oifname
+      - iftype
+      - oiftype
+      - skuid
+      - skgid
+      - nftrace
+      - rtclassid
+      - secmark
+      - nfproto
+      - l4-proto
+      - bri-iifname
+      - bri-oifname
+      - pkttype
+      - cpu
+      - iifgroup
+      - oifgroup
+      - cgroup
+      - prandom
+      - secpath
+      - iifkind
+      - oifkind
+      - bri-iifpvid
+      - bri-iifvproto
+      - time-ns
+      - time-day
+      - time-hour
+      - sdif
+      - sdifname
+      - bri-broute
+  -
+    name: cmp-ops
+    type: enum
+    entries:
+      - eq
+      - neq
+      - lt
+      - lte
+      - gt
+      - gte
+  -
+    name: object-type
+    type: enum
+    entries:
+      - unspec
+      - counter
+      - quota
+      - ct-helper
+      - limit
+      - connlimit
+      - tunnel
+      - ct-timeout
+      - secmark
+      - ct-expect
+      - synproxy
+  -
+    name: nat-range-flags
+    type: flags
+    entries:
+      - map-ips
+      - proto-specified
+      - proto-random
+      - persistent
+      - proto-random-fully
+      - proto-offset
+      - netmap
+  -
+    name: table-flags
+    type: flags
+    entries:
+      - dormant
+      - owner
+  -
+    name: chain-flags
+    type: flags
+    entries:
+      - base
+      - hw-offload
+      - binding
+  -
+    name: set-flags
+    type: flags
+    entries:
+      - anonymous
+      - constant
+      - interval
+      - map
+      - timeout
+      - eval
+      - object
+      - concat
+      - expr
+
+attribute-sets:
+  -
+    name: empty-attrs
+    attributes:
+      -
+        name: name
+        type: string
+  -
+    name: batch-attrs
+    attributes:
+      -
+        name: genid
+        type: u32
+        byte-order: big-endian
+  -
+    name: table-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: name of the table
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        doc: bitmask of flags
+        enum: table-flags
+        enum-as-flags: true
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of chains in this table
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the table
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: chain-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the chain
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the chain
+      -
+        name: name
+        type: string
+        doc: name of the chain
+      -
+        name: hook
+        type: nest
+        nested-attributes: nft-hook-attrs
+        doc: hook specification for basechains
+      -
+        name: policy
+        type: u32
+        byte-order: big-endian
+        doc: numeric policy of the chain
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of references to this chain
+      -
+        name: type
+        type: string
+        doc: type name of the chain
+      -
+        name: counters
+        type: nest
+        nested-attributes: nft-counter-attrs
+        doc: counter specification of the chain
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        doc: chain flags
+        enum: chain-flags
+        enum-as-flags: true
+      -
+        name: id
+        type: u32
+        byte-order: big-endian
+        doc: uniquely identifies a chain in a transaction
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        byte-order: big-endian
+      -
+        name: packets
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+  -
+    name: nft-hook-attrs
+    attributes:
+      -
+        name: num
+        type: u32
+        byte-order: big-endian
+      -
+        name: priority
+        type: s32
+        byte-order: big-endian
+      -
+        name: dev
+        type: string
+        doc: net device name
+      -
+        name: devs
+        type: nest
+        nested-attributes: hook-dev-attrs
+        doc: list of net devices
+  -
+    name: hook-dev-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        multi-attr: true
+  -
+    name: nft-counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+      -
+        name: packets
+        type: u64
+  -
+    name: rule-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the rule
+      -
+        name: chain
+        type: string
+        doc: name of the chain containing the rule
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the rule
+      -
+        name: expressions
+        type: nest
+        nested-attributes: expr-list-attrs
+        doc: list of expressions
+      -
+        name: compat
+        type: nest
+        nested-attributes: rule-compat-attrs
+        doc: compatibility specifications of the rule
+      -
+        name: position
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the previous rule
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: id
+        type: u32
+        doc: uniquely identifies a rule in a transaction
+      -
+        name: position-id
+        type: u32
+        doc: transaction unique identifier of the previous rule
+      -
+        name: chain-id
+        type: u32
+        doc: add the rule to chain by ID, alternative to chain name
+  -
+    name: expr-list-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: expr-attrs
+        multi-attr: true
+  -
+    name: expr-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: name of the expression type
+      -
+        name: data
+        type: sub-message
+        sub-message: expr-ops
+        selector: name
+        doc: type specific data
+  -
+    name: rule-compat-attrs
+    attributes:
+      -
+        name: proto
+        type: binary
+        doc: numeric value of the handled protocol
+      -
+        name: flags
+        type: binary
+        doc: bitmask of flags
+  -
+    name: set-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: table name
+      -
+        name: name
+        type: string
+        doc: set name
+      -
+        name: flags
+        type: u32
+        enum: set-flags
+        byte-order: big-endian
+        doc: bitmask of enum nft_set_flags
+      -
+        name: key-type
+        type: u32
+        byte-order: big-endian
+        doc: key data type, informational purpose only
+      -
+        name: key-len
+        type: u32
+        byte-order: big-endian
+        doc: key data length
+      -
+        name: data-type
+        type: u32
+        byte-order: big-endian
+        doc: mapping data type
+      -
+        name: data-len
+        type: u32
+        byte-order: big-endian
+        doc: mapping data length
+      -
+        name: policy
+        type: u32
+        byte-order: big-endian
+        doc: selection policy
+      -
+        name: desc
+        type: nest
+        nested-attributes: set-desc-attrs
+        doc: set description
+      -
+        name: id
+        type: u32
+        doc: uniquely identifies a set in a transaction
+      -
+        name: timeout
+        type: u64
+        doc: default timeout value
+      -
+        name: gc-interval
+        type: u32
+        doc: garbage collection interval
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: pad
+        type: pad
+      -
+        name: obj-type
+        type: u32
+        byte-order: big-endian
+        doc: stateful object type
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: set handle
+      -
+        name: expr
+        type: nest
+        nested-attributes: expr-attrs
+        doc: set expression
+        multi-attr: true
+      -
+        name: expressions
+        type: nest
+        nested-attributes: set-list-attrs
+        doc: list of expressions
+  -
+    name: set-desc-attrs
+    attributes:
+      -
+        name: size
+        type: u32
+        byte-order: big-endian
+        doc: number of elements in set
+      -
+        name: concat
+        type: nest
+        nested-attributes: set-desc-concat-attrs
+        doc: description of field concatenation
+        multi-attr: true
+  -
+    name: set-desc-concat-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: set-field-attrs
+  -
+    name: set-field-attrs
+    attributes:
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+  -
+    name: set-list-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: expr-attrs
+        multi-attr: true
+  -
+    name: setelem-attrs
+    attributes:
+      -
+        name: key
+        type: nest
+        nested-attributes: data-attrs
+        doc: key value
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+        doc: data value of mapping
+      -
+        name: flags
+        type: binary
+        doc: bitmask of nft_set_elem_flags
+      -
+        name: timeout
+        type: u64
+        doc: timeout value
+      -
+        name: expiration
+        type: u64
+        doc: expiration time
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: expr
+        type: nest
+        nested-attributes: expr-attrs
+        doc: expression
+      -
+        name: objref
+        type: string
+        doc: stateful object reference
+      -
+        name: key-end
+        type: nest
+        nested-attributes: TODO
+        doc: closing key value
+      -
+        name: expressions
+        type: nest
+        nested-attributes: list-attrs
+        doc: list of expressions
+  -
+    name: setelem-list-elem-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: setelem-attrs
+        multi-attr: true
+  -
+    name: setelem-list-attrs
+    attributes:
+      -
+        name: table
+        type: string
+      -
+        name: set
+        type: string
+      -
+        name: elements
+        type: nest
+        nested-attributes: setelem-list-elem-attrs
+      -
+        name: set-id
+        type: u32
+  -
+    name: gen-attrs
+    attributes:
+      -
+        name: id
+        type: u32
+        byte-order: big-endian
+        doc: ruleset generation id
+      -
+        name: proc-pid
+        type: u32
+        byte-order: big-endian
+      -
+        name: proc-name
+        type: string
+  -
+    name: obj-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the expression
+      -
+        name: name
+        type: string
+        doc: name of this expression type
+      -
+        name: type
+        type: u32
+        enum: object-type
+        byte-order: big-endian
+        doc: stateful object type
+      -
+        name: data
+        type: sub-message
+        sub-message: obj-data
+        selector: type
+        doc: stateful object data
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of references to this expression
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: object handle
+      -
+        name: pad
+        type: pad
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: quota-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        byte-order: big-endian
+      -
+        name: flags # TODO
+        type: u32
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: consumed
+        type: u64
+        byte-order: big-endian
+  -
+    name: flowtable-attrs
+    attributes:
+      -
+        name: table
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: hook
+        type: nest
+        nested-attributes: flowtable-hook-attrs
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+  -
+    name: flowtable-hook-attrs
+    attributes:
+      -
+        name: num
+        type: u32
+        byte-order: big-endian
+      -
+        name: priority
+        type: u32
+        byte-order: big-endian
+      -
+        name: devs
+        type: nest
+        nested-attributes: hook-dev-attrs
+  -
+    name: expr-cmp-attrs
+    attributes:
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: op
+        type: u32
+        byte-order: big-endian
+        enum: cmp-ops
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+  -
+    name: data-attrs
+    attributes:
+      -
+        name: value
+        type: binary
+        # sub-type: u8
+      -
+        name: verdict
+        type: nest
+        nested-attributes: verdict-attrs
+  -
+    name: verdict-attrs
+    attributes:
+      -
+        name: code
+        type: u32
+        byte-order: big-endian
+      -
+        name: chain
+        type: string
+      -
+        name: chain-id
+        type: u32
+  -
+    name: expr-counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        doc: Number of bytes
+      -
+        name: packets
+        type: u64
+        doc: Number of packets
+      -
+        name: pad
+        type: pad
+  -
+    name: expr-flow-offload-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: Flow offload table name
+  -
+    name: expr-immediate-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+  -
+    name: expr-meta-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: key
+        type: u32
+        byte-order: big-endian
+        enum: meta-keys
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-nat-attrs
+    attributes:
+      -
+        name: type
+        type: u32
+        byte-order: big-endian
+      -
+        name: family
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-proto-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-proto-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: nat-range-flags
+        enum-as-flags: true
+  -
+    name: expr-payload-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: base
+        type: u32
+        byte-order: big-endian
+      -
+        name: offset
+        type: u32
+        byte-order: big-endian
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-type
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-offset
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-flags
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-tproxy-attrs
+    attributes:
+      -
+        name: family
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-port
+        type: u32
+        byte-order: big-endian
+
+sub-messages:
+  -
+    name: expr-ops
+    formats:
+      -
+        value: bitwise # TODO
+      -
+        value: cmp
+        attribute-set: expr-cmp-attrs
+      -
+        value: counter
+        attribute-set: expr-counter-attrs
+      -
+        value: ct # TODO
+      -
+        value: flow_offload
+        attribute-set: expr-flow-offload-attrs
+      -
+        value: immediate
+        attribute-set: expr-immediate-attrs
+      -
+        value: lookup # TODO
+      -
+        value: meta
+        attribute-set: expr-meta-attrs
+      -
+        value: nat
+        attribute-set: expr-nat-attrs
+      -
+        value: payload
+        attribute-set: expr-payload-attrs
+      -
+        value: tproxy
+        attribute-set: expr-tproxy-attrs
+  -
+    name: obj-data
+    formats:
+      -
+        value: counter
+        attribute-set: counter-attrs
+      -
+        value: quota
+        attribute-set: quota-attrs
+
+operations:
+  enum-model: directional
+  begin-batch:
+    operation: batch-begin
+    parameters:
+      res-id: 10
+  end-batch:
+    operation: batch-end
+    parameters:
+      res-id: 10
+  list:
+    -
+      name: batch-begin
+      doc: Start a batch of operations
+      attribute-set: batch-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0x10
+          attributes:
+            - genid
+        reply:
+          value: 0x10
+          attributes:
+            - genid
+    -
+      name: batch-end
+      doc: Finish a batch of operations
+      attribute-set: batch-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0x11
+          attributes:
+            - genid
+    -
+      name: newtable
+      doc: Create a new table.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa00
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: gettable
+      doc: Get / dump tables.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa01
+          attributes:
+            - name
+        reply:
+          value: 0xa00
+          attributes:
+            - name
+    -
+      name: deltable
+      doc: Delete an existing table.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa02
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroytable
+      doc: Delete an existing table with destroy semantics (ignoring ENOENT errors).
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1a
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: newchain
+      doc: Create a new chain.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa03
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getchain
+      doc: Get / dump chains.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa04
+          attributes:
+            - name
+        reply:
+          value: 0xa03
+          attributes:
+            - name
+    -
+      name: delchain
+      doc: Delete an existing chain.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa05
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroychain
+      doc: Delete an existing chain with destroy semantics (ignoring ENOENT errors).
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1b
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: newrule
+      doc: Create a new rule.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa06
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getrule
+      doc: Get / dump rules.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa07
+          attributes:
+            - name
+        reply:
+          value: 0xa06
+          attributes:
+            - name
+    -
+      name: getrule-reset
+      doc: Get / dump rules and reset stateful expressions.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa19
+          attributes:
+            - name
+        reply:
+          value: 0xa06
+          attributes:
+            - name
+    -
+      name: delrule
+      doc: Delete an existing rule.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa08
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroyrule
+      doc: Delete an existing rule with destroy semantics (ignoring ENOENT errors).
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1c
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: newset
+      doc: Create a new set.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa09
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getset
+      doc: Get / dump sets.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0a
+          attributes:
+            - name
+        reply:
+          value: 0xa09
+          attributes:
+            - name
+    -
+      name: delset
+      doc: Delete an existing set.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0b
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroyset
+      doc: Delete an existing set with destroy semantics (ignoring ENOENT errors).
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1d
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: newsetelem
+      doc: Create a new set element.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0c
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getsetelem
+      doc: Get / dump set elements.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0d
+          attributes:
+            - name
+        reply:
+          value: 0xa0c
+          attributes:
+            - name
+    -
+      name: getsetelem-reset
+      doc: Get / dump set elements and reset stateful expressions.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa21
+          attributes:
+            - name
+        reply:
+          value: 0xa0c
+          attributes:
+            - name
+    -
+      name: delsetelem
+      doc: Delete an existing set element.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0e
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroysetelem
+      doc: Delete an existing set element with destroy semantics.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1e
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getgen
+      doc: Get / dump rule-set generation.
+      attribute-set: gen-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa10
+          attributes:
+            - name
+        reply:
+          value: 0xa0f
+          attributes:
+            - name
+    -
+      name: newobj
+      doc: Create a new stateful object.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa12
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getobj
+      doc: Get / dump stateful objects.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa13
+          attributes:
+            - name
+        reply:
+          value: 0xa12
+          attributes:
+            - name
+    -
+      name: delobj
+      doc: Delete an existing stateful object.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa14
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroyobj
+      doc: Delete an existing stateful object with destroy semantics.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1f
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: newflowtable
+      doc: Create a new flow table.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa16
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: getflowtable
+      doc: Get / dump flow tables.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa17
+          attributes:
+            - name
+        reply:
+          value: 0xa16
+          attributes:
+            - name
+    -
+      name: delflowtable
+      doc: Delete an existing flow table.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa18
+          is-batch: True
+          attributes:
+            - name
+    -
+      name: destroyflowtable
+      doc: Delete an existing flow table with destroy semantics.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa20
+          is-batch: True
+          attributes:
+            - name
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
-- 
2.42.0


