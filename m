Return-Path: <netdev+bounces-222208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C23CB538A9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC116462D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CA34F497;
	Thu, 11 Sep 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GTl8MfBr"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB2322DB5;
	Thu, 11 Sep 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606695; cv=none; b=BvJGbSaUMetY+IUsqsd1Rnt/eHGZvNQTr+laDbMoORyqdiM/kghToIiYVpZYp+ifzs/wDSdrhJB2FGR/J/3It/QQ31+e2eFNO027/6MlQiHZ5nKB7z23uR09M6av45/6FrgzwTIW9IE1Uj2pCz/aEuFVsgKWTCc8NpIG0uLv+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606695; c=relaxed/simple;
	bh=Rg1cLGPHrDGi6eu2u7u9y4lqNZzrSGrthed4Rc2DdIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syjPuuZjKHYDBYJqR90ZbT2NAUxIimA/9Gh8PBh3fxwDXEDoMfmVNmce4jKtsON7qE/i+/sUykhoOt+SrPMUV18ZcoM3U+Vyr0Cbiro7ARqXRcD0EfpV8hX/luVsaqVN92bIvdNSIw2lnPDqykem851ti5aXfgKPXZ8wZl6NrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GTl8MfBr; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BG44O7782625;
	Thu, 11 Sep 2025 11:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757606644;
	bh=gnk++fDRlR1tET7Jo2SrqfiscV2zrd53RgS0QDeJAgk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GTl8MfBrW6VXw5f/iRgISeTDyxOovQJpbLknnUFJfl40SYWBPzNyRYJLdnlLjW1+D
	 y3BiEOZbrimiQK8QcLWrIxlvMCLhyoA1aZ0d937U2Jpcr1gv2oklFP3XR6fNF3+3bo
	 5IXNS0xWD9GjKcjNYvVfbWJAIboG2M029V0Xr+kE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BG43ZG1170996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 11:04:03 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 11:04:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 11:04:03 -0500
Received: from [128.247.81.0] (ula0226330.dhcp.ti.com [128.247.81.0] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BG43nf2080997;
	Thu, 11 Sep 2025 11:04:03 -0500
Message-ID: <8a20160e-1528-4d0e-9347-0561fc3426b4@ti.com>
Date: Thu, 11 Sep 2025 11:04:02 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/7] Add RPMSG Ethernet Driver
To: MD Danish Anwar <danishanwar@ti.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
	<nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Xin Guo <guoxin09@huawei.com>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20250911113612.2598643-1-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250911113612.2598643-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/11/25 6:36 AM, MD Danish Anwar wrote:
> This patch series introduces the RPMSG Ethernet driver, which provides a
> virtual Ethernet interface for communication between a host processor and
> a remote processor using the RPMSG framework. The driver enables
> Ethernet-like packet transmission and reception over shared memory,
> facilitating inter-core communication in systems with heterogeneous
> processors.
> 

This is neat and all but I have to ask: why? What does this provide
that couldn't be done with normal RPMSG messages? Or from a userspace
TAP/TUN driver on top of RPMSG?

This also feels like some odd layering, as RPMSG sits on virtio, and
we have virtio-net, couldn't we have a firmware just expose that (or
would the firmware be vhost-net..)?

Andrew

> Key features of this driver:
> 
> 1. Virtual Ethernet interface using RPMSG framework
> 2. Shared memory-based packet transmission and reception
> 3. Support for multicast address filtering
> 4. Dynamic MAC address assignment
> 5. NAPI support for efficient packet processing
> 6. State machine for managing interface states
> 
> This driver is designed to be generic and vendor-agnostic. Vendors can
> develop firmware for the remote processor to make it compatible with this
> driver by adhering to the shared memory layout and communication protocol
> described in the documentation.
> 
> This patch series has been tested on a TI AM64xx platform with a
> compatible remote processor firmware. Feedback and suggestions for
> improvement are welcome.
> 
> Changes from v3 to v4:
> - Addressed comments from Parthiban Veerasooran regarding return values in
>    patch 4/7
> - Added "depends on REMOTEPROC" in Kconfig entry for RPMSG_ETH as it uses a
>    symbol from REMOTEPROC driver.
> 
> Changes from v2 to v3:
> - Removed the binding patches as suggested by Krzysztof Kozlowski <krzk@kernel.org>
> - Dropped the rpmsg-eth node. The shared memory region is directly added to the
>    "memory-region" in rproc device.
> - Added #include <linux/io.h> header for memory mapping operations
> - Added vendor-specific configuration through rpmsg_eth_data structure
> - Added shared memory region index support with shm_region_index parameter
> - Changed RPMSG channel name from generic "shm-eth" to vendor-specific "ti.shm-eth"
> - Fixed format string warning using %zu instead of %lu for size_t type
> - Updated Documentation to include shm_region_index
> - Added MAINTAINERS entry for the driver
> 
> v3 https://lore.kernel.org/all/20250908090746.862407-1-danishanwar@ti.com/
> v2 https://lore.kernel.org/all/20250902090746.3221225-1-danishanwar@ti.com/
> v1 https://lore.kernel.org/all/20250723080322.3047826-1-danishanwar@ti.com/
> 
> MD Danish Anwar (7):
>    net: rpmsg-eth: Add Documentation for RPMSG-ETH Driver
>    net: rpmsg-eth: Add basic rpmsg skeleton
>    net: rpmsg-eth: Register device as netdev
>    net: rpmsg-eth: Add netdev ops
>    net: rpmsg-eth: Add support for multicast filtering
>    MAINTAINERS: Add entry for RPMSG Ethernet driver
>    arch: arm64: dts: k3-am64*: Add shared memory region
> 
>   .../device_drivers/ethernet/index.rst         |   1 +
>   .../device_drivers/ethernet/rpmsg_eth.rst     | 424 ++++++++++++
>   MAINTAINERS                                   |   6 +
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  11 +-
>   drivers/net/ethernet/Kconfig                  |  11 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/rpmsg_eth.c              | 653 ++++++++++++++++++
>   drivers/net/ethernet/rpmsg_eth.h              | 294 ++++++++
>   8 files changed, 1399 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
>   create mode 100644 drivers/net/ethernet/rpmsg_eth.c
>   create mode 100644 drivers/net/ethernet/rpmsg_eth.h
> 
> 
> base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a


