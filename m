Return-Path: <netdev+bounces-66896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B48415C6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9761F23052
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76450A83;
	Mon, 29 Jan 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWbo9kVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DE15959E;
	Mon, 29 Jan 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567741; cv=none; b=QmSVGp1UqF0EpW80KacJsark9WUFCAMi86KrSnWGDxFM36bS6E4xzOw33EoPYmcvJpzf4+sJb84UOx9KSLv0VEZIV7mdqIFBrdDmkEMJW+EaEKTYXaeekVRpk3nymuP142KlyGycczwopybFJ5ivZrU1E8lybI9BMOxN1jH8yXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567741; c=relaxed/simple;
	bh=8098iyevRZmq8WUQ6q/OsqtuWNClMOQs4E4MOL4qOWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NE+SVvsARV9SrE8IXhng6zfjuh8rVVidMQ0KSkgQAQYryzEfKkOZjkso1nKx2O+V+IYZmhCN+5TJ/CTuFnYn7KF+lR1ElBSZwHPzsl8pCwPrdSYXP9bY2Yrkl4R8simTUr+FKwSTz5pHpWP8PUHdGIZx7nlq6dADRs1hP2q8SZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWbo9kVw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso3989744e87.2;
        Mon, 29 Jan 2024 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567736; x=1707172536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBzt6nKGUUhQiFpCbWAozRASE/SVErwuAmCVEdz/fDE=;
        b=DWbo9kVwbwp2Q8Llfp2GuNJRVGOOAiU61NekYPeIELh3NJDWIey/mfV5BoZTBtAB0v
         jl8RSiVcSFc502SUPPgepiOhgsbXGRd4kti09Ke5zz6wiCbJbDegeA0E7Oi/h6o6sE/K
         Tc7yycy/VBrO1Y/oofs/23I6us+a5rmTGTLR+TYnspdEIsmcyKBygMFJZhmoVB96Opu1
         Lv/DfO3lPk/KSozDJu80p0atXDXgmFYO4FzgGfkzBMFnygGoReIE0NGNRH+NcRaowbeE
         UpQFlpZVQuKQfpiiIOHZWZGnLelx/Ruee5IoR9w8thw1O+04vVuJJjwuRJUuGqCLRdbL
         t8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567736; x=1707172536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBzt6nKGUUhQiFpCbWAozRASE/SVErwuAmCVEdz/fDE=;
        b=WmQ0GcHi/X011FHZ0XcIImJTxMqg7vxWvw6NUWVGz3r1wNtEu8cFoKqQbQCegApUU7
         xtcC3Ox2mCL2lzYTQrmdTYf0wqdZ9ZJIwjCMVPTcbm1xflXAtV3JRQ35LYgl+aFLoN9Y
         +bQLZa3XNyLVH/RR1yFf8qg45Bq78bWVRUbQkqEiWLOs2kC6ruyXRcoGQGv/IXdCFOtr
         aEN9lcDioiOdbi4j5VvkKX18HKjhmwgHp1bVaJSHKTeGqe0nYROvBg4mB2RqIF6ZvOK/
         rrFF0eeOT02R9ibH6WLemWiwAJ01xCAwl8qKH6nZWM82xpB26C+D3qLnGKRx1gwfApjN
         rrvQ==
X-Gm-Message-State: AOJu0Yy/vaYsnk4AyzrUqTfSUJ2vKZ+ViP4UbYIhqYhwnFi/MCoAqq4W
	EhpxVutpZvvhBzDsoMhVv47cYriPZQwI+URG7ud/RxIYMmV8KMvR/OFaFY0xlfU=
X-Google-Smtp-Source: AGHT+IEhaCXFuhc7tgcFzqZwvgUt7b2rsel8hoJZkEJHttzsOUeHl6+4RlYPSRRPN/ccRMBsJGeskw==
X-Received: by 2002:ac2:51a7:0:b0:50e:4a61:c369 with SMTP id f7-20020ac251a7000000b0050e4a61c369mr4384329lfk.46.1706567735548;
        Mon, 29 Jan 2024 14:35:35 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:35 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 13/13] doc/netlink/specs: Update the tc spec
Date: Mon, 29 Jan 2024 22:34:58 +0000
Message-ID: <20240129223458.52046-14-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in many of the gaps in the tc netlink spec, including stats attrs,
classes and actions. Many documentation strings have also been added.

This is still a work in progress, albeit fairly complete:
 - there are still many attributes left as binary blobs.
 - actions have not had much testing

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 2218 +++++++++++++++++++++++++--
 1 file changed, 2067 insertions(+), 151 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4346fa402fc9..4b21b00dbebe 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -48,21 +48,28 @@ definitions:
       -
         name: bytes
         type: u64
+        doc: Number of enqueued bytes
       -
         name: packets
         type: u32
+        doc: Number of enqueued packets
       -
         name: drops
         type: u32
+        doc: Packets dropped because of lack of resources
       -
         name: overlimits
         type: u32
+        doc: |
+          Number of throttle events when this flow goes out of allocated bandwidth
       -
         name: bps
         type: u32
+        doc: Current flow byte rate
       -
         name: pps
         type: u32
+        doc: Current flow packet rate
       -
         name: qlen
         type: u32
@@ -112,6 +119,7 @@ definitions:
       -
         name: limit
         type: u32
+        doc: Queue length; bytes for bfifo, packets for pfifo
   -
     name: tc-htb-opt
     type: struct
@@ -119,11 +127,11 @@ definitions:
       -
         name: rate
         type: binary
-        len: 12
+        struct: tc-ratespec
       -
         name: ceil
         type: binary
-        len: 12
+        struct: tc-ratespec
       -
         name: buffer
         type: u32
@@ -149,15 +157,19 @@ definitions:
       -
         name: rate2quantum
         type: u32
+        doc: bps->quantum divisor
       -
         name: defcls
         type: u32
+        doc: Default class number
       -
         name: debug
         type: u32
+        doc: Debug flags
       -
         name: direct-pkts
         type: u32
+        doc: Count of non shaped packets
   -
     name: tc-gred-qopt
     type: struct
@@ -165,15 +177,19 @@ definitions:
       -
         name: limit
         type: u32
+        doc: HARD maximal queue length in bytes
       -
         name: qth-min
         type: u32
+        doc: Min average length threshold in bytes
       -
         name: qth-max
         type: u32
