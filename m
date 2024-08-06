Return-Path: <netdev+bounces-116102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5D9491A7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06728281DDB
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304E1D27B6;
	Tue,  6 Aug 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/zCmd0I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1D1D1F70;
	Tue,  6 Aug 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951368; cv=none; b=EEGIwX6bUELEmw3YDTtccc4mQSpHUzA8OncQ6TALLlRQkIgNnv3B9uUG+u+kGe8/JLXWg7UY0UYUXYNU/c6lQCrVRc5DDu9J6MimA8urWoJN3v72no75IF3X8fTo0Vfag4RgBXZsOtHOmzUS7nGWlDJPU4hnUHjlj+7LrWvxjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951368; c=relaxed/simple;
	bh=me0Ze4lcq7XxuwaxcIT/WZFzPqa4bZkOsD7ruqLyEvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sG2KkQpNhI0cDjFCOvLqlFW+jlG15of+4C8mw2+Yx1Ols1Vgb0ROVyzQAvH+0Y9Gdk89I4Q8eDbkwbO2LHr8tqq1STZ1WQrYyP75S6ZK6QV0EvKeqVtlCPX+TtPMqFnyzv1ZBSWj/6VC57V6jD48njm6/cws/NzNMNvRtCadLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/zCmd0I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DMPXS030128;
	Tue, 6 Aug 2024 13:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	p+iUhtKzIgCa4fDedTG3hLPlIMFc5UIEIUgTSS8on30=; b=s/zCmd0IZLSDuDMA
	h7/rcwLTAmAQ54tCtNS3EVnrmw6SXxuoAWAGOI0Kia3d62XHRZUwrV1Tw3FjXrun
	xeW1ORGYt269nI4z/Y+H2LJl0TnVb1I3zEtrRclMVNMs/qICMwTrK8R3VbuDRlAV
	wT9EPScggFG9WcEiE39toFKRrq4EowHlY1t/EcUS0b6wbgvpRtyHotqgtYjAJrgd
	a7932z9qod9Aua1pRxtqgGzfFcSf4hjb+rUfescbOetw6CyhuemmrIAkX3aa9mCv
	hieOF1qX9fJmsEVmGcZRC+02rzsPamddWTs/VVkKZaDwiWkY5VWA/p2LIuXi/Ac1
	mLxHXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ukv5g4su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:35:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DZiC8021711;
	Tue, 6 Aug 2024 13:35:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ukv5g4sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:35:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476DIqL5030242;
	Tue, 6 Aug 2024 13:35:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k33fd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:35:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476DZfKP16056848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 13:35:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1BB458057;
	Tue,  6 Aug 2024 13:35:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151BF58059;
	Tue,  6 Aug 2024 13:35:38 +0000 (GMT)
Received: from [9.171.74.197] (unknown [9.171.74.197])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 13:35:37 +0000 (GMT)
Message-ID: <e255e7862c29c80174455fc587219badfbd3076f.camel@linux.ibm.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Yunsheng Lin <linyunsheng@huawei.com>,
        Somnath Kotur
	 <somnath.kotur@broadcom.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yonglong Liu <liuyonglong@huawei.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "shenjian (K)"
 <shenjian15@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev
Date: Tue, 06 Aug 2024 15:35:37 +0200
In-Reply-To: <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
	 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
	 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
	 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
	 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xgeDWH_HJIqqmiX5PC-LTNewoQ4E4Mf9
X-Proofpoint-GUID: tnHjtsv9vUTqSd1OFzO2MHsPrA-pmo3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060093

