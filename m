Return-Path: <netdev+bounces-294077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHmnHhOQHmodlAkAu9opvQ
	(envelope-from <netdev+bounces-294077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:10:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CF462A3E5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEB72302E1F0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFB3BADA9;
	Tue,  2 Jun 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YalpdgoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C923BAD84
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387240; cv=none; b=auvEQr0AHYkOIQekimIZQr4XWUHrs/TeQWR6IRyD1tlP70YiXQRLfAd30MqJi8LZl3ujwgt81yEY6WHM5yITjP0rULOTYsdxnihZRoLFXNNe5nJzPtO7k5MPgpIJeuHXuAWgO8RHSy6q7oUfJ9UUNgfFNMo4FUkGqCnB3urFhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387240; c=relaxed/simple;
	bh=ABDmoAvjP05kv7u0OeLlAtHWL2O1SJOEplteGzR9Ptg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/27fqYOyihXtXrFSu79pp2GFo9ncm4WCp1r/lZZpEng0xRsh76/Xk7lgpTLM9yv3AWhWX/LwI5+OyYhNp7K36H5qsA7/ISwdRduCM7fHe9iNwm+a2qn4b1JouXV+CpZtnfQX9x3c29HNFsvjLE2M+OMkUzuJ5PV4ZARJaVkacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YalpdgoA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3138814f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780387237; x=1780992037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j+2PtZRo6SPy8FA5buPLCnnYrJlwwHwsl8orB3/M8g=;
        b=YalpdgoAj6SIU0gm2yey+MrsRcVuyFVvqS96ueSafNZnemOKeAZB+f4dhfkRH2PgL5
         psLEt2OqKmPfgHFsXKKuT8W+yAY3xyUc4P3IOstRPZhVaFmcxw6umEs9DqvqbxYs2uY4
         SLFeDNP4A5+O6UcrXh4DcDThxIVOe86LUR4XIU82ffHhO1SWuZE2CSMr0ANvy1BQVGnB
         8ecbWINx/KwPrMw5hfzGF87L3kttMz0kQIoDgwMw5TQzLw6OLLrAf9kXBKa8iUvC5mdP
         L/brUv0lVGh03DSzethLk0EtmDcGpGGCu2LD7pAgiwT06OckxgflnoCGkCBe0PLk+yA6
         DL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387237; x=1780992037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0j+2PtZRo6SPy8FA5buPLCnnYrJlwwHwsl8orB3/M8g=;
        b=qIwg7J5EOV0I3RuVg1Rw8jLBW5GvRlpmCo2Oq9e84kDgGhZdCKmUJt29bOiq0RZ/+g
         9PZXqJMZl7BFqKf40s40010VqfXZUjfyDuZYSLAHmxtTMH8i39Z/eh+M5me0rojH0pMc
         dDDgH8IF3xjmqiQJi7C3c8TsMkNRG3ecnAyx6JY+JOhEIvdpnkaoG1pH9t9YQuGifB43
         cYxe9FxUBXpnAg6gDfgiQpujhUzzIaf3ViGfR0TpLH1gjB94q6Pdr0AzripcL7VC0Pou
         fxV8xkEsvDiN9/fMOcP6cTEjOnpvT0lZp9rST4XnBejtFsWvBUhGZAlOZ8uDW+Xwdtsj
         KhLA==
X-Forwarded-Encrypted: i=1; AFNElJ/uR2XF2nNBQxq3oxOeSZo3OR8+eZlSfgVkJXTL73ygkN9Y8Gdo7K4A6ygJ9hVYXRsUb5g0WGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdU9j1lg/f5AJDI1tUJpFBl4qi/i7mqc8+WNM2MR8IF8tTlcG
	NvsmcQmeJPhTVId3elvo8VO8eShQ4z0O8+/0ChOTo9u1lbWNbV56sREd
X-Gm-Gg: Acq92OG7fA7yAjYro0dONzwbkCso41vtx3cvf4xC27dT7mjtT6iKhrYs18S9gpZjayy
	+5irxOy0S6ngXHRk+mQmjSGgKXradJfcDWoP57GcygVzNXmJpXoydF27SbZTh+PAIchkHP9eKna
	yyymwCDC+YL7DBG+PkfiZol2Sb00h9Hx4n/0ffFYWJAVrVG+m9Hie2Nxc8osj9E9NFdFFzqCwcd
	MJ43muGdetuH2pdver9/MC1/HGrVO0uouzHCKJcZCQgbRfdQwvHWkL/aAR0dda1aB8DQ7IV4p2S
	cqs2us8TfZlkwFM+Nn5dTp9DP59I6XkQ4aIEnkzPNI+UfDubHgzIxpqZxDfmPWrx1enkyRfA0xd
	ep+K6UMCpJ3YbxAIKy3xwwtay9WXMI3xXM0DJn0ice35x7MZ0Om+tPVtaS4rONaA0f8gD2NMNG+
	/ctUNvu1FXAeFT7kvgXixs7ZPTvNdtfZeTGdZn4AqcnVes9ElwFWu1UgJjeqBOlMC8oCB9RRU=
X-Received: by 2002:a05:600c:c84:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490b0e9f45cmr39048035e9.14.1780387236616;
        Tue, 02 Jun 2026 01:00:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm82684755e9.0.2026.06.02.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:00:36 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:00:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, jianhao.xu@seu.edu.cn,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260602090034.7a5c243e@pumpkin>
In-Reply-To: <20260601231546.3407019-1-kuniyu@google.com>
References: <20260601223122.63c0d23f@pumpkin>
	<20260601231546.3407019-1-kuniyu@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294077-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89CF462A3E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  1 Jun 2026 23:14:44 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Mon, 1 Jun 2026 22:31:22 +0100
> > On Mon, 1 Jun 2026 05:36:37 -0700
> > Eric Dumazet <edumazet@google.com> wrote:
> >  =20
> > > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Sun, 31 May 2026 23:39:46 +0800
> > > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > >   =20
> > > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> > > > > flowlabel_consistency and flowlabel_state_ranges with plain loads,
> > > > > while writers update them through proc_dou8vec_minmax(). These ch=
ecks
> > > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads =
leave
> > > > > KCSAN-visible data races and can make the policy checks observe s=
tale or
> > > > > inconsistent values.
> > > > >
> > > > > The race can be reached on a running system by toggling
> > > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task repe=
atedly
> > > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > > state-ranges flow label.
> > > > >
> > > > > This issue was first flagged by our static analysis tool while sc=
anning
> > > > > lockless IPv6 sysctl readers, then manually audited on Linux v6.1=
8.21.
> > > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KC=
SAN by
> > > > > concurrently flipping the two sysctls while TCP reflect and UDP
> > > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KC=
SAN
> > > > > reported races between proc_dou8vec_minmax() and the two plain-lo=
ad
> > > > > sites in ipv6_flowlabel_get().
> > > > >
> > > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side repr=
oducer
> > > > > also hit the inline ip6_make_flowlabel() reader through
> > > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> > > > > fixed in this tree by commit ded139b59b5d
> > > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The rema=
ining
> > > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > > >
> > > > > Use READ_ONCE() for those remaining sysctl reads so they follow t=
he same
> > > > > lockless reader contract already used by other IPv6 sysctl reader=
s.
> > > > >
> > > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > > >
> > > > > Representative QEMU/KCSAN reports from the two target reader path=
s:
> > > > >
> > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minm=
ax
> > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > >          tcp_setsockopt+0x72/0xb0
> > > > >
> > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minm=
ax
> > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > >          udpv6_setsockopt+0x21/0x40
> > > > >
> > > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > > ---
> > > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >A
> > > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk=
, struct in6_flowlabel_req *freq,
> > > > >       int err;
> > > > >
> > > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistenc=
y)) {   =20
> > > >
> > > > That can't actually fix anything.   =20
> > >=20
> > > It fixes a KCSAN splat.
> > >=20
> > > If you think you can fix KCSAN instead, please do so.

ipv6.h has:
	u8 flowlabel_consistency;

KCSAN probably shouldn't care about byte reads.

> >=20
> > It is a false positive. =20
>=20
> It's not.
>=20
>=20
> > (Which I think you also said in a different email. =20
>=20
> I guess you meant this one ?
> https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@seu.ed=
u.cn/
>=20
> This is different because, in addition to Eric's comment, IPv6
> address is 128-bit and data-race is inevitable without locking
> unless CPU supports native 128-bit read/write; we already do
> load/store-tearing of 128bit with u32/u64.

But the code isn't looking at a 128bit value, it is only doing a check
for zero (and READ_ONCE() doesn't support 128bit values).
If there is no locking the value can change just before/after the test.
Even if it were subject to read/write tearing absolutely the worst that
could happen is a zero being detected when the value changes between
two non-zero values.
That isn't relevant here - it is just a boolean.

-- David


