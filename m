Return-Path: <netdev+bounces-52088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A47FD3B9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7018C2823F9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6741A282;
	Wed, 29 Nov 2023 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUDpRPL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5498D6C;
	Wed, 29 Nov 2023 02:12:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-409299277bbso49625725e9.2;
        Wed, 29 Nov 2023 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252759; x=1701857559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OiXF+wSumcaIiWQAp9R+NZ5wr+B+h86icAQ57NmgD4=;
        b=OUDpRPL5dvim3XL/9v7HEPJK9U2O5kigeRyj0DbKBWGRXqGdFn4OX6BOlGwLZFBqpK
         eGGbyo7m3QqqsRC7Dp+/Un9xEz46DMPFCDsixUuDudSHOK4TZ+o3dNLNyRQOTLGmyb9X
         mqONCt1dRVETMPnIio6qu70ee9Kdz1AHTmIVyMfBjSiQrzo771QRWkp/QloRQF6xBoMP
         58JhMK1vD5Cm/CtAFEMqsqi4WWk9+GTW8C6lVfniXBs9NDr3TZIGSY1WKbf5AID2nSPE
         qU9dbuAbT2hkyRenicpLr5m8xLc6sspeSzuWfIzn77EHot+yVkde4vUHO7ZavAfj7jJe
         BgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252759; x=1701857559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OiXF+wSumcaIiWQAp9R+NZ5wr+B+h86icAQ57NmgD4=;
        b=FNnROzOqElfm8nuXQmsH4O3NXKJa84yl3KJYyqlwFoDxGeLeExARb+Ttj4S1QuhR6n
         SOX6reN7cSOGLUDGvKpWHTh3k9WkA+0FEgQpGDbOAI3md1G+tsBFYN94Y8U5FLPadyU4
         NIq6T3fFJ6FW6lGuE7gqULtbNN+zTpf9rOeir1Ap8AdwYvIT3KMmiIMl4VBciSFHIkc1
         j/FEJFUp45gwUucgOHR2l8P1dO/DsdNKk4xrSfp9WuONCDdU7nSjTLEYDhhzj4m78xl7
         btC9lwkrBw41UAchlNFLY3z0mPOAMMBq7TtfRUotDbksFUatXAFSK5XXBBk5qmHtpZef
         XEWw==
X-Gm-Message-State: AOJu0YxUhQ/1KYKnmBZZWJi8i9SV7zfsAdvNos+fYHl/YsFzDJw0C4H/
	BF+sDFS12E5Nu+j956u4gsOjglK/WlKqCA==
X-Google-Smtp-Source: AGHT+IEb1G5KGeNi155xEZCaZDYcLdU0rR2+hQfT8nFDSAJI8xnp2Pcl7AdoOuAfRxX+e8B0U+NMUQ==
X-Received: by 2002:a05:600c:35ca:b0:406:54e4:359c with SMTP id r10-20020a05600c35ca00b0040654e4359cmr13234269wmq.19.1701252758568;
        Wed, 29 Nov 2023 02:12:38 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:648d:8c5c:f210:5d75])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm17296877wrc.95.2023.11.29.02.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:12:37 -0800 (PST)
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
Subject: [RFC PATCH net-next v1 5/6] doc/netlink/specs: Add a spec for tc
Date: Wed, 29 Nov 2023 10:11:58 +0000
Message-ID: <20231129101159.99197-6-donald.hunter@gmail.com>
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

This is a work-in-progress spec for tc that covers:
 - most of the qdiscs
 - the flower classifier
 - new, del, get for qdisc, chain, class and filter

