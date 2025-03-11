Return-Path: <netdev+bounces-173949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21233A5C79E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA833B884D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178B25E83F;
	Tue, 11 Mar 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gp/mOcT2"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66E25EFA4;
	Tue, 11 Mar 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707066; cv=none; b=hnG1AMleZO/D6eh4UUaLbYDOIIYJrTGe8FEd1secVs+VHR9eTX0D2xWz4Ug2SQamVhLiycXnLGsOG4FYfRigUhj9KmbVAWSGLXS78dSOkeq/Wab1BLBocUVDsj/Wqx3sp10/tUtJC7xx7pCDDvpuQFuw3canM7mvgo0c40vGRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707066; c=relaxed/simple;
	bh=mCayHC07IPSadxzr8LI33VWkoHz8rXpRAPQg3FVWUF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaN/3lpinJmwbuiczHpHpqxLmsfP9uCHjeh1tfWe7jHr5n2sVrEq+4FhBMdc21dy3XpSNwYfNh8ETnzKJmNyD1imAJ1mTYhY4xP/GKPIr/EU4/W85iEv8qyFNy9vxZwDQSbVIJWCwGkmcQmrIcivQq3XP60PPOjmsX9g0Mck+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gp/mOcT2; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFV0TE1330725
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 10:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741707061;
	bh=EqNC1vKEj/YCl/EuKp8Axc5QCFL9Aq3EYEgz9+y2yHs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Gp/mOcT2v3v3jGGQ/cMeCA/VJGaAKTxTbzuND0xBgEKljj5xcTNWKD9L7Xc6hfmE2
	 5vCXFJDQo3x1IHKhf1T9K3xPZDBwzwfrMG500pqPyyFvDAo+j2XBYrqiBblq3U9yEw
	 QHJ3t8DqEfDye5Q/9qBCautjvxZ2KVsvS1EbtWEk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFV0or126139
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 10:31:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 10:31:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 10:31:00 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BFUxQo018528;
	Tue, 11 Mar 2025 10:31:00 -0500
Date: Tue, 11 Mar 2025 21:00:59 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Message-ID: <20250311153059.aejqbclfcso6n3pk@uda0492258>
References: <20250311130103.68971-1-s-vadapalli@ti.com>
 <02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com>
 <20250311151833.v3gymfqao4y2zls7@uda0492258>
 <373ae7ef7ff20aa6dccefcb40e2312e9510132b3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <373ae7ef7ff20aa6dccefcb40e2312e9510132b3.camel@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 11, 2025 at 03:25:36PM +0000, Sverdlin, Alexander wrote:
> Hi Siddharth!
> 
> On Tue, 2025-03-11 at 20:48 +0530, s-vadapalli@ti.com wrote:
> > > > Registering the interrupts for TX or RX DMA Channels prior to registering
> > > > their respective NAPI callbacks can result in a NULL pointer dereference.
> > > > This is seen in practice as a random occurrence since it depends on the
> > > > randomness associated with the generation of traffic by Linux and the
> > > > reception of traffic from the wire.
> > > > 
> > > > Fixes: 681eb2beb3ef ("net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path")
> > > > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > > > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > ...
> > > 
> > > 
> > > > @@ -2590,10 +2591,11 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
> > > >  	return 0;
> > > >  
> > > >  err_flow:
> > > > -	for (--i; i >= 0 ; i--) {
> > > > +	netif_napi_del(&flow->napi_rx);
> > > 
> > > There are totally 3 "goto err_flow;" instances, so if k3_udma_glue_rx_flow_init() or
> > > k3_udma_glue_rx_get_irq() would fail on the first iteration, we would come here without
> > > a single call to netif_napi_add().
> > 
> > The following should address this right?
> 
> Looks good to me!

Thank you for the confirmation. I will post the v3 patch with the fix.

Regards,
Siddharth.

