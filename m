Return-Path: <netdev+bounces-217307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98773B38482
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33A846301A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F83570D0;
	Wed, 27 Aug 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPg0FzY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959F2F3C0E
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303885; cv=none; b=WsaFs9d+6newc4s5x6MdVKtm9ZMITHyEQrhQ42DmdyZA/ILfHC5Y2co2BQTVoXmebgzGcCcG8mUUBnSF6YJXs021KH7qnagmpHyxkR3iHsEtV7cby3/FrSljiL6x4UCsrU5aFrA+YOHkLEb4OsGcDO6xdmcKQg3PBSuIPcj1Kro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303885; c=relaxed/simple;
	bh=8ulXXiScqWzB2D/6c7q0uERiSY6EZ/jTL93ZMrHwvIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAijkkb6r2NhNpRyEjxgJbgNzoLpi4qe4jLejpomwB2bSyCfgp01P/G9gLCmtmXcxZeprJpW3wl1XWF3PgoYB+PMdaYqw0uQJEvBCkfjfJoldvoeDmKWjADEKJquYW+XmNx7uXHQDBXYJL07dBYHthJ1z3jIZVR39fDHaeYj0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPg0FzY6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71e6f84b77eso54936437b3.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756303883; x=1756908683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7k70P5b82tqCDgSvQoptS8/1G48rkfPqCLS2A6Aenk=;
        b=nPg0FzY6F7U293AfaDhxt5LWohSsRTiXXqEW9emnJJsxTVIux52MuYaawKfGrTrx7N
         5ytuG99sMxgj0DZYcZ9MjKV0sX0uf15pIv2n1dVo44MAGlGupuJ17FCymNrKl/3bVFR4
         M7vno2+bgu258D4AGJPVbao6r+tL22E+xT8ikfxvwEVwY/OMlNOvi5EcLwn9/olDrnKC
         Xrn+8dFt0IY4zRlAByudfwFn/jF44Fr0TrUMU9mKTUIqdkHttZcXkB5SsVYL3SLtlGHU
         5nNKw8cxTX3U+p0HW+o6zhV7Mt7IMxvAiTIHXVwT1igt7USKNd2bMIuLD8YtNPs7AU+q
         VvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303883; x=1756908683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7k70P5b82tqCDgSvQoptS8/1G48rkfPqCLS2A6Aenk=;
        b=XJj8pLUrtgsdiYUuGvjCc2n1t54jIZ2V3gt7J3CiGM9ZiWJc/ZqaGKYwnxCgecyBs4
         GwAz54tMErKfb+WwAAJcA5o64LepWqnM7r8sq9BMJOU5bDqXNVp+WRKC62rMMWWyMCAe
         kUYS5TKRMEprntwx/rfrVnd+UOb5/zd+N9dqykg24wp3M3RPEBEkZQbJyKu+TqnOz4KN
         1NgAly17asfR0q/wp4jjyaHW7gQBJHwU8vWrNC/U1HqOxippb03e9YCWnchwVSMxxtA6
         5LarmEXJD3I5qZBL8wflXIw9e/TC+jINrVYNT2ELMH2J06d3x9+vVWI8qtEYhZpXlO7w
         U6BQ==
X-Gm-Message-State: AOJu0YyTPW44QZTzh4ZoRlQTU8gC9ywsiKVkBFqRF7iOYGsEoK39Qob1
	zDjkK3t3Q13uVNfOML/qQuKXDR3i0ANyv5qfrd7rz4c2bCBBw+2/zQKrZzHUGXDUcyHUqs5i+Db
	AieOcLTONOegyY0tvDH7F4iWsgsdCUj1dIpb/s7k=
X-Gm-Gg: ASbGnctWF6QExsB3zTWG3nIOiinoAoTaWen1x+87RVzJz2m9HOJ7rM58GhcaYxCudYq
	WDnWagrjKLwh+8rq61IETfOiG7UUnt5ilFEBvdvlOJJBWmUEFw+7wzn6ytst5ApFyebOvdf2mhW
	d6u6Zf29RlL4si6xRv8WeebRMTiLCTDu1VJcUil/sxQVgO8qG7FDGTOT38JvSI1McQrD2BGvxEm
	Z67WA==
X-Google-Smtp-Source: AGHT+IGheNUqnZTxuKAq20Grw8HnVQ8cX3wASKk27/QuxfDq2D1bWsA1Z0fwXhD0a/3ipTBHdfv7Gnen8ZF6gytgzjw=
X-Received: by 2002:a05:690c:284:b0:71a:2299:f0d8 with SMTP id
 00721157ae682-71fdc2e5b04mr236097057b3.16.1756303882541; Wed, 27 Aug 2025
 07:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF4aUuukN6wde=NrLcPfZPkLiudUYjSvb5NvoY55EhP3ssLx4Q@mail.gmail.com>
 <c804757c-6bf5-4053-8a32-43e21781633f@gmail.com>
