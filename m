Return-Path: <netdev+bounces-232578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F8C06C3E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0494E1E29
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7620F079;
	Fri, 24 Oct 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myKeebTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EC230270
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317265; cv=none; b=X0k6vwQU2I6SWgaEr4ba+eM3iLF8fV2U5cTkvgwx87OF2eIIg4yA1DrHlwk5cYRgxwSOMTSLAOuDecypAysM5tONXWlcmz2LO12GeGx3SaUHSDZ2F0MpqnvIDkEcFz08c7aLC8d3m59vp1yA7mSXA+/Gc8Ivk6x5SZIotSNClqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317265; c=relaxed/simple;
	bh=g0OQj2odqnKGjjUCjL4JSUE+49bnKRi0zUdHPIjn5Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuR/eozJnbGeXSio/ikhSpZ6w6SdRTFej2QcLP5k1PiihvZMkDKUqkElN548EpXxjpfrQseeTYHzQHKErtYTJYdnP6LHy7K6UggBUGgmlLcBC3sLjTf3HiX0J8UlLvrG0TQvZ+TrjjEfoWYtM37Gqj3r/5WiAKo4i3Ew+nrrfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myKeebTQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e88cacc5d9so18994601cf.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761317263; x=1761922063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zsathjUD8Tufz0Hkfd/J7QuTnTEjh6BgaqtFOpsb0E=;
        b=myKeebTQW/DXzYuQuQZ0Di+cldBua/d+py3z4rWvsjsfzwF4eV+y7FmOSu7sKqScNm
         039lvedbzJy3aT6SCFFcrS7GKGIWpn+TUMu6MRqXO4dCdw5BiNUtCbxczHj6flPnFBhf
         aCGjEs+7l+2GLpdtf14ihCTRy2efInayMH2NjYh1Y8b09oJwPutTGjXDGBulh8LYK0vA
         nB0+ozz+WipzGy53FitbLw5hSsP+c3FjSpnoeeNmASzo1+O69FDcmRgPFsKmKePgowxr
         T0UJ4YC7LANsTEQGiqiVfrfK+4SefRbi7Ubrov0ocQ6vqanArdUo8ptrQWQCPqzzxvLN
         RXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317263; x=1761922063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zsathjUD8Tufz0Hkfd/J7QuTnTEjh6BgaqtFOpsb0E=;
        b=rZt3O74o1oHKIZZXM1qU8fhE07dihc1k1GG3MzjESfJha1ze5G308ZZCR2zH+kYk0X
         7xD8Aa4Gad7+twS71uZcoIJIixAhNBuXj2j4W6ihLIpwt9mL3NH9NuCauAj291nlqW/J
         GOGmouQSWDMjh9V36TmMR632B6OhYioGDRvpCScqXfsV5Mh2ejphahT/nN5yVu0k4NUP
         j/XlWb0IsYHkLezgQ+ISTjfApZF1T5zC6SiYFj8GeN33ODRXCZ30/b9kSM2TZP3ZcpT/
         q8uCMJbho7w8zHEbIMwC2EerZbNb4NODqDcSgk1WiMyWM01BGiU+xMcIjiwfCw9QlqNL
         xSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7jGD0MSuaTkAb1AKjDBhqbxYWYYoTu0TESakXdUDzJwprwij3GFw3143WWuE+dO7T9IxqjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDPXSrWKKaVwP5ZtYiYd+cClLSIdDrX28nD4prqZZDxeapTrd
	p7dDw3mf55ZYfSILhHIWg5NfoE+0zVbhBXq9I98ALNE4HQqs6eL+5UDCczL6Z/8ix0D8U40bkQR
	8HG8VKOaN1Pb5tYzVMGJZKeBHSso4i7hCXIVHaf46
X-Gm-Gg: ASbGncsLIi7bd2xaCYa5Ic2FJPqjM3KsNULdQkZfH4delzyCviWa38Lh7H+C2RPhVwX
	CP+OhKknzQlXhb8gisS/5u7IXtoy/3vqmqh4vjTMDtC/fFbHHmaE+osXZAdQD0RgoEpbkjqLXVP
	ykr1vwWXiFWvI+AU+iV62s0xAAqBYRQZ9uVy44Kd8ST4KHAvOc25Wy8ehj9GTexYdmdYeCBDuD8
	ioOGVV5bFms7JSpAUw5VDZCoCL83ylXACqLNC395MQyDYJW4N5pSZ99sV9kXe4OqITjnQ==
