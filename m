Return-Path: <netdev+bounces-50422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6D7F5BD3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB931C20CAD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3122334;
	Thu, 23 Nov 2023 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8lx7i2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A4D60
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:01:32 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c2139492d9so451249a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700733692; x=1701338492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqQNRQSdTwHSoJJNFa49GmUjjH3adDjHMPo9cLYvV2g=;
        b=Y8lx7i2k59qMiVdlUfsjEWkRDiEoaRMbIewYxacJbXvyEAEfe/r+uIyI+aAfuc6kf3
         1s3n34PNGI4qiY/QslhfVa2M5/XhNzoT0lGkxgpxsqpqNXMPbh0xnLhGyLKwiDDtrdNV
         +lVITjNH3o40CSpnYP4AyFqGhpYhzv/fhemzLeTSE11nqJYvaUGwR4Vc28skB9eQ4XAv
         4y7YkGTFbUBONt3szi82K9HbdBw7a+/NuwmVLvApL5if3ZTvQZBlFgqT00i1ch+lb0Df
         xyd4oRjGVLipzbgZRtdbuuiZmA0TArTuE4um1AijyAD9rXkRw28ZMz/bEIu4WyBmfKMr
         D6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700733692; x=1701338492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqQNRQSdTwHSoJJNFa49GmUjjH3adDjHMPo9cLYvV2g=;
        b=vxr8lflB9ic2DYERWLUzbByH7YnWrf/Ypx5o5TnlxAm+2HONGuFAyf3dVcLgRlqIML
         jLhUe46gbnlyLuoqFb780fUneurSAXZU4ZYBHtCvbGMVRBKlHlzziO+f2f1Tz8YtRHRs
         ioNr44N/SMwh1++8fpOIOgLeGVUhyG9SPfxgh4P8bymP9tndXPzJrbrZc+pUeBHWoZ5K
         aIEzJxkxpG/nP2YcUFqLE9xXDt66sgnlfEypkWhLr6GjHXkkdZmmi8rYoEQZ2bYZrOpc
         OTd5xiH67C9lHratbbDsLezU9F05wIaEfmo6VWbYCgcuqp6JNmyYsLqjm9iDDslQ8mRA
         wJIQ==
X-Gm-Message-State: AOJu0Yx3cwEj7aMCH9wIzaxPeHMGNSgQiinHiTdMcFQPPUQVFy8+gNjv
	2JUg3z6LdiR9D0ZkN7lXgGc=
X-Google-Smtp-Source: AGHT+IFA++rSyQMinyVN/w9CCXwPA7zk7bk2oNlMeuECFz2q8d8bPhUC+EpL9y6Yne83rXG8rSlL/g==
X-Received: by 2002:a05:6a20:914e:b0:18b:4dc2:a4d8 with SMTP id x14-20020a056a20914e00b0018b4dc2a4d8mr4220674pzc.8.1700733691687;
        Thu, 23 Nov 2023 02:01:31 -0800 (PST)
Received: from swarup-virtual-machine.localdomain ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id bn4-20020a056a00324400b006bde2480806sm869944pfb.47.2023.11.23.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:01:31 -0800 (PST)
From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH net-next v3] netlink: specs: devlink: add some(not all) missing attributes in devlink.yaml
Date: Thu, 23 Nov 2023 15:31:19 +0530
Message-Id: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

Add some missing(not all) attributes in devlink.yaml.

Re-generate the related devlink-user.[ch] code.

enum have been given name as devlink_stats(for trap stats)
and devlink_trap_metadata_type(for trap metadata type)

Test result with trap-get command:
  $ sudo ./tools/net/ynl/cli.py \
   --spec Documentation/netlink/specs/devlink.yaml \
   --do trap-get --json '{"bus-name": "netdevsim", \
                          "dev-name": "netdevsim1", \
   "trap-name": "ttl_value_is_too_small"}' --process-unknown
 {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
                'rx-packets': 337453},
 'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'trap-action': 'trap',
 'trap-generic': True,
 'trap-group-name': 'l3_exceptions',
 'trap-metadata': {'metadata-type-in-port': True},
 'trap-name': 'ttl_value_is_too_small',
 'trap-type': 'exception'}

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
---
V3:
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

 Documentation/netlink/specs/devlink.yaml | 330 ++++++++++++++++++-----
 include/uapi/linux/devlink.h             |   4 +-
 tools/net/ynl/generated/devlink-user.c   | 223 +++++++++++++++
 tools/net/ynl/generated/devlink-user.h   | 105 +++++++-
 4 files changed, 597 insertions(+), 65 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 43067e1f63aa..2fee16509e82 100644
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
@@ -174,7 +192,16 @@ definitions:
         name: trap
       -
         name: mirror
