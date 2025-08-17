Return-Path: <netdev+bounces-214359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72FEB29187
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 06:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A070448460A
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CD1E5205;
	Sun, 17 Aug 2025 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b="bu+CI9fu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E81D8A10
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755404999; cv=none; b=T9f64zh4eXCKzmWzQE5TzcREeZiutOzza8ESuO38dN833RVGi69ODCL4epkgqiOnFVbUm68E5/AnFTIaO7wybx/HFZYxkvZgvtnLm0yIbwI/5ijXjr30KcZyEGwkXAhxBmdVhTmX9gM2QOBPw/l8tFA1g1mywsFc0qu9FEKLEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755404999; c=relaxed/simple;
	bh=dJsoDn9ejss6xZxq1+PO6yZOjAfrmBEGOzoE1pFfCOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mkVsuseiJeVQLVirtOsmRWHfZh8xr59EBRBApHuHbF+cZCBrUmd7AJtiXH1eJHK58DZwULH/fTY05EC3OsyLFIhKYs5tiyx4Yoh4LfQNzwARtie/sMIlue8sGqx6Sg8s7znbLykwq6KjSXGHQHe12gUkwxLUUb2QlX6hcQ7Pa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io; spf=none smtp.mailfrom=coresemi.io; dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b=bu+CI9fu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=coresemi.io
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2775099b3a.3
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coresemi-io.20230601.gappssmtp.com; s=20230601; t=1755404998; x=1756009798; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7tOnFcQoia7OLIfjY0GXgnbZUBsSDQdwxwR729Y/e8=;
        b=bu+CI9fuicYGql7eXCSSIHIhAnefx+/szl65SWoI3A/eRgLojNwzGAZnNuNp4KfYeb
         5nsFX2jTA79wYBcpGrBDT9J4z1pVvTPc8V6RBUNFd4U6DDlQq/jPWfosMEcQqx/6UNd/
         uO+O9RP6NIRdJRgHEQas79AvX4WjG0Z8wLxoz9joWS+k7x/RFwRkRWvsj5GaD50rrIcS
         b9+tRO688Ch3A1WZlazCSTxWdJvysUbusuZfNfWGkK1PL4hZKqPInIUY6rTn4IxKcEdq
         5U0nr0Gl3lOvb36HYFw7wqdyX5oLf73jVvDWMvlu2rKpUxZq44IpmOJVA9K/oS9NpLgV
         /HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755404998; x=1756009798;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7tOnFcQoia7OLIfjY0GXgnbZUBsSDQdwxwR729Y/e8=;
        b=GZq/qXh8Iozt4pfz0dyUbG2DVyF9VgLF8Wf9BYGTRHjS+LkfDCaq/zdJJmEJ7IxWx2
         Yos7DNKTvCGvh4sLNuRNri+lsyehV08Mqh61jJ4Tc/gGOFyeOorWXPwTnFqy7xmFtDX0
         r6jFHq5Pnj0FId++atk7ec9c9W9PRrg6I2mwQwalRNoLZAzCafbQ21Sq4X2vk8oVHiOT
         HKwAzR2OQm2bBObPQrHMFIaoDAOPU7z2oj5vBmCop2LlG/7Z3ltOLzjFNANqCmBslzrD
         VIivKATCDzBZPF875/fJQHSnt266f6xOinCfnWJXVvHG0LBLwnxRglq0fRfymOid+AVf
         jjhg==
X-Forwarded-Encrypted: i=1; AJvYcCUnDpv9lGL0t2GuKB05aqABVKzA6e/qZxNnp/gdBJTh+BSsJDKlE9jpQcDT1h5o7yMkpZcaj/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2I0CkaKtojvaojfiThnhLpI5keDeBk6nUOkijjqUmdB/toOu
	uxw47uX8yy4mu+wffJ9YHp1sNzOGBFe4d11d1gEuJhn6BLz1CZ5RHah07WgCVQDZZeU=
