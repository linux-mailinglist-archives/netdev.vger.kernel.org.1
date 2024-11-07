Return-Path: <netdev+bounces-142653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BC9BFD9F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0EB282969
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBFE191496;
	Thu,  7 Nov 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrRjHnVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19819048F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730957069; cv=none; b=bz4Suu/TeHBl0nVuAmQYqiRzZWmcOBBB3KOpVbIZ+CZppLlZTlc5lXEOZj+adwyQPWSSMpLGno2wwXsMnPOaxtH+wHYJ202Cbr1Wl04yH/+wXlrSabKAlYmibLt3CsphWKvx0r8WQotboRD7tn7GJHQyxD7dOEnVa+MWDH9ChBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730957069; c=relaxed/simple;
	bh=hnF0gpQBktFDxibUW/Bu01vA4jF6qIYwe+HRTKmtBB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0QaK1aM15VvMuSEAaotZQBU87drn9clDO3XC1dcH69dwU2jBKXIz4fkTyRYJV0F20FpysBIVvjGHpDDdfL4hwfd4lik7gsOONQZ/ujPFa5aQgnbEonG+6UyQd9flLy5dpglc+h8iXOka4nkpJ76+IdE23ct3QbEEJxrrlGsUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrRjHnVc; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83b83f83b63so48985939f.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 21:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730957067; x=1731561867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kztwd65d003+L1p6TAzSediszVOzzvG/mcVQjCsX7PI=;
        b=OrRjHnVcz0x04GFRzutqdwqsTc2Ee1Ci6xo4r0oJS5R4CBmxX7ltW9xPn+1Y7+Pg70
         uP8WjzyY5n3SZ4FZQ34kC3g4je9kedR6ltjsRH07rTKPBJTkoNxmr4erAraM/wsu526K
         yd6YxF9YJ7xos2F1fZtiHDD3m4mO1hNfB5BD09UoxllG64POhunJ7E7lb2YI20mjIL4c
         hx4YTFiFBhkDY5L3a8oc/t9K+JwoqozJlNOmDSf6qb13N6QMrQxcUQbyy9Lv26W9eSea
         FMrhzTjYqdVQu6gMavk4nBRdLmRKbwh4g7nU6Hgh6e8VkA5z6LWw8/rvcEABKDKWF2CG
         5kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730957067; x=1731561867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kztwd65d003+L1p6TAzSediszVOzzvG/mcVQjCsX7PI=;
        b=sAm8TC5NudfaMwkwxMtEZ1tsqmzcxYxt5WbrY9H7s9iAG9AXnj8GQ8Xg4nhjFL8VPp
         7fa6ejmXxUARTImYP+uBHZRnsbfC3OEdABd/+ClJelljN+UT5VvcWBQ5b/scRHlQ1GRm
         B6/2ccSiWiL43CGDL/oZwKx9XlvMmeHZvwRo7q1XQagyAPE1fs2HFmskPvxowbdauHKz
         Q0MEwVcZZVjuYdTw9FjENd7oWS72DL96s7Jlb5VLe+LVlMdQCMWIF9Msxg7nozS6ulVD
         d12lZ44hmjytA6muKBvOB/JrVLURYY0umv5u6thF86fcef3PvOd40utk4TMirSlRPXDJ
         rHdw==
X-Forwarded-Encrypted: i=1; AJvYcCXmfhffIMcByMCyNn2/U2Ep0280HIwKJiex6eawxC2ZXPpfpsufRR+qM+Q2XqPtkvMFRCCWXhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRXSt0ISzUQ0UidgpBLXczguuaE7LcfQnUlyMQd+hLUbV5zpS
	k7GDjpKyeAeUEZdZ/F6BmitV2aTm+y234LuEAYxm1AvIxGDDTT/oI+emoGLxzgix3nD07W1luVS
	TdB6Ycfo94QLIoJ9ZEleGi2Xu6sw=
X-Google-Smtp-Source: AGHT+IEH/dBkoyQMQt5fLxxOIScVDlPNij+Ow9AUr8d6hB9OWHb7HmVeNRXVrEaC2JArlJgP7E+ENhbXAGm873j9ZEA=
X-Received: by 2002:a05:6e02:12c7:b0:3a6:c4da:6031 with SMTP id
 e9e14a558f8ab-3a6e8914035mr18396595ab.2.1730957066673; Wed, 06 Nov 2024
 21:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoB9a7eKzU9sz8AaY0sqeKn9fkK9ejDJkfh9EpdcG17k-w@mail.gmail.com>
 <20241107041506.81695-1-kuniyu@amazon.com>
