Return-Path: <netdev+bounces-131411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997A98E786
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88C61F27307
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF118D;
	Thu,  3 Oct 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vnIhUot1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7591A41
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913895; cv=none; b=uWwilGzx+0kW9Q66u71qAMTNOXieRagYEUkmd3bDC9cG1PZUVzB+O93fxxWlaJhv19nbCC4eiKITo6ei4Ps7yqs3LM3+npDPIsnRTKMppTFNA1osAMS01bRR4WCDb0PXDPFXKFztvckeOpCPBUrlOCZUWRNNV5oZYH1RUPTeRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913895; c=relaxed/simple;
	bh=7CHLKbmW8z87ufeGcUccZBrwX2HcbC0dCheq/w/zQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoDtqjrMzPWMLPT2cWFkaPt4DaTEbAqGOOV9U7aBJp4IR1qruopEOSmb0Og8y4RnSRw6e0pEijLNCPgYmVILWANiCAQV36sRqddP0dR/LpwCJkhPMHobCROoNe8SW8oDu+bRF7pQsZQIa22R044++LYwkxZKd7R8zS7kKQLRpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vnIhUot1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6gpNUZ2n+ZYIeb9jUgyu8pZsdI3EzueIgoOfHeCJegY=; b=vnIhUot1foD71vkU9UdaNoZiss
	GRwY5pWGUICSTWparQ9VtqHH7VummnPJB0YhzHFnPLO8WzqPpiaN7lJS3qeSTuq3qQ3seZ6UhicyL
	wr7HnAJKJmUu4/qtOkqnigXOLBRU6HgHI0P68JyL9FQ3WojDH090LLp3J6NZwNuiFS7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw9Ke-008uKm-8h; Thu, 03 Oct 2024 02:04:36 +0200
Date: Thu, 3 Oct 2024 02:04:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <acdc1443-15ca-4a35-aee0-ddf760136efa@lunn.ch>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
 <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>
 <zghybnunit6o3wq3kpb237onag2lycilwg5abl5elxxkke4myq@c72lnzkozeun>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zghybnunit6o3wq3kpb237onag2lycilwg5abl5elxxkke4myq@c72lnzkozeun>

> Anyway the Russell' patch set in general looks good to me. I have no
> more comments other than regarding the soft-reset change I described in
> my previous message.

Sorry, i've not been keeping track. Have you sent reviewed-by: and
Tested-by: for them?

	Andrew

