Return-Path: <netdev+bounces-199951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA335AE2838
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66A27A6218
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491851E0E0B;
	Sat, 21 Jun 2025 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD4H0JU1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933171A5B99;
	Sat, 21 Jun 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497602; cv=none; b=KltKQiDe2eyCU6/mjXiKs4gxDNiezsrw0zTdNc8KM4+ApMzNjIRV7Fj544WTNZI73aL6Lt0EsBVuuhsskpFDp9Pe8sR/ul2eqcUX58bdEJG6reaB0IrisxIUKXtBeb3ibbeLjkXVM9p05gIyR2c8sCH2Ijxtbe0ORXQ8rlb0ZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497602; c=relaxed/simple;
	bh=TlJLR5bE/LSEyfqFwlPxAqc2pFp3L5chhoIGe0UhgNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8NtcNK0+KOFg83pHM/xiANgqyNNmRmue9C6CgxScoazHJPSAAm6T3qC7XkyXNyRjWLUK0AOd4B92UusPEQN481tJrpT3cPX+BlQ7DWPOVzQsSMPYyrZYjQrUUCBb4o0OWSoPdos1AamLfBcYQEziUPMUekLPibvZ66Ru4Liud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD4H0JU1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso2088487a91.1;
        Sat, 21 Jun 2025 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750497600; x=1751102400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb2OFSDE2Drj8JB0tU6F+SK9aQFEFXhP1Y8iZqptNjk=;
        b=lD4H0JU1zKKUGAWzw+2QfIsrizl38oLCSrIhGA+lgNUNi5IICHPYEk8xkTsg3PFo2Z
         et/A9f4vN93bfpxFWB9kbutqM9IT2inbPb72Ss1xK0MSveHbTnBZ5CSCkC1YrC0cp7vV
         E0tMDzGnol4jEAXAfI9c6YCUdh4I0Bm+uEgbgTnMyNgeQuIzYzMQ0SgwPKBah56iEboq
         4m2CwzsnRQegdw7i+/UESa9NI0cOBrgHdkd0rDgGZukonMic/FJDQRC2FrhgpDWt8DxZ
         bBCHRwHMb2IOrit1Ww7c7VOi7zFxQPkCyEhXdEf99PXkoMPOlIs3jhIOoweK2Z4U2mbA
         2rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750497600; x=1751102400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb2OFSDE2Drj8JB0tU6F+SK9aQFEFXhP1Y8iZqptNjk=;
        b=nGlP4F4fDa4spsYVUvqlT1Y3nQq3O6oazwmf+5vzzFT+To4Iy7k+5WDlCxyE9BfXaf
         /btaHo8WpZV3h+DfHOItCuvWW57unmki+xXRE/5b9fTtD6SPgOx/wOUNFnqhr83jD66q
         MONsqpVVUNe86Eht3ocJHqGdaRHMwaDjFY1riUBeg3jaR8jh1P125n51fw5K7sbQJHS1
         eq0uNpMGaCD/vg1R7JFll4lzVvyQRwJOUTk/2omnLFztToiw6EJ6b0+TJqYsapbcAkCy
         KeQhsjxR9TwdRWFA5POk4avtFLNkeKwufNX/O0tlOKyidK/q9w0az1fBjGyxzPwrX4Z9
         1JJw==
X-Forwarded-Encrypted: i=1; AJvYcCWSVJ5tgSjwPzADdKpDcjejstuQ++/LBAptXMeQ6au0knmZDiGUXIM3F9Zk0qAPIAI9hctsb45XYDlNESA=@vger.kernel.org, AJvYcCWVonUahPIsRNxfXFR+ZbfEQX9z2X1O60odd6ip8aQw8fbAZ5crkzWL9vxhE30sxESkuu6N9bAe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7RhHFLo7c7MrXX7JKwJhZmXLND4TBI/9qw/78HntummHKO5H
	Y5L+UoH7UpM8spz7U3FpnWzxk55lBrGyjPFqMKiwgvFwsxqiOm2MoYRq