In-Reply-To: <20241107041506.81695-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 13:23:50 +0800
Message-ID: <CAL+tcoDW=VELoJoU6GOLQQNScdC+8+1s0aK4_YkiLog9eOcuFA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 7 Nov 2024 11:16:04 +0800
> > > Here is how things happen in production:
> > > Time        Client(A)        Server(B)
> > > 0s          SYN-->
> > > ...
> > > 132s                         <-- FIN
> > > ...
> > > 169s        FIN-->
> > > 169s                         <-- ACK
> > > 169s        SYN-->
> > > 169s                         <-- ACK
> >
> > I noticed the above ACK doesn't adhere to RFC 6191. It says:
> > "If the previous incarnation of the connection used Timestamps, then:
> >      if ...
> >      ...
> >      * Otherwise, silently drop the incoming SYN segment, thus leaving
> >          the previous incarnation of the connection in the TIME-WAIT
> >          state.
> > "
> > But the timewait socket sends an ACK because of this code snippet:
> > tcp_timewait_state_process()
> >     -> // the checks of SYN packet failed.
> >     -> if (!th->rst) {
> >         -> return TCP_TW_ACK; // this line can be traced back to 2005
>
> This is a challenge ACK following RFC 5961.

Please note the idea of challenge ack was proposed in 2010. But this
code snippet has already existed before 2005. If it is a challenge
ack, then at least we need to count it (by using NET_INC_STATS(net,
LINUX_MIB_TCPCHALLENGEACK);).

>
> If SYN is returned here, the client may lose the chance to RST the
> previous connection in TIME_WAIT.
>
> https://www.rfc-editor.org/rfc/rfc9293.html#section-3.10.7.4-2.4.1
> ---8<---
>       -  TIME-WAIT STATE
>
>          o  If the SYN bit is set in these synchronized states, it may
>             be either a legitimate new connection attempt (e.g., in the
>             case of TIME-WAIT), an error where the connection should be
>             reset, or the result of an attack attempt, as described in
>             RFC 5961 [9].  For the TIME-WAIT state, new connections can
>             be accepted if the Timestamp Option is used and meets
>             expectations (per [40]).  For all other cases, RFC 5961
>             provides a mitigation with applicability to some situations,
>             though there are also alternatives that offer cryptographic
>             protection (see Section 7).  RFC 5961 recommends that in
>             these synchronized states, if the SYN bit is set,
>             irrespective of the sequence number, TCP endpoints MUST send
>             a "challenge ACK" to the remote peer:
>
>             <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
> ---8<---
>
> https://datatracker.ietf.org/doc/html/rfc5961#section-4
> ---8<---
>    1) If the SYN bit is set, irrespective of the sequence number, TCP
>       MUST send an ACK (also referred to as challenge ACK) to the remote
>       peer:
>
>       <SEQ=3DSND.NXT><ACK=3DRCV.NXT><CTL=3DACK>
>
>       After sending the acknowledgment, TCP MUST drop the unacceptable
>       segment and stop processing further.
> ---8<---

The RFC 5961 4.2 was implemented in tcp_validate_incoming():
        /* step 4: Check for a SYN
         * RFC 5961 4.2 : Send a challenge ack
         */
        if (th->syn) {
                if (sk->sk_state =3D=3D TCP_SYN_RECV && sk->sk_socket && th=
->ack &&
                    TCP_SKB_CB(skb)->seq + 1 =3D=3D TCP_SKB_CB(skb)->end_se=
q &&
                    TCP_SKB_CB(skb)->seq + 1 =3D=3D tp->rcv_nxt &&
                    TCP_SKB_CB(skb)->ack_seq =3D=3D tp->snd_nxt)
                        goto pass;
syn_challenge:
                if (syn_inerr)
                        TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
                NET_INC_STATS(sock_net(sk),
LINUX_MIB_TCPSYNCHALLENGE);
                tcp_send_challenge_ack(sk);
                SKB_DR_SET(reason, TCP_INVALID_SYN);
                goto discard;
        }

Also, this quotation you mentioned obviously doesn't match the kernel
implementation:
"If the SYN bit is set, irrespective of the sequence number, TCP MUST
send an ACK"
The tcp_timewait_state_process() does care about the seq number, or
else timewait socket would refuse every SYN packet.

Thanks,
Jason

