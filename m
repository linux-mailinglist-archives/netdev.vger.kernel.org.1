Return-Path: <netdev+bounces-156965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80AA086EB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433DB18891A6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488A188A3A;
	Fri, 10 Jan 2025 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNMEPIJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1048F54
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488166; cv=none; b=PgVKBebgf7DcAiTR+OZwnR8n6bnbJvWxe4PdRcboP3f8vwxI5O10SuDLwLwleQmR7ahh6HXEq7pP871UvfsSdO8QLOcYac9PactiX9+9WZMzE1eNKgShfyw6KQM28Svcnr1VX7NNoje6Rhwc0/j9h/48C0qIbXph5wibO8UzSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488166; c=relaxed/simple;
	bh=8b00Yx0wyHCMbTL/WN/gW/qBKKyurk3KYhzHtJ7gx84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPgW8MSGom9WFVYVrAVcS4aCvdM6j1Kx7mtj1ZLOdAuu92z80igdmHV9hIMwg3NuSb6CLHjfnfyJqYJVUKxJXzXOoasd/LijIPZzLr1N3KLOGWJotKscTiIJ5Hf8pWWO4DwAGL4b1h/vq5A2tZ9Xe1+FF8fG6tHkP8/PIo2QGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNMEPIJa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso3078646a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 21:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736488163; x=1737092963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl51CYmAfmuKsWnsTgarutF4jx8ZUpVvR5qW6GOB9bw=;
        b=zNMEPIJauFDIDBFe3XJjlfv/FsLjz9A+MfFhFpbagyU+VQK63Ygw/Y/ii2Q8SHqjja
         BKQ9NBtNhdVglRT355PY1lTCqQonU8izPNys6ecfqlhBaXrlb2DIMs6hj4b8+emc1NZ4
         6Qr2IkX5eQa5cnv3EjfarG+xoHUG6XQqS35i80vnsadN5di0Oo7b893AIPhBRISqoBIX
         A7rZA9McwUqfWAzpax0eSIRYbfUHSuvAqzyuZ4p5kl+3z6sk+6OOp8p7WFwA1ocBysKO
         Iy8H5EQp3G46MhSgfRD3Qv/fMtutB8Hhn1X+mJMJ+d5CnWlrWLlGr4Cto7xazYhkfkKY
         0aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736488163; x=1737092963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl51CYmAfmuKsWnsTgarutF4jx8ZUpVvR5qW6GOB9bw=;
        b=nPCO1rsWEr7yFdwu+HjSy+DgAq+axoojXTcQKDnaNmK173+ggS98UA27Wbv/Z8oGbt
         6BaA7cCQx8wxjfz7GgD8oWY3GX3s2H3wk8/SxVPpxLMSL3yDhXoPBHNvw44hC+z7zrmC
         /M4BSlMqF1Fbwsh9ME491pMeQpQzF5VgaLZiMYSYSF++/fLK7tGZeHwVboAh4WwHZccr
         vmr/SjV4kJy6x25SR1lc1Dxp53xNHSzttsAM1Fe9q/NAxURmcbWdBczYI3VX5yytsbVa
         yBdpFJP6yOWGXF8+NUdUFL+/uOU8oikQVz5kSjARMHOT2Y3HJblZQhRZLxd2uCU86tY8
         RQNw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/ewdOAppkmTfi8m9J6IkgQ0PXQbYnfb88s8Z53Dqrw4yMGYXju/JJrkp+W6lTjIUd1ySYhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGlfhLBxAXRumyCw2G8QClabnH4YWlsN0gKR8an2cVOjiBWpb
	lYvPXLaw+npnFb6OFO2W5soqxWS0uBMncnh3ffWjENtg0opN2oF3siJ8WaretY4IqI+DG2PzcW9
	jsi7bM8XubzxD/xgcr37zFeh0sooY/xz31bT6
X-Gm-Gg: ASbGncttztzfFp6BTUgjKpXB9DGTEhWQ/ZOOHBWZViGYQsxFpbZ+FllLUZnn+yq8Poo
	oGk/cr+VUka8UPnt+d5i34yq1dKWROybyTocM
