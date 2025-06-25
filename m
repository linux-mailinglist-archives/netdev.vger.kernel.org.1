Return-Path: <netdev+bounces-200947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9CAE7734
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D83A456B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED421E7C23;
	Wed, 25 Jun 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpEXoJBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF251DE4E1;
	Wed, 25 Jun 2025 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833384; cv=none; b=Qpuexy6kdSWEeZYmuXWNqKdBgMXnnP5qiBmO5S73BS3lG++5vH11j4J1DXrKmerM8HbobJ+nU3BLgTGlrCna2FhMxdPpGZ7bt2VviwOsIW9iAVruwwX/dBogBbco/bjbk1nkHINydX8n9xKHOoSBtnF1J/N4x39mV0193k3fh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833384; c=relaxed/simple;
	bh=TiiYQVd5q2nwPB1caTXN61U02Aq0aA8sy8ulz3qlZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhixPJF25/s2kLHs4Ij+kmQ/dWU7TU4u5TPaahvAtpJpbQfNoAGJ+xL3yHWkcUjwv+dbncLAn+mCU62QaKrNbDf2sulgvFBk25XG+VMzzUcMzX8BPnURyky56HnZPmb9VCgAdzVHRJIClUqFTxGtbsdZ1F/DlgXgF5EIEdJcdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpEXoJBL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23508d30142so86763965ad.0;
        Tue, 24 Jun 2025 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750833380; x=1751438180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJbe9cwbvAdxvDjc4yNlP3oT3Q2RHP4uIWWpb/+JpO8=;
        b=fpEXoJBL6JRCqqyi5OuUHa78c8ESYGfzcOE7ZqwYsjRUUgHYeB5sXw4cTx2VqCKal5
         YjbZGC44jlaoMjfzAC+c5KNz9ZfPnS+yVNUo2ww7EAzE7l4psm8XQR1soXPDgp0GfGkP
         TdS5F9KaCGcqj9gEKkMIhu8GMeaWycQben8e7qSzQksQ98O7scM/sS22uyRIaWZqAnPm
         z3GqFcPt1lRwkLm8/g62PJQL7M0hCxqL/i2R0Akn6FLSnOw52NRLAwqJ7rIEqrLJ/8Pf
         c3wOcoG+9rCTrNx2vZYcuUXup2eqdGBjmtycGyyMG/zSFfPmysCeTpoFpfxuaElvbKl0
         1VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750833380; x=1751438180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJbe9cwbvAdxvDjc4yNlP3oT3Q2RHP4uIWWpb/+JpO8=;
        b=D70Oep25HvC8bZqvdsFwFwGL1dio1266ZjTrNZzClRK+KJlPTXMGldGXQcihaJPMxN
         4yhYDJB/1WUFedmpkFhv9nh3A2rKo3R80yibQxwQ/IEGeo1QoRYP38kVXNSuQcmFGrqi
         SJxNGDQInmpfnXl13T3CdIwLpD5OPZcFzz9dFTh0gQCTU/3wb2UBk382ynYtRS+6zpm5
         6yD3E2K0ZmBMiLBMH+/DMEdZwRhPu91ZAsGtppRLaIN3r8zH0ejiMfAjC2pGfIsbn82i
         UKaYv519bpKNqbEN2F5kx8UJt257MVMzTq19aQwXEubxclSTXXMlMd3WlszidPe9eA1I
         YXSw==
X-Forwarded-Encrypted: i=1; AJvYcCUQYUmXiIZMFehhtEzuMbYPrD49GFI0kj1A1/UFs7ZCAH4Oe32TaqYCNSnzE4uxmVMf7bFbbJw1I3ABjgM=@vger.kernel.org, AJvYcCXWxDYT6q95WusDUrMr9EPxcsijjD5BEe1KWbYowQwBPqPkRj1AZOef8LOmPTMaIuES3PBINJj6@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsVXIsHoDpaO79maQ6X900rRtFqhHJnAg4HPkZTgpyN+kMR+H
	adbiG5ktzffnlMftIZFql8SfiE4hKi1q4ySabz+D+PWboNZu4LKNM6Q+
X-Gm-Gg: ASbGncvta68TJcYedGnmCc+Hx7wj1/FuNdZjDMgk8dh3YKvHvjpMXur9uGY7mg5akQg
	ohngAgm4ZUz4Mm2nmj4sw7RJrH+36/LtTABoHcXSHyQGgFLiWP8V2S7soAmzoORls3hpRxmS80k
	lNB5JAjCFNW5z9xVBBcVmRx9wgIVmzwuO2qs0FkFsJc+x8KAVHYKdjOdhXc4+c8eGDDlKgTP35G
	f3/66+A1TJKXcy9Y8DnlNr1vGMGECQ8qJsAOY1hC951JGG2KAjsFFyIhSa+IDOZ3/o2YpXtpCj0
	s6GIX9vDVMDW5d3f/Mtammt7FX7BqThZn/47lFhgySvGvss3cWVnJ+ZkPm7Riw==
X-Google-Smtp-Source: AGHT+IHKpBdCB6A1ZYHFswXeR3u3s/fIe597YmTtAHLjDnjrTfbQHLrzC0uubY2sTtaj63dWuRVSLw==
X-Received: by 2002:a17:903:2282:b0:234:9fea:ec5f with SMTP id d9443c01a7336-23823f92191mr36713805ad.1.1750833379559;
        Tue, 24 Jun 2025 23:36:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695195sm128002425ad.187.2025.06.24.23.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 23:36:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 83DE44207D12; Wed, 25 Jun 2025 13:36:16 +0700 (WIB)
