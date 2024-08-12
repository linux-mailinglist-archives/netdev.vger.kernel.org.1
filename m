Return-Path: <netdev+bounces-117575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675394E5DC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ECD28203B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237542A87;
	Mon, 12 Aug 2024 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaN4YckP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B614A0B8
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437906; cv=none; b=oikoDGsZxsrMTFLfLkBJPdtIt4MB/ul1KvEB/TJRah/a5BucKD2Wm0upxd3MVO8gq7GB2fQ1SlZsgmAB7H3d0fMDOJWFOFaBO22GnV+2aEBrtbtt6Xh4b01rqgwgRQCs4EzoqNrdWqhBCSNgcozIO8S3EyvLabjCgMXgwxHPdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437906; c=relaxed/simple;
	bh=vUt4Z9hWvBr7DohE6HKyNrSohurmZ1LSl7Sb1LKtHKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIjPmYt+hrG2dwW8eZiOCdWIRugizU7jZhPSvgLScu9mDDaPsvAH6ZP/S4hmCeIt0HQ7qZf1uzJ4dC6PbaCblvxsWS7fWvjMznBgwVZRd8bopeNyjkvYNMOVD6zJegF/qJ0bzE/gCZTUR+uH78Hwa+H8iPjutwVZA9obXSEY1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaN4YckP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc692abba4so33159625ad.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723437902; x=1724042702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqOqVgnmxsvFc3YwjpXTNcZ8Ylba9/QFLWqnXzUi4Q8=;
        b=VaN4YckPgYgr2mPTA8EYxxe6dJrH6FgnInp/dvwAzWsnUHXkVtx41WIrEZPv1W01gm
         ErD/GgONtIfnfKFwswsTuhdXJaAvIftgcvntmTv3lURUwqSHk+hkRY6XyPs99ds9vcP3
         ADKoGulpj+RpquGZFSYMhjoWxEon96mEwSbwwMy6JR0bS6cPDRDLpmg8YUeO6IjHNaDv
         QUY3mJsvHiTgvlrrV7+1LyqWQsHPRupcs2WIlml+nN/VftUKVcoejCq3azVzIqX/EbJV
         cDz1H72GnD/Ak/QiXkapsqIdQe5ODMZWM/m7N/wsSc18BHoa9bqBlxFqvEEWg4p+CuWE
         i9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723437902; x=1724042702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqOqVgnmxsvFc3YwjpXTNcZ8Ylba9/QFLWqnXzUi4Q8=;
        b=twTLQfXTtkq0+w2MbBrNDsjl9w8aLpNO0qVI62St4IT7PDW4mlWpyLasrZ8NxPpRH5
         W0R5NgY2iJGVZPaNHPIJkkYBmOrO+LPNVCurQDynNxEP05V2wb++q4+SNruzQqNgidPX
         muPq44Eha9jxo9fLPaud2xgy6UaHhQg7gywI76eZ5xEfYv5ZzVUcRXRWFlasFrYNuvxr
         +zcBOnyF783RDFxxprvXzSKyWrTzk0LJ7qupt0Q/CpqB/usi2iNpWvpozGOkVTf11i13
         F+TG1zR5HH4VjZr1Lh4hd8ZjyEwa8wo6sO9CQEHnqvQZLKeaUvs8mwClkpMtxzQM+2w9
         HVxA==
X-Gm-Message-State: AOJu0Yw7ufppr8gbR0H63kn5KSWdmCvPCateKx7+9iHRo67/2zJ0bf95
	s7BA+kJPTikcbc47EWZfdDvPbaD0s4abU8Pd2CVcaBNrHNzUFuBm
X-Google-Smtp-Source: AGHT+IGoycxX5OLkReU5uodhHPk0b0y7UlIQ9Rejj7BTFVO2PAigusEm03kzprL0OQ7wcouQoqsv5w==
X-Received: by 2002:a17:902:e892:b0:1fa:fc24:afa5 with SMTP id d9443c01a7336-200ae4f989amr88341135ad.27.1723437902306;
        Sun, 11 Aug 2024 21:45:02 -0700 (PDT)
