Return-Path: <netdev+bounces-103260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F06907517
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A114C1F214F2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930B145A05;
	Thu, 13 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYTEzPrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482E145A11
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288490; cv=none; b=UiasaRK50Fnfq4gOiECVw80QZctfmynqWPKDd1slz4V9i8SWWFJWjNEU84CLlPOysCRplJeiyGTP1P6bmc9HNP/dPY7COhUR1v9vdT26VbIbZ4SSdx7WgHLW8cx44+WHLDwr6uVzpJbe7OHh5/EMknW2ZgQJ3Zk2YDvQibCn7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288490; c=relaxed/simple;
	bh=aG5jGCB1iABIl8CtNw5VnBcyqvabphYCjqoQwNwdImI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNrxPLhf7aYewTlT6LTUB3RUJMevpWUS6dKyH8fuBgVAuyF4L0jSL77+yvyb1sg6SgirPmkgE4sE+woJTTHz3k1GGyODkJIKpaFihVepczZ34t+bi644IQregFTDuMNY1r3i1g+Q4X9v77+vwamq/nuFVl5jC2jgF/JvZud4sPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sYTEzPrM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so13652a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718288488; x=1718893288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOn7hiM8kuTAVwrSuZ2ykZPt8TnaEO51DR1HZvc1lh4=;
        b=sYTEzPrMqvRMzzZuYcLjTzj9AUPJmIV0emCpuYrAkkIL1DgcVHH4ChQsxqA7F4S8RZ
         hbxa9DiDkkTWQqLT/VhDunVoS11OiMj09eBBNRf8kcq7SuyWw/SSoTSTCfjJqiRi8uJp
         baBeJvla2Gz8ot7mZp3b2uDObMIDvK36IFKsFw2NUJYXJNUhuN3hskhPHdYx/kZk5Jgi
         oJX8dF2T3XSS73Ew1L6LRA4Gdbx2cm/6moB1/AL+Scdz5w7HvmbGj4z1WXuIzN5Sietc
         XMrQKxW4r7f6jCNavWJp0ewANOWNqf4/Zi2/lSiZA5Qv9bVxybksTbp47EJjNNthNy4K
         bc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288488; x=1718893288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOn7hiM8kuTAVwrSuZ2ykZPt8TnaEO51DR1HZvc1lh4=;
        b=PxvA/TLekPthz4GAlG/0ibDmYbyG9VB8C86hsxh0vEwLaS4w8winnSdpdLf2kEVP1y
         ZWfCvZ9zrQBsJ2IS3li9r9W9GvwNU0Ap5qF25Kd6MY8d7Gdg4RhtPeRk+aA2R5Cp5zNz
         5Azxm6LxmT2/JnxhF7K7VXXSWBGr7HQpn7RSorauqUjZCBCddHaImpcW5XaZ3Q+Q5z/W
         vVIiS1lL6eE9CD+GGOtHsjaB8ESfpyRgjulq6+CL5mTBSt1zbtitJlN3HReCYUlr6rLt
         Gx5LHGNpOOOimvABFUbkP24ObPMeiaZVRohmxpijdxGTrs6BMQ00nvXZ5vWX5Fo03pp6
         WMhg==
X-Gm-Message-State: AOJu0YxPns669HTzNaQ9IhXz6RhsojxBUuiuV1bQJTNqd4Ba5QFzZGFB
	v1vXVBPUH6MiGMKwWsSmEpDl55S8Jmwve+JlvFBpKGxgWb/q+XVohofJusMPrBSSBk252MIT6MM
	yo9KEUUWY4C/kB8b26n4i5g4uCWLk4hb6WjKNLTWKii4vZneIfsoq
X-Google-Smtp-Source: AGHT+IE0enr0hZ6HvjI1+ygD4KomBwNaa+/zEmSRvxMnqImakgZMM2Fr2OfOhWrdmFIl4VUBa6yQXtxXeTdt35/dckM=
X-Received: by 2002:a05:6402:40c4:b0:57c:9853:589f with SMTP id
 4fb4d7f45d1cf-57cb58f33acmr293977a12.2.1718288487435; Thu, 13 Jun 2024
 07:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com>
 <20240613062927.54b15104@kernel.org>
