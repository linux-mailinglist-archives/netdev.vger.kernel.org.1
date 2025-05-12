Return-Path: <netdev+bounces-189854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F38AB3EDE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D24B7A4A31
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209C296D09;
	Mon, 12 May 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H800bMg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73224BBE1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070523; cv=none; b=a6HPUrK/sIVir6bG1HKeKKz9ygXQeDwa4tj/s5kkdX1pgHeZAJa8oKzT4Th3vifTANwoZFFNFI/PSTp8DyNP6gx3DP+5SQ8im62kLPYKlG9SUD2MpyGs285R/rkwlGeeir7Y+BFyRkPikD8TW6zAks/ncchQh9tnVBV0APDRbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070523; c=relaxed/simple;
	bh=soJO4A4AjQPFXEEm8Vly+9M2b9nOAfW43rupkSUMSm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giMYwL6PgGtztloUWNOfPuPzRG3JOzQVhgy5p4CNBxFoUbS6VytotXj35apGhZ8aBAg61ldHFUaN53eWB5Djm7WF6H/RtE1D2wCWIBmky7illDdx/57gETfP4+DUHjhThybehJ64uTuPY3E9rriMAR26NNfD1FbfOE1eRlxhqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H800bMg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D2DC4CEE7;
	Mon, 12 May 2025 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747070522;
	bh=soJO4A4AjQPFXEEm8Vly+9M2b9nOAfW43rupkSUMSm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H800bMg9hqnv8v4VunViEWyxpF50Txz38vqJV4wqjgqkT2GMc+bvhjjfbDC3MQy6m
	 Km+rrH7e3IAP1TXIkFgg2lhUj8Km6xdpcPjsJJpr8Tb8LQ6RGLKXThqMgr5KG5gBRH
	 nJNNeqd3U9ltFLsSyXfiTUt3vQPR6oDCiVpCORJog11+UHcE8hLnl9UFGvGwkhDSRq
	 F+4HQfrDryePQ7z4LGqJejC5OPcKaJNLayof8ygKBMpPIeOotQt04MepQQRGJVtcsj
	 QoI8bVW24RVdRcmz4R9eCXWwMPffw6ZnG9mxSHshIZBfwVkMNg4jBnBudov/2XHGku
	 a1oJc3O8R/vnw==
Date: Mon, 12 May 2025 10:22:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>,
 Furong Xu <0x1207@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250512102201.01a695c4@kernel.org>
In-Reply-To: <20250512143607.595490-1-vladimir.oltean@nxp.com>
References: <20250512143607.595490-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 17:36:07 +0300 Vladimir Oltean wrote:
> -		netdev_alert(priv->dev, "No support for HW time stamping\n");
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping\n");

coccinelle says:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:594:29-64: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

Feel free to repost without the 24h wait.
-- 
pw-bot: cr

