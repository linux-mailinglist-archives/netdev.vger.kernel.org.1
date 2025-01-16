Return-Path: <netdev+bounces-158870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64CA139BE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AF5188A3C5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5A71DE3C7;
	Thu, 16 Jan 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P50KBPac"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5D24A7E7;
	Thu, 16 Jan 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029429; cv=none; b=CLGeY61GPLGwou7q1tny8+QSzP5dmXIQSxxj8wvNPpIYn3iFpkRANOm2UoKLhgFW6dc9vHkUpL+obpTgr9z0qUk0Xo4JK0S4xYs94oNni7W76CRdA2ciBV+fJNh6sDqF33HRTu3B06+1EFYh4Tufm+pI9I01e6ctXm8Ek50EubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029429; c=relaxed/simple;
	bh=EDXMBmPTqcQgSbpwH3xgyBXyT7xISBHLAuOPqKUKGvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdCXNDGCQmUJF1LGXj8c+ZzE4tAFG1cMVmkYJOsgWqJ/fta6/WZFJPzklvHOIx//R7+r+oEemgfkywvLWQdfsFkh5XuIVE911i/fI9SzHYwDe9Yddb7ijfEMJZAxV1Vk199vmeHDrANbApSkVvAzAwQ5fsLIN7w/fwxX+Wxsfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P50KBPac; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50GCA9Sb011570
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 Jan 2025 06:10:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737029409;
	bh=hzo23YppQzy0ijbj/RhMXeFoAKmwtBkFgyT5f90kQWU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=P50KBPacPeJTsYJYyms77aJ9V5hlhojbr2AeYJCnBDo6sAnECG1Y4gMEGcPcmZOnW
	 Ftfrw2jvZ+bn7Nswt5hQsn5VzmYbYIMDAk+GO0rC4W1iEVVRIHWIz8qRFDGuOqCD8z
	 /0MdAstb1DLMOTfOGC1Crlmmi/CWd0gPyIGDaSqU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50GCA9Sb015509;
	Thu, 16 Jan 2025 06:10:09 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Jan 2025 06:10:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Jan 2025 06:10:09 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50GCA8TJ115654;
	Thu, 16 Jan 2025 06:10:08 -0600
Date: Thu, 16 Jan 2025 17:40:07 +0530
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
Message-ID: <yhxlrqqt4cuxp2hkv7nm7h5i25jjaxjhmuzhlvpfwb24jga7o2@f47d4wqe75tu>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
 <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
 <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
 <8829d58b-fbfc-4040-93de-51970631d935@kernel.org>
 <2bhpxcdducequwchyobyinj3xp2vsnpxkshtwqy24swto6zqvz@mbnnn7calbhv>
 <e2d17324-39b8-4db5-85e7-bd66e67fcd52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e2d17324-39b8-4db5-85e7-bd66e67fcd52@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Jan 16, 2025 at 01:47:59PM +0200, Roger Quadros wrote:
> 
> 
> On 16/01/2025 07:15, Siddharth Vadapalli wrote:
> > On Wed, Jan 15, 2025 at 06:38:57PM +0200, Roger Quadros wrote:
> >> Siddharth,
> >>
> >> On 15/01/2025 17:49, Roger Quadros wrote:
> >>> Hi Siddharth,
> >>>
> >>> On 15/01/2025 12:38, Siddharth Vadapalli wrote:
> >>>> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
> >>>>> Hi Siddharth,
> >>>>>
> >>>>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
> >>>>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
> >>>>>>
> >>>>>> Hello Roger,
> >>>>>>
> >>>>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
> >>>>>>
> >>>>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
> >>>>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
> >>>>>
> >>>>> Yes I meant tx instead of rx.
> >>>>>
> >>>>>>
> >>>>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> >>>>>>
> >>>>>> Additionally, following the above section we have:
> >>>>>>
> >>>>>> 		if (tx_chn->irq < 0) {
> >>>>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
> >>>>>> 				tx_chn->irq);
> >>>>>> 			ret = tx_chn->irq;
> >>>>>> 			goto err;
> >>>>>> 		}
> >>>>>>
> >>>>>> Could you please provide details on the code-path which will lead to a
> >>>>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
> >>>>>>
> >>>>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
> >>>>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
> >>>>>> 2. am65_cpsw_nuss_suspend()
> >>>>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
> >>>>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
> >>>>>> appears to me that "tx_chn->irq" will never be negative within
> >>>>>> am65_cpsw_nuss_remove_tx_chns()
> >>>>>>
> >>>>>> Please let me know if I have overlooked something.
> >>>>>
> >>>>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
> >>>>> repeatedly (by user changing number of TX queues) even if previous call
> >>>>> to am65_cpsw_nuss_init_tx_chns() failed.
> >>>>
> >>>> Thank you for clarifying. So the issue/bug was discovered since the
> >>>> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
> >>>> misled me. Maybe the "Fixes" tag should be updated? Though we should
> >>>> code to future-proof it as done in this patch, the "Fixes" tag pointing
> >>>> to the very first commit of the driver might not be accurate as the
> >>>> code-path associated with the bug cannot be exercised at that commit.
> >>>
> >>> Fair enough. I'll change the Fixes commit.
> >>
> >> Now that I check the code again, am65_cpsw_nuss_remove_tx_chns(),
> >> am65_cpsw_nuss_update_tx_chns() and am65_cpsw_nuss_init_tx_chns()
> >> were all introduced in the Fixes commit I stated.
> >>
> >> Could you please share why you thought it is not accurate?
> > 
> > Though the functions were introduced in the Fixes commit that you have
> > mentioned in the commit message, the check for "tx_chn->irq" being
> > strictly positive as implemented in this patch, is not required until
> > the commit which added am65_cpsw_nuss_update_tx_rx_chns(). The reason
> > I say so is that a negative value for "tx_chn->irq" within
> > am65_cpsw_nuss_remove_tx_chns() requires am65_cpsw_nuss_init_tx_chns()
> > to partially fail *followed by* invocation of
> > am65_cpsw_nuss_remove_tx_chns(). That isn't possible in the blamed
> > commit which introduced them, since the driver probe fails when
> > am65_cpsw_nuss_init_tx_chns() fails. The code path:
> > 
> > 	am65_cpsw_nuss_init_tx_chns() => Partially fails / Fails
> > 	  am65_cpsw_nuss_remove_tx_chns() => Invoked later on
> > 
> > isn't possible in the blamed commit.
> 
> But, am65_cpsw_nuss_update_tx_chns() and am65_cpsw_set_channels() was
> introduced in the blamed commit and the test case I shared to
> test .set_channels with different channel counts can still
> fail with warning if am65_cpsw_nuss_init_tx_chns() partially fails.

I was looking for "am65_cpsw_nuss_update_tx_rx_chns()" in the blamed
commit. I realize now that it was renamed from
am65_cpsw_nuss_update_tx_chns() which indeed is present in the blamed
commit. I apologize for the confusion caused.

Regards,
Siddharth.

