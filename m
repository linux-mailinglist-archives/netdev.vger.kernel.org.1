Return-Path: <netdev+bounces-112306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D328593833B
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 03:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C031C20A6C
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D591373;
	Sun, 21 Jul 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Jjz3yLJD"
X-Original-To: netdev@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE81366
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721525645; cv=none; b=bdqm2preZhffgwY6FyplzYpqnEch+FShGg2zlXJhdWxtouX856lHwsN5XofJ0g7M03dGZJp1LpbfHOmZU21gCXd1lqbBEf7qCJ4z1BqhBNOEXMQwtFx5JQUxPqSL8gVW3o+7wpM0pUneQ7dj/utbMVsYwGfC9K9fkaoTfTBcc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721525645; c=relaxed/simple;
	bh=g9i4JDr+uPtFirh5pRcoHEC79u82FuNeO1Ot5aBME5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ib/E666P075pj9G5q/HcQniUHWaplJav8T+33bN1vziNGIgiXqeYJcUlEiT5Uy3krkwKmG7hCmSTM2+CN8JVVevdlW2Hl6XutDGRHgw2LvXslTzdhqL9i8vu+lCklu5udt/KgojbyrwBKdfTmZuwNbacTOcIsoMdjYUC/qQ8OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Jjz3yLJD; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WRQtF2lpczlgVnN
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-type:content-type:subject:subject:message-id:date:date
	:from:from:mime-version:received:received:received; s=mr01; t=
	1721525636; x=1724117637; bh=66sXb5L8VpwQzrDoVc4XLiBCV7skFuDMSD1
	AlzCXdRg=; b=Jjz3yLJDBVuM5HJgGqTPOeMhwDI9ZAjwOKxMIk/hmH7VizCyNs1
	fEbm96QMjBrZ2zfpehuojLooaOyDREJ1jyxzu0443M949KJZbwe3Fo+WHV0FFMTy
	1Wo8o/vsf26s7VM3pSrt2PXvZzYKggrqsdhl3mA+obUq0rFr2U0Vkzbs9ldHuKgu
	kGNzcgaoxDeZCOnWEUm189LiUQ4h5T6z5yy3BNQ7kqvf5jS9qsIKFatRPZ46MAkl
	4FR0sI1JZNOBJD1oJpKzvF8q3IyJDCgybOkhxgQV+46dIcgckwN24gLYfMkU3li6
	8eXIzSJPzFRhtX1viu1jyD74bF9XEjr6aAw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id doMvr9zTI9gT for <netdev@vger.kernel.org>;
 Sun, 21 Jul 2024 01:33:56 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave_gomboc@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WRQtD4jfhzlgVnF
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 01:33:56 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-81f91171316so1847244241.0
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 18:33:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNhka9G+ZVlrKzAvB2PNwDGRZamEX2kNPCiSBM/ySOkNXmVapg
	q1vTFyTzXKIwF/qsI42zG6U42h6TGfgB2a4ycqI6rxSLXwaUKvXM7f0reBAwWFPpLHfRgEFFlEy
	bmZOU72v/LS5MZLtJVphN35IrLTg=
X-Google-Smtp-Source: AGHT+IExkHV0nluwCC7x30oSc33L4bUhDjLNYq00BIF0HtbrZZgZ4GUWYAKfaDeUUF2l4SRxQFe8OJtjTMQ32UuV6lA=
X-Received: by 2002:a05:6102:c02:b0:48f:c0b4:5696 with SMTP id
 ada2fe7eead31-4925c19ce4cmr7730791137.1.1721525635638; Sat, 20 Jul 2024
 18:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Gomboc <dave_gomboc@acm.org>
Date: Sat, 20 Jul 2024 18:33:19 -0700
X-Gmail-Original-Message-ID: <CA+dwz-12S8EeJjJ_FHtTvP41-Ru4pcfCS2ub5KjGHSY0=F=jog@mail.gmail.com>
Message-ID: <CA+dwz-12S8EeJjJ_FHtTvP41-Ru4pcfCS2ub5KjGHSY0=F=jog@mail.gmail.com>
Subject: Debian Bookworm requires r8168-dkms for RTL8111D - regression from
 Buster 10.13.0
To: nic_swsd@realtek.com, romieu@fr.zoreil.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am sending this email because of the suggestion in
/usr/share/doc/r8168-dkms/README.Debian.

Installation using a Debian Bookworm 12.2.0 amd64 DVD-ROM does not
find the onboard gigabit ethernet (RTL8111D-based) on one of my
mainboards (Gigabyte GA-890GPA-UD3H).  The network came up fine as
soon as I used apt-offline to update/upgrade, then to fetch and
install r8168-dkms.

Installation using a Debian Bullseye 11.8.0 amd64 DVD-ROM does not
find the onboard NIC either.  However, installation using a Debian
Buster 10.13.0 amd64 DVD-ROM does find the onboard NIC and can use it
directly.  (Unfortunately, installing from that DVD-ROM later failed
for some other reason.)

With r8168-dkms in operation, the relevant part of "lspci -v -v -v" reads:

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Co
ntroller (rev 03)
       Subsystem: Gigabyte Technology Co., Ltd Onboard Ethernet
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0, Cache Line Size: 4 bytes
       Interrupt: pin A routed to IRQ 18
       NUMA node: 0
       Region 0: I/O ports at ee00 [size=256]
       Region 2: Memory at fdfff000 (64-bit, prefetchable) [size=4K]
       Region 4: Memory at fdff8000 (64-bit, prefetchable) [size=16K]
       Expansion ROM at fd600000 [virtual] [disabled] [size=128K]
       Capabilities: <access denied>
       Kernel driver in use: r8168
       Kernel modules: r8168

Please let me know if there is further information I can provide that
would assist you in getting this supported directly by the r8169
driver.

Dave Gomboc

