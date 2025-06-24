Return-Path: <netdev+bounces-200737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D028CAE6AE4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CFD7AC0E1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34030749A;
	Tue, 24 Jun 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFQEoD0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA46307499;
	Tue, 24 Jun 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777795; cv=none; b=gTjF0wTiOzEpC0AM64KBbgdCcraCM9gEiCgGkFWdhV28U9ejS8gjp9IKzIfHgz/q7gFupyqk4z/Z8sPt85I3Z8wZoTBqNjXhsXcv9+QqsONPGULlUllQ4DY72DAuHi4jnlDTmVxJGVPa26ElwdaZecdht23rt7utocLm0y1FPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777795; c=relaxed/simple;
	bh=OWFTsySS+ap1Eth1b4TAY9yi/2ggn5PK1SNYBv6SlyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O1oyx97kTx6rlvkRrTIkesYWGirhpTsbJyWLZuMcCkow9wKOHxwV/bJxxC9l31xu+ukU6LdLLoowSAH0DsLTIxJtYCjK5IB9Ve/r8lcetcoSmbXGdCVltX4E78GDUMD3A2prOmCMUvyCa6yA5iliIYtT0ljmncn9NfJQ/Ad08c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFQEoD0w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso798472f8f.2;
        Tue, 24 Jun 2025 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777790; x=1751382590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECrYE2hBdfAoc57XhXFds7oudRp9T2ah+DhqL7sBQnc=;
        b=gFQEoD0wcKQivRX+p7JCiWWXbf1iK+dMfTfj8PlvlWq/gitiMg7Id0kI+Eia4YKtjk
         aPzywJq6OR74WFCgLdr8suEewsHmDqInpbr/2LjiS+pLIxdfNqTMyVvp+H64bMvao5m9
         nV/OS8m31mf/SCMxjc+jKYAZYrpXtnET/8qZn7ZuBJeTH/R7N1VgIiQROVTDus3MPGYq
         Q0WKzWwSObI1zqDcCe51gWXYprcoZyXuGpn4AnUKrrQM8B0kTV5dxZMbW52OESQKESpp
         vhFJsGs8DRPJ0BstE2QygabvcYK4C+oXdgfs1VvSYvTV08OX2Qel6Oki/19qJI9JQayn
         Qzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777790; x=1751382590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECrYE2hBdfAoc57XhXFds7oudRp9T2ah+DhqL7sBQnc=;
        b=Rj9GZ+ryU47HADITMBQlQSIkpZno4ay1BtsIFg8NSfh5JihZbCpdJ6M+0mtTEapkpZ
         VbSLip8uMr2HBh08EhfEho4IIyOnyC3ThTX9ukugSe5sNAEZY27wP3H+hUEBHTvSCuM9
         P1HPj731pzUXxFgvIURQDsrnhnYLVrkUCpnwu7C+oiAP2t4V3zgYA893TY2gCK4neZaR
         IIY5h3ktqfG/RoSCCAukhLykHIYBnZ7iNbntcNyiJUau9Af5Ob5eY8ZuzRw0L9yo+0o2
         hVGDH9krDalvrwXoRvUVVrDre0AQiVSNIIe05yegxCyhoA/pzynbGCG8N5HHenBaxNcH
         JzxA==
X-Forwarded-Encrypted: i=1; AJvYcCUSsAm5Vpc3q0aV7R1z/g0H+XyCvsn/vMc3kM0AESJjeDbZaQujQ1YAo9QlavNfAx8tPGFgi4ytyBVjz2Q=@vger.kernel.org, AJvYcCXpG+YLVf5O1SqEsyVkvr9GVFqNs9ojpxvDF2kFaswP+Xe+iG9RLIsiDzhf3u59Hr/NrgjrKMnQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3xWq33EXNUU6TCRXB9d4hAUIPo7h25gi0JDSUevDlnsodq1f
	x5eG1QKD3B83UaED+XSLVaxr4ZslqVQqjJP0Y4L2BpbAwtk5AWuI4X84
X-Gm-Gg: ASbGncvLmCs3WbyUi2YN/mzL4il1tkWwCmnSqE8AUHwDBSZLSoDaXuJs5miLQeVW4sC
	IlTsDIdS01AphpD+XXPp6zCBPwzmh6C6DADk6yCn53HyaS5kr/uIOGH69fnPxyg+A6N7WhPiM/g
	OgQfrV3KMMy/7x8Xyz4jpbSD0QvWNgJvlglg1hNr0TWdRdMZIya8zGoDPVcawgx4wWqOTlUbsq/
	p7THgpQ9HiNiy+ydnPRiFUyxmZOJLCwHm05i0S+5QwV4zQgCAt/eno0UpjKSpisZvpwYnX+8QzY
	GloAQXMHy7CTr0rht+A/IoU/D2eD+7CrL2XfeJop0ilWs4u/Ll2ShIaI1MFnJ9aceB+sxlTT+Uc
	NuWfYOOJPp91F9Hb7Q3BhegI=
