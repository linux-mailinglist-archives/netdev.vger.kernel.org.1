Return-Path: <netdev+bounces-142664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A039BFEAF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2E3B2219D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F884194AD7;
	Thu,  7 Nov 2024 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgejPHf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0C18FDC5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962334; cv=none; b=r5/V0BH3bT+cWb2L5ei/MMSqOHj34jFeRexZvp6+FxqqlSNhbdb5icNGa94JBXbUKAEcvXI7cbN0wOmOhZyERFMR+p+RH9CL82vTCa9wSYlT8gD7himQOSQhEhbfMk/Efw95MhjYXfEttw61dWDF8RJuVFOiKavqZydI8phyN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962334; c=relaxed/simple;
	bh=omq9kyaFCRoehR/tqJvQgKRMciv4D3p+TKqC4BlINKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/Tcg4hPkSrBYZIzhG5GTH0XeI3Yjvi19QeID8vAyp6RITh84+5SOlPK1e4GyaBo2cVgoMUoRrV3ffNsldNMbWKTCiZF3qLgiMmwvocgGTCYTNTZX+fInoqDJL4k9AFsj04JkKipdS7WbuTf9Wgg03J8psCV/YmWHhmRf5TeZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgejPHf9; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a6bd37f424so2503015ab.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 22:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730962331; x=1731567131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/VoP1e0MMRgpxSP+rDcdZe4Cb5nFlTHSszJKkEaXpM=;
        b=bgejPHf9JCySRFRLems9Jk9cUY4wUB4yCMZoZ4hmF76TKjd7Pps5oxo4EjszuQFhvq
         k+N1Xoq3wUdgFXHmjvgzuyX2sncAYNOoA0l+sSUTlZq6rGSzzoju1sK56CDDSlcNj0ay
         HXhJFYHfURjoxi1wewrfqeUtPU6JLoGWn0Or2TCCXFQyxQRkcF1abC1IfYwDyijdu4y6
         NbL1VWPwQ2SlinVz3WHg9UVRLHPhhlAI6tq6bAniVGJHkTZi5SZ9xMDxcvj4gySh78mp
         moL3WtVLuC1CnDPbbDFJ3jx8mKEGyXhcM0ryuBQ69RBxf0Ubu1/0VHs57nKykwimVhl3
         cKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730962331; x=1731567131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/VoP1e0MMRgpxSP+rDcdZe4Cb5nFlTHSszJKkEaXpM=;
        b=i8bOCtniT/VcW4n7ts0UUKRsosGpOKaGL8cozaWUIYBo3PjmSt+KMPt7tGSUiYdaCS
         CrOiTpYCSq2h+buc3ruOwp4QqkkYNguZ0Oezv4Cos5fxPiqFO0aiKv0oVjpCq0s3y45h
         aRGzmGvUx1K+lEBk0MNAJgH7ZQhfLb1g5gMPfNFmEWXOxuP6zV5nTdEOjUPWw3aAykvn
         q7C3ws20mu4Hk4e+x5lMMQHhmwBzpSFDXlazcwRUJww5JdI0WRcOW7UN3mM7vp4LrOnP
         TayrFxcgYTd0eD8blXOZFeoerMlz1bevDssn32hOZi6Kpw7cQZps6wU42Z0UwB2W7YaI
         5U8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcAvbpgXtry6MOL7epK7yBSXzqUHl5+hxoOgBsMEcs2WGbLNDmOacFqku/RURVzdE7uSEoBCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHGJcBebnS0MzBtJkOEF1cPpq7lndofzvCxkizkYTJJWurAlw
	ats2cMZrZcEV00Z868pzAmWnTisoLV1Y3q5YtwdJjgy/2Xp5fSrFU3TOc+DvqQboyAvd/TWUCqT
	VhvPSTti6GK13t86nT6SxKnxZfrU=
X-Google-Smtp-Source: AGHT+IFH82U4Gx+2/hqAAaXEs1wrbKcPr2RGsTLvYYO+0Rg1KneZL+cpMba4ffZOhUTJi9AX9bzHa07Sn0edOoPiMEE=
X-Received: by 2002:a05:6e02:1886:b0:3a6:bb77:a362 with SMTP id
 e9e14a558f8ab-3a6ed0c2eedmr1979685ab.4.1730962331597; Wed, 06 Nov 2024
 22:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDW=VELoJoU6GOLQQNScdC+8+1s0aK4_YkiLog9eOcuFA@mail.gmail.com>
 <20241107054309.91543-1-kuniyu@amazon.com>
