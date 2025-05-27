Return-Path: <netdev+bounces-193738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D1AC5A7B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B2F7A6559
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16BC28032E;
	Tue, 27 May 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f/ceSIhl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD549156CA;
	Tue, 27 May 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373260; cv=none; b=fLw1/zCUxJReeYJx6RSF9xJsbOqq5Equx0DxfDDMJC+iDoL8/gP/e9LUCzcz0PJCmaWmVULiBSIjuKk8Yc7tA3vp5mxKh+2E5Z2lo6dez22J9cj+akOMXPEREvMdY7YFxSE706x0RXV72Dsxgz4mTh7iVTKdKL6yQW3ro6AGENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373260; c=relaxed/simple;
	bh=a5IVo4yCm7LigODb+ANExP0xvZzE0gjGpDjtnFf0yWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0Ib7neYKWnq6qAysHQjJBIfrHc2nl15Z9tSef4LxZg/1OuzGd+QK0iGySREBTMJwGEDIDV7MTEszgg4uHTEgbzIrXbdL4Ylg1X+nzbuGoJKfFENEbGqwP59gcGc2Yk3oXH2cOUtBiGpto24dwAoryTMdisPeohB//X9V31Ks3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f/ceSIhl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xfabu4AMllSeaju3LPHLpuFW8PQMwXw0t82FVJTwvEc=; b=f/ceSIhl0pwULuwRwhuhzl4giN
	laI4TYdBH7PBMivr1Zr5limINaFDa5BQwXAl6I9eEonOEKfY5qJMs4fMPq6APZpumbh0weKMCdbiL
	zT6fTSynB1S5FEcYmY0UPJTQ0BKfb0WpDWjKIgkdi3S2EgpiFRHz3FobBqls235E6GRM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJzka-00E6OW-CJ; Tue, 27 May 2025 21:14:12 +0200
Date: Tue, 27 May 2025 21:14:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527175558.2738342-1-james.hilliard1@gmail.com>

On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> Some devices like the Allwinner H616 need the ability to select a phy
> in cases where multiple PHY's may be present in a device tree due to
> needing the ability to support multiple SoC variants with runtime
> PHY selection.

I'm not convinced about this yet. As far as i see, it is different
variants of the H616. They should have different compatibles, since
they are not actually compatible, and you should have different DT
descriptions. So you don't need runtime PHY selection.

	Andrew