X-Google-Smtp-Source: AGHT+IF83Fo6qO8bkIysEEgxJkgC/vP0W9rm4puFVnDC8LEgRyY4c/O/nZjBPtI/uP5EjI0tSGT6Nw==
X-Received: by 2002:a5d:64cb:0:b0:3a4:f7ae:7801 with SMTP id ffacd0b85a97d-3a6d12ad8a9mr5338271f8f.8.1750777789678;
        Tue, 24 Jun 2025 08:09:49 -0700 (PDT)
Received: from localhost.localdomain ([156.208.189.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8105f93sm2185975f8f.76.2025.06.24.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:09:49 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.com,
	jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com,
	bagasdotme@gmail.com,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH net-next v6] docs: net: sysctl documentation cleanup
Date: Tue, 24 Jun 2025 18:09:23 +0300
Message-Id: <20250624150923.40590-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing default values for networking sysctl parameters and
standardize documentation:
- Use "0 (disabled)" / "1 (enabled)" format consistently
- Fix cipso_rbm_struct_valid -> cipso_rbm_strictvalid typo
- Convert fwmark_reflect description to enabled/disabled terminology
- Document possible values for tcp_autocorking

Also addresses formatting inconsistencies in touched parameters.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
v6:
- fix uncorrect default value change

v5: https://lore.kernel.org/all/20250622090720.190673-1-abdelrahmanfekry375@gmail.com/
- Fixes indentation problem.

v4: https://lore.kernel.org/all/20250622062724.180130-1-abdelrahmanfekry375@gmail.com/
- Fixes blank line error that causes lists to be rendered as normal text.
- Standarize more booleans.

v3: https://lore.kernel.org/all/20250620215542.153440-1-abdelrahmanfekry375@gmail.com/
- Uses imperative mood in patch description
- Make sure patch applies by rebasing to net-next first
- Added Possible values for more booleans
- Used enabled/disabled instead of set/unset
- Standarized formatting of touched booleans

v2: https://lore.kernel.org/all/20250614225324.82810-2-abdelrahmanfekry375@gmail.com/
- Deleted space before colon for consistency
- Standardized more boolean representation (0/1 with enabled/disabled)

v1: https://lore.kernel.org/all/20250612162954.55843-2-abdelrahmanfekry375@gmail.com/
- Fixed typo in cipso_rbm_struct_valid
- Added missing default value declarations
- Standardized boolean representation (0/1 with enabled/disabled)

 Documentation/networking/ip-sysctl.rst | 674 +++++++++++++++++++------
 1 file changed, 521 insertions(+), 153 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 466bc3f5186e..9af5a8935d57 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -8,15 +8,19 @@ IP Sysctl
 ==============================
 
 ip_forward - BOOLEAN
-	- 0 - disabled (default)
-	- not 0 - enabled
-
 	Forward Packets between interfaces.
 
 	This variable is special, its change resets all configuration
 	parameters to their default state (RFC1122 for hosts, RFC1812
 	for routers)
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 ip_default_ttl - INTEGER
 	Default value of TTL field (Time To Live) for outgoing (but not
 	forwarded) IP packets. Should be between 1 and 255 inclusive.
@@ -62,20 +66,25 @@ ip_forward_use_pmtu - BOOLEAN
 	kernel honoring this information. This is normally not the
 	case.
 
-	Default: 0 (disabled)
-
 	Possible values:
 
-	- 0 - disabled
-	- 1 - enabled
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv4 reply packets that are not
 	associated with a socket for example, TCP RSTs or ICMP echo replies).
-	If unset, these packets have a fwmark of zero. If set, they have the
+	If disabled, these packets have a fwmark of zero. If enabled, they have the
 	fwmark of the packet they are replying to.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 fib_multipath_use_neigh - BOOLEAN
 	Use status of existing neighbor entry when determining nexthop for
@@ -83,12 +92,12 @@ fib_multipath_use_neigh - BOOLEAN
 	packets could be directed to a failed nexthop. Only valid for kernels
 	built with CONFIG_IP_ROUTE_MULTIPATH enabled.
 
-	Default: 0 (disabled)
-
 	Possible values:
 
-	- 0 - disabled
-	- 1 - enabled
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 fib_multipath_hash_policy - INTEGER
 	Controls which hash policy to use for multipath routes. Only valid
@@ -368,7 +377,12 @@ tcp_autocorking - BOOLEAN
 	queue. Applications can still use TCP_CORK for optimal behavior
 	when they know how/when to uncork their sockets.
 
-	Default : 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_available_congestion_control - STRING
 	Shows the available congestion control choices that are registered.
@@ -408,6 +422,13 @@ tcp_congestion_control - STRING
 tcp_dsack - BOOLEAN
 	Allows TCP to send "duplicate" SACKs.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 tcp_early_retrans - INTEGER
 	Tail loss probe (TLP) converts RTOs occurring due to tail
 	losses into fast recovery (draft-ietf-tcpm-rack). Note that
@@ -447,7 +468,12 @@ tcp_ecn_fallback - BOOLEAN
 	knob. The value	is not used, if tcp_ecn or per route (or congestion
 	control) ECN settings are disabled.
 
-	Default: 1 (fallback enabled)
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_fack - BOOLEAN
 	This is a legacy option, it has no effect anymore.
@@ -474,7 +500,7 @@ tcp_frto - INTEGER
 	By default it's enabled with a non-zero value. 0 disables F-RTO.
 
 tcp_fwmark_accept - BOOLEAN
