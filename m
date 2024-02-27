Return-Path: <netdev+bounces-75309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E0869167
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44CD1F257A8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1F13AA46;
	Tue, 27 Feb 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWVcNtax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A31332A7
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039404; cv=none; b=dBTiYyuXJtjQFRRZR5ZoR+Yk4u4C1f0Ve/g8o+MOHVf/Ip3x4MlWOxWkxHA8rBZwk4ffMjH84yOLdQPu7QBsxE33jmR413UrRDjGBbdeX2Qxxc/tfXRozB9Og0c0ZQXpA0e+QP6gHLdDdLh7Qen+WIS3PIAKO75fbq+sUwGeEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039404; c=relaxed/simple;
	bh=m718oK75YUlj1SMvsaSedaBW/4Z37JTTujIcDLBaVJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkMqGfqfGab2xGs84nD7gYQwJq3RBFV1DmrbLqRdCboDOjG33tFXkLNfbuYZfSKRKlzYypEcNX2IQLjuTQ6lPHgNl04wJh34Gd6L79zZxgz6SkvrmjjddZiyqA/yFgrmdpPbSxNoPNkpD+eK1Mzqyi2r2CtfFGVFebjsd6NeHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWVcNtax; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so5146a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709039401; x=1709644201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzdy4TtO8iFnfjG/rX2yWnJjv3HU9SHrhUmiZOAgn+Y=;
        b=VWVcNtaxhMhI/oBzznwNlyJdwjbO7psnn5kZgAc71/+ev9ooyNsC0DeOUm6OS5vY8s
         3gQgrU2FiJ2NBZ9VbbrJFgZzsB+uhq7yAJA44+9fQPi9nizlBpUGtovjldYprlelAdWz
         7d5KqI/XSKHzJjuVnyKz/3JUvTNQoWB+oDg/QXuTM5NSHOGxkBHUODIiVdRA/gHTeRM8
         ypg6BUFfXX/vQ3dRd3Bsu4TSjJsnxsmxRkAvFlXZtyt5JTxYgCwBEJhDaBeqTPLmxVCj
         c9GDprLWr7LZHIuC6gJZDvEZK2nZgd+eAhF6Zm75rZu6wr025xEuIoGfxtymwBqp4XJ/
         M9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039401; x=1709644201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzdy4TtO8iFnfjG/rX2yWnJjv3HU9SHrhUmiZOAgn+Y=;
        b=wOb2/BWGS40D3QoiB+MdUjw4jjR+2Vm1sBsXSa6VJJ/L2NFqER107MQPlWE3sIOG70
         o7daertRZSLaT+NE3BcSPA3/FIEZ3b6PjpwAc5M0QBrmm3u+C8OAMQMzboSGO4zFXfJ5
         HN777xA5IG/jwVoagjR5T+lF3E0bnygF6eFLuGXmK+pxWtsQwgfeg+ILKppmwaVCJo7c
         kiijlLNCKNabrBdpBzpWCw7jv50ErhSlY8XqKW7LqdQ3jNw0Cx8HFBcCPJYaEhmOs1NQ
         Kc+yb2wt8lUMIxYHlqwz4NFiglI4fx9UM1hHVOv8CKXy84ocfYvIovPWZ/xP8iK51Zlh
         0+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWAdjjo0c1JVVRM5dbBz6io+AxZSd58BuUcx3XbO+np3GXNsNAPcwoMJZcHtkviUHYRFkjz7uwEk21gUeYZ+StKDkInszSH
X-Gm-Message-State: AOJu0Yw2T3z2SpT1FdPFgAtdcDIbZptMBJ1Ueu/REjgeWA8qlgEbog1M
	ECecsSbk9xCKw9AyRLoOCUctVImcJkMhkM8IzrGAD2TXPd6s5hJ55ynxBUySZKScHI+1IlJ+jaN
	Jv0y0+GG8WxGohSf3k/Dc6NgFdIeuzz+pesl4OXTMdvgnNdYqmlaO
