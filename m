Return-Path: <netdev+bounces-126957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F8973637
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44354B2245F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899B18E76F;
	Tue, 10 Sep 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox0QHVSP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9718C324
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967783; cv=none; b=ECw10JJpP8ADmlqQ0HVWGIJ3UVhBaeYXuw2myoaZZbWeNG8sXYeshVjf9OcL2bviz8BhxVMjvg1rae3Vv9h2/A5MzWsVUYE0gB/FEESOsoB2UsuyMSlHN4/3SJWL0hSupQuCpkgVXxqw6J5Nbeojama1BwmBGM3X99BeUDoxXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967783; c=relaxed/simple;
	bh=aOymGcjhNQMGO581Xxz6C25Se1K1B5nV9H3tOk55OAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Epry1tqlVg//d27/S47J7AB3JEvhwBv6rZIK0o44LVp8YbaNbYAb6Oh5pfjdkGRiwtYdfula6F6IwHdjHblbZr0pRsNikAo3OCTJUCAFMdrWm3gkT2yiUJ9+T95uQw8rBL0W0ywl1ZfPPG6cGEjIKmBGnNjN24lShbejG4amp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ox0QHVSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725967780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3k0Yno5D36yM2/Zcgb354fBW/hkrA2j+HBAI2XgatF0=;
	b=Ox0QHVSPWhe2FTH9xeUKZPLHLP+nmxZKG52tbVSBBTfP0n8Y5sHbJubD1h3xyCMXF/POPB
	jWT3ketA6+BdYAr2/jb8mwDmvXKWbykZoJsia1PEyM7I+VyUu1STUQfLJRmux5hxP56nmg
	DbQrJ+lF0wry1lsDgndf2CvHDQQa86I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-8aRhlme5MAWNrJTUVIc5Cw-1; Tue, 10 Sep 2024 07:29:39 -0400
X-MC-Unique: 8aRhlme5MAWNrJTUVIc5Cw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bacd5cccso2961778f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 04:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725967778; x=1726572578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3k0Yno5D36yM2/Zcgb354fBW/hkrA2j+HBAI2XgatF0=;
        b=X51Zw+DMUL3QvQKE/OiTt1XqUs+25xHKFRnbwznHPktC3LSs6yFa2iNoAto8PCUsQ3
         EXIAeqVkKQb7etmMOCCmf9A93vzeGNcFUnblYooWw0QxePOXazXYK/Gr1xal4MS8nMST
         S4MRz2f2Ff/ZSlGy+8GEoYlAeqUxnSszOvzlG73zjgdEVfvlSh2DGt2a4F43QCDDE1fp
         IpWQusiOhyecORTdbDoYipKMTdAvLexBgjnh+CxtUYdK/XP2KicU6o6IKJ0D4489ddjD
         GMhteVdl+bDC8cA+b8BlBf+I46P6Ynh086uiFVlalo9pqvlRdNcWpX2OFORstrpvk17c
         pRSg==
X-Forwarded-Encrypted: i=1; AJvYcCUHN5Zj+u5THfwqiadBeTATvaO+rry7HodrY1w6MluqDNn2Y5sgUuUoxerZTPkmbWwptwrZeFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5sV0dA4lP0FVzzP0OSOMGadSrv0Yy3bqEkQsJRyD1UKCywzP
	JQnVlGtEIqczHZxRSB/qKE8KprDTYu85nd6/wHMugbhmVOJsForHWPTmOC1lN7Tcrz0S6ecKRsn
	SdrqDu3axbbl+55cDBzZUmZzjuendg1+zRgLASEnYO7V4g1VJYutlRw==
X-Received: by 2002:a05:6000:4581:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-378895d6239mr8374075f8f.32.1725967777786;
        Tue, 10 Sep 2024 04:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY+YEkoOGjNl2+G//8jJ4VdFMDQlFRqdfpWwy9CZc+EaVMXGy/JX1O/pSEqP1jkH3ae8fIng==
X-Received: by 2002:a05:6000:4581:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-378895d6239mr8374039f8f.32.1725967777174;
        Tue, 10 Sep 2024 04:29:37 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3687sm8612612f8f.71.2024.09.10.04.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 04:29:36 -0700 (PDT)
