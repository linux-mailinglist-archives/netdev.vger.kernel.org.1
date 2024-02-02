Return-Path: <netdev+bounces-68553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D825A847293
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FF41F2C217
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10B145346;
	Fri,  2 Feb 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2vb+7sK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684814533A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886308; cv=none; b=sG/GVJ0fqWmvFm8QJy5JljV7ZmVZRbEgfNv6wesM+x8hewZRFp+5f2xjFl2E00aVFssnBQaZBheqvIBAohUOwHmKMOwHzbMmPlW/VrwPF7AKxuW1ITkmn3y6GGxn/CGbm9VtR2OGQzHS/V89D/3rIyfOQOzAPuZZT6hh3oXS4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886308; c=relaxed/simple;
	bh=AJTxW6flLLsyctk7M9LvKtBPVb88sJTiJr4H8VUTgkY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mhwZfJBEYLZpNOxfXx2LZXudZPFaWz0A7Ku03RYfakjkRD6qVMio6d8O0DQht34OOs07KgVGxNKQ8oU+ivM23+6DASecyLxB633MESbnDfU6/kdDXfyZMreYreZMHXLVywq6OviuE/95jAOz6pvx5g3cPJAqILrIH7WcTQcB8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2vb+7sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C88DC433F1;
	Fri,  2 Feb 2024 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886308;
	bh=AJTxW6flLLsyctk7M9LvKtBPVb88sJTiJr4H8VUTgkY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=b2vb+7sKuiADKh4eZIFRUNJ40x4+ZqBE3BSHmzzVgOf20PkuCH4BWiBtmNWNTajw7
	 IAIAfsbHJzTJZsKcI5ro5SrcbkCQPTDY2RsYGYMFWZ7h1noQygxAG+hPvso2vXmrSe
	 Sw0oRY1qMaL8Y96CysUlbDUfbKZXku8vYcEq7XO90/UnpsdWnhbm69Srrg8JbvYER6
	 nF246Tczo16z3XqVqSa1BeY4exZgQegcHMHSq7QUBkKccYS5kJf7DkJW70m4yjc6WK
	 N9dpQ4bgGUCcz/EpMFKD6hwlPsA1iPz7A1BWE6/ghl+Vn/oxy5gz9N/rjxYePkG6Nu
	 MPfnBkrc0oRrA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89i+300-irMM8gZwbq6+xn7Mxc7mdr_wKhoRoyxYstV8kvQ@mail.gmail.com>
References: <20240201170937.3549878-1-edumazet@google.com> <20240201170937.3549878-6-edumazet@google.com> <170688415193.5216.10499830272732622816@kwain> <CANn89i+300-irMM8gZwbq6+xn7Mxc7mdr_wKhoRoyxYstV8kvQ@mail.gmail.com>
Subject: Re: [PATCH net-next 05/16] bonding: use exit_batch_rtnl() method
From: Antoine Tenart <atenart@kernel.org>
Cc: David S . Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
To: Eric Dumazet <edumazet@google.com>
Date: Fri, 02 Feb 2024 16:05:05 +0100
Message-ID: <170688630537.5216.11435532294079675376@kwain>

Quoting Eric Dumazet (2024-02-02 15:51:43)
> On Fri, Feb 2, 2024 at 3:29=E2=80=AFPM Antoine Tenart <atenart@kernel.org=
> wrote:
> > Quoting Eric Dumazet (2024-02-01 18:09:26)
> >
> > This changes the logic of how bond net & devices are destroyed. Before
> > this patch the logic was:
> >
> > 1. bond_destroy_sysfs; called first so no new bond devices can be
> >    registered later.
> > 2. unregister_netdevice; cleans up any new bond device added before 1.
> >
> > This now is:
> > 1. unregister_netdevice
> > // Here new bond devices can still be registered.
> > 2. bond_destroy_sysfs
> >
> > Looking briefly at the history, the above is done on purpose to avoid
> > issues when unloading the bonding module. See 23fa5c2caae0 and
> > especially 69b0216ac255.
>=20
> Nice catch, thanks.
>=20
> Hmmm, it seems we should perform the  bond_destroy_sysfs(bn) call earlier=
 then,
> from the pre_exit() method...
>=20
> Order of calls is :
> 1) pre_exit()
> 2) exit_batch_rtnl()
> 3) exit(), exit_batch()
>=20
> Something like the following (that I would squash on the current patch)

Looks good, thanks!

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 181da7ea389312d7c851ca51c35b871c07144b6b..7edd3daa7e6d977e6b0220226=
b3cd4f8f67a7952
> 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6415,6 +6415,13 @@ static int __net_init bond_net_init(struct net *ne=
t)
>         return 0;
>  }
>=20
> +static void __net_exit bond_net_pre_exit(struct net *net)
> +{
> +       struct bond_net *bn =3D net_generic(net, bond_net_id);
> +
> +       bond_destroy_sysfs(bn);
> +}
> +
>  static void __net_exit bond_net_exit_batch(struct list_head *net_list)
>  {
>         struct bond_net *bn;
> @@ -6422,7 +6429,6 @@ static void __net_exit
> bond_net_exit_batch(struct list_head *net_list)
>=20
>         list_for_each_entry(net, net_list, exit_list) {
>                 bn =3D net_generic(net, bond_net_id);
> -               bond_destroy_sysfs(bn);
>                 bond_destroy_proc_dir(bn);
>         }
>  }
> @@ -6445,8 +6451,9 @@ static void __net_exit
> bond_net_exit_batch_rtnl(struct list_head *net_list,
>=20
>  static struct pernet_operations bond_net_ops =3D {
>         .init =3D bond_net_init,
> -       .exit_batch =3D bond_net_exit_batch,
> +       .pre_exit =3D bond_net_pre_exit,
>         .exit_batch_rtnl =3D bond_net_exit_batch_rtnl,
> +       .exit_batch =3D bond_net_exit_batch,
>         .id   =3D &bond_net_id,
>         .size =3D sizeof(struct bond_net),
>  };
>

