Return-Path: <netdev+bounces-118395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04F95177E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F91C21E4E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFC1442F7;
	Wed, 14 Aug 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AY8dGWQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A5143C50
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627062; cv=none; b=k+ilpxCtdm9AoRka7fhL4b3mV0ZRrKTTKSHXQgZom1UIBDk58H6wY8O3cRYKvWLpU+zm+J0+VXe1toPo9lP1QCUMVRE2DmvjcgfR6dZCbgzIfQDUTCvS3T+YNNopwUAcWQX8w4rdRo0Pi8yJSnotvFtdQRgpXeD9RiIW2G4M2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627062; c=relaxed/simple;
	bh=IiV0RxcJZJ556aDHHRYgvbV2rs2jKY1q4HntWw6DD9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cCCmtwEn8B143RyBs6R0tv4kLejikwwKHt5EFRo+a22Jvty9WAcZfxDyXHB1ldZbmOW5pfyC3+w1kw0uMRzNHd1xAg+UTmTpdV22w7Is1CrDkKiVeLcGzR3OszLrnifOmK89k+WbmjpBlNm3FrGkiIkrlDfHmIzFPz5rsmCDDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AY8dGWQ4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240814091738euoutp013ebf3cd5e03e36b99845b185ec2729d7~rja1rAe012155621556euoutp01L
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240814091738euoutp013ebf3cd5e03e36b99845b185ec2729d7~rja1rAe012155621556euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723627058;
	bh=QhK1cKoU8sizfe/t+U+tE+B4zOedDSabkjaVo1gdge4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AY8dGWQ4YxWEWBUsZgdhjpL43G/ROPbkTYsKIxjciRvlO4xDPxFfHaKmytiNNzvyT
	 GiFj6LlXp8/0a7dsoSao+asH4Ia4HwWa80X5IHYg2Q1d2AdZC3ZXyLrSw/H3E0hovG
	 6C+/xE493ZLyDe5+WyrBL59sUaZ4gwOOgM1tRyXg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240814091738eucas1p2817e3afb338cd15e7c22327520a363cb~rja1YJS-22962729627eucas1p2a;
	Wed, 14 Aug 2024 09:17:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.C6.09620.1367CB66; Wed, 14
	Aug 2024 10:17:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240814091737eucas1p1c01d53efc2d15cd0f563c7e16800f77e~rja04jgn91333613336eucas1p1V;
	Wed, 14 Aug 2024 09:17:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240814091737eusmtrp17604687fb2254513c63e9b510b86c5d8~rja03Yatw1379913799eusmtrp1P;
	Wed, 14 Aug 2024 09:17:37 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-46-66bc7631c268
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 27.91.09010.1367CB66; Wed, 14
	Aug 2024 10:17:37 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240814091736eusmtip1f755428318a2ab760ec811ee8c70557d~rjazjuGCH0106201062eusmtip1Z;
	Wed, 14 Aug 2024 09:17:36 +0000 (GMT)
