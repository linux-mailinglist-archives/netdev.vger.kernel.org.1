Return-Path: <netdev+bounces-202708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83AFAEEBD1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493EE17D502
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C81885B8;
	Tue,  1 Jul 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSIztpto"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA3155333
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332346; cv=none; b=reJtEY+FWrUvuHFItxXhX/4qNjWb2RlnTU9rUmfd418As/Ku/uPqhqr6aQMUuCztNg9G+GwQ1Yvd+u1AzvkIbUP7jUJMrJe2NIx26nSgNRgjNyyw3gc4/nvi/X1L53YaE1PclFNgTNmsRw2np82XpY7JdjLcpUcsjzA8sk+ngao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332346; c=relaxed/simple;
	bh=tY843qin5GxkyAW9Px3Z9B7Lx6BK7vnSrhApbVophis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtxRQAh1AzNZyX7f4OtC+Z3alVU/Nkz2V8smfZbBKn+t3J1QEsUiwMSiV3+ICgCVItTEUUPvI7glZwmM48gozdf6u0kt+YfxRj0Qt9epeVGjKGOGPJMwXCNohwslTEEaQFSltui72idMZKb5+RVg/rxxYlJISuT9qSWNeymmZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSIztpto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B81C4CEE3;
	Tue,  1 Jul 2025 01:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332346;
	bh=tY843qin5GxkyAW9Px3Z9B7Lx6BK7vnSrhApbVophis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSIztpto29p1MTGCowyhydQ+juIKL8QO27b6njCX+GSZkn6hCSPbfhPA9jAS6E7GL
	 tGHNWG2I1t7vIDNLmVUuox+OhWSLPuTOUzb/JwHuv6FQwL/hxSxIznjvyInocirCFm
	 UrzsHYw65PUMtO6dN5CVtLjOJp+UwHjZz7de+Ma2VedMZ5xDrs8wyXkknD89QcG1X3
	 wY6De+bk/CL7kBUqwS71+7W326eKh9tdINTwTG0polQdwgYFiG9UHgnZOGsVs1paii
	 8yaGpGzZarmvwE1Xygb4OMDO95eN+n249CUuK5zRlEbdc8eXY/HsGau+w8Ut2P/ovN
	 1MtTVrLNNwpBg==
Date: Mon, 30 Jun 2025 18:12:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net v2] amd-xgbe: do not double read link status
Message-ID: <20250630181225.38a67e11@kernel.org>
In-Reply-To: <20250625095315.232566-1-Raju.Rangoju@amd.com>
References: <20250625095315.232566-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 15:23:15 +0530 Raju Rangoju wrote:
> The link status is latched low so that momentary link drops
> can be detected. Avoid double-reading the status to identify
> short link interruptions, unless the link was already down.

Took me a minute to understand this. How about:

The link status is latched low so that momentary link drops
can be detected. Always double-reading the status defeats this
design feature. Only double read if link was already down.

> -	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> -	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +	if (!pdata->phy.link) {
> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +		if (reg < 0)
> +			return reg;
> +
> +		if (reg & MDIO_STAT1_LSTATUS)
> +			goto skip_read;
> +	}
>  
> +	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +	if (reg < 0)
> +		return reg;
> +skip_read:
>  	if (pdata->en_rx_adap) {
>  		/* if the link is available and adaptation is done,
>  		 * declare link up

Don't use gotos for normal function control flow :/

	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
	if (reg < 0)
		return reg;
	/* Link status is latched low so that momentary link drops
	 * can be detected. If link was already down read again
	 * to get the latest state.
 	 */
	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
 		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
		if (reg < 0)
			return reg;
	}

	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
-- 
pw-bot: cr

