Return-Path: <netdev+bounces-122546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C04961A87
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B8284D67
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D11D31B7;
	Tue, 27 Aug 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlJ9C+rH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7313A258;
	Tue, 27 Aug 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801012; cv=none; b=nHSWwmVbGod+xQt3m+a4ub/929rFt91gZ8V0OI1HuDIRL9XBGPQhB8kZA9x9jBNxVeuo9AOBNJ1eVd5sOB+NeQnxRrtgi5+u2d6TSmBQWZNO/sEaHdYdhoSiyJMA2PKq1YkcM2xsHs/ZAXL8YAWbI4PLHJNThWhuJm1ffGNmPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801012; c=relaxed/simple;
	bh=NCuElr/6XZ1cF605mSXv9U8uJpxklOTAhz3RY1+N1SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3b1dG52NDs3EZb/xcGkkFd9dgOTHxCw97w4SjUjZgFWtZI6ZMdjDCP9cPmspGSz/Q9vX84EnqJhoyBiiRHbD4jZNeHJj1MGATefyClSUGXMMwM8tDfso51yt/85gVzRgFmd6NwTV6+UIVu0WNpS373vlYwPJw5GosUbB2kkB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlJ9C+rH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C810AC4AF63;
	Tue, 27 Aug 2024 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724801011;
	bh=NCuElr/6XZ1cF605mSXv9U8uJpxklOTAhz3RY1+N1SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlJ9C+rHkcZIrpFtONoiD1ZC86yC1lOoNXuaRrb1/tVcctGbsDvsopkGjeYU5a4ym
	 EBBtQTVI0U+L935jIMA+FfZe0MLmmFCRUETN25UCa/GEizN/KIVzdDhsB9nsBRpz8o
	 Z9S+siUsWWF1rOuaY5nlEBBWWw/1G7kZh/sHQRBohC1z2MtRcW+SOgwLYdTfrZuRFN
	 W6ItxJmr8jbcy8wyZO+LjCvjsxPKPsmLkmocrGj+AymFbgU9VnXJmQle2veDk6XUku
	 zleO4v8u6Jts3KdAz6PDwx2fBIMcxmjGfPf33kLONd4dkidfGNM/GcA4pOlqC41biR
	 nYD7Qmnj3Ikvg==
Date: Tue, 27 Aug 2024 16:23:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, jlu@pengutronix.de
Subject: Re: Initial Thoughts on OSI Level 1 Diagnostic for 10BaseT1L
 Interface
Message-ID: <20240827162329.636fe3af@kernel.org>
In-Reply-To: <Zs1gk3gfU7EAPmPc@pengutronix.de>
References: <Zs1gk3gfU7EAPmPc@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 07:13:55 +0200 Oleksij Rempel wrote:
> I'd like to share my initial thoughts on how to approach network OSI
> Layer 1 diagnostics for projects using the 10BaseT1L interface. I
> believe this concept could be made more generic and eventually included
> in the kernel documentation. The aim is to help developers like myself
> prioritize tasks more effectively.
> 
> The primary focus of this concept is on embedded systems where human
> interaction isn't feasible, meaning all interfaces should be
> machine-readable. For instance, a flight-recorder application could
> gather as much diagnostic data as possible for later analysis.

Having an open source form of that would be great. Most large operators
probably end up building their own triaging and failure classification
tools.

> At this point, the concept is targeting existing diagnostic interfaces,
> but it may also highlight the need for new ones.

Can't comment on T1L specifics myself but +1 for adding such guides
under Documentation/.

