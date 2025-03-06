Return-Path: <netdev+bounces-172373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52238A546C2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8957A2C40
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89820A5C1;
	Thu,  6 Mar 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbsvuwCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD018DB3F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254354; cv=none; b=BxlmtHKK0IMqVb09bFzFb+oGj/BidkRcK2RyqX/9z3iMTzEU4ZE3jo+/g15jbl96JNzn3p57wMN1vr2+iJlpESghRQE4sqvz0yk4h2CXL0aiBxJLZfV+uCDqvyMThRezFHGp5XNzQ0s0sVE/9LRd+o6+d+Vu/wKnfzoXqU1xZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254354; c=relaxed/simple;
	bh=qjo4gtWl14tUvMyk93jmHZ18fnXzKIxhyABTH4qjF4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQChDQAIrK0HFjZVTGEDAaw42Zzfb4aKhx1uiEjEFzZUkQFcO1fhu6rGMnGP08P07agOVHpOnS9muRU+PV4m9u3zNuvBPDAVVEPrfQfQJKyCDwgw3YcKQnXwQq09fIUHTe0fOBSVvUnUNHieQEPqVh4AS+9rt+9crRoxcBYA+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbsvuwCv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c08b14baa9so39432085a.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741254351; x=1741859151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsHho8Y99QQpo0CdnWI7k6TmyzrDv14W4rRXNpqU1DE=;
        b=IbsvuwCvTmYG2c3sTdld0KxkfMXo0SOuer/b72QIebAY5tw4xbIwHOsXX8Cxqi8wGk
         MnCikdfHkruHrL/zqoGsBZYMPiLY0WimDT9cFh4Pm0GHuma9B6iXQdzLFnfdLfZeNlsn
         He8B0dAs17uLo/HtJCos1v9fPmtNCLe6IwgrKbE0qL80lY0YDDEbcmn+d6qZOYN/g+bP
         84rMlhSLJsBpP8V2DlxWFoAipDY8GdChq2kS5GtH2c0BlbJsKSCQ1MZoefSr+B2RpRMu
         PL9Wx+mz0kFhSW8k3vCAVFWV7CkPOO8h8leeDFuYPvU/lVNP6p05uouLGL0vR3panKV1
         Kcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254351; x=1741859151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsHho8Y99QQpo0CdnWI7k6TmyzrDv14W4rRXNpqU1DE=;
        b=S9QHcQpaSyXZysuqMrGjD4cDgx7Zjc3YVY/Z/qquqNRSDOgFGWdO0Mu79qQyBWLpDJ
         IPRFjvGR6rS9qwxWGZPedjRRZVh7QD/6VCSQqruQPoCMSU37WKXXeV9fkpYrVljcQblc
         ksKeY7WddYJv7irbXG866aCHDojBP8uZsOF4/VfxGF3IavGwVDGTpDbDE5O8QckCH2xe
         fF8RJvD1iOkkuMZ/CnbhR/eqXoEBhKEFt8VtoRuC+vAdp8hmrcNNMpwJL6DRYgva5xXB
         QlFZOR60h/8LfC3u0WwsZlzlTvPbBdcA1pnwtBYoAM5TGuvPNTsPXXUb2FTH4At0cgep
         G2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXziM4ynUeUhbX5HMwgwFMw3pYIeV5ndBsMnhXcIO3iR7NEhwY39nrRx0ZqOVbc+QpFXo5Uqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2uxMtb5lIQ56Ouprg9c+dLHG2FwMpoFjSDwgTkbHbfD4YvdE
	s35XXicYuQx1TcjDKVbBVJpHoh4F9yhNVuEfCq3yuNizNsMPCFwdGzRVXaKnFRH1dZNN53lf4qO
	DsGVcjS3k/53MwvRZAGxeXoXwCxtgfkpldK6v
X-Gm-Gg: ASbGncscD4E6B8KvglSPDqHuMRi1yohAnovGztk1jzsBCBsMCLPA5AsppLV4ozXdh0P
	mGg1HedRcZbBgwImpUmaAKJpah5qMpyWredycBcGGle++mhAS/BTTMV1yb3RooTzb+c1kq8lffu
	BsDOgtK/adH1k6/8YmsUWndJpHpHo=
X-Google-Smtp-Source: AGHT+IE6EUehIhxTcDsLk5kTJDnbnvq9N+O903gXW3JiyNgA2aMjfH7hC/XgVWrM/4NxpLff1hnyKD7alGG7U4imr3s=
X-Received: by 2002:ac8:5807:0:b0:472:1406:69ea with SMTP id
 d75a77b69052e-4750b4484aemr103704431cf.19.1741254351049; Thu, 06 Mar 2025
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org> <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
In-Reply-To: <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 10:45:40 +0100
X-Gm-Features: AQ5f1Jpgmfpp_PSnvqSs1MH6kttfr7_Y21lbioBLWHOJed_oQfDKk154L2pM6C0
Message-ID: <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
> >
> > A recent cleanup changed the behaviour of tcp_set_window_clamp(). This
> > looks unintentional, and affects MPTCP selftests, e.g. some tests
> > re-establishing a connection after a disconnect are now unstable.
> >
> > Before the cleanup, this operation was done:
> >
> >   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> >   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> >
> > The cleanup used the 'clamp' macro which takes 3 arguments -- value,
> > lowest, and highest -- and returns a value between the lowest and the
> > highest allowable values. This then assumes ...
> >
> >   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> >
> > ... which doesn't seem to be always the case here according to the MPTC=
P
> > selftests, even when running them without MPTCP, but only TCP.
> >
> > For example, when we have ...
> >
> >   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> >
> > ... before the cleanup, the rcv_ssthresh was not changed, while after
> > the cleanup, it is lowered down to rcv_wnd (highest).
> >
> > During a simple test with TCP, here are the values I observed:
> >
> >   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> >       117760   (out)         65495         <  65536
> >       128512   (out)         109595        >  80256  =3D> lo > hi
> >       1184975  (out)         328987        <  329088
> >
> >       113664   (out)         65483         <  65536
> >       117760   (out)         110968        <  110976
> >       129024   (out)         116527        >  109696 =3D> lo > hi
> >
> > Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> > higher than rcv_wnd (hi), so having a different behaviour when the
> > clamp() macro is used, even without MPTCP.
> >
> > Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd)
> > here, which seems to be generally the case in my tests with small
> > connections.
> >
> > I then suggests reverting this part, not to change the behaviour.
> >
> > Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks for catching this. I should have done more tests :(
>
> Now I use netperf with TCP_CRR to test loopback and easily see the
> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
> tp->rcv_wnd is not the upper bound as you said.
>
> Thanks,
> Jason
>

Patch looks fine to me but all our tests are passing with the current kerne=
l,
and I was not able to trigger the condition.

Can you share what precise test you did ?

Thanks !

