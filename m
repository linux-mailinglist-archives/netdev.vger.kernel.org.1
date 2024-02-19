Return-Path: <netdev+bounces-73059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3F85ABE9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104AEB21752
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E375026E;
	Mon, 19 Feb 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aperture.us header.i=@aperture.us header.b="ZZqJEev/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12F47F7D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370452; cv=none; b=az3YRyS/6NJZGftx5AZg5kO73uV6RQHzzZSks+b9x8JrGjQhS4jf0dE0ssTkemzTgsm6KGxO22J3YrBTST7uM4H9iTxlOI8v2lQuz/YR9t5PDjCQvcXGgrLK2J5UC/s3vLjum4NhtMDPBZmXpqFAmTygcm+jocAHYkcCx0ejFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370452; c=relaxed/simple;
	bh=qdvXdkVbNbbQQZQgPyInWUPpRCO2AkWejeYup9kcpxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNEBN11eyid4qTG2o+A1R8RSGV8DcBKhLr90Q2jxNsxUY3rTbbSJw6mtfkbm8oAfPU5vn5WFowzDs7UcbX30SD8N9VU/pQqCeNspf4NaDRE5nWJlJ6riGdBJfd9ZWE7qFSkUtiC9+7fEr6Z3IU6+aLWM0d6sIk9S4JbvkyGi1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aperture.us; spf=pass smtp.mailfrom=aperture.us; dkim=pass (2048-bit key) header.d=aperture.us header.i=@aperture.us header.b=ZZqJEev/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aperture.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aperture.us
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bfc18438so199509e87.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aperture.us; s=google; t=1708370448; x=1708975248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09twXXuSAdtT2B8XfotC/XfUg1hm8BCZLN4gmIrN3SE=;
        b=ZZqJEev/5aD8JohJqPKV+e7HZAl7qtnCKcgwpLhnSiL/AE0dB4tXl7inPWZFB83k+w
         FOmHW/I6yZs+WWh6SLYtD1i47ONvLv6XCp+meNB5ANd0bFSW/HUFCpXUXKyX8Jqy5bMf
         yt2hWw4VL99iNiN6w9KYH7O4GZqjT03QtH475RVcmgOAKn4YpER/OaPFnUrj4oSvc5/F
         Y2M48lLw+3BNg14NaT3O5gYr2dA12kovBR87yS9nKbCpompHFjNowJwwq/ryiVNQjNzU
         Ypiqd54YP1HmSSY+xfFUwIhfMa53IWneVnpMKYHmyCcCA1qnRPo0CMQam7N10NCUSJs/
         ADXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370448; x=1708975248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09twXXuSAdtT2B8XfotC/XfUg1hm8BCZLN4gmIrN3SE=;
        b=VeyU0JD2q8FV+SlGnIo72m3qJ0xPRTeVPoHwXadWpQVJxbWXpuUeBd+eciEK5jp/QT
         TOG8hbO17gi87hZpwl3k/KwZqxPozfb8zlzIWk+7UlvWsqlbqA9mfgq3RlYEYw1G+WOJ
         tS6Vw0lZqjaFqouRul8/9yozlazLvtocbOuydwy1RY6lK/K7mOM/U6Eastl8VKoAZ3sk
         89Utfl710o3/I7cQtoPTDCLql+mEZR50YNscjHabmySuAMKruFpPhLyFBcj/Ur8t2R/i
         DSopvt86Ut+BwhYblrIfkoIrxcw+osXaDACbN14xO/HdwRE5p52spCwQFNmcNnexZI7Z
         odgw==
X-Forwarded-Encrypted: i=1; AJvYcCVKsZS1V9w72zZX/K5vUWwN7mndvwOUvsLXS3diFIB2jIZteZ0C//qhDiol6cFKxSSzYV5rRz6XmAC1mCcgaXDceQdpCpcC
X-Gm-Message-State: AOJu0YwMIsFlp/aD02pzjwahQAxZdBUl3cwBtg+yfyzW6KFtib4vtPzz
	UoYNJYJpnAMY+jfrtN9s4EYRThNctvJ8EJYw76/U+8kgzvBNJDR6KImC0iqL4PD5xmsYKImny/i
	ozfwVmg==
X-Google-Smtp-Source: AGHT+IF6xFCSFIX7fuxUImdrguPxy0JQ4x80lDLH8IO86FksN6Sol5G9B+HcLwx6quMcjPQXqG7aLg==
X-Received: by 2002:ac2:5e33:0:b0:512:bdcd:f22b with SMTP id o19-20020ac25e33000000b00512bdcdf22bmr1063373lfg.64.1708370448571;
        Mon, 19 Feb 2024 11:20:48 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t20-20020ac25494000000b00512b36ee2c3sm501185lfk.68.2024.02.19.11.20.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 11:20:47 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0e520362cso48012271fa.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:20:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaZLrzZORz1jGJpRUQTs3yvcYvSo851LKrkyxg2Q9mmiwJBWkwItPm6eaHAgPbltdtCaSzfCDZaiktmir2i36Zfr5E8pCr
