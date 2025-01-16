Return-Path: <netdev+bounces-158755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054AA13238
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF283A6123
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE6137C37;
	Thu, 16 Jan 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BMcMdR3a"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523205661;
	Thu, 16 Jan 2025 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004159; cv=none; b=FWioituMpL92OJR8Cj+xDVpQrUTsmeAAFQ1aptcvfIhdw+j9wAq7T2Yjoj4Um+nx5ZWYWu4WeU71tc/5J2wDFuj7y7IzYWmtCHydAXxolPb+9InmMzqGCfI3+ZfpVzsdpw9dXm/93L9/UbmIbkhrUEie0D0VU4xUa2rm0IZw4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004159; c=relaxed/simple;
	bh=jzYmmL5/uuKMv/afdLS7NtAUT09E+jog9mPZCOGpbcs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeSD4+WKly6ENQhJoHFws3ECV+dsJk9GFwKK2TXl4BMkSs6uqtZ1aOA+H+qI4NY1DN9RddX4jQgCkuywmXfrq6sgATIrEkZuZbW/pgl29dj7tVvqa9II1tMXwmzCxMG6/cDBKJR8rFyzNefrKID0k2U1XkRwp7zDyz0QFaHnhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BMcMdR3a; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50G594vO090302
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 23:09:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737004144;
	bh=ybQviCWtB4EK/IDzymZat0MjfQqmr+MfB2dwZaMeKDU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BMcMdR3azJNq8n/HFiG1zkXaUA1WpAR+D6JS+rvvZzvcHs4DAsBJGBylTfZFo17zE
	 EKpywHXEitCkjolMlYQGN7C9qcLQ2nrzJi7LkZKZoSmUkv+inIYG0HgBe5VTlpmiGz
	 xiW+MoKGGhMObkrc5FffNFsP+5s51aFidgzSAdEU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50G594e1021539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jan 2025 23:09:04 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Jan 2025 23:09:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Jan 2025 23:09:03 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50G592L9035891;
	Wed, 15 Jan 2025 23:09:03 -0600
Date: Thu, 16 Jan 2025 10:39:02 +0530
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
Message-ID: <y6hpbuck3fvxy3z6iajjgjkgmwy3773slen4j2we5pumsl77jp@oy5gp2ppfwfr>
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
 <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
 <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jan 15, 2025 at 05:49:44PM +0200, Roger Quadros wrote:
> Hi Siddharth,
> 
> On 15/01/2025 12:38, Siddharth Vadapalli wrote:

[...]

> > Only when the user re-invokes am65_cpsw_nuss_update_tx_rx_chns(),
> > the cleanup will be performed. This might have to be fixed in the
> > following manner:
> > 
> > @@ -3416,10 +3416,17 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
> >         common->tx_ch_num = num_tx;
> >         common->rx_ch_num_flows = num_rx;
> >         ret = am65_cpsw_nuss_init_tx_chns(common);
> > -       if (ret)
> > +       if (ret) {
> > +               devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
> > +               am65_cpsw_nuss_free_tx_chns(common);
> >                 return ret;
> > +       }
> > 
> >         ret = am65_cpsw_nuss_init_rx_chns(common);
> > +       if (ret) {
> > +               devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
> > +               am65_cpsw_nuss_free_rx_chns(common);
> > +       }
> > 
> >         return ret;
> >  }
> > 
> >  Please let me know what you think.
> 
> I've already implemented a cleanup series to get rid of devm_add/remove_action,
> cleanup probe error path and streamline TX and RQ queue init/cleanup.
> I'll send out the series soon as soon as I finish some tests.

Sure, thank you.

Regards,
Siddharth.

