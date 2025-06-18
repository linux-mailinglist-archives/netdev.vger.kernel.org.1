Return-Path: <netdev+bounces-199155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE20ADF350
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED1518890E9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F62046B3;
	Wed, 18 Jun 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UawI4Nhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A32FEE29
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266093; cv=none; b=TqPcvuZB+UkJ1XDg9Ka93Un9MSh5scgEUobV1etc+R7XTWq/CmoxjkhGAwxKt9/UjWdMkIv8//ybzemd+Qhj3Rwi1IPsUOrqg89FSeFx7Fenw8/e4824hpz/S+pdKCfYY8zG7e4qlNZ43EsabVn5agt/3vPJtyCoZvv/grtLTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266093; c=relaxed/simple;
	bh=PpFbNTj2nj7ppVdhf/dyRdlBwTjUyxClqGpq43MQ/hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU14MEW9aPnpgzTlZX5PWMRmo3T+He9Eh88Pl2LLKhP+M6LT+hXMDbl0R5v6aCm1xvX1E36914BpEPycGmLXXRyS8rThunpY94Zna7mvpJpo9grIbzGGTeal4x5WM2j8uRO9Eal1qHsCo6O4Z6UEUNwV1N3CyAVSoNPY27ScYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UawI4Nhr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450d08e662fso3136825e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750266089; x=1750870889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbnv5pg3BvERqXuKSCApfgJwP3ByC0KS1+2LO+hBU+Q=;
        b=UawI4NhrWTVG1UwO3wxz6ou7HEfPyI93qXYvhwvLnsfkp2++PbG++9zol8X5RP+nxg
         adBeeEyaQrV4oWmTrcs+wUcZStjREkwLRZ/9dn3eS7ZY5ylOoYyUezPUgZyF/V6sVS5h
         NmjQVuIyYED1ptmQtMTBnxCUpzCOysOU6a+ci7C/s7wKOjNDddrUVCsLZ11LbO+XTXzW
         0BbByMMCx630k8YB39Mu3MEw82plX99YEIuZZncb2CIE8UQ9Hwi2gDxKSVp/hYuxLBaP
         kur/Oo97WJpITbeoHq15cr81ZAgFjaXo7yc5I97ubpukGS/B7KbnpSFHw3b91iK2j56Z
         kIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750266089; x=1750870889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jbnv5pg3BvERqXuKSCApfgJwP3ByC0KS1+2LO+hBU+Q=;
        b=h4ILDLx1eV7DuIK8CuR4MPCh8jSO3RKxz/VkY2WbWu7aHJ/+LsY/SbCRIFXqT89AkN
         U/JpEgtyaWW9ixPOJVc157w3x8dRhptZ7crD/FOeZ7nyo/cCNTw8rXUK2k6pbqVg1fNb
         BRgNyDoRUr6BowjxQ8XVyDs0Frm/j61tOTMU036ZxRc2N80e9S/un6AvHmRXrM0Zod7O
         CyIKuLAf9tD4QnDDSRp9fJ0Q3nnENnjioflCkZvhC7ET67nWEaUUi4X10azOXYdD8i82
         q/WkK5N6ztk7MMDRCH/oewdvrXLSSCrAlzHlEMPIaPVdgVnvWBkYh73gJ5gwLXGjEtES
         irog==
X-Forwarded-Encrypted: i=1; AJvYcCUlAFQGFAT6gut+xiUL8iXsG0kzbuzaGvXx2Ynz141YcLxZ4/I2o4ck44WPtyrbccAOY4jtWhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpUzf+bpKMxScTsWWSQ5D1w6st0+xHbzguI/KR3gVMhgUd7IF
	wk3A5ccuVhuZhDNIGjlHRy97HvTgp4GcCHXh9ADs5c63V8rDbni2Tmbvo9UEXKr6ofc=
X-Gm-Gg: ASbGncuz3Pk5Z3/J9Fvgy1FqUJkd+/nAwWH9GxUyIT1rGEpwyq+I5CSZe2BbXwd4Xy3
	GNt7P8SRie7rHPN+wB/1S/D4KpAfpAH+eU7rSofQaDfbXTNO2Rg42kn9MzxhuYGXxfQWPcCSX4C
	bnFsy2Qv3JISvLo1spSB+69z5YxYpShclhg+k8p1Wg1ya6aSMyzroMjCgiMapxGacuerLcp6566
	ZUPXfDnlR3KMOdsw+2OttbmqyuqfUHM5ZYKJdcbFVe/M6rEqENUJNqekSkq0fXktZFsJpZgfvFY
	T2J8pv4nG+ZxRh5ciaIkbtvbvDULgalQBLk/9COadmrJ1rsE8klSHmwr/L2HIlwGkwMkBjbLCxz
	UIevNZuDdZhCMpRAwzW8xsfTa9qgb3neDbtehHsbhyLsbsZiCQgsK/57JC8KCKxrIXnU=
