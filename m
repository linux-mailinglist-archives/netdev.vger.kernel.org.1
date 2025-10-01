Return-Path: <netdev+bounces-227464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6FDBB0123
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1582A1C24
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082352C11C8;
	Wed,  1 Oct 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wm9PpVq/"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336342C0F61;
	Wed,  1 Oct 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316264; cv=none; b=WBZNiX4XeINCLDp4DFy62QDYVWdQ7Xg4msKmVijzihDb28wkPTnZcR1Zi7Oibhqz2OI15KG7rtf43YQ+nZ5K0Rlo/geR5RGf+FUcDETMxW3PhqVUbAF9XKFF04aLWHI8gJbsZUXu0ZtUFqW1hYeU52v0jkEiFJ9lnuJIl5cbq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316264; c=relaxed/simple;
	bh=9c53hXG+6jzoglFgEFrmZbtBT75TA8bAs8sQ8A5GACA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0G66jLX21yQ2q78EGnrF9jSkZUP7NFjpikWuxj1Q1T+wNvZm+ClHo1ClFiWrJa7mc4st+m5JTPjCjmZgiA8WJgHTkwnF8enAb/VFozIJOuQ0dzfj62RJP4VFjsjSPVI20sZP1BBkPs+H8ZRe8IEWvoPtqr2t2p41KMlG+oo788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wm9PpVq/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 591AvLaP3063484;
	Wed, 1 Oct 2025 05:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759316241;
	bh=JxzG4NDNtvyZtWrcwERf/N9ajidnNL4jpz7ADaJTFuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Wm9PpVq/HHp38jQfqHex6preKa42kLW+ISLJc7uf/PXrJSm/unAifRXnLT8E6G9xU
	 D1fjvcLqFWcVnSV+4Zd6UKGbjxpmtgYk1rkO0PczEmAIYTOKG5SpsXE60nrTlHRQHU
	 BpeH1YB57SRBvABeRBlHJZVaQiuUU+IOBrnZNoec=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 591AvLgT425510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 1 Oct 2025 05:57:21 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 1
 Oct 2025 05:57:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 05:57:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 591AvLV7463660;
	Wed, 1 Oct 2025 05:57:21 -0500
Date: Wed, 1 Oct 2025 05:57:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Simon
 Horman <horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] soc: ti: knav_dma: Make knav_dma_open_channel
 return NULL on error
Message-ID: <20251001105721.wf6mr2ysj34uhkhh@rendition>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-3-nm@ti.com>
 <c8d9f60a-341a-4386-afc6-b7a9451cda9f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8d9f60a-341a-4386-afc6-b7a9451cda9f@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:59-20250930, Jacob Keller wrote:
> 
> 
> On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> > Make knav_dma_open_channel consistently return NULL on error instead of
> > ERR_PTR. Currently the header include/linux/soc/ti/knav_dma.h returns NUL
> > when the driver is disabled, but the driver implementation returns
> > ERR_PTR(-EINVAL), creating API inconsistency for users.
> > 
> 
> I would word this as indicating that we don't even use ERR_PTR here at all!

Thanks. Yep, will do for the next respin.

> 
> > Standardize the error handling by making the function return NULL on all
> > error conditions.
> > 
> > Suggested-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Changes in V2:
> > * renewed version
> > 
> >  drivers/soc/ti/knav_dma.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> > index a25ebe6cd503..e69f0946de29 100644
> > --- a/drivers/soc/ti/knav_dma.c
> > +++ b/drivers/soc/ti/knav_dma.c
> > @@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
> >   * @name:	slave channel name
> >   * @config:	dma configuration parameters
> >   *
> > - * Returns pointer to appropriate DMA channel on success or error.
> > + * Returns pointer to appropriate DMA channel on success or NULL on error.
> >   */
> >  void *knav_dma_open_channel(struct device *dev, const char *name,
> >  					struct knav_dma_cfg *config)
> > @@ -414,13 +414,13 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
> >  
> >  	if (!kdev) {
> >  		pr_err("keystone-navigator-dma driver not registered\n");
> > -		return (void *)-EINVAL;
> > +		return NULL;
> 
> Wow. The driver doesn't even return ERR_PTR, but just directly casts
> -EINVAL to a void *... thats quite ugly. Good to remove this.
> 




-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