In-Reply-To: <c804757c-6bf5-4053-8a32-43e21781633f@gmail.com>
From: Luis Alberto <albersc2@gmail.com>
Date: Wed, 27 Aug 2025 16:11:11 +0200
X-Gm-Features: Ac12FXyRkUxB3bMHjoPs23zMtZNV8GcgNUjug0kzRr6H0JhsAMT05FD7j51uuIg
Message-ID: <CAF4aUutwOusxj_UGJzNo53Z4DFSKe8O6npxx40gEiKMKY8_JDw@mail.gmail.com>
Subject: Re: [BUG] Network regression on Linux 6.16.1 -> 6.16.2 (persists in
 6.16.3): intermittent IPv4 traffic on Wi-Fi and Ethernet
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for your reply and suggestions. The proposed fix didn=E2=80=99t solv=
e my issue.

I=E2=80=99ve been running more tests and noticed something interesting:

Recent Kernels that work fine (issue solved, internet working perfectly):

6.16.3-201.nobara.fc42.x86_64
6.16.3-2-cachyos
6.12.43-3.1-cachyos-lts

Kernels that still show the problem (internet working very poorly):

6.16.3-arch1-1
6.12.43-1-lts

So it looks like some recent kernels (Nobara, CachyOS) already include
a patch that fixes the issue.
Could someone point me to which commit might be responsible for this
fix? That would help me apply it on Arch Linux as well.

Thanks a lot for your help

El mar, 26 ago 2025 a las 20:12, Eric Dumazet
(<eric.dumazet@gmail.com>) escribi=C3=B3:
>
>
> On 8/26/25 10:59 AM, Luis Alberto wrote:
> > Hi everyone, I=E2=80=99m new to this mailing list.
> >
> > I am reporting a network regression observed on my system when
> > upgrading from Linux kernel 6.16.1 to 6.16.2 (and persisting in
> > 6.16.3). The issue affects both Wi-Fi and Ethernet interfaces and
> > seems to originate in the kernel networking stack rather than any
> > specific driver.
> >
> > For reference, I initially reported this issue on Bugzilla, ID 220484,
> > thinking it was exclusively a Wi-Fi problem.
> > Subsequent testing with a wired Ethernet connection confirmed that the
> > issue affects both interfaces.
> >
> > System / hardware information:
> > - Motherboard: Asus TUF GAMING B460M-PLUS (WI-FI)
> > - CPU: Intel i5-10400
> > - 16GB RAM
> > - GPU: NVIDIA 4060 (proprietary open module drivers installed v580)
> > - Wi-Fi: Intel AX200, driver: iwlwifi + mac80211
> > - Ethernet: Intel I219-V, driver: e1000e
> > - Connections use IPv4
> >
> > Kernel versions tested:
> >    6.15.7, 6.15.8 and 6.16.1 (works fine)
> >    6.16.2 and 6.16.3 (regression present)
> >    LTS 6.12.43 from Aug 20 (regression present)
> >
> > Symptoms:
> > - Internet connectivity is intermittent: when opening multiple
> > websites simultaneously (e.g., 10 pages), roughly 1/4 fail to load.
> > - Failed pages either remain completely blank with a connection error
> > or load partially; both situations occur frequently.
> > - The issue also occurs occasionally with a single webpage, or when
> > downloading system updates, not limited to the browser.
> > - Occurs on both Wi-Fi and wired Ethernet.
> > - No connection drops; the interface remains "up".
> > - Tested in more than one distro: EndeavourOS and Nobara, vanilla insta=
llations.
> > - Ping comparison:
> >    6.16.2+: Running ping google.com while opening 10 webpages
> > successively results in >10% packet loss and several pages failing to
> > load.
> >    6.16.1: 0% packet loss and all pages load correctly on first
> > attempt, consistently.
> >
> > Actions taken:
> > - Opened a Bugzilla report, ID 220484, including dmesg, journal, and
> > tcpdump logs.
> > - Tested with both Wi-Fi and Ethernet; issue persists on both.
> > - Verified IPv4 usage; IPv6 is link-local only.
> > - Tested repeatedly on kernel 6.16.1 and earlier: everything works perf=
ectly.
> >
> > Reproduction steps:
> > 1. Boot kernel 6.16.2 or 6.16.3
> > 2. Connect via Wi-Fi or Ethernet
> > 3. Attempt to load multiple websites
> > 4. Observe inconsistent traffic and intermittent failures
> >
> > Any help is much appreciated.
> >
> > Could anyone advise which commits between 6.16.1 and 6.16.2 might have
> > introduced this behavior, or suggest any testing and further steps?
> >
> > Thank you very much.
> >
> > Best regards,
> > Luis Alberto
>
>
> Please try :
> https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com
> <https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.co=
m>
>
>
> >

