Return-Path: <netdev+bounces-243522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D1CA2F2C
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A7063007B50
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678E32D45E;
	Thu,  4 Dec 2025 09:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFC33123C;
	Thu,  4 Dec 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840022; cv=none; b=gZlbAu2VhVUS+qF/k5O1ZVBdNR+vwWkUCWELx84FBEoUwgYV1DexZAHPGDrh8d6cdi3NpfX2LvhPju5yHoGPrySi5eMl/Je7GBmQVt6/tp9vXELnDpMwUrkwN1S8+ypxe38mGTzKGGpsiNfHEXC7wdg+m7HLsvnd6MqJVoGAZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840022; c=relaxed/simple;
	bh=V0IRAvSLDYnvAlMVrD2CIW5BHSLS2cFC5afmQhU8h1I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=d9g2le8gG5SdZzSGXym+3SFOGmzqQEetUZELn9C7dJYHR5S0TbBNFiqHHS9n6W9W7Y0c0hvDKwtNVhjGR7dHt9Ros1nOKHn7osHBm/rWSYhKxBmndu912VgtzYIQIJ3etwnX4CEq09DNttgubxyM2ez9T3EUuD1Brtbe087oF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AAD8A4923B;
	Thu, 04 Dec 2025 10:20:10 +0100 (CET)
Date: Thu, 04 Dec 2025 10:20:06 +0100
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH net-next] net: veth: Disable netpoll support
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Breno Leitao
	<leitao@debian.org>, Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com, open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20240805094012.1843247-1-leitao@debian.org>
In-Reply-To: <20240805094012.1843247-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1764839728.p54aio6507.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1764839963466

On August 5, 2024 11:40 am, Breno Leitao wrote:
> The current implementation of netpoll in veth devices leads to
> suboptimal behavior, as it triggers warnings due to the invocation of
> __netif_rx() within a softirq context. This is not compliant with
> expected practices, as __netif_rx() has the following statement:
>=20
> 	lockdep_assert_once(hardirq_count() | softirq_count());
>=20
> Given that veth devices typically do not benefit from the
> functionalities provided by netpoll, Disable netpoll for veth
> interfaces.

this patch seems to have broken combining netconsole and bridges with
veth ports:

https://bugzilla.proxmox.com/show_bug.cgi?id=3D6873

any chance this is solvable?

>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/veth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 426e68a95067..34499b91a8bd 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1696,6 +1696,7 @@ static void veth_setup(struct net_device *dev)
>  	dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
>  	dev->priv_flags |=3D IFF_NO_QUEUE;
>  	dev->priv_flags |=3D IFF_PHONY_HEADROOM;
> +	dev->priv_flags |=3D IFF_DISABLE_NETPOLL;
> =20
>  	dev->netdev_ops =3D &veth_netdev_ops;
>  	dev->xdp_metadata_ops =3D &veth_xdp_metadata_ops;
> --=20
> 2.43.0
>=20
>=20
>=20
>=20


