Return-Path: <netdev+bounces-83675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753D8934A5
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DC7B24229
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64516078C;
	Sun, 31 Mar 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbJ15pgk"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35115FA82
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903435; cv=fail; b=Fpv8GgV8oRG0e6maOLhX9djkfJotoRJQv4a1YX/IRuKxQ50mf3XE3wIw8Y0bxi114gXobWJhcwQdgEkVwaeasrSSzskQFwL5vsESr0PxEgtt6ebOhI3D6XgWv7bLLkrbxCi1ADX8ICm7Ng72xOqFZCYlDiNH6cYSq4XorHerTNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903435; c=relaxed/simple;
	bh=PNJEQ9/JZ2niMdP5puZiuqNStgHeawkkY1tyfTgMrxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=einnClsBGhPbovHU8IOzleVS/IQU+x0EUQIhx5oRnTZs1asE7oea5+vtb7dBkPQER84D1+dFZoqy1+8EJsUvoZE7MLrLQa90jtgGQI+g7oftj1t4NBfMy0fsb2V+TzQQ5MFCyWqfCC8rZg8WRPXacP8rC9QJWJHdxUPSPL5koto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbJ15pgk reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.54; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 90C9820896;
	Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gEC6N8A9vY4J; Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8187C208D2;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8187C208D2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 73B36800061;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:04 +0000
X-sender: <netdev+bounces-83512-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoABpKmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAZAAAA34oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 18983
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83512-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 309CD2058E
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814898; cv=none; b=TtNtvnRM4mLHxpsyuSf2oUJ4eUHilE+lOUFYTkGUrBLVItc17kCESpcfGtrxRgYLCIruzsDy2kCRV4l0exBhyX2nSmWPvwb6KAROqkBsT8lZi1KqUNBI1tAml0RTmdUP3MyX8zS6X0RMwjNxxE4FdPsrOpnVrjxN+0yzymEAs4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814898; c=relaxed/simple;
	bh=aZ+ahDgFULwD6gTd+XIhN5rHorld6C4W6kMFpEbq40E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Bid6CqnEu/kbI4uE+IoSDwyUpAzD6f1enGfEqH2f2Gczw99UJZjg2xkBjvMRLRX+eeKJ4CL6/bs00gzWZMnNROzrPYeBVpCHQkcBZrk7Y3/6IrOKn5I8TZJroZK3X8kC1xo6V3ivodwx5O4gCj591YGDTy2AeZ/O57CTJMVE0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbJ15pgk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711814895; x=1712419695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=lbJ15pgkjoFIosMOnM15oDV4ZjsVOR+mLG7MpqWIe/OxlPUzLHiUCKsp9rT7wvG1/v
         +FWT5/m8KnaR7+HlmP/96uL5L0YSEtfv4iNb5zaSGe31yGn2ybLrNPbKTllri+aecnrz
         5g0ch8eiMFa1/lZSV8IhhaAXQ5qtQM10Ark4YR/Uyg0uDcytyz0u+TNvu6yDei+2Fi8H
         tfz0DE/lSBnTJ59PqGsCwpFtSYcpirfgAukTfu/EH6DBDOXXHGq37KCLeq0QzHgLHnKd
         zBOpR0SHS4OUA+5bnxBqzOkJyRwV1+l6Vh4lOWMUr00oQGYQg+j9azLILp8x0wrOMLU5
         MnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814895; x=1712419695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=u/CA6LmMHt4V6bE8x8M7s37MmylQALCtHq4+mceDQZAqNd4/fAxZPgDOZl6GVJR59W
         gsiGrrlsE73I4X7lUvt2DB8/WNP+8GmqitAd5O3Kv1sVowW6igHWTevgTIOL7hNfcHE7
         C9WkfXWXhlqxz0RDcQv6PpVuwihJtGNHexUNRcc2prg2EvRQgD/JvUU9CT9jT4USy3fy
         5LiLJGbdeyMnYn2x5wn/H72miFHTUI7ZjvU0ftP4du63VN8sIyL0ZcXBX6ehQEkTn1+r
         iOMpJwiwtWWTeL7+mPbfqUNXqqG7lVjo/jbWeqeZqEQYj3fUCQVFyN013hSM2C9MGF20
         CrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTtXU+6pEXQJqrUGJAmKipoLc4xvGdwzemL7yJ/6GhHzxpfU+6n9utKv0EVZFUkG7jmZs4rHIzmrUaxO1F/1uCg7WgeUqR
