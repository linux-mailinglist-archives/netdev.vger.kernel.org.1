Return-Path: <netdev+bounces-73764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEF85E448
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F68B2161E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9C83A1F;
	Wed, 21 Feb 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgKCQcl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90D80BE5
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535728; cv=none; b=u+JrC2fpb2NCJdgNu4DTmg/+ma0xRzpOzkWFtVZTNovGrUVVVENOaUSpCUyUBeT1nBcRBWiMzoPj2yKoq2qp6UTtLBLqbjN4g6TtVnLQfX2XiOt6s9OcJAR94upO6a69ur7xxjdub3MYGqoXkMgZqi0lR+Gm2foRPQ+fz8OjRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535728; c=relaxed/simple;
	bh=V4FucYCLdRJ4fRfrhfFwWH/KsbOk4o/3OH55/PTmdNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su0yD95FiF9ri/ZMVDAOzsObSu3F7G/jgtyS3QkDTUlAvXhLLlzMnnBJpU3LheCN3uGe0uZGIzvqtsXHCiDSbhahq9sodJ+D9Bnz1/ZYWPtCLpaIzwo/yvP9P08QvGgPEGLOliU+6YjN50PqZhSsw/3NuULhZgfAETNDX3SCs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgKCQcl7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso13890a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708535725; x=1709140525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PdWSX7ZdwxbSQz6qVesoZ+BsTQkY/zgtt4zLFqnttc=;
        b=LgKCQcl7GL84nLFji37b1BV++M/kkrUfju3J6VZx/H/CQBtULukdGehMuGRjaw+7Sw
         M2ugEIZO/t1Tn+yfluaZkG3OHeEaZXcJcanyjIcQJPMoplxD+ss+kOIvtIqmpa7j01df
         HoR4LIipOu9sy8B6RERumrVE7+EtBx/Qd86ksS6nP6Pag4REGRdx/E4Y0TnbwXlomFET
         LPvAY6568hdRDlQmtu8cNYUA/3MStYJuhiuiJnmPTbwO6mjWf/ScTdgegvGnsgWmT3OS
         fJ6bnjKabNx//bzrZ479ol1sBCajYJERWoWdXQkH1AAEq2REzST/1ZhouWUwkQ9/IKxu
         23Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535725; x=1709140525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PdWSX7ZdwxbSQz6qVesoZ+BsTQkY/zgtt4zLFqnttc=;
        b=gsv+6SCe21XAaEIpnO0OfZaHg1J/8CU3WTMhh8Ft3rL81ygvkm0QObsuUAAqeGmHGq
         Gzfhe9/CzodcEgGGsNnnxWSzpYfpAd8/717Aip60csxcsv8ut72giegiE+0lE4GQrgYm
         lB+osdWHjiIIpAPsN8l5qSpwJTp2FfzBUYmBhPlHd3a7TgEwwR3SjybJISW1lcLtBzG4
         uyD2nyc4Lxg7oKcpTAnkPGL7idcwLu0iQ0UZl3k1oQOmI/FbaLRH0YH0zRX/DcM5M3YG
         02Ccmwp0b/cStLIMc8ByK/5Fdrlu8JG3XYwHBDQqOQzJicajRbd/yA2PPe358xWoJFbq
         bFSw==
X-Forwarded-Encrypted: i=1; AJvYcCXsyisK4A0fGal83vlCGmrQ0vzw+6Jmcp3ni/32014u4OfUOla9KCHZC5UH0nmzXHyi3sNrYbYwsKLM+hw0u235jgsltcDg
X-Gm-Message-State: AOJu0YxhYq6iL3HXr8NrCg050YcAWqVO//u5VPNATpSiMeLIBQgEeMCm
	eGxFheVU5ul+AefYn7c07gDkRG0Y7lHjTKIsjl8rh9tvfbtpGYWwK5KvW+LAFWdduUodK9WIE9y
	F09k/S956y1hjK+ohio55euzjEiRxrXWtRs23
X-Google-Smtp-Source: AGHT+IHz7zUcpoWDPdu3wExBB7CAp0UWx01q7OwFlzjipVr6Ilj7BAhFigxwmoPBzR7FOrEMwdRbhy+bUDhIeLHRQq0=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr227985edf.6.1708535724913; Wed, 21 Feb
 2024 09:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com> <20240221105915.829140-13-edumazet@google.com>
 <ZdYes3iPqzf0FCTf@nanopsycho>
In-Reply-To: <ZdYes3iPqzf0FCTf@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 18:15:11 +0100
Message-ID: <CANn89i+CvOVkaiXuO5vgggHdzVP17Yzw1WaiH93-fjf2cqnN_A@mail.gmail.com>
Subject: Re: [PATCH net-next 12/13] rtnetlink: make rtnl_fill_link_ifmap() RCU ready
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:03=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Feb 21, 2024 at 11:59:14AM CET, edumazet@google.com wrote:
> >Use READ_ONCE() to read the following device fields:
> >
> >       dev->mem_start
> >       dev->mem_end
> >       dev->base_addr
> >       dev->irq
> >       dev->dma
> >       dev->if_port
> >
> >Provide IFLA_MAP attribute only if at least one of these fields
> >is not zero. This saves some space in the output skb for most devices.
> >
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >---
> > net/core/rtnetlink.c | 26 ++++++++++++++------------
> > 1 file changed, 14 insertions(+), 12 deletions(-)
> >
> >diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >index 1b26dfa5668d22fb2e30ceefbf143e98df13ae29..b91ec216c593aaebf97ea69a=
a0d2d265ab61c098 100644
> >--- a/net/core/rtnetlink.c
> >+++ b/net/core/rtnetlink.c
> >@@ -1455,19 +1455,21 @@ static noinline_for_stack int rtnl_fill_vf(struc=
t sk_buff *skb,
> >       return 0;
> > }
> >
> >-static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device =
*dev)
> >+static int rtnl_fill_link_ifmap(struct sk_buff *skb,
> >+                              const struct net_device *dev)
> > {
> >       struct rtnl_link_ifmap map;
> >
> >       memset(&map, 0, sizeof(map));
> >-      map.mem_start   =3D dev->mem_start;
> >-      map.mem_end     =3D dev->mem_end;
> >-      map.base_addr   =3D dev->base_addr;
> >-      map.irq         =3D dev->irq;
> >-      map.dma         =3D dev->dma;
> >-      map.port        =3D dev->if_port;
> >-
> >-      if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
> >+      map.mem_start =3D READ_ONCE(dev->mem_start);
> >+      map.mem_end   =3D READ_ONCE(dev->mem_end);
> >+      map.base_addr =3D READ_ONCE(dev->base_addr);
> >+      map.irq       =3D READ_ONCE(dev->irq);
> >+      map.dma       =3D READ_ONCE(dev->dma);
> >+      map.port      =3D READ_ONCE(dev->if_port);
> >+      /* Only report non zero information. */
> >+      if (memchr_inv(&map, 0, sizeof(map)) &&
>
> This check(optimization) is unrelated to the rest of the patch, correct?
> If yes, could it be a separate patch?

Sure thing. BTW, do you know which tool is using this ?

I could not find IFLA_MAP being used in iproute2 or ethtool.