+        doc: Max average length threshold in bytes
       -
         name: DP
         type: u32
+        doc: Up to 2^32 DPs
       -
         name: backlog
         type: u32
@@ -195,15 +211,19 @@ definitions:
       -
         name: Wlog
         type: u8
+        doc: log(W)
       -
         name: Plog
         type: u8
+        doc: log(P_max / (qth-max - qth-min))
       -
         name: Scell_log
         type: u8
+        doc: cell size for idle damping
       -
         name: prio
         type: u8
+        doc: Priority of this VQ
       -
         name: packets
         type: u32
@@ -266,9 +286,11 @@ definitions:
       -
         name: bands
         type: u16
+        doc: Number of bands
       -
         name: max-bands
         type: u16
+        doc: Maximum number of queues
   -
     name: tc-netem-qopt
     type: struct
@@ -276,21 +298,138 @@ definitions:
       -
         name: latency
         type: u32
+        doc: Added delay in microseconds
       -
         name: limit
         type: u32
+        doc: Fifo limit in packets
       -
         name: loss
         type: u32
+        doc: Random packet loss (0=none, ~0=100%)
       -
         name: gap
         type: u32
+        doc: Re-ordering gap (0 for none)
       -
         name: duplicate
         type: u32
+        doc: Random packet duplication (0=none, ~0=100%)
       -
         name: jitter
         type: u32
+        doc: Random jitter latency in microseconds
+  -
+    name: tc-netem-gimodel
+    doc: State transition probabilities for 4 state model
+    type: struct
+    members:
+      -
+        name: p13
+        type: u32
+      -
+        name: p31
+        type: u32
+      -
+        name: p32
+        type: u32
+      -
+        name: p14
+        type: u32
+      -
+        name: p23
+        type: u32
+  -
+    name: tc-netem-gemodel
+    doc: Gilbert-Elliot models
+    type: struct
+    members:
+      -
+        name: p
+        type: u32
+      -
+        name: r
+        type: u32
+      -
+        name: h
+        type: u32
+      -
+        name: k1
+        type: u32
+  -
+    name: tc-netem-corr
+    type: struct
+    members:
+      -
+        name: delay-corr
+        type: u32
+        doc: Delay correlation
+      -
+        name: loss-corr
+        type: u32
+        doc: Packet loss correlation
+      -
+        name: dup-corr
+        type: u32
+        doc: Duplicate correlation
+  -
+    name: tc-netem-reorder
+    type: struct
+    members:
+      -
+        name: probability
+        type: u32
+      -
+        name: correlation
+        type: u32
+  -
+    name: tc-netem-corrupt
+    type: struct
+    members:
+      -
+        name: probability
+        type: u32
+      -
+        name: correlation
+        type: u32
+  -
+    name: tc-netem-rate
+    type: struct
+    members:
+      -
+        name: rate
+        type: u32
+      -
+        name: packet-overhead
+        type: s32
+      -
+        name: cell-size
+        type: u32
+      -
+        name: cell-overhead
+        type: s32
+  -
+    name: tc-netem-slot
+    type: struct
+    members:
+      -
+        name: min-delay
+        type: s64
+      -
+        name: max-delay
+        type: s64
+      -
+        name: max-packets
+        type: s32
+      -
+        name: max-bytes
+        type: s32
+      -
+        name: dist-delay
+        type: s64
+      -
+        name: dist-jitter
+        type: s64
   -
     name: tc-plug-qopt
     type: struct
@@ -307,11 +446,13 @@ definitions:
     members:
       -
         name: bands
-        type: u16
+        type: u32
+        doc: Number of bands
       -
         name: priomap
         type: binary
         len: 16
+        doc: Map of logical priority -> PRIO band
   -
     name: tc-red-qopt
     type: struct
@@ -319,21 +460,27 @@ definitions:
       -
         name: limit
         type: u32
+        doc: Hard queue length in packets
       -
         name: qth-min
         type: u32
+        doc: Min average threshold in packets
       -
         name: qth-max
         type: u32
+        doc: Max average threshold in packets
       -
         name: Wlog
         type: u8
+        doc: log(W)
       -
         name: Plog
         type: u8
+        doc: log(P_max / (qth-max - qth-min))
       -
         name: Scell-log
         type: u8
+        doc: Cell size for idle damping
       -
         name: flags
         type: u8
@@ -369,71 +516,128 @@ definitions:
         name: penalty-burst
         type: u32
   -
-    name: tc-sfq-qopt-v1 # TODO nested structs
+    name: tc-sfq-qopt
     type: struct
     members:
       -
         name: quantum
         type: u32
+        doc: Bytes per round allocated to flow
       -
         name: perturb-period
         type: s32
+        doc: Period of hash perturbation
       -
         name: limit
         type: u32
+        doc: Maximal packets in queue
       -
         name: divisor
         type: u32
+        doc: Hash divisor
       -
         name: flows
         type: u32
+        doc: Maximal number of flows
+  -
+    name: tc-sfqred-stats
+    type: struct
+    members:
+      -
+        name: prob-drop
+        type: u32
+        doc: Early drops, below max threshold
+      -
+        name: forced-drop
+        type: u32
+        doc: Early drops, after max threshold
+      -
+        name: prob-mark
+        type: u32
+        doc: Marked packets, below max threshold
+      -
+        name: forced-mark
+        type: u32
+        doc: Marked packets, after max threshold
+      -
+        name: prob-mark-head
+        type: u32
+        doc: Marked packets, below max threshold
+      -
+        name: forced-mark-head
+        type: u32
+        doc: Marked packets, after max threshold
+  -
+    name: tc-sfq-qopt-v1
+    type: struct
+    members:
+      -
+        name: v0
+        type: binary
+        struct: tc-sfq-qopt
       -
         name: depth
         type: u32
+        doc: Maximum number of packets per flow
       -
         name: headdrop
         type: u32
       -
         name: limit
         type: u32
+        doc: HARD maximal flow queue length in bytes
       -
         name: qth-min
         type: u32
+        doc: Min average length threshold in bytes
       -
-        name: qth-mac
+        name: qth-max
         type: u32
+        doc: Max average length threshold in bytes
       -
         name: Wlog
         type: u8
+        doc: log(W)
       -
         name: Plog
         type: u8
+        doc: log(P_max / (qth-max - qth-min))
       -
         name: Scell-log
         type: u8
