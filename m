Return-Path: <netdev+bounces-171366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5EBA4CAA1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816E718868EF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7221B9EC;
	Mon,  3 Mar 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/JQjJAw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915718991E;
	Mon,  3 Mar 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024948; cv=none; b=tOSWoQzrxCvKnN93Myce8TkVYfdcH74h97SCshwoZUvTotzpDIIhG3gOEZ9xSVQ/zFRkSJ7VCtED3NM1hhY+zyOhR8F8teX0cQdq5awLk2Ycm3ma59XkX44OWOhrE8CBiVRT4OecELf8Bny5MIEYkhvWHlfcVwtbeBLcuOe3hXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024948; c=relaxed/simple;
	bh=HyBjCKW51znBP/NaIGYxINt7nu7k359fu1BkdWNv6N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXh7/7AOTJ3pzsiMSC/+sO0Jo/BceVjw4/aAWewQ1HMb0deu2wVUOlfEAKRNYO8QZrwGZQFbtO74falp8OkGTZju/MqXEDQbSlza/tL1JIFdhXA6nSrEvih+FhtL4kncDDo65ijVrbIJ921zIgCdMcZqMHk15Y1MHCN89ilJBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/JQjJAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE12BC4CED6;
	Mon,  3 Mar 2025 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741024948;
	bh=HyBjCKW51znBP/NaIGYxINt7nu7k359fu1BkdWNv6N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/JQjJAwBVmDdrFoRNYPOktVxiYUDPsmZ9kfYf8VTmU6j273rYEd6pejzs8tAkPwc
	 jIrQy7BdHBLZiuLRK1uWgEq0tX0YrqUdgMdSaP84DQgon66z0A9SfnoOYSwbBf6iCl
	 QbT8ZsZ1DSlMsMGwuYHppsDs2LPiqKhKBbPHUtIRBfXe3FzvQBKGMg+6ZY4z4YV2bV
	 ezgIMRY0okMC1iuYO+5RRWElFqjtTn/NbARytT56JG9w7FT8GsqGb4Fk+YBUKgHVHD
	 fgXlD+3RLoTCjjmzsfgl5A+2eSkwoCYQWEdRxQeQvobnlluJHghNHlB3aPexF+3yCj
	 yJZGVs6tmBz2Q==
Date: Mon, 3 Mar 2025 18:02:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v2 06/10] net: usb: lan78xx: Improve error
 handling in EEPROM and OTP operations
Message-ID: <ac965de8-f320-430f-80f6-b16f4e1ba06d@sirena.org.uk>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
 <20241204084142.1152696-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GNOIgpUY1yNyfstJ"
Content-Disposition: inline
In-Reply-To: <20241204084142.1152696-7-o.rempel@pengutronix.de>
X-Cookie: Programming is an unnatural act.


--GNOIgpUY1yNyfstJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2024 at 09:41:38AM +0100, Oleksij Rempel wrote:
> Refine error handling in EEPROM and OTP read/write functions by:
> - Return error values immediately upon detection.
> - Avoid overwriting correct error codes with `-EIO`.
> - Preserve initial error codes as they were appropriate for specific
>   failures.
> - Use `-ETIMEDOUT` for timeout conditions instead of `-EIO`.

