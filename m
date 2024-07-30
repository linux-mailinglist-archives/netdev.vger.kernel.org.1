Return-Path: <netdev+bounces-114244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CD941DC8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AEE28D676
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F51A76C3;
	Tue, 30 Jul 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4t8+Kv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CA1A76AE;
	Tue, 30 Jul 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360078; cv=none; b=cNPx7ALwvFO/kP8hs8S6Nstr2H+9JrM39veK4BQbyaXe9GZVJA9osrRnEjIHP01e3NmSqmX+bPhsZpaGHSBnrdXO9xlLz+D/+OQKbd8kvtWmWntffNP+r1VVoFWN0e7HsXxzbujSrBCdvu7ETVj1A4A0SVjcSASDK3wn4KAmGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360078; c=relaxed/simple;
	bh=0GANLwW5a4SeUEYoVgNyPAu6EVILqmQHIw3PVOGNjBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeihNwxL3svvH1FbSqc+KOHcVL5/b0N+lRoFb7UHVzOjHFSqGsKimfXR7Qj20MlNXnKB3Y0f+3lk82c0xCqtDx54hpX4pgPmbykYQyUpjB8ZBR38m2Voiw1cBdf6fiC4omFT/k5qTyfiQWpIRDKfOGD6Kwfm0wU2KA6ncZOzuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4t8+Kv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C60FC4AF0E;
	Tue, 30 Jul 2024 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360077;
	bh=0GANLwW5a4SeUEYoVgNyPAu6EVILqmQHIw3PVOGNjBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R4t8+Kv49cmGOBQRECCcdOlSP/O8bo9I86x6sW1iX6BoMNIHPZ5RcviHw+WoFQvCQ
	 7X0yA1qhSxULxAil3zNFb51PpapRGX7gPx4AUADoKRjM5/fbYtqWX/T3llUAoexlj8
	 NUIVos2kXumtG79ft+a47rB919u6gUSshjphNwo/YS1Sjh/OWVTJ6GghjkBmc9xn7f
	 mBpHZzSthJLda+W6qMHaW0WtscbOKR+aE93PIr6UtxYVrw52k5FVryaK53kbaUpquc
	 4RkUS2jNWrPPhcN/SvURwwyXiTfFwE1UORQOF0aqFfQkU8iPMy5ohc906N8wopA6JO
	 eNgyj7CDu7Djw==
Message-ID: <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
Date: Tue, 30 Jul 2024 19:21:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Yonglong Liu <liuyonglong@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com, ilias.apalodimas@linaro.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, linyunsheng <linyunsheng@huawei.com>,
 "shenjian (K)" <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <8743264a-9700-4227-a556-5f931c720211@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/07/2024 15.08, Yonglong Liu wrote:
> I found a bug when running hns3 driver with page pool enabled, the log 
> as below:
> 
> [ 4406.956606] Unable to handle kernel NULL pointer dereference at 
> virtual address 00000000000000a8

struct iommu_domain *iommu_get_dma_domain(struct device *dev)
{
	return dev->iommu_group->default_domain;
}

$ pahole -C iommu_group --hex | grep default_domain
	struct iommu_domain *      default_domain;   /*  0xa8   0x8 */

Looks like iommu_group is a NULL pointer (that when deref member
'default_domain' cause this fault).


> [ 4406.965379] Mem abort info:
> [ 4406.968160]   ESR = 0x0000000096000004
> [ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 4406.977218]   SET = 0, FnV = 0
> [ 4406.980258]   EA = 0, S1PTW = 0
> [ 4406.983404]   FSC = 0x04: level 0 translation fault
> [ 4406.988273] Data abort info:
> [ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=0000202828326000
> [ 4407.013430] [00000000000000a8] pgd=0000000000000000, 
> p4d=0000000000000000
> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT 
> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle 
> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype 
> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu 
> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu 
> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi 
> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip 
> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma 
> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
> [ 4407.093343] Workqueue: events page_pool_release_retry
> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
> [ 4407.114255] sp : ffff80008bacbc80
> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27: 
> ffffc31806be7000
> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24: 
> 0000000000000002
> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21: 
> 00000000fcd7c000
> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18: 
> ffff8000d3503c58
> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15: 
> 0000000000000001
> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12: 
> 000006b10004e7fb
> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 : 
> ffffc3180405cd20
> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 : 
> 0000000000000010
> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 : 
> 0000000000000002
> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 : 
> 0000000000000000
> [ 4407.188589] Call trace:
> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
> [ 4407.199361]  page_pool_return_page+0x48/0x180
> [ 4407.203699]  page_pool_release+0xd4/0x1f0
> [ 4407.207692]  page_pool_release_retry+0x28/0xe8

I suspect that the DMA IOMMU part was deallocated and freed by the 
driver even-though page_pool still have inflight packets.

The page_pool bumps refcnt via get_device() + put_device() on the DMA
'struct device', to avoid it going away, but I guess there is also some
IOMMU code that we need to make sure doesn't go away (until all inflight
pages are returned) ???


> [ 4407.212119]  process_one_work+0x164/0x3e0
> [ 4407.216116]  worker_thread+0x310/0x420
> [ 4407.219851]  kthread+0x120/0x130
> [ 4407.223066]  ret_from_fork+0x10/0x20
> [ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
> [ 4407.232697] ---[ end trace 0000000000000000 ]---
> 
> 
> The hns3 driver use page pool like this, just call once when the driver 
> initialize:
> 
> static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
> {
>      struct page_pool_params pp_params = {
>          .flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
>                  PP_FLAG_DMA_SYNC_DEV,
>          .order = hns3_page_order(ring),
>          .pool_size = ring->desc_num * hns3_buf_size(ring) /
>                  (PAGE_SIZE << hns3_page_order(ring)),
>          .nid = dev_to_node(ring_to_dev(ring)),
>          .dev = ring_to_dev(ring),
>          .dma_dir = DMA_FROM_DEVICE,
>          .offset = 0,
>          .max_len = PAGE_SIZE << hns3_page_order(ring),
>      };
> 
>      ring->page_pool = page_pool_create(&pp_params);
>      if (IS_ERR(ring->page_pool)) {
>          dev_warn(ring_to_dev(ring), "page pool creation failed: %ld\n",
>               PTR_ERR(ring->page_pool));
>          ring->page_pool = NULL;
>      }
> }
> 
> And call page_pool_destroy(ring->page_pool)  when the driver uninitialized.
> 
> 
> We use two devices, the net port connect directory, and the step of the 
> test case like below:
> 
> 1. enable a vf of '7d:00.0':  echo 1 > 
> /sys/class/net/eno1/device/sriov_numvfs
> 
> 2. use iperf to produce some flows(the problem happens to the side which 
> runs 'iperf -s')
> 
> 3. use ifconfig down/up to the vf
> 
> 4. kill iperf
> 
> 5. disable the vf: echo 0 > /sys/class/net/eno1/device/sriov_numvfs
> 
> 6. run 1~5 with another port bd:00.0
> 
> 7. repeat 1~6
> 
> 
> And when running this test case, we can found another related message (I 
> replaced pr_warn() to dev_warn()):
> 
> pci 0000:7d:01.0: page_pool_release_retry() stalled pool shutdown: id 
> 949, 98 inflight 1449 sec
> 
> 
> Even when stop the traffic, stop the test case, disable the vf, this 
> message is still being printed.
> 
> We must run the test case for about two hours to reproduce the problem. 
> Is there some advise to solve or debug the problem?
> 

