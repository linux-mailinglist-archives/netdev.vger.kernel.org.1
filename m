Return-Path: <netdev+bounces-55399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A680AC02
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C45828193C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA947A66;
	Fri,  8 Dec 2023 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDxLq6U+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF9190
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:25:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2886576cf18so1954720a91.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 10:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059927; x=1702664727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGwghp9wX6q8DiGZDn6m01YZkqTo8rruiIntryahyDQ=;
        b=SDxLq6U+ZFC3INPH0DPaOXlEuh6E1eQSrnZhlFl5PdVChc8TbvnjPdwyooxxfe1Gj9
         ZnyFvaqyttjaxNwfHnl0dMf2c881x4xxDUw0wZOVtvwk3bauyRRdL4Als+ffDjAN1NnE
         17FiGgf9Waquo4p9vbomsTD/b6uVpxAL0PcydFx6u7L4lKBq8Bu6FF2iaCkmlKpi7fqV
         AKHaiYYctQjxe+JSlWglawz7pQ/oX59i2pLRfx3R5VBZgOwAdd1eLvoS4b1LEDBMkf3q
         cDBUe+ijXcVrmXPzgZ02HWf3QiN+y0tu/sJ8pKXqwpHPr50trK048c33S4Ov0zdT072t
         vU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059927; x=1702664727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGwghp9wX6q8DiGZDn6m01YZkqTo8rruiIntryahyDQ=;
        b=tn0B99Uv1/lLkZNxz8sxS3BmhFMzJbYl2p7prcBeQsATqxeW4Quec5McG1LZpzhitI
         BzeJDjkVyAbdLhdJCRiba3Ugzp5iqWbYf9oD3xp8crW/BmKJVjHcEaip+gUjd45CTuwC
         7orGJvAdlJZUJq01F2F1/s0WmrU5J7uwIrEj/qxRCD5xXX4LOQ1rOvKcqNpTUSqBb/Eo
         XGixSFNjj1Q3VCZKqTYpdKZyClS9hC3cWtSnb53oa7Tso42/wuUC9f3CM1I/oNEJCN2G
         X8Yy3fLm5userUR/em6q3znlGNyzEuYRL3R/aUbLFS0/qnSULOVmBeaIXVQQJdrWAg3q
         G+zA==
X-Gm-Message-State: AOJu0Yzqqw6VRgwkDpid8yO2m3Tdy/9bBq13/c1c4fyzUzkKaVQ56ieG
	FraJeUdFzr89ReAGJRHTta8=
X-Google-Smtp-Source: AGHT+IFD33QYphz38FggvY20dGd886Gi+zdQ7beV7ICatCKITX6+3QEvwc/e4HZJpMX9G7bz7/MY0w==
X-Received: by 2002:a17:90b:3598:b0:286:6cc1:278 with SMTP id mm24-20020a17090b359800b002866cc10278mr512719pjb.67.1702059926490;
        Fri, 08 Dec 2023 10:25:26 -0800 (PST)
Received: from swarup-virtual-machine.localdomain ([171.76.80.2])
        by smtp.gmail.com with ESMTPSA id gb21-20020a17090b061500b002804af3afb7sm3641908pjb.49.2023.12.08.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:25:25 -0800 (PST)
From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH net-next v6] netlink: specs: devlink: add some(not all) missing attributes in devlink.yaml
Date: Fri,  8 Dec 2023 23:55:15 +0530
Message-Id: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some missing(not all) attributes in devlink.yaml.

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
---
V6:
  - Fix review comments
V5:
  - https://lore.kernel.org/all/20231202123048.1059412-1-swarupkotikalapudi@gmail.com/
    Keep stats enum as unnamed in /uapi/linux/devlink.h
    to avoid kernel build failure
V4: https://lore.kernel.org/all/20231126105246.195288-1-swarupkotikalapudi@gmail.com/
  - Change the commit message
