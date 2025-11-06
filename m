Return-Path: <netdev+bounces-236442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C843FC3C478
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC56C1B256B4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C6534DB4E;
	Thu,  6 Nov 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sT3vVzR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4934CFB2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445402; cv=none; b=efeuu9d6/vBfBkp+yl/kWNXRpbYaHHUfmHw0IPm026U/l0TDG4ZSYLq2A/PU6wF55V6ISzGF1q/iQjGoW9DEeJYBUiRRl3k4QRDytj24vCTvQYpbvRMaBnfvF9JE9lNuXjapPgZxWMu5DaQnYuX62fwWBikSmwTHQxmvDKfBo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445402; c=relaxed/simple;
	bh=fKmNiMQe0ynvpStWuP0XnSHZDwq/y2qoqKQrGY3PXsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+n5kqfwEyBr1XS2LLj04rrwU90KRERzCk+nHABgh8MMyppAezz4scvRrai2ZKRbLf26GzwzgAId1ueIaN+ixa/Y0HDyb23yBqzzJ4xaxKfvJZwDrjUp8+tWocVXsH3UYhUsAuwVfprLnItDxWnZX9m0Qn+QxMpseGoqVIOO7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sT3vVzR4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e89c433c00so11431411cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762445399; x=1763050199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWuK2l4a0qyICiQGJ5Nu+jA+2tYvhcOWjthDcbaS8Uc=;
        b=sT3vVzR47UEiUpzCQ6Ws9CLzZld7xQo8lgINpcSj4i5hCKLmUC05n+oVbvSgKwGuSe
         pCBnJ+pD2u6ElfXcNEqn7zrL91w1XBAo/sThZQSkjMRujm0OqVsEXb1bJi5BqK+7dOOj
         64hMue/QAmbfVK5YrdzPYUyxSCs1HgAMshDY9BGw2SP38tv5xS0SzfBBXxEZFRhkZKww
         6pCw6CoV7R1QAIgtxx/wvqc57KAjiFYnGmYohVAa6b1iEqnaaouyg66StAIOOqqe3tK8
         uAfAMix+mAM/HqD1xzRAAReA2Fo+VRJBHDQ6sfKj8xZFQJRcOAPnK0Kzs9JzLOv0LLOO
         oj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445399; x=1763050199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWuK2l4a0qyICiQGJ5Nu+jA+2tYvhcOWjthDcbaS8Uc=;
        b=gZbTUKYr1LGZjtbXIsR1gTWqS0AmDWC5n/8OXwaypmK2I7KKHmQKfM6g9fBnpHRlfN
         1QJHHUwdzfI9kD9fJpkl76kj6ZeR9YEyXdu3QLOVc5h05udY+rAlWE6pS6ECccqVlNkL
         pO63tWZeMmAyLezWqyhiM6DHmsopMG+sbdEjmvZaRUjCpuILDT9KBxkqYaM7vHc420rd
         wVjqjnPdF2tF2USqc6QpVghQEIwXtLULaK4fq6oFC+t6T8wh58pK/dC2Xi+j1Rrtak86
         lPf3qPb7KNstA3hHLBwQBeeASD2SNiUly7KmZqPD1OhA9c0yvIhr17BCU8RM/2IGcXIR
         meBg==
X-Forwarded-Encrypted: i=1; AJvYcCVAaBXeZNjNa5COlGImnlWNOJ9GAfzM/u4nG9B2YFV8BpF4gulMtgmtSH9Lgv7rpTxBivsh/Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZEZPvRSRrbDBGaHd1CHZS28rvaaYJWf1vB3rZoGF1gNvT8cn
	5g/10iyujJ8cApr1OSbW6ApM9zT5wzDtdoY1dRNwYqJJxU76IrJvRiGX/f4Fu//l82fVKvuqcSu
	risoa/WkKVJZp733tUtTO8QUveyRo+5O4A6libfOU
X-Gm-Gg: ASbGncu54H9cdGUhbTxglKZft40DhbUAE18zYREdurdDIstblQ6f93CsAQxu1zNrVm5
	Te3gxEzqv3eSHoRMHYPTHS9XaeU2fsuQu4SwaNYilpeXyREp18orgn65y7MdgjzULm4AM/O6AXq
	N/unuiQ6A/tJ0C891EltM731nU0Cv01f431SxrUepLwM6GwTybos8V5jxWFiiMLhOGZ+Y5cwB55
	KUc4+zkgLIrM6tZ1zF5dQO5C6xrP8zbGmYN9Se7Htz9aY484oXMjtHnmg5KvhDdV6Poz0M=