-
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
     name: devlink
@@ -194,23 +221,44 @@ attribute-sets:
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
         value: 9
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-split-group
+        type: u32
       -
         name: sb-index
         type: u32
         value: 11
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
@@ -233,15 +281,17 @@ attribute-sets:
         name: sb-tc-index
         type: u16
         value: 22
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
         value: 25
         enum: eswitch-mode
-
       -
         name: eswitch-inline-mode
         type: u16
@@ -347,6 +397,7 @@ attribute-sets:
       -
         name: dpipe-header-id
         type: u32
+        enum: dpipe-header-id
       -
         name: dpipe-header-fields
         type: nest
@@ -433,23 +484,27 @@ attribute-sets:
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
         value: 81
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: param-generic
+        type: flag
       -
         name: param-type
         type: u8
         value: 83
-
-      # TODO: fill in the attributes in between
-
       -
         name: param-value-cmode
         type: u8
@@ -458,16 +513,32 @@ attribute-sets:
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
         value: 92
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
@@ -502,9 +573,9 @@ attribute-sets:
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
@@ -525,15 +596,31 @@ attribute-sets:
       -
         name: fmsg-obj-name
         type: string
-
+      -
+        name: fmsg-obj-value-type
+        type: u8
       # TODO: fill in the attributes in between
+      -
+        name: health-reporter
+        type: nest
+        nested-attributes: dl-health-reporter
 
       -
         name: health-reporter-name
         type: string
         value: 115
-
-      # TODO: fill in the attributes in between
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
@@ -548,15 +635,27 @@ attribute-sets:
       -
         name: flash-update-component
         type: string
-
-      # TODO: fill in the attributes in between
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
         value: 127
-
-      # TODO: fill in the attributes in between
+      -
+        name: port-pci-vf-number
+        type: u16
+      -
+        name: stats
+        type: nest
+        nested-attributes: dl-attr-stats
 
       -
         name: trap-name
@@ -566,8 +665,17 @@ attribute-sets:
         name: trap-action
         type: u8
         enum: trap-action
-
-      # TODO: fill in the attributes in between
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
@@ -577,8 +685,9 @@ attribute-sets:
       -
         name: reload-failed
         type: u8
-
-      # TODO: fill in the attributes in between
+      -
+        name: health-reporter-dump-ts-ns
+        type: u64
 
       -
         name: netns-fd
@@ -591,8 +700,6 @@ attribute-sets:
         name: netns-id
         type: u32
 
-      # TODO: fill in the attributes in between
-
       -
         name: health-reporter-auto-dump
         type: u8
@@ -610,15 +717,26 @@ attribute-sets:
         name: port-function
         type: nest
         nested-attributes: dl-port-function
-
-      # TODO: fill in the attributes in between
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
         value: 150
-
-      # TODO: fill in the attributes in between
+      -
+        name: flash-update-status-timeout
+        type: u64
 
       -
         name: flash-update-overwrite-mask
@@ -674,14 +792,14 @@ attribute-sets:
         multi-attr: true
         nested-attributes: dl-reload-act-stats
 
-      # TODO: fill in the attributes in between
-
       -
         name: port-pci-sf-number
         type: u32
         value: 164
-
-      # TODO: fill in the attributes in between
+      -
+        name: rate-type
+        type: u16
+        enum: rate-type
 
       -
         name: rate-tx-share
@@ -697,22 +815,28 @@ attribute-sets:
         name: rate-parent-node-name
         type: string
 
-      # TODO: fill in the attributes in between
+      -
+         name: region-max-snapshots
+         type: u32
 
       -
         name: linecard-index
         type: u32
         value: 171
 
