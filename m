Return-Path: <netdev+bounces-144527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E399C7AF9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98678B2A38F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72530206E63;
	Wed, 13 Nov 2024 18:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77F206514;
	Wed, 13 Nov 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521434; cv=none; b=XVUgI7OQ6Xo+zIRzJmbExGB00tX1RwrvmM1KaxpJ9sC1VmOWjJlp0OSQCPip7Ug6Y5/ZK3WtNByd/DTD78UepqnLxzFDibectwuCvG/G1Kwi2JrKzZImIspVgTSv4z1C/JPoEPwhxC2KXXAgIT32i+nqa6W5Mc3oIvie/Q4xBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521434; c=relaxed/simple;
	bh=BeBGGdhIjlqTKWJ7yHHk3/ZkKSkbIkuJI+4uKF8g4yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzOC8MMOu+YD1BVIS7BpI1hFbB1IV/eRzxuHgNLhXTQwUZQVc7/JnfQ9uQE82TNR+4FGegi5ER7iaSlr3BrOF8UH75OD8QE4iEy6Q+ej39ue4gxGhJqurr+0mIUbe9xpa4ZZmaXM8QNILgxufxvw54gFy748RGfyG8VaFsRpMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so76747895ad.2;
        Wed, 13 Nov 2024 10:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521430; x=1732126230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uok7SHVPF/iKHf5Z1yDVNybUt3pXHHMbqS63KLxZ0aI=;
        b=Mz6jPaFsnDEOMdT7mfuFraJvvRAYSvC2lGPM/0657hNSXpqQDW3tP5bykMvvgesisC
         ETKiPEagwp7LHVJPyQCWnJ2OAK0BUX/fb3kO6HODvEOPo4r/sQb20H/bYx3Aox4wNPPH
         8gEy7s8LSB8HYmfh/rhA2aUp/daUghWdDSYcLTNfm31Pp0DeOIV3vpmAc4p8R0IvjkYd
         FaoMeiXMbBM3uXToukwMu5432cVsxnevoKb92DzLHel5yGic7dXe5+cazl/XPpMDk2Ag
         lkvfiGJs4ZoKLZQddsZNlvnRW9OGUalOm2XF6goylVDFUi+i2aOtDa1TWQ3WvuJEsShq
         tyQw==
X-Forwarded-Encrypted: i=1; AJvYcCV2TgGzUUNw+OhNeeDZMuSLzVcD6OickcON3MrD9fj5GWmffiqP1o7SHSu0UvLugQa5b4s+Y4ulxoW6QwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gb9RwYKy/tSRxV6Gzm21C3SKPp+IPnpaZZYBf8hxgIKlYqGd
	fM6GMwzkvNDXnXmWAzK4Go6ewiMTF234XNMMfg0pyGVaOX7Onhf4cttGKEY=
X-Google-Smtp-Source: AGHT+IGfNiauq67jGYVNvtoLS9hIs7qlic3XDIJ9iUPHorfgN8ndrWXXo5oLsxUNyAkIdr9K8Suc+g==
X-Received: by 2002:a17:902:e84e:b0:20c:774b:5aeb with SMTP id d9443c01a7336-21183d1024cmr281417605ad.3.1731521430115;
        Wed, 13 Nov 2024 10:10:30 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58323sm113016765ad.178.2024.11.13.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:29 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 4/7] ynl: add missing pieces to ethtool spec to better match uapi header
Date: Wed, 13 Nov 2024 10:10:20 -0800
Message-ID: <20241113181023.2030098-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113181023.2030098-1-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- __ETHTOOL_UDP_TUNNEL_TYPE_CNT and render max
- skip rendering stringset (empty enum)
- skip rendering c33-pse-ext-state (defined in ethtool.h)
- rename header flags to ethtool-flag-
- add attr-cnt-name to each attribute to use XXX_CNT instead of XXX_MAX
- add unspec 0 entry to each attribute
- carry some doc entries from the existing header
- tcp-header-split

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/specs/ethtool.yaml | 354 ++++++++++++++++++++++-
 1 file changed, 343 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..83adaf8bf9a7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -5,6 +5,7 @@ name: ethtool
 protocol: genetlink-legacy
 
 doc: Partial family for Ethtool Netlink.
