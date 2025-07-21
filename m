Return-Path: <netdev+bounces-208597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3EFB0C44C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A24E3E7D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE02D5C70;
	Mon, 21 Jul 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gM8ULJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DA2D5C6F
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101724; cv=none; b=Q0Et7/qxUfIcZA4xFBuxHmueAk6yhllFbUK3+BUl1mdlRvAfMMQyd1RLCmlRPMDKxLPu3LPijdrb2wXFMoe63GpBmLVgz+o/O1wCzXISqagyuNLSFDhrAioKOdC4y9hmfKKfDMlRx8n2AoQm+wcDKNtH422nzZ9hpb3g01wN9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101724; c=relaxed/simple;
	bh=XTENnX/gkbgqpNnl0RyIF9UzLY188Jd7Mvy8uFK7iWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRTmq+8yEadvu4zYYT20DwnMMjPAh2QTU+uU7SE8eadQy1mdK8LlrDiExDaX2mo8bu6whSm4zlRjAuuAV9m8cEVxMXQB3K9F89/DQ1gzW2F5ytkWHjbFDVPmAGQRc8LmNG6u43icYEDH5q718LWaP8OQGvS6vsesrvccgrdC1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gM8ULJJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab380b8851so37348001cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753101721; x=1753706521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLPGNotQ7/PnRsIC5dpkSfUQLmEl+G0hUDnbjMVpb1A=;
        b=4gM8ULJJNMacSGLAom+OE2+MkS3V7Jzhq6KhcKdeqnbf/YcOFvC7Mmqrv2u/lzWiaZ
         17LFBSQ1Tcr6hgsdjgEOfcQEdztSHXRdM02Vl4Hf5tw1jWnGWnsbVviWNC+SECGnem2i
         OgWg5CAGis9Dne21ZklXdxIq2tiweRtuVgREbQUrlBL/uNpZCGcNk9Y9P62sXtp96LKb
         cfZjReQgKOYFuHhAeq12zGiUFqNpewudThaRWs7ryg0PoUdhtRW3Ts+zQeqDRQ+vCUN5
         NWMiztI5ZX1016WHWRJlVAoj2d8vidp9UXX/lf+hVTGmXGgw92tdSx8febosNNFXt416
         trDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753101721; x=1753706521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLPGNotQ7/PnRsIC5dpkSfUQLmEl+G0hUDnbjMVpb1A=;
        b=LiYnt6Qj6ZEwJ+G9s7zCNcTKg7T4AYT10aS610XDA3N9A+1H1cA8f+VDlFlDDHuYPH
         Tef5Iva828Rt8YeTpOHra3gZYSJ5RJDLKF4GGJWrWidJHPYdFusE/qK6rabafvN6HAk/
         uunfkG7idLIVJdkE2jpZvixqHBsDCFAQPacV7LXqmJlE9V4tXlY457QdX8d/+V53EmfJ
         YIBPHANODnJ/50JHJs+io19W23NRjhmZ7BKEOBNcf/XYfz/ORAYsC7tMdqmBkA+tvMXc
         kk3mIrfZkqwdhaIz2H6668stMWxzPA3IYFt1CBzWa1fYTfw3w5O8xtjPCrJRD3rdppV3
         j7vw==
X-Gm-Message-State: AOJu0Ywm63FlF27B5HFx/k/GU62LlZYHEPZWCFL68zlln30BAfwSDsqs
	n4ZJ+EHEhymyByEoIYVbVDc1qss3Zj83Tvgh9PJDX3KUGv5xcVEeH7BHbyxe6yybksBSgHYJ9pR
	hkt1OyVUDDK1jwFKxuW3g1VC9oTf1iVvTumlbJQ7q
X-Gm-Gg: ASbGncuh9ame/BGaUsAib/9Mih8tez0h8hkCNDNrZcAsPUb879BzfSzHUKGbrTL2FVw
	z6F0xPdLAgngBBrZ+zAboZtdtQK2edcYwU6a7tHBYnMyru0LDhMLZa5+Gwg+Wzh7Pn1xn1O0iGk
	7TqJ/7dS/MSdVLoqPGLFmaDNo9MLscG+CMSAOnGqJULzWmSErIzPTfNu9yiEkgzfMD/aB6b3mlL
	XBt3Lg=
