Return-Path: <netdev+bounces-227778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BFABB6F01
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4440D1888724
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369172FE06E;
	Fri,  3 Oct 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZjaS6+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145782FE049
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496966; cv=none; b=n0W/JHcsWSlr9DLhyaGDiKZKK7EXgXczb/H0nEOVcByeTwTwE0NRVy2Sndcwo3fRDnN+qWd9Z09ffJdnhzoN49f+IiqKvWx19dUZkaWtJyzwzDGMYiUyoCyIw8bih52sQh2Y6frsoFdOo/bVPNyOmFED3jgbrPZadrMQwQLokvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496966; c=relaxed/simple;
	bh=vskSY37lS60toJbTKBSyf1fXV82LvSikiPax9TwweHk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GSLK3dDchUK6mpCCZeJZ7iE6i7jRZaQs2nb2sV3r0SQQjI2S0iG6ROrhuCUrMmjRiie8zYz8aEOCrO8R1FkMgeRq73HuG/yWBhttTVyTWiTY9UnAGgT+ZJB35LRulJaqtuX35NUco24o3LOspNMj5JgzOG7G1OGxdnLSO2VdwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZjaS6+m; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57a960fe78fso2311888e87.2
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759496962; x=1760101762; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCgIemKPrsrTL1ps0lmEUaHKivVfdZYFIajPH3P9eNE=;
        b=VZjaS6+m8lwpSirKf+e5CDQNvnZo7/EsYKehVmzjLJL+UyRGoUx7m2Uica0d5QYjIL
         FjRpxtpbDvbsr80rjIqRZHa4jYmUTuMRmntn4KGr8yEjtzYlOav2+vsGD/9GaIiqJXng
         ZPPae8aJmR6WbaZwf3kXJWQ0NwiIuA4X8PQN49O+qT8RT1RWIUbwHJ1Rx/OAHp1ZacvA
         eHOnrfZ+n4kSi1qhx9sdh9ew5IHOElA0HBtExke91L3+EU7CeJrJNYyW82tifT/e2VdN
         865LQsHIb7lSNSFkduBePDUof665B0drL7FEy7tqGun6VUP9btm+VMpdf0Cpc39FieBp
         8imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759496962; x=1760101762;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCgIemKPrsrTL1ps0lmEUaHKivVfdZYFIajPH3P9eNE=;
        b=Z2IkjveHuxx2OxfX95V3Tg+uASbUpM5BdoY2vqCLT491m41Zsq492zL78Tu39S5b7u
         +a6GldrTpoH2MOXeaLin2fBP1l6V1DxPxoQncrSNkHa7CqRF6m6QRKrcEk+DISlr2RtD
         qqBjKK48lC7CEMMJcV0dHY8d+JAIJfR0bOD8/xsYmQ6deRcd6FmPm/fTy3b4t6EEyqbK
         qsVcmjkNdzH0M5nisSAHYjOaUu/6V5NGdln55pajNynyoJTajS0wYg4eqG7KYIB7Tzc5
         eb0Io8GEO6pfcvP3PElDIE9YfytNyXURx9YB43r9T6qMM+ZgpT3qSG9Tg1lPulnT2T7Q
         oSqA==
X-Forwarded-Encrypted: i=1; AJvYcCXL0fflQR0Tv4w973eWrh78Hs5h+o+mph7TEFa2NcH1LOYZGJDiRWDSsqQV4JSNIUkpB1iVBAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNELc/Bh1/XkF42cTlfYS/haTlYLqUSPRP2BqxVZk4GbF/Cbm
	mmSFCV3mphSZwmvs4zlR/WTTFMoXiNi2vFC/v+7Ddg3sEHYJv18c8MfX
X-Gm-Gg: ASbGncsei+h45z5qDx6KpAJBquzWTkcdHy5zaqUs6Io4BaZXmLXhOQQLO3z5qCsnmiG
	hWOHD8TQyP/E4aTYFe6yWxBr3m6xEN92lPW9JDlpcKyePHrYsD3IQRDHP94QtZ6FVH664NGr7o1
	5lKdPWsh5PDEM2f3L/PL/NCAF/8d1Vcz8RF1Yk6ykBiEsKvUP9ccM4UUBvd8VoVabJMDMzhmStT
	4Pf/rH9yuzFNzKjGkF34bx9xtvDmq5XIeDN8xJHTRx8sVr16KG1yM3GMnRRaLAkqnJn4htK5yJr
	a7bgyANcRKwtsJ1rP1McM6Tm5JSoox78J5565YmvExFE3R4a0HjLghaFpVSaRRikPvgX3pjE5wZ
	oORvK8am+64Q/ktDTdKH3mYLHWfujAmGIjv047qGc/qny12pf/du+qmihf1DnbwSL/k3d3EO9Lo
	xVWQ==
X-Google-Smtp-Source: AGHT+IGQDRMsmuf7GRheM/F9ThQSNt7DErYShT8B6ApUmvOT1m3oa5fieJ3tHAIrsClwK0aj61hLuQ==
X-Received: by 2002:a05:6512:1052:b0:57f:7baa:b9bf with SMTP id 2adb3069b0e04-58cb9a37b36mr879176e87.23.1759496961749;
        Fri, 03 Oct 2025 06:09:21 -0700 (PDT)