+        doc: Cell size for idle damping
       -
         name: flags
         type: u8
       -
         name: max-P
         type: u32
+        doc: probabilty, high resolution
       -
-        name: prob-drop
-        type: u32
+        name: stats
+        type: binary
+        struct: tc-sfqred-stats
+  -
+    name: tc-ratespec
+    type: struct
+    members:
       -
-        name: forced-drop
-        type: u32
+        name: cell-log
+        type: u8
       -
-        name: prob-mark
-        type: u32
+        name: linklayer
+        type: u8
       -
-        name: forced-mark
-        type: u32
+        name: overhead
+        type: u8
       -
-        name: prob-mark-head
-        type: u32
+        name: cell-align
+        type: u8
       -
-        name: forced-mark-head
+        name: mpu
+        type: u8
+      -
+        name: rate
         type: u32
   -
     name: tc-tbf-qopt
@@ -441,12 +645,12 @@ definitions:
     members:
       -
         name: rate
-        type: binary # TODO nested struct tc_ratespec
-        len: 12
+        type: binary
+        struct: tc-ratespec
       -
         name: peakrate
-        type: binary # TODO nested struct tc_ratespec
-        len: 12
+        type: binary
+        struct: tc-ratespec
       -
         name: limit
         type: u32
@@ -491,67 +695,1299 @@ definitions:
       -
         name: interval
         type: s8
+        doc: Sampling period
       -
         name: ewma-log
         type: u8
-attribute-sets:
+        doc: The log() of measurement window weight
   -
