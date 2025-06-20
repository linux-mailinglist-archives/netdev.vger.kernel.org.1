Return-Path: <netdev+bounces-199665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4468AE1531
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F419E52CE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322D22A7ED;
	Fri, 20 Jun 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fcR2AwBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KX7Hbri"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0335958;
	Fri, 20 Jun 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405549; cv=none; b=D2EZVk5E95O9DrVtwyXxUjMctah12FPX2XKh1EmnFngdsLEqiJKEArPUstpRdcRlx4IhsB3KJ/z36DgIHZw+Qf2Nmo/I4LNK32UJeKV6/beGq5iviqG5b5WUBLVt+kUlHJjGUcZ97gf2Um82JisLSFsd8BnU4W3BmQuxwoQE7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405549; c=relaxed/simple;
	bh=RbnTkvnJP1Ebdtqwc/VhKT85ujDu26dnLeIL9eViZj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/0IAm372DSIoED4UD6K61PHy7+yAk6lPDjDr/jqnoHYBor+gkULTGxMhysBwoIvp16a7mhx2FM4bi+yX4x8eI+fQtRAyjaULPuhwbTbSp2p8Hltwu3C9ENx7co4yEBloaHVfT4Dgbz7bz/mchK+x4AujcADhWH3NZ0ZooRgSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fcR2AwBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KX7Hbri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750405544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiOx0UJc6/4EKhHUrNBpnoe5RzXYaQsljD5jorHuO9U=;
	b=fcR2AwBfoJuarhXpV1pAN5qQaHOipR3HK/EyhllabDDjEDaA7FR8QoqR1zzakUuFtSFevU
	12/cTQFHmNuLal8bg5Q1QrRgNb3NLshTlXzw2yQHo/7JKQgzZEE2Cx/r6k8mzbMPerRBxH
	iwzGfJJai3NDQsDtH+aLY4J0YaH31ll8AsZlDi0fesj8oVnnSiApOX7qFz1np6JqRQZptl
	kK/+tfdHPSbIjitbXKYv+fZJDEuGmXssd/y3KGacea55/GuFQqIxoqqTV55OACUCXMLX18
	UtW7kBR6nOksyZkuQ0lwBDPkm86+f7f/dytdB0RLYliWkxUv7DPEyVFT5PFaVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750405544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiOx0UJc6/4EKhHUrNBpnoe5RzXYaQsljD5jorHuO9U=;
	b=5KX7HbriTjtu5BozbLOQv3iJmoMYE97BbpEOOj0WHHXHajNS8xQGCx+I/x2fRMUCv+rvcP
	upkDcLbTGDSYlyAw==
To: Song Yoong Siang <yoong.siang.song@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Jonathan Corbet <corbet@lwn.net>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Shinas Rasheed
 <srasheed@marvell.com>, Kevin Tian <kevin.tian@intel.com>, Brett Creeley
 <brett.creeley@amd.com>, Blanco Alcaine Hector
 <hector.blanco.alcaine@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, Wojciech
 Drewek <wojciech.drewek@intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next,v2 1/1] igc: Add wildcard rule support to
 ethtool NFC using Default Queue
