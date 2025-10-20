Return-Path: <netdev+bounces-231029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A25BF4138
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D9A18C502D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31D2EF67F;
	Mon, 20 Oct 2025 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4WNqzCz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8309238C1F;
	Mon, 20 Oct 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004430; cv=none; b=ZVeJExwePiimRihsFFRPXMIpsPFdWoxiV9uOo3fEjJNkfk4gHHqweRJ3x32O9ujwLxdlSD6/+mMYvxhfX0/YFprPSxkuo28aLMCbn5jIOFLL+GiSWz2bFZclIAz05udLC3LI2Eg69Cwpv5SVGpUKnwb7hLlGzdLGjtMbLY+DL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004430; c=relaxed/simple;
	bh=QnBcUs+LxaiGrX+ZfWPM2gKJapapQgzwF2K0+kBGOq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyvt7OHbEeim5GTlbEbzJ46i2Pi9pS0embZ8G3qCWUUACeNHx+H0W0u8jncqfLAjsQqS/Qbg9i5m9zedLmuyylvmEa+Xt0zKrOV/3VeJuNtSG1va/T57aztiY115SXYE6Nxllo3Yza86LKJdkdxdbL2tp42Fxp50nc+xENL/KlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4WNqzCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D809CC4CEFB;
	Mon, 20 Oct 2025 23:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761004428;
	bh=QnBcUs+LxaiGrX+ZfWPM2gKJapapQgzwF2K0+kBGOq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4WNqzCzcVQZ9GBpnd8DabQwfzn1yNMhqjxHF7RZqmO+RT2xt3ZMPMQM51KhG2fqA
	 qPrUfIrOth1zWV4U28M4g6g0QpkpmduQNeOGR0kr46Gj9JIX8omDa+sNZRqhPMOmQF
	 i61oYOVRAYG74McTgVkWgYPGVoipPSDqG6eDulaX0WdgZw0DxuLmJc1bWDXbd/T3IJ
	 TM6KqDzJw8DqMnpkbPAMf4vkECxDKbRicanGFHpTMqhAD7H3mEqJAQy2XZy3FuWtLC
	 F84FxjAyQCiW7rxeMIiNAve1Hrdshw9sPjEdDuMpZYFPEP4AX9Qph4ykTpQVK00Yie
	 N4qw1G2tF4JYg==
Date: Mon, 20 Oct 2025 16:53:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <andrew@lunn.ch>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
 <vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
 <christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
 <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <20251020165346.276cd17e@kernel.org>
In-Reply-To: <20251017064819.3048793-3-horatiu.vultur@microchip.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
	<20251017064819.3048793-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 08:48:19 +0200 Horatiu Vultur wrote:
> For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
> missing the first part but it makes the second part. Meaning that the
> ptp_clock_register() is never called.
> 
> There is no crash without the first part when enabling PTP but this is
> unexpected because some PHys have PTP functionality exposed by the
> driver and some don't even though they share the same PTP clock PTP.

I'm tempted to queue this to net-next, sounds like a "never worked 
in an obvious way" case.  I'd appreciate a second opinion.. Andrew?