V3: https://lore.kernel.org/all/20231123100119.148324-1-swarupkotikalapudi@gmail.com/
  - enum name added for stats and trap-metadata enum used by trap command
    in include/uapi/linux/devlink.h
  - Fix generated userspace file's compilation issue
    due to V1 and V2 patchset
  - Move some attributes e.g. nested-devlink and param again as a TODO,
    which needs some discussion and will be fixed in a new patchset
V2: https://lore.kernel.org/all/20231122143033.89856-1-swarupkotikalapudi@gmail.com/
  - Rebase to net-next tree
  - param-value-data data type is dynamic, hence to accomndate
    all data type make it as string type
  - Change nested attribute to use correct fields
    based on driver code e.g. region-snapshots,
    region-snapshot, region-chunks, region-chunk,
    linecard-supported-types, health-reporter,
    linecard-supported-types, nested-devlink
    and param's attributes
V1: https://lore.kernel.org/all/ZVNPi7pmJIDJ6Ms7@swarup-virtual-machine/

 Documentation/netlink/specs/devlink.yaml | 377 +++++++++++++++++------
 1 file changed, 288 insertions(+), 89 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 43067e1f63aa..c3a438197964 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -75,6 +75,14 @@ definitions:
         name: ipsec-crypto-bit
       -
         name: ipsec-packet-bit
+  -
+    type: enum
+    name: rate-type
+    entries:
+      -
+        name: leaf
+      -
+        name: node
   -
     type: enum
     name: sb-threshold-type
@@ -111,6 +119,16 @@ definitions:
         name: none
       -
         name: basic
+  -
+    type: enum
+    name: dpipe-header-id
+    entries:
+      -
+        name: ethernet
+      -
+        name: ipv4
+      -
+        name: ipv6
   -
     type: enum
     name: dpipe-match-type
@@ -174,6 +192,16 @@ definitions:
         name: trap
       -
         name: mirror
+  -
+    type: enum
+    name: trap-type
+    entries:
+      -
+        name: drop
+      -
+        name: exception
+      -
+        name: control
 
 attribute-sets:
   -
@@ -194,27 +222,45 @@ attribute-sets:
         name: port-type
         type: u16
         enum: port-type
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-desired-type
+        type: u16
+      -
+        name: port-netdev-ifindex
+        type: u32
+      -
+        name: port-netdev-name
+        type: string
+      -
+        name: port-ibdev-name
+        type: string
       -
         name: port-split-count
         type: u32
-        value: 9
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-split-group
+        type: u32
       -
         name: sb-index
         type: u32
-        value: 11
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-size
+        type: u32
+      -
+        name: sb-ingress-pool-count
+        type: u16
+      -
+        name: sb-egress-pool-count
+        type: u16
+      -
+        name: sb-ingress-tc-count
+        type: u16
+      -
+        name: sb-egress-tc-count
+        type: u16
       -
         name: sb-pool-index
         type: u16
-        value: 17
       -
         name: sb-pool-type
         type: u8
@@ -232,16 +278,16 @@ attribute-sets:
       -
         name: sb-tc-index
         type: u16
-        value: 22
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-occ-cur
+        type: u32
+      -
+        name: sb-occ-max
+        type: u32
       -
         name: eswitch-mode
         type: u16
-        value: 25
         enum: eswitch-mode
-
       -
         name: eswitch-inline-mode
         type: u16
@@ -347,6 +393,7 @@ attribute-sets:
       -
         name: dpipe-header-id
         type: u32
+        enum: dpipe-header-id
       -
         name: dpipe-header-fields
         type: nest
@@ -381,7 +428,6 @@ attribute-sets:
       -
         name: eswitch-encap-mode
         type: u8
-        value: 62
         enum: eswitch-encap-mode
       -
         name: resource-list
@@ -433,20 +479,25 @@ attribute-sets:
         name: port-flavour
         type: u16
         enum: port-flavour
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-number
+        type: u32
+      -
+        name: port-split-subport-number
+        type: u32
+      -
+        name: param
+        type: nest
+        nested-attributes: dl-param
       -
         name: param-name
         type: string
-        value: 81
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: param-generic
+        type: flag
       -
         name: param-type
         type: u8
-        value: 83
 
       # TODO: fill in the attributes in between
 
