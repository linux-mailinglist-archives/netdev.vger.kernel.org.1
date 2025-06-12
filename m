Return-Path: <netdev+bounces-197112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0948AD7845
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834FF1883FA4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33A2222A6;
	Thu, 12 Jun 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN1XPQ9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A541E5B68;
	Thu, 12 Jun 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745823; cv=none; b=a7fSz2vXBuHnc49ODaUqgvfDYHAPARKQWsxDSWRAFKvFgH6+iMNdqUGvEjzsSTfLarrpBm1hvLzxlTYO/MseyIBefGC4sC0id3w/HOSFFPOTIY1S9H3AAJC6NWmNqDi3uU2tlqCaijGiW3F+I9DfePWdnXShkYs0xBqCMYpNGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745823; c=relaxed/simple;
	bh=AjJaai9iEL5xRpPzz41oHvg6cnXsWNmzbO7rx581ebc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaKXVbgXCMQX7bA/GU9OXRHx0xJirQGcbx4jpPTJMdG/0Xnf0nFeDqpOSUBdKIhZvNXfeKcGgSxmazrx701W9+rQNhMqnWzwEeTGQNNV6ErPjH4arIDRUN7qiKG36HPdQjiHX3febh7ah5EiuictXpgr3Yj9FY8bYqCQ7tRu7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN1XPQ9s; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so92341f8f.0;
        Thu, 12 Jun 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749745820; x=1750350620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o0VnVi1dbV9tBOqGAJzI9G91QEofUUU96Z5/r8Hs4o=;
        b=jN1XPQ9sv0cHs7rndSG+Yw5FAqtDez4VYZ5kLskd3aWwkQzEX3s5mWhrv77xR2DJ5v
         2Ec+j15noJ5FHmVfsxift/xBlvorZiWRZIRIAZlfxT1Qqxy5amb8klTgh8VXopfChUk5
         2Hro95IP9QOJkPsPoiO0vLa8iRd5AU7fHZclhSA78g8qaBSC5BxJ4vFVYCmyorngTMcH
         6pUzxXaEbBl0Spse7bpwkfho6ZvPp+9MqsDdxd0Lv+lcnXwdYXn1g4/MHS8tMNa8BFnk
         cZtw2cIAt7k70ze/xNOL2/cVyrZXaMtsZBrCh+djgemGvCvNvb5ZjjgWrKfUdiOlFYG+
         6Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745820; x=1750350620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o0VnVi1dbV9tBOqGAJzI9G91QEofUUU96Z5/r8Hs4o=;
        b=R4Efk5B0GEqYpcxGJuyy8uDTmRpWRdIz1OBnkCPyBDuaFmpEYxtANA0VYc9o8/QKWZ
         wYWiDyORO+fD0GA63jmKoBqJ5SIxMKnq82FghvvwKINNsZpitWFGx/lKrUF0NNQTbILB
         2k+wGhtMvMz6O+BetQxmdE+o92D8AvruKFDnPrXKhFucT7qPq84sbLoQ/WWbdBsicYuC
         mrF6TbEY9Q0atUosQnqzMxjQDd0GfVAEI1Pyeyk5aRx1Xp93nPiwhskpCUj9kPjKddjz
         Y8TftIzXOjLUixLXxpiI+dA9r6u1AkCf7AcnnfmwqbbfAaJUVcUHbA7VcGaaMTBy0DHU
         ufjw==
X-Forwarded-Encrypted: i=1; AJvYcCV28D2taijgkZIizpFBC9DECFcYUVw4QSlCRqKqz+UeA6NWyBBdWaTxNoc47qST4ut//bMsw+Fsq3I/3SSl@vger.kernel.org, AJvYcCWpcwF9ggdTZEuOsGOKKbYidKTQRs28u9hrJ6HGsb2G+NuRhq9gdw4qcldwno8RKQ3oQaDrxa1Tdg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3ASB5x7sRx7+tFog8SzZoMz97ncnArUMQucJpMcu1ijQ4Yah
	YGReZLCIM43p4SbauQ8CPv+pXDSispWzH4KCKud2kXNTvf4ftqdv/dF+
X-Gm-Gg: ASbGncsNwiA4c1C23phodNlsBTSopWWmcgXjs/v3Epw0/hNVwAT6BiLUeUKHoaVBoIG
	NA2utGEk6slHQGxB7NT6UZNDdol9W0GQyIQRfwH7YJGg7SqZM+KL/BSry5Fnp5QHLJzr3yWNk2r
	fiaWzLmzrtYl9e316FyRJQtQTNbNXxWehNEoR7xUnZ5y6NtRA0BhnSVaviKcmIx4O3lSu55EvDm
	zUydR50NmPCdyzDkpMk6C0JX/BQh7UNbmZi1Ad9Ng91utXREs7+O9BkVM+WXoXYrmMdEg7skdlF
	UEOWJSJA3jO3pVKoI4bRxhs2vY2X5L9hZ+DwRnjCWQMvz7J9ShJtPu4wK+emiNeWBU7w93l94rA
	+phxV13b70bfh74/n8iMfDQ==
X-Google-Smtp-Source: AGHT+IGVDuSGJuohJRZKq1esAq8HonbJ3Cbg6ELoq/f8wyb1XeKFRdINfRLFCE32CSQ89UNHD0Og/A==
X-Received: by 2002:a05:6000:2908:b0:3a5:3369:391c with SMTP id ffacd0b85a97d-3a5586b9c38mr2550921f8f.1.1749745819863;
        Thu, 12 Jun 2025 09:30:19 -0700 (PDT)
