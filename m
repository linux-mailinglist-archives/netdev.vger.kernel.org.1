Return-Path: <netdev+bounces-149057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B659E3ED1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D1516745C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3D20E007;
	Wed,  4 Dec 2024 15:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C220D51C;
	Wed,  4 Dec 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327758; cv=none; b=XA4zD3eWRGmPCVga7Tgl5eG8FOq7j+y0Ht+xPZ0V9wPwo8bQllOGrR26XE8yffMhfgctqRAXD2WWtApbwVxJYptDDHeoRMNE4pNr2A+bacYug1hSklJjUJYwa7ykJWGTM2VguZz8yfrI9tFpG8C8KWZWgbrSMg7XDgtR3NV8ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327758; c=relaxed/simple;
	bh=X6tHbJZGfi9ppD5mWQMyC7Vt9ylkmCzggtgKG9fib94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFwpdppBLDBvL5bGhHEZ+3pLn5X8VEcoTHi5OhpRwlC7rd1Wgo2cKCU52GQxseVr8GjlzdEEDZi7fkAj23u2Vx268ORQjOQcAUkn/ya2RWgf3tBQwvfYSs+59/5od3A5Rw+EIjesKnmsRJCHYjSNRC1KrPmtEOY4E1NxTgr6BLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215936688aeso35478995ad.1;
        Wed, 04 Dec 2024 07:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327756; x=1733932556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blFkmvQycx4uJE423WMvDRaiK7wY26yzzaLf1AxOvj4=;
        b=biiL2z7lyaMu75ItUxsPBfsgtYu7eex6FdXQ751Mhp6eTLG1tGfF/PieqYTGt/H1Og
         VOmFR/4XzUA1w69nyNLH7GjBu4l5esn2WMRnCSF2jFFXigZNJgGQCEXFZZuYkKwwvY1I
         AH5fhbbVkud4a1FOsM12cyBrYnzTHGfxIffPg5WvqWbxZwbRwGT/grDpWRMwZcm3K6le
         T7Jcj20pqH+cuf3XMo61W8rgp9E3AioR89DiivLyF+Eubjp9dNXYBYMs90IUnLZD8Q85
         ekTFBqt8wgtVClKDYkdI6rgjsDDs6xFYjMPBwX2UuMiUujWmULQOuaExGMSP1iCEVaYZ
         p11g==
X-Forwarded-Encrypted: i=1; AJvYcCV2wUkDVt/LFG4GHfGwMaRFQdruDBKVIeEspaqpX4tlxmVZz+X7HVuvA3d2hHammKFK2WWTPkebiovmJnbP@vger.kernel.org, AJvYcCVDk7JPco5mCspvH+94etSJ2GV2osuseiePI+iwQEfX7cNz27AboLxjHrQrjk5/o0XHgfizDCJpMBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkoCn0QPxc1Wqmr4c+bsAA/T7lCSqR5z8iQQUwvooW2tbn6lU
	+EQEjy7g3iPoGCw9hxSAh9IFpQ2cUD4KsBFq9cQ2PmO+3UAfo/K6KiaM4i4=
X-Gm-Gg: ASbGncsUnR3x0+7M4Qz+b+oE5GKB1GT/1NG/4P2UYqHfu4qlPymhULz/TSbtroQyYAy
	0PU3b0L/mKtRL4WE8h1AvXnYZQBTT/ipyit0C3zmppsbSqnM3yHkAzLi9ObD+XULP4ztFR1Iuzv
	+9JGiDr27aayZWJvQvH9xynlisTxtfDL3GNtv94WtfzEUr4J6otkgZNKg88hN9zRcvhcrmOFvKj
	9tVAlpfWzJNedH7rRFxhE1/cE7FC3Lm0IMFWPzScisiwrow7g==
X-Google-Smtp-Source: AGHT+IH2fxR59shsdT6qF2Au7JVCr3BhQRRbawQoJOXF2EcEX8drfbSQp1+BXogMmIC3tcDZJfp9WQ==
X-Received: by 2002:a17:902:cf0f:b0:20c:af5c:fc90 with SMTP id d9443c01a7336-215d00d0769mr63698495ad.49.1733327755469;
        Wed, 04 Dec 2024 07:55:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215714b4f77sm67604095ad.202.2024.12.04.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:55 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v4 4/8] ynl: add missing pieces to ethtool spec to better match uapi header
Date: Wed,  4 Dec 2024 07:55:45 -0800
Message-ID: <20241204155549.641348-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
References: <20241204155549.641348-1-sdf@fomichev.me>
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
 Documentation/netlink/specs/ethtool.yaml | 358 ++++++++++++++++++++++-
 1 file changed, 346 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..c7634e957d9c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -5,6 +5,7 @@ name: ethtool
 protocol: genetlink-legacy
 
 doc: Partial family for Ethtool Netlink.