-    name: tc-attrs
+    name: tc-choke-xstats
+    type: struct
+    members:
+      -
+        name: early
+        type: u32
+        doc: Early drops
+      -
+        name: pdrop
+        type: u32
+        doc: Drops due to queue limits
+      -
+        name: other
+        type: u32
+        doc: Drops due to drop() calls
+      -
+        name: marked
+        type: u32
+        doc: Marked packets
+      -
+        name: matched
+        type: u32
+        doc: Drops due to flow match
+  -
+    name: tc-codel-xstats
+    type: struct
+    members:
+      -
+        name: maxpacket
+        type: u32
+        doc: Largest packet we've seen so far
+      -
+        name: count
+        type: u32
+        doc: How many drops we've done since the last time we entered dropping state
+      -
+        name: lastcount
+        type: u32
+        doc: Count at entry to dropping state
+      -
+        name: ldelay
+        type: u32
+        doc: in-queue delay seen by most recently dequeued packet
+      -
+        name: drop-next
+        type: s32
+        doc: Time to drop next packet
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: ecn-mark
+        type: u32
+        doc: Number of packets we've ECN marked instead of dropped
+      -
+        name: dropping
+        type: u32
+        doc: Are we in a dropping state?
+      -
+        name: ce-mark
+        type: u32
+        doc: Number of CE marked packets because of ce-threshold
+  -
+    name: tc-fq-codel-xstats
+    type: struct
+    members:
+      -
+        name: type
+        type: u32
+      -
+        name: maxpacket
+        type: u32
+        doc: Largest packet we've seen so far
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: ecn-mark
+        type: u32
+        doc: Number of packets we ECN marked instead of being dropped
+      -
+        name: new-flow-count
+        type: u32
+        doc: Number of times packets created a new flow
+      -
+        name: new-flows-len
+        type: u32
+        doc: Count of flows in new list
+      -
+        name: old-flows-len
+        type: u32
+        doc: Count of flows in old list
+      -
+        name: ce-mark
+        type: u32
+        doc: Packets above ce-threshold
+      -
+        name: memory-usage
+        type: u32
+        doc: Memory usage in bytes
+      -
+        name: drop-overmemory
+        type: u32
+  -
+    name: tc-fq-pie-xstats
+    type: struct
+    members:
+      -
+        name: packets-in
+        type: u32
+        doc: Total number of packets enqueued
+      -
+        name: dropped
+        type: u32
+        doc: Packets dropped due to fq_pie_action
+      -
+        name: overlimit
+        type: u32
+        doc: Dropped due to lack of space in queue
+      -
+        name: overmemory
+        type: u32
+        doc: Dropped due to lack of memory in queue
+      -
+        name: ecn-mark
+        type: u32
+        doc: Packets marked with ecn
+      -
+        name: new-flow-count
+        type: u32
+        doc: Count of new flows created by packets
+      -
+        name: new-flows-len
+        type: u32
+        doc: Count of flows in new list
+      -
+        name: old-flows-len
+        type: u32
+        doc: Count of flows in old list
+      -
+        name: memory-usage
+        type: u32
+        doc: Total memory across all queues
+  -
+    name: tc-fq-qd-stats
+    type: struct
+    members:
+      -
+        name: gc-flows
+        type: u64
+      -
+        name: highprio-packets
+        type: u64
+        doc: obsolete
+      -
+        name: tcp-retrans
+        type: u64
+        doc: obsolete
+      -
+        name: throttled
+        type: u64
+      -
+        name: flows-plimit
+        type: u64
+      -
+        name: pkts-too-long
+        type: u64
+      -
+        name: allocation-errors
+        type: u64
+      -
+        name: time-next-delayed-flow
+        type: s64
+      -
+        name: flows
+        type: u32
+      -
+        name: inactive-flows
+        type: u32
+      -
+        name: throttled-flows
+        type: u32
+      -
+        name: unthrottle-latency-ns
+        type: u32
+      -
+        name: ce-mark
+        type: u64
+        doc: Packets above ce-threshold
+      -
+        name: horizon-drops
+        type: u64
+      -
+        name: horizon-caps
+        type: u64
+      -
+        name: fastpath-packets
+        type: u64
+      -
+        name: band-drops
+        type: binary
+        len: 24
+      -
+        name: band-pkt-count
+        type: binary
+        len: 12
+      -
+        name: pad
+        type: pad
+        len: 4
+  -
+    name: tc-hhf-xstats
+    type: struct
+    members:
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: hh-overlimit
+        type: u32
+        doc: Number of times max heavy-hitters was hit
+      -
+        name: hh-tot-count
+        type: u32
+        doc: Number of captured heavy-hitters so far
+      -
+        name: hh-cur-count
+        type: u32
+        doc: Number of current heavy-hitters
+  -
+    name: tc-pie-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u64
+        doc: Current probability
+      -
+        name: delay
+        type: u32
+        doc: Current delay in ms
+      -
+        name: avg-dq-rate
+        type: u32
+        doc: Current average dq rate in bits/pie-time
+      -
+        name: dq-rate-estimating
+        type: u32
+        doc: Is avg-dq-rate being calculated?
+      -
+        name: packets-in
+        type: u32
+        doc: Total number of packets enqueued
+      -
+        name: dropped
+        type: u32
+        doc: Packets dropped due to pie action
+      -
+        name: overlimit
+        type: u32
+        doc: Dropped due to lack of space in queue
+      -
+        name: maxq
+        type: u32
+        doc: Maximum queue size
+      -
+        name: ecn-mark
+        type: u32
+        doc: Packets marked with ecn
+  -
+    name: tc-red-xstats
+    type: struct
+    members:
+      -
+        name: early
+        type: u32
+        doc: Early drops
+      -
+        name: pdrop
+        type: u32
+        doc: Drops due to queue limits
+      -
+        name: other
+        type: u32
+        doc: Drops due to drop() calls
+      -
+        name: marked
+        type: u32
+        doc: Marked packets
+  -
+    name: tc-sfb-xstats
+    type: struct
+    members:
+      -
+        name: earlydrop
+        type: u32
+      -
+        name: penaltydrop
+        type: u32
+      -
+        name: bucketdrop
+        type: u32
+      -
+        name: queuedrop
+        type: u32
+      -
+        name: childdrop
+        type: u32
+        doc: drops in child qdisc
+      -
+        name: marked
+        type: u32
+      -
+        name: maxqlen
+        type: u32
+      -
+        name: maxprob
+        type: u32
+      -
+        name: avgprob
+        type: u32
+  -
+    name: tc-sfq-xstats
+    type: struct
+    members:
+      -
+        name: allot
+        type: s32
+  -
+    name: gnet-stats-basic
+    type: struct
+    members:
+      -
+        name: bytes
+        type: u64
+      -
+        name: packets
+        type: u32
+  -
+    name: gnet-stats-rate-est
+    type: struct
+    members:
+      -
+        name: bps
+        type: u32
+      -
+        name: pps
+        type: u32
+  -
+    name: gnet-stats-rate-est64
+    type: struct
+    members:
+      -
+        name: bps
+        type: u64
+      -
+        name: pps
+        type: u64
+  -
+    name: gnet-stats-queue
+    type: struct
+    members:
+      -
+        name: qlen
+        type: u32
+      -
+        name: backlog
+        type: u32
+      -
+        name: drops
+        type: u32
+      -
+        name: requeues
+        type: u32
+      -
+        name: overlimits
+        type: u32
+  -
+    name: tc-u32-key
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: val
+        type: u32
+        byte-order: big-endian
+      -
+        name: "off"
+        type: s32
+      -
+        name: offmask
+        type: s32
+  -
+    name: tc-u32-sel
+    type: struct
+    members:
+      -
+        name: flags
+        type: u8
+      -
+        name: offshift
+        type: u8
+      -
+        name: nkeys
+        type: u8
+      -
+        name: offmask
+        type: u16
+        byte-order: big-endian
+      -
+        name: "off"
+        type: u16
+      -
+        name: offoff
+        type: s16
+      -
+        name: hoff
+        type: s16
+      -
+        name: hmask
+        type: u32
+        byte-order: big-endian
+      -
+        name: keys
+        type: binary
+        struct: tc-u32-key # TODO: array
+  -
+    name: tc-u32-pcnt
+    type: struct
+    members:
+      -
+        name: rcnt
+        type: u64
+      -
+        name: rhit
+        type: u64
+      -
+        name: kcnts
+        type: u64 # TODO: array
+  -
+    name: tcf-t
+    type: struct
+    members:
+      -
+        name: install
+        type: u64
+      -
+        name: lastuse
+        type: u64
+      -
+        name: expires
+        type: u64
+      -
+        name: firstuse
+        type: u64
+  -
+    name: tc-gen
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+  -
+    name: tc-gact-p
+    type: struct
+    members:
+      -
+        name: ptype
+        type: u16
+      -
+        name: pval
+        type: u16
+      -
+        name: paction
+        type: s32
+  -
+    name: tcf-ematch-tree-hdr
+    type: struct
+    members:
+      -
+        name: nmatches
+        type: u16
+      -
+        name: progid
+        type: u16
+  -
+    name: tc-basic-pcnt
+    type: struct
+    members:
+      -
+        name: rcnt
+        type: u64
+      -
+        name: rhit
+        type: u64
+  -
+    name: tc-matchall-pcnt
+    type: struct
+    members:
+      -
+        name: rhit
+        type: u64
+  -
+    name: tc-mpls
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: m-action
+        type: s32
+  -
+    name: tc-police
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: limit
+        type: u32
+      -
+        name: burst
+        type: u32
+      -
+        name: mtu
+        type: u32
+      -
+        name: rate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: peakrate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: capab
+        type: u32
+  -
+    name: tc-pedit-sel
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: nkeys
+        type: u8
+      -
+        name: flags
+        type: u8
+      -
+        name: keys
+        type: binary
+        struct: tc-pedit-key # TODO: array
+  -
+    name: tc-pedit-key
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+      -
+        name: val
+        type: u32
+      -
+        name: "off"
+        type: u32
+      -
+        name: at
+        type: u32
+      -
+        name: offmask
+        type: u32
+      -
+        name: shift
+        type: u32
+  -
+    name: tc-vlan
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: v-action
+        type: s32
+attribute-sets:
+  -
+    name: tc-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: sub-message
+        sub-message: tc-options-msg
+        selector: kind
+      -
+        name: stats
+        type: binary
+        struct: tc-stats
+      -
+        name: xstats
+        type: sub-message
+        sub-message: tca-stats-app-msg
+        selector: kind
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
+    name: tc-act-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: sub-message
+        sub-message: tc-act-options-msg
+        selector: kind
+      -
+        name: index
+        type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: tc-act-stats-attrs
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
+    name: tc-act-stats-attrs
+    attributes:
+      -
+        name: basic
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: rate-est
+        type: binary
+        struct: gnet-stats-rate-est
+      -
+        name: queue
+        type: binary
+        struct: gnet-stats-queue
+      -
+        name: app
+        type: binary
+      -
+        name: rate-est64
+        type: binary
+        struct: gnet-stats-rate-est64
+      -
+        name: pad
+        type: pad
+      -
+        name: basic-hw
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: pkt64
+        type: u64
+  -
+    name: tc-act-bpf-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: ops-len
+        type: u16
+      -
+        name: ops
+        type: binary
+      -
+        name: fd
+        type: u32
+      -
+        name: name
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: tag
+        type: binary
+      -
+        name: id
+        type: binary
+  -
+    name: tc-act-connmark-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-csum-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-ct-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: action
+        type: u16
+      -
+        name: zone
+        type: u16
+      -
+        name: mark
+        type: u32
+      -
+        name: mark-mask
+        type: u32
+      -
+        name: labels
+        type: binary
+      -
+        name: labels-mask
+        type: binary
+      -
+        name: nat-ipv4-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-ipv4-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-ipv6-min
+        type: binary
+      -
+        name: nat-ipv6-max
+        type: binary
+      -
+        name: nat-port-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: nat-port-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: helper-name
+        type: string
+      -
+        name: helper-family
+        type: u8
+      -
+        name: helper-proto
+        type: u8
+  -
+    name: tc-act-ctinfo-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: act
+        type: binary
+      -
+        name: zone
+        type: u16
+      -
+        name: parms-dscp-mask
+        type: u32
+      -
+        name: parms-dscp-statemask
+        type: u32
+      -
+        name: parms-cpmark-mask
+        type: u32
+      -
+        name: stats-dscp-set
+        type: u64
+      -
+        name: stats-dscp-error
+        type: u64
+      -
+        name: stats-cpmark-set
+        type: u64
+  -
+    name: tc-act-gate-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: priority
+        type: s32
+      -
+        name: entry-list
+        type: binary
+      -
+        name: base-time
+        type: u64
+      -
+        name: cycle-time
+        type: u64
+      -
+        name: cycle-time-ext
+        type: u64
+      -
+        name: flags
+        type: u32
+      -
+        name: clockid
+        type: s32
+  -
+    name: tc-act-ife-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: dmac
+        type: binary
+      -
+        name: smac
+        type: binary
+      -
+        name: type
+        type: u16
+      -
+        name: metalst
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-mirred-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: blockid
+        type: binary
+  -
+    name: tc-act-mpls-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-mpls
+      -
+        name: pad
+        type: pad
+      -
+        name: proto
+        type: u16
+        byte-order: big-endian
+      -
+        name: label
+        type: u32
+      -
+        name: tc
+        type: u8
+      -
+        name: ttl
+        type: u8
+      -
+        name: bos
+        type: u8
+  -
+    name: tc-act-nat-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-pedit-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-pedit-sel
+      -
+        name: pad
+        type: pad
+      -
+        name: parms-ex
+        type: binary
+      -
+        name: keys-ex
+        type: binary
+      -
+        name: key-ex
+        type: binary
+  -
+    name: tc-act-simple-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: data
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-skbedit-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: priority
+        type: u32
+      -
+        name: queue-mapping
+        type: u16
+      -
+        name: mark
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: ptype
+        type: u16
+      -
+        name: mask
+        type: u32
+      -
+        name: flags
+        type: u64
+      -
+        name: queue-mapping-max
+        type: u16
+  -
+    name: tc-act-skbmod-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: dmac
+        type: binary
+      -
+        name: smac
+        type: binary
+      -
+        name: etype
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-tunnel-key-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: enc-ipv4-src
+        type: u32
+        byte-order: big-endian
+      -
+        name: enc-ipv4-dst
+        type: u32
+        byte-order: big-endian
+      -
+        name: enc-ipv6-src
+        type: binary
+      -
+        name: enc-ipv6-dst
+        type: binary
+      -
+        name: enc-key-id
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: enc-dst-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: no-csum
+        type: u8
+      -
+        name: enc-opts
+        type: binary
+      -
+        name: enc-tos
+        type: u8
+      -
+        name: enc-ttl
+        type: u8
+      -
+        name: no-frag
+        type: flag
+  -
+    name: tc-act-vlan-attrs
     attributes:
       -