-      # TODO: fill in the attributes in between
+      -
+         name: linecard-state
+         type: u8
 
       -
         name: linecard-type
         type: string
         value: 173
-
+      -
+        name: linecard-supported-types
+        type: nest
+        nested-attributes: dl-linecard-supported-types
       # TODO: fill in the attributes in between
-
       -
         name: selftests
         type: nest
@@ -727,7 +851,6 @@ attribute-sets:
       -
         name: region-direct
         type: flag
-
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1004,7 +1127,43 @@ attribute-sets:
     attributes:
       -
         name: resource
-
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
+      # TODO: fill in the attribute param-value-list
+  -
+    name: dl-region-snapshots
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot
+  -
+    name: dl-region-snapshot
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot-id
+  -
+    name: dl-region-chunks
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk
+  -
+    name: dl-region-chunk
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk-data
+      -
+        name: region-chunk-addr
   -
     name: dl-fmsg
     subset-of: devlink
@@ -1019,7 +1178,58 @@ attribute-sets:
         name: fmsg-nest-end
       -
         name: fmsg-obj-name
-
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
+  -
+    name: dl-linecard-supported-types
+    subset-of: devlink
+    attributes:
+      -
+        name: linecard-type
   -
     name: dl-selftest-id
     name-prefix: devlink-attr-selftest-id-
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index b3c8383d342d..ddb689dd3d7e 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -248,7 +248,7 @@ enum devlink_param_reset_dev_on_drv_probe_value {
 	DEVLINK_PARAM_RESET_DEV_ON_DRV_PROBE_VALUE_DISK,
 };
 
-enum {
+enum devlink_stats {
 	DEVLINK_ATTR_STATS_RX_PACKETS,		/* u64 */
 	DEVLINK_ATTR_STATS_RX_BYTES,		/* u64 */
 	DEVLINK_ATTR_STATS_RX_DROPPED,		/* u64 */
@@ -340,7 +340,7 @@ enum devlink_trap_type {
 	DEVLINK_TRAP_TYPE_CONTROL,
 };
 
-enum {
+enum devlink_trap_metadata_type {
 	/* Trap can report input port as metadata */
 	DEVLINK_ATTR_TRAP_METADATA_TYPE_IN_PORT,
 	/* Trap can report flow action cookie as metadata */
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index bc5065bd99b2..8ae4a5f9a686 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -132,6 +132,18 @@ const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value)
 	return devlink_port_fn_attr_cap_strmap[value];
 }
 
+static const char * const devlink_rate_type_strmap[] = {
+	[0] = "leaf",
+	[1] = "node",
+};
+
+const char *devlink_rate_type_str(enum devlink_rate_type value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_rate_type_strmap))
+		return NULL;
+	return devlink_rate_type_strmap[value];
+}
+
 static const char * const devlink_sb_threshold_type_strmap[] = {
 	[0] = "static",
 	[1] = "dynamic",
@@ -184,6 +196,19 @@ devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value)
 	return devlink_eswitch_encap_mode_strmap[value];
 }
 
+static const char * const devlink_dpipe_header_id_strmap[] = {
+	[0] = "ethernet",
+	[1] = "ipv4",
+	[2] = "ipv6",
+};
+
+const char *devlink_dpipe_header_id_str(enum devlink_dpipe_header_id value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_dpipe_header_id_strmap))
+		return NULL;
+	return devlink_dpipe_header_id_strmap[value];
+}
+
 static const char * const devlink_dpipe_match_type_strmap[] = {
 	[0] = "field-exact",
 };
@@ -280,6 +305,19 @@ const char *devlink_trap_action_str(enum devlink_trap_action value)
 	return devlink_trap_action_strmap[value];
 }
 
+static const char * const devlink_trap_type_strmap[] = {
+	[0] = "drop",
+	[1] = "exception",
+	[2] = "control",
+};
+
+const char *devlink_trap_type_str(enum devlink_trap_type value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_trap_type_strmap))
+		return NULL;
+	return devlink_trap_type_strmap[value];
+}
+
 /* Policies */
 struct ynl_policy_attr devlink_dl_dpipe_match_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DPIPE_MATCH_TYPE] = { .name = "dpipe-match-type", .type = YNL_PT_U32, },
