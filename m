Return-Path: <netdev+bounces-208596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E004B0C425
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397057A31C7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179329B23B;
	Mon, 21 Jul 2025 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPDqX0u7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAC288C80
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101064; cv=none; b=ISJx9RjE8rmC/r1NtAa1jCpZGexLdiqcUol3nh1TANgJ7aceBBpsmCmvP1uEmlWg6rzKmxUkudLPcxvH3qXUh7jAbCjbkvEuaXyyeSpURqAuEAscZsKr87iDwgHK/fnXztofLCF2hvQFeslHgQ63SFkETHo6XJr6KbCwa8S2uAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101064; c=relaxed/simple;
	bh=8nenQ53s+cHDNk/eJ6AsD0FRHplg+zBhNK1F3i6c+2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kH55iX55kMwaU4Z4pkM2rniy68B+4lfn04Px4j3Kj+evxoqL+70uxstKrtobih7ZgoJJijvYthwVADrjYSdo0sg4xv1ntfxA53fDAjgZLF1kR/j7I9DBJPhj14u6I0q9TwJNge3nQUUqZEAhywUjgNW117Wr/qABVgQOmVp3KUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPDqX0u7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab5e2ae630so50395741cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753101062; x=1753705862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG3s6mUPko8JmKCEZA0jAx+ufejcC0f/4tYeTxDXVYU=;
        b=CPDqX0u7v7lsYfzUP/jOS7sBlWt6FONjeVk4rmW7MChHWNumXKM53SSzrMQnRkmglM
         LRrvXsGS38MG0AMlvJ8G1w1rMNzdANy7OdLsTw2IK6YpXviXbAAgYdvlAzKtkkNees7Y
         aviWmsZQbDrjQTiaZhUDe383zsqYb0/GbSofwnBMg17QSVAvY8mnhNUVTcXR8rphJWRg
         sAXA6CK6LacKXWw4npKk6Rlf0+M/U1LIwsnjUJGk0vUHS0s7yJkg0rfzJJUBrCS7pUc4
         Dt9koJoo6MONhpTGsE2W8ha5kNLmj4TxnbCcaLSnF9FJbPYyFdfeNZk5CfoO0dF5DisS
         zkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753101062; x=1753705862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG3s6mUPko8JmKCEZA0jAx+ufejcC0f/4tYeTxDXVYU=;
        b=L8ajGdLlmurqOgOwi5w8hW8En6kyZ74amqtrUw5OzK0+q0YrWvXU7x3jY3PZ9/faw/
         IOU9YJK3ZBrcmXJWz3syDLBD2s7iuJtFYRQrZIX/3ItOJvnt/uG6VWHUu/dcrKbseHy1
         9DGGOKcsFHZc52YTTFa7zpUOa7FAAgAjtcYO0gVvvHsi8egLXpQNgaOC1EBjLGb1SJi/
         LWiQpfZZxljqbyhBgUtq+s3epeWbkRrXjodFHXLnkhwVloiAMkiKggJfK1H/xbIZM503
         pvdizPNOk36XWnkz1TEcc1IPqPBId3AynfeRTusXfkOBDUBU12zO6EepP/A6u+vVMEG0
         4DuQ==
X-Gm-Message-State: AOJu0YyR87nS72U0MCU7hJCsMjNf+72tt/DA4Y8ND9bQq8HCqsKy+aiF
	uFz5unwVfOt+4dE6dfXfGnSOWXhOZzKenvoFng4Ku5YsgUW9DItCOHKb2aU368zgXSv2TCj1tkM
	2Jbr3k7gxwoLtIn1qw3MSwSgrKCaWNdT1jUvw6mpA
X-Gm-Gg: ASbGncvbyNs5ndmpIpl45m6tW7RSMNxarj3CLIo9Xuldx96SdTvNAyMWklmgRQF8Foq
	SO6aRoDMKtuSj6Ff42o0nAyPIMQx01NsOTURP62KkYr20vDBNrg38qM91vhS62hmi2tUEBJOfHo
	T/+QlOM4aMAa48JE6NdxPkhhla7pU1JGdQ6u+9C+jA40eAWwN2rSG8EvuGtzG8f5VJILeuqUkP7
	NlpCrc=
X-Google-Smtp-Source: AGHT+IHhbEV6R+HtlpXyKfOSyb1h/u1IDSZpj8U6vH3hJNm9xkFT+VxIOL+HYM1+PbyRuW73amTekCzMdVEBk9X4dLs=
X-Received: by 2002:ac8:5a10:0:b0:4ab:78a8:195c with SMTP id
 d75a77b69052e-4ab93cb7272mr342892451cf.19.1753101061452; Mon, 21 Jul 2025
 05:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com> <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
In-Reply-To: <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 05:30:49 -0700
X-Gm-Features: Ac12FXy1RHX2yaNiJGR3GfeQSGanKLyPojueB3VBY-EeT_sR8FwYNfAZ2-Hp3lE
Message-ID: <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/21/25 10:04 AM, Eric Dumazet wrote:
> > On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>
> >> The nipa CI is reporting frequent failures in the mptcp_connect
> >> self-tests.
> >>
> >> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> >> actually plain TCP ones, as fallback for passive socket at 2whs
> >> time cause the MPTCP listener to actually create a TCP socket.
> >>
> >> The transfer is stuck due to the receiver buffer being zero.
> >> With the stronger check in place, tcp_clamp_window() can be invoked
> >> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive buffe=
r
> >> will be zeroed, too.
> >>
> >> Pass to tcp_clamp_window() even the current skb truesize, so that
> >> such helper could compute and use the actual limit enforced by
> >> the stack.
> >>
> >> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  net/ipv4/tcp_input.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >> index 672cbfbdcec1..c98de02a3c57 100644
> >> --- a/net/ipv4/tcp_input.c
> >> +++ b/net/ipv4/tcp_input.c
> >> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *s=
k)
> >>  }
> >>
> >>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
> >> -static void tcp_clamp_window(struct sock *sk)
> >> +static void tcp_clamp_window(struct sock *sk, int truesize)
> >
> >
> > I am unsure about this one. truesize can be 1MB here, do we want that
> > in general ?
>
> I'm unsure either. But I can't think of a different approach?!? If the
> incoming truesize is 1M the socket should allow for at least 1M rcvbuf
> size to accept it, right?

What I meant was :

This is the generic point, accepting skb->truesize as additional input
here would make us more vulnerable, or we could risk other
regressions.

The question is : why does MPTCP end up here in the first place.
Perhaps an older issue with an incorrectly sized sk_rcvbuf ?

Or maybe the test about the receive queue being empty (currently done
in tcp_data_queue()) should be moved to a more strategic place.