-        name: kind
-        type: string
-      -
-        name: options
-        type: sub-message
-        sub-message: tc-options-msg
-        selector: kind
+        name: tm
+        type: binary
+        struct: tcf-t
       -
-        name: stats
+        name: parms
         type: binary
-        struct: tc-stats
+        struct: tc-vlan
       -
-        name: xstats
+        name: push-vlan-id
+        type: u16
+      -
+        name: push-vlan-protocol
+        type: u16
+      -
+        name: pad
+        type: pad
+      -
+        name: push-vlan-priority
+        type: u8
+      -
+        name: push-eth-dst
         type: binary
       -
-        name: rate
+        name: push-eth-src
         type: binary
-        struct: gnet-estimator
+  -
+    name: tc-basic-attrs
+    attributes:
       -
-        name: fcnt
+        name: classid
         type: u32
       -
-        name: stats2
+        name: ematches
         type: nest
-        nested-attributes: tca-stats-attrs
+        nested-attributes: tc-ematch-attrs
       -
-        name: stab
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
+      -
+        name: police
         type: nest
-        nested-attributes: tca-stab-attrs
+        nested-attributes: tc-police-attrs
+      -
+        name: pcnt
+        type: binary
+        struct: tc-basic-pcnt
       -
         name: pad
         type: pad
+  -
+    name: tc-bpf-attrs
+    attributes:
       -
-        name: dump-invisible
-        type: flag
+        name: act
+        type: nest
+        nested-attributes: tc-act-attrs
       -
-        name: chain
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: classid
         type: u32
       -
-        name: hw-offload
-        type: u8
+        name: ops-len
+        type: u16
       -
-        name: ingress-block
+        name: ops
+        type: binary
+      -
+        name: fd
         type: u32
       -
-        name: egress-block
+        name: name
+        type: string
+      -
+        name: flags
         type: u32
       -
-        name: dump-flags
-        type: bitfield32
+        name: flags-gen
+        type: u32
       -
-        name: ext-warn-msg
-        type: string
+        name: tag
+        type: binary
+      -
+        name: id
+        type: u32
   -
     name: tc-cake-attrs
     attributes:
@@ -641,7 +2077,8 @@ attribute-sets:
         type: u32
       -
         name: tin-stats
-        type: binary
+        type: array-nest
+        nested-attributes: tc-cake-tin-stats-attrs
       -
         name: deficit
         type: s32