In-Reply-To: <20250619153738.2788568-1-yoong.siang.song@intel.com>
References: <20250619153738.2788568-1-yoong.siang.song@intel.com>
Date: Fri, 20 Jun 2025 09:45:42 +0200
Message-ID: <8734bux3dl.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Jun 19 2025, Song Yoong Siang wrote:
> Introduce support for a lowest priority wildcard (catch-all) rule in
> ethtool's Network Flow Classification (NFC) for the igc driver. The
> wildcard rule directs all unmatched network traffic, including traffic not
> captured by Receive Side Scaling (RSS), to a specified queue. This
> functionality utilizes the Default Queue feature available in I225/I226
> hardware.
>
> The implementation has been validated on Intel ADL-S systems with two
> back-to-back connected I226 network interfaces.
>
> Testing Procedure:
> 1. On the Device Under Test (DUT), verify the initial statistic:
>    $ ethtool -S enp1s0 | grep rx_q.*packets
>         rx_queue_0_packets: 0
>         rx_queue_1_packets: 0
>         rx_queue_2_packets: 0
>         rx_queue_3_packets: 0
>
> 2. From the Link Partner, send 10 ARP packets:
>    $ arping -c 10 -I enp170s0 169.254.1.2
>
> 3. On the DUT, verify the packet reception on Queue 0:
>    $ ethtool -S enp1s0 | grep rx_q.*packets
>         rx_queue_0_packets: 10
>         rx_queue_1_packets: 0
>         rx_queue_2_packets: 0
>         rx_queue_3_packets: 0
>
> 4. On the DUT, add a wildcard rule to route all packets to Queue 3:
>    $ sudo ethtool -N enp1s0 flow-type ether queue 3
>
> 5. From the Link Partner, send another 10 ARP packets:
>    $ arping -c 10 -I enp170s0 169.254.1.2
>
> 6. Now, packets are routed to Queue 3 by the wildcard (Default Queue) rule:
>    $ ethtool -S enp1s0 | grep rx_q.*packets
>         rx_queue_0_packets: 10
>         rx_queue_1_packets: 0
>         rx_queue_2_packets: 0
>         rx_queue_3_packets: 10
>
> 7. On the DUT, add a EtherType rule to route ARP packet to Queue 1:
>    $ sudo ethtool -N enp1s0 flow-type ether proto 0x0806 queue 1
>
> 8. From the Link Partner, send another 10 ARP packets:
>    $ arping -c 10 -I enp170s0 169.254.1.2
>
> 9. Now, packets are routed to Queue 1 by the EtherType rule because it is
>    higher priority than the wildcard (Default Queue) rule:
>    $ ethtool -S enp1s0 | grep rx_q.*packets
>         rx_queue_0_packets: 10
>         rx_queue_1_packets: 10
>         rx_queue_2_packets: 0
>         rx_queue_3_packets: 10
>
> 10. On the DUT, delete all the NFC rules:
>     $ sudo ethtool -N enp1s0 delete 63
>     $ sudo ethtool -N enp1s0 delete 64
>
> 11. From the Link Partner, send another 10 ARP packets:
>     $ arping -c 10 -I enp170s0 169.254.1.2
>
> 12. Now, packets are routed to Queue 0 because the value of Default Queue
>     is reset back to 0:
>     $ ethtool -S enp1s0 | grep rx_q.*packets
>          rx_queue_0_packets: 20
>          rx_queue_1_packets: 10
>          rx_queue_2_packets: 0
>          rx_queue_3_packets: 10
>
> Co-developed-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmhVEaYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmuJEACJBgobj3CkAve16FGrjD3Zh4+IiYSY
J/o1/mJPvAyf5YhYEgQBOdqAn+w8jGBapT+RZ5ZlykRmPhjHcXIoxdi3Z7g6+u3K
gG1ymQZVbFT3NcPv5+AZHzd5825wUJJkYrJoX4MpouK6hCmw5dDPK/Eu7yg6qmhj
6bh43bt7LeZSL7KSDfGJXagYLhzVuFUI63/HSTICQz7mpd0/6qhEPW9qf4TEZZVV
bZXXO2UYJvmc01VFiEk0nFyPKEMYMW1VUvPeAZn+Y6FpvkqGj5iyKgktbiqHwuYn
BT3dEr3Io03pZn7ceuiOXF5eSGaTYvECeAx50vHvjIXwzITF9mqiNLQiEXA/hpHy
D0RlenWbdauzgaB7gDVxt2Z+FhH9MhSmTWblFeVlFgKcZt+Oz+bQwEsIlzsnhi/z
MaendoQO12/HMPRBx5LCzEwxxd+/jxUYullWCS9IYvwTErojLYCtTSsZ98XbqBd8
AsXfOuDvKGNUt6/AL5H6shQWk2l8RUUPcP58W9CnO4eo+BQqQ2x5P0HxhsqTK8SS
pU7de1jVOAsffe3D/Ee+t0/n2NFFWjIcQ2P45jLtDXsCeXVCo2hdHlL2VIkvGNiJ
rKUWejs6zdwUg5Q3D+SX1yvi2TXaFZ30X95RYwiP8uzX+Hui5HwZcHtO5VAd2VCi
hIODG5E/V6fKqA==
=SVhz
-----END PGP SIGNATURE-----
--=-=-=--