X-Gm-Message-State: AOJu0YxLq3mAZHis+WeS7/yyLMaRyTmizM9mxWipMwQ5aIcfR8N4nBSE
	c1l9c8aoYfwDbWd6s2y7sTXtt/bCVy3m/QycqxaUn4FHoiTgq3VchaGc3Fo+4NbUzjlStDJy17X
	08ncnUrtnyGt+5GX/AB+9H2+N10Q=
X-Google-Smtp-Source: AGHT+IGd2O8mKMifiEWtXwxmvNbMq1I5C6mjN0KPpO4vKSiTRx2qpOuLgKan1Goru7+nEAF1Dq82X61eIrdjqwvC7yU=
X-Received: by 2002:a17:907:86a0:b0:a4e:5abe:8164 with SMTP id
 qa32-20020a17090786a000b00a4e5abe8164mr115987ejc.59.1711814894828; Sat, 30
 Mar 2024 09:08:14 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com> <20240329154225.349288-7-edumazet@google.com>
 <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com> <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
In-Reply-To: <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 Mar 2024 00:07:37 +0800
Message-ID: <CAL+tcoBqrWX0AMFfGOJoTTT6-Mgc7HqmCU0-bzLH7rrxBGqEng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Mar 31, 2024 at 12:01=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 30, 2024 at 3:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Fri, Mar 29, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > input_queue_tail_incr_save() is incrementing the sd queue_tail
> > > and save it in the flow last_qtail.
> > >
> > > Two issues here :
> > >
> > > - no lock protects the write on last_qtail, we should use appropriate
> > >   annotations.
> > >
> > > - We can perform this write after releasing the per-cpu backlog lock,
> > >   to decrease this lock hold duration (move away the cache line miss)
> > >
> > > Also move input_queue_head_incr() and rps helpers to include/net/rps.=
h,
> > > while adding rps_ prefix to better reflect their role.
> > >
> > > v2: Fixed a build issue (Jakub and kernel build bots)
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/linux/netdevice.h | 15 ---------------
> > >  include/net/rps.h         | 23 +++++++++++++++++++++++
> > >  net/core/dev.c            | 20 ++++++++++++--------
> > >  3 files changed, 35 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afb=
baa52f8ad3e61a419e9 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3249,21 +3249,6 @@ struct softnet_data {
> > >         call_single_data_t      defer_csd;
> > >  };
> > >
> > > -static inline void input_queue_head_incr(struct softnet_data *sd)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       sd->input_queue_head++;
> > > -#endif
> > > -}
> > > -
> > > -static inline void input_queue_tail_incr_save(struct softnet_data *s=
d,
> > > -                                             unsigned int *qtail)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       *qtail =3D ++sd->input_queue_tail;
> > > -#endif
> > > -}
> > > -
> > >  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> > >
> > >  static inline int dev_recursion_level(void)
> > > diff --git a/include/net/rps.h b/include/net/rps.h
> > > index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe=
7ee415ad0b71ec643a8 100644
> > > --- a/include/net/rps.h
> > > +++ b/include/net/rps.h
> > > @@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const st=
ruct sock *sk)
> > >  #endif
> > >  }
> > >
> > > +static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       return ++sd->input_queue_tail;
> > > +#else
> > > +       return 0;
> > > +#endif
> > > +}
> > > +
> > > +static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       WRITE_ONCE(*dest, tail);
> > > +#endif
> > > +}
> >
> > I wonder if we should also call this new helper to WRITE_ONCE
> > last_qtail in the set_rps_cpu()?
> >
>
> Absolutely, I have another patch series to address remaining races
> (rflow->cpu, rflow->filter ...)
>
> I chose to make a small one, to ease reviews.

