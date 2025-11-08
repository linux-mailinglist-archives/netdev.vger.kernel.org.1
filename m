Return-Path: <netdev+bounces-236936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC63C42515
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 03:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383173BC1B2
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 02:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084252BD5A1;
	Sat,  8 Nov 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkObT6VY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836727702E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569663; cv=none; b=Mk3/SptckMh+zoF7L1++03DZ3/dak7YbdiwNY6AgqDZhabHrVelwGZpz+FWChwN5gR3pVgofw0MxrZFpJNTwvrqGlruAY2iqjfusFxS1umMzZVx6ebfkRiIYy+jZ1PicKXAcDGWXBGuf8OtYK887flVhygFxnmbAMBbNXrfNzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569663; c=relaxed/simple;
	bh=xVXlkI1ZGtDrbiL92CZlbKPAXXpGnUe237tMarden+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdBF3aWCIQvIkPwIH5Wuf/IiNsP2YzBfxniPgClZQcy3s9KoSWA5v9qeBTJNNX8R/GQRDq8eLFnFydO0kpeSYeg5bdkSbP5TRmZ5vDiDyCujmK0r5Tr1jYe1bEALM+uo7fqhkI4VgBUGkc7YeYrlPIH/x/nh5ZYizscecE/hKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkObT6VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E5C4AF09;
	Sat,  8 Nov 2025 02:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762569663;
	bh=xVXlkI1ZGtDrbiL92CZlbKPAXXpGnUe237tMarden+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkObT6VY2uQPNyl7BIzQnlX013AZ28B1Umc9mgu6Fx4HdDrfTDLDS0gtNuzQRdVWw
	 Lzl8JZoUJ6bh/4KSlLQftuURCbDGxH41sFd6m/bi/WrQuIxluqodfuVcPZuOGYpWbm
	 UlZCWoh5BgHXJMZOr4RyzQGvqu6MmfEMQDWTPf4KsnI0wiRECJruTk/i1QsQrebZF7
	 dJ7j5YnN6gQ6rv86Wg7Y8+8FzqvwPnZfNLv1YGUmv1gzcoiFTzeW/d5OsmWCicMNK6
	 PTbz+rjrTpfFA9YAqNsQYXkvlvmvf2cImBdqk0Ij88H9sumvHZERlOejtxbT8dp8ib
	 gB21KWHEjXE+Q==
Date: Fri, 7 Nov 2025 18:41:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Jacob
 Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251107184102.65b0f765@kernel.org>
In-Reply-To: <20251106213717.3543174-2-vadim.fedorenko@linux.dev>
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
	<20251106213717.3543174-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 21:37:16 +0000 Vadim Fedorenko wrote:
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +	case HWTSTAMP_TX_ONESTEP_P2P:
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "One-step timestamping is not supported");
> +		return -ERANGE;
> +	default:
> +		break;
> +	}

This is the wrong way around, if someone adds a new value unsupported
by the driver it will pass. We should be listing the supported types
and

	default:
		...ERR_MSG..
		return -ERANGE;
	}
-- 
pw-bot: cr

