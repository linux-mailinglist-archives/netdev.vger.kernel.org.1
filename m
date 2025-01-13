Return-Path: <netdev+bounces-157807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E528FA0BCE3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2523163497
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90B1FBBE8;
	Mon, 13 Jan 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thc/ses8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4825760
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784534; cv=none; b=VJtMYKk20irwuPDn8YH2IEOVETEDTy8AvTHR1SptmxV652mHdHZmL/Ejm5Asm2xFb4R2wElOClB0DgeWl9WCkdNFyqVca4L6wYb7lMYseGCF6iHqt81+6H4GPgURKTTMNk9a0/WqEPwcgWMairyxOJkKAzuvMHi+TgTCEl6DbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784534; c=relaxed/simple;
	bh=O923iFCRgHrd9/+yWUHb0K5kHroswxaz6CTJ9H7dM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd1p3fTG6A3ZHeIXLuwm9+nAzRJTzG3cKD3WYtHfD3CPY6wzAeeD8smycS7tKfsytpkPs1vgaB3ZJsDWpHigI5D3BnN3XMtxcfTZhrguq+whp5xbLUh8qC0279hylgqmz4OeNV/J6PFQSf7qyY9EC7kNVhBd72RuxvUKqdT4M9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=thc/ses8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8074684a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736784531; x=1737389331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSFbXPk7vYE+bxaCX2zLgvfp1hvdqNrA4z367H7Bxic=;
        b=thc/ses8h7P2w5W5mzgPgJzrjJ8txeiZZx3H8r2IWoR9Mj+Da5v4i+zo9cWZTTigNO
         +uCCjvoAA4rWgmULASADlCPaf0S4DTnZ/fEJzne+QJteMLJJCEFUgjGF91KQolM6CDEx
         xhQL6Y231AMpzdG240ocmt9BPZNOUKI5Lr4UmE72UT2qp3669WoXNNzVl0LVHLF0amlF
         nRsBtNdQMlHxoiFLTl97EHNdsn9/LSCLB98WHy3lGmbqfKKSqHUez2HPpWbuax6gNOxT
         4wvbeYsuB8XeOJ2j7filLSWgEWehsyEVkbN4QzwmrJAqbBVBFh8gARavl8AJtZf4Bzkt
         0zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784531; x=1737389331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSFbXPk7vYE+bxaCX2zLgvfp1hvdqNrA4z367H7Bxic=;
        b=GvxHZFyew+Mo+Uvbmxcoc0py+oXZT9+6thQEa3KQc51rKE+NJYMpw9/DmrvL2Xh1LL
         Fur34pGQp3z8H8WEgC5m6Bq1yNgBC35lkEf1Q4pg5bcVwkOrpuNQK9wXRZi/ezTAVuTj
         xc01EPmM8aSO60rWAdv2dqJlNUcqbmN/4nox4AFw9HniMmvlwWy4AIZsik1ZRfPIBnrp
         gUMcsiO78xypDdTP21CI04o3KcnR1EY6I3zb0KENinxVh6jOi0GmJvAg70RfqzZ0vHo4
         ZobxKUJryFgdoTJkD8PUJIe6k16w9j9mLHFX/OOkwP7YcNoQHCQo9NjwFZWp3PBl/GYM
         rxiw==
X-Forwarded-Encrypted: i=1; AJvYcCVhxsReydCjYzY4zhT8LMOX+y8F6oLs9uStoaY+HQbrHfLN/Q2G5JTkJG7J51AurFUI3DPsf8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrUUFGfN/t+UAFQjfjsScI1rwmWZWWHt4qHfV/1OcUkVIyF9X
	X4Qt5pvt20FGdabtCUpM86Tv9DHBjt28RUJMi0OUxYX9l5xxn6styzcl0OWIvpc1HVIv2ye6aLH
	NJCGAp6FyM3kSihHDRSI9FmYZ6HIrB62aYisF
X-Gm-Gg: ASbGncvm90Kh/kvFkNCXy7pPI6C+uHuAlM5jEHVrfl5QHP1y2F4kPiKN243eH6SJzV6
	1R06ZNq5hvnqCPUBK567LvN0UoC8k9L6MeggpjQ==
