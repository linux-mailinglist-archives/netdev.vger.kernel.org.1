Return-Path: <netdev+bounces-274013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K9gLGLpzGk/XwYAu9opvQ
	(envelope-from <netdev+bounces-274013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:46:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D0377ECC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF71D307CDBC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A84390211;
	Wed,  1 Apr 2026 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+slSkL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E22FD681
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035948; cv=none; b=czMrWG2Qk5x4CgnyiothKe4RAAiFXl2mLQ2btq3++uOqKJ8x6zjkrR0cfDdrfRo+AtuyLWKOoLuCQZ3Wq5IpwvEdPupWlDJkCMcOIDkOAdFwbU1QaveQ3I5g842spAH3u04GD1vR5IYj7WLnYCxl+AtlhqB8mcV33OkJ2RWsoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035948; c=relaxed/simple;
	bh=G23i5KUiXUp2ILmxjko50baLvNawpbXAa6jkEl9yM1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkELvvTAbq94SODPEj/WPtzSHWX8sDMSwPOMbYLfU4KKPp7rHKcUJPQxYqBe2JLqHC40VXB1FWh8SeTA7LKBkzf8nTrZE6n/NaMGYGoVJ1xOpWX8Qhw4zwjah2e8LZXcFIaf2ZS4ekDAfAKOwk4fNd+9SMgUvVFILmJikbT4zB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+slSkL6; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271257ae53so6860667c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775035946; x=1775640746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMUvPRBRQjQ3dktFD5lUuE4GHA7PZgPUIez9m4Xs3D4=;
        b=b+slSkL6q5Y/xobEegWx1Lg0uuf9Zr+y70BJGgUJ4MTQvEiF2cLIBGDCJkV4wOKrOa
         dR3aRd9tZaSdndhOQQrEhAQwBuIDYcL5P2/559Fy7hvTcnO26COpcTU/nZt+UAT2eB55
         Yf9VFLf3xC99kkvg3UhBWIbqVr7vfDbVqX5HOvBI3wYkWobjvEQ7IBLHKho+BptUZy3z
         PxqTUEFCP/TcAxFzUaSdSnjZJ5c1FRxUTd30yGZcv8UugwjKHioFGeavBFYbRvgXqde3
         KYSXuFXdePIGJVHexthmR37MBA5Yu5E551cDOwa65pVfNtG7BMTUrCXU3rkzO6ypQczl
         jATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035946; x=1775640746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMUvPRBRQjQ3dktFD5lUuE4GHA7PZgPUIez9m4Xs3D4=;
        b=HH/2SCtrLp4PAxMmQbsZItbevDdDrJRvG5LcXk7R/8O36vG4CD4aiKb67INy4TqnvQ
         MrUEP0I0+e4EdsT/P6U1AyfOhm3GMCRNY7qLkSvrm+XQTY8QM5FU0tVeVx28ZoxtaxyV
         ybXfQDWxC6o6Eg1tSdEud1Ux8fIxV7W/UC1JPvAQ5ztCgzsIVG26/z4okRYiVkh0XyzO
         ctznVbnXOmxW1o3UQSnQU7sdwgJ7XczR76HmkUUmTW/nW5btvqutLOYVdfAZDxwjUH5x
         CE6kPKaMQMZyd86yVp0yDH1FVxXgbuCuZ8nrRSkwBxs9DeQQMw498zrZNzA7a9rkQ0JP
         /Xlg==
X-Forwarded-Encrypted: i=1; AJvYcCV+OxZJsNZ9yE7eWIIX1OfFNwkux9Sz1hGoCtISVe+L9V0/BkNhyhq4ljRytrEFSjSBLJX62VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCNjpNOEKbiicPeJIaLNTCUiOc1gk41BifRnaIYOnjpyw/mV7
	TvqeczYC2MXEAhOm5ciFxLZ9opxGbq+ifsLrLBgxnIBf0L3IZ4EacRBg
X-Gm-Gg: ATEYQzwEnz84v/DcYbYa0ZjGRikLqm6g703y2aNV57e+T/+ScixfdN2VOrwo0WpjfCA
	dM3q/T+jqinmXjz1SHIX5I4ZDe2eZzrUVpb6cn2Xu4eniyTfe5o019NJCFFk/dpxhYgggVvV+bV
	m0RGazJ9drddqe9rkSWzjU6xOGQpLx+JXILXci3XYsXfy1TIHDi/GDv82/PV10VoZ1Z3wVycotL
	EHURB75tej9Rvo9ZajtJ5SIu0f/jqaAOFuBbccuHZbsvkcQyTXo7Pm1XYej/oOpM7d9xO4Juter
	QdLmUWAgz7hlwc5y/kcRPYRCQRyxmT8MtEf6LWDov2F/pvFE7HJWoKMl4xLUm/gHqCM2zzSEg3K
	pKeteNPHJE4N/Ik1160XQ0rC6imc+BzvoMSzRxzxUjbr3BZhy1a5LAT+VINPzHelYrrBXeHBLm7
	B6nmAO4QzthAkkQ0ixZBk=
X-Received: by 2002:a05:7022:e1c:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-12be649e669mr1529798c88.14.1775035945896;
        Wed, 01 Apr 2026 02:32:25 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ac09e3872sm15937029c88.13.2026.04.01.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:32:25 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:32:19 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: macb: Remove dedicated IRQ handler for
 WoL
Message-ID: <aczmIwuVNvZ2mcEC@pek-khao-d3>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
 <20260328-macb-irq-v1-4-7b3e622fb46c@gmail.com>
 <20260331195517.68108163@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aL+vMEbhczvoM+QN"
Content-Disposition: inline
In-Reply-To: <20260331195517.68108163@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 002D0377ECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--aL+vMEbhczvoM+QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 07:55:17PM -0700, Jakub Kicinski wrote:
> On Sat, 28 Mar 2026 18:17:48 +0800 Kevin Hao wrote:
> > In the current implementation, the suspend/resume path frees the
> > existing IRQ handler and sets up a dedicated WoL IRQ handler, then
> > restores the original handler upon resume. This approach is not used
> > by any other Ethernet driver and unnecessarily complicates the
> > suspend/resume process. After adjusting the IRQ handler in the previous
> > patches, we can now handle WoL interrupts without introducing any
> > overhead in the TX/RX hot path. Therefore, the dedicated WoL IRQ
> > handler is removed.
>=20
> Couple of sentences on testing (platform + flows) would be great here.

I have verified WoL functionality on my AMD ZynqMP board using the following
steps. I will include this information in the v2 commit.

  root@amd-zynqmp:~# ifconfig end0 192.168.3.3
  root@amd-zynqmp:~# ethtool -s end0 wol a
  root@amd-zynqmp:~# echo mem >/sys/power/state
  PM: suspend entry (deep)
  Filesystems sync: 0.055 seconds
  Freezing user space processes
  Freezing user space processes completed (elapsed 0.006 seconds)
  OOM killer disabled.
  Freezing remaining freezable tasks
  Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
  printk: Suspending console(s) (use no_console_suspend to debug)
  macb ff0e0000.ethernet: gem-ptp-timer ptp clock unregistered.
  e1000e: EEE TX LPI TIMER: 00000000
  xuartps ff000000.serial: ttyPS0: Unable to drain transmitter
  Disabling non-boot CPUs ...
  psci: CPU3 killed (polled 0 ms)
  psci: CPU2 killed (polled 0 ms)
  psci: CPU1 killed (polled 0 ms)
  Enabling non-boot CPUs ...
  Detected VIPT I-cache on CPU1
  CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
  CPU1 is up
  Detected VIPT I-cache on CPU2
  CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
  CPU2 is up
  Detected VIPT I-cache on CPU3
  CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
  CPU3 is up
  macb ff0e0000.ethernet end0: Link is Down
  macb ff0e0000.ethernet end0: configuring for phy/rgmii-id link mode
  macb ff0e0000.ethernet end0: Link is Up - 1Gbps/Full - flow control tx
  ptp ptp0: PM: parent end0 should not be sleeping
  macb ff0e0000.ethernet: gem-ptp-timer ptp clock registered.
  phy phy-fd400000.phy.2: phy_power_on was called before phy_init
  ata1: SATA link down (SStatus 0 SControl 330)
  ata2: SATA link down (SStatus 0 SControl 330)
  e1000e 0000:01:00.0 enp1s0: Hardware Error
  OOM killer enabled.
  Restarting tasks: Starting
  Restarting tasks: Done
  random: crng reseeded on system resumption
  PM: suspend exit
  root@amd-zynqmp:~# e1000e 0000:01:00.0 enp1s0: Hardware Error
 =20
  root@amd-zynqmp:~# e1000e 0000:01:00.0 enp1s0: NIC Link is Up 1000 Mbps F=
ull Duplex, Flow Control: None
 =20
  root@amd-zynqmp:~#

Thanks,
Kevin

--aL+vMEbhczvoM+QN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmnM5iMACgkQk1jtMN6u
sXGTFwf9G7yockZEXOls9WpILWA7emWOr5m/Omvi9wqW9USEaTSdrZQbV1L1Y4Lg
KFxKeAT8O3k6PcO5i6hp2CrPUNBnaMWdRdqqxxU0tPTzcCaOnsK0zNxT3SrIJcOI
jB81i4lvl9EdVNVTfUo2XSPGV7lVAaVdCLX4Q8yimMBKGh9/0k6qHghGkLy+SdyQ
Vyojjpy1B24vgRcnfO60uidFGdSTPfjUvLvAjCq9zeOd6p8/JJyzeGW1TRpDGwXd
XtIRWavpFhqQj9fP4oKkuPcbRaHi/wyVsuzkyotD3wXceZqsi8iAPejN9OlZnup7
ilTYlPx0efS9eoKOAGZc//EJbpd8OA==
=Hn5/
-----END PGP SIGNATURE-----

--aL+vMEbhczvoM+QN--

