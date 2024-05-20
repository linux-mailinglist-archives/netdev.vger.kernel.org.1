Return-Path: <netdev+bounces-97208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B11D8C9F6A
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030C82811D7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0681136E05;
	Mon, 20 May 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NC+r9Iqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF3136E0C
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217967; cv=none; b=nnlD9y9HHF51hDzPumGrLOF6C0rDnnqPjjYepY54rdJ/BwzaS8WYJAaU0m3QKrE2R7Y39JwRz9lV/CtmbIKkZWXdaAUIOtTpiGRLVaU+7CrzAR22dWjESjsjLsXupUQoYBDM0b6hLTAdaRYRddN+ozZxLi+MI15j09nqqWR/GU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217967; c=relaxed/simple;
	bh=KQswLALpRaa6Pp5lFgX6pCJr8nQwNjPfweVHXzM+gxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwM/GAaB+vdbyYfTT7Fdfgpps+fiL4OeW70F9ZkNFo3szIL956ecEIjqOJ8K0VxUCekW7T/AB88G1dk6UH4T9ma4mjSzsPKDCqWFgm77LVYY5SfEAKwUumjATaf/RMXXR0G/DHitz1co1UoLidU1FOLsw00KkqUB72hJ1INn5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NC+r9Iqf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso13754a12.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716217964; x=1716822764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il40ktC8l6a8ciEVVasoNKyAWxk8Uv9/W3to/R6sjfg=;
        b=NC+r9Iqf/sQRdfkz2RI0GfQB6Jtv1yp4Gloq+6a5TfwdNM8andWl5CnsiLmyuf9Au4
         1kMDw3o9oOdJJfNtZYpjzxcQA2ADHToxurvM920rcPC5Hi51HJwuXAhmHaSgLkVh9X58
         1gpB2EqKJ52Z2urJs9k5NGKeP4XHbd/JHZT6gC2QQnpH9Ro1yUfiOuUB8aX9R5/aJUPI
         iFx+jlR6vVlCsWyAHY5d8E3GKhxZhJVs42UUYmZwCfU2BtEQ1duknvOIZzQ8luKCEeZ2
         2kThNQonzDxt0+X9898oOh1Horv4klDJOIPtzltLza/Elx4PODOsSviZDzfmNhbPsrZ8
         WeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217964; x=1716822764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il40ktC8l6a8ciEVVasoNKyAWxk8Uv9/W3to/R6sjfg=;
        b=UDYoTJygs+A69lMcsDVCLZ+C9rAojKKq/eKuGvJs9PrqhDS3m4cc2xXkmnF0N6uqoV
         6Fk+TEH+5SVJRZUpiQf/gsf4s4rSmHUJk/mGmGyRSkN5jAmZm3R3ohy5LymGyMwSxuvG
         dGwO/SeAEhkwvOw3RQTlrBRE6bybi0xnE4GjY0BBiBl/a+tYNvd3/FBlTR8PT5Rk+cIi
         DJBA1nWsyRswsrG0ifIfn7GvZyNLUAgIVz1dRS4mIEFqRqQMP/98f/0o5QIPg/hs8psr
         mr1dxPsePCWfqYJDgLxTeMw/Z6m+jXR9UTR7PjLzDZvUhChE11q7l8J5q/37c09aqj5i
         cHVA==
X-Forwarded-Encrypted: i=1; AJvYcCXIqt2zdcXpacEFRm3FF+H+dtyw0lb1W1++RBmfhI1ehWOEI0zmdssK26mOyNGg4Lxh31PkLQXb4nFB61Iyk5E/aJmZuPKA
X-Gm-Message-State: AOJu0YwR/QkWSl7jBE8wTWNbD2+Y+gDPda5U8imwP1Y3OZOeXtOG/b63
	i3XjVLfhsKlOSsxCHsximEYMCU6+QaZjBIFyZPKbJU9+Cu7AJWxKnorMdtgLW+Y8EpzNoqB8Rpq
	FBxTXNlIq86CngWJoFJFMgUoTJNQA+mGf7+jT
X-Google-Smtp-Source: AGHT+IFyNr0Yc3QNIZxM5le/WmeFs356wlbPEA9sTZdth25cJo81QYY21AaXWDGnrinqixVF9qZv/G3zooCDbftmMuU=
X-Received: by 2002:aa7:d646:0:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-5752c771d19mr240882a12.5.1716217964206; Mon, 20 May 2024
 08:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com> <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
 <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
 <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com> <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
 <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com>
