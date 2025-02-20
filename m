Return-Path: <netdev+bounces-168092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87616A3D6F1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB971898D5C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D61F0E31;
	Thu, 20 Feb 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3TP1OwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A271CAA9C
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048022; cv=none; b=f0JjmNBeNggiGnyoJvuJSv+LqjmV/KXlLukNlhW9QKcgP7Vnoq4+RPb25la3VS9XvzJwhNNbEwIjM6hqj5a3Y3RxeiJ6Y7x/jJ6udCTKaZuZwBbzJTtvUVLpD0p5O2ujm9fqf9zTTyuxPmGqRgn/NIaGSSI4g5hslwMR1P04U3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048022; c=relaxed/simple;
	bh=3CKrk51GC8FbXa/H0CS6NPeFkFXlmGnCY5jQCM5UxjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5QcKuRTXcSvEZf7/EomD98XIPq/1J5VDRWnIklvNYPj3x5vm1+zM5kg1LegacGimN55lpuaV8NDONS8GioyGMgtF5O5hla3+70EtBU1nrGASjUsVtkRNGbuy8ciJyZVAGwt66LlilRb0MK5dbCZ5BUACWTgDkP8L2KSpgAiuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3TP1OwQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so1327096a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 02:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740048019; x=1740652819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6YvKg8heor0yCWQKYn8CTsVgI5aDi/FKrV5DLJXe/s=;
        b=X3TP1OwQWzsB7KEiW/POR7u6hIw169tDqXzqdyxEwslY45RqhgLmVajGKxMYeXqSCM
         jFLB5vL0YTsgsASDnWrs7FLZCDdm+bKzwAiVEI1yvccFnlUyZ8/p1Q4IlCiJCZNCMkDT
         uwaP/LSujWRBTDPwlQnPNgwUro7PIakbRexqEKsFuHTm0ZN3o08HUwJRqL+7Z/oOupgr
         ci7wo1Zd83sZ/DAKhkF5V0+lnqMJt25HKDTAkqucZrd9eCcidLyi3o6qgkZ9Qu/iNwPG
         w1T6axyIEJDcSYAnCAZ1aL63dhBw3ilw9ixKgKxL5ZubhFEwjbMBuCsmo2ZyzoGIJRqJ
         ItMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048019; x=1740652819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6YvKg8heor0yCWQKYn8CTsVgI5aDi/FKrV5DLJXe/s=;
        b=o7cq7JpKZWqTR/u9/YOXDiUsc23fhxVz3euLcNRkIlgREZT620tmUEpJlFqAQDVTaR
         qR28qx1tivofWp1pv39VfH8BEvQtUZUJ9f0tGYsRwEqCJgN7cgwyrRiZ6dn+Krxfu3sy
         UcQtRk6lpdJGspQ3wMH8GWZGKMebNB/Vq4YiWkDGQk6OIpsZQjZ5eL+lzi2Ch8BTEfwx
         xwTKovmSvvylwfuQHNyE9E9iIuKYFg4kgfw5wlB7k3qp9K09TbOzIQOmiEq9fAgh5lYO
         AjqSCDV809YMKk4bcTnUG5H219SnE4LPFNkMDiQl2dZxxahjl0l+7L4Oe81fQXl72wC8
         vvBQ==
X-Gm-Message-State: AOJu0YzPDb/A9bXg0zZJlojhEC80/4JGTxRYJj7suL7l+Ej5SDcfWfN8
	fZ9NnYGD7v3JkfOFoq8et8jt2dPZCwnKYVdB5THFAUUnbm8axdSey3FD6DpZ3Cu3g52jftRqxNV
	Gr+v0cw3RW5teZwBQAN/LqvrbMnH4TCZB4mvJ
X-Gm-Gg: ASbGncvsOhGann0QadmAWdCc209jHilMudNK96yfymmCCduK8HR2P/bdd96N+Wcl2hZ
	/j6yVxxBgfr7YfVW97kSsqZ2TGubuXHfuc6kWqhyWbyadebFPHewmvyUU84EPXSTdDkdPbdZ0h/
	u7B+aiQM0QobG1v87qOVU1nZABkyse/Q==
