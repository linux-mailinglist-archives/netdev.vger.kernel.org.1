Return-Path: <netdev+bounces-118157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF6950C82
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C311F230E3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A91A3BA3;
	Tue, 13 Aug 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h3AWunVL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AA1BF53;
	Tue, 13 Aug 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574998; cv=none; b=EQN6MCWBOtth44El21pb7QIKyVlUxdVPYCkt6sUk17J27PTUtWFBu55G7yUsqOoJ/J9CW5YA4eozDhsAC8b1O1I6tUn8XihKqbybsEzyIhz7LFRxPvamYUjjYJRiiSQb6YHuOiOm4Xxrq/Cz89gK4cC7xgJtLUB/TSFoUyf8RL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574998; c=relaxed/simple;
	bh=z0FY10OHVK866AXxUTIJNAVPumtIvRIa1B20Q2UdPLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUqVcNn6KaIuiStBGdDwWh/plZyibomEJKoOowKjDQ2Mn04OY7l5aHtKsa2e/xINAjRoL5g3QYVXK8yf2avHuOxWC5EP8ePyQNH99mCoWRH9/yp2ObEplN+tYY6RDl9oHM3V0spNXs1ux5JlDdzwlpc1wYHFIOgSmNm49QUkJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h3AWunVL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DI14uk007792;
	Tue, 13 Aug 2024 18:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	+re3UKdEBTO9LMrALk7eKBzCyQkTr59Tg8sK7WrdP8=; b=h3AWunVLDXDS3xNAK
	4k1FflP9dBX/GnsHtj36bnu6LppUWejWJLiOGmY5YjcFUMoZIgKMyhHBe9n49IpE
	RNP5SbB/k4tdpHmAeMAu2xcBK9nIye8qwtj0uuvw6ZDO/CDooxKnfOBJCEo3rTcJ
	Zo2OA/qM39ef1ueOsuckGSPMYnxfaqODnuJi166puYT6rh4QiY8giIZuVO8AhL6G
	ooNSCdFRkYlT5NbWwUii0Inu63P+AIHYIcGDWiHmG4EDpq8qM4GHzYxK2+aW1THh
	89DWzkY3fwmZI/D0agbV1EhwNgkzzw6LrRQfErtqFO6en9He7/cdyGqb0qAljDfm
	yJIeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410cd4092h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:49:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47DIl8k4013546;
	Tue, 13 Aug 2024 18:49:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410cd40929-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:49:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DISoDm010055;
	Tue, 13 Aug 2024 18:49:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0n90e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:49:35 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DInWLf24117958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 18:49:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F1B5806D;
	Tue, 13 Aug 2024 18:49:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E3085806A;
	Tue, 13 Aug 2024 18:49:30 +0000 (GMT)
Received: from [9.61.62.204] (unknown [9.61.62.204])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 18:49:30 +0000 (GMT)
Message-ID: <17532a01-b4fd-4538-b0dd-d88d3ff30784@linux.ibm.com>
Date: Tue, 13 Aug 2024 14:49:29 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yonglong Liu <liuyonglong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "shenjian (K)" <shenjian15@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
 <e255e7862c29c80174455fc587219badfbd3076f.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <e255e7862c29c80174455fc587219badfbd3076f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: akvF4dfV5J64tSd3IzaeP3rgvzaBK85F
X-Proofpoint-GUID: B11MiBCB0YS5TKOGdfksaDOXkMcLrjKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130134

