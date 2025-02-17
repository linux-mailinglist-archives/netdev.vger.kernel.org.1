Return-Path: <netdev+bounces-167059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18082A38A5B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079F81721E4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F32288D3;
	Mon, 17 Feb 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw4oWzjP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA922838F;
	Mon, 17 Feb 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812219; cv=none; b=lV27HHxapPfkCcVsTk/fM+iuL9AFg+lyKPzinr45dtNfxr+5LKfnn557kwHRQ+/SjfCpk/9DCZYZZgz3Xvn+2CBLecwczlo0oSBu6k0LqLKoz0oohtK65fOrWtVxxGBjGC5YhoxxlY7+/GxhPDbYifLqnjuuqx8sjJqaYudrc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812219; c=relaxed/simple;
	bh=S3qwZURE807WhbedRsfGnHG1TDtv+0elSP//hvhcmqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvBucihjx58tAgVLZUeRQrPWSdgTFcNw7nEUwcj34N+YrSqAJBPdwhMYiqpmzMrJ8WjM06FHY5ZwgadepxfR0H1u2Z941aHDJK1ieNdSLYMngO70FkOGaApWH55E7XodNSEo1mvRFtGwIk3/6RIKCT1igk3/0pL2oZq6J6VT+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw4oWzjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B1AC4CEE4;
	Mon, 17 Feb 2025 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739812218;
	bh=S3qwZURE807WhbedRsfGnHG1TDtv+0elSP//hvhcmqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kw4oWzjPYMIxoMeq2VF5x3eyJA5Tx1tDLDBCO18Q6WvyTLaMrhhs7BESiqk+4wGTW
	 wGl4oaKiV9mBMRary8cuaF3RfSpscrTkKJEZM0ypwPHQNTsYUS181g8o2ZUpdcK1Y1
	 UDDKhklp/FTUlczekGqoV3lfBzGg3oFUKp1eEGwJoe7/45Drv8SrYUaj87WcGDwa7w
	 mZELfSI0bL7hHc5W9vzCFUrFpFA/YZGUsfBIQ+vPKqlw7uox44RJ/ko3Rvc7FIaS4b
	 ixMv+iUX4toURTJClKDLMBiMToSjQJ5sNF01bD5bY5S9zIz1RBkJd1VLxqOAtJkhh0
	 PIyKY70qdgc+Q==
Date: Mon, 17 Feb 2025 09:10:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Message-ID: <20250217091017.3779eaf5@kernel.org>
In-Reply-To: <20250217093906.506214-2-wei.fang@nxp.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
	<20250217093906.506214-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 17:38:59 +0800 Wei Fang wrote:
> +	while (count--) {
>  		tx_swbd = &tx_ring->tx_swbd[i];
>  		enetc_free_tx_frame(tx_ring, tx_swbd);
>  		if (i == 0)
>  			i = tx_ring->bd_count;
>  		i--;
> -	} while (count--);
> +	};

I think this gives us:

drivers/net/ethernet/freescale/enetc/enetc.c:408:2-3: Unneeded semicolon
-- 
pw-bot: cr

