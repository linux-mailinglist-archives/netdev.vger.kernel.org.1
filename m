Return-Path: <netdev+bounces-187813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D0AA9B9B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A75A3B9F14
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AF1B0F31;
	Mon,  5 May 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR1rJurd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5634CF5
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470115; cv=none; b=LwTVWSfenRsm9KDlzxk6k62OEv3EuTv/93Dc5L/T98aQFKurhzqQ9e20UMl0JG8rtxj8kGEz7pWCxAgnEha/g4STyG7FzT3y08AtcRvPn15yc9/PUvNGHRELFlg9NkcoIgwVB7wtbNAVxuVR50+q88aDy9TGKSYX2grOi9FrGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470115; c=relaxed/simple;
	bh=+mO4oEHeyTD7SgRxpJ2j9SLBJ3XsPkV7afLvCpyo2Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBIsK+YiK5XXn56zLo8AysykxH8X7/vGZS6m9CUd3adqVoHMGVBm59XHGAvEDMH6ToLDBdLrKqt2qY1sKthqTHHpkFFVVANXQy2wIPpUTtU8XUR1RwL+/NTDmPhIhLasryt5sl13PScDazP3N2K/KrXkwEQd+um/Omya0s/W/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR1rJurd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC8C4CEE4;
	Mon,  5 May 2025 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746470115;
	bh=+mO4oEHeyTD7SgRxpJ2j9SLBJ3XsPkV7afLvCpyo2Cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rR1rJurdUSPykpA7lm1lUzhT0RM3SySOyGCI+HJpkh5yJG0x54ezVfrJ/Mi6QthKe
	 YQtUpLsPcWWNoCWVHT1dkDaZblqGL4omGCsQ6O+FNitIxlhjIP1Clr6MsXN2jMpSEy
	 Mt0UQfXk/YdTa42YwX9eD4Qk786xVawXzYG0Q7GecdSSk67NrN/fyfyw9/yGItz8EL
	 WwV9vEBuk1dVbiRWc8lTb27C9g2/PomxqwA0MRap28OrzMzJ2V9MUdLNvi4Ti01uXb
	 XkQH6AIlV/qxi51qlKsOyjmUOrIQko0Hok24k6lVdnsGQdYunDqLrc6tneIzXasyEQ
	 CznrUNVSgoEQg==
Date: Mon, 5 May 2025 11:35:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>, stfomichev@gmail.com
Cc: "jhs@mojatatu.com" <jhs@mojatatu.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "saeed@kernel.org" <saeed@kernel.org>, Dragos
 Tatulea <dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock
 during qdisc ndo_setup_tc
Message-ID: <20250505113514.6f369217@kernel.org>
In-Reply-To: <a834c663507a78acaf1f0b3145cf38c74fe3de09.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	<20250305163732.2766420-5-sdf@fomichev.me>
	<eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
	<aBjUFyaiZ9UHpvze@mini-arch>
	<a834c663507a78acaf1f0b3145cf38c74fe3de09.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 15:12:39 +0000 Cosmin Ratiu wrote:
> On Mon, 2025-05-05 at 08:07 -0700, Stanislav Fomichev wrote:
> > On 05/05, Cosmin Ratiu wrote: =20
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index d1a8cad0c99c..134ceddf7fa5 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -12020,9 +12020,9 @@ void
> > > unregister_netdevice_many_notify(struct
> > > list_head *head,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D NULL;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Shutdown queueing discipline. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 netdev_lock_ops(dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_shutdown(dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_tcx_uninstall(dev); =20
> >=20
> > There is a synchronize_net hidden inside of dev_tcx_uninstall, so
> > let's ops-lock only dev_shutdown here? Other than that, don't see
> > anything wrong. Can you send this separately and target net tree? =20

Avoiding synchronize_net() under the instance lock as an optimization?=20
We're under rtnl_lock here, probably a premature optimization?
But no strong preference..

BTW isn't the naming scheme now that dev_* takes the lock? So we should
probably add netif_ versions or rename these existing calls?

