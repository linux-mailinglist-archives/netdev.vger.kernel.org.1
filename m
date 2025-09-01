Return-Path: <netdev+bounces-218908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413ECB3F01A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC741A8731B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769E2737F9;
	Mon,  1 Sep 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teZiw9GF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E9272E71
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759904; cv=none; b=u5GFR6CUt34ads4fTsXBLAh8qCIX+Euf33YL1W/8WKkrvrp0Om6h2jM+h8bObD+djjBgHaevNsbNJ4iKiN8Gm9CeWFDm1YYC5uPj1wONNtwy43MY4Gz9D3QtOPxYh1qm9kQf9w3ODQiZqIh15l/KB44LJqHhUhoDzgsRpGvBkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759904; c=relaxed/simple;
	bh=P/4QopT/bUOiBjEuFQxgQJzZP8IzYmRJPTJaTvsjiG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUSkNGkWcDJEcUjRL/USi3J96UfdlX3/W2Y8TUD0wTonavn8S2t11KApT6PFY4KZ9FikwmAn5yUpKbW6N0OruE0Eyre4sFQZ8tZG/tuL1id+uD37QhAa57vUGW69+xt7wWIfDSglw4J1m9R3HiT1t+Dl8z0QiF94Mt42Mbu3qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teZiw9GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC5C4CEF0;
	Mon,  1 Sep 2025 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759903;
	bh=P/4QopT/bUOiBjEuFQxgQJzZP8IzYmRJPTJaTvsjiG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=teZiw9GFOPzZwecXwOEycccWlvIMQg2+x9F2LEnPbW1sw1b4NayV/h4W2tC2EDJvA
	 v+TrDcj2Md+bjKJFOCNb55KO1Qars4JPRfv4oYM331H/qP+OjprSLvlSv+Bj+jgbY+
	 Flx20uOhE/oaP9itulTfPV8gW7AJDUMQWc34DumulRVy6F5yNJS/R9m9m8M86RsVxG
	 1Cy/Z/VVjm0PYc8VWKIYNR3+QSUCWuAGBKckfo0ihCkuC6HQNYN903qLk5u6o/nNMN
	 2V55J7HEiYCvMxVFELPrMaMF7l6Gpsy3RbjHVfkt2bPQIb+LVmlt9uWwyH6F73KI+e
	 DFfmgW2D9Dv0A==
Date: Mon, 1 Sep 2025 13:51:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 2/2] net: wangxun: add RSS reta and rxfh
 fields support
Message-ID: <20250901135142.174698ef@kernel.org>
In-Reply-To: <20250829091752.24436-3-jiawenwu@trustnetic.com>
References: <20250829091752.24436-1-jiawenwu@trustnetic.com>
	<20250829091752.24436-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 17:17:52 +0800 Jiawen Wu wrote:
> +		u32 max_queues = min_t(u32, wx->num_rx_queues,
> +				       WX_RSS_INDIR_TBL_MAX);
> +
> +		/*Allow at least 2 queues w/ SR-IOV.*/
> +		if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> +		    max_queues < 2)
> +			max_queues = 2;
> +
> +		/* Verify user input. */
> +		for (i = 0; i < reta_entries; i++)
> +			if (rxfh->indir[i] >= max_queues)
> +				return -EINVAL;

This looks suspicious, if you report the right number of rings from
GRXRINGS the core will do the check for you.
-- 
pw-bot: cr