X-Gm-Gg: ASbGncsK0fdOYD2RMfgGu35rnJx3Q16wnD3qCbZw+ThqBPz3/WkofYtQ+nV9uEf6aDp
	uVMvXTeZa/Khgy1SUwhSJOw71aiaTZj9I++JgCYuN6AP0aNzW9Yl78xu509V15niAYjCEvaPZH9
	TfPn08iaZEmBtlG9YXnu0iTjkHrTZA5Z7IP7yLo0Fo5DenPdfSCn7Yqq0uZbcNV3D9RJCx+rMrG
	vsfFheHvVhjcgL3o9x46ti8CxJnwSEBKUhEvTMZEDo8BydvZPRM4rZoT9/5iMtTYoML3xtvqZuM
	2BiO0dRKpMnfocuKqerB9o1b5nlleB2FnBBS1txmSIRHBU8gH6MOMdgpLIaySDyquUlTkGG8Y4w
	ioMELgNE66UeB3TdEZa5BqYtF/oinsfMQzWPCtRTGguPkc+6DAKvRn668oH28TCwQ+w==
X-Google-Smtp-Source: AGHT+IGTkulwbSKlMNKTgkK2+N/a2tNWqVdcaDc/+0IBx3cEbIkK7JZwpjqo8gKvMk5mXlc40TvNCw==
X-Received: by 2002:a05:6a20:9143:b0:23f:f7ae:6e24 with SMTP id adf61e73a8af0-240e6311cc0mr6485220637.29.1755404997708;
        Sat, 16 Aug 2025 21:29:57 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a0a7sm5134883a12.28.2025.08.16.21.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 21:29:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
From: "D. Jeff Dionne" <jeff@coresemi.io>
In-Reply-To: <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
Date: Sun, 17 Aug 2025 13:29:42 +0900
Cc: Andrew Lunn <andrew@lunn.ch>,
 Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "D. Jeff Dionne" <jeff@coresemi.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC855B2C-37F3-4565-8B6F-B122F7E16E25@coresemi.io>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
To: Artur Rojek <contact@artur-rojek.eu>
X-Mailer: Apple Mail (2.3826.700.81)

On Aug 16, 2025, at 22:40, Artur Rojek <contact@artur-rojek.eu> wrote:

The MDIO isn=E2=80=99t implemented yet.  There is a pin driver for it, =
but it relies on
pin strapping the Phy.  Probably because all the designs that SoC base =
is in
(IIRC 10 or so customer and prototype designs, plus Turtle and a few=20
derivatives), the SoC was designed in conjunction with board.  A bit =
lazy.

But they all have the MDIO connected, so we should add it (it=E2=80=99s =
very simple).

Cheers,
J.

> On 2025-08-16 02:18, Andrew Lunn wrote:
>>> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both =
MDC
>>> and MDIO pins connected, however I suspect that nothing really
>>> configures it, and it simply runs on default register values (which
>>> allow for valid operation in 100Mb/s mode, it seems). I doubt there =
is
>>> another IP core to handle MDIO, as this SoC design is optimized for
>>> minimal utilization of FPGA blocks. Does it make sense to you that a =
MAC
>>> could run without any access to an MDIO bus?
>> It can work like that. You will likely have problems if the link ever
>> negotiates 10Mbps or 100Mbps half duplex. You generally need to =
change
>> something in the MAC to support different speeds and duplex. Without
>> being able to talk to the PHY over MDIO you have no idea what it has
>> negotiated with the link peer.
>=20
> Thanks for the explanation. I just confirmed that there is no activity
> on the MDIO bus from board power on, up to the jcore_emac driver start
> (and past it), so most likely this SoC design does not provide any
> management interface between MAC and PHY. I guess once/if MDIO is
> implemented, we can distinguish between IP core revision compatibles,
> and properly switch between netif_carrier_*()/phylink logic.
>=20
> Cheers,
> Artur
>=20
>> Andrew