@@ -660,6 +2097,84 @@ attribute-sets:
       -
         name: blue-timer-us
         type: s32
+  -
+    name: tc-cake-tin-stats-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: sent-packets
+        type: u32
+      -
+        name: sent-bytes64
+        type: u64
+      -
+        name: dropped-packets
+        type: u32
+      -
+        name: dropped-bytes64
+        type: u64
+      -
+        name: acks-dropped-packets
+        type: u32
+      -
+        name: acks-dropped-bytes64
+        type: u64
+      -
+        name: ecn-marked-packets
+        type: u32
+      -
+        name: ecn-marked-bytes64
+        type: u64
+      -
+        name: backlog-packets
+        type: u32
+      -
+        name: backlog-bytes
+        type: u32
+      -
+        name: threshold-rate64
+        type: u64
+      -
+        name: target-us
+        type: u32
+      -
+        name: interval-us
+        type: u32
+      -
+        name: way-indirect-hits
+        type: u32
+      -
+        name: way-misses
+        type: u32
+      -
+        name: way-collisions
+        type: u32
+      -
+        name: peak-delay-us
+        type: u32
+      -
+        name: avg-delay-us
+        type: u32
+      -
+        name: base-delay-us
+        type: u32
+      -
+        name: sparse-flows
+        type: u32
+      -
+        name: bulk-flows
+        type: u32
+      -
+        name: unresponsive-flows
+        type: u32
+      -
+        name: max-skblen
+        type: u32
+      -
+        name: flow-quantum
+        type: u32
   -
     name: tc-cbs-attrs
     attributes:
@@ -667,6 +2182,20 @@ attribute-sets:
         name: parms
         type: binary
         struct: tc-cbs-qopt
+  -
+    name: tc-cgroup-attrs
+    attributes:
+      -
+        name: act
+        type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: ematches
+        type: binary
   -
     name: tc-choke-attrs
     attributes:
@@ -677,6 +2206,9 @@ attribute-sets:
       -
         name: stab
         type: binary
+        checks:
+          min-len: 256
+          max-len: 256
       -
         name: max-p
         type: u32
@@ -704,6 +2236,56 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-ematch-attrs
+    attributes:
+      -
+        name: tree-hdr
+        type: binary
+        struct: tcf-ematch-tree-hdr
+      -
+        name: tree-list
+        type: binary
+  -
+    name: tc-flow-attrs
+    attributes:
+      -
+        name: keys
+        type: u32
+      -
+        name: mode
+        type: u32
+      -
+        name: baseclass
+        type: u32
+      -
+        name: rshift
+        type: u32
+      -
+        name: addend
+        type: u32
+      -
+        name: mask
+        type: u32
+      -
+        name: xor
+        type: u32
+      -
+        name: divisor
+        type: u32
+      -
+        name: act
+        type: binary
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: ematches
+        type: binary
+      -
+        name: perturb
+        type: u32
   -
     name: tc-flower-attrs
     attributes:
@@ -953,15 +2535,19 @@ attribute-sets:
       -
         name: key-arp-sha
         type: binary
+        display-hint: mac
       -
         name: key-arp-sha-mask
         type: binary
+        display-hint: mac
       -
         name: key-arp-tha
         type: binary
+        display-hint: mac
       -
         name: key-arp-tha-mask
         type: binary
+        display-hint: mac
       -
         name: key-mpls-ttl
         type: u8
@@ -1020,10 +2606,12 @@ attribute-sets:
         type: u8
       -
         name: key-enc-opts
-        type: binary
+        type: nest
+        nested-attributes: tc-flower-key-enc-opts-attrs
       -
         name: key-enc-opts-mask
-        type: binary
+        type: nest
+        nested-attributes: tc-flower-key-enc-opts-attrs
       -
         name: in-hw-count
         type: u32
@@ -1056,41 +2644,165 @@ attribute-sets:
         name: key-ct-zone-mask
         type: u16
       -
-        name: key-ct-mark
-        type: u32
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
+        type: nest
+        nested-attributes: tc-flower-key-mpls-opt-attrs
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
+      -
+        name: l2-miss
+        type: u8
+      -
+        name: key-cfm
+        type: nest
+        nested-attributes: tc-flower-key-cfm-attrs
+      -
+        name: key-spi
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-spi-mask
+        type: u32
+        byte-order: big-endian
+  -
+    name: tc-flower-key-enc-opts-attrs
+    attributes:
+      -
+        name: geneve
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-geneve-attrs
+      -
+        name: vxlan
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-vxlan-attrs
+      -
+        name: erspan
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-erspan-attrs
+      -
+        name: gtp
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-gtp-attrs
+  -
+    name: tc-flower-key-enc-opt-geneve-attrs
+    attributes:
+      -
+        name: class
+        type: u16
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+  -
+    name: tc-flower-key-enc-opt-vxlan-attrs
+    attributes:
+      -
+        name: gbp
+        type: u32
+  -
+    name: tc-flower-key-enc-opt-erspan-attrs
+    attributes:
+      -
+        name: ver
+        type: u8
+      -
+        name: index
+        type: u32
+      -
+        name: dir
+        type: u8
+      -
+        name: hwid
+        type: u8
+  -
+    name: tc-flower-key-enc-opt-gtp-attrs
+    attributes:
+      -
+        name: pdu-type
+        type: u8
       -
-        name: key-ct-mark-mask
-        type: u32
+        name: qfi
+        type: u8
+  -
+    name: tc-flower-key-mpls-opt-attrs
+    attributes:
       -
-        name: key-ct-labels
-        type: binary
+        name: lse-depth
+        type: u8
       -
-        name: key-ct-labels-mask
-        type: binary
+        name: lse-ttl
+        type: u8
       -
-        name: key-mpls-opts
-        type: binary
+        name: lse-bos
+        type: u8
       -
-        name: key-hash
-        type: u32
+        name: lse-tc
+        type: u8
       -
-        name: key-hash-mask
+        name: lse-label
         type: u32
+  -
+    name: tc-flower-key-cfm-attrs
+    attributes:
       -
-        name: key-num-of-vlans
+        name: md-level
         type: u8
       -
-        name: key-pppoe-sid
-        type: u16
-        byte-order: big-endian
+        name: opcode
+        type: u8
+  -
+    name: tc-fw-attrs
+    attributes:
       -