@@ -458,20 +509,34 @@ attribute-sets:
       -
         name: region-name
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: region-size
+        type: u64
+      -
+        name: region-snapshots
+        type: nest
+        nested-attributes: dl-region-snapshots
+      -
+        name: region-snapshot
+        type: nest
+        nested-attributes: dl-region-snapshot
       -
         name: region-snapshot-id
         type: u32
-        value: 92
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: region-chunks
+        type: nest
+        nested-attributes: dl-region-chunks
+      -
+        name: region-chunk
+        type: nest
+        nested-attributes: dl-region-chunk
+      -
+        name: region-chunk-data
+        type: binary
       -
         name: region-chunk-addr
         type: u64
-        value: 96
       -
         name: region-chunk-len
         type: u64
@@ -502,14 +567,13 @@ attribute-sets:
       -
         name: info-version-value
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-pool-cell-size
+        type: u32
       -
         name: fmsg
         type: nest
         nested-attributes: dl-fmsg
-        value: 106
       -
         name: fmsg-obj-nest-start
         type: flag
@@ -525,20 +589,35 @@ attribute-sets:
       -
         name: fmsg-obj-name
         type: string
+      -
+        name: fmsg-obj-value-type
+        type: u8
 
       # TODO: fill in the attributes in between
 
+      -
+        name: health-reporter
+        type: nest
+        value: 114
+        nested-attributes: dl-health-reporter
       -
         name: health-reporter-name
         type: string
-        value: 115
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: health-reporter-state
+        type: u8
+      -
+        name: health-reporter-err-count
+        type: u64
+      -
+        name: health-reporter-recover-count
+        type: u64
+      -
+        name: health-reporter-dump-ts
+        type: u64
       -
         name: health-reporter-graceful-period
         type: u64
-        value: 120
       -
         name: health-reporter-auto-recover
         type: u8
@@ -548,55 +627,64 @@ attribute-sets:
       -
         name: flash-update-component
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: flash-update-status-msg
+        type: string
+      -
+        name: flash-update-status-done
+        type: u64
+      -
+        name: flash-update-status-total
+        type: u64
       -
         name: port-pci-pf-number
         type: u16
-        value: 127
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-pci-vf-number
+        type: u16
+      -
+        name: stats
+        type: nest
+        nested-attributes: dl-attr-stats
       -
         name: trap-name
         type: string
-        value: 130
       -
         name: trap-action
         type: u8
         enum: trap-action
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: trap-type
+        type: u8
+        enum: trap-type
+      -
+        name: trap-generic
+        type: flag
+      -
+        name: trap-metadata
+        type: nest
+        nested-attributes: dl-trap-metadata
       -
         name: trap-group-name
         type: string
-        value: 135
-
       -
         name: reload-failed
         type: u8
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: health-reporter-dump-ts-ns
+        type: u64
       -
         name: netns-fd
         type: u32
-        value: 138
       -
         name: netns-pid
         type: u32
       -
         name: netns-id
         type: u32
-
-      # TODO: fill in the attributes in between
-
       -
         name: health-reporter-auto-dump
         type: u8
-        value: 141
       -
         name: trap-policer-id
         type: u32
@@ -610,22 +698,29 @@ attribute-sets:
         name: port-function
         type: nest
         nested-attributes: dl-port-function
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: info-board-serial-number
+        type: string
+      -
+        name: port-lanes
+        type: u32
+      -
+        name: port-splittable
+        type: u8
+      -
+        name: port-external
+        type: u8
       -
         name: port-controller-number
         type: u32
-        value: 150
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: flash-update-status-timeout
+        type: u64
       -
         name: flash-update-overwrite-mask
         type: bitfield32
         enum: flash-overwrite
         enum-as-flags: True
-        value: 152
       -
         name: reload-action
         type: u8
@@ -673,20 +768,16 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: dl-reload-act-stats
-
-      # TODO: fill in the attributes in between
-
       -
         name: port-pci-sf-number
         type: u32
-        value: 164
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: rate-type
+        type: u16
+        enum: rate-type
       -
         name: rate-tx-share
         type: u64