-	If set, incoming connections to listening sockets that do not have a
+	If enabled, incoming connections to listening sockets that do not have a
 	socket mark will set the mark of the accepting socket to the fwmark of
 	the incoming SYN packet. This will cause all packets on that connection
 	(starting from the first SYNACK) to be sent with that fwmark. The
@@ -482,7 +508,12 @@ tcp_fwmark_accept - BOOLEAN
 	have a fwmark set via setsockopt(SOL_SOCKET, SO_MARK, ...) are
 	unaffected.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_invalid_ratelimit - INTEGER
 	Limit the maximal rate for sending duplicate acknowledgments
@@ -528,6 +559,11 @@ tcp_l3mdev_accept - BOOLEAN
 	which the packets originated. Only valid when the kernel was
 	compiled with CONFIG_NET_L3_MASTER_DEV.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
 	Default: 0 (disabled)
 
 tcp_low_latency - BOOLEAN
@@ -593,10 +629,16 @@ tcp_min_rtt_wlen - INTEGER
 	Default: 300
 
 tcp_moderate_rcvbuf - BOOLEAN
-	If set, TCP performs receive buffer auto-tuning, attempting to
+	If enabled, TCP performs receive buffer auto-tuning, attempting to
 	automatically size the buffer (no greater than tcp_rmem[2]) to
-	match the size required by the path for full throughput.  Enabled by
-	default.
+	match the size required by the path for full throughput.
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_mtu_probing - INTEGER
 	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
@@ -621,13 +663,26 @@ tcp_no_metrics_save - BOOLEAN
 	when the connection closes, so that connections established in the
 	near future can use these to set initial conditions.  Usually, this
 	increases overall performance, but may sometimes cause performance
-	degradation.  If set, TCP will not cache metrics on closing
+	degradation.  If enabled, TCP will not cache metrics on closing
 	connections.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 tcp_no_ssthresh_metrics_save - BOOLEAN
 	Controls whether TCP saves ssthresh metrics in the route cache.
+	If enabled, ssthresh metrics are disabled.
+
+	Possible values:
 
-	Default is 1, which disables ssthresh metrics.
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_orphan_retries - INTEGER
 	This value influences the timeout of a locally closed TCP connection,
@@ -666,6 +721,11 @@ tcp_reflect_tos - BOOLEAN
 
 	This options affects both IPv4 and IPv6.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
 	Default: 0 (disabled)
 
 tcp_reordering - INTEGER
@@ -687,6 +747,13 @@ tcp_retrans_collapse - BOOLEAN
 	On retransmit try to send bigger packets to work around bugs in
 	certain TCP stacks.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 tcp_retries1 - INTEGER
 	This value influences the time, after which TCP decides, that
 	something is wrong due to unacknowledged RTO retransmissions,
@@ -714,11 +781,16 @@ tcp_retries2 - INTEGER
 	which corresponds to a value of at least 8.
 
 tcp_rfc1337 - BOOLEAN
-	If set, the TCP stack behaves conforming to RFC1337. If unset,
+	If enabled, the TCP stack behaves conforming to RFC1337. If unset,
 	we are not conforming to RFC, but prevent TCP TIME_WAIT
 	assassination.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_rmem - vector of 3 INTEGERs: min, default, max
 	min: Minimal size of receive buffer used by TCP sockets.
@@ -742,6 +814,13 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 tcp_comp_sack_delay_ns - LONG INTEGER
 	TCP tries to reduce number of SACK sent, using a timer
 	based on 5% of SRTT, capped by this sysctl, in nano seconds.
@@ -764,26 +843,41 @@ tcp_comp_sack_nr - INTEGER
 	Default : 44
 
 tcp_backlog_ack_defer - BOOLEAN
-	If set, user thread processing socket backlog tries sending
+	If enabled, user thread processing socket backlog tries sending
 	one ACK for the whole queue. This helps to avoid potential
 	long latencies at end of a TCP socket syscall.
 
-	Default : true
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_slow_start_after_idle - BOOLEAN
-	If set, provide RFC2861 behavior and time out the congestion
+	If enabled, provide RFC2861 behavior and time out the congestion
 	window after an idle period.  An idle period is defined at
 	the current RTO.  If unset, the congestion window will not
 	be timed out after an idle period.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_stdurg - BOOLEAN
 	Use the Host requirements interpretation of the TCP urgent pointer field.
-	Most hosts use the older BSD interpretation, so if you turn this on
+	Most hosts use the older BSD interpretation, so if enabled,
 	Linux might not communicate correctly with them.
 
-	Default: FALSE
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
@@ -840,7 +934,12 @@ tcp_migrate_req - BOOLEAN
 	migration by returning SK_DROP in the type of eBPF program, or
 	disable this option.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_fastopen - INTEGER
 	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
@@ -1021,6 +1120,13 @@ tcp_tw_reuse_delay - UNSIGNED INTEGER
 tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 tcp_shrink_window - BOOLEAN
 	This changes how the TCP receive window is calculated.
 
@@ -1028,13 +1134,15 @@ tcp_shrink_window - BOOLEAN
 	window can be offered, and that TCP implementations MUST ensure
 	that they handle a shrinking window, as specified in RFC 1122.
 