Great. Now I have no more questions :)

Thanks,
Jason

X-sender: <netdev+bounces-83512-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA8pGmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAA==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 12056
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 17:08:31 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sat, 30 Mar 2024 17:08:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 650D92087D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 17:08:31 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=-2.749 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=unavailable autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=gmail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xiz4JgMEUFHd for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 17:08:30 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83512-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 79CED20758
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 79CED20758
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 17:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D770AB21F24
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357B3A1D8;
	Sat, 30 Mar 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbJ15pgk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524F335D8
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814898; cv=none; b=TtNtvnRM4mLHxpsyuSf2oUJ4eUHilE+lOUFYTkGUrBLVItc17kCESpcfGtrxRgYLCIruzsDy2kCRV4l0exBhyX2nSmWPvwb6KAROqkBsT8lZi1KqUNBI1tAml0RTmdUP3MyX8zS6X0RMwjNxxE4FdPsrOpnVrjxN+0yzymEAs4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814898; c=relaxed/simple;
	bh=aZ+ahDgFULwD6gTd+XIhN5rHorld6C4W6kMFpEbq40E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Bid6CqnEu/kbI4uE+IoSDwyUpAzD6f1enGfEqH2f2Gczw99UJZjg2xkBjvMRLRX+eeKJ4CL6/bs00gzWZMnNROzrPYeBVpCHQkcBZrk7Y3/6IrOKn5I8TZJroZK3X8kC1xo6V3ivodwx5O4gCj591YGDTy2AeZ/O57CTJMVE0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbJ15pgk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e4e7057fbso46227466b.0
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711814895; x=1712419695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=lbJ15pgkjoFIosMOnM15oDV4ZjsVOR+mLG7MpqWIe/OxlPUzLHiUCKsp9rT7wvG1/v
         +FWT5/m8KnaR7+HlmP/96uL5L0YSEtfv4iNb5zaSGe31yGn2ybLrNPbKTllri+aecnrz
         5g0ch8eiMFa1/lZSV8IhhaAXQ5qtQM10Ark4YR/Uyg0uDcytyz0u+TNvu6yDei+2Fi8H
         tfz0DE/lSBnTJ59PqGsCwpFtSYcpirfgAukTfu/EH6DBDOXXHGq37KCLeq0QzHgLHnKd
         zBOpR0SHS4OUA+5bnxBqzOkJyRwV1+l6Vh4lOWMUr00oQGYQg+j9azLILp8x0wrOMLU5
         MnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814895; x=1712419695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqYtiFl3gMtiR/slz7/31AGueSg/Uoe5u6YbVitMFwQ=;
        b=u/CA6LmMHt4V6bE8x8M7s37MmylQALCtHq4+mceDQZAqNd4/fAxZPgDOZl6GVJR59W
         gsiGrrlsE73I4X7lUvt2DB8/WNP+8GmqitAd5O3Kv1sVowW6igHWTevgTIOL7hNfcHE7
         C9WkfXWXhlqxz0RDcQv6PpVuwihJtGNHexUNRcc2prg2EvRQgD/JvUU9CT9jT4USy3fy
         5LiLJGbdeyMnYn2x5wn/H72miFHTUI7ZjvU0ftP4du63VN8sIyL0ZcXBX6ehQEkTn1+r
         iOMpJwiwtWWTeL7+mPbfqUNXqqG7lVjo/jbWeqeZqEQYj3fUCQVFyN013hSM2C9MGF20
         CrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTtXU+6pEXQJqrUGJAmKipoLc4xvGdwzemL7yJ/6GhHzxpfU+6n9utKv0EVZFUkG7jmZs4rHIzmrUaxO1F/1uCg7WgeUqR
X-Gm-Message-State: AOJu0YxLq3mAZHis+WeS7/yyLMaRyTmizM9mxWipMwQ5aIcfR8N4nBSE
	c1l9c8aoYfwDbWd6s2y7sTXtt/bCVy3m/QycqxaUn4FHoiTgq3VchaGc3Fo+4NbUzjlStDJy17X
	08ncnUrtnyGt+5GX/AB+9H2+N10Q=