Message-ID: <56c4fccd-787f-4936-9f4b-a1b9ebae6d03@redhat.com>
Date: Tue, 10 Sep 2024 13:29:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: fancer.lancer@gmail.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com,
 xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
 Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch,
 linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com,
 jitendra.vegiraju@broadcom.com, netdev@vger.kernel.org
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 07:48, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> This patchset adds basic PCI ethernet device driver support for Broadcom
> BCM8958x Automotive Ethernet switch SoC devices.
> 
> This SoC device has PCIe ethernet MAC attached to an integrated ethernet
> switch using XGMII interface. The PCIe ethernet controller is presented to
> the Linux host as PCI network device.
> 
> The following block diagram gives an overview of the application.
>               +=================================+
>               |       Host CPU/Linux            |
>               +=================================+
>                          || PCIe
>                          ||
>          +==========================================+
>          |           +--------------+               |
>          |           | PCIE Endpoint|               |
>          |           | Ethernet     |               |
>          |           | Controller   |               |
>          |           |   DMA        |               |
>          |           +--------------+               |
>          |           |   MAC        |   BCM8958X    |
>          |           +--------------+   SoC         |
>          |               || XGMII                   |
>          |               ||                         |
>          |           +--------------+               |
>          |           | Ethernet     |               |
>          |           | switch       |               |
>          |           +--------------+               |
>          |             || || || ||                  |
>          +==========================================+
>                        || || || || More external interfaces
> 
> The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
> scalability.
> 
> Driver functionality specific to new MAC (DW25GMAC) is implemented in
> new file dw25gmac.c.
> 
> Management of integrated ethernet switch on this SoC is not handled by
> the PCIe interface.
> This SoC device has PCIe ethernet MAC directly attached to an integrated
> ethernet switch using XGMII interface.
> 
> v4->v5:
>     Summary of changes in this patch series:
>     As suggested by Serge Semin, defined common setup function for dw25gmac.
>     To accommodate early adopter DW25GMAC used in BCM8958x device, provide
>     a mechanism to override snps_id and snps_dev_id used for driver entry
>     matching in hwif.c
> 
>     Patch1:
>       Added plat_stmmacenet_data::snps_id,snps_dev_id fields - Serge Semin
>     Patch2:
>       Define common setup function for dw25gmac_setup() - Serge Semin
>       Support DW25GMAC IPs with varying VDMA/PDMA count - Abhishek Chauhan
>       Allocate and initialize hdma mapping configuration data dynamically
>       based on device's VDMA/PDMA feature capabilities in dw25gmac_setup().
>       Spelling errors in commit log, lower case 0x for hex -Amit Singh Tomar
>     Patch3:
>       Glue support in hwif.c for DW25GMAC in hwif.c - Serge Semin
>       Provide an option to override snps_id and snps_dev_id when the device
>       reports version info not conformant with driver's expectations as is
>       the case with BCM8958x device. - Serge Semin
>     Patch4:
>       Remove setup function in the glue driver - Serge Semin
>       Remove unnecessary calls pci_enable_device() and pci_set_master()
>       in dwxgmac_brcm_pci_resume() - Jakub Kicinski
>       Merge variable definitions to single line - Amit Singh Tomar
> 
> v3->v4:
>     Based on Serge's questions, received a confirmation from Synopsys that
>     the MAC IP is indeed the new 25GMAC design.
>     Renamed all references of XGMAC4 to 25GMAC.
>     The patch series is rearranged slightly as follows.
>     Patch1 (new): Define HDMA mapping data structure in kernel's stmmac.h
>     Patch2 (v3 Patch1): Adds dma_ops for dw25gmac in stmmac core
>         Renamed new files dwxgmac4.* to dw25gmac.* - Serge Semin
>         Defined new Synopsis version and device id macros for DW25GMAC.
>         Converted bit operations to FIELD_PREP macros - Russell King
>         Moved hwif.h to this patch, Sparse flagged warning - Simon Horman
>         Defined macros for hardcoded values TDPS etc - Serge Semin
>         Read number of PDMAs/VDMAs from hardware - Serge Semin
>     Patch3 (v3 Patch2): Hooks in hardware interface handling for dw25gmac
>         Resolved user_version quirks questions - Serge, Russell, Andrew
>         Added new stmmac_hw entry for DW25GMAC. - Serge
>         Added logic to override synopsis_dev_id by glue driver.
>     Patch4 (v3 Patch3): Adds PCI driver for BCM8958x device
>         Define bitmmap macros for hardcoded values - Andrew Lunn
>         Added per device software node - Andrew Lunn
>     Patch5(new/split): Adds BCM8958x driver to build system
>     https://lore.kernel.org/netdev/20240814221818.2612484-1-jitendra.vegiraju@broadcom.com/
> 
> v2->v3:
>     Addressed v2 comments from Andrew, Jakub, Russel and Simon.
>     Based on suggestion by Russel and Andrew, added software node to create
>     phylink in fixed-link mode.
>     Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
>     in stmmac core module.
>     Reorganized the code to use the existing glue logic support for xgmac in
>     hwif.c and override ops functions for dwxgmac4 specific functions.
>     The patch is split into three parts.
>       Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
>       Patch#2 Hooks in the hardware interface handling for dwxgmac4
>       Patch#3 Adds PCI driver for BCM8958x device
>     https://lore.kernel.org/netdev/20240802031822.1862030-1-jitendra.vegiraju@broadcom.com/
> 
> v1->v2:
>     Minor fixes to address coding style issues.
>     Sent v2 too soon by mistake, without waiting for review comments.
>     Received feedback on this version.
>     https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/
> 
> v1:
>     https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/
> 
> Jitendra Vegiraju (5):
>    Add HDMA mapping for dw25gmac support
>    Add basic dw25gmac support in stmmac core
>    Integrate dw25gmac into stmmac hwif handling
>    Add PCI driver support for BCM8958x
>    Add BCM8958x driver to build system
> 
>   MAINTAINERS                                   |   8 +
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
>   drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
>   .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 224 ++++++++
>   .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++
>   .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 507 ++++++++++++++++++
>   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  43 ++
>   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
>   drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
>   drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>   include/linux/stmmac.h                        |  48 ++
>   13 files changed, 997 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

Hi Serge, to you think you will have time to review this series soon?

We are sort in a rush to flush the net-next material before the upcoming 
merge window.

Thanks,

Paolo


