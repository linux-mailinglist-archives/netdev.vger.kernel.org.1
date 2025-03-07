Return-Path: <netdev+bounces-173092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA1A57278
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A8D7A641C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B125485E;
	Fri,  7 Mar 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y2tbYJSD"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643521859D;
	Fri,  7 Mar 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376986; cv=none; b=VAAl9Aq7AHP997w80JCblrRb+XNbPzG3Gvaw+JeB6DGTUeEBS++j9KHr5eZkq9z8bpi+V2X4EwU9q0+tMJar9HobB5ZoJ/ezmlROwkA4sd/T1316YX/0zboCsofmotkbyy9gmlxbvOO/JFID1HukBlTFpnRrLwRrEbkjsLkakRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376986; c=relaxed/simple;
	bh=TukhM5KfrnykmpRsPrYHap4TTY4YTDzqHtaP7gRPqLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpdvnTlQICin1cJYucEvF+gluLXZVHBD/bNihs2W1Etlinm0HQHZqV8skATXgTH5o4RJaeCpFbfuvsQ5i5mOg/PVWZ1jVxEjv2/p3URMIr12YZJo3FjFrLE5b6f77Hu2ykb5NiwcX/swzDz45eBSZMtAhAdnZkvNDe7+1LHYagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y2tbYJSD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527JlIFS4055826
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Mar 2025 13:47:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741376838;
	bh=7MSwLxTEPEB7snYOzkakSs7OVnf7mnb46OQFG90frxc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Y2tbYJSDFXtb3qSItccHoXSTovU+G8ZIHcDkpgt0qh+7JsRIao8dT8ZNiFm+djIOT
	 mv5xUKzEcQugm2lxrxWpdUuKsJGmA2E7sUR8pccE5cGFJyRIIwjAr8U+ruPqX1wqyH
	 ARsPzPF1GEpfesp4iIYc6GHzIr+qfutYDJph480w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527JlIOk107175;
	Fri, 7 Mar 2025 13:47:18 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 13:47:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 13:47:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527JlHRK114562;
	Fri, 7 Mar 2025 13:47:17 -0600
Date: Fri, 7 Mar 2025 13:47:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Parvathi Pudi <parvathi@couthit.com>
CC: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
        andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
        edumazet
	<edumazet@google.com>, kuba <kuba@kernel.org>,
        pabeni <pabeni@redhat.com>, robh <robh@kernel.org>,
        krzk+dt <krzk+dt@kernel.org>, conor+dt
	<conor+dt@kernel.org>,
        ssantosh <ssantosh@kernel.org>,
        richardcochran
	<richardcochran@gmail.com>,
        basharath <basharath@couthit.com>, schnelle
	<schnelle@linux.ibm.com>,
        diogo ivo <diogo.ivo@siemens.com>, m-karicheri2
	<m-karicheri2@ti.com>,
        horms <horms@kernel.org>, jacob e keller
	<jacob.e.keller@intel.com>,
        m-malladi <m-malladi@ti.com>,
        "javier carrasco
 cruz" <javier.carrasco.cruz@gmail.com>,
        afd <afd@ti.com>, s-anna
	<s-anna@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>,
        srk <srk@ti.com>, rogerq <rogerq@ti.com>,
        krishna
	<krishna@couthit.com>, pmohan <pmohan@couthit.com>,
        mohan <mohan@couthit.com>
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
Message-ID: <20250307194717.isd2yv5qvuwe6jgp@strongly>
References: <20250214054702.1073139-1-parvathi@couthit.com>
 <20250226184408.d4gpr3uu2dm7oxa2@handwork>
 <506678778.717678.1740740287558.JavaMail.zimbra@couthit.local>
 <1229872038.768025.1741268586173.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1229872038.768025.1741268586173.JavaMail.zimbra@couthit.local>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 19:13-20250306, Parvathi Pudi wrote:
> Hi,
> 
> >> On 11:16-20250214, parvathi wrote:
> >> [...]
> >>> The patches presented in this series have gone through the patch verification
> >>> tools and no warnings or errors are reported. Sample test logs verifying the
> >>> functionality on Linux next kernel are available here:
> >>> 
> >>> [Interface up
> >>> Testing](https://gist.github.com/ParvathiPudi/f481837cc6994e400284cb4b58972804)
> >>> 
> >>> [Ping
> >>> Testing](https://gist.github.com/ParvathiPudi/a121aad402defcef389e93f303d79317)
> >>> 
> >>> [Iperf
> >>> Testing](https://gist.github.com/ParvathiPudi/581db46b0e9814ddb5903bdfee73fc6f)
> >>> 
> >> 
> >> 
> >> I am looking at
> >> https://lore.kernel.org/all/20250214085315.1077108-11-parvathi@couthit.com/
> >> and wondering if i can see the test log for am335x and am47xx to make
> >> sure that PRUs are functional on those two?
> >> 
> > 
> > In this patch series we have added support for PRU-ICSS on the AM57x SOC.
> > Hence the test log was only included for the AM57x SOC. We are working in
> > parallel
> > to add support for PRU-ICSS on the AM33x and AM43x SOC's as well. We will send
> > it as
> > a separate patch series at a later time.
> > 
> 
> Further update:
> 
> We have successfully cross compiled the kernel (linux-next) with this patch series
> for AM335x and AM437x SOC respectively.
> 
> Kernel is booting well on both the SOCs and we have verified PRU functionality by
> loading simple example application (pru_addition.elf) on the PRU cores, by using
> "remoteproc" driver from mainline kernel.
> 
> Below are the logs for the SOCs with boot log and running PRU with elf file specified
> above:
> 
> AM335x test log: <https://gist.github.com/ParvathiPudi/87d7ddf949913b80f022ed99706337ac>
> AM437x test log: <https://gist.github.com/ParvathiPudi/b2d556829cb4a9e3b6b4c5656dbdd594>


Thanks for testing this, I just got some time to dig further, I will
respond on the standalone patch
https://lore.kernel.org/all/20250108125937.10604-2-basharath@couthit.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

