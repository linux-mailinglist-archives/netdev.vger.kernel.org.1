Return-Path: <netdev+bounces-136139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8529A0856
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BEB2862E8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D42076B0;
	Wed, 16 Oct 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hRSKj3GZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0D206979;
	Wed, 16 Oct 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078164; cv=none; b=e2/W7X0K3uzfhnjxHV/dP38MlLGiTRVF7KfwkX1JShKpAiZaprPpstlk7VigH6Rt5vvspvQzv9nER30rXU6fMDZDiG5MrWUWstlfF4p+lUrAua1l3i3eLXov5tM/Quet/aMUCLFJZx0WHyhmZmWrz2OLsOjLWQMX9QjB0pMSTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078164; c=relaxed/simple;
	bh=y6ZDYA1TMnw5U6d4CgN0a9uwlx1F1lxuVUqye49x2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz7W/VvakIxOknHgFCobCZdz5vNGNLHljTT3pITqTWLHO3i8tG+bJOtvS3pSKE7BDW6OnLyzodo6TyGOVYgklRdE7hHjz7gDnBLDuQoQpED7qLh5yoQJZkPKpiOJDgPP6iYm9c1Iq7fyKZH5mBDcjXyI+EVnY/Iuty/hmBcmLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hRSKj3GZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 017EC1C0006;
	Wed, 16 Oct 2024 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729078155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Wz6Rm09mHHsl0GIGJtrUDRtUhKh2IZ86Po6DQwPXtQ=;
	b=hRSKj3GZv2l6RkHFiWMpgdCxFdVHa/+8rDQIJVykjltH1WZ7FCy5uEKNSYfn+20HwCegaD
	CCKLPpkQ3klUkPA77AlxKP8sTYYZWZ/ud8d8u9MhCdx6jdmk2jmUGikzDNwCcUwh1ekkE8
	CzDfrwKqTcHdQ6+mh3hIBt0+RFD4qT6pHbIvIIOyB8H6KoSy/iwb7nJkG3Yxvv3SacmaVz
	4ujVUoXk0zSLikW942JqJiz2Qlj9a/EH/3N7HhTAk8Vcd5g+d4x+pv4HWTdoD4nv9wauAn
	S/dqQIWt7D1ocaGHy7Ul6ucbBx5QhBQiOAkpDgsbbFLupKujRowIsOk2GQBpKQ==
Date: Wed, 16 Oct 2024 13:29:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Waibel Georg
 <Georg.Waibel@wiedemann-group.com>, Appelt Andreas
 <Andreas.Appelt@wiedemann-group.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: net: phy: dp83822: Fix reset pin definitions
Message-ID: <20241016132911.0865f8bb@fedora.home>
In-Reply-To: <AS1P250MB060858238D6D869D2E063282A9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB060858238D6D869D2E063282A9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
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

Hi,

On Wed, 16 Oct 2024 09:56:34 +0000
Michel Alex <Alex.Michel@wiedemann-group.com> wrote:

> The SW_RESET definition was incorrectly assigned to bit 14, which is the
> Digital Restart bit according to the datasheet. This commit corrects
> SW_RESET to bit 15 and assigns DIG_RESTART to bit 14 as per the
> datasheet specifications.
> 
> The SW_RESET define is only used in the phy_reset function, which fully
> re-initializes the PHY after the reset is performed. The change in the
> bit definitions should not have any negative impact on the functionality
> of the PHY.
> 
> Cc: mailto:stable@vger.kernel.org
> Signed-off-by: Alex Michel <mailto:alex.michel@wiedemann-group.com>

Thanks for the patch ! When submitting a patch for inclusion through
the net subsystem, you need to format your patch so that you indicate
whether the patch is aimed towards net-next (new features) or net
(bugfixes). More information can be found here :

https://www.kernel.org/doc/Documentation/process/maintainer-netdev.rst

You can use the --subject-prefix="PATCH net" option to git format-patch
when generating the patch.

It seems to me that this is indeed a bug, which has been reported
before :

https://lore.kernel.org/netdev/CAHvQdo2yzJC89K74c_CZFjPydDQ5i22w36XPR5tKVv_W8a2vcg@mail.gmail.com/

You would therefore need a Fixes tag pinpointing the commit that
introduced the issue :

Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")

I don't have a board with that PHY to test it, it seems that issue of
the wrong bit being set during reset was introduced when Fiber support
for this PHY was added, it's unclear if the change was on purpose or
not and if changing this would break the boards that relies on straps
to detect that they are using Fiber :/

Best regards,

Maxime


