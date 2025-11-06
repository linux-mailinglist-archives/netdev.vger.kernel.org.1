Return-Path: <netdev+bounces-236505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2FC3D571
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9901893A06
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D62F7AAA;
	Thu,  6 Nov 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKzIS/fF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213C2F7475
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460685; cv=none; b=bSTSEmSHv3hczgpGCAn754wAottV+iBjcTcY396yE+M52JyovzEfZceYT8YoV0umuE/Pzwn6oWECamE8tZDc5oPIMXuNHKlcoMOZ3wPJ7ZMz9hjamVUv1cUjTnPAbtb+IosryqMz1E8MOaGQ94lwnrXbUT5hg5jLaYEkUiTlBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460685; c=relaxed/simple;
	bh=Im9QWWxJXdZqz7HeLFWXZzmI9TfaqMlaB4gqcycUoss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyTIYKjDufB2FSMWlNdBU0YDY3AmOUTvQK+zDYKrdnnMoPOCn0g/C4/I2oW6x6/KFYoPrtR/FnD6mYqHARcN2jNw9P4hEaq+fvjCoZQSzF7XIMmDw0aYyFhbs6tJrXKth+F16Ry3fPOMUvJJeC4VFJnSfbq6wI/pI1kKdUh5EdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKzIS/fF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-294fd2ca6acso259225ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762460683; x=1763065483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3gyUgZQhfQPtS7SLCIDf6NbyslQ68pOuETZ2b4hfpg=;
        b=IKzIS/fFRLupOYMhAxubkYmOMf1iYd0JtSGu6N6tjdphDY2T+lfSFlleOabM79FN56
         Xc4BiYJcoO2yRft4fhIiiYjYyeO7ZY290lVgGmyJDaSg1qEtZjZaZnKrw0R6J+lFganu
         InG87B1W4nncZe4GN2aWhII1F7jvu5cokGXaNGDU+U6mVBmr72wWeaxgajY3uA+Qe5dg
         irGl0Pis5EDMCeH6qatxrr9VPL9MymKX+OfYaq13RJo8IRtXPJNwr9i4mmekwj6E/hYq
         LOZDBCz90b2Za4RhRuMFtE8A7mVpVKK9stsAJnIqwXImh1dNG81H1gHMpOGD2wR1LQwM
         QIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460683; x=1763065483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3gyUgZQhfQPtS7SLCIDf6NbyslQ68pOuETZ2b4hfpg=;
        b=nn+P7FqnYu1zshkDnj41A+3GrOCwdfwWtMWzu/jHg1eYMdavLbktoQ96ZT38XHiWn/
         z/EiRf4MlaLlnaf8G+51s1a1MWjCdLdlSzWQFOM2jxZhzR0GdYYjzl/Im90XacP6qBfD
         RSG1UPaKinwCJvn6Sipp+8GO5roSZINN9oUN0ornE1ne3D29lMhsxALwtBK4WDRntcA6
         okCrljK9BCeebq9OzG/47KwGEfysCrWBi8jfHgNKzJmEJAW0iZKKdchGb9dDtc3Bd0l7
         a4QVN5ipV9B+23PsnY0mAtJfjN2BVYxr6difLRgzYOrY7Ad5oWKfe+dmwmezqMapXHqX
         r99Q==
X-Gm-Message-State: AOJu0YxQPV8pKKnA92EcpkHh5EmCilUKGdJF8Td3tXIpdb2hEAmgE5MI
	91lbECjTFYPKefAz4Rc6gAizBTbNZQmzv/9tE2Zymi/rY9MYU+SCRg6J15puDdcSpiGWGSfHjWS
	d2koahkgJDFdSgcGFKwoqwQLFF2Ex1C8=
X-Gm-Gg: ASbGnctaRDmCYkfy+BAyPw5IzkWYk1HZ1wxfGc06sWFctVQm1Vwf/mOURHY6eAHb2vz
	vX8BAzcRCEbjwIFtUNl3P6onYxl+GWK3Qx2U7OnYDCCg2t4mKoLeiV3w1FmnDBx/FJIwOQBG0v/
	nrgjMPPocluOfDhf2nppzklglYYJ1o6AHhsZeHcZE/AOCmlhMAdYyW4uiZreEY0bUr8XvFmD1s+
	ozSIaQHmeReOADzdpifvsuLpOXDXSAh2IusPL+7PlmVZcaBAgVHoIZQMC9wu0j5i5MbFZh8C1U3
	tvQtz84ot5n2G8+QDz3Ww5vPA07q/w==
X-Google-Smtp-Source: AGHT+IGTWzJU0xlvlovHbYWoDH5XM24Ae1wEThKwWG8ycDKpQ4Pza4FucwMrn4xnT46tQsURsHTnLGHE4XvA3l/bTbM=
X-Received: by 2002:a17:902:da86:b0:267:912b:2b36 with SMTP id
 d9443c01a7336-297c00de2ecmr9261995ad.23.1762460682652; Thu, 06 Nov 2025
 12:24:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <32c7730d3b0f6e5323d289d5bdfd01fc22d551b5.1761748557.git.lucien.xin@gmail.com>
 <43ea4062-75a8-4152-bf19-2eca561036bd@redhat.com>