Notable omissions:
 - most of the stats attrs are left as binary blobs
 - notifications are not yet implemented

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 2074 +++++++++++++++++++++++++++
 1 file changed, 2074 insertions(+)
 create mode 100644 Documentation/netlink/specs/tc.yaml

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
new file mode 100644
index 000000000000..885761e2c97a
--- /dev/null
+++ b/Documentation/netlink/specs/tc.yaml
@@ -0,0 +1,2073 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: tc
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Netlink raw family for tc qdisc, chain, class and filter configuration
+  over rtnetlink.
+
+definitions:
+  -
+    name: tcmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad1
+        type: u8
+      -
+        name: pad2
+        type: u16
+      -
+        name: ifindex
+        type: s32
+      -
+        name: handle
+        type: u32
+      -
+        name: parent
+        type: u32
+      -
+        name: info
+        type: u32
+  -
+    name: tc-cls-flags
+    type: flags
+    entries:
+      - skip-hw
+      - skip-sw
+      - in-hw
+      - not-in-nw
+      - verbose
+  -
+    name: tc-stats
+    type: struct
+    members:
+      -
+        name: bytes
+        type: u64
+      -
+        name: packets
+        type: u32
+      -
+        name: drops
+        type: u32
+      -
+        name: overlimits
+        type: u32
+      -
+        name: bps
+        type: u32
+      -
+        name: pps
+        type: u32
+      -
+        name: qlen
+        type: u32
+      -
+        name: backlog
+        type: u32
+  -
+    name: tc-cbs-qopt
+    type: struct
+    members:
+      -
+        name: offload
+        type: u8
+      -
+        name: pad
+        type: binary
+        len: 3
+      -
+        name: hicredit
+        type: s32
+      -
+        name: locredit
+        type: s32
+      -
+        name: idleslope
+        type: s32
+      -
+        name: sendslope
+        type: s32
+  -
+    name: tc-etf-qopt
+    type: struct
+    members:
+      -
+        name: delta
+        type: s32
+      -
+        name: clockid
+        type: s32
+      -
+        name: flags
+        type: s32
+  -
+    name: tc-fifo-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+  -
+    name: tc-htb-opt
+    type: struct
+    members:
+      -
+        name: rate
+        type: binary
+        len: 12
+      -
+        name: ceil
+        type: binary
+        len: 12
+      -
+        name: buffer
+        type: u32
+      -
+        name: cbuffer
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: level
+        type: u32
+      -
+        name: prio
+        type: u32
+  -
+    name: tc-htb-glob
+    type: struct
+    members:
+      -
+        name: version
+        type: u32
+      -
+        name: rate2quantum
+        type: u32
+      -
+        name: defcls
+        type: u32
+      -
+        name: debug
+        type: u32
+      -
+        name: direct-pkts
+        type: u32
+  -
+    name: tc-gred-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+      -
+        name: qth-min
+        type: u32
+      -
+        name: qth-max
+        type: u32
+      -
+        name: DP
+        type: u32
+      -
+        name: backlog
+        type: u32
+      -
+        name: qave
+        type: u32
+      -
+        name: forced
+        type: u32
+      -
+        name: early
+        type: u32
+      -
+        name: other
+        type: u32
+      -
+        name: pdrop
+        type: u32
+      -
+        name: Wlog
+        type: u8
+      -
+        name: Plog
+        type: u8
+      -
+        name: Scell_log
+        type: u8
+      -
+        name: prio
+        type: u8
+      -
+        name: packets
+        type: u32
+      -
+        name: bytesin
+        type: u32
+  -
+    name: tc-gred-sopt
+    type: struct
+    members:
+      -
+        name: DPs
+        type: u32
+      -
+        name: def_DP
+        type: u32
+      -
+        name: grio
+        type: u8
+      -
+        name: flags
+        type: u8
+      -
+        name: pad1
+        type: u16
+  -
+    name: tc-hfsc-qopt
+    type: struct
+    members:
+      -
+        name: defcls
+        type: u16
+  -
+    name: tc-mqprio-qopt
+    type: struct
+    members:
+      -
+        name: num-tc
+        type: u8
+      -
+        name: prio-tc-map
+        type: binary
+        len: 16
+      -
+        name: hw
+        type: u8
+      -
+        name: count
+        type: binary
+        len: 32
+      -
+        name: offset
+        type: binary
+        len: 32
+  -
+    name: tc-multiq-qopt
+    type: struct
+    members:
+      -
+        name: bands
+        type: u16
+      -
+        name: max-bands
+        type: u16
+  -
+    name: tc-netem-qopt
+    type: struct
+    members:
+      -
+        name: latency
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: loss
+        type: u32
+      -
+        name: gap
+        type: u32
+      -
+        name: duplicate
+        type: u32
+      -
+        name: jitter
+        type: u32
+  -
+    name: tc-prio-qopt
+    type: struct
+    members:
+      -
+        name: bands
+        type: u16
+      -
+        name: priomap
+        type: binary
+        len: 16
+  -
+    name: tc-red-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+      -
+        name: qth-min
+        type: u32
+      -
+        name: qth-max
+        type: u32
+      -
+        name: Wlog
+        type: u8
+      -
+        name: Plog
+        type: u8
+      -
+        name: Scell-log
+        type: u8
+      -
+        name: flags
+        type: u8
+  -
+    name: tc-sfb-qopt
+    type: struct
+    members:
+      -
+        name: rehash-interval
+        type: u32
+      -
+        name: warmup-time
+        type: u32
+      -
+        name: max
+        type: u32
+      -
+        name: bin-size
+        type: u32
+      -
+        name: increment
+        type: u32
+      -
+        name: decrement
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: penalty-rate
+        type: u32
+      -
+        name: penalty-burst
+        type: u32
+  -
+    name: tc-sfq-qopt-v1 # TODO nested structs
+    type: struct
+    members:
+      -
+        name: quantum
+        type: u32
+      -
+        name: perturb-period
+        type: s32
+      -
+        name: limit
+        type: u32
+      -
+        name: divisor
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: depth
+        type: u32
+      -
+        name: headdrop
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: qth-min
+        type: u32
+      -
+        name: qth-mac
+        type: u32
+      -
+        name: Wlog
+        type: u8
+      -
+        name: Plog
+        type: u8
+      -
+        name: Scell-log
+        type: u8
+      -
+        name: flags
+        type: u8
+      -
+        name: max-P
+        type: u32
+      -
+        name: prob-drop
+        type: u32
+      -
+        name: forced-drop
+        type: u32
+      -
+        name: prob-mark
+        type: u32
+      -
+        name: forced-mark
+        type: u32
+      -
+        name: prob-mark-head
+        type: u32
+      -
+        name: forced-mark-head
+        type: u32
+  -
+    name: tc-tbf-qopt
+    type: struct
+    members:
+      -
+        name: rate
+        type: binary # TODO nested struct tc_ratespec
+        len: 12
+      -
+        name: peakrate
+        type: binary # TODO nested struct tc_ratespec
+        len: 12
+      -
+        name: limit
+        type: u32
+      -
+        name: buffer
+        type: u32
+      -
+        name: mtu
+        type: u32
+  -
+    name: tc-sizespec
+    type: struct
+    members:
+      -
+        name: cell-log
+        type: u8
+      -
+        name: size-log
+        type: u8
+      -
+        name: cell-align
+        type: s16
+      -
+        name: overhead
+        type: s32
+      -
+        name: linklayer
+        type: u32
+      -
+        name: mpu
+        type: u32
+      -
+        name: mtu
+        type: u32
+      -
+        name: tsize
+        type: u32
+  -
+    name: gnet-estimator
+    type: struct
+    members:
+      -
+        name: interval
+        type: s8
+      -
+        name: ewma-log
+        type: u8
+attribute-sets:
+  -
+    name: tc-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: dynamic
+        selector:
+          attribute: kind
+          list:
+            -
+              value: bfifo
+              type: binary
+              struct: tc-fifo-qopt
+            -
+              value: cake
+              type: nest
+              nested-attributes: tc-cake-attrs
+            -
+              value: cbs
+              type: nest
+              nested-attributes: tc-cbs-attrs
+            -
+              value: choke
+              type: nest
+              nested-attributes: tc-choke-attrs
+            -
+              value: clsact
+              type: binary # empty nest
+            -
+              value: codel
+              type: nest
+              nested-attributes: tc-codel-attrs
+            -
+              value: drr
+              type: binary # TODO
+            -
+              value: etf
+              type: nest
+              nested-attributes: tc-etf-attrs
+            -
+              value: ets
+              type: nest
+              nested-attributes: tc-ets-attrs
+            -
+              value: fq
+              type: nest
+              nested-attributes: tc-fq-attrs
+            -
+              value: fq_codel
+              type: nest
+              nested-attributes: tc-fq-codel-attrs
+            -
+              value: fq_pie
+              type: nest
+              nested-attributes: tc-fq-pie-attrs
+            -
+              value: flower
+              type: nest
+              nested-attributes: tc-flower-attrs
+            -
+              value: gred
+              type: nest
+              nested-attributes: tc-gred-attrs
+            -
+              value: hfsc
+              type: binary
+              struct: tc-hfsc-qopt
+            -
+              value: hhf
+              type: nest
+              nested-attributes: tc-hhf-attrs
+            -
+              value: htb
+              type: nest
+              nested-attributes: tc-htb-attrs
+            -
+              value: ingress
+              type: binary # empty nest
+            -
+              value: mq
+              type: binary # TODO
+            -
+              value: mqprio
+              type: binary
+              struct: tc-mqprio-qopt
+            -
+              value: multiq
+              type: binary
+              struct: tc-multiq-qopt
+            -
+              value: netem
+              type: nest
+              fixed-header: tc-netem-qopt
+              nested-attributes: tc-netem-attrs
+            -
+              value: pfifo
+              type: binary
+              struct: tc-fifo-qopt
+            -
+              value: pfifo_fast
+              type: binary
+              struct: tc-prio-qopt
+            -
+              value: pfifo_head_drop
+              type: binary
+              struct: tc-fifo-qopt
+            -
+              value: pie
+              type: nest
+              nested-attributes: tc-pie-attrs
+            -
+              value: plug
+              type: binary # TODO
+            -
+              value: prio
+              type: binary
+              struct: tc-prio-qopt
+            -
+              value: qfq
+              type: binary # TODO
+            -
+              value: red
+              type: nest
+              nested-attributes: tc-red-attrs
+            -
+              value: sfb
+              type: binary
+              struct: tc-sfb-qopt
+            -
+              value: sfq
+              type: binary
+              struct: tc-sfq-qopt-v1
+            -
+              value: taprio
+              type: nest
+              nested-attributes: tc-taprio-attrs
+            -
+              value: tbf
+              type: nest
+              nested-attributes: tc-tbf-attrs
+      -
+        name: stats
+        type: binary
+        struct: tc-stats
+      -
+        name: xstats
+        type: binary
+      -
+        name: rate
+        type: binary
+        struct: gnet-estimator
+      -
+        name: fcnt
+        type: u32
+      -
+        name: stats2
+        type: nest
+        nested-attributes: tca-stats-attrs
+      -
+        name: stab
+        type: nest
+        nested-attributes: tca-stab-attrs
+      -
+        name: pad
+        type: pad
+      -
+        name: dump-invisible
+        type: flag
+      -
+        name: chain
+        type: u32
+      -
+        name: hw-offload
+        type: u8
+      -
+        name: ingress-block
+        type: u32
+      -
+        name: egress-block
+        type: u32
+      -
+        name: dump-flags
+        type: bitfield32
+      -
+        name: ext-warn-msg
+        type: string
+  -
+    name: tc-cake-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: base-rate64
+        type: u64
+      -
+        name: diffserv-mode
+        type: u32
+      -
+        name: atm
+        type: u32
+      -
+        name: flow-mode
+        type: u32
+      -
+        name: overhead
+        type: u32
+      -
+        name: rtt
+        type: u32
+      -
+        name: target
+        type: u32
+      -
+        name: autorate
+        type: u32
+      -
+        name: memory
+        type: u32
+      -
+        name: nat
+        type: u32
+      -
+        name: raw
+        type: u32
+      -
+        name: wash
+        type: u32
+      -
+        name: mpu
+        type: u32
+      -
+        name: ingress
+        type: u32
+      -
+        name: ack-filter
+        type: u32
+      -
+        name: split-gso
+        type: u32
+      -
+        name: fwmark
+        type: u32
+  -
+    name: tc-cake-stats-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: capacity-estimate64
+        type: u64
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: memory-used
+        type: u32
+      -
+        name: avg-netoff
+        type: u32
+      -
+        name: min-netlen
+        type: u32
+      -
+        name: max-netlen
+        type: u32
+      -
+        name: min-adjlen
+        type: u32
+      -
+        name: max-adjlen
+        type: u32
+      -
+        name: tin-stats
+        type: binary
+      -
+        name: deficit
+        type: s32
+      -
+        name: cobalt-count
+        type: u32
+      -
+        name: dropping
+        type: u32
+      -
+        name: drop-next-us
+        type: s32
+      -
+        name: p-drop
+        type: u32
+      -
+        name: blue-timer-us
+        type: s32
+  -
+    name: tc-cbs-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-cbs-qopt
+  -
+    name: tc-choke-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-red-qopt
+      -
+        name: stab
+        type: binary
+      -
+        name: max-p
+        type: u32
+  -
+    name: tc-codel-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: interval
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: ce-threshold
+        type: u32
+  -
+    name: tc-flower-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: indev
+        type: string
+      -
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
+      -
+        name: key-eth-dst
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-dst-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-src
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-src-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ip-proto
+        type: u8
+      -
+        name: key-ipv4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-src-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-dst-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv6-src
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-src-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-dst-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-tcp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        enum: tc-cls-flags
+        enum-as-flags: true
+      -
+        name: key-vlan-id
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-vlan-prio
+        type: u8
+      -
+        name: key-vlan-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-key-id
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-enc-ipv4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-src-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-dst-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv6-src
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-src-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-dst-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-tcp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-src-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-src-port-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-dst-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-dst-port-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-flags
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-flags-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-icmpv4-code
+        type: u8
+      -
+        name: key-icmpv4-code-mask
+        type: u8
+      -
+        name: key-icmpv4-type
+        type: u8
+      -
+        name: key-icmpv4-type-mask
+        type: u8
+      -
+        name: key-icmpv6-code
+        type: u8
+      -
+        name: key-icmpv6-code-mask
+        type: u8
+      -
+        name: key-icmpv6-type
+        type: u8
+      -
+        name: key-icmpv6-type-mask
+        type: u8
+      -
+        name: key-arp-sip
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-sip-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-tip
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-tip-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-op
+        type: u8
+      -
+        name: key-arp-op-mask
+        type: u8
+      -
+        name: key-arp-sha
+        type: binary
+      -
+        name: key-arp-sha-mask
+        type: binary
+      -
+        name: key-arp-tha
+        type: binary
+      -
+        name: key-arp-tha-mask
+        type: binary
+      -
+        name: key-mpls-ttl
+        type: u8
+      -
+        name: key-mpls-bos
+        type: u8
+      -
+        name: key-mpls-tc
+        type: u8
+      -
+        name: key-mpls-label
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-tcp-flags
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-flags-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ip-tos
+        type: u8
+      -
+        name: key-ip-tos-mask
+        type: u8
+      -
+        name: key-ip-ttl
+        type: u8
+      -
+        name: key-ip-ttl-mask
+        type: u8
+      -
+        name: key-cvlan-id
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-cvlan-prio
+        type: u8
+      -
+        name: key-cvlan-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-ip-tos
+        type: u8
+      -
+        name: key-enc-ip-tos-mask
+        type: u8
+      -
+        name: key-enc-ip-ttl
+        type: u8
+      -
+        name: key-enc-ip-ttl-mask
+        type: u8
+      -
+        name: key-enc-opts
+        type: binary
+      -
+        name: key-enc-opts-mask
+        type: binary
+      -
+        name: in-hw-count
+        type: u32
+      -
+        name: key-port-src-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-src-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-dst-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-dst-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ct-state
+        type: u16
+      -
+        name: key-ct-state-mask
+        type: u16
+      -
+        name: key-ct-zone
+        type: u16
+      -
+        name: key-ct-zone-mask
+        type: u16
+      -
+        name: key-ct-mark
+        type: u32
+      -
+        name: key-ct-mark-mask
+        type: u32
+      -
+        name: key-ct-labels
+        type: binary
+      -
+        name: key-ct-labels-mask
+        type: binary
+      -
+        name: key-mpls-opts
+        type: binary
+      -
+        name: key-hash
+        type: u32
+      -
+        name: key-hash-mask
+        type: u32
+      -
+        name: key-num-of-vlans
+        type: u8
+      -
+        name: key-pppoe-sid
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ppp-proto
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-l2-tpv3-sid
+        type: u32
+        byte-order: big-endian
+  -
+    name: tc-gred-attrs
+    attributes:
+      -
+        name: parms
+        type: binary # array of struct: tc-gred-qopt
+      -
+        name: stab
+        type: binary
+        sub-type: u8
+      -
+        name: dps
+        type: binary
+        struct: tc-gred-sopt
+      -
+        name: max-p
+        type: binary
+        sub-type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: vq-list
+        type: nest
+        nested-attributes: tca-gred-vq-list-attrs
+  -
+    name: tca-gred-vq-list-attrs
+    attributes:
+      -
+        name: entry
+        type: nest
+        nested-attributes: tca-gred-vq-entry-attrs
+        multi-attr: true
+  -
+    name: tca-gred-vq-entry-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: dp
+        type: u32
+      -
+        name: stat-bytes
+        type: u32
+      -
+        name: stat-packets
+        type: u32
+      -
+        name: stat-backlog
+        type: u32
+      -
+        name: stat-prob-drop
+        type: u32
+      -
+        name: stat-prob-mark
+        type: u32
+      -
+        name: stat-forced-drop
+        type: u32
+      -
+        name: stat-forced-mark
+        type: u32
+      -
+        name: stat-pdrop
+        type: u32
+      -
+        name: stat-other
+        type: u32
+      -
+        name: flags
+        type: u32
+  -
+    name: tc-hfsc-attrs
+    attributes:
+      -
+        name: rsc
+        type: binary
+      -
+        name: fsc
+        type: binary
+      -
+        name: usc
+        type: binary
+  -
+    name: tc-hhf-attrs
+    attributes:
+      -
+        name: backlog-limit
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: hh-flows-limit
+        type: u32
+      -
+        name: reset-timeout
+        type: u32
+      -
+        name: admit-bytes
+        type: u32
+      -
+        name: evict-timeout
+        type: u32
+      -
+        name: non-hh-weight
+        type: u32
+  -
+    name: tc-htb-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-htb-opt
+      -
+        name: init
+        type: binary
+        struct: tc-htb-glob
+      -
+        name: ctab
+        type: binary
+      -
+        name: rtab
+        type: binary
+      -
+        name: direct-qlen
+        type: u32
+      -
+        name: rate64
+        type: u64
+      -
+        name: ceil64
+        type: u64
+      -
+        name: pad
+        type: pad
+      -
+        name: offload
+        type: flag
+  -
+    name: tc-act-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: dynamic
+        selector:
+          attribute: kind
+          list:
+            -
+              value: gact
+              type: nest
+              nested-attributes: tca-gact-attrs
+      -
+        name: index
+        type: u32
+      -
+        name: stats
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: cookie
+        type: binary
+      -
+        name: flags
+        type: bitfield32
+      -
+        name: hw-stats
+        type: bitfield32
+      -
+        name: used-hw-stats
+        type: bitfield32
+      -
+        name: in-hw-count
+        type: u32
+  -
+    name: tc-etf-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-etf-qopt
+  -
+    name: tc-ets-attrs
+    attributes:
+      -
+        name: nbands
+        type: u8
+      -
+        name: nstrict
+        type: u8
+      -
+        name: quanta
+        type: nest
+        nested-attributes: tc-ets-attrs
+      -
+        name: quanta-band
+        type: u32
+        multi-attr: true
+      -
+        name: priomap
+        type: nest
+        nested-attributes: tc-ets-attrs
+      -
+        name: priomap-band
+        type: u8
+        multi-attr: true
+  -
+    name: tc-fq-attrs
+    attributes:
+      -
+        name: plimit
+        type: u32
+      -
+        name: flow-plimit
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: initial-quantum
+        type: u32
+      -
+        name: rate-enable
+        type: u32
+      -
+        name: flow-default-rate
+        type: u32
+      -
+        name: flow-max-rate
+        type: u32
+      -
+        name: buckets-log
+        type: u32
+      -
+        name: flow-refill-delay
+        type: u32
+      -
+        name: orphan-mask
+        type: u32
+      -
+        name: low-rate-threshold
+        type: u32
+      -
+        name: ce-threshold
+        type: u32
+      -
+        name: timer-slack
+        type: u32
+      -
+        name: horizon
+        type: u32
+      -
+        name: horizon-drop
+        type: u8
+  -
+    name: tc-fq-codel-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: interval
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: ce-threshold
+        type: u32
+      -
+        name: drop-batch-size
+        type: u32
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: ce-threshold-selector
+        type: u8
+      -
+        name: ce-threshold-mask
+        type: u8
+  -
+    name: tc-fq-pie-attrs
+    attributes:
+      -
+        name: limit
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: target
+        type: u32
+      -
+        name: tupdate
+        type: u32
+      -
+        name: alpha
+        type: u32
+      -
+        name: beta
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: ecn-prob
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: bytemode
+        type: u32
+      -
+        name: dq-rate-estimator
+        type: u32
+  -
+    name: tc-netem-attrs
+    attributes:
+      -
+        name: corr
+        type: binary
+      -
+        name: delay-dist
+        type: binary
+        sub-type: s16
+      -
+        name: reorder
+        type: binary
+      -
+        name: corrupt
+        type: binary
+      -
+        name: loss
+        type: binary
+      -
+        name: rate
+        type: binary
+      -
+        name: ecn
+        type: u32
+      -
+        name: rate64
+        type: u64
+      -
+        name: pad
+        type: u32
+      -
+        name: latency64
+        type: s64
+      -
+        name: jitter64
+        type: s64
+      -
+        name: slot
+        type: binary
+      -
+        name: slot-dist
+        type: binary
+        sub-type: s16
+  -
+    name: tc-pie-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: tupdate
+        type: u32
+      -
+        name: alpha
+        type: u32
+      -
+        name: beta
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: bytemode
+        type: u32
+      -
+        name: dq-rate-estimator
+        type: u32
+  -
+    name: tc-red-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-red-qopt
+      -
+        name: stab
+        type: binary
+      -
+        name: max-p
+        type: u32
+      -
+        name: flags
+        type: binary
+      -
+        name: early-drop-block
+        type: u32
+      -
+        name: mark-block
+        type: u32
+  -
+    name: tc-taprio-attrs
+    attributes:
+      -
+        name: priomap
+        type: binary
+        struct: tc-mqprio-qopt
+      -
+        name: sched-entry-list
+        type: nest
+        nested-attributes: tc-taprio-sched-entry-list
+      -
+        name: sched-base-time
+        type: s64
+      -
+        name: sched-single-entry
+        type: nest
+        nested-attributes: tc-taprio-sched-entry
+      -
+        name: sched-clockid
+        type: s32
+      -
+        name: pad
+        type: pad
+      -
+        name: admin-sched
+        type: binary
+      -
+        name: sched-cycle-time
+        type: s64
+      -
+        name: sched-cycle-time-extension
+        type: s64
+      -
+        name: flags
+        type: u32
+      -
+        name: txtime-delay
+        type: u32
+      -
+        name: tc-entry
+        type: nest
+        nested-attributes: tc-taprio-tc-entry-attrs
+  -
+    name: tc-taprio-sched-entry-list
+    attributes:
+      -
+        name: entry
+        type: nest
+        nested-attributes: tc-taprio-sched-entry
+  -
+    name: tc-taprio-sched-entry
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: cmd
+        type: u8
+      -
+        name: gate-mask
+        type: u32
+      -
+        name: interval
+        type: u32
+  -
+    name: tc-taprio-tc-entry-attrs
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: max-sdu
+        type: u32
+      -
+        name: fp
+        type: u32
+  -
+    name: tc-tbf-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-tbf-qopt
+      -
+        name: rtab
+        type: binary
+      -
+        name: ptab
+        type: binary
+      -
+        name: rate64
+        type: u64
+      -
+        name: prate4
+        type: u64
+      -
+        name: burst
+        type: u32
+      -
+        name: pburst
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: tca-gact-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+      -
+        name: parms
+        type: binary
+      -
+        name: prob
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tca-stab-attrs
+    attributes:
+      -
+        name: base
+        type: binary
+        struct: tc-sizespec
+      -
+        name: data
+        type: binary
+  -
+    name: tca-stats-attrs
+    attributes:
+      -
+        name: basic
+        type: binary
+      -
+        name: rate-est
+        type: binary
+      -
+        name: queue
+        type: binary
+      -
+        name: app
+        type: binary # TODO dynamic 2+ level nest
+        selector:
+          attribute: tca-kind
+          list:
+            -
+              value: bfifo
+              type: binary
+            -
+              value: blackhole
+              type: binary
+            -
+              value: cake
+              type: nest
+              nested-attributes: tc-cake-stats-attrs
+            -
+              value: cbs
+              type: binary
+            -
+              value: choke
+              type: binary
+            -
+              value: clsact
+              type: binary
+            -
+              value: codel
+              type: binary
+            -
+              value: drr
+              type: binary
+            -
+              value: etf
+              type: binary
+            -
+              value: ets
+              type: binary
+            -
+              value: fq
+              type: binary
+            -
+              value: fq_codel
+              type: binary
+            -
+              value: fq_pie
+              type: binary
+            -
+              value: flower
+              type: binary
+            -
+              value: gred
+              type: binary
+            -
+              value: hfsc
+              type: binary
+            -
+              value: hhf
+              type: binary
+            -
+              value: htb
+              type: binary
+            -
+              value: ingress
+              type: binary
+            -
+              value: mq
+              type: binary
+            -
+              value: mqprio
+              type: binary
+            -
+              value: multiq
+              type: binary
+            -
+              value: netem
+              type: binary
+            -
+              value: noqueue
+              type: binary
+            -
+              value: pfifo
+              type: binary
+            -
+              value: pfifo_fast
+              type: binary
+            -
+              value: pfifo_head_drop
+              type: binary
+            -
+              value: pie
+              type: binary
+            -
+              value: plug
+              type: binary
+            -
+              value: prio
+              type: binary
+            -
+              value: qfq
+              type: binary
+            -
+              value: red
+              type: binary
+            -
+              value: sfb
+              type: binary
+            -
+              value: sfq
+              type: binary
+            -
+              value: taprio
+              type: binary
+            -
+              value: tbf
+              type: binary
+      -
+        name: rate-est64
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: basic-hw
+        type: binary
+      -
+        name: pkt64
+        type: binary
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newqdisc
+      doc: Create new tc qdisc.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 36
+          attributes: &create-params
+            - tcm-family
+            - tcm-ifindex
+            - tcm-handle
+            - tcm-parent
+            - tca-kind
+            - tca-options
+            - tca-rate
+            - tca-stab
+            - tca-chain
+            - tca-ingress-block
+            - tca-egress-block
+    -
+      name: delqdisc
+      doc: Delete existing tc qdisc.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 37
+          attributes: &lookup-params
+            - tcm-family
+            - tcm-ifindex
+            - tcm-handle
+            - tcm-parent
+    -
+      name: getqdisc
+      doc: Get / dump tc qdisc information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 38
+          attributes:
+            - tcm-family
+            - tcm-ifindex
+            - tcm-handle
+            - tcm-parent
+            - tca-dump-invisible
+            - tca-dump-flags
+        reply:
+          value: 36
+          attributes: &tc-all
+            - tcm-family
+            - tcm-ifindex
+            - tcm-handle
+            - tcm-parent
+            - tca-kind
+            - tca-options
+            - tca-stats
+            - tca-xstats
+            - tca-rate
+            - tca-fcnt
+            - tca-stats2
+            - tca-stab
+            - tca-chain
+            - tca-ingress-block
+            - tca-egress-block
+    -
+      name: newtclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 40
+          attributes: *create-params
+    -
+      name: deltclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 41
+          attributes: *lookup-params
+    -
+      name: gettclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 42
+          attributes: *lookup-params
+        reply:
+          value: 40
+          attributes: *tc-all
+    -
+      name: newtfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 44
+          attributes: *create-params
+    -
+      name: deltfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 45
+          attributes: *lookup-params
+    -
+      name: gettfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 46
+          attributes: *lookup-params
+        reply:
+          value: 44
+          attributes: *tc-all
+    -
+      name: newchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 100
+          attributes: *create-params
+    -
+      name: delchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 101
+          attributes: *lookup-params
+    -
+      name: getchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 102
+          attributes: *lookup-params
+        reply:
+          value: 100
+          attributes: *tc-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-tc
+      value: 4
-- 
2.42.0


