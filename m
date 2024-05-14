Return-Path: <netdev+bounces-96299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F98C4E2C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D711C21826
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299738F86;
	Tue, 14 May 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqk1d31i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEE20DC8
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676708; cv=none; b=DqknaI8VJF0FXn1SE6JSaw6XZmcXDdkLMooJ0yeOW8tJlNC6CqGBHueKFclfe5GLFZVjHHRWhoABmobLIfVV0c+zxD0BVBHE0O79YpteRLaFMLc2a8HnmiYKCWBk40GgUADimbBaOgbrPgXGRglNG7GlObNjHxlRBxx/0AL5wmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676708; c=relaxed/simple;
	bh=9nzv+FqdOTuaznUZ9jH646/N59aLyj4TozOVbkjWFmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AupuSdAzYtvRXZrf/hZ8/nEp4tqZnnNyFZxyFFY2UgKa4g6zhpaYYQUDU9Lx2YbDxa9XNCMxrrGgOBMKEMBMxs2PI9kR5fxDLCAbaTzQxlQOhdJrlQvUynfudOyHrQE5fILeWj7Aboy9Y/iUht5uRsUZta1HzYPrDDVB3ck6KWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqk1d31i; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso9399a12.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715676705; x=1716281505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2wG2U3c2+FDHIe8u0+K8f36+tgO9JEI+G+ZeYBRmRc=;
        b=iqk1d31iDQBnhOZYLUKetL5wTfWjHPQ6RFXIwFE55Wc2+8tQlowMI1KVu3fO7l9mZf
         iWyqcQUR15pM3sjdw9kTXJ6zyUGh/kawf1Wh7Zj4Bp3gnSPqhtwytUcJPMGWLIqwBr2t
         Cds1mjQ7bESTJ+goX7RzjuT3bWDDAShU2lDvQu/fAuevQRdff3l8flyrKvM6T96tufRZ
         ytTw/3KvcUROYWD615RjnM+G4QIgVCPQmwj7I3zGcs4blMo1xPwUK0m8KnFxpyWrE1IA
         SAmN15368kx+WoRId+EqHZi08XKI99zcDoODqRHANFBg5ZZJa9t5lY+h5nk5NHHpKNsC
         rfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676705; x=1716281505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2wG2U3c2+FDHIe8u0+K8f36+tgO9JEI+G+ZeYBRmRc=;
        b=beAQzWBTC+8BaxWxULhsBCxAtc6tUpCSUFN4Z7J5QB59UGaCpHqc7oOMp9ozH9nkA0
         RGB05sulNsEFDELYQcTEMV/MggyftGYWFpGaBUdqr490oIJB8jO0AExHTwpFdjn2SoiJ
         HyUYbJu7vt+JoJvQNCRiosTTm/dQJLvMbW8pfz1XGDzGArP4vtb1ze5TiDmdR4GGUeNu
         SAxH6j+jUCr6lRCwCxAxouq20IREkAwHwPdCw+p/51tnyT1Z4EFwxvxtFMm/SYeuAz5g
         B8PkylPD2+cYUGkMhPcBfbmnjuln9vJelTgT34DweKHdRljnA7yjgl4jpF2c635VE7Sx
         PIVw==
X-Forwarded-Encrypted: i=1; AJvYcCWw3m3F4f4VpS4KSJou/yqDVdm/29Cp2HoGxrejpbGz9uFkP2T2UOdQCc7AR26Nd0ZHXo9PYjVpAFjqd75+a6AWmm/kzzlv
X-Gm-Message-State: AOJu0Yyrq8Rm4D4pUC8A1l6OkjI5WISeVQpyM6AU8b3FIn8kFJy1iK8s
	ZPk8MQQa+WaWwBIAefGcwON8+YmLdT5zh37/cFtgHJLm/KK0r+XZfBOOEha1huQaTYUwZ1Za4KG
	J78OCmWGXcF531WZVLJDDNIyZkv4GkvZSGIJw
X-Google-Smtp-Source: AGHT+IGgbme1c+f1lMya42TczEw74+mAFREzD6WZrZL7Bzk6ya0h4HuQwd1KKvZJw3AvJzm8TqzHZHkj9NbowRz5jGo=
X-Received: by 2002:a50:85c6:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-574ae418342mr516512a12.1.1715676704821; Tue, 14 May 2024
 01:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513100246.85173-1-jianbol@nvidia.com> <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