Date: Wed, 25 Jun 2025 13:36:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, pabeni@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.com, jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH net-next v6] docs: net: sysctl documentation cleanup
Message-ID: <aFuY4Ms6VDbDDldd@archie.me>
References: <20250624150923.40590-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vDl/jpiPu+gdLWq"
Content-Disposition: inline
In-Reply-To: <20250624150923.40590-1-abdelrahmanfekry375@gmail.com>


--9vDl/jpiPu+gdLWq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 06:09:23PM +0300, Abdelrahman Fekry wrote:
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 466bc3f5186e..9af5a8935d57 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -8,15 +8,19 @@ IP Sysctl
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
>  ip_forward - BOOLEAN
> -	- 0 - disabled (default)
> -	- not 0 - enabled
> -
>  	Forward Packets between interfaces.
> =20
>  	This variable is special, its change resets all configuration
>  	parameters to their default state (RFC1122 for hosts, RFC1812
>  	for routers)
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  ip_default_ttl - INTEGER
>  	Default value of TTL field (Time To Live) for outgoing (but not
>  	forwarded) IP packets. Should be between 1 and 255 inclusive.
> @@ -62,20 +66,25 @@ ip_forward_use_pmtu - BOOLEAN
>  	kernel honoring this information. This is normally not the
>  	case.
> =20
> -	Default: 0 (disabled)
> -
>  	Possible values:
> =20
> -	- 0 - disabled
> -	- 1 - enabled
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  fwmark_reflect - BOOLEAN
>  	Controls the fwmark of kernel-generated IPv4 reply packets that are not
>  	associated with a socket for example, TCP RSTs or ICMP echo replies).
> -	If unset, these packets have a fwmark of zero. If set, they have the
> +	If disabled, these packets have a fwmark of zero. If enabled, they have=
 the
