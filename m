Return-Path: <netdev+bounces-158442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E546A11E42
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B6F1608D1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB94A1EBFE8;
	Wed, 15 Jan 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJuvtM4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73001E7C24
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934001; cv=none; b=BkToDinXghpAb2ltQIxXlFu7vApE9f73mPLXATBfPRL8XVEsofPIXs5ij995ByxbBeih6Ii7G9Gy64g+0dgj+4ORXdN8BTrSluiI3KOI7WYnUvMy5e/bcWlZgc4pSj+/sKJppMptK9rc4XIexYwAi2b/fqqlgdCJ8S/DOjTsmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934001; c=relaxed/simple;
	bh=Z5i4BhvAn51rU0KLNHv8bLVq/oJuZP6nEI6HlSGsqzk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ABZCxJQ8PeJIIFiJuVGvkn8y+Ubk4FHoS4zLvauzTmMZ+qZ3Mn1YHMtls1ApSiInT75Y8ZoZeEw7nDx3U/QHz8EftK68PNC2KnGgdIxueCNARrvV6TkcGuzMkuMf4qG0GfixgjweUJCnh1cBBiYlp+XZNVQTZfNUhogcgsdMrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJuvtM4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A337C4CEDF;
	Wed, 15 Jan 2025 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736934001;
	bh=Z5i4BhvAn51rU0KLNHv8bLVq/oJuZP6nEI6HlSGsqzk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WJuvtM4uZQoKnDHshsZdEUMhx6wYtOwViNQ7xLCi+ZQ8i5l1rfVCWPblqa6TjCAaw
	 Y/dAVGVC6b2DhH4E6U5MFCYIEpiPWerXD7F8737dHePOu7gxLOj/0TZWdh4nXEL16e
	 7Ho2ZaHeKv1Dl1rV3pTFxZlnckBSLsHvHnm2BmRDdjTNd5k5MGDj+1eBhWBfiISkjh
	 aSCpQTigEPg1+CnzUwwbb/E3BUMiFHukyUjfEHUE3e9XBkA1U+WyCcp2rdBowk+Kqh
	 kGA1z5KyW0peCZLqIunZvPi+hB7bh6qsLF9H/QEefUk6IsAk7U6icUVYdfdCCY1qP7
	 YT+O6e04f7I6A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250114112401.545a70f7@kernel.org>
References: <20250113161842.134350-1-atenart@kernel.org> <20250114112401.545a70f7@kernel.org>
Subject: Re: [PATCH net] net: avoid race between device unregistration and set_channels
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 15 Jan 2025 10:39:57 +0100
Message-ID: <173693399736.5893.16178689571036969424@kwain>

Quoting Jakub Kicinski (2025-01-14 20:24:01)
> On Mon, 13 Jan 2025 17:18:40 +0100 Antoine Tenart wrote:
> > This is because unregister_netdevice_many_notify might run before
> > set_channels (both are under rtnl).=20
>=20
> But that is very bad, not at all sane. The set call should not proceed
> once dismantle begins.
>=20
> How about this?
>=20
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c index 849c98e6=
37c6..913c8e329a06 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
>                 pm_runtime_get_sync(dev->dev.parent);
> =20
>         if (!netif_device_present(dev) ||
> -           dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> +           dev->reg_state > NETREG_REGISTERED) {
>                 ret =3D -ENODEV;
>                 goto err;
>         }

That looks better, I'll send a v2 with this. Now I recall adding the
above for a similar issue...

This makes me think we should do the same in the trylock/restart_syscall
series as this will also allow calls to run after dismantle begins. It
also might be time to make dev_isalive available and use it outside of
net-sysfs.

Thanks!
Antoine

