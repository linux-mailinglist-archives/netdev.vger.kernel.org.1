Return-Path: <netdev+bounces-79434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4EA879323
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87162B21AEF
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0B79B7F;
	Tue, 12 Mar 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mvy3VH/e"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047569D0A;
	Tue, 12 Mar 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243458; cv=none; b=bmZyPmPl+DejmJjM/W2QOR9VSbKHYDYlEIRdbdKk8WimCBTdzkS8EYN6RZ3qfWbKBZM+9AyEj0naBj5NF9m19Kd9wclsXqCAuzLBqL0tESmyKIrca+0mPuoknt96LVVnK4b2bHJTgAHTiKpDRCBp493OyVny1BdPQgjYBGSG1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243458; c=relaxed/simple;
	bh=rtuJJhJjSwhFXk7Mc165YJQ7+x0VBGrwR9b8fPEb5Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C6EDGkhaxhg86Xc+D1Py30tYonUjtHcgVopxgMOsYPs/YcADnAzOxKpw6mHY3auePiwUAbAOzzWr7IMUr2Nnh+nuNzSS1hHf1ySmkAJSbPos6SZ94B9h2TOHQiECRIvr2vVFyG/93ji/uDJrdcGAjShxZvCIxQ2AMxRaJv0lzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mvy3VH/e; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CBarAg101235;
	Tue, 12 Mar 2024 06:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710243414;
	bh=AgcSXIuIsHjzqNhDCxq2Q4wqwn8Izu4O6Ezov89bPYk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mvy3VH/eO7/opZUOgyKRE5ZmhdYoYw3xiVbQ7rWps770MChgthluQNvwXoxN+DoTX
	 h73WPUMnU3dGMT045Isk2Tcdtb7nPF2QjlyOuYsMrPEGOYBZOOzt5P0xkJs8MOhg5k
	 1KJv21BFL8UFzpRQlsrv+s9OqlfIPn+Dwmyg0YW4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CBar4k022480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Mar 2024 06:36:53 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 06:36:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 06:36:53 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CBakVX058269;
	Tue, 12 Mar 2024 06:36:46 -0500
Message-ID: <6de512c3-5511-4fee-bd38-8200d87eafa9@ti.com>
Date: Tue, 12 Mar 2024 17:06:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/10] Support ICSSG-based Ethernet on AM65x
 SR1.0 devices
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, <rogerq@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <dan.carpenter@linaro.org>,
        <jacob.e.keller@intel.com>, <robh@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <wsa+renesas@sang-engineering.com>,
        <hkallweit1@gmail.com>, <arnd@arndb.de>, <vladimir.oltean@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <jan.kiszka@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Diogo,

On 05/03/24 5:10 pm, Diogo Ivo wrote:
> Hello,
> 
> This series extends the current ICSSG-based Ethernet driver to support
> AM65x Silicon Revision 1.0 devices.
> 
> Notable differences between the Silicon Revisions are that there is
> no TX core in SR1.0 with this being handled by the firmware, requiring
> extra DMA channels to manage communication with the firmware (with the
> firmware being different as well) and in the packet classifier.
> 
> The motivation behind it is that a significant number of Siemens
> devices containing SR1.0 silicon have been deployed in the field
> and need to be supported and updated to newer kernel versions
> without losing functionality.
> 
> This series is based on TI's 5.10 SDK [1].
> 
> The third version of this patch series can be found in [2].
> 
> Detailed descriptions of the changes in this series can be found in
> each commit's message.
> 
> However, in its current form the driver has two problems:
>  - Setting the link to 100Mbit/s and half duplex results in slower than
>    expected speeds. We have identified that this comes from
>    icssg_rgmii_get_fullduplex() misreporting a full duplex connection
>    and thus we send the wrong command to the firmware.
> 
>  - When using 3 TX channels we observe a timeout on TX queue 0. We have
>    made no real progress on this front in identifying the root cause.
> 
> For both of these topics help from someone more familiar with the hardware
> would be greatly appreciated so that we can support these features rather
> than disable them in the final driver version.
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> [2]: https://lore.kernel.org/netdev/20240221152421.112324-1-diogo.ivo@siemens.com/
> 
> Diogo Ivo (10):
>   dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
>   eth: Move IPv4/IPv6 multicast address bases to their own symbols
>   net: ti: icssg-prueth: Move common functions into a separate file
>   net: ti: icssg-prueth: Add SR1.0-specific configuration bits
>   net: ti: icssg-prueth: Add SR1.0-specific description bits
>   net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
>   net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
>   net: ti: icssg-prueth: Add functions to configure SR1.0 packet
>     classifier
>   net: ti: icssg-prueth: Modify common functions for SR1.0
>   net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0
>     platforms
> 
>  .../bindings/net/ti,icssg-prueth.yaml         |   35 +-
>  drivers/net/ethernet/ti/Kconfig               |   15 +
>  drivers/net/ethernet/ti/Makefile              |    9 +
>  .../net/ethernet/ti/icssg/icssg_classifier.c  |  113 +-
>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 1222 +++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |   14 +-
>  drivers/net/ethernet/ti/icssg/icssg_config.h  |   56 +
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |   10 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 1189 +---------------
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   79 +-
>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 1171 ++++++++++++++++
>  include/linux/etherdevice.h                   |   12 +-
>  12 files changed, 2715 insertions(+), 1210 deletions(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_common.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> 

This series doesn't break any existing functionality of ICSSG driver on
AM654x SR2.0. The series looks ok to me.

For this series,
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