Message-ID: <2d98cdcb-19c6-4a70-b8c6-b978b40663ee@samsung.com>
Date: Wed, 14 Aug 2024 11:17:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue
 Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7qGZXvSDF5OMLX48vM2u8Xihd+Y
	LfZsPMliMed8C4vF02OP2C32tG9ntmi8Kmmx7NJnJouLV9MtmnasYLLYvW06u8WFbX2sFv9/
	vWK1OLZAzOLb6TeMFke3r2S1uNZk4SDosWXlTSaPnbPusnss2FTq0XXjErPHplWdbB47H1p6
	vNg8k9Hj/b6rbB5Xb1Z7fN4kF8AVxWWTkpqTWZZapG+XwJWxdfEn9oImy4rfm6azNTA26ncx
	cnJICJhIHD51gbmLkYtDSGAFo8Stl3vZIZwvjBILTu1ihXA+M0qsmLmTCablyNlVUC3LGSW+
	z+2Gcj4ySnQ3XmXrYuTg4BWwk9j6XA2kgUVAVWJP+ykWEJtXQFDi5MwnYLaogLzE/Vsz2EFs
	YYEAiYan78DiIgKKEju/rAabySzwhkli8u4ZYJuZBcQlbj2ZD2azCRhKdL3tYgOxOQUMJKZt
	P8cKUSMv0bx1NlizhMApTolLvYuZIc52kXh56RQ7hC0s8er4FihbRuL05B4WiIZ2oKd/32eC
	cCYwSjQ8v8UIUWUtcefcL7DXmAU0Jdbvggafo8TV7QvYQcISAnwSN94KQhzBJzFp23RmiDCv
	REebEES1msSs4+vg1h68cIl5AqPSLKRwmYXkzVlI3pmFsHcBI8sqRvHU0uLc9NRi47zUcr3i
	xNzi0rx0veT83E2MwHR4+t/xrzsYV7z6qHeIkYmD8RCjBAezkghvoMmuNCHelMTKqtSi/Pii
	0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQYm52dqx+YHBO65c99i6/GoW7mr
	Tp9xMOlvKHriWfRQRWFJ6cIO++agW8UrlJwO7Lp8PPTvFyv1uJ8dsssnvD89+2f5myURB8Vn
	HAiU/p5SGDQ92rzKoZvL/oxGadkN8aZn31IlGbujpoYezj4Yf5FfwvvQz4AMX1+hyx2L7PpM
	vNuLb0Uufh92My2gS+2Z+Zp1l3YXbHS4ZVb2dTVbzYzLP/5Vit6Y8ebXjoKrFbfsvS/IWLXG
	n6x3MEh+uKxnbyGf+oPsWcd2spZ8Tji85otz9Ipsk5brUWZvPOLW/nnokR+wUq2g/yr7Z7e5
	qqw+C0J8Tl3dI7Pz86F7Xcbv656FFeRIBIrfWJAx44Kl77E5SizFGYmGWsxFxYkAR7JMIPYD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xu7qGZXvSDBbvFbT48vM2u8Xihd+Y
	LfZsPMliMed8C4vF02OP2C32tG9ntmi8Kmmx7NJnJouLV9MtmnasYLLYvW06u8WFbX2sFv9/
	vWK1OLZAzOLb6TeMFke3r2S1uNZk4SDosWXlTSaPnbPusnss2FTq0XXjErPHplWdbB47H1p6
	vNg8k9Hj/b6rbB5Xb1Z7fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
	ZKqkb2eTkpqTWZZapG+XoJexdfEn9oImy4rfm6azNTA26ncxcnJICJhIHDm7irmLkYtDSGAp
	o0THm7VsEAkZiZPTGlghbGGJP9e62CCK3jNKbG++ytLFyMHBK2AnsfW5GkgNi4CqxJ72Uywg
	Nq+AoMTJmU/AbFEBeYn7t2awg9jCAn4SNyb9BJspIqAosfPLarDFzAJvmCT+tx9hhFhwkEni
	84F+RpAqZgFxiVtP5jOB2GwChhJdb7vAruMUMJCYtv0cK0SNmUTX1i6oenmJ5q2zmScwCs1C
	csgsJKNmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMD433bs55YdjCtffdQ7
	xMjEwXiIUYKDWUmEN9BkV5oQb0piZVVqUX58UWlOavEhRlNgaExklhJNzgcmoLySeEMzA1ND
	EzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBib2uS5b08WOvq3srp90RtLGu8Ly
	/JXHUkwNLbLvbEXeTPYM+X1B9Onif/aCz8uW9dd9FquYaPLlsIG19UYjawfbxV17klabXj6t
	fDE9a8bz8oCP8659/dP14/Df52wtbnfKkqJ3ZL279aShynJW25fjv37fWPMsdvHlTQXCtsfl
	D5cmPnNfKrQwvHl1rVVD/9ddS+f37Sgy++zkP7HrddS+t0q7529Kz1nz8mmq0a4DG15P2MYW
	q6GoYyh88Mpk6dx7cp8U1qbYRy59+XsC36dbUh4pWyU3uWxmLJ/7rHkSm+B1r1fdF3rZb3MG
	rmQz+yRUIDtz/lOHLw6vnlg5MEjI+5UXT/xt+ej5o/lXfV+/VGIpzkg01GIuKk4EAIFtVreI
	AwAA
X-CMS-MailID: 20240814091737eucas1p1c01d53efc2d15cd0f563c7e16800f77e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14
References: <20240618144456.1688998-1-jiri@resnulli.us>
	<CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
	<cabe5701-6e25-4a15-b711-924034044331@samsung.com>
	<Zro8l2aPwgmMLlbW@nanopsycho.orion>
	<e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
	<Zrxhpa4fkVlMPf3Z@nanopsycho.orion>

