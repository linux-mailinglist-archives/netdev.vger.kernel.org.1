Return-Path: <netdev+bounces-156799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B5A07D95
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C3A188C66D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAD221DAE;
	Thu,  9 Jan 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIdA1j0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39D221D82
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440335; cv=none; b=VjFE6anFRwNQE6Wvr4G6ypVkL1k8GBlzYNf6lDD7byFw09eewDhGhQgW41T39WOf5Ot/2HvG1bMvY3cs8oPuzuLrRnMtSKbfyw3ZOg7OnS3Vx4N1/plHn5XRolFncmpI3dxC+q+OmtjANWdLhPBpOPsMBkRdZTaE+lY5Kqg5MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440335; c=relaxed/simple;
	bh=gBaoYTVVgV38dqT3uXdKjpfiBlqAQdazMbAVWhjrQ5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Stcu26HoO/DjmgoTGExaBJ2AdluvtydBAobIWCzkeRY46UEuvX6AUE8CVPUhf4AwAHUchh8IPyj+iPeIR6Kl10xEarBMC84PMmFGKTPHPs5jDzhJghJdh8EgEWnfEr3YDXrKQIxeF1DENBf6H2bv8VfpSjJpsAL0uYHwJgjtgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIdA1j0A; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4678c9310afso248581cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736440332; x=1737045132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq4abz6I9LcmxiDxc5hEV019DJ2bCXGY0QWRskzVevA=;
        b=xIdA1j0AXuCdaik+EP9pqsAYTEoZO00SZqE/9HY9lKpetCa0efA3MfWbnISPRRuKQm
         johnNhJFI2VWUj6UjUrea8iyY/jb6HAxpqOxClWdaW4mo11ZCA/TnvRn5xwmotNYfQ1p
         cMkYB0CVRjgkBefY1dtOivsXdpRmOQADGabdEwoeAD/MOTXbz+fg4BjtUqLdW3a13Tyr
         ylw3mi1dMlItT0GaFlt295h4VKsGurO4DWq6wbxvKP/B4BiTvO4O663wvQR36esM/u3e
         iybBxBon3wal3eKIVI83ZqvVMApm83mn+mA4lsexfrn1Q4WPQb8IuPeDhVqEFbMQMUIu
         pYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440332; x=1737045132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq4abz6I9LcmxiDxc5hEV019DJ2bCXGY0QWRskzVevA=;
        b=fcK9GUhCO/vyUCydmdnrOTaQv5/kwf1R3kQoY72+9rxw88K+BEd8vTVAxN4fsYylwf
         8avUii3xpK5xmRGGsZPWp58/rUb950QX32k5rDaj5S5KorWki5ia5aNvTTG0vIQPmw77
         pUP2vIODAXRZJGNKwo2A4FI0Ph7sr/XxrIR1qbHBbU1wuIrsI3XSUzs+10NXRzUn76sB
         /H6YY71y2VZsqwe4CiqC6wgOFq7UnKIfXGQWMMlHAcVF33bHK6L6WE3T/EjxDLTKSbPG
         EaeRDGEyox8WEZQ5gCiv2Sh/TP1DEw7WxO3dcp+BlYzHio3zMLCEu3rxJaADEL6vC1ES
         eJVA==
X-Forwarded-Encrypted: i=1; AJvYcCWDmskrNZ81/U+GSvktXRq3ZdD9SesiFT7te8FTze/ZS+FxJf2v+Bh2Xhl+Y6pQksnsj/RVGJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEJxtdByBYFQCgYH4O7GE7yXFZegvpEYLBGd6DINhZGTf2HOw
	BQmtk8lg18MF9+fCaC3Ey66+LxR6RuTLKYTprGsmU+yy5T9v1qfIciYBE1cIk5Ij4i+YmPr1zQ+
	J6OJSzuy9w677LlNVJ/ljX7sWT8tHaGnLsKie
X-Gm-Gg: ASbGnct6qOFr8iJNr72Vk8ZQ99HLtV3QdkV0K6+pLdC6GmXc3ETH1o+EO32se+9WGIY
	4cO2MMWSmHzJmY1lYQfNGp39v/2zKGyujrWdEEwndd5K48KHlALs7iXN6SCer0+uqSyCC0g==
X-Google-Smtp-Source: AGHT+IFEJHjfM/j0TAkx0dn+Yqq1paV/VeoS0X+Gih8nbJ2uTmVWEEFITM8oFXTVTuYMHsR9iJIU2ZtBNv5ZCvHiY8s=
X-Received: by 2002:a05:622a:386:b0:461:358e:d635 with SMTP id
 d75a77b69052e-46c7bef1660mr4509411cf.18.1736440332099; Thu, 09 Jan 2025
 08:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109161802.3599-1-sensor1010@163.com>
