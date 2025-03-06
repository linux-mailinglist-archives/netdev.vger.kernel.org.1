Return-Path: <netdev+bounces-172422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D137A548BC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B633D172978
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0902045BC;
	Thu,  6 Mar 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmAfn7Yg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0D20371F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259323; cv=none; b=PiLPQJZyrxO6iU/3uOdIUaWSrO5JVCSYjmJaOJg6+ptmDUx0v9pF/n6mmWvN40awo76YBbv1O6XapVRIplaO/4bWrfumH+UKiQAMe/xo1A39v3Yk/N0Oy5VkCCwAKk9T521GD8fsPw1+ArWqVTsT9YCO3GydTJsrRQx1ZM4G6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259323; c=relaxed/simple;
	bh=1l2lg4pxnKWN66VYlhTC0zCZyNqViTJOeCnoCR667mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGkLUn0Oqcq3AiLQUfP7ajl2JvMpkuVzMrtHr/74puD6pKuSAH8jX6egZBKV4Km21YIrGmp4j6BLIAgTJ6EUM/ruIWNd4DYvNKVuZmStvKrvFBVe+9e96UgcK07Kl2KQGauT2UfVrW9QrzDr/EFVWC88KZjLQtGuRsBS3+SraAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmAfn7Yg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so6981006d6.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741259320; x=1741864120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HOAdle44AxtzHdRU+24G5NySxyY61Mu4iq8aJK231o=;
        b=CmAfn7Yg6yY2VH2yjSe3sy6EMny1FCd3wcKfhsOYhaRauUsDq8VqTA3EjygXuhS6gi
         tahiMvzPr+kDtxJvtbAt3+ZMw471nibDAkoaiI3rZdBforj61QYKuza9iFFB7F9+G0fw
         lDRwdfNbFowqsw18evrmyrIF3KfOgC/yF4/Yn9FFm38/1mSeXT8M5NTS75oo5NsBpMFA
         CPNuraePWimvYNkzZ2q3tZg3QALNg9kmXx0f4VfBNWU7xENmY+fl8uqsLUH5YwR9Y/Dt
         W+/ZgTja8cvfnjVolpCUlidCcqpiWzGJairMjuslCwTCSoU7jZ8ktKIFT5stb9Er/o4o
         88TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259320; x=1741864120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HOAdle44AxtzHdRU+24G5NySxyY61Mu4iq8aJK231o=;
        b=dgMdbAOGojJsGVIULG6kQffl5ZTWOd6OsYaFVta263va3MsPI95wUFCABm+gzlnDb/
         zqRknPMi0pQK++08d3K/ylGLSmRYtOedtM3pxdNV87t5tA6rpDwYFzBJMCeKVqm5zHpq
         /EtuP7AUw1mGHmkXTgNWHAIkoTylaL3F7ISjVzIASKmF0zqIZytpYGegXM4ohuhycXlf
         G9LhMnQI9jriu56pzv5ZHbpRzFLWSezj5fbqHdpYm8nywiuTZQKk13dl0Sozw8JFaXS1
         VaCDwkadbB/HERb3Zs22rnlz8z2tW/Va6xOcqBu2ycgt5cLm1+lJa8Oi0S4489sx4wqP
         GJLg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTMu4jNlK3cXFnvVLXK5R4UHQmlsHZB/0DlThxLJ8l25IlbwyDy/To03Xe3zxmSWhwoTrQwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYqM93yrryCJ5AjahukoqpGATmZeU8vdQbzVa9U5PWcLno503
	tBoezhgwKoM3HkrOj4PPqFaTNoRe9rilU/0Yt13Eh0g4YXBNI9Dmxq94KID8G/RFFuFskuCaAjh
	DDx3oaooFg7G1euPicc7YxlsrZzY+ylna2vhh
X-Gm-Gg: ASbGncs/RehBInVqJMUK8WiujfTlFQcXj7loVE2n1XLGaPZWQtZ3Oqq53M9Lk7NPrvg
	jUZ1WF3yLPrHIT8JqTPCfWylQPTK/L0scfNHefudyXO8DcmcWXZTzli1RFqU34E7tImXDX0hF82
	FatCiodqA6x5sE4+DXORc+P6h4/1Y=
X-Google-Smtp-Source: AGHT+IGqjDyiWMbG6cj6FS2OJY2L/aGCOTmLPTlaPopreMPZINSjvjq5BUceWbtCkk+LzB1fdNlNrVp3CR8l8HiQTI4=
X-Received: by 2002:a05:6214:252f:b0:6e8:ddf6:d137 with SMTP id
 6a1803df08f44-6e8e6cd170cmr106132706d6.18.1741259319968; Thu, 06 Mar 2025
 03:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
 <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org> <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
 <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org> <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
