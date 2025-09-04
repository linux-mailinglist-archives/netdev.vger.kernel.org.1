Return-Path: <netdev+bounces-219852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A2B437AE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F21B20FBE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA52D3731;
	Thu,  4 Sep 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD0N2Afy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D177081F;
	Thu,  4 Sep 2025 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979703; cv=none; b=hdF8+SwRU7kY0E33xtvMYNgQfNWAqNvNh3IxPaAIQCi2hCfBWSrbfEGI6nAylwUV5CzkW4NytmHWzN2tFeWgIlCLHs+Rozgv0HJhYWXT7MUUTCHR0BkMb/p/EgdwyvxnDQBBe11b4H8Qp57WPrmrxgpCbs5lhEUCAw3kYEEgdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979703; c=relaxed/simple;
	bh=PkwoREsB9/pKPRtysjzXpw88sUFZQqfBBJxGudm+f48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCwWhwtjOvdlreqZS0/64IB7eOYuKMKIBshL/AlEroHVgJx9Lwpo5S3JulF63nIuUUvIII7P4GTYXBJJ3mVxjk6kwRh+vZLfeCo+55uYnvZ9mWi2kfH8FjPloZST2G6R3bzTjdzh2ZgphCVpJixPvqm5dr3DRCLqkXK6i2vzr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD0N2Afy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B5FC4CEF1;
	Thu,  4 Sep 2025 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756979702;
	bh=PkwoREsB9/pKPRtysjzXpw88sUFZQqfBBJxGudm+f48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TD0N2AfykrOHqznsu9h1ZxeWsqAwTt0PUB0Iftz9PpWRbfPjknJt4qVMDq3BLA81i
	 eI6ZQHOafWau1RyiBiHCISdcsQ8n2ALkLIW9Xbq5b+gQu66zDctJG17dCXnH9QxPMU
	 B2Ay/I4KM9GO+/+4LVDKXTDq2iGmDidL3t6eHAZHpvpOcpyimiT0DmK2wIYU0OoTSo
	 33enSCOo3P57BkyNnRf16VpjQHzu9zrL0IH4g+B520euaqSqIFnSDVi93kNZ4MFvVo
	 XxOE+R6Fn74sYv34SsqQxiE96EdBQOeUXUsMGDuKIl8stF4HG0e45zYe2r91WJqNoJ
	 0f+lTV2ZzxXog==
Date: Thu, 4 Sep 2025 10:54:57 +0100
From: Simon Horman <horms@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <20250904095457.GE372207@horms.kernel.org>
References: <20250904031222.40953-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904031222.40953-3-ziyao@disroot.org>

On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> We must set the clk_phy pointer to NULL to indicating it isn't available
> if the optional phy clock couldn't be obtained. Otherwise the error code
> returned by of_clk_get() could be wrongly taken as an address, causing
> invalid pointer dereference when later clk_phy is passed to
> clk_prepare_enable().
> 
> Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

...

Hi,

I this patch doesn't seem to match upstream code.

Looking over the upstream code, it seems to me that
going into the code in question .clk_phy should
be NULL, as bsp_priv it is allocated using devm_kzalloc()
over in rk_gmac_setup()

While the upstream version of the code your patch modifies
is as follows. And doesn't touch .clk_phy if integrated_phy is not set.

        if (plat->phy_node && bsp_priv->integrated_phy) {
                bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
                ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
                if (ret)
                        return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
                clk_set_rate(bsp_priv->clk_phy, 50000000);
        }

Am I missing something?