-	- 0 - Disabled.	The window is never shrunk.
-	- 1 - Enabled.	The window is shrunk when necessary to remain within
-			the memory limit set by autotuning (sk_rcvbuf).
-			This only occurs if a non-zero receive window
-			scaling factor is also in effect.
+	Possible values:
 
-	Default: 0
+	- 0 (disabled) - The window is never shrunk.
+	- 1 (enabled)  - The window is shrunk when necessary to remain within
+	  the memory limit set by autotuning (sk_rcvbuf).
+	  This only occurs if a non-zero receive window
+	  scaling factor is also in effect.
+
+	Default: 0 (disabled)
 
 tcp_wmem - vector of 3 INTEGERs: min, default, max
 	min: Amount of memory reserved for send buffers for TCP sockets.
@@ -1071,16 +1179,21 @@ tcp_notsent_lowat - UNSIGNED INTEGER
 	Default: UINT_MAX (0xFFFFFFFF)
 
 tcp_workaround_signed_windows - BOOLEAN
-	If set, assume no receipt of a window scaling option means the
+	If enabled, assume no receipt of a window scaling option means the
 	remote TCP is broken and treats the window as a signed quantity.
-	If unset, assume the remote TCP is not broken even if we do
+	If disabled, assume the remote TCP is not broken even if we do
 	not receive a window scaling option from them.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_thin_linear_timeouts - BOOLEAN
 	Enable dynamic triggering of linear timeouts for thin streams.
-	If set, a check is performed upon retransmission by timeout to
+	If enabled, a check is performed upon retransmission by timeout to
 	determine if the stream is thin (less than 4 packets in flight).
 	As long as the stream is found to be thin, up to 6 linear
 	timeouts may be performed before exponential backoff mode is
@@ -1089,7 +1202,12 @@ tcp_thin_linear_timeouts - BOOLEAN
 	For more information on thin streams, see
 	Documentation/networking/tcp-thin.rst
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_limit_output_bytes - INTEGER
 	Controls TCP Small Queue limit per tcp socket.
@@ -1141,7 +1259,7 @@ tcp_child_ehash_entries - INTEGER
 	Default: 0
 
 tcp_plb_enabled - BOOLEAN
-	If set and the underlying congestion control (e.g. DCTCP) supports
+	If enabled and the underlying congestion control (e.g. DCTCP) supports
 	and enables PLB feature, TCP PLB (Protective Load Balancing) is
 	enabled. PLB is described in the following paper:
 	https://doi.org/10.1145/3544216.3544226. Based on PLB parameters,
@@ -1157,12 +1275,17 @@ tcp_plb_enabled - BOOLEAN
 	by switches to determine next hop. In either case, further host
 	and switch side changes will be needed.
 
-	When set, PLB assumes that congestion signal (e.g. ECN) is made
+	If enabled, PLB assumes that congestion signal (e.g. ECN) is made
 	available and used by congestion control module to estimate a
 	congestion measure (e.g. ce_ratio). PLB needs a congestion measure to
 	make repathing decisions.
 
-	Default: FALSE
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 tcp_plb_idle_rehash_rounds - INTEGER
 	Number of consecutive congested rounds (RTT) seen after which
@@ -1262,6 +1385,11 @@ udp_l3mdev_accept - BOOLEAN
 	originated. Only valid when the kernel was compiled with
 	CONFIG_NET_L3_MASTER_DEV.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
 	Default: 0 (disabled)
 
 udp_mem - vector of 3 INTEGERs: min, pressure, max
@@ -1322,19 +1450,29 @@ raw_l3mdev_accept - BOOLEAN
 	originated. Only valid when the kernel was compiled with
 	CONFIG_NET_L3_MASTER_DEV.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
 	Default: 1 (enabled)
 
 CIPSOv4 Variables
 =================
 
 cipso_cache_enable - BOOLEAN
-	If set, enable additions to and lookups from the CIPSO label mapping
-	cache.  If unset, additions are ignored and lookups always result in a
+	If enabled, enable additions to and lookups from the CIPSO label mapping
+	cache.  If disabled, additions are ignored and lookups always result in a
 	miss.  However, regardless of the setting the cache is still
 	invalidated when required when means you can safely toggle this on and
 	off and the cache will always be "safe".
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 cipso_cache_bucket_size - INTEGER
 	The CIPSO label cache consists of a fixed size hash table with each
@@ -1352,17 +1490,27 @@ cipso_rbm_optfmt - BOOLEAN
 	This means that when set the CIPSO tag will be padded with empty
 	categories in order to make the packet data 32-bit aligned.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
-cipso_rbm_structvalid - BOOLEAN
-	If set, do a very strict check of the CIPSO option when
-	ip_options_compile() is called.  If unset, relax the checks done during
+cipso_rbm_strictvalid - BOOLEAN
+	If enabled, do a very strict check of the CIPSO option when
+	ip_options_compile() is called.  If disabled, relax the checks done during
 	ip_options_compile().  Either way is "safe" as errors are caught else
 	where in the CIPSO processing code but setting this to 0 (False) should
 	result in less work (i.e. it should be faster) but could cause problems
 	with other implementations that require strict checking.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 IP Variables
 ============
