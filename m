Return-Path: <netdev+bounces-158756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6879A13240
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA13A5FE8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03381132111;
	Thu, 16 Jan 2025 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y+1cHHWz"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E44A01;
	Thu, 16 Jan 2025 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004544; cv=none; b=LGY9D+lSAR/VbzqMb0szvTDJa2kXQeJGC/483qFKUcy/lFmOTGYXjqh1p/RbYwsrjG4wATjTMiSb6AN4PsuUmki6A/bSvikl7CoZeDtbhC8Gs7YdaYvXiFS0g8PbqUfZ5ll2A9OhkBF4e58F1aDzHZDtUbVoYlgI6WAyGRIhYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004544; c=relaxed/simple;
	bh=wvJrzn9KUpwNef34u79CPgRfREiVHk/T678Ki7p5Cnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7LyDLSigSz+BxMKX6rsOLBotgLlwMiOq81Q028cVTs2WgSrxgNpFvai9hVBa4mSwV0TGy4qEMa+LuVyQDN8K9W7vlxpbKshPqHM1k9leheMde4HO4uWf+p7dxY3h/NCzmrEJprwjjXYiQzxQbIHDmKQ6KnGtW4sx/++mc06ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y+1cHHWz; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50G5FWOB3882509
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Jan 2025 23:15:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737004532;
	bh=O5b4DChhEuSF6cFgqgXWktMjL9igEbr9xd8XZuxN5Zw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=y+1cHHWzDrBXz2uYN1VdFmZdeAv4frbBCtKp08OMtyp/1Uxwmqx9WPPBxSqKgLw5i
	 oq2+2kT8M9Uhd+Xi0Zk1ARiLq/1/Dhd0vRCJVltiw1MR5JQu5ZkiCcHP/jGyHN8rjM
	 jwcuVikIkhle4UPeX0OnDvBjZaku4pMc853g3Mx0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50G5FWnP014559;
	Wed, 15 Jan 2025 23:15:32 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Jan 2025 23:15:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Jan 2025 23:15:31 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50G5FUFh042455;
	Wed, 15 Jan 2025 23:15:31 -0600
Date: Thu, 16 Jan 2025 10:45:30 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>, <srk@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Message-ID: <2bhpxcdducequwchyobyinj3xp2vsnpxkshtwqy24swto6zqvz@mbnnn7calbhv>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
 <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
 <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
 <8829d58b-fbfc-4040-93de-51970631d935@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8829d58b-fbfc-4040-93de-51970631d935@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jan 15, 2025 at 06:38:57PM +0200, Roger Quadros wrote:
> Siddharth,
> 
> On 15/01/2025 17:49, Roger Quadros wrote:
> > Hi Siddharth,
> > 
> > On 15/01/2025 12:38, Siddharth Vadapalli wrote:
> >> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
> >>> Hi Siddharth,
> >>>
> >>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
> >>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
> >>>>
> >>>> Hello Roger,
> >>>>
> >>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
> >>>>
> >>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
> >>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
> >>>
> >>> Yes I meant tx instead of rx.
> >>>
> >>>>
> >>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> >>>>
> >>>> Additionally, following the above section we have:
> >>>>
> >>>> 		if (tx_chn->irq < 0) {
> >>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
> >>>> 				tx_chn->irq);
> >>>> 			ret = tx_chn->irq;
> >>>> 			goto err;
> >>>> 		}
> >>>>
> >>>> Could you please provide details on the code-path which will lead to a
> >>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
> >>>>
> >>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
> >>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
> >>>> 2. am65_cpsw_nuss_suspend()
> >>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
> >>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
> >>>> appears to me that "tx_chn->irq" will never be negative within
> >>>> am65_cpsw_nuss_remove_tx_chns()
> >>>>
> >>>> Please let me know if I have overlooked something.
> >>>
> >>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
> >>> repeatedly (by user changing number of TX queues) even if previous call
> >>> to am65_cpsw_nuss_init_tx_chns() failed.
> >>
> >> Thank you for clarifying. So the issue/bug was discovered since the
> >> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
> >> misled me. Maybe the "Fixes" tag should be updated? Though we should
> >> code to future-proof it as done in this patch, the "Fixes" tag pointing
> >> to the very first commit of the driver might not be accurate as the
> >> code-path associated with the bug cannot be exercised at that commit.
> > 
> > Fair enough. I'll change the Fixes commit.
> 
> Now that I check the code again, am65_cpsw_nuss_remove_tx_chns(),
> am65_cpsw_nuss_update_tx_chns() and am65_cpsw_nuss_init_tx_chns()
> were all introduced in the Fixes commit I stated.
> 
> Could you please share why you thought it is not accurate?

Though the functions were introduced in the Fixes commit that you have
mentioned in the commit message, the check for "tx_chn->irq" being
strictly positive as implemented in this patch, is not required until
the commit which added am65_cpsw_nuss_update_tx_rx_chns(). The reason
I say so is that a negative value for "tx_chn->irq" within
am65_cpsw_nuss_remove_tx_chns() requires am65_cpsw_nuss_init_tx_chns()
to partially fail *followed by* invocation of
am65_cpsw_nuss_remove_tx_chns(). That isn't possible in the blamed
commit which introduced them, since the driver probe fails when
am65_cpsw_nuss_init_tx_chns() fails. The code path:

	am65_cpsw_nuss_init_tx_chns() => Partially fails / Fails
	  am65_cpsw_nuss_remove_tx_chns() => Invoked later on

isn't possible in the blamed commit.

Regards,
Siddharth.

