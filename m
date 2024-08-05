Return-Path: <netdev+bounces-115758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F1947B4C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDA228201A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712C15958E;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31831158DDC;
	Mon,  5 Aug 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862446; cv=none; b=Sb7C5pbmrRM/NLVgaBkWFPm44coYdaxv1EgCxvwCTbg5S7ynGNRAIYB65g3SkNmXnWzW/KnCH3E6urWDvHOqPWIJtB5IKVOqNzyvs3FuyjvcRx8e8gJumsh/kDqLofcT6grn7pvBt9EoONG9uEtangwZYnoK4WFWDvigwS8HWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862446; c=relaxed/simple;
	bh=B9eCEAPPmf7hUoQFzUOAQPgCN7JCyf6R8EFxIMMn/O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX7L3q5IC1DosEQ5zwKY6HxPHBU2h4L03AzAM38++rfuDLiX1rGCA0uJfYi1DhaDzwu52DHYQD5qA2LLnR9UAFSUE08S6OQqxZihd630R5xH7Cn7KO5j4IIvELR8CIHXkBqOQqq8WaNtvXFPma8tlWh6WeYj0NJr/usnTbVaRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED9E143D;
	Mon,  5 Aug 2024 05:54:29 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7633F5A1;
	Mon,  5 Aug 2024 05:54:01 -0700 (PDT)
Message-ID: <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
Date: Mon, 5 Aug 2024 13:53:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yonglong Liu <liuyonglong@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2024 1:19 pm, Yunsheng Lin wrote:
> On 2024/7/31 16:42, Somnath Kotur wrote:
>> On Tue, Jul 30, 2024 at 10:51 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>
> 
> +cc iommu maintainers and list
> 
>>>
>>> On 30/07/2024 15.08, Yonglong Liu wrote:
>>>> I found a bug when running hns3 driver with page pool enabled, the log
>>>> as below:
>>>>
>>>> [ 4406.956606] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000000000000a8
>>>
>>> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>> {
>>>          return dev->iommu_group->default_domain;
>>> }
>>>
>>> $ pahole -C iommu_group --hex | grep default_domain
>>>          struct iommu_domain *      default_domain;   /*  0xa8   0x8 */
>>>
>>> Looks like iommu_group is a NULL pointer (that when deref member
>>> 'default_domain' cause this fault).
>>>
>>>
>>>> [ 4406.965379] Mem abort info:
>>>> [ 4406.968160]   ESR = 0x0000000096000004
>>>> [ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [ 4406.977218]   SET = 0, FnV = 0
>>>> [ 4406.980258]   EA = 0, S1PTW = 0
>>>> [ 4406.983404]   FSC = 0x04: level 0 translation fault
>>>> [ 4406.988273] Data abort info:
>>>> [ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>> [ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>> [ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=0000202828326000
>>>> [ 4407.013430] [00000000000000a8] pgd=0000000000000000,
>>>> p4d=0000000000000000
>>>> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
>>>> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
>>>> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
>>>> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
>>>> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
>>>> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
>>>> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
>>>> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
>>>> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
>>>> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
>>>> [ 4407.093343] Workqueue: events page_pool_release_retry
>>>> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>>>> BTYPE=--)
>>>> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
>>>> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
>>>> [ 4407.114255] sp : ffff80008bacbc80
>>>> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
>>>> ffffc31806be7000
>>>> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
>>>> 0000000000000002
>>>> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
>>>> 00000000fcd7c000
>>>> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
>>>> ffff8000d3503c58
>>>> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
>>>> 0000000000000001
>>>> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
>>>> 000006b10004e7fb
>>>> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
>>>> ffffc3180405cd20
>>>> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
>>>> 0000000000000010
>>>> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
>>>> 0000000000000002
>>>> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
>>>> 0000000000000000
>>>> [ 4407.188589] Call trace:
>>>> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
>>>> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
>>>> [ 4407.199361]  page_pool_return_page+0x48/0x180
>>>> [ 4407.203699]  page_pool_release+0xd4/0x1f0
>>>> [ 4407.207692]  page_pool_release_retry+0x28/0xe8
>>>
>>> I suspect that the DMA IOMMU part was deallocated and freed by the
>>> driver even-though page_pool still have inflight packets.
>> When you say driver, which 'driver' do you mean?
>> I suspect this could be because of the VF instance going away with
>> this cmd - disable the vf: echo 0 >
>> /sys/class/net/eno1/device/sriov_numvfs, what do you think?
>>>
>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>> 'struct device', to avoid it going away, but I guess there is also some
>>> IOMMU code that we need to make sure doesn't go away (until all inflight
>>> pages are returned) ???
> 
> I guess the above is why thing went wrong here, the question is which
> IOMMU code need to be called here to stop them from going away.

This looks like the wrong device is being passed to dma_unmap_page() - 
if a device had an IOMMU DMA domain at the point when the DMA mapping 
was create, then neither that domain nor its group can legitimately have 
disappeared while that device still had a driver bound. Or if it *was* 
the right device, but it's already had device_del() called on it, then 
you have a fundamental lifecycle problem - a device with no driver bound 
should not be passed to the DMA API, much less a dead device that's 
already been removed from its parent bus.

Thanks,
Robin.