@@ -1419,10 +1567,15 @@ ip_unprivileged_port_start - INTEGER
 	Default: 1024
 
 ip_nonlocal_bind - BOOLEAN
-	If set, allows processes to bind() to non-local IP addresses,
+	If enabled, allows processes to bind() to non-local IP addresses,
 	which can be quite useful - but may break some applications.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 ip_autobind_reuse - BOOLEAN
 	By default, bind() does not select the ports automatically even if
@@ -1431,7 +1584,13 @@ ip_autobind_reuse - BOOLEAN
 	when you use bind()+connect(), but may break some applications.
 	The preferred solution is to use IP_BIND_ADDRESS_NO_PORT and this
 	option should only be set by experts.
-	Default: 0
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 ip_dynaddr - INTEGER
 	If set non-zero, enables support for dynamic addresses.
@@ -1449,7 +1608,12 @@ ip_early_demux - BOOLEAN
 	It may add an additional cost for pure routing workloads that
 	reduces overall throughput, in such case you should disable it.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 ping_group_range - 2 INTEGERS
 	Restrict ICMP_PROTO datagram sockets to users in the group range.
@@ -1461,31 +1625,56 @@ ping_group_range - 2 INTEGERS
 tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 udp_early_demux - BOOLEAN
 	Enable early demux for connected UDP sockets. Disable this if
 	your system could experience more unconnected load.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 icmp_echo_ignore_all - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO
+	If enabled, then the kernel will ignore all ICMP ECHO
 	requests sent to it.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 icmp_echo_enable_probe - BOOLEAN
-        If set to one, then the kernel will respond to RFC 8335 PROBE
+        If enabled, then the kernel will respond to RFC 8335 PROBE
         requests sent to it.
 
-        Default: 0
+        Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 icmp_echo_ignore_broadcasts - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO and
+	If enabled, then the kernel will ignore all ICMP ECHO and
 	TIMESTAMP requests sent to it via broadcast/multicast.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 icmp_ratelimit - INTEGER
 	Limit the maximal rates for sending ICMP packets whose type matches
@@ -1542,17 +1731,22 @@ icmp_ratemask - INTEGER
 icmp_ignore_bogus_error_responses - BOOLEAN
 	Some routers violate RFC1122 by sending bogus responses to broadcast
 	frames.  Such violations are normally logged via a kernel warning.
-	If this is set to TRUE, the kernel will not give such warnings, which
+	If enabled, the kernel will not give such warnings, which
 	will avoid log file clutter.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 icmp_errors_use_inbound_ifaddr - BOOLEAN
 
-	If zero, icmp error messages are sent with the primary address of
+	If disabled, icmp error messages are sent with the primary address of
 	the exiting interface.
 
-	If non-zero, the message will be sent with the primary address of
+	If enabled, the message will be sent with the primary address of
 	the interface that received the packet that caused the icmp error.
 	This is the behaviour many network administrators will expect from
 	a router. And it can make debugging complicated network layouts
@@ -1562,7 +1756,12 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
 	then the primary address of the first non-loopback interface that
 	has one will be used regardless of this setting.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 igmp_max_memberships - INTEGER
 	Change the maximum number of multicast groups we can subscribe to.
@@ -1912,8 +2111,12 @@ arp_evict_nocarrier - BOOLEAN
 	between access points on the same network. In most cases this should
 	remain as the default (1).
 
-	- 1 - (default): Clear the ARP cache on NOCARRIER events
-	- 0 - Do not clear ARP cache on NOCARRIER events
+	Possible values:
+
+	- 0 (disabled) - Do not clear ARP cache on NOCARRIER events
+	- 1 (enabled)  - Clear the ARP cache on NOCARRIER events
+
+	Default: 1 (enabled)
 
 mcast_solicit - INTEGER
 	The maximum number of multicast probes in INCOMPLETE state,
@@ -1936,9 +2139,23 @@ mcast_resolicit - INTEGER
 disable_policy - BOOLEAN
 	Disable IPSEC policy (SPD) for this interface
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 disable_xfrm - BOOLEAN
 	Disable IPSEC encryption on this interface, whatever the policy
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 igmpv2_unsolicited_report_interval - INTEGER
 	The interval in milliseconds in which the next unsolicited
 	IGMPv1 or IGMPv2 report retransmit will take place.
@@ -1954,11 +2171,25 @@ igmpv3_unsolicited_report_interval - INTEGER
 ignore_routes_with_linkdown - BOOLEAN
         Ignore routes whose link is down when performing a FIB lookup.
 
+        Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 promote_secondaries - BOOLEAN
 	When a primary IP address is removed from this interface
 	promote a corresponding secondary IP address instead of
 	removing all the corresponding secondary IP addresses.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 drop_unicast_in_l2_multicast - BOOLEAN
 	Drop any unicast IP packets that are received in link-layer
 	multicast (or broadcast) frames.
@@ -1966,14 +2197,24 @@ drop_unicast_in_l2_multicast - BOOLEAN
 	This behavior (for multicast) is actually a SHOULD in RFC
 	1122, but is disabled by default for compatibility reasons.
 
