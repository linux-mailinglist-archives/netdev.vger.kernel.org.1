Return-Path: <netdev+bounces-118027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA9950568
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DB7285FAA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68819939D;
	Tue, 13 Aug 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M5hgcuAS"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F01993AC;
	Tue, 13 Aug 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553117; cv=none; b=C6KSQdVXvMm7n/c771YUGijJiL1En9Sp/Rf5dd+lX1KyrHsUHk4ERh2rtG9zFIrPGzaoQASSBJ8kY27gaj0EB/qXMEHVRlP/+uFJBN8qua0BU1YVasKPClxZrux5RUzewIIroGFWJPQZaQXSu0TrFGD4G9fvrgIQHM4IaePmqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553117; c=relaxed/simple;
	bh=8Pj1wwR7aGnQltROlxDHQc9l7L3VvufDjQiitUJftq4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMXoHsrh2nybhsakQqOB0XQdYxzMfXp88GA/aZc9l0Pp/4o4hyJOw44KnxCdM+PQ1L01mGXWyD6u9UbOgcurkbb1ftu+6Pg2h+uAX1vZJAQVUVYzTBTXSb7cncUuizPugv0xvOOtVFCIiV4TWDfd4fAuventqjedAjY3G5ruMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M5hgcuAS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DCirUD069251;
	Tue, 13 Aug 2024 07:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723553093;
	bh=Q6g5EkCPXb/klBvxJYIPBH2jO9tkeQKDEQKZBWsZpJk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=M5hgcuASn2hkVBaY7VEncFhMrS5jR7Lj+CmhuvvZqGlZyuO/TKFwEHWXBEsU4d9t0
	 yageb7mierlSaLU1zsfySCn3mCMjbtny8gVOk05Ih1Ej6cAjAtCwoqND5ds9PEZ8/1
	 rXRS9DRP2fkDmCilTd6fAd1q6dskOViS/NsizDGM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DCirFB128116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 07:44:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 07:44:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 07:44:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DCiql8106821;
	Tue, 13 Aug 2024 07:44:52 -0500
Date: Tue, 13 Aug 2024 07:44:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory
 Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <srk@ti.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation
 for PA_STATS support
Message-ID: <20240813124452.l2rcnqlgqt3ulqpj@compress>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-2-danishanwar@ti.com>
 <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
 <20240806150341.evrprkjp3hb6d74p@mockup>
 <39ed6b90-aab6-452d-a39b-815498a00519@ti.com>
 <20240812172218.3c63cfaf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812172218.3c63cfaf@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:22-20240812, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 11:20:56 +0530 MD Danish Anwar wrote:
> > > If the net maintainers are OK, they could potentially take the binding
> > > patch along with the driver mods corresponding to this - I am a bit
> > > unsure of picking up a binding if the driver implementation is heading
> > > the wrong way.   
> > 
> > Hi Jakub, Paolo, David, Andrew,
> > 
> > Will it be okay to pick this binding patch to net-next tree. Nishant is
> > suggesting since the driver changes are done in drivers/net/ the binding
> > can be picked by net maintainers.
> > 
> > Please let us know if it will be okay to take this binding to net-next.
> > I can post a new series with just the binding and the driver patch to
> > net-next if needed.
> 
> Nishanth, could you send an official Ack tag?

Acked-by: Nishanth Menon <nm@ti.com>

Thanks Jakub.

> 
> No problem with merging it via net-next.
> On the code itself you may want to use ethtool_puts().
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