X-Google-Smtp-Source: AGHT+IF7cDTA2uoUOlwMqHC/VPJ5LqMtWbHfwHGuYhqYUSpe7472xSEVUCV5Xh45OAJ/jdSztX93tXLZ47kTmTTEoac=
X-Received: by 2002:a05:6402:2814:b0:5d9:a91:3382 with SMTP id
 4fb4d7f45d1cf-5d972e4ee02mr8019134a12.21.1736488162625; Thu, 09 Jan 2025
 21:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109171850.2871194-1-edumazet@google.com> <Z4CxKV5AnfDPRfaF@pop-os.localdomain>
In-Reply-To: <Z4CxKV5AnfDPRfaF@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Jan 2025 06:49:11 +0100
X-Gm-Features: AbW1kvabC-kcX2lV94xNlz3WXfPsGrbKLNdYWAU8bhmBFUuMTR3QIkJNmWjTtSo
Message-ID: <CANn89iK7PzN6C4GXfwSasszdF1PyupR9xd7wsvoRiYrm0ARwtQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: calls synchronize_net() only when needed
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:33=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Thu, Jan 09, 2025 at 05:18:50PM +0000, Eric Dumazet wrote:
> > dev_deactivate_many() role is to remove the qdiscs
> > of a network device.
> >
> > When/if a qdisc is dismantled, an rcu grace period
> > is needed to make sure all outstanding qdisc enqueue
> > are done before we proceed with a qdisc reset.
> >
> > Most virtual devices do not have a qdisc (if we exclude
> > noqueue ones).
>
> Such as? To me, most virtual devices use noqueue:
>
> $ git grep IFF_NO_QUEUE -- drivers/net/
> drivers/net/amt.c:      dev->priv_flags         |=3D IFF_NO_QUEUE;
> drivers/net/bareudp.c:  dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/bonding/bond_main.c:        bond_dev->priv_flags |=3D IFF_BON=
DING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
> drivers/net/caif/caif_serial.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/dummy.c:    dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE | IFF_N=
O_QUEUE;
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        dev->priv_flags |=
=3D IFF_NO_QUEUE;
> drivers/net/ethernet/netronome/nfp/nfp_net_repr.c:      netdev->priv_flag=
s |=3D IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
> drivers/net/geneve.c:   dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE | IFF_N=
O_QUEUE;
> drivers/net/gtp.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/ipvlan/ipvlan_main.c:       dev->priv_flags |=3D IFF_UNICAST_=
FLT | IFF_NO_QUEUE;
> drivers/net/ipvlan/ipvtap.c:    dev->priv_flags &=3D ~IFF_NO_QUEUE;
> drivers/net/loopback.c: dev->priv_flags         |=3D IFF_LIVE_ADDR_CHANGE=
 | IFF_NO_QUEUE;
> drivers/net/macsec.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/macvlan.c:  dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/net_failover.c:     failover_dev->priv_flags |=3D IFF_UNICAST=
_FLT | IFF_NO_QUEUE;
> drivers/net/netdevsim/netdev.c:                    IFF_NO_QUEUE;
> drivers/net/netkit.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/nlmon.c:    dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/pfcp.c:     dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/team/team_core.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/veth.c:     dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/vrf.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/vsockmon.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/vxlan/vxlan_core.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/wan/hdlc_fr.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/wireguard/device.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> drivers/net/wireless/virtual/mac80211_hwsim.c:  dev->priv_flags |=3D IFF_=
NO_QUEUE;
>
>
> And noqueue_qdisc_ops sets ->enqueue to noop_enqueue():
>
> struct Qdisc_ops noqueue_qdisc_ops __read_mostly =3D {
>         .id             =3D       "noqueue",
>         .priv_size      =3D       0,
>         .init           =3D       noqueue_init,
>         .enqueue        =3D       noop_enqueue,
>         .dequeue        =3D       noop_dequeue,
>         .peek           =3D       noop_dequeue,
>         .owner          =3D       THIS_MODULE,
> };

Sure, but please a look at :

static int noqueue_init(struct Qdisc *qdisc, struct nlattr *opt,
struct netlink_ext_ack *extack)
{
        /* register_qdisc() assigns a default of noop_enqueue if unset,
        * but __dev_queue_xmit() treats noqueue only as such
        * if this is NULL - so clear it here. */
        qdisc->enqueue =3D NULL;
        return 0;
}

