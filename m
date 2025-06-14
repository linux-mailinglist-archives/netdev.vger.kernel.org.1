Return-Path: <netdev+bounces-197847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEAADA04F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0129C18962BD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753D207A25;
	Sat, 14 Jun 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXy/oJ16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2FE20E313;
	Sat, 14 Jun 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749941655; cv=none; b=P7eHjCy55sg8jBZ8bVOfjkUYw79+BkgYZ45s7uVVcGZCYpHiR+1frHfFH4JwHzsm5MepUmivPRjlx/ccuvO6nVY9pmcTJ5cZ/Sz5ot3AYop92agvI3BdbhOOd24NgV88IzuOeE0K8Uof5eLBkWje4Q9nlKzQlOLF/qQTnLTMP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749941655; c=relaxed/simple;
	bh=lN3BpAZoazXqsfOZcneaole++Sjm5m7VSC0L1t8WFk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldkEykaNeMaPT8Ck+e3m9EVZSrJ5wBsaX52P442N9jFvcUKFCBy1vd35FgrX8nvMIYdsP90BYANWI5IVg3BBNEiYP70CPRRcbsru/Jl1D2J7lJ877/Vufd3uRixhljcWTbjqsG2wIAB8RSOCuUjhrKuTO8CURF2vF7YM2XOzMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXy/oJ16; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a577f164c8so81111f8f.2;
        Sat, 14 Jun 2025 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749941652; x=1750546452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSWTfDytlz01KBOuhR0FulJcEEhd6xAGRNsL1vqyiC0=;
        b=fXy/oJ16gsK0kczPJGTii+90awvN+BQQDOg3AkNjxpZ+YB3mFxTrIqtAkktbxTgs0g
         T5u/UyF0eVfVKaR9jQKjhCo/GTObHf56o/hvnKlRuI0kCZmyVvf3HORlf5DjL3JCDz4G
         xz557oR+YKQoXKxZ+GW/NCyh4tDh26cUu91xZ7JpWPoGgWQ4z63HkY0peo5+RfVw8095
         7qSJypDd7IALMM6zLQj0gbB4vwx56yW3a+K2lj7nWXPM5B7rXLLyCYQjkx11dMEe8c8F
         3Hyd15YE45cHfE9mvl3FWZ9NhCBdeUaoq4D65ORTMftKSCb19Rnxh8O6YJ7kyRM3fsOF
         XZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749941652; x=1750546452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSWTfDytlz01KBOuhR0FulJcEEhd6xAGRNsL1vqyiC0=;
        b=IcVwP6zPb9m4ITMv+1hB/xgOy3HEV4+PngNpIlMtHjpwWMINXjw9Gb9LMNS7Ga4GlR
         +B/UNiW5qZQQtMlSMqcAnTRQLszXVOZ+VMm73ZI5t8FZCNFTGUze/fPnl2drvmO5Lwt+
         p9omqKeDnAn2FZ5Grtia/FGmFS4KxszLpSqXP2o+32SuwdDuvTv+F7XOh+zSGP/quYeK
         qRYMMaM8S6acZLYtVWX0hH6oG4uoHAJaoyJnXT61MfH5eUe3sBtgLfAuGiLdbajCEih/
         aSbIL5hvr2KiqYfc6by95TM/M+odcDHQ9QCtyNUujoVsv11jI3LwqynvxIU7590Z6LDl
         Z1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRuagGhBk9D+gBDq2JnqG6xmZnjSY2eBj9VNNPjfP5BF07yi4SbO5yaZDk6X681roBSP5tfYG8wWAjj4=@vger.kernel.org, AJvYcCW+u9efYOwRP+FXHej96vbEaEg6KKzNDQ52IPeBgBLcSvp8GT6WO3fT9wCljbDeakqMHce58w5D@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTZf94GCv7DJ2mVD2pZ0PgTCnHMpG2UwEG6V0ZwhlUCE9EcYh
	ASoTQUksxb4kQBV97HEAyicvsCDqYmlkFOKhKUP5jZKfTOzM8CsneTfYE3uzxRMU
