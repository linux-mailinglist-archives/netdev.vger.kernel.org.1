Return-Path: <netdev+bounces-94338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D58BF392
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F31E1F25828
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB82C127;
	Wed,  8 May 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKNvDiyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD653BE62
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127683; cv=none; b=JqhSDv10LWeZFPgX73PuXRIOPGaF4IltO2Q7opt4udavSV1HEMVpCmMT4OhDtxk+TFYCGd0RnlBoWsBIZ7APrrQewsXyD6PCdlMEa2b/4zGrSCAIr2rYRyufXvCmDMBnYTe4+bppPnzyovE7CJrGZwRhernbc8GuXHFKKUfjo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127683; c=relaxed/simple;
	bh=XrEA+5+va8GBUzGXvAFwBVLg1pfjWJyY5eXsTHDvOBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAmwGtdv3fCaoUimO9+f3wWQPCEeu3yRY1rJWRbpl3e+HH/u6+igq3Whvy7LH5hK0yl9b1Mh/WZbedhEt1N/o9U+iiCETdPddyKd71beXGT5hdcoFBlT3ceuqcyqutni0r38UjQLn6kSFlGCybxDpT07sskVcnUNRnt8K526kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKNvDiyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5BEC2BBFC;
	Wed,  8 May 2024 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715127683;
	bh=XrEA+5+va8GBUzGXvAFwBVLg1pfjWJyY5eXsTHDvOBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKNvDiyPipLG4t05ctL6RK9UB+KE4GnSh3oHcy3Zomr+rcJOg/dRcjvdds6jo3vZv
	 i7GZxB+g1xFPOLG+pK1fEfQjsKueDq+wfTZ1JOMEegCaEW8Zy3qE/bILfKmBqxCyVZ
	 /GEmkVgjWiTBVsmqzF2RhMhrVnEx4Jd0UJSOpqHBBdHK/IkPO2sJ/5+ZD89MMjsAC4
	 Wob/AdRcaA5m7PDsoa/ZVAFoWUzvot6Kclu2T0wdmnrvABMffPMuOtkcqk0ixpGGEf
	 8EgTomkp9wynlA1rItNVXGpEGUDaBiyjVNMUAT6h553ijFk+y58yL3G/zx6xThCUy8
	 Tw6u1nNWc6VjQ==
Date: Tue, 7 May 2024 17:21:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 05/24] ovpn: implement interface
 creation/destruction via netlink
Message-ID: <20240507172122.544dd68e@kernel.org>
In-Reply-To: <20240506011637.27272-6-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  6 May 2024 03:16:18 +0200 Antonio Quartulli wrote:
>  int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -ENOTSUPP;
> +	const char *ifname =3D OVPN_DEFAULT_IFNAME;
> +	enum ovpn_mode mode =3D OVPN_MODE_P2P;
> +	struct net_device *dev;
> +	struct sk_buff *msg;
> +	void *hdr;
> +
> +	if (info->attrs[OVPN_A_IFNAME])
> +		ifname =3D nla_data(info->attrs[OVPN_A_IFNAME]);
> +
> +	if (info->attrs[OVPN_A_MODE]) {
> +		mode =3D nla_get_u32(info->attrs[OVPN_A_MODE]);
> +		pr_debug("ovpn: setting device (%s) mode: %u\n", ifname, mode);
> +	}
> +
> +	dev =3D ovpn_iface_create(ifname, mode, genl_info_net(info));
> +	if (IS_ERR(dev)) {
> +		pr_err("ovpn: error while creating interface %s: %ld\n", ifname,
> +		       PTR_ERR(dev));

Better to send the error to the caller with NL_SET_ERR_MSG_MOD()

> +		return PTR_ERR(dev);
> +	}
> +
> +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_put(msg, info->snd_portid, info->snd_seq, &ovpn_nl_fami=
ly,
> +			  0, OVPN_CMD_NEW_IFACE);

genlmsg_iput() will save you a lot of typing

> +	if (!hdr) {
> +		netdev_err(dev, "%s: cannot create message header\n", __func__);
> +		return -EMSGSIZE;
> +	}
> +
> +	if (nla_put(msg, OVPN_A_IFNAME, strlen(dev->name) + 1, dev->name)) {

nla_put_string() ?

> +		netdev_err(dev, "%s: cannot add ifname to reply\n", __func__);

Probably not worth it, can't happen given the message size

> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
>  }
> =20
>  int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -ENOTSUPP;
> +	struct ovpn_struct *ovpn =3D info->user_ptr[0];
> +
> +	rtnl_lock();
> +	ovpn_iface_destruct(ovpn);
> +	dev_put(ovpn->dev);
> +	rtnl_unlock();
> +
> +	synchronize_net();

Why? =F0=9F=A4=94=EF=B8=8F