>  	fwmark of the packet they are replying to.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  fib_multipath_use_neigh - BOOLEAN
>  	Use status of existing neighbor entry when determining nexthop for
> @@ -83,12 +92,12 @@ fib_multipath_use_neigh - BOOLEAN
>  	packets could be directed to a failed nexthop. Only valid for kernels
>  	built with CONFIG_IP_ROUTE_MULTIPATH enabled.
> =20
> -	Default: 0 (disabled)
> -
>  	Possible values:
> =20
> -	- 0 - disabled
> -	- 1 - enabled
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  fib_multipath_hash_policy - INTEGER
>  	Controls which hash policy to use for multipath routes. Only valid
> @@ -368,7 +377,12 @@ tcp_autocorking - BOOLEAN
>  	queue. Applications can still use TCP_CORK for optimal behavior
>  	when they know how/when to uncork their sockets.
> =20
> -	Default : 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_available_congestion_control - STRING
>  	Shows the available congestion control choices that are registered.
> @@ -408,6 +422,13 @@ tcp_congestion_control - STRING
>  tcp_dsack - BOOLEAN
>  	Allows TCP to send "duplicate" SACKs.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> +
>  tcp_early_retrans - INTEGER
>  	Tail loss probe (TLP) converts RTOs occurring due to tail
>  	losses into fast recovery (draft-ietf-tcpm-rack). Note that
> @@ -447,7 +468,12 @@ tcp_ecn_fallback - BOOLEAN
>  	knob. The value	is not used, if tcp_ecn or per route (or congestion
>  	control) ECN settings are disabled.
> =20
> -	Default: 1 (fallback enabled)
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_fack - BOOLEAN
>  	This is a legacy option, it has no effect anymore.
> @@ -474,7 +500,7 @@ tcp_frto - INTEGER
>  	By default it's enabled with a non-zero value. 0 disables F-RTO.
> =20
>  tcp_fwmark_accept - BOOLEAN
> -	If set, incoming connections to listening sockets that do not have a
> +	If enabled, incoming connections to listening sockets that do not have a
>  	socket mark will set the mark of the accepting socket to the fwmark of
>  	the incoming SYN packet. This will cause all packets on that connection
>  	(starting from the first SYNACK) to be sent with that fwmark. The
> @@ -482,7 +508,12 @@ tcp_fwmark_accept - BOOLEAN
>  	have a fwmark set via setsockopt(SOL_SOCKET, SO_MARK, ...) are
>  	unaffected.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_invalid_ratelimit - INTEGER
>  	Limit the maximal rate for sending duplicate acknowledgments
> @@ -528,6 +559,11 @@ tcp_l3mdev_accept - BOOLEAN
>  	which the packets originated. Only valid when the kernel was
>  	compiled with CONFIG_NET_L3_MASTER_DEV.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
>  	Default: 0 (disabled)
> =20
>  tcp_low_latency - BOOLEAN
> @@ -593,10 +629,16 @@ tcp_min_rtt_wlen - INTEGER
>  	Default: 300
> =20
>  tcp_moderate_rcvbuf - BOOLEAN
> -	If set, TCP performs receive buffer auto-tuning, attempting to
> +	If enabled, TCP performs receive buffer auto-tuning, attempting to
>  	automatically size the buffer (no greater than tcp_rmem[2]) to
> -	match the size required by the path for full throughput.  Enabled by
> -	default.
> +	match the size required by the path for full throughput.
> +
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_mtu_probing - INTEGER
>  	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
> @@ -621,13 +663,26 @@ tcp_no_metrics_save - BOOLEAN
>  	when the connection closes, so that connections established in the
>  	near future can use these to set initial conditions.  Usually, this
>  	increases overall performance, but may sometimes cause performance
> -	degradation.  If set, TCP will not cache metrics on closing
> +	degradation.  If enabled, TCP will not cache metrics on closing
>  	connections.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  tcp_no_ssthresh_metrics_save - BOOLEAN
>  	Controls whether TCP saves ssthresh metrics in the route cache.
> +	If enabled, ssthresh metrics are disabled.
> +
> +	Possible values:
> =20
> -	Default is 1, which disables ssthresh metrics.
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_orphan_retries - INTEGER
>  	This value influences the timeout of a locally closed TCP connection,
> @@ -666,6 +721,11 @@ tcp_reflect_tos - BOOLEAN
> =20
>  	This options affects both IPv4 and IPv6.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
>  	Default: 0 (disabled)
> =20
>  tcp_reordering - INTEGER
> @@ -687,6 +747,13 @@ tcp_retrans_collapse - BOOLEAN
>  	On retransmit try to send bigger packets to work around bugs in
>  	certain TCP stacks.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> +
>  tcp_retries1 - INTEGER
>  	This value influences the time, after which TCP decides, that
>  	something is wrong due to unacknowledged RTO retransmissions,
> @@ -714,11 +781,16 @@ tcp_retries2 - INTEGER
>  	which corresponds to a value of at least 8.
> =20
>  tcp_rfc1337 - BOOLEAN
> -	If set, the TCP stack behaves conforming to RFC1337. If unset,
> +	If enabled, the TCP stack behaves conforming to RFC1337. If unset,
>  	we are not conforming to RFC, but prevent TCP TIME_WAIT
>  	assassination.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_rmem - vector of 3 INTEGERs: min, default, max
>  	min: Minimal size of receive buffer used by TCP sockets.
> @@ -742,6 +814,13 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
>  tcp_sack - BOOLEAN
>  	Enable select acknowledgments (SACKS).
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> +
>  tcp_comp_sack_delay_ns - LONG INTEGER
>  	TCP tries to reduce number of SACK sent, using a timer
>  	based on 5% of SRTT, capped by this sysctl, in nano seconds.
> @@ -764,26 +843,41 @@ tcp_comp_sack_nr - INTEGER
>  	Default : 44
> =20
>  tcp_backlog_ack_defer - BOOLEAN
> -	If set, user thread processing socket backlog tries sending
> +	If enabled, user thread processing socket backlog tries sending
>  	one ACK for the whole queue. This helps to avoid potential
>  	long latencies at end of a TCP socket syscall.
> =20
> -	Default : true
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_slow_start_after_idle - BOOLEAN
> -	If set, provide RFC2861 behavior and time out the congestion
> +	If enabled, provide RFC2861 behavior and time out the congestion
>  	window after an idle period.  An idle period is defined at
>  	the current RTO.  If unset, the congestion window will not
>  	be timed out after an idle period.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  tcp_stdurg - BOOLEAN
>  	Use the Host requirements interpretation of the TCP urgent pointer fiel=
d.
> -	Most hosts use the older BSD interpretation, so if you turn this on
> +	Most hosts use the older BSD interpretation, so if enabled,
>  	Linux might not communicate correctly with them.
> =20
> -	Default: FALSE
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_synack_retries - INTEGER
>  	Number of times SYNACKs for a passive TCP connection attempt will
> @@ -840,7 +934,12 @@ tcp_migrate_req - BOOLEAN
>  	migration by returning SK_DROP in the type of eBPF program, or
>  	disable this option.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_fastopen - INTEGER
>  	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
> @@ -1021,6 +1120,13 @@ tcp_tw_reuse_delay - UNSIGNED INTEGER
>  tcp_window_scaling - BOOLEAN
>  	Enable window scaling as defined in RFC1323.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> +
>  tcp_shrink_window - BOOLEAN
>  	This changes how the TCP receive window is calculated.
> =20
> @@ -1028,13 +1134,15 @@ tcp_shrink_window - BOOLEAN
>  	window can be offered, and that TCP implementations MUST ensure
>  	that they handle a shrinking window, as specified in RFC 1122.
> =20
> -	- 0 - Disabled.	The window is never shrunk.
> -	- 1 - Enabled.	The window is shrunk when necessary to remain within
> -			the memory limit set by autotuning (sk_rcvbuf).
> -			This only occurs if a non-zero receive window
> -			scaling factor is also in effect.
> +	Possible values:
> =20
> -	Default: 0
> +	- 0 (disabled) - The window is never shrunk.
> +	- 1 (enabled)  - The window is shrunk when necessary to remain within
> +	  the memory limit set by autotuning (sk_rcvbuf).
> +	  This only occurs if a non-zero receive window
> +	  scaling factor is also in effect.
> +
> +	Default: 0 (disabled)
> =20
>  tcp_wmem - vector of 3 INTEGERs: min, default, max
>  	min: Amount of memory reserved for send buffers for TCP sockets.
> @@ -1071,16 +1179,21 @@ tcp_notsent_lowat - UNSIGNED INTEGER
>  	Default: UINT_MAX (0xFFFFFFFF)
> =20
>  tcp_workaround_signed_windows - BOOLEAN
> -	If set, assume no receipt of a window scaling option means the
> +	If enabled, assume no receipt of a window scaling option means the
>  	remote TCP is broken and treats the window as a signed quantity.
> -	If unset, assume the remote TCP is not broken even if we do
> +	If disabled, assume the remote TCP is not broken even if we do
>  	not receive a window scaling option from them.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_thin_linear_timeouts - BOOLEAN
>  	Enable dynamic triggering of linear timeouts for thin streams.
> -	If set, a check is performed upon retransmission by timeout to
> +	If enabled, a check is performed upon retransmission by timeout to
>  	determine if the stream is thin (less than 4 packets in flight).
>  	As long as the stream is found to be thin, up to 6 linear
>  	timeouts may be performed before exponential backoff mode is
> @@ -1089,7 +1202,12 @@ tcp_thin_linear_timeouts - BOOLEAN
>  	For more information on thin streams, see
>  	Documentation/networking/tcp-thin.rst
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_limit_output_bytes - INTEGER
>  	Controls TCP Small Queue limit per tcp socket.
> @@ -1141,7 +1259,7 @@ tcp_child_ehash_entries - INTEGER
>  	Default: 0
> =20
>  tcp_plb_enabled - BOOLEAN
> -	If set and the underlying congestion control (e.g. DCTCP) supports
> +	If enabled and the underlying congestion control (e.g. DCTCP) supports
>  	and enables PLB feature, TCP PLB (Protective Load Balancing) is
>  	enabled. PLB is described in the following paper:
>  	https://doi.org/10.1145/3544216.3544226. Based on PLB parameters,
> @@ -1157,12 +1275,17 @@ tcp_plb_enabled - BOOLEAN
>  	by switches to determine next hop. In either case, further host
>  	and switch side changes will be needed.
> =20
> -	When set, PLB assumes that congestion signal (e.g. ECN) is made
> +	If enabled, PLB assumes that congestion signal (e.g. ECN) is made
>  	available and used by congestion control module to estimate a
>  	congestion measure (e.g. ce_ratio). PLB needs a congestion measure to
>  	make repathing decisions.
> =20
> -	Default: FALSE
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  tcp_plb_idle_rehash_rounds - INTEGER
>  	Number of consecutive congested rounds (RTT) seen after which
> @@ -1262,6 +1385,11 @@ udp_l3mdev_accept - BOOLEAN
>  	originated. Only valid when the kernel was compiled with
>  	CONFIG_NET_L3_MASTER_DEV.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
>  	Default: 0 (disabled)
> =20
>  udp_mem - vector of 3 INTEGERs: min, pressure, max
> @@ -1322,19 +1450,29 @@ raw_l3mdev_accept - BOOLEAN
>  	originated. Only valid when the kernel was compiled with
>  	CONFIG_NET_L3_MASTER_DEV.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
>  	Default: 1 (enabled)
> =20
>  CIPSOv4 Variables
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  cipso_cache_enable - BOOLEAN
> -	If set, enable additions to and lookups from the CIPSO label mapping
> -	cache.  If unset, additions are ignored and lookups always result in a
> +	If enabled, enable additions to and lookups from the CIPSO label mapping
> +	cache.  If disabled, additions are ignored and lookups always result in=
 a
