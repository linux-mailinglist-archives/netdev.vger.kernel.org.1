Return-Path: <netdev+bounces-234695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284CC26102
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 679CF341947
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F1219A7A;
	Fri, 31 Oct 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TsoSUOoI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EB25334B;
	Fri, 31 Oct 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927360; cv=none; b=WS+aGBcZpCOkNEB18HOWbmaBVo8WAygWYAN5UEV0XrC9A5gNKsnT5yTy34kkbbd9jBx8bJON6vhExBSbeuBIpeofjBa6jJe+DcctWAJVhXjXZ9U0fm4YqLr3+YemW2dYjEYOeYiy7SrMnX1el6NFoeYtPNJ4DAm52UA7rfUSgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927360; c=relaxed/simple;
	bh=006TMgvcwfIbmOITyVS1NTTJwmxmkCoDyHD8bCI13pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyQAFSHq6qN2npAKDDMPa0hRm88ToKc5kt7n5UmeOmYR4b2MsLMHtt1eSLQsBOyi0dgnl5XewVyFa6MSU+SxVq7oETIbeLAO5V3z7+fWyT+RQtF7ekKoluir7VRAnP2O0KbWsMMHC+aTAgWP6KVW+6GNO59G23NtEWZq4smc8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TsoSUOoI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GZ1we4raHwUnUtjU8hy3mle/N+CwqLuNQ45wdAbVLNk=; b=TsoSUOoIsv2yrwHS7xiSEVNSNT
	t+XUvWmL0xM1TiQOM68kY9+J9+/wLYoM0yNKlGLkH4f1weu2Ab8t6SRmiGPOuGynt1dyumSuApiJy
	YsU3OctViL4sKkcM8DiJ+HkifHPSOW54uCpi35RnxH7Tb0P3IRkP3/r/dlHjP2K4uBsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vErn4-00Cc4o-CP; Fri, 31 Oct 2025 17:15:50 +0100
Date: Fri, 31 Oct 2025 17:15:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: altera-tse: Read core revision before
 registering netdev
Message-ID: <b72e0572-6000-478a-b125-93f079944ace@lunn.ch>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
 <20251030102418.114518-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030102418.114518-3-maxime.chevallier@bootlin.com>

On Thu, Oct 30, 2025 at 11:24:15AM +0100, Maxime Chevallier wrote:
> The core revision is used in .ndo_open(), so we have to populate it
> before regstering the netdev.

All that open does is:

	if ((priv->revision < 0xd00) || (priv->revision > 0xe00))
		netdev_warn(dev, "TSE revision %x\n", priv->revision);

So i agree this does not need a Fixes: tag.

But i do wounder why this is in open. The revision has already been
printed once in probe. Are values < 0xd00 or > 0xe00 significant? Is
this left over code and some actions that were previously here are now
gone?

Maybe a better fix is to remove this, and make revision local in
probe?

      Andrew

