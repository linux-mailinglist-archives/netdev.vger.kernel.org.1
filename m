Return-Path: <netdev+bounces-114142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CC9412CD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6224C1C22A1D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C3195FE5;
	Tue, 30 Jul 2024 13:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD11E49B;
	Tue, 30 Jul 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344937; cv=none; b=sHiRMtj3dotEYXPuII9DK2qoKUn7Gx+M/9micGvgyN3dL6Ppig5ahJkfwgNVuyDJsd8EYYPWRVL67oNAU8febNnGpul9XKXyImiQaqisEL+fGXHMQT3p3mqjN8pPiEDr+GrXe1xCvdGDbtf5rhFA0oB0EZ6OLLVqrtI55CAHvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344937; c=relaxed/simple;
	bh=CYbynfAM7nNVVgLEvHVrjLnzZzfs0PFfVm0k4Vx51CQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:CC:
	 In-Reply-To:Content-Type; b=puBYPo0wZNMGCWaQn5EpVnUTOHsp8xTyxo63W/DQqj8O/5UCFzBA8dUxnzf5EQvF7YqHu4jtL7Xs42NsxYaoXYkiKLCZQVekook4T9F6A9TZpzdH2+63kTOKBmvT19WroUf3vm6FYriuS0kfAVLG+68xyvenACrFbGQQqz8IWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WYFmt4wrPzQnBp;
	Tue, 30 Jul 2024 21:04:30 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id A235C180100;
	Tue, 30 Jul 2024 21:08:48 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jul 2024 21:08:47 +0800
Message-ID: <8743264a-9700-4227-a556-5f931c720211@huawei.com>
Date: Tue, 30 Jul 2024 21:08:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
Content-Language: en-US
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
From: Yonglong Liu <liuyonglong@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, linyunsheng
	<linyunsheng@huawei.com>, "shenjian (K)" <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>
In-Reply-To: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
X-Forwarded-Message-Id: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200007.china.huawei.com (7.202.181.233)

I found a bug when running hns3 driver with page pool enabled, the log 
as below:

[ 4406.956606] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000000a8
[ 4406.965379] Mem abort info:
[ 4406.968160]   ESR = 0x0000000096000004
[ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 4406.977218]   SET = 0, FnV = 0
[ 4406.980258]   EA = 0, S1PTW = 0
[ 4406.983404]   FSC = 0x04: level 0 translation fault
[ 4406.988273] Data abort info:
[ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=0000202828326000
[ 4407.013430] [00000000000000a8] pgd=0000000000000000, p4d=0000000000000000
[ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT 
nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle 
ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype 
iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu 
hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu 
hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi 
scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip 
hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma 
xhci_pci_renesas uacce libsas [last unloaded: hnae3]
[ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
[ 4407.093343] Workqueue: events page_pool_release_retry
[ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
[ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
[ 4407.114255] sp : ffff80008bacbc80
[ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27: 
ffffc31806be7000
[ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24: 
0000000000000002
[ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21: 
00000000fcd7c000
[ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18: 
ffff8000d3503c58
[ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15: 
0000000000000001
[ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12: 
000006b10004e7fb
[ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 : 
ffffc3180405cd20
[ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 : 
0000000000000010
[ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 : 
0000000000000002
[ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 : 
0000000000000000
[ 4407.188589] Call trace:
[ 4407.191027]  iommu_get_dma_domain+0xc/0x20
[ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
[ 4407.199361]  page_pool_return_page+0x48/0x180
[ 4407.203699]  page_pool_release+0xd4/0x1f0
[ 4407.207692]  page_pool_release_retry+0x28/0xe8
[ 4407.212119]  process_one_work+0x164/0x3e0
[ 4407.216116]  worker_thread+0x310/0x420
[ 4407.219851]  kthread+0x120/0x130
[ 4407.223066]  ret_from_fork+0x10/0x20
[ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
[ 4407.232697] ---[ end trace 0000000000000000 ]---


The hns3 driver use page pool like this, just call once when the driver 
initialize:

static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
{
     struct page_pool_params pp_params = {
         .flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
                 PP_FLAG_DMA_SYNC_DEV,
         .order = hns3_page_order(ring),
         .pool_size = ring->desc_num * hns3_buf_size(ring) /
                 (PAGE_SIZE << hns3_page_order(ring)),
         .nid = dev_to_node(ring_to_dev(ring)),
         .dev = ring_to_dev(ring),
         .dma_dir = DMA_FROM_DEVICE,
         .offset = 0,
         .max_len = PAGE_SIZE << hns3_page_order(ring),
     };

     ring->page_pool = page_pool_create(&pp_params);
     if (IS_ERR(ring->page_pool)) {
         dev_warn(ring_to_dev(ring), "page pool creation failed: %ld\n",
              PTR_ERR(ring->page_pool));
         ring->page_pool = NULL;
     }
}

And call page_pool_destroy(ring->page_pool)  when the driver uninitialized.


We use two devices, the net port connect directory, and the step of the 
test case like below:

1. enable a vf of '7d:00.0':  echo 1 > 
/sys/class/net/eno1/device/sriov_numvfs

2. use iperf to produce some flows(the problem happens to the side which 
runs 'iperf -s')

3. use ifconfig down/up to the vf

4. kill iperf

5. disable the vf: echo 0 > /sys/class/net/eno1/device/sriov_numvfs

6. run 1~5 with another port bd:00.0

7. repeat 1~6


And when running this test case, we can found another related message (I 
replaced pr_warn() to dev_warn()):

pci 0000:7d:01.0: page_pool_release_retry() stalled pool shutdown: id 
949, 98 inflight 1449 sec


Even when stop the traffic, stop the test case, disable the vf, this 
message is still being printed.

We must run the test case for about two hours to reproduce the problem.  
Is there some advise to solve or debug the problem?