-        value: 166
       -
         name: rate-tx-max
         type: u64
@@ -696,20 +787,22 @@ attribute-sets:
       -
         name: rate-parent-node-name
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+         name: region-max-snapshots
+         type: u32
       -
         name: linecard-index
         type: u32
-        value: 171
-
-      # TODO: fill in the attributes in between
-
+      -
+         name: linecard-state
+         type: u8
       -
         name: linecard-type
         type: string
-        value: 173
+      -
+        name: linecard-supported-types
+        type: nest
+        nested-attributes: dl-linecard-supported-types
 
       # TODO: fill in the attributes in between
 
@@ -736,12 +829,14 @@ attribute-sets:
         name: reload-stats
       -
         name: remote-reload-stats
+
   -
     name: dl-reload-stats
     subset-of: devlink
     attributes:
       -
         name: reload-action-info
+
   -
     name: dl-reload-act-info
     subset-of: devlink
@@ -750,12 +845,14 @@ attribute-sets:
         name: reload-action
       -
         name: reload-action-stats
+
   -
     name: dl-reload-act-stats
     subset-of: devlink
     attributes:
       -
         name: reload-stats-entry
+
   -
     name: dl-reload-stats-entry
     subset-of: devlink
@@ -764,6 +861,7 @@ attribute-sets:
         name: reload-stats-limit
       -
         name: reload-stats-value
+
   -
     name: dl-info-version
     subset-of: devlink
@@ -772,6 +870,7 @@ attribute-sets:
         name: info-version-name
       -
         name: info-version-value
+
   -
     name: dl-port-function
     name-prefix: devlink-port-fn-attr-
@@ -1005,6 +1104,49 @@ attribute-sets:
       -
         name: resource
 
+  -
+    name: dl-param
+    subset-of: devlink
+    attributes:
+      -
+        name: param-name
+      -
+        name: param-generic
+      -
+        name: param-type
+
+      # TODO: fill in the attribute param-value-list
+
+  -
+    name: dl-region-snapshots
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot
+
+  -
+    name: dl-region-snapshot
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot-id
+
+  -
+    name: dl-region-chunks
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk
+
+  -
+    name: dl-region-chunk
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk-data
+      -
+        name: region-chunk-addr
+
   -
     name: dl-fmsg
     subset-of: devlink
@@ -1020,6 +1162,62 @@ attribute-sets:
       -
         name: fmsg-obj-name
 
+  -
+    name: dl-health-reporter
+    subset-of: devlink
+    attributes:
+      -
+        name: health-reporter-name
+      -
+        name: health-reporter-state
+      -
+        name: health-reporter-err-count
+      -
+        name: health-reporter-recover-count
+      -
+        name: health-reporter-graceful-period
+      -
+        name: health-reporter-auto-recover
+      -
+        name: health-reporter-dump-ts
+      -
+        name: health-reporter-dump-ts-ns
+      -
+        name: health-reporter-auto-dump
+
+  -
+    name: dl-attr-stats
+    name-prefix: devlink-attr-
+    attributes:
+      - name: stats-rx-packets
+        type: u64
+        value: 0
+      -
+        name: stats-rx-bytes
+        type: u64
+      -
+        name: stats-rx-dropped
+        type: u64
+
+  -
+    name: dl-trap-metadata
+    name-prefix: devlink-attr-
+    attributes:
+      -
+        name: trap-metadata-type-in-port
+        type: flag
+        value: 0
+      -
+        name: trap-metadata-type-fa-cookie
+        type: flag
+
+  -
+    name: dl-linecard-supported-types
+    subset-of: devlink
+    attributes:
+      -
+        name: linecard-type
+
   -
     name: dl-selftest-id
     name-prefix: devlink-attr-selftest-id-
@@ -1077,6 +1275,7 @@ operations:
         reply:
           value: 3  # due to a bug, port dump returns DEVLINK_CMD_NEW
           attributes: *port-id-attrs
+
     -
       name: port-set
       doc: Set devlink port instances.
-- 
2.34.1