In-Reply-To: <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 10:51:30 +0200
Message-ID: <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
To: Jianbo Liu <jianbol@nvidia.com>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, Leon Romanovsky <leonro@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "fw@strlen.de" <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:37=E2=80=AFAM Jianbo Liu <jianbol@nvidia.com> wro=
te:
>
> On Mon, 2024-05-13 at 12:29 +0200, Eric Dumazet wrote:
> > On Mon, May 13, 2024 at 12:04=E2=80=AFPM Jianbo Liu <jianbol@nvidia.com=
> wrote:
> > >
> > > In commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> > > per-cpu lists"), skb can be queued on remote cpu list for deferral
> > > free.
> > >
> > > The remote cpu is kicked if the queue reaches half capacity. As
> > > mentioned in the patch, this seems very unlikely to trigger
> > > NET_RX_SOFTIRQ on the remote CPU in this way. But that seems not
> > > true,
> > > we actually saw something that indicates this: skb is not freed
> > > immediately, or even kept for a long time. And the possibility is
> > > increased if there are more cpu cores.
> > >
> > > As skb is not freed, its extension is not freed as well. An error
> > > occurred while unloading the driver after running TCP traffic with
> > > IPsec, where both crypto and packet were offloaded. However, in the
> > > case of crypto offload, this failure was rare and significantly more
> > > challenging to replicate.
> > >
> > >  unregister_netdevice: waiting for eth2 to become free. Usage count =
=3D
> > > 2
> > >  ref_tracker: eth%d@000000007421424b has 1/1 users at
> > >       xfrm_dev_state_add+0xe5/0x4d0
> > >       xfrm_add_sa+0xc5c/0x11e0
> > >       xfrm_user_rcv_msg+0xfa/0x240
> > >       netlink_rcv_skb+0x54/0x100
> > >       xfrm_netlink_rcv+0x31/0x40
> > >       netlink_unicast+0x1fc/0x2c0
> > >       netlink_sendmsg+0x232/0x4a0
> > >       __sock_sendmsg+0x38/0x60
> > >       ____sys_sendmsg+0x1e3/0x200
> > >       ___sys_sendmsg+0x80/0xc0
> > >       __sys_sendmsg+0x51/0x90
> > >       do_syscall_64+0x40/0xe0
> > >       entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > >
> > > The ref_tracker shows the netdev is hold when the offloading xfrm
> > > state is first added to hardware. When receiving packet, the secpath
> > > extension, which saves xfrm state, is added to skb by ipsec offload,
> > > and the xfrm state is hence hold by the received skb. It can't be
> > > flushed till skb is dequeued from the defer list, then skb and its
> > > extension are really freed. Also, the netdev can't be unregistered
> > > because it still referred by xfrm state.
> > >
> > > To fix this issue, drop this extension before skb is queued to the
> > > defer list, so xfrm state destruction is not blocked.
> > >
> > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu
> > > lists")
> > > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> >
> >
> > This attribution and patch seem wrong. Also you should CC XFRM
> > maintainers.
> >
> > Before being freed from tcp_recvmsg() path, packets can sit in TCP
> > receive queues for arbitrary amounts of time.
> >
> > secpath_reset() should be called much earlier than in the code you
> > tried to change.
>
> Yes, this also fixed the issue if I moved secpatch_reset() before
> tcp_v4_do_rcv().
>
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2314,6 +2314,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>         tcp_v4_fill_cb(skb, iph, th);
>
>         skb->dev =3D NULL;
> +       secpath_reset(skb);
>
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 ret =3D tcp_v4_do_rcv(sk, skb);
>
> Do you want me to send v2, or push a new one if you agree with this
> change?

That would only care about TCP and IPv4.

I think we need a full fix, not a partial work around to an immediate probl=
em.

Can we have some feedback from Steffen, I  wonder if we missed
something really obvious.

It is hard to believe this has been broken for such  a long time.

I think the issue came with

commit d77e38e612a017480157fe6d2c1422f42cb5b7e3
Author: Steffen Klassert <steffen.klassert@secunet.com>
Date:   Fri Apr 14 10:06:10 2017 +0200

    xfrm: Add an IPsec hardware offloading API

    This patch adds all the bits that are needed to do
    IPsec hardware offload for IPsec states and ESP packets.
    We add xfrmdev_ops to the net_device. xfrmdev_ops has
    function pointers that are needed to manage the xfrm
    states in the hardware and to do a per packet
    offloading decision.

    Joint work with:
    Ilan Tayari <ilant@mellanox.com>
    Guy Shapiro <guysh@mellanox.com>
    Yossi Kuperman <yossiku@mellanox.com>

    Signed-off-by: Guy Shapiro <guysh@mellanox.com>
    Signed-off-by: Ilan Tayari <ilant@mellanox.com>
    Signed-off-by: Yossi Kuperman <yossiku@mellanox.com>
    Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

We should probably handle NETDEV_DOWN/NETDEV_UNREGISTER better,
instead of adding  secpath_reset(skb) there and there.

