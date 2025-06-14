Return-Path: <netdev+bounces-197751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE358AD9BBF
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1240189D99E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509A244677;
	Sat, 14 Jun 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+k6FHmW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C00F50F;
	Sat, 14 Jun 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749893242; cv=none; b=fLO3QJWRzmNYrFbAJ6f/1OC8U2/Jjz7l0VJtgfZKFIX0x8Ev/m/g0P+YQU/aRtZ0bTFB6NNyiyNmmkqRReSX5pAovA3QYdJhzv45jZVZhH6micrEbXXP7GApZuq5MHyViF6lQ4o7Ho8Z8qSLyHsUpSJNuq/IAcTpxMBCYzhgTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749893242; c=relaxed/simple;
	bh=jqiRf5jpsYfPahTWJgkrFQNqWCksHEG0UZ4QVuvztrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6vs80v0EcNQPp4BElSgHFGm+2mMuzHxE8zTlq/7moN30zl3ERAtgblpY8n1F31jTfjqO9Yqdcrk6rpB0udgXq8HphiTWcJk0HOVChUT7Ay4oX3/U1ZqKLjvz5Yy5b2rOErTB1mR14tzX+uy1pBAWkXWhGGzQPPLT5uFkKhzKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+k6FHmW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4531898b208so3362235e9.3;
        Sat, 14 Jun 2025 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749893238; x=1750498038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUaqaUgH0UpGeWeQjj9qkPhsCQex5dp5zI7Y8+I2rfg=;
        b=A+k6FHmWfO89Sb5f8z6C9E8rhhRFYs55TecOQRPuyQXwAnUmsma5QkkmFh8MxdNJLg
         pwupPv8WyVjige0F1GRlGHORrz2pGUeNBPLb9GZwOBpgc6HeU5jMEGTAkyvdyxBW/oGl
         fgKNDuomfN2z2JNmPFS62yQeEClyAHFgVtW3CWMDxA1mxX4+7+X/FZQMMmYgY5y6AVf6
         wN72jNzm4Fr9jfc/K/wPm+EAixPyGaxTQtSEVKfs3LpMnmU4igkkE5EEVDHfZq7KTxsF
         BmrCdbQiKM3uqsShavsnep6DpHTwCy/m/LBwF7bVaP5q24s2fH0Nk0DpoKtFJftg+bhA
         rRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749893238; x=1750498038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUaqaUgH0UpGeWeQjj9qkPhsCQex5dp5zI7Y8+I2rfg=;
        b=kVCn5E1wMJd7MLEILiYmGeaSrtOLEnZdaDDgMaaOi+y6x+iVtluMidgmxJ9vyuOENI
         dlP3PFg0/jz8w3wzGTkOGCH/vrNjyO1I/4FpvhUx6tyuNaYzA1oj2CyvCcwExvT3YD5Z
         GTgtFidQrKFPFG8xMreYk32PV5KhtuyEJcgf+SMNZ3hpFokzq77seOfrhzBtRuv+P+VE
         FtjlEDAPJgh8Kc/05cKu/MQ6u5tkrD+x3H95GxdkM6hXWnHLeS7O8UGcdsGBn42aFGG/
         Nutroi2DK1s5oqWZT4O7X2JhrAdzex10cGbEV7txzfQr5xETBSRv68ldX4Y7V3d3MHn+
         V+tA==
X-Forwarded-Encrypted: i=1; AJvYcCUMGHGlbMmy9Deiinv9tNmJMm1hMGf3hTUKEmjb1ymcYlUTPn0yosRgCnLHiJ+C+f+faXh3aCNU8tA=@vger.kernel.org, AJvYcCUNRd62HDWbr5XpExIRHVewxwTiw/pe7IRE11UYKo2y3vWfGv21t9cVh0OrsSojONGIgdzcWWUx68ntJSkp@vger.kernel.org, AJvYcCWlG5BLQzH3y8eR0EU8S/dF0E9o4zMrqWrSgNFNLbSwXi93WFuZwNEK4/Fmcqc54XULRL8g4Og2@vger.kernel.org
X-Gm-Message-State: AOJu0YxndJERXaVuXLuJKbffRHBYGOye9idVxBbOYiEV2JRw3aRpDB21
	NNMO4zbHwLjBpMByHxJeFEivi31J+M/85PVLxPyh98AjMJUu+dO8KFWb