@@ -361,6 +399,36 @@ struct ynl_policy_nest devlink_dl_resource_nest = {
 	.table = devlink_dl_resource_policy,
 };
 
+struct ynl_policy_attr devlink_dl_param_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_GENERIC] = { .name = "param-generic", .type = YNL_PT_FLAG, },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest devlink_dl_param_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_param_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_snapshot_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest devlink_dl_region_snapshot_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_snapshot_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_chunk_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_CHUNK_DATA] = { .name = "region-chunk-data", .type = YNL_PT_BINARY,},
+	[DEVLINK_ATTR_REGION_CHUNK_ADDR] = { .name = "region-chunk-addr", .type = YNL_PT_U64, },
+};
+
+struct ynl_policy_nest devlink_dl_region_chunk_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_chunk_policy,
+};
+
 struct ynl_policy_attr devlink_dl_info_version_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
@@ -384,6 +452,44 @@ struct ynl_policy_nest devlink_dl_fmsg_nest = {
 	.table = devlink_dl_fmsg_policy,
 };
 
+struct ynl_policy_attr devlink_dl_health_reporter_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .name = "health-reporter-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_STATE] = { .name = "health-reporter-state", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_ERR_COUNT] = { .name = "health-reporter-err-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT] = { .name = "health-reporter-recover-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .name = "health-reporter-graceful-period", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .name = "health-reporter-auto-recover", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS] = { .name = "health-reporter-dump-ts", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS] = { .name = "health-reporter-dump-ts-ns", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .name = "health-reporter-auto-dump", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest devlink_dl_health_reporter_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_health_reporter_policy,
+};
+
+struct ynl_policy_attr devlink_dl_attr_stats_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_STATS_RX_PACKETS] = { .name = "stats-rx-packets", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_STATS_RX_BYTES] = { .name = "stats-rx-bytes", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_STATS_RX_DROPPED] = { .name = "stats-rx-dropped", .type = YNL_PT_U64, },
+};
+
+struct ynl_policy_nest devlink_dl_attr_stats_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_attr_stats_policy,
+};
+
+struct ynl_policy_attr devlink_dl_trap_metadata_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_TRAP_METADATA_TYPE_IN_PORT] = { .name = "trap-metadata-type-in-port", .type = YNL_PT_FLAG, },
+	[DEVLINK_ATTR_TRAP_METADATA_TYPE_FA_COOKIE] = { .name = "trap-metadata-type-fa-cookie", .type = YNL_PT_FLAG, },
+};
+
+struct ynl_policy_nest devlink_dl_trap_metadata_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_trap_metadata_policy,
+};
+
 struct ynl_policy_attr devlink_dl_port_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .name = "hw-addr", .type = YNL_PT_BINARY,},
 	[DEVLINK_PORT_FN_ATTR_STATE] = { .name = "state", .type = YNL_PT_U8, },
@@ -415,6 +521,15 @@ struct ynl_policy_nest devlink_dl_reload_act_stats_nest = {
 	.table = devlink_dl_reload_act_stats_policy,
 };
 
+struct ynl_policy_attr devlink_dl_linecard_supported_types_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_LINECARD_TYPE] = { .name = "linecard-type", .type = YNL_PT_NUL_STR, },
+};
+
+struct ynl_policy_nest devlink_dl_linecard_supported_types_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_linecard_supported_types_policy,
+};
+
 struct ynl_policy_attr devlink_dl_selftest_id_policy[DEVLINK_ATTR_SELFTEST_ID_MAX + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .name = "flash", .type = YNL_PT_FLAG, },
 };
@@ -478,6 +593,24 @@ struct ynl_policy_nest devlink_dl_resource_list_nest = {
 	.table = devlink_dl_resource_list_policy,
 };
 
