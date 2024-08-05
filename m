Return-Path: <netdev+bounces-115754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C9947AFC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E4B20B44
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F2156C7B;
	Mon,  5 Aug 2024 12:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8E155A5F;
	Mon,  5 Aug 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860377; cv=none; b=u9I0xPDfSsjiH//tlGrkCTUn6mGG+YbiSL8SSpPQ5X2r9mEU89G6tdcnjQ8DUlm1UnQToNKmWzc2RW3fqdpXpnzBeYhJPqdmNZoR9xmzXowoo9UJJ+Afs/pYrldgI5eYVuYIk/DqIhRPR5BVFq+8ufGYvdiTrTdWS1460/64pJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860377; c=relaxed/simple;
	bh=9kKtwZPzto+3iu+ozE9odzsSQasOgtHx3JeB+HXuNTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jEx0YS6BdgUbdfrE4b9NJMmlneZSJR037okbUeYgIjHIMHs/DWadyvDQXaRgSeyaPageLKA9F4s1pwrjPNrBZZCgh2Z6UcYlsI28R1Cx/0pVk/YFBl1HOGea2w4yMDtf7EuY+9KNJkkzWYy4T7eAsTr5Hf7O3ZrWJiDpKt1Tlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WcwTt2lxxz1L9qR;
	Mon,  5 Aug 2024 20:19:14 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 594ED180105;
	Mon,  5 Aug 2024 20:19:32 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 Aug 2024 20:19:32 +0800
Message-ID: <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
Date: Mon, 5 Aug 2024 20:19:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Somnath Kotur <somnath.kotur@broadcom.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>
CC: Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/31 16:42, Somnath Kotur wrote:
> On Tue, Jul 30, 2024 at 10:51 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>

+cc iommu maintainers and list

>>
>> On 30/07/2024 15.08, Yonglong Liu wrote:
>>> I found a bug when running hns3 driver with page pool enabled, the log
>>> as below:
>>>
>>> [ 4406.956606] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000000000000a8
>>
>> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>> {
>>         return dev->iommu_group->default_domain;
>> }
>>
>> $ pahole -C iommu_group --hex | grep default_domain
>>         struct iommu_domain *      default_domain;   /*  0xa8   0x8 */
>>
>> Looks like iommu_group is a NULL pointer (that when deref member
>> 'default_domain' cause this fault).
>>
>>
>>> [ 4406.965379] Mem abort info:
>>> [ 4406.968160]   ESR = 0x0000000096000004
>>> [ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [ 4406.977218]   SET = 0, FnV = 0
>>> [ 4406.980258]   EA = 0, S1PTW = 0
>>> [ 4406.983404]   FSC = 0x04: level 0 translation fault
>>> [ 4406.988273] Data abort info:
>>> [ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>> [ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=0000202828326000
>>> [ 4407.013430] [00000000000000a8] pgd=0000000000000000,
>>> p4d=0000000000000000
>>> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
>>> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
>>> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
>>> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
>>> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
>>> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
>>> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
>>> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
>>> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
>>> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
>>> [ 4407.093343] Workqueue: events page_pool_release_retry
>>> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
>>> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
>>> [ 4407.114255] sp : ffff80008bacbc80
>>> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
>>> ffffc31806be7000
>>> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
>>> 0000000000000002
>>> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
>>> 00000000fcd7c000
>>> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
>>> ffff8000d3503c58
>>> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
>>> 0000000000000001
>>> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
>>> 000006b10004e7fb
>>> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
>>> ffffc3180405cd20
>>> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
>>> 0000000000000010
>>> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
>>> 0000000000000002
>>> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
>>> 0000000000000000
>>> [ 4407.188589] Call trace:
>>> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
>>> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
>>> [ 4407.199361]  page_pool_return_page+0x48/0x180
>>> [ 4407.203699]  page_pool_release+0xd4/0x1f0
>>> [ 4407.207692]  page_pool_release_retry+0x28/0xe8
>>
>> I suspect that the DMA IOMMU part was deallocated and freed by the
>> driver even-though page_pool still have inflight packets.
> When you say driver, which 'driver' do you mean?
> I suspect this could be because of the VF instance going away with
> this cmd - disable the vf: echo 0 >
> /sys/class/net/eno1/device/sriov_numvfs, what do you think?
>>
>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>> 'struct device', to avoid it going away, but I guess there is also some
>> IOMMU code that we need to make sure doesn't go away (until all inflight
>> pages are returned) ???

I guess the above is why thing went wrong here, the question is which
IOMMU code need to be called here to stop them from going away.

What I am also curious is that there should be a pool of allocated iova in
iommu that is corresponding to the in-flight page for page_pool, shouldn't
iommu wait for the corresponding allocated iova to be freed similarly as
page_pool does for it's in-flight pages?

