Return-Path: <netdev+bounces-63654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2082EB74
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 10:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB4DB221F4
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8912B61;
	Tue, 16 Jan 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DtxFLmZn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82D134A0;
	Tue, 16 Jan 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9AcTE6fHCMnU430YmN95iQmPujpuIuN4C1DpdMpZauU=; b=DtxFLmZn0JKnbACsWiwlPC2A5Z
	tUJwvvDgXS7AOB2TfgJ7J9RER1b22R/uUY6RCBqIfj6pBcaI5R1BGj3LXohumWmCf90Kc17yQXo+y
	5tu/u6Zy/jWxSQCTBg7qc7NpCbdXsZyzjvSUpLbrpuiNR1+rdM2v9KNSaqciyPzDscwEA4cdOsYk1
	99E1WO8gltQu0VaOeShTnMGSwsS6FJB1fpsj01zKFf7JjxAeRPzpWalW0LYOOwG4GE8nVi80VjITs
	F+qwlZn8OccXyI5m50677HrgaIFs7y2Df6o6Zy0vwKGtG7U8rRaum5hTAjCANAyqcePT5XFuOtXQ8
	L8QtZqPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45646)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPfi6-0003FM-27;
	Tue, 16 Jan 2024 09:26:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPfi4-0003le-Ax; Tue, 16 Jan 2024 09:26:16 +0000
Date: Tue, 16 Jan 2024 09:26:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: mvpp2: clear BM pool before initialization
Message-ID: <ZaZLuPyRa5QhRrmH@shell.armlinux.org.uk>
References: <20240116055754.279560-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116055754.279560-1-jpatel2@marvell.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 15, 2024 at 09:57:54PM -0800, Jenishkumar Maheshbhai Patel wrote:
>  static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
>  {
>  	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
>  	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
>  	struct mvpp2_port *port;
>  
> +	if (priv->percpu_pools)
> +		poolnum = mvpp2_get_nrxqs(priv) * 2;
> +
> +	for (i = 0; i < poolnum; i++) {
> +		/* Make sure about the pool state in case it was
> +		 * used by firmware.
> +		 */
> +		mvpp2_bm_pool_cleanup(priv, i);
> +	}

	/* Clean up the pool state in case it contains stale state */
	for (i = 0; i < poolnum; i++)
		mvpp2_bm_pool_cleanup(priv, i);

Doesn't need quite as many lines!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

