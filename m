Return-Path: <netdev+bounces-131131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEC98CDBE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F52810F3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DE193425;
	Wed,  2 Oct 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Glx0VZ6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7625771
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854093; cv=none; b=mop06cBboQqSa+Aa7+rLk1OZrklT6lror0C/tcIIpsp5i6skOhQny67U3SF5qv0+LQKsvaApbzNHQQGe7E/QFszdW8SzV0EqFtgYP7Da5K49rZNfJ0SZSVJxm1TNQd6WiL313JiibVoMcTPBlvPWCAHR3zZepkCDAYmpkq5BaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854093; c=relaxed/simple;
	bh=+6rxxewfS7nGJm/k6J4am0oJsZeqIYjkksEUEVpB8xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXeZDwZyz/Vz5xV5IKL4tFH5tw1ffp67N+KX9zkCEirCHzmc3wIAW6jDdTQbHnn9tiZxNSxG7YjtQXy2oLITk2EqlmafQshvFx1RGsQpy6Cc+oI1oJHLcdNnd8zUfEx0VjAUc9sCxyV7mZXVf/f+0hm2KHcEZjMdus42o+jImZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Glx0VZ6l; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso6839627a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727854090; x=1728458890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoY1uVWW0TBlbL1FE0TmNEJGNZWbqNtdD5nNxMYW6CY=;
        b=Glx0VZ6ltpONe1rvR3Vjtkqvnq2NVK5ADpo6NfJHxKuIJUI92kumm+eiHBl0fbYFpA
         I7G5D92++A2cHMvKJIFAtZxF0vNk6Nlktl2xt055qDKnRvnth/fzyDjC6i16C6YN5zZ9
         9/p0i9TmW0bye7YDmJWUHKjUvrFqHkN9mNSjWT3HQBRxekLEdOgWxyCPQeYG1vG28/M1
         hqrVwtIDTc35BuoBCrbhIZZ5r/dKse1KdnBhdfl6BFmLWTuVqNNVhQEfrvRKk74LFq8N
         BrSl3aDswKUWa9bxg0INOuYrSs+vb/TV0Q6FsYBocUQaxl6eOnvvz9BDz55Y89zOG2VT
         r8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854090; x=1728458890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoY1uVWW0TBlbL1FE0TmNEJGNZWbqNtdD5nNxMYW6CY=;
        b=r3oveHHfcqwpcZpfYg1EsUxphEJwWpTy7aY1fFAkMrlMAy419AlImWgt/+834UXwub
         YTaHXllWRg0/0QQX+ilyDfumZ38NLOwMPAWIguG1j+mv/ZNmB1g3mnUKYawcfYi84diR
         TiPl8giWwJ5zkgCJS5473VB1nDvysRhO+Vz6nLxDKajF4/PyM/hjnu1lF1GSBLxDsdud
         ycB+hbg4i4wKu0EaOwmunJDk4q8qDZ24QyOQb8cRzaIB4nM/fWK7WCyoxNwaw3g0dc8x
         fIsWPmh1QHg48GTCEbugaxajx1e0/PMQh+oYAyePEX8Eyq/WQpy5t/yd0H1coHcKS1tV
         PTSw==
X-Forwarded-Encrypted: i=1; AJvYcCW23rIgWMr0/AqOkBoTeF6oN6gFZ6QuzBSRBlK/bCiDCKrtHQPVLDsh4KCMY2/DoBPEe76wMLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VHCi+mkcpzOYKp1ca/LKwuWM7SAdYN6yiPXunvg5K1egrN73
	4C0/NL4c/ga5Uz6zfkUA6XdmUw614jljyR3wg+H9fBY2Nkdsrb/b8L5DL9kq2avC/4wTh6bPIkA
	vKOa1zD1eyKCZyhgZfIhIj07tt/UB823sb0D3
X-Google-Smtp-Source: AGHT+IHw62kflM+poCBldYd3rhBWj/iPUQPhXrrG5B2DbjbsL9SQBpONq+uoJt8zohnrcwpN9Aak4tkU8MOmPDPMcus=
X-Received: by 2002:a05:6402:2550:b0:5c4:1320:e5a3 with SMTP id
 4fb4d7f45d1cf-5c8b1a34bb7mr1807331a12.16.1727854089499; Wed, 02 Oct 2024
 00:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
In-Reply-To: <20241002053844.130553-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 09:27:55 +0200
Message-ID: <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Daniel Yang <danielyangkang@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:39=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> pskb_expand_head doesn't initialize extra nhead bytes in header and
> tail bytes, leading to KMSAN infoleak error. Fix by initializing data to
> 0 with memset.
>
> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Tested-by: Daniel Yang <danielyangkang@gmail.com>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

No no no.

Please fix the root cause, instead of making slow all the users that
got this right.

Uninit was stored to memory at:
 eth_header_parse+0xb8/0x110 net/ethernet/eth.c:204
 dev_parse_header include/linux/netdevice.h:3158 [inline]
 packet_rcv+0xefc/0x2050 net/packet/af_packet.c:2253
 dev_queue_xmit_nit+0x114b/0x12a0 net/core/dev.c:2347
 xmit_one net/core/dev.c:3584 [inline]
 dev_hard_start_xmit+0x17d/0xa20 net/core/dev.c:3604
 __dev_queue_xmit+0x3576/0x55e0 net/core/dev.c:4424
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]



Sanity check [1] in __bpf_redirect_common() does not really help, if
skb->len =3D=3D 1 :/

/* Verify that a link layer header is carried */
if (unlikely(skb->mac_header >=3D skb->network_header || skb->len =3D=3D 0)=
) {
     kfree_skb(skb);
     return -ERANGE;
}

These bugs keep showing up.

[1]

commit 114039b342014680911c35bd6b72624180fd669a
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Mon Nov 21 10:03:39 2022 -0800

    bpf: Move skb->len =3D=3D 0 checks into __bpf_redirect

    To avoid potentially breaking existing users.

    Both mac/no-mac cases have to be amended; mac_header >=3D network_heade=
r
    is not enough (verified with a new test, see next patch).

    Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len"=
)
    Signed-off-by: Stanislav Fomichev <sdf@google.com>
    Link: https://lore.kernel.org/r/20221121180340.1983627-1-sdf@google.com
    Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

I sent an earlier patch, this went nowhere I am afraid.

https://www.spinics.net/lists/netdev/msg982652.html

Daniel, can you take a look and fix this in net/core/filter.c ?