+uapi-header: linux/ethetool_netlink_generated.h
 
 definitions:
   -
@@ -12,43 +13,97 @@ doc: Partial family for Ethtool Netlink.
     enum-name:
     type: enum
     entries: [ vxlan, geneve, vxlan-gpe ]
+    attr-cnt-name: __ETHTOOL_UDP_TUNNEL_TYPE_CNT
+    render-max: true
   -
     name: stringset
     type: enum
     entries: []
+    render: false
   -
     name: header-flags
     type: flags
-    entries: [ compact-bitsets, omit-reply, stats ]
+    name-prefix: ethtool-flag-
+    entries:
+      -
+        name: compact-bitsets
+        doc: use compact bitsets in reply
+      -
+        name: omit-reply
+        doc: provide optional reply for SET or ACT requests
+      -
+        name: stats
+        doc: request statistics, if supported by the driver
   -
     name: module-fw-flash-status
     type: enum
-    entries: [ started, in_progress, completed, error ]
+    doc: plug-in module firmware flashing status
+    render: false
+    entries:
+      -
+        name: started
+        doc: The firmware flashing process has started.
+      -
+        name: in_progress
+        doc: The firmware flashing process is in progress.
+      -
+        name: completed
+        doc: The firmware flashing process was completed successfully.
+      -
+        name: error
+        doc: The firmware flashing process was stopped due to an error.
   -
     name: c33-pse-ext-state
-    enum-name:
+    enum-name: c33-pse-ext-state
+    doc: "groups of PSE extended states functions. IEEE 802.3-2022 33.2.4.4 Variables"
     type: enum
     name-prefix: ethtool-c33-pse-ext-state-
+    render: false
     entries:
         - none
-        - error-condition
-        - mr-mps-valid
-        - mr-pse-enable
-        - option-detect-ted
-        - option-vport-lim
-        - ovld-detected
-        - power-not-available
-        - short-detected
+        -
+          name: error-condition
+          doc: Group of error_condition states
+        -
+          name: mr-mps-valid
+          doc: Group of mr_mps_valid states
+        -
+          name: mr-pse-enable
+          doc: Group of mr_pse_enable states
+        -
+          name: option-detect-ted
+          doc: Group of option_detect_ted states
+        -
+          name: option-vport-lim
+          doc: Group of option_vport_lim states
+        -
+          name: ovld-detected
+          doc: Group of ovld_detected states
+        -
+          name: power-not-available
+          doc: Group of power_not_available states
+        -
+          name: short-detected
+          doc: Group of short_detected states
   -
     name: phy-upstream-type
     enum-name:
     type: enum
     entries: [ mac, phy ]
+  -
+    name: tcp-data-split
+    type: enum
+    entries: [ unknown, disabled, enabled ]
 
 attribute-sets:
   -
     name: header
+    attr-cnt-name: __ETHTOOL_A_HEADER_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: dev-index
         type: u32
@@ -65,7 +120,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: bitset-bit
+    attr-cnt-name: __ETHTOOL_A_BITSET_BIT_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: index
         type: u32
@@ -77,7 +137,12 @@ doc: Partial family for Ethtool Netlink.
         type: flag
   -
     name: bitset-bits
+    attr-cnt-name: __ETHTOOL_A_BITSET_BITS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: bit
         type: nest
@@ -85,7 +150,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset-bit
   -
     name: bitset
+    attr-cnt-name: __ETHTOOL_A_BITSET_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: nomask
         type: flag
@@ -104,7 +174,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: string
+    attr-cnt-name: __ETHTOOL_A_STRING_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: index
         type: u32
@@ -113,7 +188,16 @@ doc: Partial family for Ethtool Netlink.
         type: string
   -
     name: strings
+    attr-cnt-name: __ETHTOOL_A_STRINGS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: string
         type: nest
@@ -121,7 +205,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: string
   -
     name: stringset
+    attr-cnt-name: __ETHTOOL_A_STRINGSET_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: id
         type: u32
@@ -135,7 +224,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: strings
   -
     name: stringsets
