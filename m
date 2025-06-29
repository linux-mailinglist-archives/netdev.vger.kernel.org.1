Return-Path: <netdev+bounces-202261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E30AECF8E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D2F7A1EE3
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22609237A4F;
	Sun, 29 Jun 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kSHAKymU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF84233158;
	Sun, 29 Jun 2025 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221614; cv=none; b=q/wNAx+Cy/9Q0rSpKgW8Z3l7CygCVxJeae/T7W8DkxpOV4Qsh7Ua6OsdX5xnr1xFn/qjyRWBgMfjyiBtDNCMaoxMuCmuYvrjO2PW/Ac9l95jmdLZo6ItHelclTCJs+AeGOyVFuYoYHmNJjFuqROchLLxEVGc8JevgR8ksRXZm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221614; c=relaxed/simple;
	bh=W6nAtBdJOtPdVut/wcfTksyMZElqg9WjrBXjCPbWZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okbk0MiAIHYuDTW1CAdVK4rzVDWJNWUCGIrEkoiGFrSSkl6AWrxQ6L4gX0HUzU4hS7GIzbIC0+5TYQvhZzuDvgUuRtD8Il0p9LUmk9YoefE9TvmSLvlQ9Z+DmrVGKv5LHGMvEEv7Crlnoe3KhfBxeUE8+16henO7xbm2TkObHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kSHAKymU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QX1murptrOVH4xG1C1DogmF5HNLO3DLAS8v3YKRUskg=; b=kSHAKymUrGqyNPeikA+ET9CRvh
	pi0ce05QS9PdOB8IMyZl+R0lcjJqX1MmVHxGilsqJN11O1J5rXx8IbqSSZuiPNadMLC16k4buMC4I
	2Alv6XuV3aKqIw/lnjyc70ei39mjdElIvmalkojVNajMUeyAyY5h8QuUrhTsPGvAA4E4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVwji-00HIFS-Jx; Sun, 29 Jun 2025 20:26:42 +0200
Date: Sun, 29 Jun 2025 20:26:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: add support for dwmac 5.20
Message-ID: <4d5a599a-60e5-4141-8671-ffcbda3aca02@lunn.ch>
References: <20250629094425.718-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629094425.718-1-jszhang@kernel.org>

On Sun, Jun 29, 2025 at 05:44:25PM +0800, Jisheng Zhang wrote:
> The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
> compatibility flag, and extend coverage of the dwmac-generic driver
> for the 5.20 IP.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> index b9218c07eb6b..cecce6ed9aa6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> @@ -59,6 +59,7 @@ static const struct of_device_id dwmac_generic_match[] = {
>  	{ .compatible = "snps,dwmac-3.72a"},
>  	{ .compatible = "snps,dwmac-4.00"},
>  	{ .compatible = "snps,dwmac-4.10a"},
> +	{ .compatible = "snps,dwmac-5.20"},
>  	{ .compatible = "snps,dwmac"},
>  	{ .compatible = "snps,dwxgmac-2.10"},
>  	{ .compatible = "snps,dwxgmac"},

I can see a compatible flag being added. But what about the extending
the coverage of the dwmac-generic driver part?

	Andrew