X-Google-Smtp-Source: AGHT+IGd2O8mKMifiEWtXwxmvNbMq1I5C6mjN0KPpO4vKSiTRx2qpOuLgKan1Goru7+nEAF1Dq82X61eIrdjqwvC7yU=
X-Received: by 2002:a17:907:86a0:b0:a4e:5abe:8164 with SMTP id
 qa32-20020a17090786a000b00a4e5abe8164mr115987ejc.59.1711814894828; Sat, 30
 Mar 2024 09:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com> <20240329154225.349288-7-edumazet@google.com>
 <CAL+tcoBa1g1Ps5V_P1TqVtGWD482AvSy=wgvvUMT3RCHH+x2=Q@mail.gmail.com> <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
In-Reply-To: <CANn89iJKQuSLUivtGQRNxA2Xd3t8n68GQ_BAz2dp28eU9wzVcg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 Mar 2024 00:07:37 +0800
Message-ID: <CAL+tcoBqrWX0AMFfGOJoTTT6-Mgc7HqmCU0-bzLH7rrxBGqEng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83512-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 16:08:31.4465
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 5dfc8bdd-92fb-49c1-dd23-08dc50d3a4e3
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.010|SMR=0.010(SMRPI=0.007(SMRPI-FrontendProxyAgent=0.007));2024-03-30T16:08:31.456Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 11653

On Sun, Mar 31, 2024 at 12:01=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 30, 2024 at 3:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Fri, Mar 29, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > input_queue_tail_incr_save() is incrementing the sd queue_tail
> > > and save it in the flow last_qtail.
> > >
> > > Two issues here :
> > >
> > > - no lock protects the write on last_qtail, we should use appropriate
> > >   annotations.
> > >
> > > - We can perform this write after releasing the per-cpu backlog lock,
> > >   to decrease this lock hold duration (move away the cache line miss)
> > >
> > > Also move input_queue_head_incr() and rps helpers to include/net/rps.=
h,
> > > while adding rps_ prefix to better reflect their role.
> > >
> > > v2: Fixed a build issue (Jakub and kernel build bots)
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/linux/netdevice.h | 15 ---------------
> > >  include/net/rps.h         | 23 +++++++++++++++++++++++
> > >  net/core/dev.c            | 20 ++++++++++++--------
> > >  3 files changed, 35 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afb=
baa52f8ad3e61a419e9 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3249,21 +3249,6 @@ struct softnet_data {
> > >         call_single_data_t      defer_csd;
> > >  };
> > >
> > > -static inline void input_queue_head_incr(struct softnet_data *sd)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       sd->input_queue_head++;
> > > -#endif
> > > -}
> > > -
> > > -static inline void input_queue_tail_incr_save(struct softnet_data *s=
d,
> > > -                                             unsigned int *qtail)
> > > -{
> > > -#ifdef CONFIG_RPS
> > > -       *qtail =3D ++sd->input_queue_tail;
> > > -#endif
> > > -}
> > > -
> > >  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> > >
> > >  static inline int dev_recursion_level(void)
> > > diff --git a/include/net/rps.h b/include/net/rps.h
> > > index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe=
7ee415ad0b71ec643a8 100644
> > > --- a/include/net/rps.h
> > > +++ b/include/net/rps.h
> > > @@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const st=
ruct sock *sk)
> > >  #endif
> > >  }
> > >
> > > +static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       return ++sd->input_queue_tail;
> > > +#else
> > > +       return 0;
> > > +#endif
> > > +}
> > > +
> > > +static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
> > > +{
> > > +#ifdef CONFIG_RPS
> > > +       WRITE_ONCE(*dest, tail);
> > > +#endif
> > > +}
> >
> > I wonder if we should also call this new helper to WRITE_ONCE
> > last_qtail in the set_rps_cpu()?
> >
>
> Absolutely, I have another patch series to address remaining races
> (rflow->cpu, rflow->filter ...)
>
> I chose to make a small one, to ease reviews.

Great. Now I have no more questions :)

Thanks,
Jason