X-Google-Smtp-Source: AGHT+IHCs6kC0uKuWqU4u+xIGZAbOkv9IzefsWfpHYl4jDxIHl+sVRYkDPZmOlDoUoS9nowtjAmgsTX7bFauk2cp3WU=
X-Received: by 2002:a50:9e2a:0:b0:565:4c2a:c9b6 with SMTP id
 z39-20020a509e2a000000b005654c2ac9b6mr216298ede.0.1709039400512; Tue, 27 Feb
 2024 05:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227092411.2315725-1-edumazet@google.com> <20240227092411.2315725-3-edumazet@google.com>
 <Zd3cn-kct8PdrvGg@nanopsycho>
In-Reply-To: <Zd3cn-kct8PdrvGg@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 14:09:49 +0100
Message-ID: <CANn89i+TfGnpBthoix4QmfC6hEsEH0HdYnAowMPeNz0z+4qUjw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] inet: do not use RTNL in inet_netconf_get_devconf()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:59=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Feb 27, 2024 at 10:24:10AM CET, edumazet@google.com wrote:
> >"ip -4 netconf show dev XXXX" no longer acquires RTNL.
>
> I was under impression that you refer to the current code, confused me a
> bit :/
>
>
> >
> >Return -ENODEV instead of -EINVAL if no netdev or idev can be found.
> >
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >---
> > net/ipv4/devinet.c | 27 +++++++++++++++------------
> > 1 file changed, 15 insertions(+), 12 deletions(-)
> >
> >diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> >index ca75d0fff1d1ebd8c199fb74a6f0e2f51160635c..f045a34e90b974b17512a30c=
3b719bdfc3cba153 100644
> >--- a/net/ipv4/devinet.c
> >+++ b/net/ipv4/devinet.c
> >@@ -2205,21 +2205,20 @@ static int inet_netconf_get_devconf(struct sk_bu=
ff *in_skb,
> >                                   struct netlink_ext_ack *extack)
> > {
> >       struct net *net =3D sock_net(in_skb->sk);
> >-      struct nlattr *tb[NETCONFA_MAX+1];
> >+      struct nlattr *tb[NETCONFA_MAX + 1];
> >+      const struct ipv4_devconf *devconf;
> >+      struct in_device *in_dev =3D NULL;
> >+      struct net_device *dev =3D NULL;
> >       struct sk_buff *skb;
> >-      struct ipv4_devconf *devconf;
> >-      struct in_device *in_dev;
> >-      struct net_device *dev;
> >       int ifindex;
> >       int err;
> >
> >       err =3D inet_netconf_valid_get_req(in_skb, nlh, tb, extack);
> >       if (err)
> >-              goto errout;
> >+              return err;
> >
> >-      err =3D -EINVAL;
> >       if (!tb[NETCONFA_IFINDEX])
> >-              goto errout;
> >+              return -EINVAL;
> >
> >       ifindex =3D nla_get_s32(tb[NETCONFA_IFINDEX]);
> >       switch (ifindex) {
> >@@ -2230,10 +2229,10 @@ static int inet_netconf_get_devconf(struct sk_bu=
ff *in_skb,
> >               devconf =3D net->ipv4.devconf_dflt;
> >               break;
> >       default:
> >-              dev =3D __dev_get_by_index(net, ifindex);
> >-              if (!dev)
> >-                      goto errout;
> >-              in_dev =3D __in_dev_get_rtnl(dev);
> >+              err =3D -ENODEV;
> >+              dev =3D dev_get_by_index(net, ifindex);
>
> Comment says:
> /* Deprecated for new users, call netdev_get_by_index() instead */
> struct net_device *dev_get_by_index(struct net *net, int ifindex)

Only for long-standing allocations, where we are not sure if a leak
could happen or not.
We do not bother allocating a tracker otherwise.
Look at inet6_netconf_get_devconf() :
We left there dev_get_by_index() and dev_put().

I think I am aware of the tracking facility, I implemented it...


>
> Perhaps better to use:
> netdev_get_by_index() and netdev_put()?
>
>
> >+              if (dev)
> >+                      in_dev =3D in_dev_get(dev);
>
> The original flow:
>                 err =3D -ENODEV;
>                 dev =3D dev_get_by_index(net, ifindex);
>                 if (!dev)
>                         goto errout;
>                 in_dev =3D in_dev_get(dev);
>                 if (!in_dev)
>                         goto errout;

A single goto looks nicer to me.

> Reads a bit nicer to me. Not sure why you changed it. Yeah, it's a nit.
>