-	Default: off (0)
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 drop_gratuitous_arp - BOOLEAN
 	Drop all gratuitous ARP frames, for example if there's a known
 	good ARP proxy on the network and such frames need not be used
 	(or in the case of 802.11, must not be used to prevent attacks.)
 
-	Default: off (0)
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 
 tag - INTEGER
@@ -2017,20 +2258,24 @@ bindv6only - BOOLEAN
 	which restricts use of the IPv6 socket to IPv6 communication
 	only.
 
-		- TRUE: disable IPv4-mapped address feature
-		- FALSE: enable IPv4-mapped address feature
+	Possible values:
 
-	Default: FALSE (as specified in RFC3493)
+	- 0 (disabled) - enable IPv4-mapped address feature
+	- 1 (enabled)  - disable IPv4-mapped address feature
+
+	Default: 0 (disabled)
 
 flowlabel_consistency - BOOLEAN
 	Protect the consistency (and unicity) of flow label.
 	You have to disable it to use IPV6_FL_F_REFLECT flag on the
 	flow label manager.
 
-	- TRUE: enabled
-	- FALSE: disabled
+	Possible values:
 
-	Default: TRUE
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 auto_flowlabels - INTEGER
 	Automatically generate flow labels based on a flow hash of the
@@ -2056,10 +2301,13 @@ flowlabel_state_ranges - BOOLEAN
 	reserved for the IPv6 flow manager facility, 0x80000-0xFFFFF
 	is reserved for stateless flow labels as described in RFC6437.
 
-	- TRUE: enabled
-	- FALSE: disabled
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
-	Default: true
 
 flowlabel_reflect - INTEGER
 	Control flow label reflection. Needed for Path MTU
@@ -2127,10 +2375,13 @@ anycast_src_echo_reply - BOOLEAN
 	Controls the use of anycast addresses as source addresses for ICMPv6
 	echo reply
 
-	- TRUE:  enabled
-	- FALSE: disabled
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
-	Default: FALSE
 
 idgen_delay - INTEGER
 	Controls the delay in seconds after which time to retry
@@ -2187,7 +2438,12 @@ skip_notify_on_dev_down - BOOLEAN
 	to true skips the message, making IPv4 and IPv6 on par in relying
 	on userspace caches to track link events and evict routes.
 
-	Default: false (generate message)
+	Possible values:
+
+	- 0 (disabled) - generate the message
+	- 1 (enabled)  - skip generating the message
+
+	Default: 0 (disabled)
 
 nexthop_compat_mode - BOOLEAN
 	New nexthop API provides a means for managing nexthops independent of
@@ -2294,13 +2550,26 @@ conf/all/forwarding - BOOLEAN
 proxy_ndp - BOOLEAN
 	Do proxy ndp.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
+
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv6 reply packets that are not
 	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
