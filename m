Return-Path: <netdev+bounces-293909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFHSB+36HWpSgQkAu9opvQ
	(envelope-from <netdev+bounces-293909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78695625901
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BB53044A61
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DC36213D;
	Mon,  1 Jun 2026 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwNycYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A2356742
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349487; cv=none; b=I9FHxc4l8rixQ1YA2NsojUsFx390BSxRRCh3H78oHBN8oHVo3ispXRcs7ANmLyKUUD7YCly4iFsbZ/SeFmVKUoJWymG0r34ty7w+IlUBTy5zgqfr0o8Mdo3VGaVEAC0o3zmycoMqSuzZIyStgg14+BP1IxSvq2Kze2x0XeKBnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349487; c=relaxed/simple;
	bh=Q04HHqCNMvuz+9/io2PQGUaUhDGXaJOQ++RaknZ+Yj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQDtxOoNHOKIK/VfZTwWXsiq2cbW18b2ix2AfL9pIkJ/dx17Ovl2M8hIQs3FCVyqKVvJy0NDPlLYiUNwWyssMznvnReSzzP7Ze6zUPKTxSqa8qb+wa0T0hrSJA50HsG/lGtacf7P2ZnPPqTPFrN71TnKEsaztLtPCGuGKnjdBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruwNycYg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso97067785e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349484; x=1780954284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aps6S5lqWxgw9ER0P66xSnHFOS5VJXJLk5UkrjHU5Mo=;
        b=ruwNycYgZzJCx6l+sTUPDIIvrsmLjiGsM7anTYS2cOWTBQ7Ry9TAlngSoDuznkdFUH
         6BNSO/QX6VtxtXOJ6s61AXLKlBA38yH5ZEtSM/tjIYNWaEQFi0/nORHZjVsb0ZTDei/N
         X2MBY+0uZwmxpdpZgEVnaZFxnsand/vKPGwCk9G05OJitYRsdXuvN7TBf4g5X7xqbq55
         pu1NFa2PgcOh28uRygIbhThTPMLJnxHOCftgWx+OFqxpBMHCykW7Ekw9onJk8kdzNMnF
         bd4jWIf8mxopdJKCLltWMNqtAYL8xJQ2eSf0x9bH9V/mxHEneEoq54teYqkD4+lo3vcB
         aemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349484; x=1780954284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aps6S5lqWxgw9ER0P66xSnHFOS5VJXJLk5UkrjHU5Mo=;
        b=Pfuq/+gv7jJKiPD9pTuPlEyI1KBZBHXKLanR/x0PSw5M8QZtrpLx/8RlOB9dZLs14c
         mi9rgPjfDu230JbHc1cLWewzxVi6922EJ/P+SsoWsfaEdMQuKF6OLCQFjdk6vr4SWI7y
         vK44k02RDaBefZ0OirZWvADY3hl8n/qx1Cd+S1IuYK04YV+/+yYZYqBMbWGOohuGNNI6
         ppEkcz2317Rcwmaf8FBPzuXsqpzK7lxdLBO7lp2eA7YphXRFj1Rt568NTOckZaieeW+q
         73wNk/2AmicjGVUYmLNK0juQlNoYD73jKCcfkjnjmdayKtkRJARA+qT6sWGmGl6Akasu
         7pZA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xn+nqBLazU+UaPFirRJyN7E86zFRFHzTal1PvAiUXBt/QLYIOw5GER8UtOsG5kCW2gqauxCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7nJrTDBVCUk9itX/j7AHJYwICKagHubCt+KUFq/iowgHMN7r
	c8IIbS5g85lVtp9yVCn2CC4xe3CUmUWZUbGzJ68ugQ6yFPssuBV19/QW
X-Gm-Gg: Acq92OHoQvjO43QgKCR+juoCXyWLCA4zXHTk4sCjD9f6kVHZ1JH/bfzOVdpDsBOtKQu
	E8O9NUCaeURHPwJTkfTfI91wbN2cKNfwqD4muuhesBuK+tNQCwTzPVJNoAbGgwn+vWkq+Tir0GW
	vDRuxTxhnd8AirHaDCDWelzmha/Co6GLfbM5djSL6rXFszJ5ysC88uGoRWwJU1gjExUyWRdPy9V
	xVTfWikB7SuA+dKUU+cLopg6LZ8RvaShV/3fetLJBQH8D2TBC1XxtXR5zcR/fZVl3v7H75JOugs
	lmJvuwTqtaYZvHvqB0GATphx/qZ08dnvFQhbmxAjnl8nZXaFOv++WWTRYKy1uGU0TSLeWn7j/F7
	C5pNfhvAUcw03uWFHsqMIJmJACuebsPwoGAhS7LDWcD+eZsdDiZ/tz6b9BItXjzZ49GBsfIBSON
	8xazghaC4WsVsoXY4BlrpkiM2uOlETP4RO1NxbdrDAz6OmQrTh+2WoA/rz165DRRm5IONrbkY=
X-Received: by 2002:a05:600c:8582:b0:490:48e2:5618 with SMTP id 5b1f17b1804b1-490a296046dmr181264715e9.22.1780349484313;
        Mon, 01 Jun 2026 14:31:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c128dacsm83516355e9.32.2026.06.01.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:31:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 22:31:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260601223122.63c0d23f@pumpkin>
In-Reply-To: <CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
	<20260601132245.4be1b32a@pumpkin>
	<CANn89iL5RYPYWPnwdiB2db+5bkgFt0_atBLHw4hopOq3KUK9Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293909-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:email]
