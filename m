Return-Path: <netdev+bounces-235887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13FC36C1A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798F21887EC8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D0322537;
	Wed,  5 Nov 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVYlz/Yg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD822192F9
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360683; cv=none; b=SvOMRKfkPyuwtdSxtkLkpLpWtCIFu/2KUhxp05BVpN1elZVMgWQPpJsDPpE2W9n6WwoGHSNTIOuRn19yBjw1c4QS0Bn8en/7xVFf8A2/uJDH7GDJtV+j6XtV61Pnm7OGvDLrlvZta+wie9R5iIpBrkcc4KMx+Uzvjj3N+FzpuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360683; c=relaxed/simple;
	bh=GW/1rThu9A9VrIJ15jRlROphRPI5FE0uWF3EEE1al8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBqerxHPdkqnjcJ4MR0aOMWawjY8qHkEv5sx4LkvD+g0QX+UztwjrmJpWkl5itI4wjZIGuA9nG0bMA51Wy5KIF8rREvar6wF/pqPDgrAU0M8CyxXsxZ6dSy9G/8YKQ7MlWGW3w6Bhks74+ewIhz9RlNeAEQZMoxUQtKMXLP9lRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVYlz/Yg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecf30c734eso66243741cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 08:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360681; x=1762965481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDNd3akV2rzQHYcdupU7xqNM7wqWBa5+j0F0UtfiOns=;
        b=sVYlz/YgdNMHJd/PPf7iArQLosSXpN1QQu49f9mngx7waJyVba8RrR5srxPRsXd9Fv
         qEb255vY4F6ZbiuAsnh6oMg3DAIoDyN/MK00HM/E1INA6Mljoq3USQzLB7lfgZelxAsz
         d1rG2TKzSkPvN4dFPuFuZ5FPgtt7PgWSFozizdcIK+raTt9m5JxW33rW3zIA89mJFPry
         un8c7wNXj+BVrP0mNGWv6rHULJw94B3wUtRnKR17JETmIgJt0E/j4+OmlWxZlpgO3H0Z
         eqQRG7MoZZ/P84dskL8V5OO+jSur6/2Mi72ZuaUctapyaP7D4C0DyW0n/Pb0I6UnPw6t
         5MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360681; x=1762965481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDNd3akV2rzQHYcdupU7xqNM7wqWBa5+j0F0UtfiOns=;
        b=htjXZbh5Cn66dc+Eu79HiImoKpTzPZelfAXfXtHdhWNM5ltfeamWdVyTOfmZkbawiB
         Z+NFgwV+OnfO/liEskvmJMXdu+jMQm3CnjmLSka+5WY/umBQVmKGjWFcoiwt8251Qi/U
         CapgaPb51apFNRdqoSkIGuYGk96ULWzgEkSc/d2V9O8TsLJ6juvt+Lah0xHd2gXFkOIp
         8+Iq4b6TYDMZLzKkfJF1O+4krkoir/j8kZhShbOQooJwA0OsduPd8HdW3UPwdPt57sue
         TvNsJWxX/rJWZWQ2eYChhFlulqctjKNRZ8c+FBK4GWY2+YejsnvZY0nP3yrI2Q0gxC1K
         o64g==
X-Forwarded-Encrypted: i=1; AJvYcCU12QRljpsEiMcy9uDwR9zPLRhxe+SnUq0M/qgfKcI5HZfUCdwEygcN/XCXtMIQ/GFGz4yq/ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXgJL6xWIRPUK8ZtT/AlQKpCIGgRlHpFg+f4PFGeS1FaN5jl0
	x/A1RotvHTkm687sPLBOnKz+oI/Nv0mH4/ebN0z22MAFwvH3FAaavdm3r0kIadr1Bxupp/vw3W+
	IehBCqUMg10k7Bql31phSedH2AOvF6NbIljAFPtjl
X-Gm-Gg: ASbGncsPOsAi87mPN0FoW0ith951i8bWT4KL4Kk+Fw3aLNzx6XVobhtBz6odMtpTcNX
	FvRC/DAgDWh/fjhn3riryLT0Yao1ARHyRwatV6a+OghoAq1cJAVG9P8KJN7oHJ7gFwVTs/6WhUh
	1Mph8FAp8TVFiEU1yw4sfhTqAwEAgmdshJtHc/QdL+/rHcN9kCCsH6vEUqu9Q8iqFk9c/4XA2HD
	EOlMorUGlwHul94CEbb+vPl5y+e5uGGo0UyYLSwBOQIMN/H/ff6PB7CG6Wp9YVtK+yKiqw=
