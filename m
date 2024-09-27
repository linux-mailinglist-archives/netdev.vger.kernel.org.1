Return-Path: <netdev+bounces-130141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B8988907
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBDA1C20AEC
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88D17166E;
	Fri, 27 Sep 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kVlMyhzD"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD252B9B5;
	Fri, 27 Sep 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454304; cv=none; b=txj6JDNyUloB0Qu8fmS5t2d01S/n2QZNed+8V+kyG6G1Ea2hLf5ivWL5PGjlLY579v19r6NlrJC35/uo/JafzPZQIl3CWwc9oPjP9m5RKoZ+21+o6DgiVHyOFcGgWxVvK3xoeuCVfvtfRiDasw05NnnwYeuzuKGvjtSTmNxd7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454304; c=relaxed/simple;
	bh=uHV78x04NiotWc7oMLtEikHJ+iec588lfT3Fa7lR8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTa3quLZerjAT5paaJgVx97lXLh3QyoaY9lcjDuSLNFwHWIoeKBbC2fwu1Hgi+eXBDD78MCFQqIAPEfIvigYZ4CXHzHp4XagAqRplL3MODLEkR63368CpcaxDB4vIoZ84rCFTEKv9a1e8JhNlyEFh+G7K+gaakHpo5AWfmtR0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kVlMyhzD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97D2920008;
	Fri, 27 Sep 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727454294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/awAcCMMa99o4Y4kUEvD11vhsBuYYvwpwMnsRHMj5I=;
	b=kVlMyhzDJwScPYvoFwNOlJTrlHD9Oh3KxSbS9Cevg0irT5MI7h/MP6yDePvC24iYgmifR3
	/d9Hh+huHUo00PDjsEZsP04CXk4LTPViva/2bWAkpcjzS4caUdDj6ZaebSdLl1q3lXv0o9
	V9fg1kEG4P9/wo62A98b2Pyrz7xcRpK9T6kEMtSnxi4az+IG4kxjZkeoQrlUBAe53b55Kr
	trcnkkyMsueOBIxu5ESYgukxPEGW3bIlMWX2so8kVlTQLXT6anLdouTMzqXEBmYnBWik2k
	dIxnAew+Xkwrc5tBeeZ2pYguKAkCzAeY6kwDIfQa8ven16aUPyyY75u2aM1imQ==
Date: Fri, 27 Sep 2024 18:24:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v4 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
Message-ID: <20240927182451.2927c944@fedora.home>
In-Reply-To: <20240927010553.3557571-2-quic_abchauha@quicinc.com>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
	<20240927010553.3557571-2-quic_abchauha@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 26 Sep 2024 18:05:52 -0700
Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:

> AQR115c reports incorrect PMA capabilities which includes
> 10G/5G and also incorrectly disables capabilities like autoneg
> and 10Mbps support.
> 
> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
> with autonegotiation.
> 
> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for the changes,

Maxime

