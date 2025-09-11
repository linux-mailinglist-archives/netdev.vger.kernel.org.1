Return-Path: <netdev+bounces-222158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D4B5352B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D748616E111
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1D322C81;
	Thu, 11 Sep 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFj6q/Et"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F723064A5;
	Thu, 11 Sep 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600623; cv=none; b=UmWCb+IypSKxtKOifQ1hPN63/SPmz/nFHLCVi4fOFhdvGzotet1rw4GhP/gA+edPoYkefb/4IzLcLzbmXTR4zzmG5xRfEctv65cPGtVG6d7GgyNrNlyIvKMB5umkNahxeOyLVb1CW+6BCvPzWfoS2FAg82PpYpD75ONZBdlNKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600623; c=relaxed/simple;
	bh=ajdvvYdACeLJLVakIpYlzVZsRsQHLnPdwJVCjL/Ee6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCaKgo97efUWWua6i1aNbROGSjMjOCX2MVwfqYm6iIEFAzLPYIRrX8lCjYDFkjBYTKMTv+Q5N0k6ThAmaoxSYtKbCFqTvngFrQf7gDnjW/8uRrl6fnlJEksQKQJ9CBaeBeZNHE57hdCxeSfnnRzvjHqNzQy71ydcslGqHO7Hx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFj6q/Et; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so878192a91.2;
        Thu, 11 Sep 2025 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757600621; x=1758205421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L+yCUCajZfLABRxvlmYlSqRsk/AWvRnW7kYTdlkXJU=;
        b=jFj6q/EtSCauDqteijh5smVZ9C+wJtMeVSE5KB+mXz6V5r+WJ7aqLKDAOzjlAM4bt9
         A2ENqYdpJeY6rnu+Ky7WewQmcxOIWEQB2U+REWmznjmnxoGQQxO4ETvCh2ig7RFVJlpF
         +/lKjyNQvdYNSVG1mUjgyWh4rO6dmFhBYcpisLOnuDwXyaSrcNbswKASbCt9QhAc9L4K
         RFRSUmogkp0+T4m2Ma1bXBhoAu/MmeEnAj7owa1hdgRMdPNTq9usNmBTDX+54GCC8yEH
         Apk2CH3oMguJDuEBYKxOrELwJmFGY8NBtLVnaEM7TRN6GItjalGjkr66qingws3h7vpU
         rHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600621; x=1758205421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L+yCUCajZfLABRxvlmYlSqRsk/AWvRnW7kYTdlkXJU=;
        b=ARXdwHbJBdaIXlD71sBf2m0kwRmg710xggMXPx2CG/tzTBEEWV+FZ0dH6W1DjDLYbF
         ZZp4t3qryjo4GxUhWZMnKYl+s6aQSoN3/vtTKFhnHEAGrQk6g61XJwDxVzrzqKhewV2K
         reqI4c7DBXcBlH7DR6iLTB39VqmnY9JjAzlf2yLHKBzNNPfhKq99MrNabuSvNXPMV+2q
         1fQJ0iukpVaP9RVcv+ZnUSEq8MyglWsufoKGGnAv7JdvcehfjNJeK6t9yUcafxX5bO3n
         LxxLYva5xOiMf/nwJBhbYGUAXAXX+03ayM3wnPxiijCNUI2rXeX3GFlRLkd5w7AT3isV
         Ifbw==
X-Forwarded-Encrypted: i=1; AJvYcCUDaUELWS2AO4qvWJRJhTri6j6BNoqDbf/2blZac+kOjgzeWUzsKqt5cekZTukY5aSKrehvVCBwKtmQLN4=@vger.kernel.org, AJvYcCWMVdE5L07QTI47xzlPo3wZrYIPW5Q2TjWqWr8tErG15HLilB1n3xFbdzaO5qQfU/zGgyEXiqd+@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWfqfnnbKBAqeul/VMKwRbOsANxNgdS4xLjWwR2AyLVDX+/X7
	gutuEju7qm2fo7l81Za+CuM6GyL3RDKRaR1Bx3B2l27cGPCZwqSuL5v7J2tT5mffVRF6VF/CQiK
	jDNfjDvRMICTCZe6i1tzz39W63coUfsjwbznhy20=
X-Gm-Gg: ASbGncuX5Y1/RDtaLLUMJWwfAGRkuLc2jJHS0+bFhlgw+XGSP0EhyNa/E7XLsz/vLk3
	HGIeDpfsx3DYsi1pHiLAECG3h/oo4UiUqjvcRPywWZ7y9rg+ExR0VnOm+9QUUJ8MNBpNgnFeQV/
	i6elmOBvKRxbA25gBMG8pdTPoZ8rzrMIo33mnNJ8OVgXhCEOjlIcDa++K0J0PLoDo3QphK11YZI
	EWD9Bx2LsLi5MsyEb/NF1OwqGG0kNbbu1IgaNL6UpvxNRFdXlowrMMkDdU3ht29KarsSucpJLup
	wSUccYfo/+4uEM5jZUatDZ6E