+struct ynl_policy_attr devlink_dl_region_snapshots_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_SNAPSHOT] = { .name = "region-snapshot", .type = YNL_PT_NEST, .nest = &devlink_dl_region_snapshot_nest, },
+};
+
+struct ynl_policy_nest devlink_dl_region_snapshots_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_snapshots_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_chunks_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_CHUNK] = { .name = "region-chunk", .type = YNL_PT_NEST, .nest = &devlink_dl_region_chunk_nest, },
+};
+
+struct ynl_policy_nest devlink_dl_region_chunks_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_chunks_policy,
+};
+
 struct ynl_policy_attr devlink_dl_reload_act_info_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_RELOAD_ACTION] = { .name = "reload-action", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_RELOAD_ACTION_STATS] = { .name = "reload-action-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_stats_nest, },
@@ -578,14 +711,26 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DEV_NAME] = { .name = "dev-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .name = "port-index", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_PORT_TYPE] = { .name = "port-type", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_DESIRED_TYPE] = { .name = "port-desired-type", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_NETDEV_IFINDEX] = { .name = "port-netdev-ifindex", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_NETDEV_NAME] = { .name = "port-netdev-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PORT_IBDEV_NAME] = { .name = "port-ibdev-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .name = "port-split-count", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLIT_GROUP] = { .name = "port-split-group", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .name = "sb-index", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_SIZE] = { .name = "sb-size", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_INGRESS_POOL_COUNT] = { .name = "sb-ingress-pool-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_EGRESS_POOL_COUNT] = { .name = "sb-egress-pool-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_INGRESS_TC_COUNT] = { .name = "sb-ingress-tc-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_EGRESS_TC_COUNT] = { .name = "sb-egress-tc-count", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .name = "sb-pool-index", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_SB_POOL_TYPE] = { .name = "sb-pool-type", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_SB_POOL_SIZE] = { .name = "sb-pool-size", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = { .name = "sb-pool-threshold-type", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_SB_THRESHOLD] = { .name = "sb-threshold", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_TC_INDEX] = { .name = "sb-tc-index", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_OCC_CUR] = { .name = "sb-occ-cur", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_OCC_MAX] = { .name = "sb-occ-max", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = { .name = "eswitch-mode", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = { .name = "eswitch-inline-mode", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_DPIPE_TABLES] = { .name = "dpipe-tables", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_tables_nest, },
@@ -639,11 +784,21 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID] = { .name = "dpipe-table-resource-id", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS] = { .name = "dpipe-table-resource-units", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_FLAVOUR] = { .name = "port-flavour", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_NUMBER] = { .name = "port-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLIT_SUBPORT_NUMBER] = { .name = "port-split-subport-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PARAM] = { .name = "param", .type = YNL_PT_NEST, .nest = &devlink_dl_param_nest, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_GENERIC] = { .name = "param-generic", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = { .name = "param-value-cmode", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_REGION_NAME] = { .name = "region-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_REGION_SIZE] = { .name = "region-size", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_REGION_SNAPSHOTS] = { .name = "region-snapshots", .type = YNL_PT_NEST, .nest = &devlink_dl_region_snapshots_nest, },
+	[DEVLINK_ATTR_REGION_SNAPSHOT] = { .name = "region-snapshot", .type = YNL_PT_NEST, .nest = &devlink_dl_region_snapshot_nest, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_REGION_CHUNKS] = { .name = "region-chunks", .type = YNL_PT_NEST, .nest = &devlink_dl_region_chunks_nest, },
+	[DEVLINK_ATTR_REGION_CHUNK] = { .name = "region-chunk", .type = YNL_PT_NEST, .nest = &devlink_dl_region_chunk_nest, },
+	[DEVLINK_ATTR_REGION_CHUNK_DATA] = { .name = "region-chunk-data", .type = YNL_PT_BINARY,},
 	[DEVLINK_ATTR_REGION_CHUNK_ADDR] = { .name = "region-chunk-addr", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_REGION_CHUNK_LEN] = { .name = "region-chunk-len", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_INFO_DRIVER_NAME] = { .name = "info-driver-name", .type = YNL_PT_NUL_STR, },
@@ -653,22 +808,38 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_INFO_VERSION_STORED] = { .name = "info-version-stored", .type = YNL_PT_NEST, .nest = &devlink_dl_info_version_nest, },
 	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_SB_POOL_CELL_SIZE] = { .name = "sb-pool-cell-size", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_FMSG] = { .name = "fmsg", .type = YNL_PT_NEST, .nest = &devlink_dl_fmsg_nest, },
 	[DEVLINK_ATTR_FMSG_OBJ_NEST_START] = { .name = "fmsg-obj-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_PAIR_NEST_START] = { .name = "fmsg-pair-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_ARR_NEST_START] = { .name = "fmsg-arr-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_NEST_END] = { .name = "fmsg-nest-end", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_OBJ_NAME] = { .name = "fmsg-obj-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FMSG_OBJ_VALUE_TYPE] = { .name = "fmsg-obj-value-type", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER] = { .name = "health-reporter", .type = YNL_PT_NEST, .nest = &devlink_dl_health_reporter_nest, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .name = "health-reporter-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_STATE] = { .name = "health-reporter-state", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_ERR_COUNT] = { .name = "health-reporter-err-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT] = { .name = "health-reporter-recover-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS] = { .name = "health-reporter-dump-ts", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .name = "health-reporter-graceful-period", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .name = "health-reporter-auto-recover", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .name = "flash-update-file-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .name = "flash-update-component", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_MSG] = { .name = "flash-update-status-msg", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_DONE] = { .name = "flash-update-status-done", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_TOTAL] = { .name = "flash-update-status-total", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .name = "port-pci-pf-number", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_PCI_VF_NUMBER] = { .name = "port-pci-vf-number", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_STATS] = { .name = "stats", .type = YNL_PT_NEST, .nest = &devlink_dl_attr_stats_nest, },
 	[DEVLINK_ATTR_TRAP_NAME] = { .name = "trap-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_TRAP_ACTION] = { .name = "trap-action", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_TRAP_TYPE] = { .name = "trap-type", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_TRAP_GENERIC] = { .name = "trap-generic", .type = YNL_PT_FLAG, },
+	[DEVLINK_ATTR_TRAP_METADATA] = { .name = "trap-metadata", .type = YNL_PT_NEST, .nest = &devlink_dl_trap_metadata_nest, },
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .name = "trap-group-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_RELOAD_FAILED] = { .name = "reload-failed", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS] = { .name = "health-reporter-dump-ts-ns", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_NETNS_FD] = { .name = "netns-fd", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_NETNS_PID] = { .name = "netns-pid", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_NETNS_ID] = { .name = "netns-id", .type = YNL_PT_U32, },
@@ -677,7 +848,12 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .name = "trap-policer-rate", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .name = "trap-policer-burst", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_FUNCTION] = { .name = "port-function", .type = YNL_PT_NEST, .nest = &devlink_dl_port_function_nest, },
+	[DEVLINK_ATTR_INFO_BOARD_SERIAL_NUMBER] = { .name = "info-board-serial-number", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PORT_LANES] = { .name = "port-lanes", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLITTABLE] = { .name = "port-splittable", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_PORT_EXTERNAL] = { .name = "port-external", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_PORT_CONTROLLER_NUMBER] = { .name = "port-controller-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_TIMEOUT] = { .name = "flash-update-status-timeout", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] = { .name = "flash-update-overwrite-mask", .type = YNL_PT_BITFIELD32, },
 	[DEVLINK_ATTR_RELOAD_ACTION] = { .name = "reload-action", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED] = { .name = "reload-actions-performed", .type = YNL_PT_BITFIELD32, },
@@ -691,12 +867,16 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_RELOAD_ACTION_INFO] = { .name = "reload-action-info", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_info_nest, },
 	[DEVLINK_ATTR_RELOAD_ACTION_STATS] = { .name = "reload-action-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_stats_nest, },
 	[DEVLINK_ATTR_PORT_PCI_SF_NUMBER] = { .name = "port-pci-sf-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_RATE_TYPE] = { .name = "rate-type", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .name = "rate-tx-share", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .name = "rate-tx-max", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .name = "rate-node-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .name = "rate-parent-node-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_REGION_MAX_SNAPSHOTS] = { .name = "region-max-snapshots", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .name = "linecard-index", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_LINECARD_STATE] = { .name = "linecard-state", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_LINECARD_TYPE] = { .name = "linecard-type", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = { .name = "linecard-supported-types", .type = YNL_PT_NEST, .nest = &devlink_dl_linecard_supported_types_nest, },
 	[DEVLINK_ATTR_SELFTESTS] = { .name = "selftests", .type = YNL_PT_NEST, .nest = &devlink_dl_selftest_id_nest, },
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .name = "rate-tx-priority", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .name = "rate-tx-weight", .type = YNL_PT_U32, },
@@ -1073,6 +1253,20 @@ int devlink_dl_resource_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_param_free(struct devlink_dl_param *obj)
+{
+	free(obj->param_name);
+}
+
+void devlink_dl_region_snapshot_free(struct devlink_dl_region_snapshot *obj)
+{
+}
+
+void devlink_dl_region_chunk_free(struct devlink_dl_region_chunk *obj)
+{
+	free(obj->region_chunk_data);
+}
+
 void devlink_dl_info_version_free(struct devlink_dl_info_version *obj)
 {
 	free(obj->info_version_name);
@@ -1163,6 +1357,19 @@ int devlink_dl_fmsg_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_health_reporter_free(struct devlink_dl_health_reporter *obj)
+{
+	free(obj->health_reporter_name);
+}
+
+void devlink_dl_attr_stats_free(struct devlink_dl_attr_stats *obj)
+{
+}
+
+void devlink_dl_trap_metadata_free(struct devlink_dl_trap_metadata *obj)
+{
+}
+
 void devlink_dl_port_function_free(struct devlink_dl_port_function *obj)
 {
 	free(obj->hw_addr);
@@ -1266,6 +1473,12 @@ int devlink_dl_reload_act_stats_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void
+devlink_dl_linecard_supported_types_free(struct devlink_dl_linecard_supported_types *obj)
+{
+	free(obj->linecard_type);
+}
+
 void devlink_dl_selftest_id_free(struct devlink_dl_selftest_id *obj)
 {
 }
@@ -1582,6 +1795,16 @@ int devlink_dl_resource_list_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_region_snapshots_free(struct devlink_dl_region_snapshots *obj)
+{
+	devlink_dl_region_snapshot_free(&obj->region_snapshot);
+}
+
+void devlink_dl_region_chunks_free(struct devlink_dl_region_chunks *obj)
+{
+	devlink_dl_region_chunk_free(&obj->region_chunk);
+}
+
 void devlink_dl_reload_act_info_free(struct devlink_dl_reload_act_info *obj)
 {
 	unsigned int i;
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 1db4edc36eaa..06a7cdb57f17 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -24,6 +24,7 @@ const char *devlink_port_flavour_str(enum devlink_port_flavour value);
 const char *devlink_port_fn_state_str(enum devlink_port_fn_state value);
 const char *devlink_port_fn_opstate_str(enum devlink_port_fn_opstate value);
 const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value);
+const char *devlink_rate_type_str(enum devlink_rate_type value);
 const char *
 devlink_sb_threshold_type_str(enum devlink_sb_threshold_type value);
 const char *devlink_eswitch_mode_str(enum devlink_eswitch_mode value);
@@ -31,6 +32,7 @@ const char *
 devlink_eswitch_inline_mode_str(enum devlink_eswitch_inline_mode value);
 const char *
 devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value);
+const char *devlink_dpipe_header_id_str(enum devlink_dpipe_header_id value);
 const char *devlink_dpipe_match_type_str(enum devlink_dpipe_match_type value);
 const char *
 devlink_dpipe_action_type_str(enum devlink_dpipe_action_type value);
@@ -41,6 +43,7 @@ const char *devlink_reload_action_str(enum devlink_reload_action value);
 const char *devlink_param_cmode_str(enum devlink_param_cmode value);
 const char *devlink_flash_overwrite_str(enum devlink_flash_overwrite value);
 const char *devlink_trap_action_str(enum devlink_trap_action value);
+const char *devlink_trap_type_str(enum devlink_trap_type value);
 
 /* Common nested types */
 struct devlink_dl_dpipe_match {
@@ -53,7 +56,7 @@ struct devlink_dl_dpipe_match {
 	} _present;
 
 	enum devlink_dpipe_match_type dpipe_match_type;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	__u32 dpipe_header_index;
 	__u32 dpipe_field_id;
@@ -83,7 +86,7 @@ struct devlink_dl_dpipe_action {
 	} _present;
 
 	enum devlink_dpipe_action_type dpipe_action_type;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	__u32 dpipe_header_index;
 	__u32 dpipe_field_id;
@@ -143,6 +146,35 @@ struct devlink_dl_resource {
 	__u64 resource_occ;
 };
 
+struct devlink_dl_param {
+	struct {
+		__u32 param_name_len;
+		__u32 param_generic:1;
+		__u32 param_type:1;
+	} _present;
+
+	char *param_name;
+	__u8 param_type;
+};
+
+struct devlink_dl_region_snapshot {
+	struct {
+		__u32 region_snapshot_id:1;
+	} _present;
+
+	__u32 region_snapshot_id;
+};
+
+struct devlink_dl_region_chunk {
+	struct {
+		__u32 region_chunk_data_len;
+		__u32 region_chunk_addr:1;
+	} _present;
+
+	void *region_chunk_data;
+	__u64 region_chunk_addr;
+};
+
 struct devlink_dl_info_version {
 	struct {
 		__u32 info_version_name_len;
@@ -165,6 +197,49 @@ struct devlink_dl_fmsg {
 	char *fmsg_obj_name;
 };
 
+struct devlink_dl_health_reporter {
+	struct {
+		__u32 health_reporter_name_len;
+		__u32 health_reporter_state:1;
+		__u32 health_reporter_err_count:1;
+		__u32 health_reporter_recover_count:1;
+		__u32 health_reporter_graceful_period:1;
+		__u32 health_reporter_auto_recover:1;
+		__u32 health_reporter_dump_ts:1;
+		__u32 health_reporter_dump_ts_ns:1;
+		__u32 health_reporter_auto_dump:1;
+	} _present;
+
+	char *health_reporter_name;
+	__u8 health_reporter_state;
+	__u64 health_reporter_err_count;
+	__u64 health_reporter_recover_count;
+	__u64 health_reporter_graceful_period;
+	__u8 health_reporter_auto_recover;
+	__u64 health_reporter_dump_ts;
+	__u64 health_reporter_dump_ts_ns;
+	__u8 health_reporter_auto_dump;
+};
+
+struct devlink_dl_attr_stats {
+	struct {
+		__u32 stats_rx_packets:1;
+		__u32 stats_rx_bytes:1;
+		__u32 stats_rx_dropped:1;
+	} _present;
+
+	__u64 stats_rx_packets;
+	__u64 stats_rx_bytes;
+	__u64 stats_rx_dropped;
+};
+
+struct devlink_dl_trap_metadata {
+	struct {
+		__u32 trap_metadata_type_in_port:1;
+		__u32 trap_metadata_type_fa_cookie:1;
+	} _present;
+};
+
 struct devlink_dl_port_function {
 	struct {
 		__u32 hw_addr_len;
@@ -194,6 +269,14 @@ struct devlink_dl_reload_act_stats {
 	struct devlink_dl_reload_stats_entry *reload_stats_entry;
 };
 
+struct devlink_dl_linecard_supported_types {
+	struct {
+		__u32 linecard_type_len;
+	} _present;
+
+	char *linecard_type;
+};
+
 struct devlink_dl_selftest_id {
 	struct {
 		__u32 flash:1;
@@ -230,6 +313,22 @@ struct devlink_dl_resource_list {
 	struct devlink_dl_resource *resource;
 };
 
+struct devlink_dl_region_snapshots {
+	struct {
+		__u32 region_snapshot:1;
+	} _present;
+
+	struct devlink_dl_region_snapshot region_snapshot;
+};
+
+struct devlink_dl_region_chunks {
+	struct {
+		__u32 region_chunk:1;
+	} _present;
+
+	struct devlink_dl_region_chunk region_chunk;
+};
+
 struct devlink_dl_reload_act_info {
 	struct {
 		__u32 reload_action:1;
@@ -283,7 +382,7 @@ struct devlink_dl_dpipe_header {
 	} _present;
 
 	char *dpipe_header_name;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	struct devlink_dl_dpipe_header_fields dpipe_header_fields;
 };
-- 
2.34.1


