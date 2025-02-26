Return-Path: <netdev+bounces-169957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC831A46A10
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A240E7A2C05
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51E236428;
	Wed, 26 Feb 2025 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pBfjg8U5"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D722D784;
	Wed, 26 Feb 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595594; cv=none; b=AjOJKyojRLnb87yukzz42YRU8Zom4pn9d6neejomCERG73ZfJfHEOgn1FR/RPCifR4W8SsQBKRgzAnO3UH6c8iZwURIWiLXszzITYxs2mmGNyKtoopR179NEP0WrrARi/u21SBs87mCwy/r7Gww8RT8ORkKssM1I4HvKnSTeJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595594; c=relaxed/simple;
	bh=av0A0EgMmZuF7k4uVACqRkbAc5DuEtFyJ21KJyF35nw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSZ0plLOTJjr1zBeIFDsNVtw+VX6z1E723wdxSY5pfR5aKKPSEDHJOGNPt0e9CZY2VZ230nNheNLLlo326MRT9MhqMwVEfTUDgayGSDkrNjWFbfiqPUXzZbaKQWy8JGyTG+tDcPiP/I6C8hx1VXfgcTaM5FUW9wNl3Ehkh09juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pBfjg8U5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QIi9ms2156450
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:44:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740595450;
	bh=esbbA0aHxV2C7K7XPMRSKO3A35omNfgqBS1hPBjtmXg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pBfjg8U5jkATBCxBRPgW1hxkKxkjGDHEVGISh7VcEj5YIYrbU+fYbnsayWPzlFKcI
	 47JaBvj4ZjrahbShEttZOLhtpYWrZvE+Dn2iMeKZduVs2P1eJ3xxTWysLT/29QlYTd
	 cP2MVrU0/cHm+OCLt+4sGqm7SAwgQRmoH/hTrANA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QIi9GH029156
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 12:44:09 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 12:44:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 12:44:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QIi8S8076566;
	Wed, 26 Feb 2025 12:44:08 -0600
Date: Wed, 26 Feb 2025 12:44:08 -0600
From: Nishanth Menon <nm@ti.com>
To: parvathi <parvathi@couthit.com>
CC: <danishanwar@ti.com>, <rogerq@kernel.org>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <ssantosh@kernel.org>,
        <richardcochran@gmail.com>, <basharath@couthit.com>,
        <schnelle@linux.ibm.com>, <diogo.ivo@siemens.com>,
        <m-karicheri2@ti.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <javier.carrasco.cruz@gmail.com>, <afd@ti.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pratheesh@ti.com>, <prajith@ti.com>,
        <vigneshr@ti.com>, <praneeth@ti.com>, <srk@ti.com>, <rogerq@ti.com>,
        <krishna@couthit.com>, <pmohan@couthit.com>, <mohan@couthit.com>
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
Message-ID: <20250226184408.d4gpr3uu2dm7oxa2@handwork>
References: <20250214054702.1073139-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250214054702.1073139-1-parvathi@couthit.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:16-20250214, parvathi wrote:
[...]
> The patches presented in this series have gone through the patch verification
> tools and no warnings or errors are reported. Sample test logs verifying the
> functionality on Linux next kernel are available here:
> 
> [Interface up Testing](https://gist.github.com/ParvathiPudi/f481837cc6994e400284cb4b58972804)
> 
> [Ping Testing](https://gist.github.com/ParvathiPudi/a121aad402defcef389e93f303d79317)
> 
> [Iperf Testing](https://gist.github.com/ParvathiPudi/581db46b0e9814ddb5903bdfee73fc6f)
> 


I am looking at https://lore.kernel.org/all/20250214085315.1077108-11-parvathi@couthit.com/
and wondering if i can see the test log for am335x and am47xx to make
sure that PRUs are functional on those two?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

