Return-Path: <netdev+bounces-221617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF7B513A3
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E4E1889C85
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFC242D7B;
	Wed, 10 Sep 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvyC8Crl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF9522F
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499375; cv=none; b=gYufycl9lgyW61F4DAvaAeo7FgTkOhFJYdvS2yKhPCtzffNtWvBGy/szfyoBQ+nPAKVxl35jAhhy2Irb9LkItm8Vr8GXe0SBQCytG44KVsWqvR1zNA9uDUgiSPNcuPvBMV/ismsuJjflHlNj433KRIKOiUxu+UYwtHTrpdD83J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499375; c=relaxed/simple;
	bh=kb7vKOojxxGWsHeQkcm6xWQORB5xje5KWUsDsvD2T8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csps0eObkAhmpiJL99hDoBlqokzBDJ2hUEcIrmxmdEM34scTRdOGeoLf65K6Ip8Ae8jGSNUEVkyy9qBRWd+omPDmljXzTLq9wKFddJBvZ9u/bnowH2d+vSUvxvVUH3UJcIMzShM32bnCQZNEFJv+BKkUOjwuvwR/t0iDir8Yasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvyC8Crl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so4527121cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757499373; x=1758104173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb7vKOojxxGWsHeQkcm6xWQORB5xje5KWUsDsvD2T8s=;
        b=vvyC8CrlOMFoX01xgFgnVj4ck+fFkKETK9xr2tEI6oT0JriR9dB+eFZLQrAIAX/6Mv
         GRPxIhxCX55IbiNlsH8a8ZIErMoA6M1NUWEqdvPuvC+8zFC/Ypa2jMoclw3UfGRA/+Hm
         1Nv93yz6inSTC9Qvqy2M5xRH5svKULEMbxHyaeTIvALo7S5kUsNVOK5KqPr7o17XAe50
         zZONv5UIsq2kKqIHlpC3Jyw0Ktls4QfGpasnjTuViyWXGhDd9GNNde+u+p+FbAEcjdxw
         GonugmdqNx8ggT8BNnpd9ffRwCqJgm7Fa33+Zz4+v2pJGn1d4xn8Lorye+3L2P3pTbZl
         WaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499373; x=1758104173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb7vKOojxxGWsHeQkcm6xWQORB5xje5KWUsDsvD2T8s=;
        b=w12j0HxUhF9Jy/JXAV7HF5SHvGRy1GMQLUHlAHoAY/+I7i2wA9Y1dZySRqgpXGEB23
         dJ2SQsqH8vQWmgTPpxeVYupKG9MF7DJ3sJEII5KEP0Gs+conW3NMufXilZl+tAEe9Pmp
         kTcP7g6z6/Vzc7q55Gxj0g6XKT4jsuYWMGhhMFKydqZry0/zPLGQ4a8y7ZbAUIybCVW7
         J8yXbrw2cJ++vaHGUPvOehOmkIGBNLfomhxLLrEUeYDC81tGXfUZKEar/Z9rrmQ1hqn1
         VOcr7rZ4dRpitVzPCzzI1o396H0Zyehdjb2gdZXFDZtHwlMR77AN/i4rD3JkMGWdHK3n
         At4w==
X-Forwarded-Encrypted: i=1; AJvYcCWGIPRvke1pk1x1o/359jrXtmzodp1v6i20QyzltaPBLBfVWGypdfl/HlBiSbbvYWIdfzeOdbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznb1/jqso/bQ0IMYFehQUJRIh4LwZySDXLyINu+ZCJUcY1V6dT
	+fCCSnMB0LF/3UjnbdN3NBU9s2DGUwq/lGYybBLk4tTrUe+ApXakJJy5ZaXAjc0Yrxot8VC3sMp
	e3CeSQXHpIOCHfTMqwZtUmSQSFYrx5haGYDX0Eq/HSjooo9wuH1L0P0og
X-Gm-Gg: ASbGncvy+kIxOLk5mvZ5nB8kaF9lotMy4ou63ILw2ijOflAMuSXL8WJDFmcL5HYUQDT
	ZHlbRygSa/WF+WHQ5V5je7eTSbSPeHsjiOmtprMQ7BesV9CH+9ZlyKPTk3QIY9ZVu9cYqAwuix8
	8NnZfWQU18uEq1omoe8SlZvuM8m2BeKnJs9eZATx/scSK4FavBfN6yz3zzQlTzpSuDiSFJL2MOo
	sUhAtR+jtYhT5/B2b/k/aiQ5Q471puao+Q=
X-Google-Smtp-Source: AGHT+IH1OTBf4ex6AupVqKl3LEDyp5+AYZQHxuptjMpumk6G61pi0WnLzbpdjWtaEe59MxWslLAVcGyidtWsBAK057w=
X-Received: by 2002:a05:622a:593:b0:4b4:8ea6:b989 with SMTP id
 d75a77b69052e-4b5e7cd607dmr227030211cf.2.1757499372444; Wed, 10 Sep 2025
 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR07MB91623D4146367CDEABC5E381F80EA@DU0PR07MB9162.eurprd07.prod.outlook.com>
In-Reply-To: <DU0PR07MB91623D4146367CDEABC5E381F80EA@DU0PR07MB9162.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Sep 2025 03:16:01 -0700
X-Gm-Features: Ac12FXxJ4NOa44EGpH7C4--CH6ky-ulSu-6BaeXZ7OO145U9Zwkrpg65p73sLio
Message-ID: <CANn89iKy+jvfifGQX8EBomWmhzQnn7j7q39uqd23NX0vvk1nFQ@mail.gmail.com>
Subject: Re: TCP connection/socket gets stuck - Customer requests are dropped
 with SocketTimeoutException
To: Ramakant Badolia <Ramakant.Badolia@tomtom.com>
Cc: "ncardwell@google.com" <ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ozan Sengul <Ozan.Sengul@tomtom.com>, 
	Raja Sekhar Pula Venkata <RAJASEKHAR.PULAVENKATA@tomtom.com>, 
	Jean-Christophe Duberga <Jean-Christophe.Duberga@tomtom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:49=E2=80=AFAM Ramakant Badolia
<Ramakant.Badolia@tomtom.com> wrote:
>
> Hi Linux TCP Maintainers,
>
> I am writing to get insight on this bug report - https://bugzilla.kernel.=
org/show_bug.cgi?id=3D219221
> Unfortunately, we at TomTom have also been stuck with this issue for the =
last two months and our customer requests are getting dropped intermittentl=
y several times a day.
>
> Currently we are using Linux version 5.14.0-570.37.1.el9_6.x86_64 which i=
s causing this issue.
>
> As reported in https://bugzilla.kernel.org/show_bug.cgi?id=3D219221, we d=
on't have possibility to rollback to previous working version.
>
> I want to check if you acknowledged this bug and what solution was provid=
ed? Which version should we switch to in order to have this fixed?
>

No idea. This might be a question for Redhat support ?

I do not think you shared a pcap with us ?

Make sure to not force too small SO_RCVBUF values, because too small
values are not very well supported.

Even if we 'fixed' linux, performance would be extremely bad.

This is a random guess, based on the known 'issues' some folks have
with 'TCP stack'


> Best Regards,
> Ramakant Badolia / Engineer IV - Software / PU Traffic and Travel Informa=
tion (TTI) / Perseus Team / +49 (0) 1793792612 mobile / ramakant.badolia@to=
mtom.com / www.tomtom.com