X-Google-Smtp-Source: AGHT+IH58c37AG/af4f4icilMWcPvLaMg2pPaTUa68jf5McE3goKr/3yvOut8tr4lnbiCT8/nN53GvzvWsfwvgSJpbo=
X-Received: by 2002:a05:6402:2102:b0:5e0:461b:e852 with SMTP id
 4fb4d7f45d1cf-5e0a4bac46emr1932942a12.25.1740048019053; Thu, 20 Feb 2025
 02:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220072559.782296-1-idosch@nvidia.com>
In-Reply-To: <20250220072559.782296-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 11:40:07 +0100
X-Gm-Features: AWEUYZkNaTv7zSSVJUWZv9C3TGHxavhQ8q6HULnE901IntF8CWAAmc6O48inF_k
Message-ID: <CANn89iKnRBQipCOLtFq-rVPOoaZ7M6tYVo+Fm1aYgCZnyqW=eg@mail.gmail.com>
Subject: Re: [PATCH net] net: loopback: Avoid sending IP packets without an
 Ethernet header
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, maheshb@google.com, 
	lucien.xin@gmail.com, fmei@sfs.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:26=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> After commit 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> IPv4 neighbors can be constructed on the blackhole net device, but they
> are constructed with an output function (neigh_direct_output()) that
> simply calls dev_queue_xmit(). The latter will transmit packets via
> 'skb->dev' which might not be the blackhole net device if dst_dev_put()
> switched 'dst->dev' to the blackhole net device while another CPU was
> using the dst entry in ip_output(), but after it already initialized
> 'skb->dev' from 'dst->dev'.
>
> Specifically, the following can happen:
>
>     CPU1                                      CPU2
>
> udp_sendmsg(sk1)                          udp_sendmsg(sk2)
> udp_send_skb()                            [...]
> ip_output()
>     skb->dev =3D skb_dst(skb)->dev
>                                           dst_dev_put()
>                                               dst->dev =3D blackhole_netd=
ev
> ip_finish_output2()
>     resolves neigh on dst->dev
> neigh_output()
> neigh_direct_output()
> dev_queue_xmit()
>
> This will result in IPv4 packets being sent without an Ethernet header
> via a valid net device:
>
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp9s0, link-type EN10MB (Ethernet), snapshot length 262144 =
bytes
> 22:07:02.329668 20:00:40:11:18:fb > 45:00:00:44:f4:94, ethertype Unknown
> (0x58c6), length 68:
>         0x0000:  8dda 74ca f1ae ca6c ca6c 0098 969c 0400  ..t....l.l.....=
.
>         0x0010:  0000 4730 3f18 6800 0000 0000 0000 9971  ..G0?.h........=
q
>         0x0020:  c4c9 9055 a157 0a70 9ead bf83 38ca ab38  ...U.W.p....8..=
8
>         0x0030:  8add ab96 e052                           .....R
>
> Fix by making sure that neighbors are constructed on top of the
> blackhole net device with an output function that simply consumes the
> packets, in a similar fashion to dst_discard_out() and
> blackhole_netdev_xmit().
>
> Fixes: 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to invalidat=
e dst entries")
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Reported-by: Florian Meister <fmei@sfs.com>
> Closes: https://lore.kernel.org/netdev/20250210084931.23a5c2e4@hermes.loc=
al/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/loopback.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index c8840c3b9a1b..f1d68153987e 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_b=
uff *skb,
>         return NETDEV_TX_OK;
>  }
>
> +static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *s=
kb)
> +{
> +       kfree_skb(skb);

If there is any risk of this being hit often, I would probably use the
recent SKB_DROP_REASON_BLACKHOLE

(feel free to resubmit
https://lore.kernel.org/netdev/20250212164323.2183023-1-edumazet@google.com=
/T/#mbb8d4b0779cb8f0654a382772c943af5389606ea
?)

Otherwise, this looks good to me, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