In-Reply-To: <20241107054309.91543-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 14:51:35 +0800
Message-ID: <CAL+tcoCzJWBN9-0F32a37Ljbx9XbA-in55K8sRjfSicZBGtqbA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:43=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 7 Nov 2024 13:23:50 +0800
> > On Thu, Nov 7, 2024 at 12:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Thu, 7 Nov 2024 11:16:04 +0800
> > > > > Here is how things happen in production:
> > > > > Time        Client(A)        Server(B)
> > > > > 0s          SYN-->
> > > > > ...
> > > > > 132s                         <-- FIN
> > > > > ...
> > > > > 169s        FIN-->
> > > > > 169s                         <-- ACK
> > > > > 169s        SYN-->
> > > > > 169s                         <-- ACK
> > > >
> > > > I noticed the above ACK doesn't adhere to RFC 6191. It says:
> > > > "If the previous incarnation of the connection used Timestamps, the=
n:
> > > >      if ...
> > > >      ...
> > > >      * Otherwise, silently drop the incoming SYN segment, thus leav=
ing
> > > >          the previous incarnation of the connection in the TIME-WAI=
T
> > > >          state.
> > > > "
> > > > But the timewait socket sends an ACK because of this code snippet:
> > > > tcp_timewait_state_process()
> > > >     -> // the checks of SYN packet failed.
> > > >     -> if (!th->rst) {
> > > >         -> return TCP_TW_ACK; // this line can be traced back to 20=
05
> > >
> > > This is a challenge ACK following RFC 5961.
> >
> > Please note the idea of challenge ack was proposed in 2010. But this
> > code snippet has already existed before 2005. If it is a challenge
> > ack, then at least we need to count it (by using NET_INC_STATS(net,
> > LINUX_MIB_TCPCHALLENGEACK);).
>
> The word was not accurate, the behaviour is compliant with RFC 5961.
> RFC is often formalised based on real implementations.
>
> Incrementing the count makes sense to me.
>
> >
> > >
> > > If SYN is returned here, the client may lose the chance to RST the
> > > previous connection in TIME_WAIT.
> > >
> > > https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4-2.4.1
> > > ---8<---
> > >       -  TIME-WAIT STATE
> > >
> > >          o  If the SYN bit is set in these synchronized states, it ma=
y
> > >             be either a legitimate new connection attempt (e.g., in t=
he
> > >             case of TIME-WAIT), an error where the connection should =
be
> > >             reset, or the result of an attack attempt, as described i=
n
> > >             RFC 5961 [9].  For the TIME-WAIT state, new connections c=
an
> > >             be accepted if the Timestamp Option is used and meets
> > >             expectations (per [40]).  For all other cases, RFC 5961
> > >             provides a mitigation with applicability to some situatio=
ns,
> > >             though there are also alternatives that offer cryptograph=
ic
> > >             protection (see Section 7).  RFC 5961 recommends that in
> > >             these synchronized states, if the SYN bit is set,
> > >             irrespective of the sequence number, TCP endpoints MUST s=
end
> > >             a "challenge ACK" to the remote peer:
> > >
> > >             <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
> > > ---8<---
> > >
> > > https://datatracker.ietf.org/doc/html/rfc5961#section-4
> > > ---8<---
> > >    1) If the SYN bit is set, irrespective of the sequence number, TCP
> > >       MUST send an ACK (also referred to as challenge ACK) to the rem=
ote
> > >       peer:
> > >
> > >       <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
> > >
> > >       After sending the acknowledgment, TCP MUST drop the unacceptabl=
e
> > >       segment and stop processing further.
> > > ---8<---
> >
> > The RFC 5961 4.2 was implemented in tcp_validate_incoming():
> >         /* step 4: Check for a SYN
> >          * RFC 5961 4.2 : Send a challenge ack
> >          */
> >         if (th->syn) {
> >                 if (sk->sk_state =3D=3D TCP_SYN_RECV && sk->sk_socket &=
& th->ack &&
> >                     TCP_SKB_CB(skb)->seq + 1 =3D=3D TCP_SKB_CB(skb)->en=
d_seq &&
> >                     TCP_SKB_CB(skb)->seq + 1 =3D=3D tp->rcv_nxt &&
> >                     TCP_SKB_CB(skb)->ack_seq =3D=3D tp->snd_nxt)
> >                         goto pass;
> > syn_challenge:
> >                 if (syn_inerr)
> >                         TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
> >                 NET_INC_STATS(sock_net(sk),
> > LINUX_MIB_TCPSYNCHALLENGE);
> >                 tcp_send_challenge_ack(sk);
> >                 SKB_DR_SET(reason, TCP_INVALID_SYN);
> >                 goto discard;
> >         }
> >
> > Also, this quotation you mentioned obviously doesn't match the kernel
> > implementation:
> > "If the SYN bit is set, irrespective of the sequence number, TCP MUST
> > send an ACK"
> > The tcp_timewait_state_process() does care about the seq number, or
> > else timewait socket would refuse every SYN packet.
>
> That's why I pasted RFC 9293 first that clearly states that we
> should check seq number and then return ACK for all other cases.

I don't think so.

RFC 9293 only states that RFC 5691 provides an approach that mitigates
the risk by rejecting all the SYN packets if the socket stays in
synchronized state. It's "For all other cases" in RFC 9293.
Please loot at "irrespective of the sequence number" in RFC 5691 4.2
[1]. It means no matter what the seq is we MUST send back an ACK
instead of establishing a new connection.
Actually the tcp_timewait_state_process() checks the seq or timestamp
in the SYN packet.

[1]: https://datatracker.ietf.org/doc/html/rfc5961#section-4.2

Thanks,
Jason

