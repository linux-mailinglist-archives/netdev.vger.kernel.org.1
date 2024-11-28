Return-Path: <netdev+bounces-147681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9D9DB2C9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A228277C
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B33145348;
	Thu, 28 Nov 2024 06:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7985628;
	Thu, 28 Nov 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775515; cv=none; b=ka1eKFygYV/6/hV+fdwg8mCSKDcka33I3rD6hTmAgjpCIf68CuEP1Rovw9hGUK05JNBihQc+eLof3hNqXPbNLZ/BTEMoIHBi5/eHPE8YzOUkZdH63vWaqwV6XvMfgo7h5yXzyi+3ecSTIQSEQto4OUjULJJblo3mLuMrUZ2QwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775515; c=relaxed/simple;
	bh=8MIb454F747QhCp+41gOydAJ0LMkRoVG4yoK6ZtJz6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X12HyaZ5A77nvB+Jrnw7zudV6Hy8r/XUpAaNsIM5AKhXQh3s57CH7TkIUsAy78nTHeJ7eosVznWVhLBlAZxRSk2iaFom5L1D5cyCJTShDaZ2iXGZqj4iCT2UIAZuJY3bPzlQzyVcZapdvLRI9yIxq6ktSSGQ3SSYKSpcqqQp1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 65B69C3EEACD;
	Thu, 28 Nov 2024 07:31:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 65B69C3EEACD
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jose Ignacio
 Tornos Martinez <jtornosm@redhat.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
In-Reply-To: <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch> (Andrew Lunn's
	message of "Wed, 27 Nov 2024 18:37:36 +0100")
References: <m3plmhhx6d.fsf@t19.piap.pl>
	<c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch>
Sender: khalasa@piap.pl
Date: Thu, 28 Nov 2024 07:31:48 +0100
Message-ID: <m3wmgnhnsb.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

>> Unfortunately it's initially set based on the supported capability
>> rather than the actual hw setting.
>
> We need a clear definition of 'initially', and when does it actually
> matter.
>
> Initially, things like speed, duplex and set to UNKNOWN. They don't
> make any sense until the link is up. phydev->advertise is set to
> phydev->supported, so that we advertise all the capabilities of the
> PHY. However, at probe, this does not really matter, it is only when
> phy_start() is called is the hardware actually configured with what it
> should advertise, or even if it should do auto-neg or not.
>
> In the end, this might not matter.

Nevertheless, it seems it does matter.

>> While in most cases there is no
>> difference (i.e., autoneg is supported and on by default), certain
>> adapters (e.g. fiber optics) use fixed settings, configured in hardware.
>
> If the hardware is not capable of supporting autoneg, why is autoneg
> in phydev->supported? To me, that is the real issue here.

Well, autoneg *IS* supported by the PHY in this case.
No autoneg in phydev->supported would mean I can't enable it if needed,
wouldn't it?

It is supported but initially disabled.

With current code, PHY correctly connects to the other side, all the
registers are valid etc., the PHY indicates, for example, a valid link
with 100BASE-FX full duplex etc.

Yet the Linux netdev, ethtool etc. indicate no valid link, autoneg on,
and speed/duplex unknown. It's just completely inconsistent with the
real hardware state.

It seems the phy/phylink code assumes the PHY starts with autoneg
enabled (if supported). This is simply an incorrect assumption.

BTW if the code meant to enable autoneg, it would do exactly that -
enable it by writing to PHY command register. Then the hw and sw state
would be consistent again (though initial configuration would be
ignored, not very nice). Now the code doesn't enable autoneg, it only
*indicates* it's enabled and in reality it's not.
--=20
Krzysiek
PAMI=C4=98TAJ: WR=C3=93G TE=C5=BB TO CZYTA

