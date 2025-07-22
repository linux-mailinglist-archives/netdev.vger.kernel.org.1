Return-Path: <netdev+bounces-208901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF14B0D80D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CB0547DC5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A02E3B1E;
	Tue, 22 Jul 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y03WOVm4"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBC2E3B07;
	Tue, 22 Jul 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183311; cv=none; b=K/QpmQW5C4+7sbwkyFWcI2cy+Td4x+UcBVCiWmx1qXRagLJck/kAZsVvaCr97ASyQj/6p9WfOjqLNO4Ue+AJ8mxM2lkxb89tjdfGRdbTQRb8VlWMhX9Ry9lcZUirkVpGqBzavRMeY3Jssg60VRA3OkhaFPY3fYket0lgCEqxXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183311; c=relaxed/simple;
	bh=rbdZjDSLrpVj5DtG98YpTOBmbGpCsBPfCraJQUpvKpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B9N4ZblTS2ox2nh3F7lizACn+IScGHljw8+WTkNZJVgSJR69YZtWyvac6xjFkq9tCnTk85FbHIC9v1KvrVo04skVCm3rgYdrWhMDAWOOh1z3o7WtFW59NVN2EuagXY1yOqydjKLrfi+KHpWTkIQ0Lqj7eOc0jZiLvQNjrkZQZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y03WOVm4; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MBKvXT1034159;
	Tue, 22 Jul 2025 06:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753183257;
	bh=gd/G+IQueW+F6ETdxeKKpMhqSGQPrgsgg0P5duEJ5SA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=y03WOVm4GTfsZ8+Axl8kFzgwMK9S660vb2o80D9BFYjYcr06rjXeEFGKCXZ6/Nkeb
	 m9uIwgj13SFznWzVaWUUnnz66MjovSq1AxO8MR0gaf59YOa9DJuXA+ZuRs2JrowmWU
	 0nTaIZ8db5LpJeIA8mO1xiQjQzY8Ek29vWGS7ka8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MBKvM84059187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 06:20:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 06:20:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 06:20:55 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MBKnoe1243770;
	Tue, 22 Jul 2025 06:20:50 -0500
Message-ID: <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
Date: Tue, 22 Jul 2025 16:50:48 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dong,

On 21/07/25 5:02 pm, Dong Yibo wrote:
> Hi maintainers,
> 
> This patch series introduces support for MUCSE N500/N210 1Gbps Ethernet
> controllers. Only basic tx/rx is included, more features can be added in
> the future.
> 
> The driver has been tested on the following platform:
>    - Kernel version: 6.16.0-rc3
>    - Intel Xeon Processor
> 
> Changelog:
> v1 -> v2: 
>   [patch 01/15]:
>   1. Fix changed section in MAINTAINERs file by mistake.
>   2. Fix odd indentaition in 'drivers/net/ethernet/mucse/Kconfig'.
>   3. Drop pointless driver version.
>   4. Remove pr_info prints.
>   5. Remove no need 'memset' for priv after alloc_etherdev_mq.
>   6. Fix __ function names.
>   7. Fix description errors from 'kdoc summry'.
>   [patch 02/15]:
>   1. Fix define by using the BIT() macro.
>   2. Remove wrong 'void *' cast.
>   3. Fix 'reverse Christmas tree' format for local variables.
>   4. Fix description errors from 'kdoc summry'.
>   [patch 03/15]:
>   1. Remove inline functions in C files.
>   2. Remove use s32, use int.
>   3. Use iopoll to instead rolling own.
>   4. Fix description errors from 'kdoc summry'.
>   [patch 04/15]:
>   1. Using __le32/__le16 in little endian define.
>   2. Remove all defensive code.
>   3. Remove pcie hotplug relative code.
>   4. Fix 'replace one error code with another' error.
>   5. Turn 'fw error code' to 'linux/POSIX error code'.
>   6. Fix description errors from 'kdoc summry'.
>   [patch 05/15]:
>   1. Use iopoll to instead rolling own.
>   2. Use 'linux/POSIX error code'.
>   3. Use devlink to download flash.
>   4. Fix description errors from 'kdoc summry'.
>   [patch 06/15] - [patch 15/15]:
>   1. Check errors similar to the patches [1-5].
>   2. Fix description errors from 'kdoc summry'.
> 
> v1: Initial submission
>   https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/T/#t
> 
> 
> Dong Yibo (15):
>   net: rnpgbe: Add build support for rnpgbe
>   net: rnpgbe: Add n500/n210 chip support
>   net: rnpgbe: Add basic mbx ops support
>   net: rnpgbe: Add get_capability mbx_fw ops support
>   net: rnpgbe: Add download firmware for n210 chip
>   net: rnpgbe: Add some functions for hw->ops
>   net: rnpgbe: Add get mac from hw
>   net: rnpgbe: Add irq support
>   net: rnpgbe: Add netdev register and init tx/rx memory
>   net: rnpgbe: Add netdev irq in open
>   net: rnpgbe: Add setup hw ring-vector, true up/down hw
>   net: rnpgbe: Add link up handler
>   net: rnpgbe: Add base tx functions
>   net: rnpgbe: Add base rx function
>   net: rnpgbe: Add ITR for rx
> 

This series has lots of checkpatch errors / warnings.

Before posting the series please try to run checkpatch on all patches.

	./scripts/checkpatch.pl --strict --codespell <PATH_TO_PATCHES>

For patches within net subsystem, for declaring variables, please follow
https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

You can use https://github.com/ecree-solarflare/xmastree to verify
locally before posting.

The series also has kdoc warnings, please run below script on all the
files that the series is modifying.
	./scripts/kernel-doc -none -Wall

>  .../device_drivers/ethernet/index.rst         |    1 +
>  .../device_drivers/ethernet/mucse/rnpgbe.rst  |   21 +
>  MAINTAINERS                                   |    8 +
>  drivers/net/ethernet/Kconfig                  |    1 +
>  drivers/net/ethernet/Makefile                 |    1 +
>  drivers/net/ethernet/mucse/Kconfig            |   35 +
>  drivers/net/ethernet/mucse/Makefile           |    7 +
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   13 +
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  733 ++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  593 +++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   66 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2320 +++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  175 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  901 +++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  623 +++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   49 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  753 ++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  695 +++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    |  476 ++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |   30 +
>  20 files changed, 7501 insertions(+)

7.5K Lines of change is a too much for a series. It becomes very
difficult for maintainers to review a series like this.

Please try to split this into multiple series if possible.

>  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
>  create mode 100644 drivers/net/ethernet/mucse/Kconfig
>  create mode 100644 drivers/net/ethernet/mucse/Makefile
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h
> 


-- 
Thanks and Regards,
Danish

