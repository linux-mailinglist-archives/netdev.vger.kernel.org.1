Return-Path: <netdev+bounces-183525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF3A90EB3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD51E189B3E6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6B23A98C;
	Wed, 16 Apr 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/X2YL40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11E18D63E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843082; cv=none; b=HNCUf7zQrZ7vyYt6cIO3HmI513cc90UAYlZqwkzZ18+eG+doBsypnIqBEKEmxc4cAR0nBaM/SYhVUpxgR3LHEG8Zb8e24gQ+6FbioPz4cB2HjceEdfd+6hJhfGU73s2mkI3229uuItrE9M7wS/NJKakZIumzh+l7p6hp5/08qiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843082; c=relaxed/simple;
	bh=ZbunFVDc+z4ZNinhUozXF0DHGNkTGheh1l4/+ElGHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umnxJ4w65uFd1yc0TDGoqN41Cl3kS9ge2qstSlhw0EYITXAa4NH8nQ6BAcph6CLm6m0HFKFLMv7giLwuZB0yY4eP7NgruBCJZIGwvLiEYad5Blq3Z3YE1dPVV6jc/bLj4Z6a+P1K1gEoBA8eJ/3UQ3uvr79DZ5Gc2ChwNY4yxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/X2YL40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B09C4CEE2;
	Wed, 16 Apr 2025 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744843080;
	bh=ZbunFVDc+z4ZNinhUozXF0DHGNkTGheh1l4/+ElGHqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E/X2YL400qWMrxAg+hIq73VEMNHFiId2k2Opfic6Sq38awI1C2UzakpJejoi72Ix6
	 bLSj5m8BuF5SxVEnOcnB6EM1hmbL1KzxtBeLHUmEWg6kFnmaYj4L7ydrYFjlDwqJir
	 /IgqZ9KKrjFfb1vrZ8Y4ohZOfi9c0qwfTGAy8cBVZF9o6HSLSYZkJ+xfi3b0cyW8Ou
	 4Vwm2ZdCDo0FaBPpD917lz+B1Heb42XfFHn5C6cRh1QApEvajKczPAiK2VDTORg2Qq
	 KSXXUZEucpeut6mJS3Hh47LpSOF0TZrd+x72bTh343o5ORvUZJ1saIzQTzpaFSk412
	 LtJEDJgeWlsNA==
Date: Wed, 16 Apr 2025 15:37:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <20250416153758.3f0b7dfc@kernel.org>
In-Reply-To: <Z__w52jL05YbqSTW@shell.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
	<E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
	<20250414174342.67fe4b1d@kernel.org>
	<Z_4s5DmCPKB8SUJv@shell.armlinux.org.uk>
	<Z__w52jL05YbqSTW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 19:03:19 +0100 Russell King (Oracle) wrote:
> "This change will have the side effect of printing link messages to
> the kernel log, even though the physical link hasn't changed state.
> This matches the carrier state."

So I did misunderstand. I thought we lose physical link. This paragraph
looks good, then, it'd correct my guess.