X-Google-Smtp-Source: AGHT+IFpbEMylk7d/l42fxjvE8B2fzo2xN2COCA7HEbClpmNiZwUfboRPlSNKp4uI1hk1Vieez8OSg==
X-Received: by 2002:a05:600c:3b0a:b0:450:d5ed:3c20 with SMTP id 5b1f17b1804b1-4533cac31dbmr60700295e9.6.1750266089247;
        Wed, 18 Jun 2025 10:01:29 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8c16sm2599915e9.19.2025.06.18.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:01:28 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:01:24 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "open list:NETWORKING [TCP]"
 <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] tcp_metrics: set maximum cwnd from the dst
 entry
Message-ID: <20250618190124.04b7a2c3@mordecai.tesarici.cz>
In-Reply-To: <20250617133935.60f621db@mordecai.tesarici.cz>
References: <20250613102012.724405-1-ptesarik@suse.com>
	<20250613102012.724405-2-ptesarik@suse.com>
	<da990565-b8ec-4d34-9739-cf13a2a7d2b3@redhat.com>
	<20250617133935.60f621db@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 13:39:35 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> On Tue, 17 Jun 2025 13:00:53 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > On 6/13/25 12:20 PM, Petr Tesarik wrote: =20
> > > diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> > > index 4251670e328c8..dd8f3457bd72e 100644
> > > --- a/net/ipv4/tcp_metrics.c
> > > +++ b/net/ipv4/tcp_metrics.c
> > > @@ -477,6 +477,9 @@ void tcp_init_metrics(struct sock *sk)
> > >  	if (!dst)
> > >  		goto reset;
> > > =20
> > > +	if (dst_metric_locked(dst, RTAX_CWND))
> > > +		tp->snd_cwnd_clamp =3D dst_metric(dst, RTAX_CWND);
> > > +
> > >  	rcu_read_lock();
> > >  	tm =3D tcp_get_metrics(sk, dst, false);
> > >  	if (!tm) {
> > > @@ -484,9 +487,6 @@ void tcp_init_metrics(struct sock *sk)
> > >  		goto reset;
> > >  	}
> > > =20
> > > -	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> > > -		tp->snd_cwnd_clamp =3D tcp_metric_get(tm, TCP_METRIC_CWND);
> > > -
> > >  	val =3D READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
> > >  	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
> > >  	if (val) {   =20
> >=20
> > It's unclear to me why you drop the tcp_metric_get() here. It looks like
> > the above will cause a functional regression, with unlocked cached
> > metrics no longer taking effects? =20
>=20
> Unlocked cached TCP_METRIC_CWND has never taken effects. As you can
> see, tcp_metric_get() was executed only if the metric was locked.=20
>=20
> In fact, the cwnd parameter in the route does not have any effect
> either. It's even documented in the manual page of ip-route(8):
>=20
>               cwnd NUMBER (Linux 2.3.15+ only)
>                      the clamp for congestion window. It is ignored if
>                      the lock flag is not used.
>=20
> Note that here is also an initcwnd parameter, and I'm not changing
> anything about the handling of that one.
>=20
> Now, if you think that this TCP_METRIC_CWND is quite useless, then I
> wholeheartedly agree with you, but we cannot simply remove it, as it
> has become part of uapi, defined in include/uapi/linux/tcp_metrics.h.

As an afterthought, I'm not quite sure about the semantics of this
metric. The value calculated in tcp_update_metrics() has never been
used for anything since it was introduced in 2.3.15. So there is:

- either a locked cwnd value, which is used to clamp cwnd on a
  route and never updated,
- or an unlocked cwnd value, which is updated upon connection
  termination but never used for anything by the kernel.

OK, the unlocked value can be read by userspace, but what is it
supposed to mean? The manual page for route-tcp_metrics(8) says: =E2=80=9CC=
WND
metric value=E2=80=9D, which sounds like the author did not have a clue eit=
her.

Unless someone here _has_ a clue, I'll just leave it as is, except the
clamp value will be taken from the routing table, as it makes no sense
to wait until the very same value propagates to a tcp_metrics_block
(where it is then never updated).

Petr T

