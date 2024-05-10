Return-Path: <netdev+bounces-95458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7F8C24DE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A344A1C21AC7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33512AAE9;
	Fri, 10 May 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMv8z6SJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521F487BC;
	Fri, 10 May 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344174; cv=none; b=OffNrJEfCIbS1sudWCfwh1Wq0jkJC7vtYsN1KUzVrd4G6rE1rlkkYO5Tmdf2Jox559GXImw2nh0uGpngL9H9lLeywRm3ilt/gz9gr0qmitFIa9kkz67jJz/F9PXdJHroKvlQ3cYoZP5AjTwm/rqqu9jVnfYyf25w0GEsGS3/xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344174; c=relaxed/simple;
	bh=KLTEQaQm0FiKrFX+yiOF9TjuFZuP1CHAkj/bzBphg3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVzDGq8/dF4oaFkzthWiAneEn2SP8UZ5edGoo4of34hvoEynFEuhLwsWquiMnjFgsFpAcRzPUNdPeMPEUoHt/Z3mjgLDnLJ0IV44zZdemQb8cfuLmi6rAWQDt9eqWb5QhNAlTj5KytVDRJrmTgvGzdWvP2A5Vql+gEFPzBZxJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMv8z6SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D53C113CC;
	Fri, 10 May 2024 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344174;
	bh=KLTEQaQm0FiKrFX+yiOF9TjuFZuP1CHAkj/bzBphg3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMv8z6SJgjOkYO8F9OmlDJc1OX4Dw5sMcTwrp3qrJanEAm/UX1rAcrxLFwfNqgmpe
	 /PU0QXrxfVoVPBdfZtCdM7hNA2mrscGvYlNjz+rGtb3UflMUsDV7gQf7ZSj6t+Y0zO
	 1tUWYEW4lmf3Ou1nPm1/+sXXklEKH5URkSc9iPsp7sdFU39ggWDZBLXd+U54iCSZ0T
	 RIJXeJFaJWCGJixm99vjbFAI7GFg10MRVv7AqJtG3zFkhB3vvX2ie8P+2BhXQJM8UJ
	 BuAlyCfrOyqgNYHZ6wWS8+ZE0wyKNb3odRDQQCwpR9nN1NPcfCKnY8OhbCT0SG8SyO
	 F3MgcnXQ/EWSQ==
Date: Fri, 10 May 2024 13:29:27 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v3 2/3] net: dsa: microchip: dcb: add comments
 for DSCP related functions
Message-ID: <20240510122927.GW2347895@kernel.org>
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
 <20240510053828.2412516-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510053828.2412516-3-o.rempel@pengutronix.de>

On Fri, May 10, 2024 at 07:38:27AM +0200, Oleksij Rempel wrote:
> All other functions are commented. Add missing comments to following
> functions:
> ksz_set_global_dscp_entry()
> ksz_port_add_dscp_prio()
> ksz_port_del_dscp_prio()
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Thanks,

I really appreciate attention to this detail.

Reviewed-by: Simon Horman <horms@kernel.org>


