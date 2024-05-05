Return-Path: <netdev+bounces-93469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B48BC054
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605EC281834
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E780182AE;
	Sun,  5 May 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGnV3Asv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A192033E
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911247; cv=none; b=VLUH07XT1uMvY0oiWXgoIbtkgeMROtynusKEyNFUQVoICkD4lK0apxJwMqkqXlJrEs8oPmCBTuHOHP4mRHdydK37uxwqfFEXnvlvdz0u9boea6lRvovHsLtvhuzaK988hmALpHBZOrkaHAa3mEU5z1shelWb+aEjMgzp5KlGAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911247; c=relaxed/simple;
	bh=WxQQo1msbFJvJ7KTn5oWNe7ihO28HBPUVv3OailyNQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd2hdByxSd44AcJ/fvZ7uo/yksCxdwTCVoRa4YNG6AKwvMRVzmTS6CK9VGvVxxzzkIbtfPVSmlQxPMMNkLyCBbPdsn0GvADBJ/GvUYv0xmjHwkZ1jvmuG97s1giWGGyLE+mM7OH7KZAxRfo4jw6XwJW0LPuB6fEEl24HaedHEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGnV3Asv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599af16934so228532866b.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714911240; x=1715516040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIq2aKoB/QFJgNRUAiXNZ4dj37szD872mrmhb6FK284=;
        b=EGnV3Asvxtf9fNumb/tzhcII63qlg2b78jELK59elTi+urEh8yL2B+c02sdO58VrtY
         9IpoQPQmGVZM0dSefuTo1mtsuyfGusgnKGYvt5eOHuU4c7ruPqfaFcKUYg04GAMqbsBN
         qZyp42z/wD7XP+zwovSvJIMjnRJO9PJ0bgnTJScafTV5XO4Ejr3IBgmBKzLKKGQRUF+x
         E0tiBINu45Ziw+GGKfeIMDBDnGShi5MNgw5IJ2wy6Dx8EQZVhH6E4V9PCCb2d4yJ1fAc
         x0ee1rnkmLYFxxnXgGDtsYoUgVqWkJps8qKqE+MxeARR9XELqWWtAi+YX7jVGERU+SrN
         VZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714911240; x=1715516040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIq2aKoB/QFJgNRUAiXNZ4dj37szD872mrmhb6FK284=;
        b=BkreC9eYTIvVAYZ4bb5wNUs1+lJyEUp18S7knQ3zK29uzw8/2MJocn6OIRRR7ILhSM
         l5dPc/tAiXf4KhGRrfV+K/jRGOG9SPCLtywTGeYsDtnJO2A2PH4gV4yTV7G86DMqzfER
         C6f5ywIrPy24LbwKVx0hq3wrHECIVpnB3BKY7W9tWV3sJWV36W3NeHT3juKJp+iIwL9y
         YEfTlgsLaXu5rf7FbfuDPAMQVm4xuXymz8Vcf+HgWzZseRFPKezXRTRx0SoTG1YFWNXj
         fQ9ENvLKSswCl0mLD4vr4h0cafrcVfavTkKMZkDqL8QAzmt2oumULvvr1PqrBO15ivZ6
         l3dg==
X-Gm-Message-State: AOJu0YzhWUo9Lwhu8JWKekPjd95ZU3OgtEpRca/+O+zi0mU3nJxfpKRm
	cK6XXLj9GWqaYtNRhISl+N8W5BukAr7KTOJ/w0CxRLEtRlYL0JWzw2amE+WYB2rg4BaFe0ci8cl
	8ii4a04OvNws8vhPaKTfrX2A8kcA=
X-Google-Smtp-Source: AGHT+IEiI/41aIMuLWPWdpyxFaB+cXNqALu6zyzHYrdj2ZSCmBdrvoube3y0jU3N7pMvh/n+nJek2XCuvS7DxwkQ2zg=
X-Received: by 2002:a50:ab4f:0:b0:56f:e585:2388 with SMTP id
 t15-20020a50ab4f000000b0056fe5852388mr4799674edc.36.1714911240210; Sun, 05
 May 2024 05:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502130049.46be401e@kernel.org>
In-Reply-To: <20240502130049.46be401e@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 5 May 2024 21:13:48 +0900
Message-ID: <CAMArcTWUusDHes9AWeJLeFMZMUVe+A=8DOVZ8WjwfAmA=dyesA@mail.gmail.com>
Subject: Re: [TEST] amt.sh crashes smcrouted
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for the report!

> Hi Taehee Yoo!
>
> We started running amt tests in the netdev CI, and it looks like it
> hangs - or at least it doesn't produce any output for long enough
> for the test runner to think it hung.
>
> While looking at the logs, however, I see:
>
> [    3.361660] smcrouted[294]: segfault at 7fff480c95f3 ip 00000000004034=
e4 sp 00007fff480b9410 error 6 in smcrouted[402000+a000] likely on CPU 3 (c=
ore 3, socket 0)
> [    3.361812] Code: 74 24 38 89 ef e8 4c 33 00 00 44 0f b7 f8 66 39 84 2=
4 e2 01 00 00 75 09 45 85 ed 0f 85 ed 01 00 00 48 8b 44 24 38 0f b6 40 33 <=
42> 88 84 3c e4 01 00 00 48 8b 3b 48 8d 54 24 38 48 8d 74 24 50 e8
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/577882/4-amt-sh/
>
> So I think the cause may be a bug in smcroute.
>
> We use smcroute build from latest git
> # cd smcroute/
> # git log -1 --oneline
> cd25930 .github: use same CFLAGS for both configure runs
> # smcroute -v
> SMCRoute v2.5.6
>
> Could you check if you can repro this crash?

I tried to reproduce the latest version of the smcrouted crash,
but I couldn't reproduce it.
I'm sure this crash is the reason for the failure of your case.
But the real bug of this phenomenon is the amt.sh doesn't have timeout logi=
c.
If the smcrouted did crash or it couldn't finish in time something in it,
it should print FAIL and then quit this test, but it waits forever.

I will send a patch for it.

Thank you so much for taking care of it.
Taehee Yoo