+uapi-header: linux/ethtool_netlink_generated.h
 
 definitions:
   -
@@ -12,43 +13,99 @@ doc: Partial family for Ethtool Netlink.
     enum-name:
     type: enum
     entries: [ vxlan, geneve, vxlan-gpe ]
+    enum-cnt-name: __ethtool-udp-tunnel-type-cnt
+    render-max: true
   -
     name: stringset
     type: enum
     entries: []
+    header: linux/ethtool.h # skip rendering, no actual definition
   -
     name: header-flags
     type: flags
-    entries: [ compact-bitsets, omit-reply, stats ]
+    name-prefix: ethtool-flag-
+    doc: common ethtool header flags
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
+    header: linux/ethtool.h
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
+    doc: "groups of PSE extended states functions. IEEE 802.3-2022 33.2.4.4 Variables"
     type: enum
     name-prefix: ethtool-c33-pse-ext-state-
+    header: linux/ethtool.h
     entries:
-        - none
-        - error-condition
-        - mr-mps-valid
-        - mr-pse-enable
-        - option-detect-ted
-        - option-vport-lim
-        - ovld-detected
-        - power-not-available
-        - short-detected
+        -
+          name: none
+          doc: none
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
+    attr-cnt-name: __ethtool-a-header-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: dev-index
         type: u32
@@ -65,7 +122,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: bitset-bit
+    attr-cnt-name: __ethtool-a-bitset-bit-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: index
         type: u32
@@ -77,7 +139,12 @@ doc: Partial family for Ethtool Netlink.
         type: flag
   -
     name: bitset-bits
+    attr-cnt-name: __ethtool-a-bitset-bits-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: bit
         type: nest
@@ -85,7 +152,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset-bit
   -
     name: bitset
+    attr-cnt-name: __ethtool-a-bitset-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: nomask
         type: flag
@@ -104,7 +176,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: string
+    attr-cnt-name: __ethtool-a-string-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: index
         type: u32
@@ -113,7 +190,16 @@ doc: Partial family for Ethtool Netlink.
         type: string
   -
     name: strings
+    attr-cnt-name: __ethtool-a-strings-cnt
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
@@ -121,7 +207,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: string
   -
     name: stringset
+    attr-cnt-name: __ethtool-a-stringset-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: id
         type: u32
@@ -135,7 +226,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: strings
   -
     name: stringsets
+    attr-cnt-name: __ethtool-a-stringsets-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: stringset
         type: nest
@@ -143,7 +239,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: stringset
   -
     name: strset
+    attr-cnt-name: __ethtool-a-strset-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -158,7 +259,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: privflags
+    attr-cnt-name: __ethtool-a-privflags-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -170,7 +276,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: rings
+    attr-cnt-name: __ethtool-a-rings-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -205,6 +316,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: tcp-data-split
         type: u8
+        enum: tcp-data-split
       -
         name: cqe-size
         type: u32
@@ -223,31 +335,48 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: mm-stat
+    attr-cnt-name: __ethtool-a-mm-stat-cnt
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
+    attr-cnt-name: __ethtool-a-mm-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -285,7 +414,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: mm-stat
   -
     name: linkinfo
+    attr-cnt-name: __ethtool-a-linkinfo-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -307,7 +441,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: linkmodes
+    attr-cnt-name: __ethtool-a-linkmodes-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -343,7 +482,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: linkstate
+    attr-cnt-name: __ethtool-a-linkstate-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -368,7 +512,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: debug
+    attr-cnt-name: __ethtool-a-debug-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -379,7 +528,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset
   -
     name: wol
+    attr-cnt-name: __ethtool-a-wol-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -393,7 +547,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: features
+    attr-cnt-name: __ethtool-a-features-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -416,7 +575,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: bitset
   -
     name: channels
+    attr-cnt-name: __ethtool-a-channels-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -448,7 +612,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: irq-moderation
+    attr-cnt-name: __ethtool-a-irq-moderation-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: usec
         type: u32
@@ -460,7 +629,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: profile
+    attr-cnt-name: __ethtool-a-profile-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: irq-moderation
         type: nest
@@ -468,7 +642,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: irq-moderation
   -
     name: coalesce
+    attr-cnt-name: __ethtool-a-coalesce-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -565,7 +744,12 @@ doc: Partial family for Ethtool Netlink.
 
   -
     name: pause-stat
+    attr-cnt-name: __ethtool-a-pause-stat-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -577,7 +761,12 @@ doc: Partial family for Ethtool Netlink.
         type: u64
   -
     name: pause
+    attr-cnt-name: __ethtool-a-pause-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -600,7 +789,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: eee
+    attr-cnt-name: __ethtool-a-eee-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -627,7 +821,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: ts-stat
+    attr-cnt-name: __ethtool-a-ts-stat-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: tx-pkts
         type: uint