X-Gm-Gg: ASbGncsMHO17q0/5GsV38YGWYeY78z7/rxdvwr6XItDb2lx+PwjsDAAElzazgAxoy9Q
	vB+ArdVWAZID9Wpe5Kq0RFzd+MCaDA5SH+az/+3SoOnFlesjiMFN6D2SkJD9nzmLdUcvw1qli4W
	e2i4NCQx/yIDTnM0YBozYJ3ihkKYTQJR24j99+OyRhm8/ViaslnSTJeAn6zA57sAo92SrkMTRkB
	RZjhXycumVqmRYbEAnilTACBx8xPfkhEJdrMVrSswiNotTGxgmNjCSFA3bZFWViOvkHduYb/X+e
	Q7Bj5bviJrf3pzb9Bcs5SDg5r2f8Pu43AMhtTd3yR1U+SD3M4pcZknH2nnG/avym+v1w29vTlxH
	rNtMRGI6pjCD7IqNTvm2g+jw=
X-Google-Smtp-Source: AGHT+IEGivefzFeBF/gpM090vkeJDJ7Be5fPPQzUEnjIUOcKLBVUCTphVleEfakGeN8J/Q2GNc6Zpw==
X-Received: by 2002:a05:6000:4203:b0:3a3:71fb:7903 with SMTP id ffacd0b85a97d-3a5723abf38mr1386969f8f.10.1749941651560;
        Sat, 14 Jun 2025 15:54:11 -0700 (PDT)