On 8/6/24 9:35 AM, Niklas Schnelle wrote:
> On Mon, 2024-08-05 at 20:19 +0800, Yunsheng Lin wrote:
>> On 2024/7/31 16:42, Somnath Kotur wrote:
>>> On Tue, Jul 30, 2024 at 10:51 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>>
>>
>> +cc iommu maintainers and list
>>
>>>>
>>>> On 30/07/2024 15.08, Yonglong Liu wrote:
>>>>> I found a bug when running hns3 driver with page pool enabled, the log
>>>>> as below:
>>>>>
>>>>> [ 4406.956606] Unable to handle kernel NULL pointer dereference at
>>>>> virtual address 00000000000000a8
>>>>
>>>> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>>> {
>>>>         return dev->iommu_group->default_domain;
>>>> }
>>>>
>>>> $ pahole -C iommu_group --hex | grep default_domain
>>>>         struct iommu_domain *      default_domain;   /*  0xa8   0x8 */
>>>>
>>>> Looks like iommu_group is a NULL pointer (that when deref member
>>>> 'default_domain' cause this fault).
>>>>
>>>>
>>>>> [ 4406.965379] Mem abort info:
>>>>> [ 4406.968160]   ESR = 0x0000000096000004
>>>>> [ 4406.971906]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>>> [ 4406.977218]   SET = 0, FnV = 0
>>>>> [ 4406.980258]   EA = 0, S1PTW = 0
>>>>> [ 4406.983404]   FSC = 0x04: level 0 translation fault
>>>>> [ 4406.988273] Data abort info:
>>>>> [ 4406.991154]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>>> [ 4406.996632]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>> [ 4407.001681]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>>> [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=0000202828326000
>>>>> [ 4407.013430] [00000000000000a8] pgd=0000000000000000,
>>>>> p4d=0000000000000000
>>>>> [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>> [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
>>>>> nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
>>>>> ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
>>>>> iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
>>>>> hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
>>>>> hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
>>>>> scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
>>>>> hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
>>>>> xhci_pci_renesas uacce libsas [last unloaded: hnae3]
>>>>> [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
>>>>> [ 4407.093343] Workqueue: events page_pool_release_retry
>>>>> [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>>>>> BTYPE=--)
>>>>> [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
>>>>> [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
>>>>> [ 4407.114255] sp : ffff80008bacbc80
>>>>> [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
>>>>> ffffc31806be7000
>>>>> [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
>>>>> 0000000000000002
>>>>> [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
>>>>> 00000000fcd7c000
>>>>> [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
>>>>> ffff8000d3503c58
>>>>> [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
>>>>> 0000000000000001
>>>>> [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
>>>>> 000006b10004e7fb
>>>>> [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
>>>>> ffffc3180405cd20
>>>>> [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
>>>>> 0000000000000010
>>>>> [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
>>>>> 0000000000000002
>>>>> [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
>>>>> 0000000000000000
>>>>> [ 4407.188589] Call trace:
>>>>> [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
>>>>> [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
>>>>> [ 4407.199361]  page_pool_return_page+0x48/0x180
>>>>> [ 4407.203699]  page_pool_release+0xd4/0x1f0
>>>>> [ 4407.207692]  page_pool_release_retry+0x28/0xe8
>>>>
>>>> I suspect that the DMA IOMMU part was deallocated and freed by the
>>>> driver even-though page_pool still have inflight packets.
>>> When you say driver, which 'driver' do you mean?
>>> I suspect this could be because of the VF instance going away with
>>> this cmd - disable the vf: echo 0 >
>>> /sys/class/net/eno1/device/sriov_numvfs, what do you think?
>>>>
>>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>>> 'struct device', to avoid it going away, but I guess there is also some
>>>> IOMMU code that we need to make sure doesn't go away (until all inflight
>>>> pages are returned) ???
>>
>> I guess the above is why thing went wrong here, the question is which
>> IOMMU code need to be called here to stop them from going away.
>>
>> What I am also curious is that there should be a pool of allocated iova in
>> iommu that is corresponding to the in-flight page for page_pool, shouldn't
>> iommu wait for the corresponding allocated iova to be freed similarly as
>> page_pool does for it's in-flight pages?
>>
> 
> 
> Is it possible you're using an IOMMU whose driver doesn't yet support
> blocking_domain? I'm currently working an issue on s390 that also
> occurs during device removal and is fixed by implementing blocking
> domain in the s390 IOMMU driver (patch forthcoming). The root cause for
> that is that our domain->ops->attach_dev() fails when during hot-unplug
> the device is already gone from the platform's point of view and then
> we ended up with a NULL domain unless we have a blocking domain which
> can handle non existant devices and gets set as fallback in
> __iommu_device_set_domain(). In the case I can reproduce the backtrace
> is different[0] but we also saw at least two cases where we see the
> exact same call trace as in the first mail of this thread. So far I
> suspected them to be due to the blocking domain issue but it could be a
> separate issue too.
> 
> Thanks,
> Niklas
> 

Couple of things to follow up with on Niklas' statement above...

So first, after further testing on my end, I wanted to clarify that the implementation of a blocked domain is unrelated to this bug.  Sorry for the noise.

Second, it looks like Niklas copied an unrelated backtrace in his report (I snipped it from my reply).

But I wanted to be clear, we can reproduce this same sort of error on s390 and using a different device driver (mlx5_core) and the backtrace is almost identical to what this thread is reporting and in the same area.  The most reliable repro method I've found so far is to use a few mellanox VFs and power one down (echo 0 > /sys/bus/pci/slots/.../power) during or shortly after a tcp workload (iperf3).  I verified that I can reproduce on a kernel as old as 6.7 release tag; I stopped there because that's the release when s390 converted to use dma-iommu but I assume the problem really existed longer than this.

Here's a backtrace of a repro on s390 (6.11-rc3):

[  691.860855] Unable to handle kernel pointer dereference in virtual kernel address space
[  691.861089] Failing address: 0706c00180000000 TEID: 0706c00180000803
[  691.861097] Fault in home space mode while using kernel ASCE.
[  691.861118] AS:0000000154fbc007 R3:0000000000000024 
[  691.861153] Oops: 0038 ilc:2 [#1] PREEMPT SMP 
[  691.861161] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables rpcrdma rdma_ucm rdma_cm iw_cm ib_cm uvdevic
e s390_trng ism eadm_sch sunrpc tape_34xx tape tape_class mlx5_ib vfio_ap ib_uverbs kvm ib_core zcrypt_cex4 vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel loop dm_multipath nfnetlink lcs ctcm fsm mlx5_core ghash_s390 prng chacha_s390 aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s3
90 sha_common zfcp scsi_transport_fc scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey zcrypt rng_core autofs4
[  691.861319] CPU: 9 UID: 0 PID: 283 Comm: kworker/9:2 Not tainted 6.11.0-rc3 #1
[  691.861325] Hardware name: IBM 8561 T01 772 (LPAR)
[  691.861329] Workqueue: events page_pool_release_retry
[  691.861342] Krnl PSW : 0704e00180000000 0000013bd3a6ee26 (iommu_iova_to_phys+0x6/0x40)
[  691.861355]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  691.861363] Krnl GPRS: 0000000080000000 0000000000000000 0706c00180000000 0000000afba90000
[  691.861369]            0000000000001000 0000000000000002 0000000000000022 0000000000000002
[  691.861374]            0000000000001000 0000000afba90000 00000039c0e19000 00000039c0bc9098
[  691.861379]            000000427ac33400 00000039c0e19068 0000013bd3a7655c 000000bbd8d1bb28
[  691.861389] Krnl Code: 0000013bd3a6ee1c: 0707                bcr     0,%r7
[  691.861389]            0000013bd3a6ee1e: 0707                bcr     0,%r7
[  691.861389]           #0000013bd3a6ee20: c004002a8d6c        brcl    0,0000013bd3fc08f8
[  691.861389]           >0000013bd3a6ee26: 58502000            l       %r5,0(%r2)
[  691.861389]            0000013bd3a6ee2a: ec580014047e        cij     %r5,4,8,0000013bd3a6ee52
[  691.861389]            0000013bd3a6ee30: ec58000c007e        cij     %r5,0,8,0000013bd3a6ee48
[  691.861389]            0000013bd3a6ee36: e31020080004        lg      %r1,8(%r2)
[  691.861389]            0000013bd3a6ee3c: e31010400004        lg      %r1,64(%r1)
[  691.861426] Call Trace:
[  691.861430]  [<0000013bd3a6ee26>] iommu_iova_to_phys+0x6/0x40 
[  691.861436]  [<0000013bd2f47a32>] dma_unmap_page_attrs+0x1a2/0x1e0 
[  691.861443]  [<0000013bd3c2b81a>] page_pool_return_page+0x5a/0x130 
[  691.861449]  [<0000013bd3c2cb68>] page_pool_release+0xb8/0x1f0 
[  691.861455]  [<0000013bd3c2ce9c>] page_pool_release_retry+0x2c/0x120 
[  691.861461]  [<0000013bd2e95652>] process_one_work+0x2b2/0x5d0 
[  691.861467]  [<0000013bd2e9625e>] worker_thread+0x20e/0x3f0 
[  691.861473]  [<0000013bd2ea25e2>] kthread+0x152/0x170 
[  691.861478]  [<0000013bd2e135ac>] __ret_from_fork+0x3c/0x60 
[  691.861484]  [<0000013bd3ecf0ca>] ret_from_fork+0xa/0x38 
[  691.861491] INFO: lockdep is turned off.
[  691.861495] Last Breaking-Event-Address:
[  691.861499]  [<0000013bd3a76556>] iommu_dma_unmap_page+0x36/0xb0
[  691.861507] Kernel panic - not syncing: Fatal exception: panic_on_oops





