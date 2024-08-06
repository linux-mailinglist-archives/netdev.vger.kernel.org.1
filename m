Return-Path: <netdev+bounces-116140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4D94941A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2641F226DC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001FB1EA0A0;
	Tue,  6 Aug 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RkDqvkkN"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489DD1D54FB;
	Tue,  6 Aug 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956643; cv=none; b=t8tfsZen/o6zXDdprzq84n4JAfgMKprfd0H6VSbDchbGRo+8zo18Is9d2lkbGWx6FzHTudSDlt5+OJq8qsmODUbwWMgIWN+F9bOsDWD8kFr6rNRabG38rxUbiPDeR2aSOmg6LoAIgJD1u3TXJaHNfhMzDLPN7ERVHyuDx/5MGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956643; c=relaxed/simple;
	bh=vXK0BUzSSbknlVaLGfcKkPDJgP2UcBjdICOwO3I5IJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5r/fEgrBn0e47DkkmFKpPuWtP9xU4S48c+rxckwDaIYRwpZnYyS89zGgWb8GJzixsJsDJDAbDYoxkMKZNJaWVwCTdWlLCbYd/cPcULjv4bhLYMStPOSGAHh1Iywx3sRZZgJe+q0ECy2dX8Vds8oEy5W4cyTaVzF3agkFrPFcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RkDqvkkN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476F3fDN106327;
	Tue, 6 Aug 2024 10:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722956621;
	bh=H7hluvR91GwUos3RLVo/gNL6S3yfN5RfkN4cbUfh3qk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=RkDqvkkN/qd6naQNMmEmJIsZBiv9iBTixgy8aE2W1RJTXbHVcXOKK9wIdJiGAGYDt
	 SAwKiXKAEyvhWVg68bPMEYUcFt9LZQJizpccQu/xs4Ooedgyqojpg/HKAS8M0TrAWb
	 Er09X5GcbhAcqEF9cFReSPnk0qHHiS6xkYioe3fY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476F3fHq022247
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:03:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:03:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:03:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476F3fg8106848;
	Tue, 6 Aug 2024 10:03:41 -0500
Date: Tue, 6 Aug 2024 10:03:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
        Sai
 Krishna <saikrishnag@marvell.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent
	<kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation
 for PA_STATS support
Message-ID: <20240806150341.evrprkjp3hb6d74p@mockup>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-2-danishanwar@ti.com>
 <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:42-20240805, Roger Quadros wrote:
> 
> 
> On 29/07/2024 14:32, MD Danish Anwar wrote:
> > Add documentation for pa-stats node which is syscon regmap for
> > PA_STATS registers. This will be used to dump statistics maintained by
> > ICSSG firmware.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: tags should come after Author's Signed-off-by:
> 
> > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

If the net maintainers are OK, they could potentially take the binding
patch along with the driver mods corresponding to this - I am a bit
unsure of picking up a binding if the driver implementation is heading
the wrong way.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