+    attr-cnt-name: __ETHTOOL_A_STRINGSETS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: stringset
         type: nest
@@ -143,7 +237,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: stringset
   -
     name: strset
+    attr-cnt-name: __ETHTOOL_A_STRSET_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -158,7 +257,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: privflags
+    attr-cnt-name: __ETHTOOL_A_PRIVFLAGS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -170,7 +274,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: rings
+    attr-cnt-name: __ETHTOOL_A_RINGS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -205,6 +314,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: tcp-data-split
         type: u8
+        enum: tcp-data-split
       -
         name: cqe-size
         type: u32
@@ -223,31 +333,48 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: mm-stat
+    attr-cnt-name: __ETHTOOL_A_MM_STAT_CNT
+    doc: MAC Merge (802.3)
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
       -
         name: reassembly-errors
+        doc: aMACMergeFrameAssErrorCount
         type: u64
       -
         name: smd-errors
+        doc: aMACMergeFrameSmdErrorCount
         type: u64
       -
         name: reassembly-ok
+        doc: aMACMergeFrameAssOkCount
         type: u64
       -
         name: rx-frag-count
+        doc: aMACMergeFragCountRx
         type: u64
       -
         name: tx-frag-count
+        doc: aMACMergeFragCountTx
         type: u64
       -
         name: hold-count
+        doc: aMACMergeHoldCount
         type: u64
   -
     name: mm
+    attr-cnt-name: __ETHTOOL_A_MM_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -285,7 +412,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: mm-stat
   -
     name: linkinfo
+    attr-cnt-name: __ETHTOOL_A_LINKINFO_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -307,7 +439,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: linkmodes
+    attr-cnt-name: __ETHTOOL_A_LINKMODES_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -343,7 +480,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: linkstate
+    attr-cnt-name: __ETHTOOL_A_LINKSTATE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -368,7 +510,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: debug
+    attr-cnt-name: __ETHTOOL_A_DEBUG_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -379,7 +526,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset
   -
     name: wol
+    attr-cnt-name: __ETHTOOL_A_WOL_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -393,7 +545,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: features
+    attr-cnt-name: __ETHTOOL_A_FEATURES_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -416,7 +573,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset
   -
     name: channels
+    attr-cnt-name: __ETHTOOL_A_CHANNELS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -448,7 +610,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: irq-moderation
+    attr-cnt-name: __ETHTOOL_A_IRQ_MODERATION_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: usec
         type: u32
@@ -460,7 +627,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: profile
+    attr-cnt-name: __ETHTOOL_A_PROFILE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: irq-moderation
         type: nest
@@ -468,7 +640,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: irq-moderation
   -
     name: coalesce
+    attr-cnt-name: __ETHTOOL_A_COALESCE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -565,7 +742,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: pause-stat
+    attr-cnt-name: __ETHTOOL_A_PAUSE_STAT_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -577,7 +759,12 @@ doc: Partial family for Ethtool Netlink.
         type: u64
   -
     name: pause
+    attr-cnt-name: __ETHTOOL_A_PAUSE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -600,7 +787,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: eee
+    attr-cnt-name: __ETHTOOL_A_EEE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -627,7 +819,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: ts-stat
+    attr-cnt-name: __ETHTOOL_A_TS_STAT_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: tx-pkts
         type: uint
@@ -639,7 +836,12 @@ doc: Partial family for Ethtool Netlink.
         type: uint
   -
     name: tsinfo
+    attr-cnt-name: __ETHTOOL_A_TSINFO_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -665,19 +867,32 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: ts-stat
   -
     name: cable-result
+    attr-cnt-name: __ETHTOOL_A_CABLE_RESULT_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pair
+        doc: ETHTOOL_A_CABLE_PAIR_
         type: u8
       -
         name: code
+        doc: ETHTOOL_A_CABLE_RESULT_CODE_
         type: u8
       -
         name: src
+        doc: ETHTOOL_A_CABLE_INF_SRC_
         type: u32
   -
     name: cable-fault-length
+    attr-cnt-name: __ETHTOOL_A_CABLE_FAULT_LENGTH_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pair
         type: u8