X-Gm-Gg: ASbGncuGsac1gH35SlxHvG4ThtMbxXYERe/Bbwb2JgpxAHCE37TL/OiMlmM/wpJHfER
	iFRweKe+UFTfyUzMuE341/6/1xFFawsIGBEW086jPZCiBuPj1HV+WfOlkcfB0Wzmw4VfNyxgOQk
	D7KSdOrb/LjqOBb2O8EYdNcJvP7OZ8hbJRHC8ABmpuuWh9o+Wtm19K/Rtn+vxu99KXlE/N45pf4
	E9g0zSZPVjmWYCJIkCDyrye7saLzWlZGwE/tfl/go2JnObpe5kdQCbks/lAnmkwrqG583g6n3nc
	tsXLuylUzoWaQUoZ4XlCZEu87H/GrIftrzGCi58Zgkf2l5i6JAdGRvZrqg1+FErGgum6CYaFF4T
	76k/7LzmrTo0WF4NLidXLfJc=
X-Google-Smtp-Source: AGHT+IEfK2VfdfII4a8PmobQm62IARGV9PWo2PsX1rgO8gX9H/p2lHjac8gP+KLtjqM/7XwoJuYptg==
X-Received: by 2002:a05:600c:3494:b0:442:fac9:5e2f with SMTP id 5b1f17b1804b1-4533ca4b453mr10177735e9.2.1749893238049;
        Sat, 14 Jun 2025 02:27:18 -0700 (PDT)
