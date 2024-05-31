Return-Path: <netdev+bounces-99639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260A8D5946
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950551F258E1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892C4500D;
	Fri, 31 May 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XCbOoDV4"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B539FF3;
	Fri, 31 May 2024 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129526; cv=none; b=SgsIPc4/fo/xi2gPYkNkkzKggz5gfpfdVMMp5JdYArE67hWxASkIVca0vhYjWd61/6TU0nUIhlrmTh8WJbZGnZwTaoc5xsDxQd7LehDDPghFaZl/EHoVfg4qBkzWzlsiwIbINBshZFrTBOZmffHBiltw1pjkFqnrFDr6gLEJvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129526; c=relaxed/simple;
	bh=azXToPJBreaYT3oMsV3NXjWxkhfHZAY+ky+oRDOdj8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VDxAiqz0E7gWftVlMTxg1VPyYbS9YE/rFlya13Hy8bdVsNkcqc3HVmgds8/3p+frUK4Lio25u+MeAty6jqrKn8uB589jxsM7MP5/wV2bwePg18wH0zer/wcNLQU01C8x1nesDCcTtDX2yfj8EZEw38VL+H6SbTd9dTGJ8fYq3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XCbOoDV4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V4OnPH116975;
	Thu, 30 May 2024 23:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717129489;
	bh=75wx86d1rasct0BIwNJWvg9dRa0ITHDEy5c6cUcfULc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XCbOoDV4TfBCPfZeP4Kar5sDRjO9t1nsTkBxHM4tUt3KLLLzyx3mUf6OzHKy/Yg42
	 XOTtpt4jAVEY74jZHyLs2yIkYJKTYRpVibiXIFZEURpMZJOmbvAltFPKUdpHU/O7As
	 ujKTXjQzf/H4zychpRCwpSioC6ZdV4qj4+Xxx4jM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V4OnsP049857
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 23:24:49 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 23:24:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 23:24:49 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V4Og8E038918;
	Thu, 30 May 2024 23:24:43 -0500
Message-ID: <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>
Date: Fri, 31 May 2024 09:54:41 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
To: Jacob Keller <jacob.e.keller@intel.com>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@ti.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-3-danishanwar@ti.com>
 <7143f846-623d-465f-a717-8c550407d012@intel.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <7143f846-623d-465f-a717-8c550407d012@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jacob,

On 5/30/2024 11:45 PM, Jacob Keller wrote:
> 
> 
> On 5/29/2024 4:05 AM, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> The ICSSG dual-emac / switch firmware supports Enhanced Scheduled Traffic
>> (EST – defined in P802.1Qbv/D2.2 that later got included in IEEE
>> 802.1Q-2018) configuration. EST allows express queue traffic to be
>> scheduled (placed) on the wire at specific repeatable time intervals. In
>> Linux kernel, EST configuration is done through tc command and the taprio
>> scheduler in the net core implements a software only scheduler
>> (SCH_TAPRIO). If the NIC is capable of EST configuration,user indicate
>> "flag 2" in the command which is then parsed by taprio scheduler in net
>> core and indicate that the command is to be offloaded to h/w. taprio then
>> offloads the command to the driver by calling ndo_setup_tc() ndo ops. This
>> patch implements ndo_setup_tc() to offload EST configuration to ICSSG.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
> 
> I tried to apply this series to review it. Unfortunately It no longer
> applies cleanly since it has textual conflicts with 972383aecf43 ("net:
> ti: icssg-switch: Add switchdev based driver for ethernet switch
> support"), which was part of:
> 
> https://lore.kernel.org/netdev/20240528113734.379422-1-danishanwar@ti.com/
> 
> The conflict seemed easy enough to resolve, but I'm not sure if the
> prueth_qos structure would be placed optimally. I tried to build the
> driver to check what the placement should be and was unable to get
> things to compile.

When I had posted this series (v8) the ICSSG switch series was not
merged yet and I had rebased this series on net-next/main. When you
tested it, the ICSSG Series was merged and as it resulted in conflict.

I will rebase it on the latest net-next and make sure that their is no
conflict and post next revision.

Thanks for your feedback.

-- 
Thanks and Regards,
Md Danish Anwar

