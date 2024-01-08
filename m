Return-Path: <netdev+bounces-62412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0F826FFF
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86031282FBB
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9444C89;
	Mon,  8 Jan 2024 13:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DD44C87
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93CD3C15;
	Mon,  8 Jan 2024 05:37:10 -0800 (PST)
Received: from [10.57.4.107] (unknown [10.57.4.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED213F64C;
	Mon,  8 Jan 2024 05:36:23 -0800 (PST)
Message-ID: <89d33974-81fa-4926-9796-31bcd6d6cdc4@arm.com>
Date: Mon, 8 Jan 2024 13:36:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 08/15] net/mlx5e: Create single netdev per SD group
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-9-saeed@kernel.org>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20231221005721.186607-9-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/12/2023 00:57, Saeed Mahameed wrote:
> From: Tariq Toukan <tariqt@nvidia.com>
> 
> Integrate the SD library calls into the auxiliary_driver ops in
> preparation for creating a single netdev for the multiple devices
> belonging to the same SD group.
> 
> SD is still disabled at this stage. It is enabled by a downstream patch
> when all needed parts are implemented.
> 
> The netdev is created only when the SD group, with all its participants,
> are ready. It is later destroyed if any of the participating devices
> drops.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Hi Tariq,


Currently when booting the kernel against next-master(next-20240108)
with Arm64 on Marvell Thunder X2 (TX2), the kernel is failing to probe
the network card which is resulting in boot failures for our CI (with
rootfs over NFS). I can send the full logs if required. Most other
boards seem fine.

A bisect (full log below) identified this patch as introducing the
failure. Bisected it on the tag "mlx5-updates-2023-12-20" at repo
"https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/".

This works fine on Linux 6.7-rc5


Sample back trace from failure:
------
<3>[   67.915121] mlx5_core 0000:0b:00.1: mlx5_cmd_out_err:808:(pid
1585): ACCESS_REG(0x805) op_mod(0x1) failed, status bad parameter(0x3),
syndrome (0x6c4d48), err(-22)
<3>[   67.915121] mlx5_core 0000:0b:00.1: mlx5_cmd_out_err:808:(pid
1585): ACCESS_REG(0x805) op_mod(0x1) failed, status bad parameter(0x3),
syndrome (0x6c4d48), err(-22)
<4>[   67.945022] mlx5_core.eth: probe of mlx5_core.eth.1 failed with
error -22
<4>[   67.945022] mlx5_core.eth: probe of mlx5_core.eth.1 failed with
error -22
------


Here is the lspci o/p for the card:
------
0b:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
[ConnectX-4 Lx]
    Subsystem: Hewlett Packard Enterprise MT27710 Family [ConnectX-4 Lx]
    Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0,
IOMMU group 0
    Memory at 10000000000 (64-bit, prefetchable) [size=32M]
    Expansion ROM at 43000000 [disabled] [size=1M]
    Capabilities: [60] Express Endpoint, MSI 00
    Capabilities: [48] Vital Product Data
    Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
    Capabilities: [c0] Vendor Specific Information: Len=18 <?>
    Capabilities: [40] Power Management version 3
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
    Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
    Capabilities: [1c0] Secondary PCI Express
    Capabilities: [230] Access Control Services
------


Bisect log:
------
git bisect start
# good: [a39b6ac3781d46ba18193c9dbb2110f31e9bffe9] Linux 6.7-rc5
git bisect good a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
# bad: [22c4640698a1d47606b5a4264a584e8046641784] net/mlx5: Implement
management PF Ethernet profile
git bisect bad 22c4640698a1d47606b5a4264a584e8046641784
# good: [f12f551b5b966ec58bfba9daa15f3cb99a92c1f9] bnxt_en: Prevent TX
timeout with a very small TX ring
git bisect good f12f551b5b966ec58bfba9daa15f3cb99a92c1f9
# good: [509afc7452707e62fb7c4bb257f111617332ffad] Merge branch
'tools-net-ynl-add-sub-message-support-to-ynl'
git bisect good 509afc7452707e62fb7c4bb257f111617332ffad
# good: [0ee28c9ae042e77100fae2cd82a54750668aafce] Merge tag
'wireless-next-2023-12-18' of
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
git bisect good 0ee28c9ae042e77100fae2cd82a54750668aafce
# good: [29c302a2e265a356434b005155990a9e766db75d] libbpf: further
decouple feature checking logic from bpf_object
git bisect good 29c302a2e265a356434b005155990a9e766db75d
# good: [852486b35f344887786d63250946dd921a05d7e8] x86/cfi,bpf: Fix
bpf_exception_cb() signature
git bisect good 852486b35f344887786d63250946dd921a05d7e8
# good: [e37a11fca41864c9f652ff81296b82e6f65a4242] bridge: add MDB state
mask uAPI attribute
git bisect good e37a11fca41864c9f652ff81296b82e6f65a4242
# good: [bee9705c679d0df8ee099e3c5312ac76f447848a] Merge branch
'net-sched-tc-drop-reason'
git bisect good bee9705c679d0df8ee099e3c5312ac76f447848a
# good: [c82d360325112ccc512fc11a3b68cdcdf04a1478] net/mlx5: SD, Add
informative prints in kernel log
git bisect good c82d360325112ccc512fc11a3b68cdcdf04a1478
# bad: [c73a3ab8fa6e93a783bd563938d7cf00d62d5d34] net/mlx5e: Support
cross-vhca RSS
git bisect bad c73a3ab8fa6e93a783bd563938d7cf00d62d5d34
# bad: [c4fb94aa822d6c9d05fc3c5aee35c7e339061dc1] net/mlx5e: Create EN
core HW resources for all secondary devices
git bisect bad c4fb94aa822d6c9d05fc3c5aee35c7e339061dc1
# bad: [e2578b4f983cfcd47837bbe3bcdbf5920e50b2ad] net/mlx5e: Create
single netdev per SD group
git bisect bad e2578b4f983cfcd47837bbe3bcdbf5920e50b2ad
# first bad commit: [e2578b4f983cfcd47837bbe3bcdbf5920e50b2ad]
net/mlx5e: Create single netdev per SD group
------

Thanks,
Aishwarya