In-Reply-To: <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 17:12:30 +0200
Message-ID: <CANn89i+WsR-bB2_vAQ9t-Vnraq7r-QVt9mOZfTFY5VD7Bj2r5g@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 4:14=E2=80=AFAM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
>
>
> On 5/17/2024 1:08 AM, Subash Abhinov Kasiviswanathan (KS) wrote:
> >
> >
> > On 5/16/2024 12:49 PM, Subash Abhinov Kasiviswanathan (KS) wrote:
> >> On 5/16/2024 2:31 AM, Eric Dumazet wrote:
> >>> On Thu, May 16, 2024 at 9:57=E2=80=AFAM Eric Dumazet <edumazet@google=
.com>
> >>> wrote:
> >>>>
> >>>> On Thu, May 16, 2024 at 9:16=E2=80=AFAM Subash Abhinov Kasiviswanath=
an (KS)
> >>>> <quic_subashab@quicinc.com> wrote:
> >>>>>
> >>>>> On 5/15/2024 11:36 PM, Eric Dumazet wrote:
> >>>>>> On Thu, May 16, 2024 at 4:32=E2=80=AFAM Subash Abhinov Kasiviswana=
than (KS)
> >>>>>> <quic_subashab@quicinc.com> wrote:
> >>>>>>>
> >>>>>>> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
> >>>>>>>> On Wed, May 15, 2024 at 6:47=E2=80=AFAM Subash Abhinov Kasiviswa=
nathan (KS)
> >>>>>>>> <quic_subashab@quicinc.com> wrote:
> >>>>>>>>>
> >>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A)
> >>>>>>>>> was having
> >>>>>>>>> a slower single stream download speed compared to a device runn=
ing
> >>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with
> >>>>>>>>> iperf3 with
> >>>>>>>>> window size 4M from a third party server.
> >>>>>>>>
> >>>>>>
> >>> This is not fixable easily, because tp->window_clamp has been
> >>> historically abused.
> >>>
> >>> TCP_WINDOW_CLAMP socket option should have used a separate tcp socket
> >>> field
> >>> to remember tp->window_clamp has been set (fixed) to a user value.
> >>>
> >>> Make sure you have this followup patch, dealing with applications
> >>> still needing to make TCP slow.
> >>>
> >>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
> >>> Author: Hechao Li <hli@netflix.com>
> >>> Date:   Tue Apr 9 09:43:55 2024 -0700
> >>>
> >>>      tcp: increase the default TCP scaling ratio
> >>>> What happens if you let autotuning enabled ?
> >> I'll try this test and also the test with 4M SO_RCVBUF on the device
> >> configuration where the download issue was observed and report back
> >> with the findings.
> > With autotuning, the receiver window scaled to ~9M. The download speed
> > matched whatever I got with setting SO_RCVBUF 16M on A earlier (which
> > aligns with previous observation as the window scaled to ~8M without th=
e
> > commit).
> >
> > With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download speed
> > increased significantly but didn't match the download speed of B with 4=
M
> > SO_RCVBUF. Per commit description, the commit matches the behavior as i=
f
> > tcp_adv_win_scale was set to 1.
> >
> > Download speed of B is higher than A for 4M SO_RCVBUF as receiver windo=
w
> > of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.
> Would the following to change to re-enable the use of sysctl
> tcp_adv_win_scale to set the initial scaling ratio be acceptable.
> Default value of tcp_adv_win_scale is 1 which corresponds to the
> existing 50% ratio.
>
> I verified with this patch on A that setting SO_RCVBUF 4M in iperf3 with
> tcp_adv_win_scale =3D 1 (default) scales receiver window to ~4M while
> tcp_adv_win_scale =3D 2 scales receiver window to ~6M (which matches the
> behavior from B).

What problem are you trying to solve that commit  697a6c8cec03c229
did not ?

>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 618f991cb336..1bca7d2e47c8 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1460,14 +1460,23 @@ static inline int tcp_space_from_win(const
> struct sock *sk, int win)
>          return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
>   }
>
> -/* Assume a 50% default for skb->len/skb->truesize ratio.
> - * This may be adjusted later in tcp_measure_rcv_mss().
> - */
> -#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))
> -
>   static inline void tcp_scaling_ratio_init(struct sock *sk)
>   {
> -       tcp_sk(sk)->scaling_ratio =3D TCP_DEFAULT_SCALING_RATIO;
> +       int win_scale =3D
> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_adv_win_scale);
> +
> +       if (win_scale <=3D 0) {
> +               if (win_scale < -TCP_RMEM_TO_WIN_SCALE)
> +                       win_scale =3D -TCP_RMEM_TO_WIN_SCALE;
> +
> +               tcp_sk(sk)->scaling_ratio =3D
> +                       1 << (TCP_RMEM_TO_WIN_SCALE + win_scale);
> +       } else {
> +               if (win_scale > TCP_RMEM_TO_WIN_SCALE)
> +                       win_scale =3D TCP_RMEM_TO_WIN_SCALE;
> +
> +               tcp_sk(sk)->scaling_ratio =3D U8_MAX -
> +                       (1 << (TCP_RMEM_TO_WIN_SCALE - win_scale));
> +       }
>   }
>
>   /* Note: caller must be prepared to deal with negative returns */