Received: from localhost.localdomain ([154.182.223.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532ddd29ffsm77545825e9.0.2025.06.14.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 02:27:17 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: abdelrahmanfekry375@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.com
Subject: [PATCH v2 1/2] docs: net: sysctl documentation cleanup
Date: Sat, 14 Jun 2025 12:25:42 +0300
Message-Id: <20250614092542.66138-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
References: <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Deleted space before colon for consistency
- Standardized more boolean representation (0/1 with enabled/disabled)

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 47 ++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 0f1251cce314..68778532faa5 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -8,14 +8,16 @@ IP Sysctl
 ==============================
 
 ip_forward - BOOLEAN
-	- 0 - disabled (default)
-	- not 0 - enabled
+	- 0 (disabled)
+	- not 0 (enabled)
 
 	Forward Packets between interfaces.
 
 	This variable is special, its change resets all configuration
 	parameters to their default state (RFC1122 for hosts, RFC1812
 	for routers)
+
+	Default: 0 (disabled)
 
 ip_default_ttl - INTEGER
 	Default value of TTL field (Time To Live) for outgoing (but not
@@ -75,7 +77,7 @@ fwmark_reflect - BOOLEAN
 	If unset, these packets have a fwmark of zero. If set, they have the
 	fwmark of the packet they are replying to.
 
-	Default: 0
+	Default: 0 (disabled)
 
 fib_multipath_use_neigh - BOOLEAN
 	Use status of existing neighbor entry when determining nexthop for
@@ -368,7 +370,7 @@ tcp_autocorking - BOOLEAN
 	queue. Applications can still use TCP_CORK for optimal behavior
 	when they know how/when to uncork their sockets.
 
-	Default : 1
+	Default: 1 (enabled)
 
 tcp_available_congestion_control - STRING
 	Shows the available congestion control choices that are registered.
@@ -407,6 +409,12 @@ tcp_congestion_control - STRING
 
 tcp_dsack - BOOLEAN
 	Allows TCP to send "duplicate" SACKs.
+
+	Possible values:
+		- 0 (disabled)
+		- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_early_retrans - INTEGER
 	Tail loss probe (TLP) converts RTOs occurring due to tail
@@ -623,6 +631,8 @@ tcp_no_metrics_save - BOOLEAN
 	increases overall performance, but may sometimes cause performance
 	degradation.  If set, TCP will not cache metrics on closing
 	connections.
+
+	Default: 0 (disabled)
 
 tcp_no_ssthresh_metrics_save - BOOLEAN
 	Controls whether TCP saves ssthresh metrics in the route cache.
@@ -684,6 +694,8 @@ tcp_retrans_collapse - BOOLEAN
 	Bug-to-bug compatibility with some broken printers.
 	On retransmit try to send bigger packets to work around bugs in
 	certain TCP stacks.
+
+	Default: 1 (enabled)
 
 tcp_retries1 - INTEGER
 	This value influences the time, after which TCP decides, that
@@ -739,6 +751,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 
 tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
+
+	Default: 1 (enabled)
 
 tcp_comp_sack_delay_ns - LONG INTEGER
 	TCP tries to reduce number of SACK sent, using a timer
@@ -766,7 +780,7 @@ tcp_backlog_ack_defer - BOOLEAN
 	one ACK for the whole queue. This helps to avoid potential
 	long latencies at end of a TCP socket syscall.
 
-	Default : true
+	Default: 1 (enabled)
 
 tcp_slow_start_after_idle - BOOLEAN
 	If set, provide RFC2861 behavior and time out the congestion
@@ -781,7 +795,7 @@ tcp_stdurg - BOOLEAN
 	Most hosts use the older BSD interpretation, so if you turn this on
 	Linux might not communicate correctly with them.
 
-	Default: FALSE
+	Default: 0 (disabled)
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
@@ -1018,6 +1032,10 @@ tcp_tw_reuse_delay - UNSIGNED INTEGER
 
 tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
 
 tcp_shrink_window - BOOLEAN
 	This changes how the TCP receive window is calculated.
@@ -1160,7 +1178,7 @@ tcp_plb_enabled - BOOLEAN
 	congestion measure (e.g. ce_ratio). PLB needs a congestion measure to
 	make repathing decisions.
 
-	Default: FALSE
+	Default: 0 (disabled)
 
 tcp_plb_idle_rehash_rounds - INTEGER
 	Number of consecutive congested rounds (RTT) seen after which
@@ -1352,7 +1370,7 @@ cipso_rbm_optfmt - BOOLEAN
 
 	Default: 0
 
-cipso_rbm_structvalid - BOOLEAN
+cipso_rbm_strictvalid - BOOLEAN
 	If set, do a very strict check of the CIPSO option when
 	ip_options_compile() is called.  If unset, relax the checks done during
 	ip_options_compile().  Either way is "safe" as errors are caught else
@@ -1543,7 +1561,7 @@ icmp_ignore_bogus_error_responses - BOOLEAN
 	If this is set to TRUE, the kernel will not give such warnings, which
 	will avoid log file clutter.
 
-	Default: 1
+	Default: 1 (enabled)
 
 icmp_errors_use_inbound_ifaddr - BOOLEAN
 
@@ -1560,7 +1578,7 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
 	then the primary address of the first non-loopback interface that
 	has one will be used regardless of this setting.
 
-	Default: 0
+	Default: 0 (disabled)
 
 igmp_max_memberships - INTEGER
 	Change the maximum number of multicast groups we can subscribe to.
@@ -1933,10 +1951,15 @@ mcast_resolicit - INTEGER
 
 disable_policy - BOOLEAN
 	Disable IPSEC policy (SPD) for this interface
+
+	Default: 0
+
 
 disable_xfrm - BOOLEAN
 	Disable IPSEC encryption on this interface, whatever the policy
 
+	Default: 0
+
 igmpv2_unsolicited_report_interval - INTEGER
 	The interval in milliseconds in which the next unsolicited
 	IGMPv1 or IGMPv2 report retransmit will take place.
@@ -1951,11 +1974,15 @@ igmpv3_unsolicited_report_interval - INTEGER
 
 ignore_routes_with_linkdown - BOOLEAN
         Ignore routes whose link is down when performing a FIB lookup.
+
+        Default: 0 (disabled)
 
 promote_secondaries - BOOLEAN
 	When a primary IP address is removed from this interface
 	promote a corresponding secondary IP address instead of
 	removing all the corresponding secondary IP addresses.
+
+	Default: 0 (disabled)
 
 drop_unicast_in_l2_multicast - BOOLEAN
 	Drop any unicast IP packets that are received in link-layer
-- 
2.25.1