In-Reply-To: <43ea4062-75a8-4152-bf19-2eca561036bd@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 6 Nov 2025 15:24:30 -0500
X-Gm-Features: AWmQ_blGjOQ50fcZQT5EtzHNncMYn6qzWEjBf9UHnF498_0zXTgvgxEng025WXQ
Message-ID: <CADvbK_d8WoKJkU7ACK6nzbv7hzxxkAYZ5--DPzVQHsSZbEJnuw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 09/15] quic: add congestion control
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> > +/* Compute and update the pacing rate based on congestion window and s=
moothed RTT. */
> > +static void quic_cong_pace_update(struct quic_cong *cong, u32 bytes, u=
32 max_rate)
> > +{
> > +     u64 rate;
> > +
> > +     /* rate =3D N * congestion_window / smoothed_rtt */
> > +     rate =3D (u64)cong->window * USEC_PER_SEC * 2;
> > +     if (likely(cong->smoothed_rtt))
> > +             rate =3D div64_ul(rate, cong->smoothed_rtt);
> > +
> > +     WRITE_ONCE(cong->pacing_rate, min_t(u64, rate, max_rate));
> > +     pr_debug("%s: update pacing rate: %u, max rate: %u, srtt: %u\n",
> > +              __func__, cong->pacing_rate, max_rate, cong->smoothed_rt=
t);
>
> I think you should skip entirely the pacing_rate update when
> `smoothed_rtt =3D=3D 0`
>
will update it.

> [...]> +/* rfc9002#section-5: Estimating the Round-Trip Time */
> > +void quic_cong_rtt_update(struct quic_cong *cong, u32 time, u32 ack_de=
lay)
> > +{
> > +     u32 adjusted_rtt, rttvar_sample;
> > +
> > +     /* Ignore RTT sample if ACK delay is suspiciously large. */
> > +     if (ack_delay > cong->max_ack_delay * 2)
> > +             return;
> > +
> > +     /* rfc9002#section-5.1: latest_rtt =3D ack_time - send_time_of_la=
rgest_acked */
> > +     cong->latest_rtt =3D cong->time - time;
> > +
> > +     /* rfc9002#section-5.2: Estimating min_rtt */
> > +     if (!cong->min_rtt_valid) {
> > +             cong->min_rtt =3D cong->latest_rtt;
> > +             cong->min_rtt_valid =3D 1;
> > +     }
> > +     if (cong->min_rtt > cong->latest_rtt)
> > +             cong->min_rtt =3D cong->latest_rtt;
> > +
> > +     if (!cong->is_rtt_set) {
> > +             /* rfc9002#section-5.3:
> > +              *   smoothed_rtt =3D latest_rtt
> > +              *   rttvar =3D latest_rtt / 2
> > +              */
> > +             cong->smoothed_rtt =3D cong->latest_rtt;
> > +             cong->rttvar =3D cong->smoothed_rtt / 2;
> > +             quic_cong_pto_update(cong);
> > +             cong->is_rtt_set =3D 1;
> > +             return;
> > +     }
> > +
> > +     /* rfc9002#section-5.3:
> > +      *   adjusted_rtt =3D latest_rtt
> > +      *   if (latest_rtt >=3D min_rtt + ack_delay):
> > +      *     adjusted_rtt =3D latest_rtt - ack_delay
> > +      *   smoothed_rtt =3D 7/8 * smoothed_rtt + 1/8 * adjusted_rtt
> > +      *   rttvar_sample =3D abs(smoothed_rtt - adjusted_rtt)
> > +      *   rttvar =3D 3/4 * rttvar + 1/4 * rttvar_sample
> > +      */
> > +     adjusted_rtt =3D cong->latest_rtt;
> > +     if (cong->latest_rtt >=3D cong->min_rtt + ack_delay)
> > +             adjusted_rtt =3D cong->latest_rtt - ack_delay;
> > +
> > +     cong->smoothed_rtt =3D (cong->smoothed_rtt * 7 + adjusted_rtt) / =
8;
>
> Out of sheer curiosity, is the compiler smart enough to use a 'srl 3'
> for the above?
>
Yes.

266 cong->smoothed_rtt =3D (cong->smoothed_rtt * 7 + adjusted_rtt) / 8;

0x593d <+77>:  mov    (%rbx),%ecx         ; ecx =3D cong->smoothed_rtt
0x593f <+79>:  lea    (%rax,%rcx,8),%edx   ; edx =3D adjusted_rtt + (ecx * =
8)
0x5942 <+82>:  sub    %ecx,%edx           ; edx =3D adjusted_rtt +
(8*ecx) - ecx =3D ecx*7 + adjusted_rtt
0x5946 <+86>:  shr    $0x3,%edx           ; edx >>=3D 3 =E2=86=92 divide by=
 8
0x594d <+93>:  mov    %edx,(%rbx)         ; store result back to
cong->smoothed_rtt

Thanks.