Received: from localhost.localdomain ([102.40.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e24b0c8sm24872135e9.24.2025.06.12.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:30:19 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.com,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH 2/2] docs: net: clarify sysctl value constraints
Date: Thu, 12 Jun 2025 19:29:54 +0300
Message-Id: <20250612162954.55843-3-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
References: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So, i also noticed that some of the parameters represented
as boolean have no value constrain checks and accept integer
values due to u8 implementation, so i wrote a note for every
boolean parameter that have no constrain checks in code. and
fixed a typo in fmwark instead of fwmark.

Added notes for 19 confirmed parameters,
Verified by code inspection and runtime testing.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 50 +++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f7ff8c53f412..99e786915204 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -68,6 +68,8 @@ ip_forward_use_pmtu - BOOLEAN
 
 	- 0 - disabled
 	- 1 - enabled
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv4 reply packets that are not
@@ -89,6 +91,8 @@ fib_multipath_use_neigh - BOOLEAN
 
 	- 0 - disabled
 	- 1 - enabled
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 fib_multipath_hash_policy - INTEGER
 	Controls which hash policy to use for multipath routes. Only valid
@@ -489,6 +493,8 @@ tcp_fwmark_accept - BOOLEAN
 	unaffected.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_invalid_ratelimit - INTEGER
 	Limit the maximal rate for sending duplicate acknowledgments
@@ -603,6 +609,8 @@ tcp_moderate_rcvbuf - BOOLEAN
 	automatically size the buffer (no greater than tcp_rmem[2]) to
 	match the size required by the path for full throughput.  Enabled by
 	default.
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_mtu_probing - INTEGER
 	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
@@ -636,6 +644,8 @@ tcp_no_ssthresh_metrics_save - BOOLEAN
 	Controls whether TCP saves ssthresh metrics in the route cache.
 
 	Default is 1, which disables ssthresh metrics.
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_orphan_retries - INTEGER
 	This value influences the timeout of a locally closed TCP connection,
@@ -703,7 +713,9 @@ tcp_retries1 - INTEGER
 
 	RFC 1122 recommends at least 3 retransmissions, which is the
 	default.
-
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 tcp_retries2 - INTEGER
 	This value influences the timeout of an alive TCP connection,
 	when RTO retransmissions remain unacknowledged.
@@ -751,6 +763,8 @@ tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 	
 	Default: 1 (enabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_comp_sack_delay_ns - LONG INTEGER
 	TCP tries to reduce number of SACK sent, using a timer
@@ -787,6 +801,8 @@ tcp_slow_start_after_idle - BOOLEAN
 	be timed out after an idle period.
 
 	Default: 1
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_stdurg - BOOLEAN
 	Use the Host requirements interpretation of the TCP urgent pointer field.
@@ -794,6 +810,8 @@ tcp_stdurg - BOOLEAN
 	Linux might not communicate correctly with them.
 
 	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
@@ -1034,6 +1052,8 @@ tcp_window_scaling - BOOLEAN
 	- 1 - Enabled.
 	
 	Default: 1 (enabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_shrink_window - BOOLEAN
 	This changes how the TCP receive window is calculated.
@@ -1049,6 +1069,8 @@ tcp_shrink_window - BOOLEAN
 			scaling factor is also in effect.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_wmem - vector of 3 INTEGERs: min, default, max
 	min: Amount of memory reserved for send buffers for TCP sockets.
@@ -1104,7 +1126,9 @@ tcp_thin_linear_timeouts - BOOLEAN
 	Documentation/networking/tcp-thin.rst
 
 	Default: 0
-
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 tcp_limit_output_bytes - INTEGER
 	Controls TCP Small Queue limit per tcp socket.
 	TCP bulk sender tends to increase packets in flight until it
@@ -1367,6 +1391,9 @@ cipso_rbm_optfmt - BOOLEAN
 	categories in order to make the packet data 32-bit aligned.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 cipso_rbm_strictvalid - BOOLEAN
 	If set, do a very strict check of the CIPSO option when
@@ -1377,6 +1404,9 @@ cipso_rbm_strictvalid - BOOLEAN
 	with other implementations that require strict checking.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 IP Variables
 ============
@@ -1437,6 +1467,9 @@ ip_nonlocal_bind - BOOLEAN
 	which can be quite useful - but may break some applications.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 ip_autobind_reuse - BOOLEAN
 	By default, bind() does not select the ports automatically even if
@@ -1447,6 +1480,8 @@ ip_autobind_reuse - BOOLEAN
 	option should only be set by experts.
 	Default: 0
 
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 ip_dynaddr - INTEGER
 	If set non-zero, enables support for dynamic addresses.
 	If set to a non-zero value larger than 1, a kernel log
@@ -1476,13 +1511,16 @@ tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
 
 	Default: 1
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 udp_early_demux - BOOLEAN
 	Enable early demux for connected UDP sockets. Disable this if
 	your system could experience more unconnected load.
 
 	Default: 1
-
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 icmp_echo_ignore_all - BOOLEAN
 	If set non-zero, then the kernel will ignore all ICMP ECHO
 	requests sent to it.
@@ -1815,7 +1853,7 @@ src_valid_mark - BOOLEAN
 	  lookup.  This permits rp_filter to function when the fwmark is
 	  used for routing traffic in both directions.
 
-	This setting also affects the utilization of fmwark when
+	This setting also affects the utilization of fwmark when
 	performing source address selection for ICMP replies, or
 	determining addresses stored for the IPOPT_TS_TSANDADDR and
 	IPOPT_RR IP options.
@@ -2324,7 +2362,9 @@ fwmark_reflect - BOOLEAN
 	fwmark of the packet they are replying to.
 
 	Default: 0
-
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 ``conf/interface/*``:
 	Change special settings per interface.
 
-- 
2.25.1