On Mon, 2024-08-05 at 20:19 +0800, Yunsheng Lin wrote:
> On 2024/7/31 16:42, Somnath Kotur wrote:
> > On Tue, Jul 30, 2024 at 10:51=E2=80=AFPM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> > >=20
>=20
> +cc iommu maintainers and list
>=20
> > >=20
> > > On 30/07/2024 15.08, Yonglong Liu wrote:
> > > > I found a bug when running hns3 driver with page pool enabled, the =
log
> > > > as below:
> > > >=20
> > > > [ 4406.956606] Unable to handle kernel NULL pointer dereference at
> > > > virtual address 00000000000000a8
> > >=20
> > > struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> > > {
> > >         return dev->iommu_group->default_domain;
> > > }
> > >=20
> > > $ pahole -C iommu_group --hex | grep default_domain
> > >         struct iommu_domain *      default_domain;   /*  0xa8   0x8 *=
/
> > >=20
> > > Looks like iommu_group is a NULL pointer (that when deref member
> > > 'default_domain' cause this fault).
> > >=20
> > >=20
> > > > [ 4406.965379] Mem abort info:
> > > > [ 4406.968160]   ESR =3D 0x0000000096000004
> > > > [ 4406.971906]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > [ 4406.977218]   SET =3D 0, FnV =3D 0
> > > > [ 4406.980258]   EA =3D 0, S1PTW =3D 0
> > > > [ 4406.983404]   FSC =3D 0x04: level 0 translation fault
> > > > [ 4406.988273] Data abort info:
> > > > [ 4406.991154]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > > > [ 4406.996632]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > > [ 4407.001681]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > > [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000020282=
8326000
> > > > [ 4407.013430] [00000000000000a8] pgd=3D0000000000000000,
> > > > p4d=3D0000000000000000
> > > > [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT =
SMP
> > > > [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
> > > > nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
> > > > ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrt=
ype
> > > > iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
> > > > hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
> > > > hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libi=
scsi
> > > > scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
> > > > hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
> > > > xhci_pci_renesas uacce libsas [last unloaded: hnae3]
> > > > [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
> > > > [ 4407.093343] Workqueue: events page_pool_release_retry
> > > > [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSB=
S
> > > > BTYPE=3D--)
> > > > [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
> > > > [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
> > > > [ 4407.114255] sp : ffff80008bacbc80
> > > > [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
> > > > ffffc31806be7000
> > > > [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
> > > > 0000000000000002
> > > > [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
> > > > 00000000fcd7c000
> > > > [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
> > > > ffff8000d3503c58
> > > > [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
> > > > 0000000000000001
> > > > [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
> > > > 000006b10004e7fb
> > > > [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
> > > > ffffc3180405cd20
> > > > [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
> > > > 0000000000000010
> > > > [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
> > > > 0000000000000002
> > > > [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
> > > > 0000000000000000
> > > > [ 4407.188589] Call trace:
> > > > [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
> > > > [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
> > > > [ 4407.199361]  page_pool_return_page+0x48/0x180
> > > > [ 4407.203699]  page_pool_release+0xd4/0x1f0
> > > > [ 4407.207692]  page_pool_release_retry+0x28/0xe8
> > >=20
> > > I suspect that the DMA IOMMU part was deallocated and freed by the
> > > driver even-though page_pool still have inflight packets.
> > When you say driver, which 'driver' do you mean?
> > I suspect this could be because of the VF instance going away with
> > this cmd - disable the vf: echo 0 >
> > /sys/class/net/eno1/device/sriov_numvfs, what do you think?
> > >=20
> > > The page_pool bumps refcnt via get_device() + put_device() on the DMA
> > > 'struct device', to avoid it going away, but I guess there is also so=
me
> > > IOMMU code that we need to make sure doesn't go away (until all infli=
ght
> > > pages are returned) ???
>=20
> I guess the above is why thing went wrong here, the question is which
> IOMMU code need to be called here to stop them from going away.
>=20
> What I am also curious is that there should be a pool of allocated iova i=
n
> iommu that is corresponding to the in-flight page for page_pool, shouldn'=
t
> iommu wait for the corresponding allocated iova to be freed similarly as
> page_pool does for it's in-flight pages?
>=20


Is it possible you're using an IOMMU whose driver doesn't yet support
blocking_domain? I'm currently working an issue on s390 that also
occurs during device removal and is fixed by implementing blocking
domain in the s390 IOMMU driver (patch forthcoming). The root cause for
that is that our domain->ops->attach_dev() fails when during hot-unplug
the device is already gone from the platform's point of view and then
we ended up with a NULL domain unless we have a blocking domain which
can handle non existant devices and gets set as fallback in
__iommu_device_set_domain(). In the case I can reproduce the backtrace
is different[0] but we also saw at least two cases where we see the
exact same call trace as in the first mail of this thread. So far I
suspected them to be due to the blocking domain issue but it could be a
separate issue too.

Thanks,
Niklas

[0]
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000483
Fault in home space mode while using kernel ASCE.
AS:0000000159f00007 R3:00000003fe900007 S:00000003fe8ff800 P:00000000000001=
3d
Oops: 0004 ilc:2 [#1] SMP
Modules linked in: ...
CPU: 15 UID: 0 PID: 139 Comm: kmcheck Kdump: loaded ...
Tainted: [W]=3DWARN
Hardware name: IBM 3931 A01 701 (LPAR)
Krnl PSW : 0404e00180000000 00000109fc6c2d98 (s390_iommu_release_device+0x5=
8/0xf0)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000010 0000000000000000 0000000000000000 00000109fd18e=
b40
           00000109fcf78c34 0000000000000037 0000000000000000 00000109fd33a=
e60
           0000000804768748 0000000804768700 00000109fd133f10 0700000000000=
000
           0000000000000000 000000080474a400 00000109fc6b9d9a 00000089fef6b=
968
Krnl Code: 00000109fc6c2d8c: a51e0000           llilh   %r1,0
0109fc6c2d90: 580013ac          l       %r0,940(%r1)
0109fc6c2d94: a7180000          lhi     %r1,0
0109fc6c2d98: ba10c0b8          cs      %r1,%r0,184(%r12)
0109fc6c2d9c: ec180008007e      cij     %r1,0,8,00000109fc6c2dac
0109fc6c2da2: 4120c0b8          la      %r2,184(%r12)
0109fc6c2da6: c0e50023b3f5      brasl   %r14,00000109fcb39590
0109fc6c2dac: e310d0200004      lg      %r1,32(%r13)
Call Trace:
 [<00000109fc6c2d98>] s390_iommu_release_device+0x58/0xf0
 [<00000109fc6b9d9a>] iommu_deinit_device+0x7a/0x1c0
 [<00000109fc6b9920>] iommu_release_device+0x160/0x240
 [<00000109fc6b97ae>] iommu_bus_notifier+0x9e/0xb0
 [<00000109fbbb1be2>] blocking_notifier_call_chain+0x72/0x130
 [<00000109fc6d2c0c>] bus_notify+0x10c/0x130
 [<00000109fc6ccc16>] device_del+0x4c6/0x700
 [<00000109fc6349fa>] pci_remove_bus_device+0xfa/0x1c0
 [<00000109fc634af8>] pci_stop_and_remove_bus_device_locked+0x38/0x50
 [<00000109fbb6cb86>] zpci_bus_remove_device+0x66/0xa0
 [<00000109fbb6a9ac>] zpci_event_availability+0x15c/0x270
 [<00000109fc77b16a>] chsc_process_crw+0x48a/0xca0
 [<00000109fc7842c2>] crw_collect_info+0x1d2/0x310
 [<00000109fbbaf85c>] kthread+0x1bc/0x1e0
 [<00000109fbb0f5fa>] __ret_from_fork+0x3a/0x60
 [<00000109fcb5807a>] ret_from_fork+0xa/0x40
Last Breaking-Event-Address:
 [<00000109fc6b9d98>] iommu_deinit_device+0x78/0x1c0
Kernel panic - not syncing: Fatal exception: panic_on_oops