In-Reply-To: <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 12:08:28 +0100
X-Gm-Features: AQ5f1JqnqOEjgEt1NTmjqKYptzUm18O7uGofh7YTyGk_91RbtSC-SoxS4lIhJ18
Message-ID: <CANn89iJ2S+mCs8PxZ-EBAfH--j6v9cUazCc8O4FWvMat=_yURQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Mar 6, 2025 at 11:12=E2=80=AFAM Matthieu Baerts <matttbe@kernel.o=
rg> wrote:
> >
> > On 06/03/2025 11:02, Eric Dumazet wrote:
> > > On Thu, Mar 6, 2025 at 10:55=E2=80=AFAM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> > >>
> > >> Hi Eric,
> > >>
> > >> On 06/03/2025 10:45, Eric Dumazet wrote:
> > >>> On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > >>>>
> > >>>> On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> > >>>> <matttbe@kernel.org> wrote:
> > >>>>>
> > >>>>> A recent cleanup changed the behaviour of tcp_set_window_clamp().=
 This
> > >>>>> looks unintentional, and affects MPTCP selftests, e.g. some tests
> > >>>>> re-establishing a connection after a disconnect are now unstable.
> > >>>>>
> > >>>>> Before the cleanup, this operation was done:
> > >>>>>
> > >>>>>   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> > >>>>>   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> > >>>>>
> > >>>>> The cleanup used the 'clamp' macro which takes 3 arguments -- val=
ue,
> > >>>>> lowest, and highest -- and returns a value between the lowest and=
 the
> > >>>>> highest allowable values. This then assumes ...
> > >>>>>
> > >>>>>   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> > >>>>>
> > >>>>> ... which doesn't seem to be always the case here according to th=
e MPTCP
> > >>>>> selftests, even when running them without MPTCP, but only TCP.
> > >>>>>
> > >>>>> For example, when we have ...
> > >>>>>
> > >>>>>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> > >>>>>
> > >>>>> ... before the cleanup, the rcv_ssthresh was not changed, while a=
fter
> > >>>>> the cleanup, it is lowered down to rcv_wnd (highest).
> > >>>>>
> > >>>>> During a simple test with TCP, here are the values I observed:
> > >>>>>
> > >>>>>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> > >>>>>       117760   (out)         65495         <  65536
> > >>>>>       128512   (out)         109595        >  80256  =3D> lo > hi
> > >>>>>       1184975  (out)         328987        <  329088
> > >>>>>
> > >>>>>       113664   (out)         65483         <  65536
> > >>>>>       117760   (out)         110968        <  110976
> > >>>>>       129024   (out)         116527        >  109696 =3D> lo > hi
> > >>>>>
> > >>>>> Here, we can see that it is not that rare to have rcv_ssthresh (l=
o)
> > >>>>> higher than rcv_wnd (hi), so having a different behaviour when th=
e
> > >>>>> clamp() macro is used, even without MPTCP.
> > >>>>>
> > >>>>> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv=
_wnd)
> > >>>>> here, which seems to be generally the case in my tests with small
> > >>>>> connections.
> > >>>>>
> > >>>>> I then suggests reverting this part, not to change the behaviour.
> > >>>>>
> > >>>>> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> > >>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55=
1
> > >>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > >>>>
> > >>>> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > >>>>
> > >>>> Thanks for catching this. I should have done more tests :(
> > >>>>
> > >>>> Now I use netperf with TCP_CRR to test loopback and easily see the
> > >>>> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which mean=
s
> > >>>> tp->rcv_wnd is not the upper bound as you said.
> > >>>>
> > >>>> Thanks,
> > >>>> Jason
> > >>>>
> > >>>
> > >>> Patch looks fine to me but all our tests are passing with the curre=
nt kernel,
> > >>> and I was not able to trigger the condition.
> > >>
> > >> Thank you for having looked at this patch!
> > >>
> > >>
> > >>> Can you share what precise test you did ?
> > >>
> > >> To be able to get a situation where "rcv_ssthresh > rcv_wnd", I simp=
ly
> > >> executed MPTCP Connect selftest. You can also force creating TCP onl=
y
> > >> connections with '-tt', e.g.
> > >>
> > >>   ./mptcp_connect.sh -tt
> > >
> > > I was asking Jason about TCP tests. He mentioned TCP_CRR
> >
> > Oops, I'm sorry, I didn't look at the "To:" field.
> >
> > > I made several of them, with temporary debug in the kernel that did
> > > not show the issue.
> > >
> > >
> > > I am wondering if this could hide an issue in MPTCP ?
> > Indeed, I was wondering the same thing. I didn't see anything obvious
> > when looking at this issue. The behaviours around the window clamping,
> > with MPTCP single flow, and "plain" TCP were quite similar I think.
>
> OK, let me run mptcp tests just in case I see something dubious.

I have no idea why only MPTCP flows can trigger the condition, I do
not think it matters anyway.

Reviewed-by: Eric Dumazet <edumazet@google.com>

