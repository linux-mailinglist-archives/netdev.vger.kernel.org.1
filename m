Return-Path: <netdev+bounces-219853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171EDB437B5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB18A544BDD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6552EE286;
	Thu,  4 Sep 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj8sq+mg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730D7081F;
	Thu,  4 Sep 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979823; cv=none; b=ZvSFaLHMDFtWT7ZqVKubz30jf15oWGU09x+6sgfBpKiCSCHA6FhEo24IfNTLPZpXjfYizybf8k7gLA98fNiGLnZGl3Qc8cr5fCUVwh0Dao2kZUWIIzJzRUHGoD179UxbNm1s0eduaYiqmMKQGYEyDKjTauLRAZUBHaGYhsTnyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979823; c=relaxed/simple;
	bh=Mr3XGbhvMQum++WN/lI8qNzkak39gyYMn/Hwp8A8pV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKvbQ7KDaa+VZn17x8ucu4pTdKFjLToEzISTNbvmyn9LUp292hHCwyC6Eoxey6jPzlOWohIEYg+GmqmqqZxOJC54COIXEZWacN7nOwhk/uJGvGpnwWK7TfH2y9kLjdEjkvQkLFmNEMNAbT1qzUnmsH/BF3rtUrLIWPSfeIo6sXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj8sq+mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5508C4CEF0;
	Thu,  4 Sep 2025 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756979822;
	bh=Mr3XGbhvMQum++WN/lI8qNzkak39gyYMn/Hwp8A8pV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fj8sq+mgo4dfxA5yYQzsWdjJrzopo8xjxcP55pLDVCdIYJX23w2mbI5w9ZBiWursc
	 jbB4qXTb+q9JVhmeeUHzq57A0DfFP75EugVf4ShFtHyWrx9pvig6V/du2iNQ5L6CvH
	 fh1LjNoheXSZvmggQwqStAds4c0Xz4imFgNEqBbQ99ZeLlDN++1/ksDWDRJbekGnUY
	 vUcHGKCHV2ImQEGxjjdSNxVNY84eWqNxaev0mtKagsTLaZ9V8+2yN9dvnua6p/uU0W
	 lw1SOQdyZaH0GHe5ccvEJh4ruq+DYW6X9HytsBHc7O+VaImvtkInuY1ZB0gLW5Hbza
	 EnLwKSRA5uohQ==
Date: Thu, 4 Sep 2025 10:56:57 +0100
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
Message-ID: <20250904095657.GF372207@horms.kernel.org>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <20250904095457.GE372207@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904095457.GE372207@horms.kernel.org>

On Thu, Sep 04, 2025 at 10:54:57AM +0100, Simon Horman wrote:
> On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > We must set the clk_phy pointer to NULL to indicating it isn't available
> > if the optional phy clock couldn't be obtained. Otherwise the error code
> > returned by of_clk_get() could be wrongly taken as an address, causing
> > invalid pointer dereference when later clk_phy is passed to
> > clk_prepare_enable().
> > 
> > Fixes: da114122b831 ("net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> 
> ...
> 
> Hi,
> 
> I this patch doesn't seem to match upstream code.
> 
> Looking over the upstream code, it seems to me that
> going into the code in question .clk_phy should
> be NULL, as bsp_priv it is allocated using devm_kzalloc()
> over in rk_gmac_setup()
> 
> While the upstream version of the code your patch modifies
> is as follows. And doesn't touch .clk_phy if integrated_phy is not set.
> 
>         if (plat->phy_node && bsp_priv->integrated_phy) {
>                 bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>                 ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>                 if (ret)
>                         return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>                 clk_set_rate(bsp_priv->clk_phy, 50000000);
>         }
> 
> Am I missing something?

Oops, I missed that da114122b831 is present in net-next (but not net).
Let me look over this a second time.


