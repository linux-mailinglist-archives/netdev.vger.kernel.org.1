Return-Path: <netdev+bounces-148764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D69E315B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31533B2476E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B95224FA;
	Wed,  4 Dec 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz+Vs3oL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A931F95E;
	Wed,  4 Dec 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278985; cv=none; b=q4ZyebWdFJ6TL/EZpPD+U0Hdhn/H1wCfsoRzVjj0+ReKzbImz+Lo+1CMNUA5AaPaZlqvmoCsoPIaFnMR4slXpceCorwqnyrsBIZlGqWXFeqCPyNuQT4XCY/V4atrv1FFvbciKsJBiMQE3bFijwvagunWFqUwDoTOVs+5JXEw5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278985; c=relaxed/simple;
	bh=p+M8K4aXqk7J59dm+ld5lfN8hCyYmxDFRO8GjeZyb5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGNfUthYUU1GwAxMNzvgLOU+d7PwfzugqMQ9zVPacnbUxCJFQVH2xWJrctmuslXpZwQ3URR/bf8KWyn8C850t8UBLpu7pO8VJiuYyTldS5hPJRdIo7NlZo//fi+TN8iKoWG8FoVpT7hOz5G16WEq93FNeQCO94rqm/Gh0NUQSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz+Vs3oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92799C4CEDC;
	Wed,  4 Dec 2024 02:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278985;
	bh=p+M8K4aXqk7J59dm+ld5lfN8hCyYmxDFRO8GjeZyb5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cz+Vs3oLAJClXacGy34IfxMFxXdX95slK/kxIrjCJi5dJNtlce/Fz3SDZzPjdifyG
	 aLn6ns2KImwJu8KDXMyAad2TpgNDGQcpeACxvKjZuPLrbfZnVdMu8zyigfVa+YMzyJ
	 FypAH5jq7ZWcpNL1hFxQrwreWE48z7QKNje2q3+DBvABaORdhmgyx2V4oi6s+wA6WF
	 Kcg73jlxqCDChbtDmiWCrdzcLACQzs5njKPHqAv7jJVOGKRCNNrOj7rtO9IHYGHlCP
	 XD4Ta6Hwk330xaA8Y3rNu9nUSdZfpJIyzrDHr/gi/xafwIkUZV7eK2DWiwLpwl0DYx
	 VeTG1ZKllWs/A==
Date: Tue, 3 Dec 2024 18:23:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Satananda Burla <sburla@marvell.com>, Abhijit Ayarekar
 <aayarekar@marvell.com>
Subject: Re: [PATCH net v1 1/4] octeon_ep: fix race conditions in
 ndo_get_stats64
Message-ID: <20241203182303.0550b547@kernel.org>
In-Reply-To: <20241203072130.2316913-2-srasheed@marvell.com>
References: <20241203072130.2316913-1-srasheed@marvell.com>
	<20241203072130.2316913-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 23:21:27 -0800 Shinas Rasheed wrote:
> +	clear_bit(OCTEP_DEV_STATE_OPEN, &oct->state);
> +	/* Make sure device state open is cleared so that no more
> +	 * stats fetch can happen intermittently
> +	 */
> +	smp_mb__after_atomic();
> +	while (octep_drv_busy(oct))
> +		msleep(20);

This is a poor re-implementation of a lock.
We have more lock types in Linux than I care to count now.
Please just use the right one. Hint, it's probably a spin lock or
RCU+synchronize_net() on close.
-- 
pw-bot: cr