-        name: key-ppp-proto
-        type: u16
-        byte-order: big-endian
+        name: classid
+        type: u32
       -
-        name: key-l2-tpv3-sid
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: indev
+        type: string
+      -
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
+      -
+        name: mask
         type: u32
-        byte-order: big-endian
   -
     name: tc-gred-attrs
     attributes:
@@ -1135,7 +2847,7 @@ attribute-sets:
         type: u32
       -
         name: stat-bytes
-        type: u32
+        type: u64
       -
         name: stat-packets
         type: u32
@@ -1232,40 +2944,25 @@ attribute-sets:
         name: offload
         type: flag
   -
-    name: tc-act-attrs
+    name: tc-matchall-attrs
     attributes:
       -
-        name: kind
-        type: string
+        name: classid
+        type: u32
       -
-        name: options
-        type: sub-message
-        sub-message: tc-act-options-msg
-        selector: kind
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
       -
-        name: index
+        name: flags
         type: u32
       -
-        name: stats
+        name: pcnt
         type: binary
+        struct: tc-matchall-pcnt
       -
         name: pad
         type: pad
-      -
-        name: cookie
-        type: binary
-      -
-        name: flags
-        type: bitfield32
-      -
-        name: hw-stats
-        type: bitfield32
-      -
-        name: used-hw-stats
-        type: bitfield32
-      -
-        name: in-hw-count
-        type: u32
   -
     name: tc-etf-attrs
     attributes:
@@ -1304,48 +3001,71 @@ attribute-sets:
       -
         name: plimit
         type: u32
+        doc: Limit of total number of packets in queue
       -
         name: flow-plimit
         type: u32
+        doc: Limit of packets per flow
       -
         name: quantum
         type: u32
+        doc: RR quantum
       -
         name: initial-quantum
         type: u32
+        doc: RR quantum for new flow
       -
         name: rate-enable
         type: u32
+        doc: Enable / disable rate limiting
       -
         name: flow-default-rate
         type: u32
+        doc: Obsolete, do not use
       -
         name: flow-max-rate
         type: u32
+        doc: Per flow max rate
       -
         name: buckets-log
         type: u32
+        doc: log2(number of buckets)
       -
         name: flow-refill-delay
         type: u32
+        doc: Flow credit refill delay in usec
       -
         name: orphan-mask
         type: u32
+        doc: Mask applied to orphaned skb hashes
       -
         name: low-rate-threshold
         type: u32
+        doc: Per packet delay under this rate
       -
         name: ce-threshold
         type: u32
+        doc: DCTCP-like CE marking threshold
       -
         name: timer-slack
         type: u32
       -
         name: horizon
         type: u32
+        doc: Time horizon in usec
       -
         name: horizon-drop
         type: u8
+        doc: Drop packets beyond horizon, or cap their EDT
+      -
+        name: priomap
+        type: binary
+        struct: tc-prio-qopt
+      -
+        name: weights
+        type: binary
+        sub-type: s32
+        doc: Weights for each band
   -
     name: tc-fq-codel-attrs
     attributes:
@@ -1427,6 +3147,7 @@ attribute-sets:
       -
         name: corr
         type: binary
+        struct: tc-netem-corr
       -
         name: delay-dist
         type: binary
@@ -1434,15 +3155,19 @@ attribute-sets:
       -
         name: reorder
         type: binary
+        struct: tc-netem-reorder
       -
         name: corrupt
         type: binary
+        struct: tc-netem-corrupt
       -
         name: loss
-        type: binary
+        type: nest
+        nested-attributes: tc-netem-loss-attrs
       -
         name: rate
         type: binary
+        struct: tc-netem-rate
       -
         name: ecn
         type: u32
@@ -1461,10 +3186,27 @@ attribute-sets:
       -
         name: slot
         type: binary
+        struct: tc-netem-slot
       -
         name: slot-dist
         type: binary
         sub-type: s16
+      -
+        name: prng-seed
+        type: u64
+  -
+    name: tc-netem-loss-attrs
+    attributes:
+      -
+        name: gi
+        type: binary
+        doc: General Intuitive - 4 state model
+        struct: tc-netem-gimodel
+      -
+        name: ge
+        type: binary
+        doc: Gilbert Elliot models
+        struct: tc-netem-gemodel
   -
     name: tc-pie-attrs
     attributes:
@@ -1492,6 +3234,44 @@ attribute-sets:
       -
         name: dq-rate-estimator
         type: u32
+  -
+    name: tc-police-attrs
+    attributes:
+      -
+        name: tbf
+        type: binary
+        struct: tc-police
+      -
+        name: rate
+        type: binary
+      -
+        name: peakrate
+        type: binary
+      -
+        name: avrate
+        type: u32
+      -
+        name: result
+        type: u32
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+      -
+        name: rate64
+        type: u64
+      -
+        name: peakrate64
+        type: u64
+      -
+        name: pktrate64
+        type: u64
+      -
+        name: pktburst64
+        type: u64
   -
     name: tc-qfq-attrs
     attributes:
@@ -1516,13 +3296,36 @@ attribute-sets:
         type: u32
       -
         name: flags
-        type: binary
+        type: bitfield32
       -
         name: early-drop-block
         type: u32
       -
         name: mark-block
         type: u32
+  -
+    name: tc-route-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: to
+        type: u32
+      -
+        name: from
+        type: u32
+      -
+        name: iif
+        type: u32
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
   -
     name: tc-taprio-attrs
     attributes:
@@ -1629,17 +3432,43 @@ attribute-sets:
         name: pad
         type: pad
   -
-    name: tca-gact-attrs
+    name: tc-act-sample-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-gen
+      -
+        name: rate
+        type: u32
+      -
+        name: trunc-size
+        type: u32
+      -
+        name: psample-group
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-gact-attrs
     attributes:
       -
         name: tm
         type: binary
+        struct: tcf-t
       -
         name: parms
         type: binary
+        struct: tc-gen
       -
         name: prob
         type: binary
+        struct: tc-gact-p
       -
         name: pad
         type: pad
@@ -1659,34 +3488,89 @@ attribute-sets:
       -
         name: basic
         type: binary
+        struct: gnet-stats-basic
       -
         name: rate-est
         type: binary
+        struct: gnet-stats-rate-est
       -
         name: queue
         type: binary
+        struct: gnet-stats-queue
       -
         name: app