>  	miss.  However, regardless of the setting the cache is still
>  	invalidated when required when means you can safely toggle this on and
>  	off and the cache will always be "safe".
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  cipso_cache_bucket_size - INTEGER
>  	The CIPSO label cache consists of a fixed size hash table with each
> @@ -1352,17 +1490,27 @@ cipso_rbm_optfmt - BOOLEAN
>  	This means that when set the CIPSO tag will be padded with empty
>  	categories in order to make the packet data 32-bit aligned.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
> -cipso_rbm_structvalid - BOOLEAN
> -	If set, do a very strict check of the CIPSO option when
> -	ip_options_compile() is called.  If unset, relax the checks done during
> +cipso_rbm_strictvalid - BOOLEAN
> +	If enabled, do a very strict check of the CIPSO option when
> +	ip_options_compile() is called.  If disabled, relax the checks done dur=
ing
>  	ip_options_compile().  Either way is "safe" as errors are caught else
>  	where in the CIPSO processing code but setting this to 0 (False) should
>  	result in less work (i.e. it should be faster) but could cause problems
>  	with other implementations that require strict checking.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  IP Variables
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -1419,10 +1567,15 @@ ip_unprivileged_port_start - INTEGER
>  	Default: 1024
> =20
>  ip_nonlocal_bind - BOOLEAN
> -	If set, allows processes to bind() to non-local IP addresses,
> +	If enabled, allows processes to bind() to non-local IP addresses,
>  	which can be quite useful - but may break some applications.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  ip_autobind_reuse - BOOLEAN
>  	By default, bind() does not select the ports automatically even if
> @@ -1431,7 +1584,13 @@ ip_autobind_reuse - BOOLEAN
>  	when you use bind()+connect(), but may break some applications.
>  	The preferred solution is to use IP_BIND_ADDRESS_NO_PORT and this
>  	option should only be set by experts.
> -	Default: 0
> +
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  ip_dynaddr - INTEGER
>  	If set non-zero, enables support for dynamic addresses.
> @@ -1449,7 +1608,12 @@ ip_early_demux - BOOLEAN
>  	It may add an additional cost for pure routing workloads that
>  	reduces overall throughput, in such case you should disable it.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  ping_group_range - 2 INTEGERS
>  	Restrict ICMP_PROTO datagram sockets to users in the group range.
> @@ -1461,31 +1625,56 @@ ping_group_range - 2 INTEGERS
>  tcp_early_demux - BOOLEAN
>  	Enable early demux for established TCP sockets.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  udp_early_demux - BOOLEAN
>  	Enable early demux for connected UDP sockets. Disable this if
>  	your system could experience more unconnected load.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  icmp_echo_ignore_all - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO
> +	If enabled, then the kernel will ignore all ICMP ECHO
>  	requests sent to it.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  icmp_echo_enable_probe - BOOLEAN
> -        If set to one, then the kernel will respond to RFC 8335 PROBE
> +        If enabled, then the kernel will respond to RFC 8335 PROBE
>          requests sent to it.
> =20
> -        Default: 0
> +        Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  icmp_echo_ignore_broadcasts - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO and
> +	If enabled, then the kernel will ignore all ICMP ECHO and
>  	TIMESTAMP requests sent to it via broadcast/multicast.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  icmp_ratelimit - INTEGER
>  	Limit the maximal rates for sending ICMP packets whose type matches
> @@ -1542,17 +1731,22 @@ icmp_ratemask - INTEGER
>  icmp_ignore_bogus_error_responses - BOOLEAN
>  	Some routers violate RFC1122 by sending bogus responses to broadcast
>  	frames.  Such violations are normally logged via a kernel warning.
> -	If this is set to TRUE, the kernel will not give such warnings, which
> +	If enabled, the kernel will not give such warnings, which
>  	will avoid log file clutter.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  icmp_errors_use_inbound_ifaddr - BOOLEAN
> =20
> -	If zero, icmp error messages are sent with the primary address of
> +	If disabled, icmp error messages are sent with the primary address of
>  	the exiting interface.
> =20
> -	If non-zero, the message will be sent with the primary address of
> +	If enabled, the message will be sent with the primary address of
>  	the interface that received the packet that caused the icmp error.
>  	This is the behaviour many network administrators will expect from
>  	a router. And it can make debugging complicated network layouts
> @@ -1562,7 +1756,12 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
>  	then the primary address of the first non-loopback interface that
>  	has one will be used regardless of this setting.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  igmp_max_memberships - INTEGER
>  	Change the maximum number of multicast groups we can subscribe to.
> @@ -1912,8 +2111,12 @@ arp_evict_nocarrier - BOOLEAN
>  	between access points on the same network. In most cases this should
>  	remain as the default (1).
> =20
> -	- 1 - (default): Clear the ARP cache on NOCARRIER events
> -	- 0 - Do not clear ARP cache on NOCARRIER events
> +	Possible values:
> +
> +	- 0 (disabled) - Do not clear ARP cache on NOCARRIER events
> +	- 1 (enabled)  - Clear the ARP cache on NOCARRIER events
> +
> +	Default: 1 (enabled)
> =20
>  mcast_solicit - INTEGER
>  	The maximum number of multicast probes in INCOMPLETE state,
> @@ -1936,9 +2139,23 @@ mcast_resolicit - INTEGER
>  disable_policy - BOOLEAN
>  	Disable IPSEC policy (SPD) for this interface
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  disable_xfrm - BOOLEAN
>  	Disable IPSEC encryption on this interface, whatever the policy
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  igmpv2_unsolicited_report_interval - INTEGER
>  	The interval in milliseconds in which the next unsolicited
>  	IGMPv1 or IGMPv2 report retransmit will take place.
> @@ -1954,11 +2171,25 @@ igmpv3_unsolicited_report_interval - INTEGER
>  ignore_routes_with_linkdown - BOOLEAN
>          Ignore routes whose link is down when performing a FIB lookup.
> =20
> +        Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  promote_secondaries - BOOLEAN
>  	When a primary IP address is removed from this interface
>  	promote a corresponding secondary IP address instead of
>  	removing all the corresponding secondary IP addresses.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  drop_unicast_in_l2_multicast - BOOLEAN
>  	Drop any unicast IP packets that are received in link-layer
>  	multicast (or broadcast) frames.
> @@ -1966,14 +2197,24 @@ drop_unicast_in_l2_multicast - BOOLEAN
>  	This behavior (for multicast) is actually a SHOULD in RFC
>  	1122, but is disabled by default for compatibility reasons.
> =20
> -	Default: off (0)
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  drop_gratuitous_arp - BOOLEAN
>  	Drop all gratuitous ARP frames, for example if there's a known
>  	good ARP proxy on the network and such frames need not be used
>  	(or in the case of 802.11, must not be used to prevent attacks.)
> =20
> -	Default: off (0)
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
> =20
>  tag - INTEGER
> @@ -2017,20 +2258,24 @@ bindv6only - BOOLEAN
>  	which restricts use of the IPv6 socket to IPv6 communication
>  	only.
> =20
> -		- TRUE: disable IPv4-mapped address feature
> -		- FALSE: enable IPv4-mapped address feature
> +	Possible values:
> =20
> -	Default: FALSE (as specified in RFC3493)
> +	- 0 (disabled) - enable IPv4-mapped address feature
> +	- 1 (enabled)  - disable IPv4-mapped address feature
> +
> +	Default: 0 (disabled)
> =20
>  flowlabel_consistency - BOOLEAN
>  	Protect the consistency (and unicity) of flow label.
>  	You have to disable it to use IPV6_FL_F_REFLECT flag on the
>  	flow label manager.
> =20
> -	- TRUE: enabled
> -	- FALSE: disabled
> +	Possible values:
> =20
> -	Default: TRUE
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  auto_flowlabels - INTEGER
>  	Automatically generate flow labels based on a flow hash of the
> @@ -2056,10 +2301,13 @@ flowlabel_state_ranges - BOOLEAN
>  	reserved for the IPv6 flow manager facility, 0x80000-0xFFFFF
>  	is reserved for stateless flow labels as described in RFC6437.
> =20
> -	- TRUE: enabled
> -	- FALSE: disabled
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
> -	Default: true
> =20
>  flowlabel_reflect - INTEGER
>  	Control flow label reflection. Needed for Path MTU
> @@ -2127,10 +2375,13 @@ anycast_src_echo_reply - BOOLEAN
>  	Controls the use of anycast addresses as source addresses for ICMPv6
>  	echo reply
> =20
> -	- TRUE:  enabled
> -	- FALSE: disabled
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
> -	Default: FALSE
> =20
>  idgen_delay - INTEGER
>  	Controls the delay in seconds after which time to retry
> @@ -2187,7 +2438,12 @@ skip_notify_on_dev_down - BOOLEAN
>  	to true skips the message, making IPv4 and IPv6 on par in relying
>  	on userspace caches to track link events and evict routes.
> =20
> -	Default: false (generate message)
> +	Possible values:
> +
> +	- 0 (disabled) - generate the message
> +	- 1 (enabled)  - skip generating the message
> +
> +	Default: 0 (disabled)
> =20
>  nexthop_compat_mode - BOOLEAN
>  	New nexthop API provides a means for managing nexthops independent of
> @@ -2294,13 +2550,26 @@ conf/all/forwarding - BOOLEAN
>  proxy_ndp - BOOLEAN
>  	Do proxy ndp.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
> +
>  fwmark_reflect - BOOLEAN
>  	Controls the fwmark of kernel-generated IPv6 reply packets that are not
>  	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
> -	If unset, these packets have a fwmark of zero. If set, they have the
> +	If disabled, these packets have a fwmark of zero. If enabled, they have=
 the
