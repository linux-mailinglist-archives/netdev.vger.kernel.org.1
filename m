Return-Path: <netdev+bounces-157270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B33A09CD5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2806C188B945
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455A2080C7;
	Fri, 10 Jan 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ywgPJBKk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA74206F33;
	Fri, 10 Jan 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543470; cv=none; b=mapiN7RG481m8qr7PzAxkqLlz044k1rO50pb/1qDB1Z+iQ8dR2w304IoE89aB1N2UacKy+MQYA9smOfeQuiac2TeUoXUWQ1/zPUIOsgZuInU8C2ZpAjqsBegmbIqZvSrXsXiPzXmyyLnWwRBjhdVZJq6I0Lo9fDWu6AL6k8oJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543470; c=relaxed/simple;
	bh=nhyefq/M1I5R1C/jhXDtDdnGJ1jbIukA1QzXV8qJRiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFYslEsPR3tTfgGkG4QbuI38nmZaLGK1A/z6f+wI6qDeIs0yoZeNUEfFvqU6BDSMDpVZsA3E8wqtGGqGPF4Ek2F06SDXxdpqJVWp7bF4qnaA+8GkfvWun7XWv2BmMX8SzRfhuZXdaxt76lP52nEAEnfUNtbm5fOV2oMdt03+dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ywgPJBKk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A6gCHdvtOPxKY5f3gOlIBM7+RIbHqchd5puNoKZYZRM=; b=ywgPJBKkc5zJIk5ofNkxqcZkH4
	sBqqdj6xASmrbwNB7aNgGYxpqrlGf6ewpM3IKdK5mMbwpCjFOEOiIerlwSO8Cz7jm2+7lZ9vVlY0o
	yalMj14CMagdpD45XIwxeDikjskz04wG6AdJsYT5BFVHHl5JDUJsXCLGh+flaC0EbooY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWMHR-003Lnm-4b; Fri, 10 Jan 2025 22:10:57 +0100
Date: Fri, 10 Jan 2025 22:10:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>

> - over-temp alarm remains set, even if temperature drops below threshold

> +int rtl822x_hwmon_init(struct phy_device *phydev)
> +{
> +	struct device *hwdev, *dev = &phydev->mdio.dev;
> +	const char *name;
> +
> +	/* Ensure over-temp alarm is reset. */
> +	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);

So it is possible to clear the alarm.

I know you wanted to experiment with this some more....

If the alarm is still set, does that prevent the PHY renegotiating the
higher link speed? If you clear the alarm, does that allow it to
renegotiate the higher link speed? Or is a down/up still required?
Does an down/up clear the alarm if the temperature is below the
threshold?

Also, does HWMON support clearing alarms? Writing a 0 to the file? Or
are they supported to self clear on read?

I'm wondering if we are heading towards ABI issues? You have defined:

- over-temp alarm remains set, even if temperature drops below threshold

so that kind of eliminates the possibility of implementing self
clearing any time in the future. Explicit clearing via a write is
probably O.K, because the user needs to take an explicit action.  Are
there other ABI issues i have not thought about.

	Andrew

