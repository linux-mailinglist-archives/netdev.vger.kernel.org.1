Return-Path: <netdev+bounces-71346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0708530A4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C271F22206
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4793D387;
	Tue, 13 Feb 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghz4twCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72932EB12
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827948; cv=none; b=CONCCdGSB/sdl2X1kwnZDZGhpkLSGn60nmRYkprBGVtnA2iPsqkE44G5dTNC/LJ3al03i6Zh74Afa8gzDruGKLD/z2U6EnsbhbYfOiBN3bDczW/nx3dzzvG80fmPnj8BFvMbyYIib6EHCsTZ2K4MpGvFHaZSoP3L+AWpJfmqWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827948; c=relaxed/simple;
	bh=/vkqYRQoxbV8yJdeIsX2M3p3XZ7CwtBOxVrO5YXVZLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti32k0gTl1eDIrD/VU21+MQZpcuy11edGtjTq2BbSum1m9oZaY5cjkeN1so/grT+Awg+iJRGpvAhRSW9gDRst7rUZzB76y9nVKGR40cmxtcZlOJoPYkZFrkXV3C1oXNfphNgJzM5i+fYhc0TZdNUHnCiiiFA3QiSQ0PAutY87g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghz4twCF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5620f15c3e5so211405a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707827945; x=1708432745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiCrkm9y2zfMdLUkLPp5/+DgIqVT0l09pbNHZKyufcs=;
        b=Ghz4twCFT9UM3b1OYYSElgqBkDOCqF0LFbMDaQ/cvnbQCpJJrSc1P9uLHJBlNfcIAy
         4mFGBMktmgczx8eYu+NUkTf+415gwNW/0bs7EhDPer04m+scB4CwTkpNNqUO8dGDnV2X
         CXsS5spuHX5lbVUcjY9h2j9gQ1n41vElvn5wEnxHELTMdC97etV2QKn8RnzqHauU1rcv
         rlC6sFiktXL7NSFBpok1TsrsAhPOeaklDCZgONbBOwx4YcNM4+S/MpkiubBfavCn+l1X
         K/FZekZkZZoEy3RlaXieANrOogtw8lj7OyhEGXcgsAXrNYxJIsfaxb5X4NCwwnIeFeNL
         hOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827945; x=1708432745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiCrkm9y2zfMdLUkLPp5/+DgIqVT0l09pbNHZKyufcs=;
        b=N+H55B5W1eiSXohyTw9yV+flXyWvW25aaLMMDZjLO5W2xGkkqP59CQDWU5+KpqPsoO
         c4oESfX8uieg1I0yFZ0dBghBAUbR0136OTxczhxEcmtx7UTrT4eCr2z0VD3gWI1hiN7x
         VZxpGxIzQOgCHtRdUQTURKBC7GqRf5IMhpXvXopxm+Vn3Y5yNcdgtjiJWFkqyWrILovm
         mjnfPkYhqtWppN9gmAsNgSmCVMvKchHW3cN4ITccPdW+lGMOnAbjHZPbLQG6a+fYrqqT
         PC9V/v8HtzDrzHotNv9nyVzI1H2+bjNgCqw1mpQS9k1SIZPiYzn4lZc1bEExkqNbki45
         5UFA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Iy9f9m67fEhXNzMl7iE4fz47pxmnqgV2x6AtJmE3sPnt8HBMm7QbbgBoYNsuRaYrTQG3aSVfj7EYZsgD9758u99ITGdk
X-Gm-Message-State: AOJu0Yy+VL3gCx5hxeIlzmJ7D/1TqzJgntGTk5V1wmn4IO8ErTq3IY5a
	DaO9ROnhO0jeZs2CAGmyhXtuKXaRKP3lCiBJ9zX9F31140T68Tlwp/POTnVU+zYXEYA7MjNLKe3
	QZo61HsNulNRsw8Jzh/0933+E9eM=
X-Google-Smtp-Source: AGHT+IGdMLBrEsHKogqLngq+zDaYWVjuJQEVwG1HFLC0rdI6gG9cwCPqMvD7+Yqj2dmSSxClmq7mfY/bYhcROZzOzmA=
X-Received: by 2002:a05:6402:6d2:b0:561:ca31:a52a with SMTP id
 n18-20020a05640206d200b00561ca31a52amr2971638edy.36.1707827944628; Tue, 13
 Feb 2024 04:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
 <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com>
 <CAL+tcoB1BDAaL3nPNjPAKXM42LK509w30X_djGz18R7EDfzMoQ@mail.gmail.com> <CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com>
In-Reply-To: <CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 20:38:27 +0800
Message-ID: <CAL+tcoBdvbA7OFYgdjN=LdLiQ=CyBxCkRy-0S_cPRPhxRHgenA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Feb 13, 2024 at 11:30=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > >
> > > > Hi Eric, Kuniyuki
> > > >
> > > > Sorry, I should have checked tcp_conn_request() carefully last nigh=
t.
> > > > Today, I checked tcp_conn_request() over and over again.
> > > >
> > > > I didn't find there is any chance to return a negative/positive val=
ue,
> > > > only 0. It means @acceptable is always true and it should never ret=
urn
> > > > TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger =
a
> > > > reset in this way.
> > > >
> > >
> > > Then send a cleanup, thanks.
> > >
> > > A standalone patch is going to be simpler than reviewing a whole seri=
es.
> >
> > I fear that I could misunderstand what you mean. I'm not that familiar
> > with how it works. Please enlighten me, thanks.
> >
> > Are you saying I don't need to send a new version of the current patch
> > series, only send a patch after this series is applied?
> >
>
> No. I suggested the clean up being sent before the series.
>
> If acceptable is always true in TCP, why keep dead code ?
>
> This would avoid many questions.
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2d20edf652e6cb5eb56bda0107c99bed0b0a335f..b1c4462a0798c45e9b10d6271=
5bc88fa35349078
> 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6623,7 +6623,6 @@ int tcp_rcv_state_process(struct sock *sk,
> struct sk_buff *skb)
>         const struct tcphdr *th =3D tcp_hdr(skb);
>         struct request_sock *req;
>         int queued =3D 0;
> -       bool acceptable;
>         SKB_DR(reason);
>
>         switch (sk->sk_state) {
> @@ -6649,12 +6648,10 @@ int tcp_rcv_state_process(struct sock *sk,
> struct sk_buff *skb)
>                          */
>                         rcu_read_lock();
>                         local_bh_disable();
> -                       acceptable =3D
> icsk->icsk_af_ops->conn_request(sk, skb) >=3D 0;
> +                       icsk->icsk_af_ops->conn_request(sk, skb);
>                         local_bh_enable();
>                         rcu_read_unlock();
>
> -                       if (!acceptable)
> -                               return 1;
>                         consume_skb(skb);
>                         return 0;
>                 }

Thanks for your explanation. Since the DCCP seems dead, there is no
need to keep it for TCP as you said. I will send this patch first,
then two updated patch series following.

Thanks,
Jason

