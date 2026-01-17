Return-Path: <netdev+bounces-250718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF84D38FF5
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9323019E33
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4A218592;
	Sat, 17 Jan 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiCzOMet"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5635959;
	Sat, 17 Jan 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669596; cv=none; b=WUKz+KJ5F78sgiiqbSvaomxw+Tf8TVZGxiqzkPlsR0uSmcP7HVSiyTOhp4tsXPjnsR3NUfTfMxWh2CT5pAROG9urCEFSaXbVlAVFPXGVWKbQQF7nsIgewziTJHbRu7VDQuQ6tlzSQurB2lN1ESOGjl+eLLIb9UgW677fJZK2WCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669596; c=relaxed/simple;
	bh=l0dshTY8GU6EMJ8gcGBz/7Rc6DIMcfI+pdpD3/t/BlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOHJwvmApeiLrbM7hOunuj5jioWOV3v8zn+vepTZGc809yGZHI8LDq52vCD1znxDo4QA46m5QP0OaHAU5nhm8E6jMoaIH2X1U11d4wB1Ezl7A+Tf3GqxpuoBo1X1a7vDwlHJu9puQzct21RcSsVU5v/UpaxHgLD/RLSIgQNOLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiCzOMet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD1C4CEF7;
	Sat, 17 Jan 2026 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768669596;
	bh=l0dshTY8GU6EMJ8gcGBz/7Rc6DIMcfI+pdpD3/t/BlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiCzOMet67QTgiBJIyTLZOzf5PmawlbBamAtHhDg4b311fqeMsRgcDwyaT/CX8rHy
	 YxYpsCUbOh9wG024AEtR7bFIBarHszxYwirsVWG/AwMkzx1ndZRJ89l8xUq/GNOMof
	 9rMc0zLzrqyl4Od6h6tzUhRt+VpGYUQNLYqtvQLWo4da3fOQwa8LNrE3uN5ykwa0VS
	 P5n4LK7dWiVFl929g8Wpyqqf5qtbkohfh0aRBk0pAO5YQzDNCjI7G+46EyNwYrfnO5
	 uO83l5OBKpsV55T6rn51MZOWv2RfnyYaV71SR/7BSEduCr2V1B/NTMkAP0KwmDAFID
	 +YfqztHbKRrtw==
Date: Sat, 17 Jan 2026 09:06:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Tao Wang
 <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <20260117090634.26148eb4@kernel.org>
In-Reply-To: <aWqmIRFsHkQKkXF-@shell.armlinux.org.uk>
References: <20260115070853.116260-1-tao03.wang@horizon.auto>
	<aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
	<aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
	<6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
	<51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
	<aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
	<aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
	<aWp-lDunV9URYNRL@shell.armlinux.org.uk>
	<3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
	<aWqP_hhX73x_8Qs1@shell.armlinux.org.uk>
	<aWqmIRFsHkQKkXF-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 20:57:05 +0000 Russell King (Oracle) wrote:
> Thoughts - should the kernel default to having flow control enabled
> or disabled in light of this? Should this feature require explicit
> administrative configuration given the severity of network disruption?

FWIW in DC historically we have seen a few NICs which have tiny buffers
so back-pressuring up to the top of rack switch is helpful. Switches
have more reasonable buffers. That's just NIC Tx pause, switch Rx pause
(from downlink ports, not fabric!). Letting switches generate pause is 
a recipe for.. not having a network. We'd need to figure out why Netgear
does what it does in your case, IMHO.

