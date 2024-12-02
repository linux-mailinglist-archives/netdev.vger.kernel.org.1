Return-Path: <netdev+bounces-148152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672D9E08F2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E86B16EEC6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804F1DA11A;
	Mon,  2 Dec 2024 16:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401351D90AC;
	Mon,  2 Dec 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156986; cv=none; b=nfaMDkLA2Y0mZbpi9ihoOLFAWOHbchd9mRVZrW+LZGGuBrJwwc16crJ3gzAyWLN+zRey71qHdokI8fLiTRhb0DsYK7TrDw4F7zKnSdS0+9+5/kYDfNZjv0XwVuVR0uG4BbEwchzbWZSmFgPEUZrn1fuHU9wyxAbGTQenRErnfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156986; c=relaxed/simple;
	bh=NmSw+q1isXaiAp2leJ+cQrWBMwxTiP22ffr+z/rMGa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft1l75DUzlYwZ5BlIvRS7p6KhMRwZ30UzfKeDlbQe99PNdZ89/NNaRkIp4XrzOrXxj2oAvUncZC9aSSr8AL/8dfymMVvGOlQFdTglKyefXOXldLJFE6czqKqqVZ8WcOo/yparDuHo8TkfoLE16sUlWcmjbEU2C5Wzfw3VUWHNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21561af95c3so17687515ad.3;
        Mon, 02 Dec 2024 08:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156983; x=1733761783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqu0iXawGFxj2/+c+jISNhs8tZDONWPWVEAsbnIrSjU=;
        b=JGOmTFX+X9S5Foo0lqNMOTT/LbaanIaxooymorvVxZuU/oHdzgPgwP1SHDls2FDnOk
         eGY13xoo7MHosTWclW5yyY5g1uV71Yej1t0TJRFHe7pRk/LEBF7UUMadXYDj/U6A71vS
         GzGoMbRjKtBi+mzoZmEfHevLWrVf02/ML7iFLs6K5apOOqja6vuCgk5FHX8Eg0F0YQ+c
         hmNFvlKqCQtGZDtJjqNLegdETW/+fouQb67s9C7bQi+K3WLryM+ooJWpWYRQnfYvPAZG
         amCEXNluGk0bsvrESJ5pqoTVRUSKWRDR3rC9LrSYMx6sSliDsv8I1oteozZeaw9zAcb/
         eMQA==
X-Forwarded-Encrypted: i=1; AJvYcCUkcn57SFbB60jbAVuNJYBuhh+d08CV+kBerEsa0g7R3WdVcZQn/P2CbebjU3T8MXNImB0QmxG7Vu0=@vger.kernel.org, AJvYcCXZ0busGm5rEQAr2VZTOWGwAXNPIluMsFI15iYtiJ3QeeVEzy2DPJGAGXfRdVyyikTkqdgx9Bx2b9MPj0jk@vger.kernel.org
X-Gm-Message-State: AOJu0YxzE70iJCAqLxa4thgx6z9HnfhRYMepl1H1POBb7mLo6npgIk1x
	LvfH8rlYhlGBrw4Sura1LOBbec77W4dVkbbnrFNvYEZAgWLR6WEGrq2yKPM=
X-Gm-Gg: ASbGnculm4CaX7aYSnahlTgUDvkgobH4pZscxN1S6Jm7xIluThPwbhMuqUX86vq4JJ5
	WbPHuw8rByheghpM2OEGAuJx7hRwJy73WqITDSoz3ChNYz9t7y87o4hiWUtg2NUiKtqFhzociHS
	d9704aWL49LZfyn2NZMaAetVI9vVHv/07icNjGkofNRLfnzDSvRH+K5PMhx/V8YiJEINTmCyhlO
	2bG7VadmCwEuMCm8CJ799KDvvOGHX5WdQQ+pZItGuquHdw8ew==
X-Google-Smtp-Source: AGHT+IGbOd5+q8sALyKzNrESTVdwF3B5m6NwXX4kJoaYv8mOV2b/q0sC7GS1a03WmkW5zCoIqyIBfw==
X-Received: by 2002:a17:902:ef43:b0:215:5bd8:9f7b with SMTP id d9443c01a7336-2155bd8a314mr158267015ad.15.1733156982892;
        Mon, 02 Dec 2024 08:29:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156b12f791sm38595185ad.44.2024.12.02.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:42 -0800 (PST)
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
Subject: [PATCH net-next v3 4/8] ynl: add missing pieces to ethtool spec to better match uapi header
Date: Mon,  2 Dec 2024 08:29:32 -0800
Message-ID: <20241202162936.3778016-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
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
index 93369f0eb816..efa00665c191 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -5,6 +5,7 @@ name: ethtool
 protocol: genetlink-legacy
 
 doc: Partial family for Ethtool Netlink.
+uapi-header: linux/ethtool_netlink_generated.h
 
 definitions:
   -
@@ -12,43 +13,97 @@ doc: Partial family for Ethtool Netlink.
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
+    attr-cnt-name: __ethtool-a-header-cnt
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
+    attr-cnt-name: __ethtool-a-bitset-bit-cnt
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
+    attr-cnt-name: __ethtool-a-bitset-bits-cnt
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
+    attr-cnt-name: __ethtool-a-bitset-cnt
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
+    attr-cnt-name: __ethtool-a-string-cnt
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
@@ -121,7 +205,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -135,7 +224,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -143,7 +237,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -158,7 +257,12 @@ doc: Partial family for Ethtool Netlink.
 
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
@@ -170,7 +274,12 @@ doc: Partial family for Ethtool Netlink.
 
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
@@ -285,7 +412,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -307,7 +439,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -343,7 +480,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -368,7 +510,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -379,7 +526,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -393,7 +545,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -416,7 +573,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -448,7 +610,12 @@ doc: Partial family for Ethtool Netlink.
 
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
@@ -460,7 +627,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -468,7 +640,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -565,7 +742,12 @@ doc: Partial family for Ethtool Netlink.
 
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
@@ -577,7 +759,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -600,7 +787,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -627,7 +819,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -639,7 +836,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -665,19 +867,32 @@ doc: Partial family for Ethtool Netlink.
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
+    attr-cnt-name: __ethtool-a-cable-fault-length-cnt
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
+    attr-cnt-name: __ethtool-a-cable-nest-cnt
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
@@ -721,7 +952,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -736,7 +972,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -750,7 +991,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -761,7 +1007,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -772,7 +1023,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -787,14 +1043,24 @@ doc: Partial family for Ethtool Netlink.
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
@@ -805,7 +1071,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -823,7 +1094,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -844,7 +1120,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -869,7 +1150,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -912,7 +1198,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -933,7 +1224,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -947,7 +1243,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -960,7 +1261,13 @@ doc: Partial family for Ethtool Netlink.
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
@@ -969,7 +1276,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -1027,7 +1339,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -1053,7 +1370,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -1084,7 +1406,12 @@ doc: Partial family for Ethtool Netlink.
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
@@ -1110,7 +1437,12 @@ doc: Partial family for Ethtool Netlink.
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