X-Google-Smtp-Source: AGHT+IECy0DNJwhJeIjdbjfXkIdcPVInPFDXCcmsDy8wKkUfA3HdisJZF6w1mPhnG9bIpDieWqZbBPK7yyBDK9BynZY=
X-Received: by 2002:a05:622a:410d:b0:4ed:680e:29d2 with SMTP id
 d75a77b69052e-4ed725e74f9mr77097231cf.44.1762445399047; Thu, 06 Nov 2025
 08:09:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105093837.711053-1-edumazet@google.com> <0eecf17d-2606-4304-bc75-efe4c7ec73b9@kernel.org>
In-Reply-To: <0eecf17d-2606-4304-bc75-efe4c7ec73b9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 08:09:48 -0800
X-Gm-Features: AWmQ_bkl-AVBQwT-9D5XgAGRZ3AH4yIJoh6AJfNiakHIL10Q3TwtcTMLkZY_y4w
Message-ID: <CANn89iJsqvNFgAoUfPcB==PiVeMHNBFB1uyWkF4Egs0KBW-ENg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:57=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
> On 05/11/2025 10.38, Eric Dumazet wrote:
> > TCP SACK compression has been added in 2018 in commit
> > 5d9f4262b7ea ("tcp: add SACK compression").
> >
> > It is working great for WAN flows (with large RTT).
> > Wifi in particular gets a significant boost _when_ ACK are suppressed.
> >
> > Add a new sysctl so that we can tune the very conservative 5 % value
> > that has been used so far in this formula, so that small RTT flows
> > can benefit from this feature.
> >
> > delay =3D min ( 5 % of RTT, 1 ms)
> >
> > This patch adds new tcp_comp_sack_rtt_percent sysctl
> > to ease experiments and tuning.
> >
> > Given that we cap the delay to 1ms (tcp_comp_sack_delay_ns sysctl),
> > set the default value to 100.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
> >   include/net/netns/ipv4.h               |  1 +
> >   net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
> >   net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++-------=
-
> >   net/ipv4/tcp_ipv4.c                    |  1 +
> >   5 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..ebc11f593305bf87e7d4ad4=
d50ef085b22aef7da 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -854,9 +854,18 @@ tcp_sack - BOOLEAN
> >
> >       Default: 1 (enabled)
> >
> > +tcp_comp_sack_rtt_percent - INTEGER
> > +     Percentage of SRTT used for the compressed SACK feature.
> > +     See tcp_comp_sack_nr, tcp_comp_sack_delay_ns, tcp_comp_sack_slack=
_ns.
> > +
> > +     Possible values : 1 - 1000
>
> If this is a percentage, why does it allow 1000 as max?

To allow a 10x max. If someone needs more in the future, we might change it=
.

> > +     /* delay =3D (rtt >> 3) * NSEC_PER_USEC * comp_sack_rtt_percent /=
 100
> > +      * ->
> > +      * delay =3D rtt * 1.25 * comp_sack_rtt_percent
> > +      */
>
> Why explain this with shifts.  I have to use extra time to remember that
> shift ">> 3" is the same as div "/" 8.  And that ">>" 2 is the same as
> div "/4".  For the code, I think the compiler will convert /4 to >>2
> anyway.  I don't feel strongly about this, so I'll let it be up to you
> if you want to adjust this or not.

Look elsewhere in TCP, we always convert rtt with (rtt >> 3), because
it is kept scaled by 3.

I personally prefer this to rtt/8, but I understand if you are from
another team :)

>
>
> > +     delay =3D (u64)(rtt + (rtt >> 2)) *
> > +             READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_rtt_percent);
> > +
> > +     delay =3D min(delay, READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_del=
ay_ns));
> > +
> >       sock_hold(sk);
> >       hrtimer_start_range_ns(&tp->compressed_ack_timer, ns_to_ktime(del=
ay),
> > -                            READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_co=
mp_sack_slack_ns),
> > +                            READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_s=
lack_ns),
> >                              HRTIMER_MODE_REL_PINNED_SOFT);
> >   }
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index b7526a7888cbe296c0f4ba6350772741cfe1765b..a4411cd0229cb7fc5903d20=
6e549d0889d177937 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -3596,6 +3596,7 @@ static int __net_init tcp_sk_init(struct net *net=
)
> >       net->ipv4.sysctl_tcp_comp_sack_delay_ns =3D NSEC_PER_MSEC;
> >       net->ipv4.sysctl_tcp_comp_sack_slack_ns =3D 100 * NSEC_PER_USEC;
> >       net->ipv4.sysctl_tcp_comp_sack_nr =3D 44;
> > +     net->ipv4.sysctl_tcp_comp_sack_rtt_percent =3D 100;
> >       net->ipv4.sysctl_tcp_backlog_ack_defer =3D 1;
> >       net->ipv4.sysctl_tcp_fastopen =3D TFO_CLIENT_ENABLE;
> >       net->ipv4.sysctl_tcp_fastopen_blackhole_timeout =3D 0;
>