This patch (which is in Linus' tree) appears to break booting with a NFS
root filesystem on Raspberry Pi 3B+.  There appears to be at least no
incoming traffic seen on the device, I've not checked if there's
anything outgoing:

[   19.234086] usb 1-1.1.1: new high-speed USB device number 6 using dwc2
[   19.394134] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
[   19.710839] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: renamed from eth0
Device /sys/class/net/enxb827ebea22ac found
done.
Begin: Waiting up to 180 secs for any network device to become available ... done.
IP-Config: enxb827ebea22ac hardware address b8:27:eb:ea:22:ac mt[   20.663606] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Down
u 1500 DHCP
[   22.708103] lan78xx 1-1.1.1:1.0 enxb827ebea22ac: Link is Up - 1Gbps/Full - flow control off
IP-Config: no response after 2 secs - giving up

The link did look like it was up on the switch.  Full log:

   https://lava.sirena.org.uk/scheduler/job/1158809#L965

A bisect points to this commit fairly cleanly:

git bisect start
# status: waiting for both good and bad commits
# bad: [7eb172143d5508b4da468ed59ee857c6e5e01da6] Linux 6.14-rc5
git bisect bad 7eb172143d5508b4da468ed59ee857c6e5e01da6
# status: waiting for good commit(s), bad commit known
# good: [ffd294d346d185b70e28b1a28abe367bbfe53c04] Linux 6.13
git bisect good ffd294d346d185b70e28b1a28abe367bbfe53c04
# bad: [f1c243fc78ca94fd72e2e6e8f0f49b7360fef475] Merge tag 'iommu-updates-v6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect bad f1c243fc78ca94fd72e2e6e8f0f49b7360fef475
# good: [5f537664e705b0bf8b7e329861f20128534f6a83] cachestat: fix page cache statistics permission checking
git bisect good 5f537664e705b0bf8b7e329861f20128534f6a83
# bad: [7b081a74c07d9e097f6829a1749f0aa441553c5e] Merge tag 'regulator-v6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect bad 7b081a74c07d9e097f6829a1749f0aa441553c5e
# bad: [7b24f164cf005b9649138ef6de94aaac49c9f3d1] Merge tag 'ipsec-next-2025-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
git bisect bad 7b24f164cf005b9649138ef6de94aaac49c9f3d1
# bad: [75e2c86c7b180fd1068ad271178c2820a199e7eb] net: netlink: catch attempts to send empty messages
git bisect bad 75e2c86c7b180fd1068ad271178c2820a199e7eb
# bad: [bf361b18d91e96dee50c5794097a80ff3594725c] net: usb: lan78xx: Fix return value handling in lan78xx_set_features
git bisect bad bf361b18d91e96dee50c5794097a80ff3594725c
# bad: [195c3d4631816f02071f0e01d2d2def51cf5067a] octeontx2-pf: map skb data as device writeable
git bisect bad 195c3d4631816f02071f0e01d2d2def51cf5067a
# good: [dcf3827cde8621d2317a7f98e069adbdc2112982] xdp, xsk: constify read-only arguments of some static inline helpers
git bisect good dcf3827cde8621d2317a7f98e069adbdc2112982
# good: [7a2716ac9a5b2a2dd0443b101766d3721f094ee1] Merge branch 'net-phylib-eee-cleanups'
git bisect good 7a2716ac9a5b2a2dd0443b101766d3721f094ee1
# bad: [18eabadd73ae60023ab05e376246bd725fb0c113] vrf: Make pcpu_dstats update functions available to other modules.
git bisect bad 18eabadd73ae60023ab05e376246bd725fb0c113
# bad: [8b1b2ca83b200fa46fdfb81e80ad5fe34537e6d4] net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
git bisect bad 8b1b2ca83b200fa46fdfb81e80ad5fe34537e6d4
# good: [39aa1d620d10cdd276f4728da50f136dbe939643] net: usb: lan78xx: move functions to avoid forward definitions
git bisect good 39aa1d620d10cdd276f4728da50f136dbe939643
# good: [32ee0dc764505278229078e496e7b56a6d65224b] net: usb: lan78xx: Fix error handling in MII read/write functions
git bisect good 32ee0dc764505278229078e496e7b56a6d65224b
# first bad commit: [8b1b2ca83b200fa46fdfb81e80ad5fe34537e6d4] net: usb: lan78xx: Improve error handling in EEPROM and OTP operations

--GNOIgpUY1yNyfstJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfF7q4ACgkQJNaLcl1U
h9C4agf8Dt15Yvbnen1Fcb4o6u5NGQTwUYEAezfdVD+Sh6B+6aQuPckAw4C0BmoE
QzQ0yGO0jgMTlUZQzp7GqY2bjbxL2hY62D9sZyQaM5gic6IKZAV+e/krXdCcYbOu
sBObiGCN7y69TLM6fmRYTNqp0DR00ER/YIwYCQzPPORdXBkmeBPsWkLxhEfG5FmN
O4meCDAEd+gVInZovPcnJug4PiROTL/4KWRWUPseT/rX/YSvJYLgOEiQB3safIUR
ZYqxv9zFrBvfAU9g57RKmx+Ml061Djtyjm0g359lbzWLUodPAYQZl1GRcM41Z6rZ
2Wv+Bsou/t67aJCu8YTcqtjEQ7Rajg==
=6Wf3
-----END PGP SIGNATURE-----

--GNOIgpUY1yNyfstJ--