X-Google-Smtp-Source: AGHT+IFX1wOjsWIH7J/Bj5uz7IFRQbJozPmXV7X3WSlZzpEkYBe14E2w9LSZj23ug/gmCTFHN+Fd9B+JRHkIjj29vKI=
X-Received: by 2002:ac8:7c46:0:b0:4eb:be61:54a0 with SMTP id
 d75a77b69052e-4ed725e79cdmr44293871cf.49.1762360680839; Wed, 05 Nov 2025
 08:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105093837.711053-1-edumazet@google.com> <CADVnQymZ1tFnEA1Q=vtECs0=Db7zHQ8=+WCQtnhHFVbEOzjVnQ@mail.gmail.com>
In-Reply-To: <CADVnQymZ1tFnEA1Q=vtECs0=Db7zHQ8=+WCQtnhHFVbEOzjVnQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 08:37:48 -0800
X-Gm-Features: AWmQ_blbJ_kMqRgAj2a-qQ1wc-umocYHdWMT4-2lV6ksvMGYfy5N-qNXavxEmmk
Message-ID: <CANn89iJpinbbrU2YxiWNQa9b2vQ035A75g00hWFLce-CAJi9hA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:41=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Wed, Nov 5, 2025 at 4:38=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
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
> >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
> >  include/net/netns/ipv4.h               |  1 +
> >  net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
> >  net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++--------
> >  net/ipv4/tcp_ipv4.c                    |  1 +
> >  5 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..ebc11f593305bf87e7d4ad4=
d50ef085b22aef7da 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -854,9 +854,18 @@ tcp_sack - BOOLEAN
> >
> >         Default: 1 (enabled)
> >
> > +tcp_comp_sack_rtt_percent - INTEGER
> > +       Percentage of SRTT used for the compressed SACK feature.
> > +       See tcp_comp_sack_nr, tcp_comp_sack_delay_ns, tcp_comp_sack_sla=
ck_ns.
> > +
> > +       Possible values : 1 - 1000
> > +
> > +       Default : 100 %
>
> Overall the patch looks great to me, but for the default value I would
> suggest 33% rather than 100%.
>
> AFAICT, basically, in data center environments with RTT < 1ms, if
> tcp_comp_sack_rtt_percent  is 100% and we allow the data receiver to
> wait a whole SRTT before it sends an ACK, then the data sender is
> likely to have fully used up its cwnd at the point that the receiver
> finally sends the ACK at the end of the SRTT. That means that for the
> entire time that the ACK is traveling from the data receiver to the
> data sender, the data sender has no permission (from congestion
> control) to send. So the "pipe" (data sender -> data receiver network
> path) will have an idle bubble for a long time while the data sender
> is waiting for the ACK. In these cases, the system would lose
> pipelining and would end up in a "stop and wait" mode.
>
> The rationale for 33% is basically to try to facilitate pipelining,
> where there are always at least 3 ACKs and 3 GSO/TSO skbs per SRTT, so
> that the path can maintain a budget for 3 full-sized GSO/TSO skbs "in
> flight" at all times:
>
> + 1 skb in the qdisc waiting to be sent by the NIC next
> + 1 skb being sent by the NIC (being serialized by the NIC out onto the w=
ire)
> + 1 skb being received and aggregated by the receiver machine's
> aggregation mechanism (some combination of LRO, GRO, and sack
> compression)
>
> Note that this is basically the same magic number (3) and the same
> rationales as:
>
> (a) tcp_tso_should_defer() ensuring that we defer sending data for no
> longer than cwnd/tcp_tso_win_divisor (where tcp_tso_win_divisor =3D 3),
> and
> (b) bbr_quantization_budget() ensuring that cwnd is at least 3 GSO/TSO
> skbs to maintain pipelining and full throughput at low RTTs
>
> It is also similar in spirit to your 2014 patch that limits GSO skbs
> to half the cwnd, again to help maintain pipelining:
>
> tcp: limit GSO packets to half cwnd
> d649a7a81f3b5bacb1d60abd7529894d8234a666
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd649a7a81f3b5bacb1d60abd7529894d8234a666
>
> WDYT?

This all makes sense Neal, thank you !

I was mainly focused on reordering issues more than actual drops :)

