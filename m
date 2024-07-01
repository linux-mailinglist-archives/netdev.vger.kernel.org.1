Return-Path: <netdev+bounces-108162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF491E088
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CACB265FE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F9153BDE;
	Mon,  1 Jul 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3i6++WB"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959413B597;
	Mon,  1 Jul 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840199; cv=none; b=JeWOzoOQWR5JbQQYeqt3Mqfh269k/edVmognSrLI1cDcZTwUm83TZsztGjWXy9p2wdPo8u37JcM6o4h9x9l3Jy7ERojXwa/BdU5Fe+C3dKG3UQajQD5J6j/BMQcDDLV3s0nmMal2B2lH0GcAKn0rin4FF/NpvvT7X9N+5ndfXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840199; c=relaxed/simple;
	bh=k/aNFr2V+t4EIgNHmxBAUmytNN3FV9Xi0cJmr8p+FAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJjarBzMQZDNZlA0VaiKh9LNrU6tDJBtXicb/B0ZqdaUDi6aPfJPE5lnAXgodKP8G+dALjXRBOTpgcJVurOKktHYCDQ1CUwaoJ8LOCcrMLh7XSde0T9RCSoJlBzwo2aOq0NuxhMzxfejA4orFALreCw4CYn/Ty2hMe6sx32PZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3i6++WB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B61640002;
	Mon,  1 Jul 2024 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719840196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kWWWbC2x2ItJ9G8/unlsi6K5UG6ftjMXI7ISqzusJc=;
	b=Q3i6++WBEfADMOdjqk/CEzc/CriDRK+cfhPq7V4WfPbraGYYojzo4SojSKMhpSXF1dM0i+
	13zFtaSKdLK0PhEtLTMym3/N6b8yd6cxjORy8com+S1ApTKpE/ylcgv/dtJa19HdgpXO92
	q51DjJ0cawSp6yaOWyn650XFQHVe7NDacGDsCUu4zsxFhp+dpnUj5mCQp/KVb2sKrCdiY2
	N9fD0t6wMDs9BlUayrrVtAk8H9bMlDn/exf7zZ2P6wuJxTR8vkoZzQcSa7iF+NXR2lgApN
	HkOfEMd1eGfOuNaSRUWbkVVvZzzm4W8xO7iEzfRc4/pXQGFbCoQpUwalyIzK8Q==
Date: Mon, 1 Jul 2024 15:23:13 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v13 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240701152313.65d5c6b0@fedora-5.home>
In-Reply-To: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

On Mon,  1 Jul 2024 15:17:46 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello everyone,
> 
> This is V14 on the phy_link_topology series

	[PATCH net-next v13 00/13] Introduce PHY listing and link_topology tracking

(small typo in the cover-letter subject, this is indeed V14)

Maxime