X-Google-Smtp-Source: AGHT+IEzyJI/vIFUZLf1BG+68RB3wLNmSkArh/JOGzLBtvFAXJWkCa4Z7oKd+oW/ySua2GG0NoJFj/vsPJGWjt0TPuE=
X-Received: by 2002:a17:90b:554d:b0:32d:dc3e:555c with SMTP id
 98e67ed59e1d1-32ddc3e97e9mr1683034a91.18.1757600620699; Thu, 11 Sep 2025
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034337.43331-2-anderson@allelesecurity.com> <CANn89iKUKof727RDZkbfA-Q3pbV0U-pTH19L-kSvhhhtkKYGTA@mail.gmail.com>
In-Reply-To: <CANn89iKUKof727RDZkbfA-Q3pbV0U-pTH19L-kSvhhhtkKYGTA@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 11 Sep 2025 15:23:28 +0100
X-Gm-Features: AS18NWBcD4WbGQJ4jACO0KO5hwG-6IMIYyouyx38G9hwkEwBGEOIknFKPD82EeE
Message-ID: <CAJwJo6astnZxqkpikp4OtatHLMTq8-j35nRWYcq3HjX4eH0VuA@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR.
To: Eric Dumazet <edumazet@google.com>, Anderson Nascimento <anderson@allelesecurity.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for copying on the thread,

On Thu, 11 Sept 2025 at 14:15, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Sep 10, 2025 at 8:49=E2=80=AFPM Anderson Nascimento
> <anderson@allelesecurity.com> wrote:
> >
> > A NULL pointer dereference can occur in tcp_ao_finish_connect() during =
a
> > connect() system call on a socket with a TCP-AO key added and TCP_REPAI=
R
> > enabled.
> >
> > The function is called with skb being NULL and attempts to dereference =
it
> > on tcp_hdr(skb)->seq without a prior skb validation.
> >
> > Fix this by checking if skb is NULL before dereferencing it. If skb is
> > not NULL, the ao->risn is set to tcp_hdr(skb)->seq. If skb is NULL,
> > ao->risn is set to 0 to keep compatibility with calls made from
> > tcp_rcv_synsent_state_process().
> >
> > int main(void){
> >         struct sockaddr_in sockaddr;
> >         struct tcp_ao_add tcp_ao;
> >         int sk;
> >         int one =3D 1;
> >
> >         memset(&sockaddr,'\0',sizeof(sockaddr));
> >         memset(&tcp_ao,'\0',sizeof(tcp_ao));
> >
> >         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> >
> >         sockaddr.sin_family =3D AF_INET;
> >
> >         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
> >         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
> >         tcp_ao.keylen =3D 16;
> >
> >         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
> >
> >         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
> >         sizeof(tcp_ao));
> >         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
> >
> >         sockaddr.sin_family =3D AF_INET;
> >         sockaddr.sin_port =3D htobe16(123);
> >
> >         inet_aton("127.0.0.1", &sockaddr.sin_addr);
> >
> >         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
> >
> > return 0;
> > }
> >
> > $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> > $ unshare -Urn
> > # ip addr add 127.0.0.1 dev lo
> > # ./tcp-ao-nullptr
> >
> > BUG: kernel NULL pointer dereference, address: 00000000000000b6
> >
>
> CC Dmitry Safonov <0x7f454c46@gmail.com>
>
> <cut many useless details>
>
> Really I do not think you need to include the crash in the changelog.
>
> Just mentioning a possible NULL deref should be enough, it seems
> obvious skb can be NULL here
> now you mention it.

> -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
> +       if (skb)
> +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       else
> +               WRITE_ONCE(ao->risn, 0);

I think we don't need 'else' here with 0-write. It may overwrite a
value previously set. The allocation of ao_info is kzalloc() so even
if it wasn't - we don't leak kernel memory contents here.

> Real question is : can a TCP-AO socket be fully checkpointed/restored
> with TCP_REPAIR ?

Yeah, I've missed that skb can be 0 for TCP-REPAIR on connect().
I have selftests to checkpoint/restore a socket, but they all
checkpoint/dump an existing tcp-ao established connection, rather than
set TCP-REPAIR before connect().

> If not, we should just reject the attempt much earlier, and add needed
> socket options to support it in the future if there is interest.

The restoration of TCP-AO state is done with TCP_AO_REPAIR
setsockopt(), the corresponding Initial Sequence Numbers (ISNs) should
be set by tcp_ao_repair::{snt_isn,recv_isn}.
So, I think at this moment it's fully possible to checkpoint/restore
AO sockets (albeit, I haven't yet spent time to add support in CRIU).
The only thing I've missed was connect() under repair-enabled.

Thanks,
             Dmitry