Received: from localhost (c188-149-31-7.bredband.tele2.se. [188.149.31.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113490dsm1839325e87.32.2025.10.03.06.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 06:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 15:09:18 +0200
Message-Id: <DD8PM8593EAM.1FQU37SU51BLJ@gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] ptp: marvell: add core support for
 Marvell PTP v2.1
From: "Casper Andersson" <casper.casan@gmail.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>
X-Mailer: aerc 0.20.1-41-gf07db1056341
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
 <20250416104849.43374926@kmaincent-XPS-13-7390>
 <Z_9252w9vWiGysiF@shell.armlinux.org.uk>
 <20250613171913.11a10645@kmaincent-XPS-13-7390>
In-Reply-To: <20250613171913.11a10645@kmaincent-XPS-13-7390>


Hi, I'm also late to the ball here.

On Fri Jun 13, 2025 at 5:19 PM CEST, Kory Maincent wrote:
> Hello Russell,
>
> Le Wed, 16 Apr 2025 10:22:47 +0100,
> "Russell King (Oracle)" <linux@armlinux.org.uk> a =C3=A9crit :
>
>> On Wed, Apr 16, 2025 at 10:48:49AM +0200, Kory Maincent wrote:
>> > On Fri, 11 Apr 2025 22:26:37 +0100
>> > Russell King <rmk+kernel@armlinux.org.uk> wrote: =20
>> > > Provide core support for the Marvell PTP v2.1 implementations, which
>> > > consist of a TAI (time application interface) and timestamping block=
s.
>> > > This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
>> > > Armada 37xx (mvneta), as well as Marvell DSA devices.
>> > >=20
>> > > Support for both arrival timestamps is supported, we use arrival 1 f=
or
>> > > PTP peer delay messages, and arrival 0 for all other messages.
>> > >=20
>> > > External event capture is also supported.
>> > >=20
>> > > PPS output and trigger generation is not supported.
>> > >=20
>> > > This core takes inspiration from the existing Marvell 88E6xxx DSA PT=
P
>> > > code and DP83640 drivers. Like the original 88E6xxx DSA code, we
>> > > use a delayed work to keep the cycle counter updated, and a separate
>> > > delayed work for event capture.
>> > >=20
>> > > We expose the ptp clock aux work to allow users to support single an=
d
>> > > multi-port designs - where there is one Marvell TAI instance and a
>> > > number of Marvell TS instances. =20
>> >=20
>> > ...
>> >  =20
>> > > +#define MV_PTP_MSGTYPE_DELAY_RESP	9
>> > > +
>> > > +/* This defines which incoming or outgoing PTP frames are timestamp=
ped */
>> > > +#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
>> > > +				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
>> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
>> > > +/* Direct Sync messages to Arr0 and delay messages to Arr1 */
>> > > +#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
>> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP)) =20
>> >=20
>> > Why did you have chosen to use two queues with two separate behavior?
>> > I have tried using only one queue and the PTP as master behaves correc=
tly
>> > without all these overrun. It is way better with one queue.
>> > Maybe it was not the best approach if you want to use the two queues. =
  =20
>>=20
>> First, both queues have the same behaviour.
>>=20
>> Second, because they *aren't* queues as they can only stamp one message.
>> The sync messages come from the master on a regular basis. The delay
>> response messages come from the master in response to a delay request
>> message, the timing of which is determined by the local slave.
>>=20
>> If the local end sends a delay request just at the point that the master
>> sends a sync message causing the master to immediately follow the sync
>> message with the delay response message, then we could get an overrun
>> on a single queue - because we'll stamp the sync message and if we don't
>> read the timestamp quickly enough, the stamp registers will be busy
>> preventing the timestamp of the delay response being captured.
>
> I just come back on this. I think you are wrong.
> We are using different registers to save timestamp for departure or arriv=
al
> packets.
> If there is a sync message and a delay request message (the delay respons=
e is
> not timestamped) at the same time, the sync message timestamp will be sav=
e in
> the departure registers and the delay request timestamp in the arrival re=
gisters
> (or the contrary if the Marvell PTP is a follower). There is no possibili=
ty to
> loose the timestamp on that case, therefore using two registers for arriv=
al
> packets is useless.

E2E timestamping should never have any collision on RX timestamps. But
P2P can. Sync, PdelayReq, and PdelayResp all need to be RX timestamped.
Running normally with ptp4l it worked pretty fine with PdelayResp on a
separate "queue". But Calnex Paragon-X (PTP tester) sends Sync and
PdelayReq almost simultaneously, causing collision. So there really
isn't a perfect solution to this. This was my experience from a while
back with Russell's original RFC from years ago.

Some variants of this PTP block (e.g. the 1512p and mv88e6390x I have
access to) have the ability to store the timestamp in the reserved2
field, which makes RX timestamps much simpler and less error-prone (but
they also support the full onestep offloading using Time Arrays which
requires a totally different implementation).

BR
Casper

>
> FYI, I just tested the patch series on the Espressobin which have a mv88e=
6xxx
> and the PTP worked well.=20
>
> Do you now If you will have time to send a v2 or should I take the lead o=
n
> this series?=20
>
>> With the overruns that I've seen, they've always been on the second
>> "queue" and have always been for a sequence number several in the past
>> beyond the point that the overrun has been reported. However, the
>> packet which the sequence number matches had already been received -
>> and several others have also been received. I've been wondering if it's
>> a hardware bug, or maybe it's something other bits of the kernel is
>> doing wrong.
>
> I think we should drop this as I don't see anything relevant to use two
> "queues" except overrun cases.
>
> Regards,


