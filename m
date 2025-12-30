Return-Path: <netdev+bounces-246321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCACE94E7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B94301460E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612B2D47E9;
	Tue, 30 Dec 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWGOaHbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A429A32D
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089337; cv=none; b=Ik7GO1nxZqKn3QlcaZhXtDzImHw1PvyJChVcG38XQLW8irHEXtm4Lp5mSGBZt5Ih+gERvOsvDqAvU7XR1A6yI1VHayvsrP5VdZgrao5FJUUaQ0sMlQvKenybv+qv76YZCE+uCpTZENCov2Tki0mW3zZps/0KtlvG1c1MsJ7CVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089337; c=relaxed/simple;
	bh=VQZj6EuQ2ZoY4vY74orxPnwNlaav6retxXbAo80HSoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK+GUd2Pb8ArUTwOSpzMdV7yVdFCxnnHjI0H1Ss9sBCDE6oZxgVvL6FeSwmCb1qXu9N6LgWDO8vtpUZxOruTqJ6P65fHhq12D/uBYmPmD0SSl2SkzoDjJa1vyfRQRQQNDiDGr5BTW1VQymu4sj2gms14nlg+lQYEckoXTScVBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWGOaHbB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso5269059a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767089335; x=1767694135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4F9bSCEJ0/0vAqvKbzwSPjoi5jovTSkn9ts7DNm0H0=;
        b=iWGOaHbBqrPnPks2GODCBbPxu7uxYdz13/t+2auqYI8qvTJe6/8b1qzd1x9weP3plg
         Q4wxjUGdCtfpIHVsINpJPoZGG/Fv/SVGOLIuJEYlYREuPPrc1cic+zb7EO/R6EjCtje1
         HtPFGSlQtBlyTr5h0ULsnXTqzUA1Gtn6FY/bi9Nns9oixD2arsEfsN2RVaf2zTn1q9E7
         oFv5fUrUTh4gG5xvVRIngGACi49qiSq4odrfmflbykaB+2dR6bcQmBYDgtqAqyUvnYxE
         A+R/4wLuNc9G5/on7f4a7u8zTjkAvWfkXqiuE9N1T01Ej5Tg0KefTOKYlDTYshSpowMk
         ZKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089335; x=1767694135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4F9bSCEJ0/0vAqvKbzwSPjoi5jovTSkn9ts7DNm0H0=;
        b=u/5hWYdTvKz3haz74Y0quolGHnlBq3s9XqBb6a1dzfTHdQPgYJnn71fkM1wmk5CA4j
         J22fpgoAMoH32Vbu6wIvhyKKr8XsZ3lfjlr4zUN32rwCqySqFi00wnLamKj4JyCg8l0g
         O3ClYkNl6FIMDHoi+wJhUlzEMtAhYew5YsABYq0hH6maXeUORTI201B4w6E0VXY7GKcP
         iIe1kZE4CW0uPfoNOKlQNDAr3v6hOijY8l7Ei+sIbIVUlIHP65O+I99LN/lTmPOSVcep
         eZt2Sgxp4L3FTlRW2JIoQf3CB3vrwrqUDHuMXu+XpT1IcGQe/gBo2TS16mZkYOVq2uLB
         Stgw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRP5thFNESmz0xKxSqNymM6AJ7iDYd+Kh49Bg5j29vOhhem+NKR3f3PzoR/RKICizSQb/xfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nsGG3iGyTaecsW6py9ULU9CZRAbsa3TKTPL22Kf95fOZHNS+
	CvohggRdfO1TNq0UjvP1iVzwU6SGa5NlE1ER4DR6jP3mN4cqLlAaJsR4du9goviKnkPo3zGDNMI
	eAzi/bruOiJqY7E5MBL9K0c6G/V9KgYk=
X-Gm-Gg: AY/fxX6yHYZhSFkt0SHEvI44sgLGZV5fqLiP5I7Uun11ZTMMcQqpTbi+1BFS/Jq0QNe
	WSTb05BlXAr9ZqJwfLCh6ixYpaapxwFfP1yo0lDlLiDU9/SOTmmuf9bi1ZJVcXTl6kLOR81aVq1
	7rJNGXH7UT3ePMMd8vumXUCBL0veBTG0GaFkd9LzAbAKIYpfXOtl3epv0/7M+e6D2rgJNb4n18R
	KRDT9hP7/kB0mIXJZe3EH2wVEppaCYJC/vCD+VtcLuZ2hw/zK/vOrkxYvUkpYtpqK+GeER7zeUc
	V3I4pQKp
X-Google-Smtp-Source: AGHT+IHZAaxt027sGHCGDX3pnrOwzKxIkX7D8fXW+aIEYtuBua5GkzZCr7nRm2DE4BZgvhp3LrKi8sNU3zALzogPMZQ=
X-Received: by 2002:a05:7022:6294:b0:11b:9b9f:427a with SMTP id
 a92af1059eb24-121722b4fdfmr32658769c88.21.1767089334852; Tue, 30 Dec 2025
 02:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229173346.8899-1-tinsaetadesse2015@gmail.com> <3d6fbc23-e9b8-443c-badb-b3380b62d21f@redhat.com>
In-Reply-To: <3d6fbc23-e9b8-443c-badb-b3380b62d21f@redhat.com>
From: TINSAE TADESSE GUTEMA <tinsaetadesse2015@gmail.com>
Date: Tue, 30 Dec 2025 13:08:36 +0300
X-Gm-Features: AQt7F2p3if1NR4ZDsHiLWZeYPxAFBSFcIkLSOPbnDa8Ac8ysbT0vFjTMH1hAAUM
Message-ID: <CAJ12PfMGqsLWQvaeW4WSNHXd838XYuJ+QHiYZS1FtgmYWH9NnA@mail.gmail.com>
Subject: Re: [PATCH] Fix PTP driver warnings by removing settime64 check
To: Paolo Abeni <pabeni@redhat.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 12/29/25 6:32 PM, Tinsae Tadesse wrote:
> > Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
> > ---
> >  drivers/ptp/ptp_clock.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index b0e167c0b3eb..5374b3e9ad15 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -323,8 +323,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clo=
ck_info *info,
> >       size_t size;
> >
> >       if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
> > -                      (!info->gettimex64 && !info->gettime64) ||
> > -                      !info->settime64))
> > +                      (!info->gettimex64 && !info->gettime64)))
> >               return ERR_PTR(-EINVAL);
> >
> >       /* Initialize a clock structure. */
>
> I guess this is an attempt to address the following issue:
>
> https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
>
> If so, it's already fixed by commit 81d90d93d22ca4f61833cba921dce9a0bd822=
18f
>
> /P
>

Hi Paolo,

Thanks for the update!