X-Rspamd-Queue-Id: 78695625901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 05:36:37 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 31 May 2026 23:39:46 +0800
> > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > =20
> > > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > > while writers update them through proc_dou8vec_minmax(). These checks
> > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> > > KCSAN-visible data races and can make the policy checks observe stale=
 or
> > > inconsistent values.
> > >
> > > The race can be reached on a running system by toggling
> > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeated=
ly
> > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > state-ranges flow label.
> > >
> > > This issue was first flagged by our static analysis tool while scanni=
ng
> > > lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN =
by
> > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> > > reported races between proc_dou8vec_minmax() and the two plain-load
> > > sites in ipv6_flowlabel_get().
> > >
> > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproduc=
er
> > > also hit the inline ip6_make_flowlabel() reader through
> > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > > fixed in this tree by commit ded139b59b5d
> > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> > > plain readers in this tree are both in ipv6_flowlabel_get().
> > >
> > > Use READ_ONCE() for those remaining sysctl reads so they follow the s=
ame
> > > lockless reader contract already used by other IPv6 sysctl readers.
> > >
> > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > >
> > > Representative QEMU/KCSAN reports from the two target reader paths:
> > >
> > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > >   write: proc_dou8vec_minmax+0x206/0x220
> > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > >          do_ipv6_setsockopt+0x873/0x2220
> > >          tcp_setsockopt+0x72/0xb0
> > >
> > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
> > >   write: proc_dou8vec_minmax+0x206/0x220
> > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > >          do_ipv6_setsockopt+0x873/0x2220
> > >          udpv6_setsockopt+0x21/0x40
> > >
> > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > ---
> > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > --- a/net/ipv6/ip6_flowlabel.c
> > > +++ b/net/ipv6/ip6_flowlabel.c
> > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, st=
ruct in6_flowlabel_req *freq,
> > >       int err;
> > >
> > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) =
{ =20
> >
> > That can't actually fix anything. =20
>=20
> It fixes a KCSAN splat.
>=20
> If you think you can fix KCSAN instead, please do so.

It is a false positive.
(Which I think you also said in a different email.

-- David=20

>=20
> > If the value can be written concurrently it will still be zero or non-z=
ero
> > even if the write gets split.
> > So it can only ever be the same as the write happening a bit earlier or
> > a bit later.
> >
> > There might be a real bug if the code looks at
> > net->ipv6.sysctl.flowlabel_consistency again.
> > But a READ_ONCE() in an if won't fix anything.
> > =20
> > >                       net_info_ratelimited("Can not set IPV6_FL_F_REF=
LECT if flowlabel_consistency sysctl is enable\n");
> > >                       return -EPERM;
> > >               }
> > > @@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, st=
ruct in6_flowlabel_req *freq,
> > >
> > >       if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
> > >               return -EINVAL;
> > > -     if (net->ipv6.sysctl.flowlabel_state_ranges &&
> > > +     if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) && =20
> >
> > Ditto.
> > =20
> > >           (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
> > >               return -ERANGE;
> > > =20
> >
> > -- David
> > =20