X-Google-Smtp-Source: AGHT+IFSjC22yV9svo8mM4ncjz5b4xSsABWSaxdFSN5RhJTTf/Jd6G9PRPs2Ze5a8yLF7pW1Gs+dkMuXgiyk2pZrD+0=
X-Received: by 2002:a05:622a:4d90:b0:4a9:ae5a:e8a6 with SMTP id
 d75a77b69052e-4ab93db8394mr356765701cf.47.1753101720665; Mon, 21 Jul 2025
 05:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
 <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com> <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
In-Reply-To: <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 05:41:48 -0700
X-Gm-Features: Ac12FXwnCd9vylLY1Lcb5yhiuQI2y5Uzve8u7tIj8_OwEbVQKbJOPQH_7njK_Ug
Message-ID: <CANn89i+eLqKvv1mF6N8-5DrQZZfRJrfopps0w9HRMANn_w=1QA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 5:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jul 21, 2025 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 7/21/25 10:04 AM, Eric Dumazet wrote:
> > > On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > >>
> > >> The nipa CI is reporting frequent failures in the mptcp_connect
> > >> self-tests.
> > >>
> > >> In the failing scenarios (TCP -> MPTCP) the involved sockets are
> > >> actually plain TCP ones, as fallback for passive socket at 2whs
> > >> time cause the MPTCP listener to actually create a TCP socket.
> > >>
> > >> The transfer is stuck due to the receiver buffer being zero.
> > >> With the stronger check in place, tcp_clamp_window() can be invoked
> > >> while the TCP socket has sk_rmem_alloc =3D=3D 0, and the receive buf=
fer
> > >> will be zeroed, too.
> > >>
> > >> Pass to tcp_clamp_window() even the current skb truesize, so that
> > >> such helper could compute and use the actual limit enforced by
> > >> the stack.
> > >>
> > >> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> > >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >> ---
> > >>  net/ipv4/tcp_input.c | 12 ++++++------
> > >>  1 file changed, 6 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > >> index 672cbfbdcec1..c98de02a3c57 100644
> > >> --- a/net/ipv4/tcp_input.c
> > >> +++ b/net/ipv4/tcp_input.c
> > >> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock =
*sk)
> > >>  }
> > >>
> > >>  /* 4. Recalculate window clamp after socket hit its memory bounds. =
*/
> > >> -static void tcp_clamp_window(struct sock *sk)
> > >> +static void tcp_clamp_window(struct sock *sk, int truesize)
> > >
> > >
> > > I am unsure about this one. truesize can be 1MB here, do we want that
> > > in general ?
> >
> > I'm unsure either. But I can't think of a different approach?!? If the
> > incoming truesize is 1M the socket should allow for at least 1M rcvbuf
> > size to accept it, right?
>
> What I meant was :
>
> This is the generic point, accepting skb->truesize as additional input
> here would make us more vulnerable, or we could risk other
> regressions.
>
> The question is : why does MPTCP end up here in the first place.
> Perhaps an older issue with an incorrectly sized sk_rcvbuf ?
>
> Or maybe the test about the receive queue being empty (currently done
> in tcp_data_queue()) should be moved to a more strategic place.

If the MPTCP part can not be easily resolved, perhaps :

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 672cbfbdcec1de22a5b1494d365863303271d222..81b6d37708120632d16a5089244=
2ea04779cc3a4
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5549,6 +5549,10 @@ static int tcp_prune_queue(struct sock *sk,
const struct sk_buff *in_skb)
 {
        struct tcp_sock *tp =3D tcp_sk(sk);

+       /* Do nothing if our queues are empty. */
+       if (!atomic_read(&sk->sk_rmem_alloc))
+               return -1;
+
        NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);

        if (!tcp_can_ingest(sk, in_skb))