Received: from localhost.localdomain ([154.182.223.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm94897025e9.23.2025.06.14.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 15:54:11 -0700 (PDT)
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
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2 2/2] docs: net: clarify sysctl value constraints
Date: Sun, 15 Jun 2025 01:53:24 +0300
Message-Id: <20250614225324.82810-3-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
References: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
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

- No changes for v2 in this patch , still waiting to be reviewed.
Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
v2:
- No change.
v1:
- Added notes for booleans that accept 0-255 not only 0/1.
 Documentation/networking/ip-sysctl.rst | 70 ++++++++++++++++++++------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 68778532faa5..38f2981290d6 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -70,6 +70,8 @@ ip_forward_use_pmtu - BOOLEAN
 
 	- 0 - disabled
 	- 1 - enabled
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv4 reply packets that are not
@@ -91,6 +93,8 @@ fib_multipath_use_neigh - BOOLEAN
 
 	- 0 - disabled
 	- 1 - enabled
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 fib_multipath_hash_policy - INTEGER
 	Controls which hash policy to use for multipath routes. Only valid
@@ -490,7 +494,9 @@ tcp_fwmark_accept - BOOLEAN
 	have a fwmark set via setsockopt(SOL_SOCKET, SO_MARK, ...) are
 	unaffected.
 
-	Default: 0
+	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_invalid_ratelimit - INTEGER
 	Limit the maximal rate for sending duplicate acknowledgments
@@ -605,6 +611,8 @@ tcp_moderate_rcvbuf - BOOLEAN
 	automatically size the buffer (no greater than tcp_rmem[2]) to
 	match the size required by the path for full throughput.  Enabled by
 	default.
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_mtu_probing - INTEGER
 	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
@@ -638,6 +646,8 @@ tcp_no_ssthresh_metrics_save - BOOLEAN
 	Controls whether TCP saves ssthresh metrics in the route cache.
 
 	Default is 1, which disables ssthresh metrics.
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_orphan_retries - INTEGER
 	This value influences the timeout of a locally closed TCP connection,
@@ -705,7 +715,9 @@ tcp_retries1 - INTEGER
 
 	RFC 1122 recommends at least 3 retransmissions, which is the
 	default.
-
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 tcp_retries2 - INTEGER
 	This value influences the timeout of an alive TCP connection,
 	when RTO retransmissions remain unacknowledged.
@@ -728,7 +740,7 @@ tcp_rfc1337 - BOOLEAN
 	we are not conforming to RFC, but prevent TCP TIME_WAIT
 	assassination.
 
-	Default: 0
+	Default: 0 (disabled)
 
 tcp_rmem - vector of 3 INTEGERs: min, default, max
 	min: Minimal size of receive buffer used by TCP sockets.
@@ -753,6 +765,8 @@ tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 	
 	Default: 1 (enabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_comp_sack_delay_ns - LONG INTEGER
 	TCP tries to reduce number of SACK sent, using a timer
@@ -788,7 +802,9 @@ tcp_slow_start_after_idle - BOOLEAN
 	the current RTO.  If unset, the congestion window will not
 	be timed out after an idle period.
 
-	Default: 1
+	Default: 1 (enabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_stdurg - BOOLEAN
 	Use the Host requirements interpretation of the TCP urgent pointer field.
@@ -796,6 +812,8 @@ tcp_stdurg - BOOLEAN
 	Linux might not communicate correctly with them.
 
 	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
@@ -852,7 +870,7 @@ tcp_migrate_req - BOOLEAN
 	migration by returning SK_DROP in the type of eBPF program, or
 	disable this option.
 
-	Default: 0
+	Default: 0 (disabled)
 
 tcp_fastopen - INTEGER
 	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
@@ -1036,6 +1054,8 @@ tcp_window_scaling - BOOLEAN
 	- 1 - Enabled.
 	
 	Default: 1 (enabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_shrink_window - BOOLEAN
 	This changes how the TCP receive window is calculated.
@@ -1050,7 +1070,9 @@ tcp_shrink_window - BOOLEAN
 			This only occurs if a non-zero receive window
 			scaling factor is also in effect.
 
-	Default: 0
+	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
 
 tcp_wmem - vector of 3 INTEGERs: min, default, max
 	min: Amount of memory reserved for send buffers for TCP sockets.
@@ -1092,7 +1114,7 @@ tcp_workaround_signed_windows - BOOLEAN
 	If unset, assume the remote TCP is not broken even if we do
 	not receive a window scaling option from them.
 
-	Default: 0
+	Default: 0 (disabled)
 
 tcp_thin_linear_timeouts - BOOLEAN
 	Enable dynamic triggering of linear timeouts for thin streams.
@@ -1105,8 +1127,10 @@ tcp_thin_linear_timeouts - BOOLEAN
 	For more information on thin streams, see
 	Documentation/networking/tcp-thin.rst
 
-	Default: 0
-
+	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 tcp_limit_output_bytes - INTEGER
 	Controls TCP Small Queue limit per tcp socket.
 	TCP bulk sender tends to increase packets in flight until it
@@ -1350,7 +1374,7 @@ cipso_cache_enable - BOOLEAN
 	invalidated when required when means you can safely toggle this on and
 	off and the cache will always be "safe".
 
-	Default: 1
+	Default: 1 (enabled)
 
 cipso_cache_bucket_size - INTEGER
 	The CIPSO label cache consists of a fixed size hash table with each
@@ -1368,7 +1392,10 @@ cipso_rbm_optfmt - BOOLEAN
 	This means that when set the CIPSO tag will be padded with empty
 	categories in order to make the packet data 32-bit aligned.
 
-	Default: 0
+	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 cipso_rbm_strictvalid - BOOLEAN
 	If set, do a very strict check of the CIPSO option when
@@ -1378,7 +1405,10 @@ cipso_rbm_strictvalid - BOOLEAN
 	result in less work (i.e. it should be faster) but could cause problems
 	with other implementations that require strict checking.
 
-	Default: 0
+	Default: 0 (disabled)
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 IP Variables
 ============
@@ -1439,6 +1469,9 @@ ip_nonlocal_bind - BOOLEAN
 	which can be quite useful - but may break some applications.
 
 	Default: 0
+
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 
 ip_autobind_reuse - BOOLEAN
 	By default, bind() does not select the ports automatically even if
@@ -1449,6 +1482,8 @@ ip_autobind_reuse - BOOLEAN
 	option should only be set by experts.
 	Default: 0
 
+	note: Accepts integer values (0-255) but only 0/1 have defined behaviour.
+
 ip_dynaddr - INTEGER
 	If set non-zero, enables support for dynamic addresses.
 	If set to a non-zero value larger than 1, a kernel log
@@ -1478,13 +1513,16 @@ tcp_early_demux - BOOLEAN
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
@@ -1817,7 +1855,7 @@ src_valid_mark - BOOLEAN
 	  lookup.  This permits rp_filter to function when the fwmark is
 	  used for routing traffic in both directions.
 
-	This setting also affects the utilization of fmwark when
+	This setting also affects the utilization of fwmark when
 	performing source address selection for ICMP replies, or
 	determining addresses stored for the IPOPT_TS_TSANDADDR and
 	IPOPT_RR IP options.
@@ -2326,7 +2364,9 @@ fwmark_reflect - BOOLEAN
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