>  	fwmark of the packet they are replying to.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  ``conf/interface/*``:
>  	Change special settings per interface.
> @@ -2391,9 +2660,11 @@ ra_honor_pio_life - BOOLEAN
>  	lifetime of an address matching a prefix sent in a Router
>  	Advertisement Prefix Information Option.
> =20
> -	- If enabled, the PIO valid lifetime will always be honored.
> -	- If disabled, RFC4862 section 5.5.3e is used to determine
> +	Possible values:
> +
> +	- 0 (disabled) - RFC4862 section 5.5.3e is used to determine
>  	  the valid lifetime of the address.
> +	- 1 (enabled)  - the PIO valid lifetime will always be honored.
> =20
>  	Default: 0 (disabled)
> =20
> @@ -2405,8 +2676,10 @@ ra_honor_pio_pflag - BOOLEAN
>  	P-flag suppresses any effects of the A-flag within the same
>  	PIO. For a given PIO, P=3D1 and A=3D1 is treated as A=3D0.
> =20
> -	- If disabled, the P-flag is ignored.
> -	- If enabled, the P-flag will disable SLAAC autoconfiguration
> +	Possible values:
> +
> +	- 0 (disabled) - the P-flag is ignored.
> +	- 1 (enabled)  - the P-flag will disable SLAAC autoconfiguration
>  	  for the given Prefix Information Option.
> =20
>  	Default: 0 (disabled)
> @@ -2528,10 +2801,15 @@ mtu - INTEGER
>  	Default: 1280 (IPv6 required minimum)
> =20
>  ip_nonlocal_bind - BOOLEAN
> -	If set, allows processes to bind() to non-local IPv6 addresses,
> +	If enabled, allows processes to bind() to non-local IPv6 addresses,
>  	which can be quite useful - but may break some applications.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  router_probe_interval - INTEGER
>  	Minimum interval (in seconds) between Router Probing described
> @@ -2561,7 +2839,12 @@ use_oif_addrs_only - BOOLEAN
>  	routed via this interface are restricted to the set of addresses
>  	configured on this interface (vis. RFC 6724, section 4).
> =20
> -	Default: false
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  use_tempaddr - INTEGER
>  	Preference for Privacy Extensions (RFC3041).
> @@ -2686,10 +2969,14 @@ force_tllao - BOOLEAN
>  ndisc_notify - BOOLEAN
>  	Define mode for notification of address and device changes.
> =20
> -	* 0 - (default): do nothing
> -	* 1 - Generate unsolicited neighbour advertisements when device is brou=
ght
> +	Possible values:
> +
> +	- 0 (disabled) - do nothing
> +	- 1 (enabled)  - Generate unsolicited neighbour advertisements when dev=
ice is brought
>  	  up or hardware address changes.
> =20
> +	Default: 0 (disabled)
> +
>  ndisc_tclass - INTEGER
>  	The IPv6 Traffic Class to use by default when sending IPv6 Neighbor
>  	Discovery (Router Solicitation, Router Advertisement, Neighbor
> @@ -2706,8 +2993,12 @@ ndisc_evict_nocarrier - BOOLEAN
>  	not be cleared when roaming between access points on the same network.
>  	In most cases this should remain as the default (1).
> =20
> -	- 1 - (default): Clear neighbor discover cache on NOCARRIER events.
> -	- 0 - Do not clear neighbor discovery cache on NOCARRIER events.
> +	Possible values:
> +
> +	- 0 (disabled) - Do not clear neighbor discovery cache on NOCARRIER eve=
nts.
> +	- 1 (enabled)  - Clear neighbor discover cache on NOCARRIER events.
> +
> +	Default: 1 (enabled)
> =20
>  mldv1_unsolicited_report_interval - INTEGER
>  	The interval in milliseconds in which the next unsolicited
> @@ -2736,25 +3027,34 @@ suppress_frag_ndisc - INTEGER
>  optimistic_dad - BOOLEAN
>  	Whether to perform Optimistic Duplicate Address Detection (RFC 4429).
> =20
> -	* 0: disabled (default)
> -	* 1: enabled
> -
>  	Optimistic Duplicate Address Detection for the interface will be enabled
>  	if at least one of conf/{all,interface}/optimistic_dad is set to 1,
>  	it will be disabled otherwise.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
> +
>  use_optimistic - BOOLEAN
>  	If enabled, do not classify optimistic addresses as deprecated during
>  	source address selection.  Preferred addresses will still be chosen
>  	before optimistic addresses, subject to other ranking in the source
>  	address selection algorithm.
> =20
> -	* 0: disabled (default)
> -	* 1: enabled
> -
>  	This will be enabled if at least one of
>  	conf/{all,interface}/use_optimistic is set to 1, disabled otherwise.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> +
>  stable_secret - IPv6 address
>  	This IPv6 address will be used as a secret to generate IPv6
>  	addresses for link-local addresses and autoconfigured
> @@ -2785,14 +3085,24 @@ drop_unicast_in_l2_multicast - BOOLEAN
>  	Drop any unicast IPv6 packets that are received in link-layer
>  	multicast (or broadcast) frames.
> =20
> -	By default this is turned off.
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  drop_unsolicited_na - BOOLEAN
>  	Drop all unsolicited neighbor advertisements, for example if there's
>  	a known good NA proxy on the network and such frames need not be used
>  	(or in the case of 802.11, must not be used to prevent attacks.)
> =20
> -	By default this is turned off.
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled).
> =20
>  accept_untracked_na - INTEGER
>  	Define behavior for accepting neighbor advertisements from devices that
> @@ -2833,7 +3143,12 @@ enhanced_dad - BOOLEAN
>  	The nonce option will be sent on an interface unless both of
>  	conf/{all,interface}/enhanced_dad are set to FALSE.
> =20
> -	Default: TRUE
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> =20
>  ``icmp/*``:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -2862,29 +3177,49 @@ ratemask - list of comma separated ranges
>  	Default: 0-1,3-127 (rate limit ICMPv6 errors except Packet Too Big)
> =20
>  echo_ignore_all - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO
> +	If enabled, then the kernel will ignore all ICMP ECHO
>  	requests sent to it over the IPv6 protocol.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  echo_ignore_multicast - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO
> +	If enabled, then the kernel will ignore all ICMP ECHO
>  	requests sent to it over the IPv6 protocol via multicast.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  echo_ignore_anycast - BOOLEAN
> -	If set non-zero, then the kernel will ignore all ICMP ECHO
> +	If enabled, then the kernel will ignore all ICMP ECHO
>  	requests sent to it over the IPv6 protocol destined to anycast address.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  error_anycast_as_unicast - BOOLEAN
> -	If set to 1, then the kernel will respond with ICMP Errors
> +	If enabled, then the kernel will respond with ICMP Errors
>  	resulting from requests sent to it over the IPv6 protocol destined
>  	to anycast address essentially treating anycast as unicast.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 0 (disabled)
> =20
>  xfrm6_gc_thresh - INTEGER
>  	(Obsolete since linux-4.14)
> @@ -2902,34 +3237,49 @@ YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux=
-ipv6.org>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  bridge-nf-call-arptables - BOOLEAN
> -	- 1 : pass bridged ARP traffic to arptables' FORWARD chain.
> -	- 0 : disable this.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled) - disable this.
> +	- 1 (enabled)  - pass bridged ARP traffic to arptables' FORWARD chain.
> +
> +	Default: 1 (enabled)
> =20
>  bridge-nf-call-iptables - BOOLEAN
> -	- 1 : pass bridged IPv4 traffic to iptables' chains.
> -	- 0 : disable this.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled) - disable this.
> +	- 1 (enabled)  - pass bridged IPv4 traffic to iptables' chains.
> +
> +	Default: 1 (enabled)
> =20
>  bridge-nf-call-ip6tables - BOOLEAN
> -	- 1 : pass bridged IPv6 traffic to ip6tables' chains.
> -	- 0 : disable this.
> =20
> -	Default: 1
> +	Possible values:
> +
> +	- 0 (disabled) - disable this.
> +	- 1 (enabled)  - pass bridged IPv6 traffic to ip6tables' chains.
> +
> +	Default: 1 (enabled)
> =20
>  bridge-nf-filter-vlan-tagged - BOOLEAN
> -	- 1 : pass bridged vlan-tagged ARP/IP/IPv6 traffic to {arp,ip,ip6}table=
s.
> -	- 0 : disable this.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled) - disable this.
> +	- 1 (enabled)  - pass bridged vlan-tagged ARP/IP/IPv6 traffic to {arp,i=
p,ip6}tables
> +
> +	Default: 0 (disabled)
> =20
>  bridge-nf-filter-pppoe-tagged - BOOLEAN
> -	- 1 : pass bridged pppoe-tagged IP/IPv6 traffic to {ip,ip6}tables.
> -	- 0 : disable this.
> =20
> -	Default: 0
> +	Possible values:
> +
> +	- 0 (disabled) - disable this.
> +	- 1 (enabled)  - pass bridged pppoe-tagged IP/IPv6 traffic to {ip,ip6}t=
ables.
> +
> +	Default: 0 (disabled)
> =20
>  bridge-nf-pass-vlan-input-dev - BOOLEAN
>  	- 1: if bridge-nf-filter-vlan-tagged is enabled, try to find a vlan
> @@ -2952,11 +3302,12 @@ addip_enable - BOOLEAN
>  	the ability to dynamically add and remove new addresses for the SCTP
>  	associations.
> =20
> -	1: Enable extension.
> +	Possible values:
> =20
> -	0: Disable extension.
> +	- 0 (disabled) - disable extension.
> +	- 1 (enabled)  - enable extension
> =20
> -	Default: 0
> +	Default: 0 (disabled)
> =20
>  pf_enable - INTEGER
>  	Enable or disable pf (pf is short for potentially failed) state. A value
> @@ -3025,19 +3376,23 @@ auth_enable - BOOLEAN
>  	required for secure operation of Dynamic Address Reconfiguration
>  	(ADD-IP) extension.
> =20
> -	- 1: Enable this extension.
> -	- 0: Disable this extension.
> +	Possible values:
> =20
> -	Default: 0
> +	- 0 (disabled) - disable extension.
> +	- 1 (enabled)  - enable extension
> +
> +	Default: 0 (disabled)
> =20
>  prsctp_enable - BOOLEAN
>  	Enable or disable the Partial Reliability extension (RFC3758) which
>  	is used to notify peers that a given DATA should no longer be expected.
> =20
> -	- 1: Enable extension
> -	- 0: Disable
> +	Possible values:
> =20
> -	Default: 1
> +	- 0 (disabled) - disable extension.
> +	- 1 (enabled)  - enable extension
> +
> +	Default: 1 (enabled)
> =20
>  max_burst - INTEGER
>  	The limit of the number of new packets that can be initially sent.  It
> @@ -3137,10 +3492,12 @@ cookie_preserve_enable - BOOLEAN
>  	Enable or disable the ability to extend the lifetime of the SCTP cookie
>  	that is used during the establishment phase of SCTP association
> =20
> -	- 1: Enable cookie lifetime extension.
> -	- 0: Disable
> +	Possible values:
> +
> +	- 0 (disabled) - disable.
> +	- 1 (enabled)  - enable cookie lifetime extension.
> =20
> -	Default: 1
> +	Default: 1 (enabled)
> =20
>  cookie_hmac_alg - STRING
>  	Select the hmac algorithm used when generating the cookie value sent by
> @@ -3274,10 +3631,12 @@ reconf_enable - BOOLEAN
>          a stream, and it includes the Parameters of "Outgoing/Incoming S=
SN
>          Reset", "SSN/TSN Reset" and "Add Outgoing/Incoming Streams".
> =20
> -	- 1: Enable extension.
> -	- 0: Disable extension.
> +	Possible values:
> =20
> -	Default: 0
> +	- 0 (disabled) - Disable extension.
> +	- 1 (enabled) - Enable extension.
> +
> +	Default: 0 (disabled)
> =20
>  intl_enable - BOOLEAN
>          Enable or disable extension of User Message Interleaving functio=
nality
> @@ -3288,10 +3647,12 @@ intl_enable - BOOLEAN
>          to 1 and also needs to set socket options SCTP_FRAGMENT_INTERLEA=
VE to 2
>          and SCTP_INTERLEAVING_SUPPORTED to 1.
> =20
> -	- 1: Enable extension.
> -	- 0: Disable extension.
> +	Possible values:
> =20
> -	Default: 0
> +	- 0 (disabled) - Disable extension.
> +	- 1 (enabled) - Enable extension.
> +
> +	Default: 0 (disabled)
> =20
>  ecn_enable - BOOLEAN
>          Control use of Explicit Congestion Notification (ECN) by SCTP.
> @@ -3300,10 +3661,12 @@ ecn_enable - BOOLEAN
>          due to congestion by allowing supporting routers to signal conge=
stion
>          before having to drop packets.
> =20
> -        1: Enable ecn.
> -        0: Disable ecn.
> +        Possible values:
> =20
> -        Default: 1
> +	- 0 (disabled) - Disable ecn.
> +	- 1 (enabled) - Enable ecn.
> +
> +	Default: 1 (enabled)
> =20
>  l3mdev_accept - BOOLEAN
>  	Enabling this option allows a "global" bound socket to work
> @@ -3312,6 +3675,11 @@ l3mdev_accept - BOOLEAN
>  	originated. Only valid when the kernel was compiled with
>  	CONFIG_NET_L3_MASTER_DEV.
> =20
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
>  	Default: 1 (enabled)
> =20
> =20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9vDl/jpiPu+gdLWq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFuY4AAKCRD2uYlJVVFO
o/sWAQCVltUZL81RUl1RHtJPXvLz181ytwF2oaLuUAIBq5cITwEAnZOfm3aVldvU
Ex6GqJvUzih78FYnPLj1k572W1ONoAU=
=7oVg
-----END PGP SIGNATURE-----

--9vDl/jpiPu+gdLWq--