X-Gm-Gg: ASbGncvjrXqcfBUqQOglD654bIgdrWCY5h3NaqJ3zmjgzx5zh4S1BRQYEWwt0nuziOY
	YVvIrx6KiBceQ3A/EzuDEHb2JqMchHRy8Ptz+6TwaouxSGduO/V22N2r+WbRm3F3+E6mBvTi71x
	j7xtp4O2biYj4G932/kSp7TU+oJ+uvRpZTH5LyPUFmd8V/9f6C0NoapaxWn7UT5aDfWPiP0X3Ox
	/TWlr5GIOjuHH3tPnRU87La44f3Cz+Gu++u45fkXXtgKgP0FtDNFLmYAl3Fu21JLgLs9aBFmSkw
	dEtUoFw+G7eo/3DsAyolq9NDysBymvXLIkx0MWU2xQwn9ivVp0jpVYrWV6829g==
X-Google-Smtp-Source: AGHT+IG7BlAgeNt15LoNBTGF+uLERbEgVKWD0uxp4y5YChdeGXj1JFCxW0uLE3Hzps/4ZmMXA/qHFQ==
X-Received: by 2002:a17:90b:1dc7:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-3159d8fe239mr7708289a91.32.1750497599534;
        Sat, 21 Jun 2025 02:19:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e190sm6059930a91.13.2025.06.21.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 02:19:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EAA784207D0B; Sat, 21 Jun 2025 16:19:54 +0700 (WIB)
Date: Sat, 21 Jun 2025 16:19:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, pabeni@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.com, jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH net-next v3] docs: net: sysctl documentation cleanup
Message-ID: <aFZ5OhP3Ci5KzOff@archie.me>
References: <20250620215542.153440-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620215542.153440-1-abdelrahmanfekry375@gmail.com>

On Sat, Jun 21, 2025 at 12:55:42AM +0300, Abdelrahman Fekry wrote:
> +	Possible values:
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)

I see boolean lists as normal paragraph instead, so I have to separate
them:

---- >8 ----
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index edf4b22535e40b..4cc9f0aacf6418 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -15,6 +15,7 @@ ip_forward - BOOLEAN
 	for routers)
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -66,6 +67,7 @@ ip_forward_use_pmtu - BOOLEAN
 	case.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -78,6 +80,7 @@ fwmark_reflect - BOOLEAN
 	fwmark of the packet they are replying to.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -90,6 +93,7 @@ fib_multipath_use_neigh - BOOLEAN
 	built with CONFIG_IP_ROUTE_MULTIPATH enabled.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -374,6 +378,7 @@ tcp_autocorking - BOOLEAN
 	when they know how/when to uncork their sockets.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -418,6 +423,7 @@ tcp_dsack - BOOLEAN
 	Allows TCP to send "duplicate" SACKs.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -463,6 +469,7 @@ tcp_ecn_fallback - BOOLEAN
 	control) ECN settings are disabled.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -502,6 +509,7 @@ tcp_fwmark_accept - BOOLEAN
 	unaffected.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -552,6 +560,7 @@ tcp_l3mdev_accept - BOOLEAN
 	compiled with CONFIG_NET_L3_MASTER_DEV.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -625,6 +634,7 @@ tcp_moderate_rcvbuf - BOOLEAN
 	match the size required by the path for full throughput.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -657,6 +667,7 @@ tcp_no_metrics_save - BOOLEAN
 	connections.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -667,6 +678,7 @@ tcp_no_ssthresh_metrics_save - BOOLEAN
 	If enabled, ssthresh metrics are disabled.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -710,6 +722,7 @@ tcp_reflect_tos - BOOLEAN
 	This options affects both IPv4 and IPv6.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -735,6 +748,7 @@ tcp_retrans_collapse - BOOLEAN
 	certain TCP stacks.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -772,6 +786,7 @@ tcp_rfc1337 - BOOLEAN
 	assassination.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -800,6 +815,7 @@ tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -832,6 +848,7 @@ tcp_backlog_ack_defer - BOOLEAN
 	long latencies at end of a TCP socket syscall.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -844,6 +861,7 @@ tcp_slow_start_after_idle - BOOLEAN
 	be timed out after an idle period.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -855,6 +873,7 @@ tcp_stdurg - BOOLEAN
 	Linux might not communicate correctly with them.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -916,6 +935,7 @@ tcp_migrate_req - BOOLEAN
 	disable this option.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1101,6 +1121,7 @@ tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1113,12 +1134,13 @@ tcp_shrink_window - BOOLEAN
 	window can be offered, and that TCP implementations MUST ensure
 	that they handle a shrinking window, as specified in RFC 1122.
 