X-Google-Smtp-Source: AGHT+IE92IiIlxZe/vCbz1W3l+/D7/t7cX8hEkGueYRWyivh8yBVqVe2h8k0ttxlFNJrFQcUv3qqRiIoMO3DK6S/vZg=
X-Received: by 2002:a05:6402:388d:b0:5d0:d91d:c195 with SMTP id
 4fb4d7f45d1cf-5d972e708dcmr20528956a12.32.1736784531154; Mon, 13 Jan 2025
 08:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109171850.2871194-1-edumazet@google.com> <Z4CxKV5AnfDPRfaF@pop-os.localdomain>
 <CANn89iK7PzN6C4GXfwSasszdF1PyupR9xd7wsvoRiYrm0ARwtQ@mail.gmail.com>
In-Reply-To: <CANn89iK7PzN6C4GXfwSasszdF1PyupR9xd7wsvoRiYrm0ARwtQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 17:08:40 +0100
X-Gm-Features: AbW1kvZ2pFcE30ZGSSKB-px7JqTxfSj88QNNkodvCsj-ulS3Xqfcn9vTNnjCEUQ
Message-ID: <CANn89i+ioYk6_n1E5Y+vpsNR0Uxd5_foLpM9UCEQ_c05Sray7Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sched: calls synchronize_net() only when needed
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jan 10, 2025 at 6:33=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:18:50PM +0000, Eric Dumazet wrote:
> > > dev_deactivate_many() role is to remove the qdiscs
> > > of a network device.
> > >
> > > When/if a qdisc is dismantled, an rcu grace period
> > > is needed to make sure all outstanding qdisc enqueue
> > > are done before we proceed with a qdisc reset.
> > >
> > > Most virtual devices do not have a qdisc (if we exclude
> > > noqueue ones).
> >
> > Such as? To me, most virtual devices use noqueue:
> >
> > $ git grep IFF_NO_QUEUE -- drivers/net/
> > drivers/net/amt.c:      dev->priv_flags         |=3D IFF_NO_QUEUE;
> > drivers/net/bareudp.c:  dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/bonding/bond_main.c:        bond_dev->priv_flags |=3D IFF_B=
ONDING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
> > drivers/net/caif/caif_serial.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/dummy.c:    dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE | IFF=
_NO_QUEUE;
> > drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        dev->priv_flags=
 |=3D IFF_NO_QUEUE;
> > drivers/net/ethernet/netronome/nfp/nfp_net_repr.c:      netdev->priv_fl=
ags |=3D IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
> > drivers/net/geneve.c:   dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE | IFF=
_NO_QUEUE;
> > drivers/net/gtp.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/ipvlan/ipvlan_main.c:       dev->priv_flags |=3D IFF_UNICAS=
T_FLT | IFF_NO_QUEUE;
> > drivers/net/ipvlan/ipvtap.c:    dev->priv_flags &=3D ~IFF_NO_QUEUE;
> > drivers/net/loopback.c: dev->priv_flags         |=3D IFF_LIVE_ADDR_CHAN=
GE | IFF_NO_QUEUE;
> > drivers/net/macsec.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/macvlan.c:  dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/net_failover.c:     failover_dev->priv_flags |=3D IFF_UNICA=
ST_FLT | IFF_NO_QUEUE;
> > drivers/net/netdevsim/netdev.c:                    IFF_NO_QUEUE;
> > drivers/net/netkit.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/nlmon.c:    dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/pfcp.c:     dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/team/team_core.c:   dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/veth.c:     dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/vrf.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/vsockmon.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/vxlan/vxlan_core.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/wan/hdlc_fr.c:      dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/wireguard/device.c: dev->priv_flags |=3D IFF_NO_QUEUE;
> > drivers/net/wireless/virtual/mac80211_hwsim.c:  dev->priv_flags |=3D IF=
F_NO_QUEUE;
> >
> >
> > And noqueue_qdisc_ops sets ->enqueue to noop_enqueue():
> >
> > struct Qdisc_ops noqueue_qdisc_ops __read_mostly =3D {
> >         .id             =3D       "noqueue",
> >         .priv_size      =3D       0,
> >         .init           =3D       noqueue_init,
> >         .enqueue        =3D       noop_enqueue,
> >         .dequeue        =3D       noop_dequeue,
> >         .peek           =3D       noop_dequeue,
> >         .owner          =3D       THIS_MODULE,
> > };
>
> Sure, but please a look at :
>
> static int noqueue_init(struct Qdisc *qdisc, struct nlattr *opt,
> struct netlink_ext_ack *extack)
> {
>         /* register_qdisc() assigns a default of noop_enqueue if unset,
>         * but __dev_queue_xmit() treats noqueue only as such
>         * if this is NULL - so clear it here. */
>         qdisc->enqueue =3D NULL;
>         return 0;
> }

How can we proceed on this patch ?

I can remove the "(if we exclude noqueue ones)" part if this is confusing.