@@ -689,7 +904,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: cable-nest
+    attr-cnt-name: __ETHTOOL_A_CABLE_NEST_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: result
         type: nest
@@ -700,20 +920,31 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-fault-length
   -
     name: cable-test
+    attr-cnt-name: __ETHTOOL_A_CABLE_TEST_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
         nested-attributes: header
   -
     name: cable-test-ntf
+    attr-cnt-name: __ETHTOOL_A_CABLE_TEST_NTF_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
         nested-attributes: header
       -
         name: status
+        doc: _STARTED/_COMPLETE
         type: u8
       -
         name: nest
@@ -721,7 +952,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-nest
   -
     name: cable-test-tdr-cfg
+    attr-cnt-name: __ETHTOOL_A_CABLE_TEST_TDR_CFG_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: first
         type: u32
@@ -736,7 +972,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: cable-test-tdr-ntf
+    attr-cnt-name: __ETHTOOL_A_CABLE_TEST_TDR_NTF_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -750,7 +991,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-nest
   -
     name: cable-test-tdr
+    attr-cnt-name: __ETHTOOL_A_CABLE_TEST_TDR_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -761,7 +1007,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-test-tdr-cfg
   -
     name: tunnel-udp-entry
+    attr-cnt-name: __ETHTOOL_A_TUNNEL_UDP_ENTRY_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: port
         type: u16
@@ -772,7 +1023,12 @@ doc: Partial family for Ethtool Netlink.
         enum: udp-tunnel-type
   -
     name: tunnel-udp-table
+    attr-cnt-name: __ETHTOOL_A_TUNNEL_UDP_TABLE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: size
         type: u32
@@ -787,14 +1043,24 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: tunnel-udp-entry
   -
     name: tunnel-udp
+    attr-cnt-name: __ETHTOOL_A_TUNNEL_UDP_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: table
         type: nest
         nested-attributes: tunnel-udp-table
   -
     name: tunnel-info
+    attr-cnt-name: __ETHTOOL_A_TUNNEL_INFO_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -805,7 +1071,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: tunnel-udp
   -
     name: fec-stat
+    attr-cnt-name: __ETHTOOL_A_FEC_STAT_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -823,7 +1094,12 @@ doc: Partial family for Ethtool Netlink.
         sub-type: u64
   -
     name: fec
+    attr-cnt-name: __ETHTOOL_A_FEC_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -844,7 +1120,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: fec-stat
   -
     name: module-eeprom
+    attr-cnt-name: __ETHTOOL_A_MODULE_EEPROM_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -869,7 +1150,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: stats-grp
+    attr-cnt-name: __ETHTOOL_A_STATS_GRP_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -912,7 +1198,12 @@ doc: Partial family for Ethtool Netlink.
         name: hist-val
   -
     name: stats
+    attr-cnt-name: __ETHTOOL_A_STATS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -933,7 +1224,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: phc-vclocks
+    attr-cnt-name: __ETHTOOL_A_PHC_VCLOCKS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -947,7 +1243,12 @@ doc: Partial family for Ethtool Netlink.
         sub-type: s32
   -
     name: module
+    attr-cnt-name: __ETHTOOL_A_MODULE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -960,7 +1261,13 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: c33-pse-pw-limit
+    attr-cnt-name: __ETHTOOL_A_C33_PSE_PW_LIMIT_CNT
+    attr-max-name: __ETHTOOL_A_C33_PSE_PW_LIMIT_MAX
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: min
         type: u32
@@ -969,7 +1276,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: pse
+    attr-cnt-name: __ETHTOOL_A_PSE_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1027,7 +1339,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: c33-pse-pw-limit
   -
     name: rss
+    attr-cnt-name: __ETHTOOL_A_RSS_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1053,7 +1370,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: plca
+    attr-cnt-name: __ETHTOOL_A_PLCA_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1084,7 +1406,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: module-fw-flash
+    attr-cnt-name: __ETHTOOL_A_MODULE_FW_FLASH_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1110,7 +1437,12 @@ doc: Partial family for Ethtool Netlink.
         type: uint
   -
     name: phy
+    attr-cnt-name: __ETHTOOL_A_PHY_CNT
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
-- 
2.47.0