-	Possible values
-	- 0 (disabled)	The window is never shrunk.
-	- 1 (enabled)	The window is shrunk when necessary to remain within
-			the memory limit set by autotuning (sk_rcvbuf).
-			This only occurs if a non-zero receive window
-			scaling factor is also in effect.
+	Possible values:
+
+	- 0 (disabled): The window is never shrunk.
+	- 1 (enabled): The window is shrunk when necessary to remain within
+	  the memory limit set by autotuning (sk_rcvbuf).
+	  This only occurs if a non-zero receive window
+	  scaling factor is also in effect.
 
 	Default: 0 (disabled)
 
@@ -1163,6 +1185,7 @@ tcp_workaround_signed_windows - BOOLEAN
 	not receive a window scaling option from them.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1180,6 +1203,7 @@ tcp_thin_linear_timeouts - BOOLEAN
 	Documentation/networking/tcp-thin.rst
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1257,6 +1281,7 @@ tcp_plb_enabled - BOOLEAN
 	make repathing decisions.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1361,6 +1386,7 @@ udp_l3mdev_accept - BOOLEAN
 	CONFIG_NET_L3_MASTER_DEV.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1425,6 +1451,7 @@ raw_l3mdev_accept - BOOLEAN
 	CONFIG_NET_L3_MASTER_DEV.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1441,6 +1468,7 @@ cipso_cache_enable - BOOLEAN
 	off and the cache will always be "safe".
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1463,6 +1491,7 @@ cipso_rbm_optfmt - BOOLEAN
 	categories in order to make the packet data 32-bit aligned.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1477,6 +1506,7 @@ cipso_rbm_strictvalid - BOOLEAN
 	with other implementations that require strict checking.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1541,6 +1571,7 @@ ip_nonlocal_bind - BOOLEAN
 	which can be quite useful - but may break some applications.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1555,6 +1586,7 @@ ip_autobind_reuse - BOOLEAN
 	option should only be set by experts.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1577,6 +1609,7 @@ ip_early_demux - BOOLEAN
 	reduces overall throughput, in such case you should disable it.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1593,6 +1626,7 @@ tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1603,6 +1637,7 @@ udp_early_demux - BOOLEAN
 	your system could experience more unconnected load.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1613,6 +1648,7 @@ icmp_echo_ignore_all - BOOLEAN
 	requests sent to it.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1623,6 +1659,7 @@ icmp_echo_enable_probe - BOOLEAN
         requests sent to it.
 
         Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1633,6 +1670,7 @@ icmp_echo_ignore_broadcasts - BOOLEAN
 	TIMESTAMP requests sent to it via broadcast/multicast.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1697,6 +1735,7 @@ icmp_ignore_bogus_error_responses - BOOLEAN
 	will avoid log file clutter.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -1718,6 +1757,7 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
 	has one will be used regardless of this setting.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2096,6 +2136,7 @@ disable_policy - BOOLEAN
 	Disable IPSEC policy (SPD) for this interface
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2105,6 +2146,7 @@ disable_xfrm - BOOLEAN
 	Disable IPSEC encryption on this interface, whatever the policy
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2126,6 +2168,7 @@ ignore_routes_with_linkdown - BOOLEAN
         Ignore routes whose link is down when performing a FIB lookup.
 
         Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2137,6 +2180,7 @@ promote_secondaries - BOOLEAN
 	removing all the corresponding secondary IP addresses.
 
 	Possible values:
+        
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2150,6 +2194,7 @@ drop_unicast_in_l2_multicast - BOOLEAN
 	1122, but is disabled by default for compatibility reasons.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2161,6 +2206,7 @@ drop_gratuitous_arp - BOOLEAN
 	(or in the case of 802.11, must not be used to prevent attacks.)
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2209,6 +2255,7 @@ bindv6only - BOOLEAN
 	only.
 
 	Possible values:
+
 	- 0 (disabled) - enable IPv4-mapped address feature
 	- 1 (enabled)  - disable IPv4-mapped address feature
 
@@ -2220,6 +2267,7 @@ flowlabel_consistency - BOOLEAN
 	flow label manager.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2250,6 +2298,7 @@ flowlabel_state_ranges - BOOLEAN
 	is reserved for stateless flow labels as described in RFC6437.
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 
@@ -2323,6 +2372,7 @@ anycast_src_echo_reply - BOOLEAN
 	echo reply
 
 	Possible values:
+
 	- 0 (disabled)
 	- 1 (enabled)
 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

