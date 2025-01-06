Return-Path: <netdev+bounces-155589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF831A031CD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F58A1886E46
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77411DFE38;
	Mon,  6 Jan 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CPs858+Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6394207A;
	Mon,  6 Jan 2025 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197558; cv=none; b=GUqBrjjz/2F3I68WveqdQ3ez3U+MVtk3MaLuBzUcw95SLYoXUFJATmvoaDC7Hi2F/y3NcT6Gz/s1WiHhIo/PsDEh1bcRk2omk6WH17XOHcEGX8YFIqvzyipMaBWVRmhyVBNbfXBzNlE2V1BabsexlnqNCqx2nVju3TH9wad7FWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197558; c=relaxed/simple;
	bh=PMqIAjMy2W2C7fvdlEyLE/DnMiUNw+hnOLyMhva0jlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA8l8Xqod9TS2gadelQuRCXsKYUrj/WakcKF+gKK2Q32c/g6tCUs5I0/GmIFgP8w9Q79svisCGSNEceLGCdfPgJISEtaoMLYo4lNzvm4JPANKvswyD4Eor2eKFtHTjPRLu08xgPMwuh2JjWPZWD+pTDCzZL8NPpiP+7rIcvtLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CPs858+Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eDDQkkpqbkCsGa2J3B58yILeZtgFMY6XLVrsYIvsNhA=; b=CPs858+YJWwWF23l1a8Ms63Hb7
	20deuNmLXH9hjPK5Inbeta9Y47I3UZgaj5N4/mflqEagCOk7V7LpPfPEBjnNxf98bOWtMP9lTpMlG
	ZTsIgS3YVHRro27D03qsmYiwsZtIj/BUdQeuSKu6+yliFHuHo6UGxfUNz2OPnxyjQduU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUuIC-001zXE-Br; Mon, 06 Jan 2025 22:05:44 +0100
Date: Mon, 6 Jan 2025 22:05:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: Unexport stmmac_rx_offset()
 from stmmac.h
Message-ID: <6f0b5132-9695-4da6-ae87-1e0757253c07@lunn.ch>
References: <20250106062845.3943846-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106062845.3943846-1-0x1207@gmail.com>

> +static inline unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
> +{
> +	if (stmmac_xdp_is_enabled(priv))
> +		return XDP_PACKET_HEADROOM;
> +
> +	return 0;
> +}

Please drop the inline keyword. You don't need it in a .c file, it is
better to let the compiler to decide.


    Andrew

---
pw-bot: cr