-	If unset, these packets have a fwmark of zero. If set, they have the
+	If disabled, these packets have a fwmark of zero. If enabled, they have the
 	fwmark of the packet they are replying to.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 ``conf/interface/*``:
 	Change special settings per interface.
@@ -2391,9 +2660,11 @@ ra_honor_pio_life - BOOLEAN
 	lifetime of an address matching a prefix sent in a Router
 	Advertisement Prefix Information Option.
 
-	- If enabled, the PIO valid lifetime will always be honored.
-	- If disabled, RFC4862 section 5.5.3e is used to determine
+	Possible values:
+
+	- 0 (disabled) - RFC4862 section 5.5.3e is used to determine
 	  the valid lifetime of the address.
+	- 1 (enabled)  - the PIO valid lifetime will always be honored.
 
 	Default: 0 (disabled)
 
@@ -2405,8 +2676,10 @@ ra_honor_pio_pflag - BOOLEAN
 	P-flag suppresses any effects of the A-flag within the same
 	PIO. For a given PIO, P=1 and A=1 is treated as A=0.
 
-	- If disabled, the P-flag is ignored.
-	- If enabled, the P-flag will disable SLAAC autoconfiguration
+	Possible values:
+
+	- 0 (disabled) - the P-flag is ignored.
+	- 1 (enabled)  - the P-flag will disable SLAAC autoconfiguration
 	  for the given Prefix Information Option.
 
 	Default: 0 (disabled)
@@ -2528,10 +2801,15 @@ mtu - INTEGER
 	Default: 1280 (IPv6 required minimum)
 
 ip_nonlocal_bind - BOOLEAN
-	If set, allows processes to bind() to non-local IPv6 addresses,
+	If enabled, allows processes to bind() to non-local IPv6 addresses,
 	which can be quite useful - but may break some applications.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 router_probe_interval - INTEGER
 	Minimum interval (in seconds) between Router Probing described
@@ -2561,7 +2839,12 @@ use_oif_addrs_only - BOOLEAN
 	routed via this interface are restricted to the set of addresses
 	configured on this interface (vis. RFC 6724, section 4).
 
-	Default: false
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 use_tempaddr - INTEGER
 	Preference for Privacy Extensions (RFC3041).
@@ -2686,10 +2969,14 @@ force_tllao - BOOLEAN
 ndisc_notify - BOOLEAN
 	Define mode for notification of address and device changes.
 
-	* 0 - (default): do nothing
-	* 1 - Generate unsolicited neighbour advertisements when device is brought
+	Possible values:
+
+	- 0 (disabled) - do nothing
+	- 1 (enabled)  - Generate unsolicited neighbour advertisements when device is brought
 	  up or hardware address changes.
 
+	Default: 0 (disabled)
+
 ndisc_tclass - INTEGER
 	The IPv6 Traffic Class to use by default when sending IPv6 Neighbor
 	Discovery (Router Solicitation, Router Advertisement, Neighbor
@@ -2706,8 +2993,12 @@ ndisc_evict_nocarrier - BOOLEAN
 	not be cleared when roaming between access points on the same network.
 	In most cases this should remain as the default (1).
 
-	- 1 - (default): Clear neighbor discover cache on NOCARRIER events.
-	- 0 - Do not clear neighbor discovery cache on NOCARRIER events.
+	Possible values:
+
+	- 0 (disabled) - Do not clear neighbor discovery cache on NOCARRIER events.
+	- 1 (enabled)  - Clear neighbor discover cache on NOCARRIER events.
+
+	Default: 1 (enabled)
 
 mldv1_unsolicited_report_interval - INTEGER
 	The interval in milliseconds in which the next unsolicited
@@ -2736,25 +3027,34 @@ suppress_frag_ndisc - INTEGER
 optimistic_dad - BOOLEAN
 	Whether to perform Optimistic Duplicate Address Detection (RFC 4429).
 
-	* 0: disabled (default)
-	* 1: enabled
-
 	Optimistic Duplicate Address Detection for the interface will be enabled
 	if at least one of conf/{all,interface}/optimistic_dad is set to 1,
 	it will be disabled otherwise.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
+
 use_optimistic - BOOLEAN
 	If enabled, do not classify optimistic addresses as deprecated during
 	source address selection.  Preferred addresses will still be chosen
 	before optimistic addresses, subject to other ranking in the source
 	address selection algorithm.
 
-	* 0: disabled (default)
-	* 1: enabled
-
 	This will be enabled if at least one of
 	conf/{all,interface}/use_optimistic is set to 1, disabled otherwise.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 stable_secret - IPv6 address
 	This IPv6 address will be used as a secret to generate IPv6
 	addresses for link-local addresses and autoconfigured
@@ -2785,14 +3085,24 @@ drop_unicast_in_l2_multicast - BOOLEAN
 	Drop any unicast IPv6 packets that are received in link-layer
 	multicast (or broadcast) frames.
 
-	By default this is turned off.
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 drop_unsolicited_na - BOOLEAN
 	Drop all unsolicited neighbor advertisements, for example if there's
 	a known good NA proxy on the network and such frames need not be used
 	(or in the case of 802.11, must not be used to prevent attacks.)
 
-	By default this is turned off.
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled).
 
 accept_untracked_na - INTEGER
 	Define behavior for accepting neighbor advertisements from devices that
@@ -2833,7 +3143,12 @@ enhanced_dad - BOOLEAN
 	The nonce option will be sent on an interface unless both of
 	conf/{all,interface}/enhanced_dad are set to FALSE.
 
-	Default: TRUE
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 ``icmp/*``:
 ===========
@@ -2862,29 +3177,49 @@ ratemask - list of comma separated ranges
 	Default: 0-1,3-127 (rate limit ICMPv6 errors except Packet Too Big)
 
 echo_ignore_all - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO
+	If enabled, then the kernel will ignore all ICMP ECHO
 	requests sent to it over the IPv6 protocol.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 echo_ignore_multicast - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO
+	If enabled, then the kernel will ignore all ICMP ECHO
 	requests sent to it over the IPv6 protocol via multicast.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 echo_ignore_anycast - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO
+	If enabled, then the kernel will ignore all ICMP ECHO
 	requests sent to it over the IPv6 protocol destined to anycast address.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 error_anycast_as_unicast - BOOLEAN
-	If set to 1, then the kernel will respond with ICMP Errors
+	If enabled, then the kernel will respond with ICMP Errors
 	resulting from requests sent to it over the IPv6 protocol destined
 	to anycast address essentially treating anycast as unicast.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
 
 xfrm6_gc_thresh - INTEGER
 	(Obsolete since linux-4.14)
@@ -2902,34 +3237,49 @@ YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
 =================================
 
 bridge-nf-call-arptables - BOOLEAN
-	- 1 : pass bridged ARP traffic to arptables' FORWARD chain.
-	- 0 : disable this.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled) - disable this.
+	- 1 (enabled)  - pass bridged ARP traffic to arptables' FORWARD chain.
+
+	Default: 1 (enabled)
 
 bridge-nf-call-iptables - BOOLEAN
-	- 1 : pass bridged IPv4 traffic to iptables' chains.
-	- 0 : disable this.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled) - disable this.
+	- 1 (enabled)  - pass bridged IPv4 traffic to iptables' chains.
+
+	Default: 1 (enabled)
 
 bridge-nf-call-ip6tables - BOOLEAN
-	- 1 : pass bridged IPv6 traffic to ip6tables' chains.
-	- 0 : disable this.
 
-	Default: 1
+	Possible values:
+
+	- 0 (disabled) - disable this.
+	- 1 (enabled)  - pass bridged IPv6 traffic to ip6tables' chains.
+
+	Default: 1 (enabled)
 
 bridge-nf-filter-vlan-tagged - BOOLEAN
-	- 1 : pass bridged vlan-tagged ARP/IP/IPv6 traffic to {arp,ip,ip6}tables.
-	- 0 : disable this.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled) - disable this.
+	- 1 (enabled)  - pass bridged vlan-tagged ARP/IP/IPv6 traffic to {arp,ip,ip6}tables
+
+	Default: 0 (disabled)
 
 bridge-nf-filter-pppoe-tagged - BOOLEAN
-	- 1 : pass bridged pppoe-tagged IP/IPv6 traffic to {ip,ip6}tables.
-	- 0 : disable this.
 
-	Default: 0
+	Possible values:
+
+	- 0 (disabled) - disable this.
+	- 1 (enabled)  - pass bridged pppoe-tagged IP/IPv6 traffic to {ip,ip6}tables.
+
+	Default: 0 (disabled)
 
 bridge-nf-pass-vlan-input-dev - BOOLEAN
 	- 1: if bridge-nf-filter-vlan-tagged is enabled, try to find a vlan
@@ -2952,11 +3302,12 @@ addip_enable - BOOLEAN
 	the ability to dynamically add and remove new addresses for the SCTP
 	associations.
 
-	1: Enable extension.
+	Possible values:
 
-	0: Disable extension.
+	- 0 (disabled) - disable extension.
+	- 1 (enabled)  - enable extension
 
-	Default: 0
+	Default: 0 (disabled)
 
 pf_enable - INTEGER
 	Enable or disable pf (pf is short for potentially failed) state. A value
@@ -3025,19 +3376,23 @@ auth_enable - BOOLEAN
 	required for secure operation of Dynamic Address Reconfiguration
 	(ADD-IP) extension.
 
-	- 1: Enable this extension.
-	- 0: Disable this extension.
+	Possible values:
 
-	Default: 0
+	- 0 (disabled) - disable extension.
+	- 1 (enabled)  - enable extension
+
+	Default: 0 (disabled)
 
 prsctp_enable - BOOLEAN
 	Enable or disable the Partial Reliability extension (RFC3758) which
 	is used to notify peers that a given DATA should no longer be expected.
 
-	- 1: Enable extension
-	- 0: Disable
+	Possible values:
 
-	Default: 1
+	- 0 (disabled) - disable extension.
+	- 1 (enabled)  - enable extension
+
+	Default: 1 (enabled)
 
 max_burst - INTEGER
 	The limit of the number of new packets that can be initially sent.  It
@@ -3137,10 +3492,12 @@ cookie_preserve_enable - BOOLEAN
 	Enable or disable the ability to extend the lifetime of the SCTP cookie
 	that is used during the establishment phase of SCTP association
 
-	- 1: Enable cookie lifetime extension.
-	- 0: Disable
+	Possible values:
+
+	- 0 (disabled) - disable.
+	- 1 (enabled)  - enable cookie lifetime extension.
 
-	Default: 1
+	Default: 1 (enabled)
 
 cookie_hmac_alg - STRING
 	Select the hmac algorithm used when generating the cookie value sent by
@@ -3274,10 +3631,12 @@ reconf_enable - BOOLEAN
         a stream, and it includes the Parameters of "Outgoing/Incoming SSN
         Reset", "SSN/TSN Reset" and "Add Outgoing/Incoming Streams".
 
-	- 1: Enable extension.
-	- 0: Disable extension.
+	Possible values:
 
-	Default: 0
+	- 0 (disabled) - Disable extension.
+	- 1 (enabled) - Enable extension.
+
+	Default: 0 (disabled)
 
 intl_enable - BOOLEAN
         Enable or disable extension of User Message Interleaving functionality
@@ -3288,10 +3647,12 @@ intl_enable - BOOLEAN
         to 1 and also needs to set socket options SCTP_FRAGMENT_INTERLEAVE to 2
         and SCTP_INTERLEAVING_SUPPORTED to 1.
 
-	- 1: Enable extension.
-	- 0: Disable extension.
+	Possible values:
 
-	Default: 0
+	- 0 (disabled) - Disable extension.
+	- 1 (enabled) - Enable extension.
+
+	Default: 0 (disabled)
 
 ecn_enable - BOOLEAN
         Control use of Explicit Congestion Notification (ECN) by SCTP.
@@ -3300,10 +3661,12 @@ ecn_enable - BOOLEAN
         due to congestion by allowing supporting routers to signal congestion
         before having to drop packets.
 
-        1: Enable ecn.
-        0: Disable ecn.
+        Possible values:
 
-        Default: 1
+	- 0 (disabled) - Disable ecn.
+	- 1 (enabled) - Enable ecn.
+
+	Default: 1 (enabled)
 
 l3mdev_accept - BOOLEAN
 	Enabling this option allows a "global" bound socket to work
@@ -3312,6 +3675,11 @@ l3mdev_accept - BOOLEAN
 	originated. Only valid when the kernel was compiled with
 	CONFIG_NET_L3_MASTER_DEV.
 
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
 	Default: 1 (enabled)
 
 
-- 
2.25.1


