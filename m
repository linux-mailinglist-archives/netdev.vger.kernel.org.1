Return-Path: <netdev+bounces-103282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE89075DF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58363286A9C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F471482EA;
	Thu, 13 Jun 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx0uP1gD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BC146A74
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290763; cv=none; b=NbmT2rGKXgi7wF4c74RIGwtVJTAHue195g6cZ3TBH8tfN85Wkkq0tnUtUIAZV/mGmeOgayphL5SNcCzqlxszc8oPI4xqUKzaoEgJ0uMP4NLPNfjUCgtHr+iNRzlDF/EsiApkBysqZie4BsIDDK5+C50n+wR7XiqcOsX+yA55dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290763; c=relaxed/simple;
	bh=qs2Dz7qjSbW4vccPeJYtnqhSYlxFt3bToMTXiSpftTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyjHNWXHVucIh6g6UsK111glMVQ0FRbEFbKyr8+QlfVZ+ZNwMqECUS+NTPM7HdPXuiGpEtUdVJNruHMQYXt5Cq+669BULNzcLHLA8K6J6F5Oh0Sj3fTwmNL8oFTU9411ivvnhN+VrFDtmvi1Ot0ry2Mcntbv68KyjqRn07c0Nas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx0uP1gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3950DC32786;
	Thu, 13 Jun 2024 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718290763;
	bh=qs2Dz7qjSbW4vccPeJYtnqhSYlxFt3bToMTXiSpftTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yx0uP1gDwb6Y4Yqm1HkVgJV+XZTCZVWS7uCG84X9HKSSFMaQS0J4AMPp7ad4IsapJ
	 qoO2ZkEOOlPsaVmIC1cKnaUgFF7fYBU0BarcMUdruYJb5CjNP6XXrdNaTcRcTyEWaL
	 fwfkZWdko+dap8fRG5X0yKRG1OVH0qBmgRZ8jm6KtKSEf/qLD5HTJnKJxxMjj3p8p/
	 f62qc8Ytsl+pjDZcsx2aff8xXXFgvz9CkAMJvYh6S5F4S+VlwT1Q4p87ZA3D0bLRvq
	 AKaiyNoQjeVox1FqtNFnZtVsBBvHFs1ljEmVEckDsfSZplYZioAnIaWArr+X/Mnz7p
	 LYwcb7Uvh/Nlg==
Date: Thu, 13 Jun 2024 07:59:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: Linux NetDev <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: Some sort of netlink RTM_GET(ROUTE|RULE|NEIGH) regression(?) in
 6.10-rc3 vs 6.9
Message-ID: <20240613075922.1052ce99@kernel.org>
In-Reply-To: <CANP3RGcovrwKpuM-o=V2OYosdb6Xyy+tRM3Qrp3pF7RctEm6LQ@mail.gmail.com>
References: <CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com>
	<20240613062927.54b15104@kernel.org>
	<CANP3RGcovrwKpuM-o=V2OYosdb6Xyy+tRM3Qrp3pF7RctEm6LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 16:21:15 +0200 Maciej =C5=BBenczykowski wrote:
> Ok, I sent out 2 patches adding the flag in 3 more spots that are
> enough to get both tests working.

Thanks!

> The first in RTM_GETNEIGH seems obvious enough.
>=20
> $ git grep rtnl_register.*RTM_GETNEIGH,
> net/core/neighbour.c:3894:      rtnl_register(PF_UNSPEC, RTM_GETNEIGH,
> neigh_get, neigh_dump_info,
> net/core/rtnetlink.c:6752:      rtnl_register(PF_BRIDGE, RTM_GETNEIGH,
> rtnl_fdb_get, rtnl_fdb_dump, 0);
> net/mctp/neigh.c:331:   rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GE=
TNEIGH,
>=20
> but there is also PF_BRIDGE and PF_MCTP... (though obviously the test
> doesn't care)
> (and also RTM_GETNEIGHTBL...)

These weren't converted to the new way, so they will be okay.

> The RTM_GETRULE portion of the second one seems fine too:
>=20
> $ git grep rtnl_register.*RTM_GETRULE
> net/core/fib_rules.c:1296:      rtnl_register(PF_UNSPEC, RTM_GETRULE,
> NULL, fib_nl_dumprule,
>=20
> but I'm less certain about the GET_ROUTE portion there-of... as
> there's a lot of hits:
>=20
> $ git grep rtnl_register.*RTM_GETROUTE
> net/can/gw.c:1293:      ret =3D rtnl_register_module(THIS_MODULE,
> PF_CAN, RTM_GETROUTE,
> net/core/rtnetlink.c:6743:      rtnl_register(PF_UNSPEC, RTM_GETROUTE,
> NULL, rtnl_dump_all, 0);
> net/ipv4/fib_frontend.c:1662:   rtnl_register(PF_INET, RTM_GETROUTE,
> NULL, inet_dump_fib,
> net/ipv4/ipmr.c:3162:   rtnl_register(RTNL_FAMILY_IPMR, RTM_GETROUTE,
> net/ipv4/route.c:3696:  rtnl_register(PF_INET, RTM_GETROUTE,
> inet_rtm_getroute, NULL,
> net/ipv6/ip6_fib.c:2516:        ret =3D
> rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
> net/ipv6/ip6mr.c:1394:  err =3D rtnl_register_module(THIS_MODULE,
> RTNL_FAMILY_IP6MR, RTM_GETROUTE,
> net/ipv6/route.c:6737:  ret =3D rtnl_register_module(THIS_MODULE,
> PF_INET6, RTM_GETROUTE,
> net/mctp/route.c:1481:  rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GE=
TROUTE,
> net/mpls/af_mpls.c:2755:        rtnl_register_module(THIS_MODULE,
> PF_MPLS, RTM_GETROUTE,
> net/phonet/pn_netlink.c:304:    rtnl_register_module(THIS_MODULE,
> PF_PHONET, RTM_GETROUTE,
>=20
> It seems like maybe v4 and both mr's should be changed too?

Didn't check MR, the v4 route dump has the flag already, AFAICS.

