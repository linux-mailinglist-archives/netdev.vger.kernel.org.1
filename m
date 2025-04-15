Return-Path: <netdev+bounces-182546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69603A890D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAB7A506A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2638DEC;
	Tue, 15 Apr 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt3PGILq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E8EAC6
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677824; cv=none; b=qx4N4/OsKzut8Wts8CP0VegsAUWcsPnzHChruYo3MXZcH6QVRHJU2B9tRunIho136HYO9BWIQYL9oSEJQhi4AmFiOhM719J+KZzGx90aKjovAjV9FNDpw18ZdxxvUn07XzOcvYYoQTpWlwjxldBigNDSUZRpCaTewxLaB1Gdz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677824; c=relaxed/simple;
	bh=4ae4V/iCsu7Dm/UVFu21GxYfPTorOCXdVBpV9LrqHHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rl0/S1Uxt2I6108SBmiZqt8FAMIGSRkWU4dz5F3FzHJNsex79ETUUNppfVAKMFTeW9T4L6/pkIgHGe3weQUyMJr6B5oqi4nmE2RI05Wd5hMCEH523VCsztTNNkWqbe4kGMu+RCEI/NjPNAeqvqhxzBOf/875Snlp+Y11p4bnsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt3PGILq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51250C4CEE2;
	Tue, 15 Apr 2025 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677823;
	bh=4ae4V/iCsu7Dm/UVFu21GxYfPTorOCXdVBpV9LrqHHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yt3PGILq/RNZhYPUlG+8q/pUOPhjI1fV/t/Xmev9/0Pk6iLyytypHcMQmAXS9RkfT
	 pqD29Icaa4wo3UDg8Rw3Sl6W9s3tJCv9U51Vv9oLXSm9jfsROpODvS8ywTxbTUswB5
	 YrvHrqXg2Rb9ToqcEz5XJ/XwNxTPNBKItGNzAVgDObSVSFKlf0/aAWBatzGrRSbvGY
	 Ip9WcR3s72Y0xF4h/xUaVZ4d8Z8QQYphlNqRxPU5bkStf3MUp6ChYJ/vesgIWXuWVb
	 /yCW+eerjUeHPHINLfAdHAoCn0zjQLKt0k/JNjR4iUJpDgWXlEOrcw3XQyMUGJHamJ
	 bwBb60QHiHlhg==
Date: Mon, 14 Apr 2025 17:43:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <20250414174342.67fe4b1d@kernel.org>
In-Reply-To: <E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
	<E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 10:34:42 +0100 Russell King (Oracle) wrote:
> Phylink does not permit drivers to mess with the netif carrier, as
> this will de-synchronise phylink with the MAC driver. Moreover,
> setting and clearing the TE and RE bits via stmmac_mac_set() in this
> path is also wrong as the link may not be up.
> 
> Replace the netif_carrier_on(), netif_carrier_off() and
> stmmac_mac_set() calls with the appropriate phylink_start() and
> phylink_stop() calls, thereby allowing phylink to manage the netif
> carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> methods.
> 
> Note that RE should only be set after the DMA is ready to avoid the
> receive FIFO between the MAC and DMA blocks overflowing, so
> phylink_start() needs to be placed after DMA has been started.

IIUC this will case a link loss when XDP is installed, if not disregard
the reset of the email.

Any idea why it's necessary to mess with the link for XDP changes?
Is there no way to discard all the traffic and let the queues go
idle without dropping the link?

I think we should mention in the commit message that the side effect is
link loss on XDP on / off. I don't know of any other driver which would
need this, stmmac is a real gift..

