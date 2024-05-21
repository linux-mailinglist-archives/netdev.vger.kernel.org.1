Return-Path: <netdev+bounces-97334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27248CADF2
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080BEB23379
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963B76025;
	Tue, 21 May 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bZd2oRfu"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB075803;
	Tue, 21 May 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716293552; cv=none; b=QpEpemPU22EpH2IBr1v0wJvNtFD6v063zDQ5jRPHxK2syYYYDRjoSTm1elL6SUgLv7K6QZoysEXkj2xEO4y5fEvo67O1rL9lXBC57gNEEPLK9TR0IpWjgTTD4tFTONledsNGerNx6GX3GgGy3zSZpSWEdUFXn4DnFsaHoUH/nfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716293552; c=relaxed/simple;
	bh=h0Oo0u4hQ+QRXSLJiXBTA++cyqDIus27IbVzDtn13Ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSVMexL0LaZeXSdv4SLyVc/aKuiojoGpxmj/qWs0nTYY/qRgW886eTXCU2pw0Du3ptze3CcgkJaGAEXklfhxzKcjaEf8QjJ6u6b1wDy7O1Lf8wrMiYqiaUYfwmKp7wqO5qB26I9+tA/b+fh+sfmReFE4Q8mowU905qpMMEqfPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bZd2oRfu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LCC5ng103274;
	Tue, 21 May 2024 07:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716293525;
	bh=VA+sG18CvzhI4DKfHZ9IEpAa6kujOkUdi/5UyYLhoRg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=bZd2oRfuR9ZwysK9K94z5AOvJ8vnnOm2KUenLR/dXrockW9bL4C0jI5fv1bxCTlqx
	 ngO5SibvjY8HtCeJ+CPYaOfgR1/d++E4w9EPe8/jfek5VzNMAT1+U3+zRQlseqZ9Vj
	 0gBMA5xtN5sJ0oOus/rjGKFH9aqbQIWyiab8gZIg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LCC5Kl072918
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 07:12:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 07:12:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 07:12:05 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LCC42T030983;
	Tue, 21 May 2024 07:12:05 -0500
Date: Tue, 21 May 2024 17:42:03 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <corbet@lwn.net>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <misael.lopez@ti.com>, <srk@ti.com>
Subject: Re: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc
 for CPSW Proxy Client
Message-ID: <0b0c1b07-756e-439e-bfc5-53824fd2a61c@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sun, May 19, 2024 at 05:31:16PM +0200, Andrew Lunn wrote:
> On Sat, May 18, 2024 at 06:12:07PM +0530, Siddharth Vadapalli wrote:
> > The CPSW Proxy Client driver interfaces with Ethernet Switch Firmware on
> > a remote core to enable Ethernet functionality for applications running
> > on Linux. The Ethernet Switch Firmware (EthFw) is in control of the CPSW
> > Ethernet Switch on the SoC and acts as the Server, offering services to
> > Clients running on various cores.
> 
> I'm not sure we as a community what this architecture. We want Linux
> to be driving the hardware, not firmware. So expect linux to be
> running the server.
> 
> > +The "am65-cpsw-nuss.c" driver in Linux at:
> > +drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +provides Ethernet functionality for applications on Linux.
> > +It also handles both the control-path and data-path, namely:
> > +Control => Configuration of the CPSW Peripheral
> > +Data => Configuration of the DMA Channels to transmit/receive data
> 
> So nuss is capable of controlling the hardware. nuss has an upper
> interface which is switchdev, and a lower interface which somehow acts
> on the hardware, maybe invoking RPCs into the firmware?
> 
> So it is not too big a step to put the server functionality in Linux,
> on top of the nuss driver.

Andrew,

Thank you for reviewing the patch and sharing your feedback. While I
have come across other Switch Designs / Architecture, I am yet to go
through the one you have mentioned below. I will go through it in detail
and will follow up with my understanding in a future reply. This reply
is intended to be an acknowledgment that I have read your feedback.
I also wanted to clarify the use-case which this series targets. The
requirements of the use-case are:
1. Independent Ethernet Switch functionality: Switch operation and
configuration when Linux is not functional (Fast startup, Low Power
Mode, Safety use-cases).
2. Dynamic Ethernet Switch configuration changes performed based on the
applications which run on various cores.

[...]

Regards,
Siddharth.