@@ -639,7 +838,12 @@ doc: Partial family for Ethtool Netlink.
         type: uint
   -
     name: tsinfo
+    attr-cnt-name: __ethtool-a-tsinfo-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -665,19 +869,32 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: ts-stat
   -
     name: cable-result
+    attr-cnt-name: __ethtool-a-cable-result-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pair
+        doc: ETHTOOL_A_CABLE_PAIR
         type: u8
       -
         name: code
+        doc: ETHTOOL_A_CABLE_RESULT_CODE
         type: u8
       -
         name: src
+        doc: ETHTOOL_A_CABLE_INF_SRC
         type: u32
   -
     name: cable-fault-length
+    attr-cnt-name: __ethtool-a-cable-fault-length-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pair
         type: u8
@@ -689,7 +906,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: cable-nest
+    attr-cnt-name: __ethtool-a-cable-nest-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: result
         type: nest
@@ -700,20 +922,31 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-fault-length
   -
     name: cable-test
+    attr-cnt-name: __ethtool-a-cable-test-cnt
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
+    attr-cnt-name: __ethtool-a-cable-test-ntf-cnt
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
@@ -721,7 +954,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-nest
   -
     name: cable-test-tdr-cfg
+    attr-cnt-name: __ethtool-a-cable-test-tdr-cfg-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: first
         type: u32
@@ -736,7 +974,12 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: cable-test-tdr-ntf
+    attr-cnt-name: __ethtool-a-cable-test-tdr-ntf-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -750,7 +993,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-nest
   -
     name: cable-test-tdr
+    attr-cnt-name: __ethtool-a-cable-test-tdr-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -761,7 +1009,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: cable-test-tdr-cfg
   -
     name: tunnel-udp-entry
+    attr-cnt-name: __ethtool-a-tunnel-udp-entry-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: port
         type: u16
@@ -772,7 +1025,12 @@ doc: Partial family for Ethtool Netlink.
         enum: udp-tunnel-type
   -
     name: tunnel-udp-table
+    attr-cnt-name: __ethtool-a-tunnel-udp-table-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: size
         type: u32
@@ -787,14 +1045,24 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: tunnel-udp-entry
   -
     name: tunnel-udp
+    attr-cnt-name: __ethtool-a-tunnel-udp-cnt
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
+    attr-cnt-name: __ethtool-a-tunnel-info-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -805,7 +1073,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: tunnel-udp
   -
     name: fec-stat
+    attr-cnt-name: __ethtool-a-fec-stat-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -823,7 +1096,12 @@ doc: Partial family for Ethtool Netlink.
         sub-type: u64
   -
     name: fec
+    attr-cnt-name: __ethtool-a-fec-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -844,7 +1122,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: fec-stat
   -
     name: module-eeprom
+    attr-cnt-name: __ethtool-a-module-eeprom-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -869,7 +1152,12 @@ doc: Partial family for Ethtool Netlink.
         type: binary
   -
     name: stats-grp
+    attr-cnt-name: __ethtool-a-stats-grp-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -912,7 +1200,12 @@ doc: Partial family for Ethtool Netlink.
         name: hist-val
   -
     name: stats
+    attr-cnt-name: __ethtool-a-stats-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: pad
         type: pad
@@ -933,7 +1226,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: phc-vclocks
+    attr-cnt-name: __ethtool-a-phc-vclocks-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -947,7 +1245,12 @@ doc: Partial family for Ethtool Netlink.
         sub-type: s32
   -
     name: module
+    attr-cnt-name: __ethtool-a-module-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -960,7 +1263,13 @@ doc: Partial family for Ethtool Netlink.
         type: u8
   -
     name: c33-pse-pw-limit
+    attr-cnt-name: __ethtool-a-c33-pse-pw-limit-cnt
+    attr-max-name: __ethtool-a-c33-pse-pw-limit-max
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: min
         type: u32
@@ -969,7 +1278,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: pse
+    attr-cnt-name: __ethtool-a-pse-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1027,7 +1341,12 @@ doc: Partial family for Ethtool Netlink.
         nested-attributes: c33-pse-pw-limit
   -
     name: rss
+    attr-cnt-name: __ethtool-a-rss-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1053,7 +1372,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: plca
+    attr-cnt-name: __ethtool-a-plca-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1084,7 +1408,12 @@ doc: Partial family for Ethtool Netlink.
         type: u32
   -
     name: module-fw-flash
+    attr-cnt-name: __ethtool-a-module-fw-flash-cnt
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: header
         type: nest
@@ -1110,7 +1439,12 @@ doc: Partial family for Ethtool Netlink.
         type: uint
   -
     name: phy
+    attr-cnt-name: __ethtool-a-phy-cnt
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