In-Reply-To: <20250109161802.3599-1-sensor1010@163.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 9 Jan 2025 11:31:55 -0500
X-Gm-Features: AbW1kvbiBRLLkAEChgPv_uoYdTqHgBbS4BbWAR69au-g16kfMOq98PNzh1_pEws
Message-ID: <CADVnQy=Uy+UxYivkUY1JZ4+c2rDD74VY8=vxmxf=NJxWcXa69Q@mail.gmail.com>
Subject: Re: [PATCH] tcp: Add an extra check for consecutive failed keepalive probes
To: Lizhe <sensor1010@163.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:21=E2=80=AFAM Lizhe <sensor1010@163.com> wrote:
>
> Add an additional check to handle situations where consecutive
> keepalive probe packets are sent without receiving a response.
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  net/ipv4/tcp_timer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index b412ed88ccd9..5a5dee8cd6d3 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -828,6 +828,12 @@ static void tcp_keepalive_timer (struct timer_list *=
t)
>                 }
>                 if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <=3D 0) =
{
>                         icsk->icsk_probes_out++;
> +                       if (icsk->icsk_probes_out >=3D keepalive_probes(t=
p)) {
> +                               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                               SK_RST_REASON_TCP_KEEPALI=
VE_TIMEOUT);
> +                               tcp_write_err(sk);
> +                               goto out;
> +                       }
>                         elapsed =3D keepalive_intvl_when(tp);
>                 } else {
>                         /* If keepalive was lost due to local congestion,
> --

Can you please explain the exact motivation for your patch, ideally
providing either a tcpdump trace or packetdrill test to document the
scenario you are concerned about?

The Linux TCP keepalive logic in tcp_keepalive_timer() already
includes logic (a few lines above the spot you propose to patch) that
ensures that a connection will be closed with ETIMEDOUT if consecutive
keepalive probes fail:

                if ((user_timeout !=3D 0 &&
                    elapsed >=3D msecs_to_jiffies(user_timeout) &&
                    icsk->icsk_probes_out > 0) ||
                    (user_timeout =3D=3D 0 &&
                    icsk->icsk_probes_out >=3D keepalive_probes(tp))) {
                        tcp_send_active_reset(sk, GFP_ATOMIC,

SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
                        tcp_write_err(sk);
                        goto out;
                }
                if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <=3D 0) {
                        icsk->icsk_probes_out++;
                        elapsed =3D keepalive_intvl_when(tp);

AFAICT your patch nearly duplicates the existing logic, but changes
the application-visible behavior to close the connection after one
fewer timer expiration, thus breaking the semantics of the
net.ipv4.tcp_keepalive_probes.

neal

---

ps: For reference, here is a packetdrill test we use to test this
functionality; this passes on recent Linux kernels:

// Test TCP keepalive behavior without TCP timestamps enabled.

`../common/defaults.sh`

// Create a socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0

   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

// Establish a connection.
   +0 < S 0:0(0) win 20000 <mss 1000,nop,nop,sackOK,nop,wscale 8>
   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
  +.1 < . 1:1(0) ack 1 win 20000
   +0 accept(3, ..., ...) =3D 4

// Verify keepalives are disabled by default.
   +0 getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [0], [4]) =3D 0
// Enable keepalives:
   +0 setsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], 4) =3D 0

// Verify default TCP_KEEPIDLE is 7200, from net.ipv4.tcp_keepalive_time=3D=
7200:
   +0 getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) =3D 0
// Start sending keepalive probes after 3 seconds of idle
   +0 setsockopt(4, SOL_TCP, TCP_KEEPIDLE, [3], 4) =3D 0

// Verify default TCP_KEEPINTVL is 75, from net.ipv4.tcp_keepalive_intvl=3D=
75:
   +0 getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [75], [4]) =3D 0
// Send keepalive probes every 2 seconds.
   +0 setsockopt(4, SOL_TCP, TCP_KEEPINTVL, [2], 4) =3D 0

// Verify default TCP_KEEPCNT is 9, from net.ipv4.tcp_keepalive_probes=3D9:
   +0 getsockopt(4, SOL_TCP, TCP_KEEPCNT, [9], [4]) =3D 0
// Send 4 keepalive probes before giving up.
   +0 setsockopt(4, SOL_TCP, TCP_KEEPCNT, [4], 4) =3D 0

// Set up an epoll operation to verify that connections terminated by faile=
d
// keepalives will wake up blocked epoll waiters with EPOLLERR|EPOLLHUP:
   +0 epoll_create(1) =3D 5
   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=3DEPOLLERR, fd=3D4}) =3D 0
   +0...11 epoll_wait(5, {events=3DEPOLLERR|EPOLLHUP, fd=3D4}, 1, 15000) =
=3D 1

// Verify keepalive behavior looks correct, given the parameters above:

// Start sending keepalive probes after 3 seconds of idle.
   +3 > . 0:0(0) ack 1
// Send keepalive probes every 2 seconds.
   +2 > . 0:0(0) ack 1
   +2 > . 0:0(0) ack 1
   +2 > . 0:0(0) ack 1
   +2 > R. 1:1(0) ack 1
// Sent 4 keepalive probes and then gave up and reset the connection.

// Verify that we get the expected error when we try to use the socket:
   +0 read(4, ..., 1000) =3D -1 ETIMEDOUT (Connection timed out)