X-Google-Smtp-Source: AGHT+IFrRie5LZwAXyGo8VdA/dW0Kw6zQOvMyJ84skrhz0SomwbTbyAoOgLOsZ/ffDKChWlscWABZ7AWSLtoQ3SeUFY=
X-Received: by 2002:ac8:5e0c:0:b0:4e8:a870:a608 with SMTP id
 d75a77b69052e-4e8a870ab1emr345457141cf.76.1761317262327; Fri, 24 Oct 2025
 07:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com> <20251024075027.3178786-3-edumazet@google.com>
 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com> <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
 <44b10f91-1e19-48d0-9578-9b033b07fab7@kernel.org>
In-Reply-To: <44b10f91-1e19-48d0-9578-9b033b07fab7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 07:47:31 -0700
X-Gm-Features: AS18NWBzi8QtBKdD5zQiZ8is6b_JvGVdtA3bpgRArMUuLXYqOKpQhORIPeWKac0
Message-ID: <CANn89iKgqF_9pn6FeyjKtq-oVS-TsYYhvyVRbOs3RzYqXY0DWQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:02=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 24/10/2025 13:19, Eric Dumazet wrote:
> > On Fri, Oct 24, 2025 at 3:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> Hi Eric,
> >>
> >> Many thanks for tracking this down!
> >>
> >> Recently we are observing mptcp selftests instabilities in
> >> simult_flows.sh, Geliang bisected them to e118cdc34dd1 ("mptcp: rcvbuf
> >> auto-tuning improvement") and the rcvbuf growing less. I *think* mptcp
> >> selftests provide some value even for plain tcp :)
> >>
> >> On 10/24/25 9:50 AM, Eric Dumazet wrote:
> >>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >>> index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec65=
657ec179cfd52ede483 100644
> >>> --- a/net/mptcp/protocol.c
> >>> +++ b/net/mptcp/protocol.c
> >>> @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp=
_sock *msk, struct sk_buff *to,
> >>>   * - mptcp does not maintain a msk-level window clamp
> >>>   * - returns true when  the receive buffer is actually updated
> >>>   */
> >>> -static bool mptcp_rcvbuf_grow(struct sock *sk)
> >>> +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
> >>>  {
> >>>       struct mptcp_sock *msk =3D mptcp_sk(sk);
> >>>       const struct net *net =3D sock_net(sk);
> >>> -     int rcvwin, rcvbuf, cap;
> >>> +     u32 rcvwin, rcvbuf, cap, oldval;
> >>>
> >>> +     oldval =3D msk->rcvq_space.copied;
> >>> +     msk->rcvq_space.copied =3D newval;
> >>
> >> I *think* the above should be:
> >>
> >>         oldval =3D msk->rcvq_space.space;
> >>         msk->rcvq_space.space =3D newval;
> >>
> >
> > You are right, thanks for catching this.
> >
> > I developed / tested this series on a kernel where MPTCP changes were
> > not there yet.
> >
> > Only when rebasing to net-next I realized MPTCP had to be changed.
>
> Thank you for the fix, and for having adapted MPTCP as well!
>
> >> mptcp tracks the copied bytes incrementally - msk->rcvq_space.copied i=
s
> >> updated at each rcvmesg() iteration - and such difference IMHO makes
> >> porting this kind of changes to mptcp a little more difficult.
> >>
> >> If you prefer, I can take care of the mptcp bits afterwards - I'll als=
o
> >> try to remove the mentioned difference and possibly move the algebra i=
n
> >> a common helper.
> >
> > Do you want me to split this patch in two parts or is it okay if I
> > send a V2 with
> > the a/msk->rcvq_space.copied/msk->rcvq_space.space/ ?
>
> If you send a v2, could it eventually target "net" instead please?
>
> If the idea is to delay the fix to stable, it is always possible to ask
> the stable team to backport it to stable in a few weeks / months, e.g.
>
>   Cc: <stable@vger.kernel.org> # after -rc6
>

I usually stack multiple patches, and net-next allows for less merge confli=
cts.

See for instance
https://lore.kernel.org/netdev/20251024120707.3516550-1-edumazet@google.com=
/T/#u
which touches tcp_rcv_space_adjust(), and definitely net-next candidate.

Bug was added 5 months ago, and does not seem critical to me
(otherwise we would have caught it much much earlier) ?

Truth be told, I had first to fix TSO defer code, and thought the fix
was not good enough.