-        type: binary # TODO sub-message needs 2+ level deep lookup
+        type: sub-message
         sub-message: tca-stats-app-msg
         selector: kind
       -
         name: rate-est64
         type: binary
+        struct: gnet-stats-rate-est64
       -
         name: pad
         type: pad
       -
         name: basic-hw
         type: binary
+        struct: gnet-stats-basic
       -
         name: pkt64
+        type: u64
+  -
+    name: tc-u32-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: hash
+        type: u32
+      -
+        name: link
+        type: u32
+      -
+        name: divisor
+        type: u32
+      -
+        name: sel
+        type: binary
+        struct: tc-u32-sel
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: act
+        type: array-nest
+        nested-attributes: tc-act-attrs
+      -
+        name: indev
+        type: string
+      -
+        name: pcnt
+        type: binary
+        struct: tc-u32-pcnt
+      -
+        name: mark
         type: binary
+        struct: tc-u32-mark
+      -
+        name: flags
+        type: u32
+      -
+        name: pad
+        type: pad
 
 sub-messages:
   -
     name: tc-options-msg
     formats:
+      -
+        value: basic
+        attribute-set: tc-basic-attrs
+      -
+        value: bpf
+        attribute-set: tc-bpf-attrs
       -
         value: bfifo
         fixed-header: tc-fifo-qopt
@@ -1696,6 +3580,9 @@ sub-messages:
       -
         value: cbs
         attribute-set: tc-cbs-attrs
+      -
+        value: cgroup
+        attribute-set: tc-cgroup-attrs
       -
         value: choke
         attribute-set: tc-choke-attrs
@@ -1713,6 +3600,12 @@ sub-messages:
       -
         value: ets
         attribute-set: tc-ets-attrs
+      -
+        value: flow
+        attribute-set: tc-flow-attrs
+      -
+        value: flower
+        attribute-set: tc-flower-attrs
       -
         value: fq
         attribute-set: tc-fq-attrs
@@ -1723,8 +3616,8 @@ sub-messages:
         value: fq_pie
         attribute-set: tc-fq-pie-attrs
       -
-        value: flower
-        attribute-set: tc-flower-attrs
+        value: fw
+        attribute-set: tc-fw-attrs
       -
         value: gred
         attribute-set: tc-gred-attrs
@@ -1739,6 +3632,9 @@ sub-messages:
         attribute-set: tc-htb-attrs
       -
         value: ingress # no content
+      -
+        value: matchall
+        attribute-set: tc-matchall-attrs
       -
         value: mq # no content
       -
@@ -1775,6 +3671,9 @@ sub-messages:
       -
         value: red
         attribute-set: tc-red-attrs
+      -
+        value: route
+        attribute-set: tc-route-attrs
       -
         value: sfb
         fixed-header: tc-sfb-qopt
@@ -1787,88 +3686,105 @@ sub-messages:
       -
         value: tbf
         attribute-set: tc-tbf-attrs
-  -
-    name: tc-act-options-msg
-    formats:
       -
-        value: gact
-        attribute-set: tca-gact-attrs
+        value: u32
+        attribute-set: tc-u32-attrs
   -
-    name: tca-stats-app-msg
+    name: tc-act-options-msg
     formats:
       -
-        value: bfifo
-      -
-        value: blackhole
+        value: bpf
+        attribute-set: tc-act-bpf-attrs
       -
-        value: cake
-        attribute-set: tc-cake-stats-attrs
+        value: connmark
+        attribute-set: tc-act-connmark-attrs
       -
-        value: cbs
+        value: csum
+        attribute-set: tc-act-csum-attrs
       -
-        value: choke
+        value: ct
+        attribute-set: tc-act-ct-attrs
       -
-        value: clsact
+        value: ctinfo
+        attribute-set: tc-act-ctinfo-attrs
       -
-        value: codel
+        value: gact
+        attribute-set: tc-act-gact-attrs
       -
-        value: drr
+        value: gate
+        attribute-set: tc-act-gate-attrs
       -
-        value: etf
+        value: ife
+        attribute-set: tc-act-ife-attrs
       -
-        value: ets
+        value: mirred
+        attribute-set: tc-act-mirred-attrs
       -
-        value: fq
+        value: mpls
+        attribute-set: tc-act-mpls-attrs
       -
-        value: fq_codel
+        value: nat
+        attribute-set: tc-act-nat-attrs
       -
-        value: fq_pie
+        value: pedit
+        attribute-set: tc-act-pedit-attrs
       -
-        value: flower
+        value: police
+        attribute-set: tc-act-police-attrs
       -
-        value: gred
+        value: sample
+        attribute-set: tc-act-sample-attrs
       -
-        value: hfsc
+        value: simple
+        attribute-set: tc-act-simple-attrs
       -
-        value: hhf
+        value: skbedit
+        attribute-set: tc-act-skbedit-attrs
       -
-        value: htb
+        value: skbmod
+        attribute-set: tc-act-skbmod-attrs
       -
-        value: ingress
+        value: tunnel_key
+        attribute-set: tc-act-tunnel-key-attrs
       -
-        value: mq
+        value: vlan
+        attribute-set: tc-act-vlan-attrs
+  -
+    name: tca-stats-app-msg
+    formats:
       -
-        value: mqprio
+        value: cake
+        attribute-set: tc-cake-stats-attrs
       -
-        value: multiq
+        value: choke
+        fixed-header: tc-choke-xstats
       -
-        value: netem
+        value: codel
+        fixed-header: tc-codel-xstats
       -
-        value: noqueue
+        value: fq
+        fixed-header: tc-fq-qd-stats
       -
-        value: pfifo
+        value: fq_codel
+        fixed-header: tc-fq-codel-xstats
       -
-        value: pfifo_fast
+        value: fq_pie
+        fixed-header: tc-fq-pie-xstats
       -
-        value: pfifo_head_drop
+        value: hhf
+        fixed-header: tc-hhf-xstats
       -
         value: pie
-      -
-        value: plug
-      -
-        value: prio
-      -
-        value: qfq
+        fixed-header: tc-pie-xstats
       -
         value: red
+        fixed-header: tc-red-xstats
       -
         value: sfb
+        fixed-header: tc-sfb-xstats
       -
         value: sfq
-      -
-        value: taprio
-      -
-        value: tbf
+        fixed-header: tc-sfq-xstats
 
 operations:
   enum-model: directional
-- 
2.42.0


