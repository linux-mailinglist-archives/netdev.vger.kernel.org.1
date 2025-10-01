Return-Path: <netdev+bounces-227500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE522BB14F2
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800682A5EC4
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24E2C11C9;
	Wed,  1 Oct 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SmoPHkHx"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263928137D;
	Wed,  1 Oct 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337919; cv=none; b=MiPyb9R97n9mvi3DgHjqcFT0yM03yTUDawj2yucHNHb2jV3OvfXn8iXyyuJ80GDgYH94bNRwkR8lUJBmTDcKn0W3VnGDqe3vSD9hpYvBapseAts6DQ6RlB09yaESCXnih19VN4Qrnw81DHKzpJmvG4BY9/dqfB3ujH3Un1jm4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337919; c=relaxed/simple;
	bh=Qh7KxPXWt/CfsqUGwj+AGUKWsRL22jtI/i4SqoHDvuo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXkT8Vc/J/mdv95vyAzEEZE89RT05xw/UWyJwZvG8iJQb4U4TJzNaIDiFGqAwKdRsY7Gnb67WwOCEuSHqlE6OjNHGP+22eErBaswOfJX57Ya60Eg9TPojSEhM0CdpnS7rqrphVc/pQoEZgcxxenWf8wgecnBWEOHWsrs21SH1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SmoPHkHx; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 591Gw9c32711373;
	Wed, 1 Oct 2025 11:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759337889;
	bh=iTpxZ9ru9UqyaX58xqLKVwXiK/FxAvZ1ncan5yozrCE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SmoPHkHxXUqEl/EwoZySTE7UaA5+k0GAB3wrOylYlxn69j3OzA7l6IlUGVLc5XFES
	 Jszshhl8wf4NYbiTKCKVqoTR8+MLc/YsSHMtNEerFg/19hkZSuhUl2iR2rXjPuDi5t
	 y3Dk02COdGubZzcEfoaybF42eWTUZOgRub8ekgxg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 591Gw95r615388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 1 Oct 2025 11:58:09 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 1
 Oct 2025 11:58:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 11:58:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 591Gw85r861915;
	Wed, 1 Oct 2025 11:58:08 -0500
Date: Wed, 1 Oct 2025 11:58:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Horman <horms@kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] net: ethernet: ti: Remove IS_ERR_OR_NULL checks
 for knav_dma_open_channel
Message-ID: <20251001165808.lnatvc224dpewpe7@unscathed>
References: <20250930121609.158419-1-nm@ti.com>
 <20250930121609.158419-4-nm@ti.com>
 <0cae855b-e842-47a1-9aaf-b2a297ec32d6@intel.com>
 <20251001105416.frbebh5ws2rnxquu@quality>
 <aN1Pwh3B8xhEoQmh@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aN1Pwh3B8xhEoQmh@horms.kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:58-20251001, Simon Horman wrote:
> On Wed, Oct 01, 2025 at 05:54:16AM -0500, Nishanth Menon wrote:
> > On 16:59-20250930, Jacob Keller wrote:
> > > 
> > > 
> > > On 9/30/2025 5:16 AM, Nishanth Menon wrote:
> > > > knav_dma_open_channel now only returns NULL on failure instead of error
> > > > pointers. Replace IS_ERR_OR_NULL checks with simple NULL checks.
> > > > 
> > > > Suggested-by: Simon Horman <horms@kernel.org>
> > > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > > ---
> > > > Changes in V2:
> > > > * renewed version
> > > > * Dropped the fixes since code refactoring was involved.
> > > > 
> > > 
> > > Whats the justification for splitting this apart from patch 1 of 3?
> > > 
> > > It seems like we ought to just do all this in a single patch. I don't
> > > see the value in splitting this apart into 3 patches, unless someone
> > > else on the list thinks it is valuable.
> > 
> > The only reason I have done that is to ensure the patches are
> > bisectable. at patch #1, we are still returning -EINVAL, the driver
> > should still function when we switch the return over to NULL.
> 
> Maybe we can simplify things and squash all three patches into one.
> They seem inter-related.

I have no issues as the SoC driver maintainer.. just need direction on
logistics: I will need either the network maintainers to agree to take
it in OR with their ack, I can queue it up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

