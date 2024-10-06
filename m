Return-Path: <netdev+bounces-132465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99750991C80
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D118F1F21F13
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157D1EB36;
	Sun,  6 Oct 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPdpYbdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60351231C85;
	Sun,  6 Oct 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728188593; cv=none; b=HUOZZMPzUUlLTBCY9YnHojrAFYs8ns9USA4vnX/6zLiYSIUDCtPuqtgg+cPiCx62/S6zE4Rvs2sF7v/jFNWrFmcNE2D9lDpR+rQ/xG4IT2rYwUpOyi8QoHYhgD2f47v0D3Lg2PZgLjVCIe+10aY9MArEghXwUfgzA1Oodi7Iyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728188593; c=relaxed/simple;
	bh=FTcS6jJUUGP2xfO1WQ4jrgdubKd1+esFyHCSTX7twJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaZQA6kG0ReWv4SY/4j5IHQzBbVU90DM430U86DnIjkMup/DkRKZjmHGcT6IHycGm0dmMto3ur2b1gEeLZcSm6SW/3G0k4gnb0VHxhd2OEGW0cJ+/pueak9uFRd1rgom3iOdvWmuYxL9AEVwcY4PqDxwHEab46EVP0+PvwmLVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPdpYbdm; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6e20a8141c7so29305657b3.0;
        Sat, 05 Oct 2024 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728188591; x=1728793391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRoaR+J22+s3bQTSbb5ozPji+bkw6rSBB6arrWs1Exg=;
        b=YPdpYbdmNZKFwDXMLn+uMQhtj7645MwM0oONrdceLFVuqZur1GcEwFZPaSTtcpnfkx
         FWz7P07NI23Mqqc7Uv+gkCI6A7uTlE7U/vhNhUxGJot6kiRbXChdLh9PJ14D8nuBncdF
         waPIbwm5vcClWmvGiajjMLJouWNWrv5lTQDGeM98T6BYYPlSmE9/ZDGGw8mYWJlhUQG2
         aEdguFPSbL2Nc5V7BU7IpKQDeDVTqfDMu41gZjIgtE8sve8XtVVPwaOp/2YvOD5N2vyX
         6mssWErNUr54L146nUmJ+xSApEtZKy6VqvS0HQrCFowMjEVp+cbkMJLjLDzDg99UBaAF
         IwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728188591; x=1728793391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRoaR+J22+s3bQTSbb5ozPji+bkw6rSBB6arrWs1Exg=;
        b=SHNR/gcQIW+mGeMtZikNQdz0wooaTuuuFdyLl5m+3fTZnfXk4VWJ7lhU0IwASepiPU
         oAxfCdHkzX5FtT51xLjM9hNzBG47J090AUwNI9unYo5uitSG6e2Mr1ZEGpyOr0lz5Kab
         YOqvFxRbJg/PVfnwblYkWll6Cj/kOkPCKEkRUEATbUPu6aqsDh5tYL8VqOauNcQSijj1
         qUB9Q6WNMOp0IyXLBxinNhIPBcLzaAwsUOMIrRpUxAkBs04y2f7ZykCmDbiuvqHTblQg
         VSYkLIRWueVQuo45FYzsl6BI3dsldyzNIuWvllYpk4z8r6I4uRFAATKISXIGTxtB1uhh
         +opg==
X-Forwarded-Encrypted: i=1; AJvYcCW7qVeb6DYKxn8IYPCE5GgyEdP31yRsSt6igiKKlArkLjxHEpz0zpxB1bOYtWI6KiIYgUO0jmBnRLDZtcI=@vger.kernel.org, AJvYcCWkdzKQ1MrApELM5d2biMQjZwsZxdNCPGfcy+NZ5LvsUeq/554k6DPGaKJadF9o75iBS/59DasN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwlprd2sfrCUoDLvncERXyO533+IWqiwQE93OdUfwCfyvj7Y9i
	1iXkw+p+SBOldZ17I6uONDrrTa4H2IOsMvyU0mfcpYeXuRMl0bS6WJC9GLUrTkGvCWDFyEF/Aik
	urJPxY4ndU79bGGzrM5+ctfUNKtY=
X-Google-Smtp-Source: AGHT+IHZkQoBoq65+yltbbNFl6fuvhp+vj8ZcTlMgCUOGwqvApGvDXr+0rhpw7VxlcjckIeqQ+XyydIXXE6K+94hP7E=
X-Received: by 2002:a05:6902:250a:b0:e25:e3d1:149c with SMTP id
 3f1490d57ef6-e289393ee5bmr5549749276.44.1728188591385; Sat, 05 Oct 2024
 21:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003082231.759759-1-dongml2@chinatelecom.cn> <CANn89iKfvO1Z8_ntCre-nG+6jrq-Lf0Hym_D=+w68beZps4Atg@mail.gmail.com>
In-Reply-To: <CANn89iKfvO1Z8_ntCre-nG+6jrq-Lf0Hym_D=+w68beZps4Atg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 6 Oct 2024 12:23:05 +0800
Message-ID: <CADxym3bHD4CiD4EQa6gU2z-RVWtWGH+xD=ZtkLkWDGu7RBwobw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: refresh tcp_mstamp for compressed ack
 in timer
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Oct 3, 2024 at 10:23=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, we refresh the tcp_mstamp for delayed acks and keepalives, but
> > not for the compressed ack in tcp_compressed_ack_kick().
> >
> > I have not found out the effact of the tcp_mstamp when sending ack, but
> > we can still refresh it for the compressed ack to keep consistent.
>
> This was a choice I made for the following reason :
>
> delayed ack timer can happen sometime 40ms later. Thus the
> tcp_mstamp_refresh(tp) was probably welcome.
>
> Compressed ack timer is scheduled for min( 5% of RTT, 1ms). It is
> usually in the 200 usec range.
>

Thanks for the explanation! I'm writing a tool, which tries to capture
the latency from __tcp_transmit_skb() to dev_hard_start_xmit() according
to the skb->tstamp, and the compressed ack case confuses my
application.

Maybe someone else can do similar things, and they can benefit from
this patch too.

Thanks!
Menglong Dong

> So sending the prior tsval (for flow using TCP TS) was ok (and right
> most of the time), and not changing PAWS or EDT logic.
>
> Although I do not object to your patch, there is no strong argument
> for it or against it.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  net/ipv4/tcp_timer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index 79064580c8c0..1f37a37f9c82 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -851,6 +851,7 @@ static enum hrtimer_restart tcp_compressed_ack_kick=
(struct hrtimer *timer)
> >                          * LINUX_MIB_TCPACKCOMPRESSED accurate.
> >                          */
> >                         tp->compressed_ack--;
> > +                       tcp_mstamp_refresh(tp);
> >                         tcp_send_ack(sk);
> >                 }
> >         } else {
> > --
> > 2.39.5
> >

