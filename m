Return-Path: <netdev+bounces-214679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4154B2ADA3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A82B566B78
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083633EB17;
	Mon, 18 Aug 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AVVl5XMf"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D733EAFE;
	Mon, 18 Aug 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532942; cv=none; b=aniZRM+xSJTb/l/cxw/EVTBmg/qeToDCalFo1F6/YMd4R23UcEc5EXIHkWxygvvKfvJ/xnQ4KbQyvhsi99WWsLTFiDZHw8uRD+1WBARws0jh9IBAMGS8sQsZHCIRDp+32bilNawd/J3tJIEPF+8Jme0xjTs+L438XSpBKWHtRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532942; c=relaxed/simple;
	bh=txUHouZLKUWwHajaGL1FV2nk8iPMV70N590D30ieBTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hhlla6SmLalReKJYZ1UdeECnsGIu1Ya9/Lnhir/9z7rhjdpUs6Wn1kzxfSEO/T1a/vAX4S4Xlb/0oi+6/iEAbtRxRgKKjIG1bLE8pev0qaDrNmf4jqxTbK0LfmMQIl4Tj3VNZWfNejzETN8usbwuFde+H+4T7FejnfnqmvTsvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AVVl5XMf; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IFxW592750304;
	Mon, 18 Aug 2025 10:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755532772;
	bh=nL/RHFpr+seUeTtCfnfSwBjUy081h6/HTNiT4CEr7Ek=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AVVl5XMfoZzhwTCK0DHjcq7KFtLg/pkBIswc+g/F2n7ii8mky8Gs3UkZjbUjtF6mH
	 A29TsFpEqRQAJLPFL82mVFF311UhhAlNnU/AaIgQCjDO55vVU1xCeKLcuRi3NCDLt3
	 m9ID2Xobqlf/lN6/8C7/lKabAb7XmbKkl5OtmKSs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IFxWfj3919372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 10:59:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 10:59:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 10:59:31 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IFxHMO1277663;
	Mon, 18 Aug 2025 10:59:17 -0500
Message-ID: <8ad6bb71-9ce5-414a-bbf6-b9893b88cb4f@ti.com>
Date: Mon, 18 Aug 2025 21:29:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 0/5] PRU-ICSSM Ethernet Driver
To: Parvathi Pudi <parvathi@couthit.com>, <danishanwar@ti.com>,
        <rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <ssantosh@kernel.org>, <richardcochran@gmail.com>, <m-malladi@ti.com>,
        <s.hauer@pengutronix.de>, <afd@ti.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <johan@kernel.org>, <m-karicheri2@ti.com>,
        <s-anna@ti.com>, <glaroque@baylibre.com>, <saikrishnag@marvell.com>,
        <kory.maincent@bootlin.com>, <diogo.ivo@siemens.com>,
        <javier.carrasco.cruz@gmail.com>, <basharath@couthit.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vadim.fedorenko@linux.dev>, <alok.a.tiwari@oracle.com>,
        <bastien.curutchet@bootlin.com>, <pratheesh@ti.com>, <prajith@ti.com>,
        <vigneshr@ti.com>, <praneeth@ti.com>, <srk@ti.com>, <rogerq@ti.com>,
        <krishna@couthit.com>, <pmohan@couthit.com>, <mohan@couthit.com>
References: <20250812110723.4116929-1-parvathi@couthit.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250812110723.4116929-1-parvathi@couthit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Parvathi

