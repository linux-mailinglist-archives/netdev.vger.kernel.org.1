Return-Path: <netdev+bounces-109126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD1927130
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF7BB22033
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451E1A38DD;
	Thu,  4 Jul 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XPmoLHHN"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032C18637;
	Thu,  4 Jul 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080299; cv=none; b=nniIrv4sHOalj7KNrXkZTwuDHm3AILcmohgnBPtGLJvemNTD+7QP0gryTp+61AQ8qM0swyi8LcJyN24RUTHKDwzxozHS+MAEWX/DqUAWYO69J1yqgCwac3NvtHF1xOTL60uOEG9kDiASHemEgYb5kkzOv48xHniNf18yZatzm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080299; c=relaxed/simple;
	bh=PBoisISGLknAlq0wKrfsyN9ceoRghcEUzBB6UHhN16c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTKJiKK2Z5T8vXlXrJeYeHb1K5b7zckNBETuYtmWlTsi0iVJ4ouehQVBzd+kN97vTpIkqEehlGDghJxvUVsBLDfwdtJaERb6jR2H5ovX/J9SHocE+mY2Av3YWRHEpvl+8VH7X8zfQTMu3apAuFwsxNaNKKJ2nxr3Z9297D1rVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XPmoLHHN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 711C0E0007;
	Thu,  4 Jul 2024 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2Dd+Vi+ygaeHfugpUqHHdz5n+PugnuRjKyRb3baBns=;
	b=XPmoLHHN0tJQLVIPOtg1MytcKIp5T1fpADEqDfSZOLEYa2kQzbEgevd0sIF/0YMKjlV+0r
	BpygXMaRmo063x+xCd4j5VKWWoxQA4HPf3LVMnDx4AcXaz1heMAPXe2/+NqENHQWkjxstm
	Olwb1Od51q7UKZ+0p9H+60E/LzDhgee1MquerNPBO7D1JE5f6Eivl6R9kP4mQCgt2lWX0E
	wKWpgI4s7ZhVnfQkLw/R0ISsHHuLOP9xxZMPsNwsieuqUZawwe5ZsopgxGpZFP+X1t01tv
	mAZw7Is6oIhclSZ5FCza5xuwKRAeRcQi0sqMlUn5YZK8sVq8Edzhd9cmrXom4Q==
Date: Thu, 4 Jul 2024 10:04:50 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next v15 04/14] net: sfp: Add helper to return the
 SFP bus name
Message-ID: <20240704100450.67182233@fedora-2.home>
In-Reply-To: <ZoVv9OJl0Cu67q1E@shell.armlinux.org.uk>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
	<20240703140806.271938-5-maxime.chevallier@bootlin.com>
	<ZoVv9OJl0Cu67q1E@shell.armlinux.org.uk>
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

Hello Russell,

On Wed, 3 Jul 2024 16:36:20 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Jul 03, 2024 at 04:07:54PM +0200, Maxime Chevallier wrote:
> > Knowing the bus name is helpful when we want to expose the link topology
> > to userspace, add a helper to return the SFP bus name.  
> 
> I think it's worth mentioning about the use case in this patch as well,
> something like:
> 
> "This call will always be made while holding the RTNL which ensures
> that the SFP driver won't unbind from the device. The returned pointer
> to the bus name will only be used while RTNL is held."

I'll add that in both the commit log and the documentation for the
function.

[...]

> > +EXPORT_SYMBOL_GPL(sfp_get_name);  
> 
> Please move this to just below sfp_bus_del_upstream() since the
> functions in this file are organised as:
> 
> - internal functions
> - upstream callable functions
> - downstream (sfp driver) callable functions.
> 
> Note also that the upstream callable functions are all documented with
> kerneldoc, and sfp_get_name() is clearly a function called from the
> upstream side.

No problem, I'll move it and a some proper documentation. Thanks for
the review,

Maxime


