Return-Path: <netdev+bounces-94749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79048C08E3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27662B20318
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4C54F86;
	Thu,  9 May 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4LX3Sqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FEFC12
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216988; cv=none; b=cjlvtW4fSUssqnYA0Ov2lEmfDDWmmUwnSTgv65zY2+sWxba/fYZoFvAwoQP/QLBqFVmb/NWTSgzA6iAk9gaBnS4kvXOsIIXxJK9/X8F3w+sk2xtM6ewQ+vwhv3GIv45b9md/XjlgT/doHlYhLZ7yjeh9aR2IN0qu2YLQwsG388A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216988; c=relaxed/simple;
	bh=9P2MCSkkl4wP84e5I7U/0n73u+m5InsCVhiiOi/rFm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R43l7LlZI8l96mzDDaZSQ3z1fuijRUt4eCSSuwjDMaFdVRU6DkcVvdgMea6tIWrONXAeiozRPMusF9UJS17BAdZZAbV5ahw98thjwtek8GsFB2TYbtCVWTvZmudqDGuk8Ku6nnut/MkpX6Gh64AuUHJMeJIdY2ok50TMddzj1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4LX3Sqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB7C2BD10;
	Thu,  9 May 2024 01:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216988;
	bh=9P2MCSkkl4wP84e5I7U/0n73u+m5InsCVhiiOi/rFm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4LX3Sqmc6n6KF9P/LHWAo32QaZoCYkDCtWCAlaXf1LICeTsX0NcyATJJMXYlHVYQ
	 PPS0uGiJUbZac/yTTINcHPZzriMB4Ut5RiaYcJTQp0obGY3/YED870KRHcV5s2AXG3
	 Wh6zND4Q4gBH3djyPJbHxMenSTxQTMHl8wBfVLr6hzRZLnStYFd4gXUqP1zoWT0MHt
	 Iau471DuQQ+gtUMJkjHKPgvX8pksK173cJi/9Jh5T8kk5JYd9aQSxjHyZo2/lsQJbJ
	 u6qnRibjju7InSB6P5F6yOi7FNFlZw+KVzZYv0pyQhlKCiyqvyjRTMT0Bjgywo00Wq
	 0wZf0QMgZEmJg==
Date: Wed, 8 May 2024 18:09:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 05/24] ovpn: implement interface
 creation/destruction via netlink
Message-ID: <20240508180946.47e6610a@kernel.org>
In-Reply-To: <3b9f43da-0269-4eba-a3c4-dcb635c0de75@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-6-antonio@openvpn.net>
	<20240507172122.544dd68e@kernel.org>
	<3b9f43da-0269-4eba-a3c4-dcb635c0de75@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 May 2024 11:49:07 +0200 Antonio Quartulli wrote:
> >> +		netdev_err(dev, "%s: cannot add ifname to reply\n", __func__); =20
> >=20
> > Probably not worth it, can't happen given the message size =20
>=20
> Personally I still prefer to check the return value of functions that=20
> may fail, because somebody may break the assumption (i.e. message large=20
> enough by design) without realizing that this call was relying on that.
>=20
> If you want, I could still add a comment saying that we don't expect=20
> this to happen.

In a few other places we put a WARN_ON_ONCE() on messages size errors.
That way syzbot usually catches the miscalculation rather quickly.
But no strong objections if you prefer the print.
 =20
> >> +		genlmsg_cancel(msg, hdr);
> >> +		nlmsg_free(msg);
> >> +		return -EMSGSIZE;
> >> +	}
> >> +
> >> +	genlmsg_end(msg, hdr);
> >> +
> >> +	return genlmsg_reply(msg, info);
> >>   }
> >>  =20
> >>   int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> >>   {
> >> -	return -ENOTSUPP;
> >> +	struct ovpn_struct *ovpn =3D info->user_ptr[0];
> >> +
> >> +	rtnl_lock();
> >> +	ovpn_iface_destruct(ovpn);
> >> +	dev_put(ovpn->dev);
> >> +	rtnl_unlock();
> >> +
> >> +	synchronize_net(); =20
> >=20
> > Why? =F0=9F=A4=94=EF=B8=8F =20
>=20
>=20
> hmm I was under the impression that we should always call this function=20
> when destroying an interface to make sure that packets that already=20
> entered the network stack can be properly processed before the interface=
=20
> is gone for good.
>=20
> Maybe this is not the right place? Any hint?

The unregistration of the netdevice should take care of syncing packets
in flight, AFAIU.

