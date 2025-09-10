Return-Path: <netdev+bounces-221674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29847B51884
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA563B1614
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADC320A3C;
	Wed, 10 Sep 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZ9O1Wet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF430289358
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512724; cv=none; b=mcWGkJ1z+0uw3OdSoV+J5xTAotYmLnkCjn0CPVunUw7rQqWmgHsk6ErAQTfzAUvcUwvxU1rk6n+LNyd43weWbPMcOPSNeYGYxxToJOIDTcPj0BR9nq27WZOCo/1kz6AEF8r5jJxYyYbxxiZmvyJQqiDnWLFqPg2E0c5IM2REnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512724; c=relaxed/simple;
	bh=7pyaKb+vpz6MYYu9Wb3Mz6zu46mjkpzSexjm9dUiAbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLIXa5Eh1eeeTpxHHRedDGWlTS/62oDKujkpiebG6OZRHi09lTfaCLF4eQfPwWpRaI0BAef0Hp8Xo/Rq4eZWKNAcf9YHknuGOBG6IBeuvVyfvm6ZF1ecJMx8/jcCpvYR+J1P/WRM+p/AbdtewtPl85AUe53HvezwwVzDQZ5u/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZ9O1Wet; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b350971a2eso139501cf.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757512721; x=1758117521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pyaKb+vpz6MYYu9Wb3Mz6zu46mjkpzSexjm9dUiAbo=;
        b=xZ9O1WetADTIph4EJb6iMvpuCwc4WmZrYrdSsc82tWNsxqmyeoSfICqULL4LcxBNHU
         wDCbrgln1K5jQncR0UO650d8O0ki9I3cB9+POkbCW0SM0vy+EfQaoRKu1GbTDsO7iI3/
         g2/nLBYrvwR5gVJ5WLLQo25S+DlxHV5jpzvSyR/UYxw3oXg0Ri9Bts69YGFSnX5d2jvS
         zKvqjOJHnaIrRyNeOYIItDVVg5tHioH3rJisJBntHej975/rHQ+TngijREGs1w5wvA0n
         fWDaI4gCZStLgHt8jNkKk0CijWuEtFls0DinJvo0X1SGnnou5O0pOb+65caGAPfa2lHo
         f7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512721; x=1758117521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pyaKb+vpz6MYYu9Wb3Mz6zu46mjkpzSexjm9dUiAbo=;
        b=iZwjqlIjIUHRgBdGn7vH21BrAfWqpDm4c4V4gj/HyGDb6xodQn/Lv8Z/xK8dGeny8N
         rXeoKctrTlGsNqxdtaEt+DbdGwSG+P1f8OGmcGD5DuoR3GMsBfkQW3e/enNTpO8ftUqc
         fGvdl4bhzCzg6XxCnjj2CQMVm8iY4iZxT+iAxoWKGfD0HL0l+4/RYRbJN8M+dHR7Thki
         FYscdjTik1f+apl3M4++fIzyO++l3HaQOSOoLTkIW9Z22DybiJoprA8sTdT8TptpiO+u
         F6dD36D1GsVHvXt0oSktwQrvSGTaVq7t5VinPjJQL5r99x+/pVDKYamWywBRkg2xIJOg
         Xumg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQI5TBoO9M5tNyy9jcy92SykZAaBbr1E73lxKtjgZrFPUmZZAs/kbkjdhbUIX6cfJjncNYQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXFHQbdSWM67uCb+z0J1U6qaOZtVRWk2zqzlinOsF3YWxpBPf
	H4y/yBk38c1/+/NnuuWqowVWbsR7RANfjJDqQCB92KA80Aaap7RUjbYC3a61wCapnP3Wx+2PMdv
	aDjRsryBxtD0GYApmA0jMQ9RH9oKx5ymDA/lj0oPY
X-Gm-Gg: ASbGncuR8aNzu4LqUpP6zILr2gqPiyayrMX7Gm2wlWAgmbqgpQKe8rzVHedjst+P/1B
	eAv7jlxZXx8kOJ+zkuhxap4AUl95IJ0Ir/orVgza8F4fWtleTV1JTVg1911EViRUY9K844HbnwD
	Y0LmjS0xU/d+6PIxGH7RFPyvU7HTl1ovW2RM57iGEjv2SaKaSNpDjVoPCtZyqA7JGEqEaFjykBq
	GSde1zNna889OCvDa1s8yFZzrLkZWqTrcjHW3BA1x7LHxNLanvkTT5dFA==
X-Google-Smtp-Source: AGHT+IFVQ83MLxSAeQdO7dDnCHCBL84jtvyAAC2tYVK/CnqMCjU8ayOqVjHHbE3JLv+qSYLoTgVKF2doj+mz0CDkcOk=
X-Received: by 2002:a05:622a:4cb:b0:4b3:1d1:fddd with SMTP id
 d75a77b69052e-4b62525eee4mr5533231cf.18.1757512721181; Wed, 10 Sep 2025
 06:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR07MB91623D4146367CDEABC5E381F80EA@DU0PR07MB9162.eurprd07.prod.outlook.com>
 <CANn89iKy+jvfifGQX8EBomWmhzQnn7j7q39uqd23NX0vvk1nFQ@mail.gmail.com>
In-Reply-To: <CANn89iKy+jvfifGQX8EBomWmhzQnn7j7q39uqd23NX0vvk1nFQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 10 Sep 2025 09:58:24 -0400
X-Gm-Features: AS18NWBJuv3lhsWoa1Fjk8Z1vbrmV-UOwKjiWnlMeOHVGaysEBNT9lzulHqJkCU
Message-ID: <CADVnQykpRGLzri3nDu9dJmXNUBqz-Q0YsqY-B_r4Pj0VOg44ZA@mail.gmail.com>
Subject: Re: TCP connection/socket gets stuck - Customer requests are dropped
 with SocketTimeoutException
To: Eric Dumazet <edumazet@google.com>
Cc: Ramakant Badolia <Ramakant.Badolia@tomtom.com>, "kuniyu@google.com" <kuniyu@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ozan Sengul <Ozan.Sengul@tomtom.com>, 
	Raja Sekhar Pula Venkata <RAJASEKHAR.PULAVENKATA@tomtom.com>, 
	Jean-Christophe Duberga <Jean-Christophe.Duberga@tomtom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 10, 2025 at 1:49=E2=80=AFAM Ramakant Badolia
> <Ramakant.Badolia@tomtom.com> wrote:
> >
> > Hi Linux TCP Maintainers,
> >
> > I am writing to get insight on this bug report - https://bugzilla.kerne=
l.org/show_bug.cgi?id=3D219221
> > Unfortunately, we at TomTom have also been stuck with this issue for th=
e last two months and our customer requests are getting dropped intermitten=
tly several times a day.
> >
> > Currently we are using Linux version 5.14.0-570.37.1.el9_6.x86_64 which=
 is causing this issue.
> >
> > As reported in https://bugzilla.kernel.org/show_bug.cgi?id=3D219221, we=
 don't have possibility to rollback to previous working version.
> >
> > I want to check if you acknowledged this bug and what solution was prov=
ided? Which version should we switch to in order to have this fixed?
> >
>
> No idea. This might be a question for Redhat support ?
>
> I do not think you shared a pcap with us ?

Looks like the bug report at
https://bugzilla.kernel.org/show_bug.cgi?id=3D219221 posted a working
and non-working ("not working TCP connection PCAP file"
non-working_tcp_packets.pcap) pcap file, though there was only a text
update for the working case.

neal

