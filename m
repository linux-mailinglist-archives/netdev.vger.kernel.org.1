Return-Path: <netdev+bounces-147987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421849DFB8B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92746B2435E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90081F943F;
	Mon,  2 Dec 2024 07:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585D1F8EF0;
	Mon,  2 Dec 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126292; cv=none; b=AW/MbtIMxdjVkUJ8TzO6ezvqE/XKwvy73BznapXPDg1Nwbw+EJK73d/KCx9modzUGwp+VEydFeFq8Kt663dJtvek0pqxrtvMB/alFcfnWuPcy/3EXRqUDHhimHsyQJ4FClJHI3U+tIjgDNL8u9RAUmSQxO/+ioxOLCNfCtsur8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126292; c=relaxed/simple;
	bh=5n73uMdwQbFgV2Fx+/Rw7cLPrVE0hEVu/BDKxMK536I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ia05bnJjXZ2x5zMUjmFfyo/I+HOVMI0EvVj9FH5wGzSlnvJL77tRiQjwGoTUZc+IEJMTVtYHVYbC2i7vVKrVV4UEvEyfmBCNc8VqPA3VQ6PzB7fTA3HM2h/WkK/zYI7tsA/7E9xUzoHSIFPbLtCwx7YaWaT4ZC2Qw3GTWmQ2d0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id ADC37C3EEAC5;
	Mon,  2 Dec 2024 08:57:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl ADC37C3EEAC5
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,  netdev <netdev@vger.kernel.org>,  Oliver
 Neukum <oneukum@suse.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jose Ignacio
 Tornos Martinez <jtornosm@redhat.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
In-Reply-To: <f870d2c7-cf0a-4e78-80d6-faa490a13820@gmail.com> (Heiner
	Kallweit's message of "Fri, 29 Nov 2024 07:49:32 +0100")
References: <m3plmhhx6d.fsf@t19.piap.pl>
	<c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch>
	<m3wmgnhnsb.fsf@t19.piap.pl>
	<2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch>
	<m3serah8ch.fsf@t19.piap.pl>
	<f870d2c7-cf0a-4e78-80d6-faa490a13820@gmail.com>
Sender: khalasa@piap.pl
Date: Mon, 02 Dec 2024 08:57:59 +0100
Message-ID: <m3ldwyh5yw.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Heiner,

Heiner Kallweit <hkallweit1@gmail.com> writes:

> If autoneg is supported, then phylib defaults to enable it. I don't see
> anything wrong with this. BaseT modes from 1000Mbps on require autoneg.
> Your original commit message seems to refer to a use case where a certain
> operation mode of the PHY doesn't support autoneg. Then the PHY driver
> should detect this operation mode and clear the autoneg-supported bit.

I'm not sure about it, but if there is consensus it should stay this
way, no problem.

WRT specific case, It seems the SFP port doesn't support autoneg on
AX88772BL (I don't have any SFP copper 10/100 module).

The PHY registers (100BASE-FX, no link currently):
          x0   x1   x2   x3   x4   x5   x6   x7   x8
  0000: 2100 7809   3B 1881  501
  0010:  250  80C 8620   20 2314  3C8 4716 724F 8024

BMCR: fixed speed 100 Mb/s
      The datasheet says "autoneg is fixed to 1 and speed to 100", but
      it's apparently the case only with 100BASE-TX, not FX.

      It seems autoneg, speed and duplex bits are read only
      (bits 13, 12, 9, 8). So, basically, you can't enable autoneg at
      all and this is maybe the source of the "bug".

BMSR: 10 and 100 Mb/s FD/HD autoneg support indicated. Hmm. R/O.

ANAR: quite standard, but doesn't matter since autoneg is disabled.

I will think about it a bit more.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