On 8/12/2025 4:35 PM, Parvathi Pudi wrote:
> Hi,
> 
> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> Megabit ICSS (ICSSM).
> 
> Support for ICSSG Dual-EMAC mode has already been mainlined [1] and the
> fundamental components/drivers such as PRUSS driver, Remoteproc driver,
> PRU-ICSS INTC, and PRU-ICSS IEP drivers are already available in the mainline
> Linux kernel. The current set of patch series builds on top of these components
> and introduces changes to support the Dual-EMAC using ICSSM on the TI AM57xx,
> AM437x and AM335x devices.
> 
> AM335x, AM437x and AM57xx devices may have either one or two PRU-ICSS instances
> with two 32-bit RISC PRU cores. Each PRU core has (a) dedicated Ethernet interface
> (MII, MDIO), timers, capture modules, and serial communication interfaces, and
> (b) dedicated data and instruction RAM as well as shared RAM for inter PRU
> communication within the PRU-ICSS.
> 
> These patches add support for basic RX and TX  functionality over PRU Ethernet
> ports in Dual-EMAC mode.
> 
> Further, note that these are the initial set of patches for a single instance of
> PRU-ICSS Ethernet.  Additional features such as Ethtool support, VLAN Filtering,
> Multicast Filtering, Promiscuous mode, Storm prevention, Interrupt coalescing,
> Linux PTP (ptp4l) Ordinary clock and Switch mode support for AM335x, AM437x
> and AM57x along with support for a second instance of  PRU-ICSS on AM57x
> will be posted subsequently.
> 
> The patches presented in this series have gone through the patch verification
> tools and no warnings or errors are reported. Sample test logs obtained from AM33x,
> AM43x and AM57x verifying the functionality on Linux next kernel are available here:
> 
> [Interface up Testing](https://gist.github.com/ParvathiPudi/e24ae1971258b689c411bf6d8b504576)
> 
> [Ping Testing](https://gist.github.com/ParvathiPudi/6077cc7ab71eb0bc62ef0435ce9a5572)
> 
> [Iperf Testing](https://gist.github.com/ParvathiPudi/54aec8d6aaa1149b68589af9c8511b23)
> 
> [1] https://lore.kernel.org/all/20230106121046.886863-1-danishanwar@ti.com/
> [2] https://lore.kernel.org/all/20250108125937.10604-1-basharath@couthit.com/
> 
> This is the v13 of the patch series [v1]. This version of the patchset
> addresses the comments made on [v12] of the series.
> 
> Changes from v12 to v13 :
> 
> *) Addressed Alok Tiwari comments on patch 2, 3 and 5 of the series.
> *) Addressed Bastien Curutchet comment on patch 2 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v11 to v12 :
> 
> *) Addressed Jakub Kicinski's comments on patch 2 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v10 to v11 :
> 
> *) Reduced patch series size by removing features such as Ethtool support,
> VLAN filtering, Multicast filtering, Promiscuous mode handling, Storm Prevention,
> Interrupt coalescing, and Linux PTP (ptp4l) ordinary clock support. This was done
> based on Jakub Kicinski's feedback regarding the large patch size (~5kLoC).
> Excluded features will be resubmitted.
> *) Addressed Jakub Kicinski comments on patch 2, and 3 of the series.
> *) Addressed Jakub Kicinski's comment on patch 4 of the series by implementing
> hrtimer based TX resume logic to notify upper layers in case of TX busy.
> *) Rebased the series on latest net-next.
> 
> Changes from v9 to v10 :
> 
> *) Addressed Vadim Fedorenko comments on patch 6 and 11 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v8 to v9 :
> 
> *) Addressed Vadim Fedorenko comments on patch 6 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v7 to v8 :
> 
> *) Addressed Paolo Abeni comments on patch 3 and 4 of the series.
> *) Replaced threaded IRQ logic with NAPI logic based on feedback from Paolo Abeni.
> *) Added Reviewed-by: tag from Rob Herring for patch 1.
> *) Rebased the series on latest net-next.
> 
> Changes from v6 to v7 :
> 
> *) Addressed Rob Herring comments on patch 1 of the series.
> *) Addressed Jakub Kicinski comments on patch 4, 5 and 6 of the series.
> *) Addressed Alok Tiwari comments on Patch 1, 4 and 5 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v5 to v6 :
> 
> *) Addressed Simon Horman comments on patch 2, 7 and 11 of the series.
> *) Addressed Andrew Lunn comments on patch 5 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v4 to v5 :
> 
> *) Addressed Andrew Lunn and Keller, Jacob E comments on patch 5 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v3 to v4 :
> 
> *) Added support for AM33x and AM43x platforms.
> *) Removed SOC patch [2] and its dependencies.
> *) Addressed Jakub Kicinski, MD Danish Anwar and Nishanth Menon comments on cover
>    letter of the series.
> *) Addressed Rob Herring comments on patch 1 of the series.
> *) Addressed Ratheesh Kannoth comments on patch 2 of the series.
> *) Addressed Maxime Chevallier comments on patch 4 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v2 to v3 :
> 
> *) Addressed Conor Dooley comments on patch 1 of the series.
> *) Addressed Simon Horman comments on patch 2, 3, 4, 5 and 6 of the series.
> *) Addressed Joe Damato comments on patch 4 of the series.
> *) Rebased the series on latest net-next.
> 
> Changes from v1 to v2 :
> 
> *) Addressed Andrew Lunn, Rob Herring comments on patch 1 of the series.
> *) Addressed Andrew Lunn comments on patch 2, 3, and 4 of the series.
> *) Addressed Richard Cochran, Jason Xing comments on patch 6 of the series.
> *) Rebased patchset on next-202401xx linux-next.
> 
> [v1] https://lore.kernel.org/all/20250109105600.41297-1-basharath@couthit.com/
> [v2] https://lore.kernel.org/all/20250124122353.1457174-1-basharath@couthit.com/
> [v3] https://lore.kernel.org/all/20250214054702.1073139-1-parvathi@couthit.com/
> [v4] https://lore.kernel.org/all/20250407102528.1048589-1-parvathi@couthit.com/
> [v5] https://lore.kernel.org/all/20250414113458.1913823-1-parvathi@couthit.com/
> [v6] https://lore.kernel.org/all/20250423060707.145166-1-parvathi@couthit.com/
> [v7] https://lore.kernel.org/all/20250503121107.1973888-1-parvathi@couthit.com/
> [v8] https://lore.kernel.org/all/20250610105721.3063503-1-parvathi@couthit.com/
> [v9] https://lore.kernel.org/all/20250623135949.254674-1-parvathi@couthit.com/
> [v10] https://lore.kernel.org/all/20250702140633.1612269-1-parvathi@couthit.com/
> [v11] https://lore.kernel.org/all/20250722132700.2655208-1-parvathi@couthit.com/
> [v12] https://lore.kernel.org/all/20250724072535.3062604-1-parvathi@couthit.com/
> 
> Thanks and Regards,
> Parvathi.
> 
> Parvathi Pudi (2):
>   dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for
>     AM57xx, AM43xx and AM33xx SOCs
>   net: ti: prueth: Adds IEP support for PRUETH on AM33x, AM43x and AM57x
>     SOCs
> 
> Roger Quadros (3):
>   net: ti: prueth: Adds ICSSM Ethernet driver
>   net: ti: prueth: Adds PRUETH HW and SW configuration
>   net: ti: prueth: Adds link detection, RX and TX support.
> 

Can you please use prefix "net: ti: icssm-prueth" instead of net: ti:
prueth" throughout the series?

icssg driver uses prefix "net: ti: icssg-prueth" so this will be similar
to that.

This way grepping in git log for,
- icssm will give you only icssm patches
- icssg will give you only icssg patches
- prueth will give you both icssm and icssg patches

-- 
Thanks and Regards,
Md Danish Anwar