X-Received: by 2002:a05:6512:1287:b0:512:c1e1:5211 with SMTP id
 u7-20020a056512128700b00512c1e15211mr32919lfs.37.1708370446705; Mon, 19 Feb
 2024 11:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch> <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch> <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz> <ZbOPXAFfWujlk20q@torres.zugschlus.de>
 <20240126121028.2463aa68@meshulam.tesarici.cz> <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
 <0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com> <20240206092351.59b10030@meshulam.tesarici.cz>
 <ZcoL0MseDC69s2_P@torres.zugschlus.de>
In-Reply-To: <ZcoL0MseDC69s2_P@torres.zugschlus.de>
From: Christian Stewart <christian@aperture.us>
Date: Mon, 19 Feb 2024 11:20:35 -0800
X-Gmail-Original-Message-ID: <CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
Message-ID: <CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
To: Marc Haber <mh+netdev@zugschlus.de>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, alexandre.torgue@foss.st.com, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, Feb 12, 2024 at 4:15=E2=80=AFAM Marc Haber <mh+netdev@zugschlus.de>=
 wrote:
>
> On Tue, Feb 06, 2024 at 09:23:51AM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Mon, 5 Feb 2024 13:50:35 -0800
> > Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > > On 2/5/24 12:12, Marc Haber wrote:
> > > > On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesa=C5=99=C3=ADk wr=
ote:
> > > >> Then you may want to start by verifying that it is indeed the same
> > > >> issue. Try the linked patch.
> > > >
> > > > The linked patch seemed to help for 6.7.2, the test machine ran for=
 five
> > > > days without problems. After going to unpatched 6.7.2, the issue wa=
s
> > > > back in six hours.
> > >
> > > Do you mind responding to Petr's patch with a Tested-by? Thanks!
> >
> > I believe Marc tested my first attempt at a solution (the one with
> > spinlocks), not the latest incarnation. FWIW I have tested a similar
> > scenario, with similar results.
>
> Where is the latest patch? I can give it a try.
>
> Sorry for not responding any earlier, February 10 is an important tax
> due date in Germany.
>
> Greetings
> Marc

We are seeing the same kernel panic on shutdown with 6.7.4 on a
BananaPi M2 Ultra:

[**    ] (3 of 3) A stop job is running for Network Manager (33s / 52s)
[  259.463772] rcu: INFO: rcu_sched self-detected stall on CPU
[  259.469388] rcu:     0-....: (2099 ticks this GP)
idle=3D0fdc/1/0x40000002 softirq=3D12003/12003 fqs=3D1034
[  259.478360] rcu:     (t=3D2100 jiffies g=3D16277 q=3D36 ncpus=3D4)
[  259.483595] CPU: 0 PID: 4462 Comm: ip Tainted: G         C         6.7.4=
 #1
[  259.490562] Hardware name: Allwinner sun8i Family
[  259.495268] PC is at stmmac_get_stats64+0x30/0x198
[  259.500081] LR is at dev_get_stats+0x3c/0x160
[  259.504445] pc : [<c06b9924>]    lr : [<c07bf7a8>]    psr: 200f0013
[  259.510712] sp : f1e6d9b8  ip : c3ca478c  fp : c23e0000
[  259.515941] r10: 00000000  r9 : c3ca4598  r8 : 00000000
[  259.521168] r7 : 00000001  r6 : 00000000  r5 : c23e3000  r4 : 00000001
[  259.527697] r3 : 00005c1b  r2 : c23e2e08  r1 : c3ca46c4  r0 : c23e0000
[  259.534226] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[  259.541363] Control: 10c5387d  Table: 429cc06a  DAC: 00000051
[  259.547117]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
[  259.552882]  dev_get_stats from rtnl_fill_stats+0x30/0x118
[  259.552899]  rtnl_fill_stats from rtnl_fill_ifinfo+0x720/0x135c
[  259.564306]  rtnl_fill_ifinfo from rtnl_dump_ifinfo+0x330/0x6a8
[  259.570240]  rtnl_dump_ifinfo from netlink_dump+0x16c/0x350
[  259.575830]  netlink_dump from __netlink_dump_start+0x1bc/0x280
[  259.581766]  __netlink_dump_start from rtnetlink_rcv_msg+0xf4/0x2f0
[  259.588047]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb8/0x118
[  259.593893]  netlink_rcv_skb from netlink_unicast+0x1fc/0x2d8
[  259.599655]  netlink_unicast from netlink_sendmsg+0x1c8/0x440
[  259.605416]  netlink_sendmsg from sock_write_iter+0xa0/0x10c
[  259.611094]  sock_write_iter from vfs_write+0x338/0x398
[  259.616334]  vfs_write from ksys_write+0xbc/0xf0
[  259.620961]  ksys_write from ret_fast_syscall+0x0/0x54
[  259.626110] Exception stack(0xf1e6dfa8 to 0xf1e6dff0)
[  259.631169] dfa0:                   00000003 be997dd8 00000003
be997dd8 00000014 00000001
[  259.639351] dfc0: 00000003 be997dd8 00000014 00000004 00519548
be997e08 b6fd0ce0 0051783c

https://github.com/skiffos/SkiffOS/issues/307

I'm writing to ask if anyone has found a fix for this yet?

Thanks!
Christian Stewart

