Return-Path: <netdev+bounces-234329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F67C1F795
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66B4A34DB21
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120A34FF4F;
	Thu, 30 Oct 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kvAGlboN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6933F39D;
	Thu, 30 Oct 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819295; cv=none; b=KMdc8p35zomScsguqsFnTuOCX87TEnlt6KnUB/VOvyBl+5DjtOWc6eDYUz46k3gOjXEZ508keGIG8pNcPW5VXjwuFBxA0Oy3zmZospgJAowVvU0QMAlIQJuGWDx6411h6q50odO0TirRZBX+AKxOcb8s5YmFhPSdH+XPhmKS/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819295; c=relaxed/simple;
	bh=9+26W/7FccezvQBu6jAWgN6OcPPx65WqQb+oWvycV2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlTA+ttTaXkUNFSigTkNcRnLXMbBrAlmIIZrTCYOZ9vFl4jSXmoYksaITg+6bUX213a7eDszZYfZN2BkKSEH72+gfy6sqP1BwFI9mWzR5Qmyjcp1v/9yb6u22a85DAIe8CKtLF1M2UgBeOVehPfpoq3ZYgqfPFBCwqHipbTKiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kvAGlboN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 22EC91A1777;
	Thu, 30 Oct 2025 10:14:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E311D6068C;
	Thu, 30 Oct 2025 10:14:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D4A5102F2500;
	Thu, 30 Oct 2025 11:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819289; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fFivBrtf6Fyg74mEnmhhcfVb7sdHf9IjJ5FCXLS4tic=;
	b=kvAGlboNHT7htE3FpUCOqYWVZEDMz/8kSwDiIZskRyxxK4ecuuGIebMcAxtPK2S6JB82a3
	j+PHwi0uebvfgGIkpI8YI2EASSwzN9ll2WBkS1sV02z3jV35UlKFyk6Nk831b1kC8zIwMp
	pe7C57xf8V/eNg3ObX7YfXgNH0AySHql6l3VaiLYj3tSxFRg33vmcaI/XQzcaBYVbghsmP
	6vDOReyQjyz5f7UgC2O3+qrU36V/v5JwFMrHsm07De13vj5fUSVH2zCbjKF74Qa4zR7ocv
	ecTY1uUR4NBpCGchIpFxmOepkh917uoIIisNomdurxDbf2+d6X3U9o+Q+boFuA==
Date: Thu, 30 Oct 2025 11:14:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller@googlegroups.com, vladimir.oltean@nxp.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: core: prevent NULL deref in
 generic_hwtstamp_ioctl_lower()
Message-ID: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
In-Reply-To: <20251030093621.3563440-1-r772577952@gmail.com>
References: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
	<20251030093621.3563440-1-r772577952@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 30 Oct 2025 09:36:21 +0000
Jiaming Zhang <r772577952@gmail.com> wrote:

> The ethtool tsconfig Netlink path can trigger a null pointer
> dereference. A call chain such as:
>=20
>   tsconfig_prepare_data() ->
>   dev_get_hwtstamp_phylib() ->
>   vlan_hwtstamp_get() ->
>   generic_hwtstamp_get_lower() ->
>   generic_hwtstamp_ioctl_lower()
>=20
> results in generic_hwtstamp_ioctl_lower() being called with
> kernel_cfg->ifr as NULL.
>=20
> The generic_hwtstamp_ioctl_lower() function does not expect a
> NULL ifr and dereferences it, leading to a system crash.
>=20
> Fix this by adding a NULL check for kernel_cfg->ifr in
> generic_hwtstamp_get/set_lower(). If ifr is NULL, return
> -EOPNOTSUPP to prevent the call to the legacy IOCTL helper.
>=20
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to
> get/set hwtstamp config") Closes:
> https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.d=
ev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com> ---
>  net/core/dev_ioctl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index ad54b12d4b4c..39eaf6ba981a 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *de=
v,
>  		return err;
>  	}
> =20
> +	/* Netlink path with unconverted driver */

nit: "lower driver", to be precise.

With this change:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> +	if (!kernel_cfg->ifr)
> +		return -EOPNOTSUPP;
> +
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
>  }
> @@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *de=
v,
>  		return err;
>  	}
> =20
> +	/* Netlink path with unconverted driver */

same.

> +	if (!kernel_cfg->ifr)
> +		return -EOPNOTSUPP;
> +
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
>  }



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