On 14.08.2024 09:49, Jiri Pirko wrote:
> Mon, Aug 12, 2024 at 06:55:26PM CEST, m.szyprowski@samsung.com wrote:
>> On 12.08.2024 18:47, Jiri Pirko wrote:
>>> Mon, Aug 12, 2024 at 04:57:24PM CEST, m.szyprowski@samsung.com wrote:
>>>> On 18.06.2024 16:44, Jiri Pirko wrote:
>>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>>
>>>>> Add support for Byte Queue Limits (BQL).
>>>>>
>>>>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>>>>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>>>>> running in background. Netperf TCP_RR results:
>>>>>
>>>>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>>>>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>>>>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>>>>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>>>>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>>>>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>>>>      BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>>>>      BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>>>>      BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>>>>      BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>>>>      BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>>>>      BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>>>>
>>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>> ---
>>>>> v2->v3:
>>>>> - fixed the switch from/to orphan mode while skbs are yet to be
>>>>>      completed by using the second least significant bit in virtqueue
>>>>>      token pointer to indicate skb is orphan. Don't account orphan
>>>>>      skbs in completion.
>>>>> - reorganized parallel skb/xdp free stats accounting to napi/others.
>>>>> - fixed kick condition check in orphan mode
>>>>> v1->v2:
>>>>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>>>>      propagate use_napi flag to __free_old_xmit() and only call
>>>>>      netdev_tx_completed_queue() in case it is true
>>>>> - added forgotten call to netdev_tx_reset_queue()
>>>>> - fixed stats for xdp packets
>>>>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>>>>> - handle the !use_napi case in start_xmit() kick section
>>>>> ---
>>>>>     drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>>>>>     1 file changed, 57 insertions(+), 24 deletions(-)
>>>> I've recently found an issue with virtio-net driver and system
>>>> suspend/resume. Bisecting pointed to the c8bd1f7f3e61 ("virtio_net: add
>>>> support for Byte Queue Limits") commit and this patch. Once it got
>>>> merged to linux-next and then Linus trees, the driver occasionally
>>>> crashes with the following log (captured on QEMU's ARM 32bit 'virt'
>>>> machine):
>>>>
>>>> root@target:~# time rtcwake -s10 -mmem
>>>> rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Aug 10 12:40:26 2024
>>>> PM: suspend entry (s2idle)
>>>> Filesystems sync: 0.000 seconds
>>>> Freezing user space processes
>>>> Freezing user space processes completed (elapsed 0.006 seconds)
>>>> OOM killer disabled.
>>>> Freezing remaining freezable tasks
>>>> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>>> ------------[ cut here ]------------
>>>> kernel BUG at lib/dynamic_queue_limits.c:99!
>>>> Internal error: Oops - BUG: 0 [#1] SMP ARM
>>>> Modules linked in: bluetooth ecdh_generic ecc libaes
>>>> CPU: 1 PID: 1282 Comm: rtcwake Not tainted
>>>> 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
>>>> Hardware name: Generic DT based system
>>>> PC is at dql_completed+0x270/0x2cc
>>>> LR is at __free_old_xmit+0x120/0x198
>>>> pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
>>>> ...
>>>> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>>> Control: 10c5387d  Table: 43a4406a  DAC: 00000051
>>>> ...
>>>> Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
>>>> Stack: (0xe0805e80 to 0xe0806000)
>>>> ...
>>>> Call trace:
>>>>    dql_completed from __free_old_xmit+0x120/0x198
>>>>    __free_old_xmit from free_old_xmit+0x44/0xe4
>>>>    free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>>>>    virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>>>>    __napi_poll from net_rx_action+0x140/0x2b4
>>>>    net_rx_action from handle_softirqs+0x11c/0x350
>>>>    handle_softirqs from call_with_stack+0x18/0x20
>>>>    call_with_stack from do_softirq+0x48/0x50
>>>>    do_softirq from __local_bh_enable_ip+0xa0/0xa4
>>>>    __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>>>>    virtnet_open from virtnet_restore+0x94/0x120
>>>>    virtnet_restore from virtio_device_restore+0x110/0x1f4
>>>>    virtio_device_restore from dpm_run_callback+0x3c/0x100
>>>>    dpm_run_callback from device_resume+0x12c/0x2a8
>>>>    device_resume from dpm_resume+0x12c/0x1e0
>>>>    dpm_resume from dpm_resume_end+0xc/0x18
>>>>    dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>>>>    suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>>>>    pm_suspend from state_store+0x68/0xc8
>>>>    state_store from kernfs_fop_write_iter+0x10c/0x1cc
>>>>    kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>>>>    vfs_write from ksys_write+0x5c/0xd4
>>>>    ksys_write from ret_fast_syscall+0x0/0x54
>>>> Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
>>>> ...
>>>> ---[ end trace 0000000000000000 ]---
>>>> Kernel panic - not syncing: Fatal exception in interrupt
>>>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>>>
>>>> I have fully reproducible setup for this issue. Reverting it together
>>>> with f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning") (due to
>>>> some code dependencies) fixes this issue on top of Linux v6.11-rc1 and
>>>> recent linux-next releases. Let me know if I can help debugging this
>>>> issue further and help fixing.
>>> Will fix this tomorrow. In the meantime, could you provide full
>>> reproduce steps?
>> Well, it is easy to reproduce it simply by calling
>>
>> # time rtcwake -s10 -mmem
>>
>> a few times and sooner or later it will cause a kernel panic.
> I found the problem. Following patch will help:
>
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3f10c72743e9..c6af18948092 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>   	if (err < 0)
>   		goto err_xdp_reg_mem_model;
>   
> -	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>   	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> +	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>   	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>   
>   	return 0;
>
>
> Will submit the patch in a jiff. Thanks!

Confirmed. The above change fixed this issue in my tests.

Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


