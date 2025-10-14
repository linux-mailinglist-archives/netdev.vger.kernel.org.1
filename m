Return-Path: <netdev+bounces-229110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D147BD84BC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D86A3B40D0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22672DC79B;
	Tue, 14 Oct 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1oG+WBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81C2DCF65
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432078; cv=none; b=cpgD9kzfxBY3RS7ZY10mpFvQcJOLLB6BJc3rcxVavKbMNsMm//1GUvAUUtqMZx06El7LUwyw1BjexyWa1XHVePHY/KAJNapQFuABaRZj5nnLdNxPlIp7ntFQhXTWBQvOS0ZjgErMdJ3toFJDjhlCZ3M5WgNUX4INq68wV7ZhIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432078; c=relaxed/simple;
	bh=6LgNKZNmgF10jIXqxGjeEBugATe/LKxXcOJp3lARXDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLIShMZT7V+UeovGeR4+SCq731lHVEsG5XsffX8tQY1qdb0wfeD1myWZ3y2yLRHnFfdDIeovZryI4Pc+t934GM95FIYPc+0Tzrmvhi/2eqvVNwZuVFBnDJ2I2WeYrx0ikIMvgIclUo/Sz9NI5DQQ1RFDEii5mhlSbmU7obSb3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1oG+WBJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78f15d5846dso83975176d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760432076; x=1761036876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4VySRwz9m1JU+ZDg+Fh3/d34BuS0ZBZLOysYt4I24I=;
        b=x1oG+WBJhate8zQn30/BPtcFzz2cgKy0LbB1TwuFmClLe4MIfjkNJqoFuvP+D0YmkL
         WWQ1OKApyOt0SshG/dfPy5zlL/qS4R/87Nx6g2WzRjX6OHF0rFEUSm8SdMpPPeq75wgo
         iliBuQChj8EWtwLF+N25ApN8QzjGgRsTqYLaCQwaU3Sq4QJ6clRSye1+bqWODYERTVSj
         7Zbvi4Kv2aNAU5gRNO1lawGyjKq337+5gztuHsnYLmM+MoHqN9+tp92pkaL8Y324fwmU
         w0CMdNIXjuW1ZOXyKHJCLuJgW2yWiVDahmea/asR60BFT1+klc9U0AVTvnrIArAC5TCC
         fbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432076; x=1761036876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4VySRwz9m1JU+ZDg+Fh3/d34BuS0ZBZLOysYt4I24I=;
        b=w63OOq+TmLTioZd7vWMxsM1YEjnJnnpuF2kMqKMXMFDVdZyuLfm2MDiEcN7TdRNhKs
         AZg0EuJLc4vfDEjuLWFuUg66zna0Wlg0p2Xz5jnfKELy7Z/uTlBFwYjRodeFhRC1wsU0
         zMmI15PGMmIcfaMvSS9GyS/Di/ui8uOIOcwXim3DB9SLJF8uqchH2+uqmUt/lR+AXHde
         KDsUNBYJxZRlTc0VVa91VyKDLcAL/WGAVqRWesSzquzsDFwWqt3394NDQ29MLHvZAdh2
         1scJgiMN24PEMgWSfgzypXTDqVv6WHKnA+OI4rvL6cGUAKBDXBTHWStcRMo0PImh2t+r
         K7jg==
X-Forwarded-Encrypted: i=1; AJvYcCWSH/8cTWC8+auLD76M59OHe5D4Ib6O2fLqdp9uwUQsPsgavJo+gOj3Du/zF1BVMAmJJ5Kb0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiRWvYzwtNjlAnvsHbuRZ+0sXTCT/UUtOSIxk5nH2IP6IxiR0
	hTnibnzfwbUjqug7NZaYhlBAdYdYqfXMHOfILxJg+ebDUJsVjxoUCWiGDW5pIJRlzcLekyvR1iQ
	NmiAthK2nogaBqewyFBnc3qRIGt4p9YFAQ1/eS2Z0
X-Gm-Gg: ASbGncv6+2hIDMqHUmJtmNBmG538O0JQ7eB58eom4I0YVdzObwHcsRitaQ7EvuAkuqo
	gQeJccJn9WpFWixP+3EG4UWrhmiaqZtL9ZTHbZR4n6H+FZjpJXlW8MfKAggjIYV3WDRkJnYSi/l
	JDuAwvZkN6/IYC/k0jiReBsTGBtqrsNeZ2BNaHYh813rJKzecULeeaVr4rPkfp68//GpfSR3Hxw
	5g+ysqfYcMv2DXAE6ktXhtAU0h4y3f/
X-Google-Smtp-Source: AGHT+IFA8xut4GWM2ihOQCr4R8bWnXf5T+nPRO/dqWNWbF48zVbKNVA6mwY9MPlWQGhl4PI0B5Nf/QP3ZfC1nQzoVWM=
X-Received: by 2002:a05:622a:8a:b0:4df:4174:8239 with SMTP id
 d75a77b69052e-4e6eaceafe1mr343666951cf.29.1760432075575; Tue, 14 Oct 2025
 01:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
 <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
In-Reply-To: <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:54:24 -0700
X-Gm-Features: AS18NWABPuN2ltBmI73WriTakkV-8ehTeL9FJW2CFHXHDKq3zSwQiuxYu4RFeag
Message-ID: <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:29=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 14, 2025 at 1:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 10/13/25 4:59 PM, Eric Dumazet wrote:
> > > Some applications uses TCP_TX_DELAY socket option after TCP flow
> > > is established.
> > >
> > > Some metrics need to be updated, otherwise TCP might take time to
> > > adapt to the new (emulated) RTT.
> > >
> > > This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
> > > and sk->sk_pacing_rate.
> > >
> > > This is best effort, and for instance icsk_rto is reset
> > > without taking backoff into account.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > The CI is consistently reporting pktdrill failures on top of this patch=
:
> >
> > # selftests: net/packetdrill: tcp_user_timeout_user-timeout-probe.pkt
> > # TAP version 13
> > # 1..2
> > # tcp_user_timeout_user-timeout-probe.pkt:35: error in Python code
> > # Traceback (most recent call last):
> > #   File "/tmp/code_T7S7S4", line 202, in <module>
> > #     assert tcpi_probes =3D=3D 6, tcpi_probes; \
> > # AssertionError: 0
> > # tcp_user_timeout_user-timeout-probe.pkt: error executing code:
> > 'python3' returned non-zero status 1
> >
> > To be accurate, the patches batch under tests also includes:
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1010780
> >
> > but the latter looks even more unlikely to cause the reported issues?!?

Not sure, look at the packetdrill test "`tc qdisc delete dev tun0 root
2>/dev/null ; tc qdisc add dev tun0 root pfifo limit 0`"

After "net: dev_queue_xmit() llist adoption" __dev_xmit_skb() might
return NET_XMIT_SUCCESS instead of NET_XMIT_DROP

__tcp_transmit_skb() has some code to detect NET_XMIT_DROP
immediately, instead of relying on a timer.

I can fix the 'single packet' case, but not the case of many packets
being sent in //

Note this issue was there already, for qdisc with TCQ_F_CAN_BYPASS :
We were returning NET_XMIT_SUCCESS even if the driver had to drop the packe=
t.

Test is flaky even without the
https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1010780
series.