Received: from laptop.. ([2405:4802:1f31:4f80:d239:57ff:fee4:71e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3ffd2sm29086555ad.262.2024.08.11.21.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:45:01 -0700 (PDT)
From: =?UTF-8?q?L=C6=B0=C6=A1ng=20Vi=E1=BB=87t=20Ho=C3=A0ng?= <tcm4095@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?L=C6=B0=C6=A1ng=20Vi=E1=BB=87t=20Ho=C3=A0ng?= <tcm4095@gmail.com>
Subject: [PATCH iproute2 v2 2/2] tc-cake: reformat
Date: Mon, 12 Aug 2024 11:41:38 +0700
Message-ID: <20240812044234.3570-2-tcm4095@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812044234.3570-1-tcm4095@gmail.com>
References: <20240812044234.3570-1-tcm4095@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reformat tc-cake to use man format (nroff) instead of pre-formatting.

Signed-off-by: Lương Việt Hoàng <tcm4095@gmail.com>
---
 man/man8/tc-cake.8 | 415 +++++++++++++++++++++++++--------------------
 1 file changed, 230 insertions(+), 185 deletions(-)

diff --git a/man/man8/tc-cake.8 b/man/man8/tc-cake.8
index 6d77d7d2..47f8f985 100644
--- a/man/man8/tc-cake.8
+++ b/man/man8/tc-cake.8
@@ -146,22 +146,23 @@ CAKE uses a deficit-mode shaper, which does not exhibit the initial burst
 typical of token-bucket shapers.  It will automatically burst precisely as much
 as required to maintain the configured throughput.  As such, it is very
 straightforward to configure.
-.PP
-.B unlimited
-(default)
+
+.TP
+\fBunlimited\fR (default)
 .br
-	No limit on the bandwidth.
-.PP
-.B bandwidth
-RATE
+No limit on the bandwidth.
+
+.TP
+\fBbandwidth\fR RATE
 .br
-	Set the shaper bandwidth.  See
+Set the shaper bandwidth.  See
 .BR tc(8)
 or examples below for details of the RATE value.
-.PP
+
+.TP
 .B autorate-ingress
 .br
-	Automatic capacity estimation based on traffic arriving at this qdisc.
+Automatic capacity estimation based on traffic arriving at this qdisc.
 This is most likely to be useful with cellular links, which tend to change
 quality randomly.  A
 .B bandwidth
@@ -177,58 +178,61 @@ are not expert network engineers, keywords have been provided to represent a
 number of common link technologies.
 
 .SS	Manual Overhead Specification
-.B overhead
-BYTES
+.TP
+\fBoverhead\fR BYTES
 .br
-	Adds BYTES to the size of each packet.  BYTES may be negative; values
+Adds BYTES to the size of each packet.  BYTES may be negative; values
 between -64 and 256 (inclusive) are accepted.
-.PP
-.B mpu
-BYTES
+
+.TP
+\fBmpu\fR BYTES
 .br
-	Rounds each packet (including overhead) up to a minimum length
+Rounds each packet (including overhead) up to a minimum length
 BYTES. BYTES may not be negative; values between 0 and 256 (inclusive)
 are accepted.
-.PP
+
+.TP
 .B atm
 .br
-	Compensates for ATM cell framing, which is normally found on ADSL links.
+Compensates for ATM cell framing, which is normally found on ADSL links.
 This is performed after the
 .B overhead
 parameter above.  ATM uses fixed 53-byte cells, each of which can carry 48 bytes
 payload.
-.PP
+
+.TP
 .B ptm
 .br
-	Compensates for PTM encoding, which is normally found on VDSL2 links and
+Compensates for PTM encoding, which is normally found on VDSL2 links and
 uses a 64b/65b encoding scheme. It is even more efficient to simply
 derate the specified shaper bandwidth by a factor of 64/65 or 0.984. See
 ITU G.992.3 Annex N and IEEE 802.3 Section 61.3 for details.
-.PP
+
+.TP
 .B noatm
 .br
-	Disables ATM and PTM compensation.
+Disables ATM and PTM compensation.
 
-.SS	Failsafe Overhead Keywords
+.SS Failsafe Overhead Keywords
 These two keywords are provided for quick-and-dirty setup.  Use them if you
 can't be bothered to read the rest of this section.
-.PP
-.B raw
-(default)
+
+.TP
+\fBraw\fR (default)
 .br
-	Turns off all overhead compensation in CAKE.  The packet size reported
+Turns off all overhead compensation in CAKE.  The packet size reported
 by Linux will be used directly.
-.PP
-	Other overhead keywords may be added after "raw".  The effect of this is
+
+Other overhead keywords may be added after "raw".  The effect of this is
 to make the overhead compensation operate relative to the reported packet size,
 not the underlying IP packet size.
-.PP
+
+.TP
 .B conservative
 .br
-	Compensates for more overhead than is likely to occur on any
+Compensates for more overhead than is likely to occur on any
 widely-deployed link technology.
-.br
-	Equivalent to
+Equivalent to
 .B overhead 48 atm.
 
 .SS ADSL Overhead Keywords
@@ -238,77 +242,86 @@ this section are intended to correspond with these sources of information.  All
 of them implicitly set the
 .B atm
 flag.
-.PP
+
+.TP
 .B pppoa-vcmux
 .br
-	Equivalent to
+Equivalent to
 .B overhead 10 atm
-.PP
+
+.TP
 .B pppoa-llc
 .br
-	Equivalent to
+Equivalent to
 .B overhead 14 atm
-.PP
+
+.TP
 .B pppoe-vcmux
 .br
-	Equivalent to
+Equivalent to
 .B overhead 32 atm
-.PP
+
+.TP
 .B pppoe-llcsnap
 .br
-	Equivalent to
+Equivalent to
 .B overhead 40 atm
-.PP
+
+.TP
 .B bridged-vcmux
 .br
-	Equivalent to
+Equivalent to
 .B overhead 24 atm
-.PP
+
+.TP
 .B bridged-llcsnap
 .br
-	Equivalent to
+Equivalent to
 .B overhead 32 atm
-.PP
+
+.TP
 .B ipoa-vcmux
 .br
-	Equivalent to
+Equivalent to
 .B overhead 8 atm
-.PP
+
+.TP
 .B ipoa-llcsnap
 .br
-	Equivalent to
+Equivalent to
 .B overhead 16 atm
-.PP
+
+.P
 See also the Ethernet Correction Factors section below.
 
 .SS VDSL2 Overhead Keywords
 ATM was dropped from VDSL2 in favour of PTM, which is a much more
 straightforward framing scheme.  Some ISPs retained PPPoE for compatibility with
 their existing back-end systems.
-.PP
+
+.TP
 .B pppoe-ptm
 .br
-	Equivalent to
+Equivalent to
 .B overhead 30 ptm
 
+PPPoE: 2B PPP + 6B PPPoE +
 .br
-	PPPoE: 2B PPP + 6B PPPoE +
-.br
-	ETHERNET: 6B dest MAC + 6B src MAC + 2B ethertype + 4B Frame Check Sequence +
-.br
-	PTM: 1B Start of Frame (S) + 1B End of Frame (Ck) + 2B TC-CRC (PTM-FCS)
+ETHERNET: 6B dest MAC + 6B src MAC + 2B ethertype + 4B Frame Check Sequence +
 .br
-.PP
+PTM: 1B Start of Frame (S) + 1B End of Frame (Ck) + 2B TC-CRC (PTM-FCS)
+
+.TP
 .B bridged-ptm
 .br
-	Equivalent to
+Equivalent to
 .B overhead 22 ptm
+
+ETHERNET: 6B dest MAC + 6B src MAC + 2B ethertype + 4B Frame Check Sequence +
 .br
-	ETHERNET: 6B dest MAC + 6B src MAC + 2B ethertype + 4B Frame Check Sequence +
-.br
-	PTM: 1B Start of Frame (S) + 1B End of Frame (Ck) + 2B TC-CRC (PTM-FCS)
-.br
-.PP
+PTM: 1B Start of Frame (S) + 1B End of Frame (Ck) + 2B TC-CRC (PTM-FCS)
+
+.P
 See also the Ethernet Correction Factors section below.
 
 .SS DOCSIS Cable Overhead Keyword
@@ -318,26 +331,28 @@ infrastructure.
 In this case, the actual on-wire overhead is less important than the packet size
 the head-end equipment uses for shaping and metering.  This is specified to be
 an Ethernet frame including the CRC (aka FCS).
-.PP
+
+.TP
 .B docsis
 .br
-	Equivalent to
+Equivalent to
 .B overhead 18 mpu 64 noatm
 
 .SS Ethernet Overhead Keywords
-.PP
+
+.TP
 .B ethernet
 .br
-	Accounts for Ethernet's preamble, inter-frame gap, and Frame Check
+Accounts for Ethernet's preamble, inter-frame gap, and Frame Check
 Sequence.  Use this keyword when the bottleneck being shaped for is an
 actual Ethernet cable.
-.br
-	Equivalent to
+Equivalent to
 .B overhead 38 mpu 84 noatm
-.PP
+
+.TP
 .B ether-vlan
 .br
-	Adds 4 bytes to the overhead compensation, accounting for an IEEE 802.1Q
+Adds 4 bytes to the overhead compensation, accounting for an IEEE 802.1Q
 VLAN header appended to the Ethernet frame header.  NB: Some ISPs use one or
 even two of these within PPPoE; this keyword may be repeated as necessary to
 express this.
@@ -360,54 +375,77 @@ the jitter in the Linux kernel itself, so congestion might be signalled
 prematurely. The flows will then become sparse and total throughput reduced,
 leaving little or no back-pressure for the fairness logic to work against. Use
 the "metro" setting for local lans unless you have a custom kernel.
-.PP
-.B rtt
-TIME
+
+.TP
+\fBrtt\fR TIME
 .br
-	Manually specify an RTT.
-.PP
+Manually specify an RTT.
+
+.TP
 .B datacentre
 .br
-	For extremely high-performance 10GigE+ networks only.  Equivalent to
+For extremely high-performance 10GigE+ networks only.
+.br
+Equivalent to
 .B rtt 100us.
-.PP
+
+.TP
 .B lan
 .br
-	For pure Ethernet (not Wi-Fi) networks, at home or in the office.  Don't
-use this when shaping for an Internet access link.  Equivalent to
+For pure Ethernet (not Wi-Fi) networks, at home or in the office.  Don't
+use this when shaping for an Internet access link.
+.br
+Equivalent to
 .B rtt 1ms.
-.PP
+
+.TP
 .B metro
 .br
-	For traffic mostly within a single city.  Equivalent to
+For traffic mostly within a single city.
+.br
+Equivalent to
 .B rtt 10ms.
-.PP
+
+.TP
 .B regional
 .br
-	For traffic mostly within a European-sized country.  Equivalent to
+For traffic mostly within a European-sized country.
+.br
+Equivalent to
 .B rtt 30ms.
-.PP
-.B internet
-(default)
+
+.TP
+\fBinternet\fR (default)
+.br
+This is suitable for most Internet traffic.
 .br
-	This is suitable for most Internet traffic.  Equivalent to
+Equivalent to
 .B rtt 100ms.
-.PP
+
+.TP
 .B oceanic
 .br
-	For Internet traffic with generally above-average latency, such as that
-suffered by Australasian residents.  Equivalent to
+For Internet traffic with generally above-average latency, such as that
+suffered by Australasian residents.
+.br
+Equivalent to
 .B rtt 300ms.
-.PP
+
+.TP
 .B satellite
 .br
-	For traffic via geostationary satellites.  Equivalent to
+For traffic via geostationary satellites.
+.br
+Equivalent to
 .B rtt 1000ms.
-.PP
+
+.TP
 .B interplanetary
 .br
-	So named because Jupiter is about 1 light-hour from Earth.  Use this to
-(almost) completely disable AQM actions.  Equivalent to
+So named because Jupiter is about 1 light-hour from Earth.  Use this to
+(almost) completely disable AQM actions.
+.br
+Equivalent to
 .B rtt 3600s.
 
 .SH FLOW ISOLATION PARAMETERS
@@ -419,68 +457,76 @@ minimize flow collisions.
 
 These keywords specify whether fairness based on source address, destination
 address, individual flows, or any combination of those is desired.
-.PP
+
+.TP
 .B flowblind
 .br
-	Disables flow isolation; all traffic passes through a single queue for
+Disables flow isolation; all traffic passes through a single queue for
 each tin.
-.PP
+
+.TP
 .B srchost
 .br
-	Flows are defined only by source address.  Could be useful on the egress
+Flows are defined only by source address.  Could be useful on the egress
 path of an ISP backhaul.
-.PP
+
+.TP
 .B dsthost
 .br
-	Flows are defined only by destination address.  Could be useful on the
+Flows are defined only by destination address.  Could be useful on the
 ingress path of an ISP backhaul.
-.PP
+
+.TP
 .B hosts
 .br
-	Flows are defined by source-destination host pairs.  This is host
+Flows are defined by source-destination host pairs.  This is host
 isolation, rather than flow isolation.
-.PP
+
+.TP
 .B flows
 .br
-	Flows are defined by the entire 5-tuple of source address, destination
+Flows are defined by the entire 5-tuple of source address, destination
 address, transport protocol, source port and destination port.  This is the type
 of flow isolation performed by SFQ and fq_codel.
-.PP
+
+.TP
 .B dual-srchost
 .br
-	Flows are defined by the 5-tuple, and fairness is applied first over
+Flows are defined by the 5-tuple, and fairness is applied first over
 source addresses, then over individual flows.  Good for use on egress traffic
 from a LAN to the internet, where it'll prevent any one LAN host from
 monopolising the uplink, regardless of the number of flows they use.
-.PP
+
+.TP
 .B dual-dsthost
 .br
-	Flows are defined by the 5-tuple, and fairness is applied first over
+Flows are defined by the 5-tuple, and fairness is applied first over
 destination addresses, then over individual flows.  Good for use on ingress
 traffic to a LAN from the internet, where it'll prevent any one LAN host from
 monopolising the downlink, regardless of the number of flows they use.
-.PP
-.B triple-isolate
-(default)
+
+.TP
+\fBtriple-isolate\fR (default)
 .br
-	Flows are defined by the 5-tuple, and fairness is applied over source
+Flows are defined by the 5-tuple, and fairness is applied over source
 *and* destination addresses intelligently (ie. not merely by host-pairs), and
 also over individual flows.  Use this if you're not certain whether to use
 dual-srchost or dual-dsthost; it'll do both jobs at once, preventing any one
 host on *either* side of the link from monopolising it with a large number of
 flows.
-.PP
+
+.TP
 .B nat
 .br
-	Instructs Cake to perform a NAT lookup before applying flow-isolation
+Instructs Cake to perform a NAT lookup before applying flow-isolation
 rules, to determine the true addresses and port numbers of the packet, to
 improve fairness between hosts "inside" the NAT.  This has no practical effect
 in "flowblind" or "flows" modes, or if NAT is performed on a different host.
-.PP
-.B nonat
-(default)
+
+.TP
+\fBnonat\fR (default)
 .br
-	Cake will not perform a NAT lookup.  Flow isolation will be performed
+Cake will not perform a NAT lookup.  Flow isolation will be performed
 using the addresses and port numbers directly visible to the interface Cake is
 attached to.
 
@@ -495,44 +541,46 @@ the threshold using the same algorithm as the deficit-mode shaper.
 Detailed customisation of tin parameters is not provided.  The following presets
 perform all necessary tuning, relative to the current shaper bandwidth and RTT
 settings.
-.PP
+
+.TP
 .B besteffort
 .br
-	Disables priority queuing by placing all traffic in one tin.
-.PP
+Disables priority queuing by placing all traffic in one tin.
+
+.TP
 .B precedence
 .br
-	Enables legacy interpretation of TOS "Precedence" field.  Use of this
+Enables legacy interpretation of TOS "Precedence" field.  Use of this
 preset on the modern Internet is firmly discouraged.
-.PP
+
+.TP
 .B diffserv4
 .br
-	Provides a general-purpose Diffserv implementation with four tins:
-.br
-		Bulk (CS1, LE in kernel v5.9+), 6.25% threshold, generally low priority.
-.br
-		Best Effort (general), 100% threshold.
+Provides a general-purpose Diffserv implementation with four tins:
+
+\(bu Bulk (CS1, LE in kernel v5.9+), 6.25% threshold, generally low priority.
 .br
-		Video (AF4x, AF3x, CS3, AF2x, CS2, TOS4, TOS1), 50% threshold.
+\(bu Best Effort (general), 100% threshold.
 .br
-		Voice (CS7, CS6, EF, VA, CS5, CS4), 25% threshold.
-.PP
-.B diffserv3
-(default)
+\(bu Video (AF4x, AF3x, CS3, AF2x, CS2, TOS4, TOS1), 50% threshold.
 .br
-	Provides a simple, general-purpose Diffserv implementation with three tins:
+\(bu Voice (CS7, CS6, EF, VA, CS5, CS4), 25% threshold.
+
+.TP
+\fBdiffserv3\fR (default)
 .br
-		Bulk (CS1, LE in kernel v5.9+), 6.25% threshold, generally low priority.
+Provides a simple, general-purpose Diffserv implementation with three tins:
+
+\(bu Bulk (CS1, LE in kernel v5.9+), 6.25% threshold, generally low priority.
 .br
-		Best Effort (general), 100% threshold.
+\(bu Best Effort (general), 100% threshold.
 .br
-		Voice (CS7, CS6, EF, VA, TOS4), 25% threshold, reduced Codel interval.
+\(bu Voice (CS7, CS6, EF, VA, TOS4), 25% threshold, reduced Codel interval.
 
-.PP
-.B fwmark
-MASK
+.TP
+\fBfwmark\fR MASK
 .br
-	This options turns on fwmark-based overriding of CAKE's tin selection.
+This options turns on fwmark-based overriding of CAKE's tin selection.
 If set, the option specifies a bitmask that will be applied to the fwmark
 associated with each packet. If the result of this masking is non-zero, the
 result will be right-shifted by the number of least-significant unset bits in
@@ -541,38 +589,38 @@ This can be used to set policies in a firewall script that will override CAKE's
 built-in tin selection.
 
 .SH OTHER PARAMETERS
+
+.TP
 .B ingress
 .br
-	Indicates that CAKE is running in ingress mode (i.e. running on the downlink
-of a connection). This changes the shaper to also count dropped packets as data
+Indicates that CAKE is running in ingress mode (i.e. running on the downlink of
+a connection). This changes the shaper to also count dropped packets as data
 transferred, as these will have already traversed the link before CAKE can
 choose what to do with them.
 
-	In addition, the AQM will be tuned to always keep at least two packets
+In addition, the AQM will be tuned to always keep at least two packets
 queued per flow. The reason for this is that retransmits are more expensive in
 ingress mode, since dropped packets have to traverse the link again; thus,
 keeping a minimum number of packets queued will improve throughput in cases
 where the number of active flows are so large that they saturate the link even
 at their minimum window size.
 
-.PP
-.B memlimit
-LIMIT
+.TP
+\fBmemlimit\fR LIMIT
 .br
-	Limit the memory consumed by Cake to LIMIT bytes. Note that this does
+Limit the memory consumed by Cake to LIMIT bytes. Note that this does
 not translate directly to queue size (so do not size this based on bandwidth
 delay product considerations, but rather on worst case acceptable memory
 consumption), as there is some overhead in the data structures containing the
 packets, especially for small packets.
 
-	By default, the limit is calculated based on the bandwidth and RTT
+By default, the limit is calculated based on the bandwidth and RTT
 settings.
 
-.PP
+.TP
 .B wash
-
 .br
-	Traffic entering your diffserv domain is frequently mis-marked in
+Traffic entering your diffserv domain is frequently mis-marked in
 transit from the perspective of your network, and traffic exiting yours may be
 mis-marked from the perspective of the transiting provider.
 
@@ -583,15 +631,13 @@ If you are shaping inbound, and cannot trust the diffserv markings (as is the
 case for Comcast Cable, among others), it is best to use a single queue
 "besteffort" mode with wash.
 
-.PP
+.TP
 .B split-gso
-
 .br
-	This option controls whether CAKE will split General Segmentation
+This option controls whether CAKE will split General Segmentation
 Offload (GSO) super-packets into their on-the-wire components and
 dequeue them individually.
 
-.br
 Super-packets are created by the networking stack to improve efficiency.
 However, because they are larger they take longer to dequeue, which
 translates to higher latency for competing flows, especially at lower
@@ -610,25 +656,22 @@ field on the skb, and the flow hashing can be overridden by setting the
 .B classid
 parameter.
 
-.PP
-.B Tin override
-
-.br
-        To assign a priority tin, the major number of the priority field needs
+.SS Tin override
+To assign a priority tin, the major number of the priority field needs
 to match the qdisc handle of the cake instance; if it does, the minor number
 will be interpreted as the tin index. For example, to classify all ICMP packets
 as 'bulk', the following filter can be used:
 
-.br
-        # tc qdisc replace dev eth0 handle 1: root cake diffserv3
-        # tc filter add dev eth0 parent 1: protocol ip prio 1 \\
-          u32 match icmp type 0 0 action skbedit priority 1:1
+.RS
+.EX
+# tc qdisc replace dev eth0 handle 1: root cake diffserv3
+# tc filter add dev eth0 parent 1: protocol ip prio 1 \\
+  u32 match icmp type 0 0 action skbedit priority 1:1
+.EE
+.RE
 
-.PP
-.B Flow hash override
-
-.br
-        To override flow hashing, the classid can be set. CAKE will interpret
+.SS Flow hash override
+To override flow hashing, the classid can be set. CAKE will interpret
 the major number of the classid as the host hash used in host isolation mode,
 and the minor number as the flow hash used for flow-based queueing. One or both
 of those can be set, and will be used if the relevant flow isolation parameter
@@ -636,15 +679,16 @@ is set (i.e., the major number will be ignored if CAKE is not configured in
 hosts mode, and the minor number will be ignored if CAKE is not configured in
 flows mode).
 
-.br
 This example will assign all ICMP packets to the first queue:
 
-.br
-        # tc qdisc replace dev eth0 handle 1: root cake
-        # tc filter add dev eth0 parent 1: protocol ip prio 1 \\
-          u32 match icmp type 0 0 classid 0:1
+.RS
+.EX
+# tc qdisc replace dev eth0 handle 1: root cake
+# tc filter add dev eth0 parent 1: protocol ip prio 1 \\
+  u32 match icmp type 0 0 classid 0:1
+.EE
+.RE
 
-.br
 If only one of the host and flow overrides is set, CAKE will compute the other
 hash from the packet as normal. Note, however, that the host isolation mode
 works by assigning a host ID to the flow queue; so if overriding both host and
@@ -656,12 +700,11 @@ destination host.
 
 
 .SH EXAMPLES
+.EX
 # tc qdisc delete root dev eth0
-.br
 # tc qdisc add root dev eth0 cake bandwidth 100Mbit ethernet
-.br
 # tc -s qdisc show dev eth0
-.br
+
 qdisc cake 1: root refcnt 2 bandwidth 100Mbit diffserv3 triple-isolate rtt 100.0ms noatm overhead 38 mpu 84
  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
  backlog 0b 0p requeues 0
@@ -691,9 +734,10 @@ qdisc cake 1: root refcnt 2 bandwidth 100Mbit diffserv3 triple-isolate rtt 100.0
   un_flows            0            0            0
   max_len             0            0            0
   quantum           300         1514          762
+.EE
 
-After some use:
-.br
+.SS After some use:
+.EX
 # tc -s qdisc show dev eth0
 
 qdisc cake 1: root refcnt 2 bandwidth 100Mbit diffserv3 triple-isolate rtt 100.0ms noatm overhead 38 mpu 84
@@ -725,6 +769,7 @@ qdisc cake 1: root refcnt 2 bandwidth 100Mbit diffserv3 triple-isolate rtt 100.0
   un_flows            0            0            0
   max_len          1514         1514         1514
   quantum           300         1514          762
+.EE
 
 .SH SEE ALSO
 .BR tc (8),
-- 
2.45.2