In-Reply-To: <20240613062927.54b15104@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 13 Jun 2024 16:21:15 +0200
Message-ID: <CANP3RGcovrwKpuM-o=V2OYosdb6Xyy+tRM3Qrp3pF7RctEm6LQ@mail.gmail.com>
Subject: Re: Some sort of netlink RTM_GET(ROUTE|RULE|NEIGH) regression(?) in
 6.10-rc3 vs 6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux NetDev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 13 Jun 2024 14:18:41 +0200 Maciej =C5=BBenczykowski wrote:
> > The Android net tests
> > (available at https://cs.android.com/android/platform/superproject/main=
/+/main:kernel/tests/net/test/
> > more specifically multinetwork_test.py & neighbour_test.py)
> > run via:
> >   /...aosp-tests.../net/test/run_net_test.sh --builder
> > from within a 6.10-rc3 kernel tree are falling over due to a *plethora*=
 of:
> >   TypeError: NLMsgHdr requires a bytes object of length 16, got 4
> >
> > The problems might be limited to RTM_GETROUTE and RTM_GETRULE and RTM_G=
ETNEIGH,
> > as various other netlink using xfrm tests appear to be okay...
> >
> > (note: 6.10-rc3 also fails to build for UML due to a buggy bpf change,
> > but I sent out a 1-line fix for that already:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240613112520.152=
6350-1-maze@google.com/
> > )
> >
> > It is of course entirely possible the test code is buggy in how it
> > parses netlink, but it has worked for years and years...
> >
> > Before I go trying to bisect this... anyone have any idea what might
> > be the cause?
> > Perhaps some sort of change to how these dumps work? Some sort of new
> > netlink extended errors?
>
> Take a look at commit 5b4b62a169e1 ("rtnetlink: make the "split"
> NLM_DONE handling generic"), there may be more such workarounds missing.

Ok, I sent out 2 patches adding the flag in 3 more spots that are
enough to get both tests working.

The first in RTM_GETNEIGH seems obvious enough.

$ git grep rtnl_register.*RTM_GETNEIGH,
net/core/neighbour.c:3894:      rtnl_register(PF_UNSPEC, RTM_GETNEIGH,
neigh_get, neigh_dump_info,
net/core/rtnetlink.c:6752:      rtnl_register(PF_BRIDGE, RTM_GETNEIGH,
rtnl_fdb_get, rtnl_fdb_dump, 0);
net/mctp/neigh.c:331:   rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETN=
EIGH,

but there is also PF_BRIDGE and PF_MCTP... (though obviously the test
doesn't care)
(and also RTM_GETNEIGHTBL...)

The RTM_GETRULE portion of the second one seems fine too:

$ git grep rtnl_register.*RTM_GETRULE
net/core/fib_rules.c:1296:      rtnl_register(PF_UNSPEC, RTM_GETRULE,
NULL, fib_nl_dumprule,

but I'm less certain about the GET_ROUTE portion there-of... as
there's a lot of hits:

$ git grep rtnl_register.*RTM_GETROUTE
net/can/gw.c:1293:      ret =3D rtnl_register_module(THIS_MODULE,
PF_CAN, RTM_GETROUTE,
net/core/rtnetlink.c:6743:      rtnl_register(PF_UNSPEC, RTM_GETROUTE,
NULL, rtnl_dump_all, 0);
net/ipv4/fib_frontend.c:1662:   rtnl_register(PF_INET, RTM_GETROUTE,
NULL, inet_dump_fib,
net/ipv4/ipmr.c:3162:   rtnl_register(RTNL_FAMILY_IPMR, RTM_GETROUTE,
net/ipv4/route.c:3696:  rtnl_register(PF_INET, RTM_GETROUTE,
inet_rtm_getroute, NULL,
net/ipv6/ip6_fib.c:2516:        ret =3D
rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
net/ipv6/ip6mr.c:1394:  err =3D rtnl_register_module(THIS_MODULE,
RTNL_FAMILY_IP6MR, RTM_GETROUTE,
net/ipv6/route.c:6737:  ret =3D rtnl_register_module(THIS_MODULE,
PF_INET6, RTM_GETROUTE,
net/mctp/route.c:1481:  rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETR=
OUTE,
net/mpls/af_mpls.c:2755:        rtnl_register_module(THIS_MODULE,
PF_MPLS, RTM_GETROUTE,
net/phonet/pn_netlink.c:304:    rtnl_register_module(THIS_MODULE,
PF_PHONET, RTM_GETROUTE,

It seems like maybe v4 and both mr's should be changed too?

