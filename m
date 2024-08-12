Return-Path: <netdev+bounces-117791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28594F565
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FF1C20FB9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F0188CA7;
	Mon, 12 Aug 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="goHQ0gNc"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AD18787D
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481734; cv=none; b=LzwYuWz6d8vIOF41Puk4D+FBRdRChq3Ic3TUtF+US6GU5XdZlz/Q+MYSo2PvRXb8dNVuNkODkpubqz9X+NLPjwzyAtHoUWfvepUd15nHWNeZXuQH9H9Qd/2RoeMYzfkXFVL9ExjrYdofhgc5TN/Nl8iOTIK+8toJhOzwHymfIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481734; c=relaxed/simple;
	bh=F3aZ9qdHrAx+6Ybsj0Bq4hTioRQncc6ZQGRHbvHmcBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XmYJEDA6oiYAVe8YHFAXeXMU8KCX1Yrc1inScF4dd2jxBUX6ZtZv16ickJAyrwktopD9w+koMUm69C9RTJJw8QJbZ5Qmd2yTKZkqlitg9w80Z5onOwS2OvBp8u8ZA6XwRDGra/ULKDZ6bBWMOBfIhp7AiXomDYYoiBkc6D1TY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=goHQ0gNc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240812165529euoutp021d1794a86696f628bda4fd9fa4c348ea~rCYB-dd6y1734817348euoutp02d
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:55:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240812165529euoutp021d1794a86696f628bda4fd9fa4c348ea~rCYB-dd6y1734817348euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723481729;
	bh=wkl9SvOpO9jjJ7OMDyuUDtM5i2LfFTisAlADtu/MCQY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=goHQ0gNcT+3xpIbUrKc2EdOXpQuJ32v14duCIDIRSw/upEw3MhCR1fzXj+avM57Jj
	 u2iofdGHd0X/lj+DWfVHu0LExC9oTF/cqmyyhvxskA17XV+26M1H2oTZdro0fcFA7y
	 GrV5Ivv/nl+YRI57h2KQUXwELn0/gV2G/Tx6T0c4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240812165529eucas1p10cec69e47d70d9d811b254213d51cbdd~rCYBh63wc1157011570eucas1p1N;
	Mon, 12 Aug 2024 16:55:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A4.AC.09875.18E3AB66; Mon, 12
	Aug 2024 17:55:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240812165528eucas1p1b06295dc79458698d9fd43f450c963d7~rCYBF-xIu1156511565eucas1p1V;
	Mon, 12 Aug 2024 16:55:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240812165528eusmtrp2fa81e0c2d0df382816917ceb7d7c1728~rCYBFT9fw2617226172eusmtrp2f;
	Mon, 12 Aug 2024 16:55:28 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-ff-66ba3e81ec46
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6B.9C.09010.08E3AB66; Mon, 12
	Aug 2024 17:55:28 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240812165527eusmtip2a9cf78d3005c39fe080132a765498867~rCX-0t1W63270332703eusmtip2g;
	Mon, 12 Aug 2024 16:55:27 +0000 (GMT)
Message-ID: <e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
Date: Mon, 12 Aug 2024 18:55:26 +0200
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
In-Reply-To: <Zro8l2aPwgmMLlbW@nanopsycho.orion>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7qNdrvSDLat5bP48vM2u8Xihd+Y
	LfZsPMliMed8C4vF02OP2C32tG9ntmi8Kmmx7NJnJouLV9MtmnasYLLYvW06u8WFbX2sFv9/
	vWK1OLZAzOLb6TeMFke3r2S1uNZk4SDosWXlTSaPnbPusnss2FTq0XXjErPHplWdbB47H1p6
	vNg8k9Hj/b6rbB5Xb1Z7fN4kF8AVxWWTkpqTWZZapG+XwJWx/cFu5oIDehXT109ia2DsU+ti
	5OCQEDCROL3XoouRi0NIYAWjxI9zL9ghnC+MEv8/L2eCcD4zSszoOAfkcIJ17Pj/hhkisZxR
	Ys7a51AtHxkldq+5zw5SxStgJ3HnHIjNwcEioCqxYlkqRFhQ4uTMJywgtqiAvMT9WzPAyoUF
	AiQanr4Di4sIKErs/LIabAGzwBsmicm7Z4BtZhYQl7j1ZD6YzSZgKNH1tosNxOYUMJDYvWop
	K0SNvETz1tlgzRICpzgl9jXfhDrbRWL7ztWsELawxKvjW9ghbBmJ/zvnM0E0tDNKLPh9H8qZ
	wCjR8PwWI0SVNdA7v9hA3mEW0JRYv0sfIuwocXX7AnZISPJJ3HgrCHEEn8SkbdOZIcK8Eh1t
	QhDVahKzjq+DW3vwwiXmCYxKs5DCZRaSN2cheWcWwt4FjCyrGMVTS4tz01OLjfJSy/WKE3OL
	S/PS9ZLzczcxApPh6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8gSa70oR4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzqqbIpwoJpCeWpGanphakFsFkmTg4pRqY9CQNPyRvfXxRzjCGr3LTOofVf6IV
	85yUIoTLptpcNI9UkLDhWuh+K8+3IGaFlOFVto3sik1WkeFySVHMjCzPYk8esFz2efW5OJdF
	9WdCdrFtLr+1QOT81ODJKgoSM2Zt6g5zWNPRsNt91/0r5qcsrruKzeu9fi321YvD23oMsv89
	2Rwm9SPmqvXsNsFrbfMW561//ZWxe/4EvTaT27zbhNcu3fC35fL9mMtMC37aPvm9pMp2VnXo
	US+ngsWzjK4sb2adobuU31HK6Kx0W+E+Jc7XltO89+Qvf66zrqan88tR85OOx3PKbi9nDVbh
	tnDOWW7i9mzKnb1mJ7cYyNrm/fLO8bSdm97n1cDvmOGlxFKckWioxVxUnAgAn82HFPUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xe7oNdrvSDHYt07f48vM2u8Xihd+Y
	LfZsPMliMed8C4vF02OP2C32tG9ntmi8Kmmx7NJnJouLV9MtmnasYLLYvW06u8WFbX2sFv9/
	vWK1OLZAzOLb6TeMFke3r2S1uNZk4SDosWXlTSaPnbPusnss2FTq0XXjErPHplWdbB47H1p6
	vNg8k9Hj/b6rbB5Xb1Z7fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
	ZKqkb2eTkpqTWZZapG+XoJex/cFu5oIDehXT109ia2DsU+ti5OSQEDCR2PH/DXMXIxeHkMBS
	Rol5u06yQCRkJE5Oa2CFsIUl/lzrYoMoes8ocfvyTmaQBK+AncSdc/fZuxg5OFgEVCVWLEuF
	CAtKnJz5BGyOqIC8xP1bM9hBbGEBP4kbk36CzRQRUJTY+WU12GJmgTdMEv/bjzBCLHjGKHFj
	XT8bSBWzgLjErSfzmUBsNgFDia63XWBxTgEDid2rlrJC1JhJdG3tYoSw5SWat85mnsAoNAvJ
	IbOQjJqFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuN/27GfW3Ywrnz1Ue8Q
	IxMH4yFGCQ5mJRHeQJNdaUK8KYmVValF+fFFpTmpxYcYTYGBMZFZSjQ5H5iA8kriDc0MTA1N
	zCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamGa0T2oLf/J8RaH8Eo6Qy9H7swsy
	zaJ+tM68sujyg7tWGlHW7RePdby2zF9y5PTriJQkV5GVW/N3r/K57mJyKWu1Gtuja9ELi4qu
	nPhe+ePTzd07tepa4ln2rJ117PKfu5cfPd0W63Uuefk2GX1bVnuz8myRRYxdTR3ircGJpVkR
	Zyaeid8gcGzXTNXXy3zXTGh82da3a/8q1rMRf5d0K+gnmLxhCdG5PVUg6NG3qcuO/Vr7u1Uo
	csG3kP8iF+ZXu1qmqEuJJy0RtlqcvOt9Xe+Si02/9k/d03ef9UGOZcOpmQumT619unBzrfCz
	zSInl68tP7A8fzqT6QSHeTmPeYWeCGyKN5tddM2B89Zxbb8OJZbijERDLeai4kQARd7WcYgD
	AAA=
X-CMS-MailID: 20240812165528eucas1p1b06295dc79458698d9fd43f450c963d7
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

On 12.08.2024 18:47, Jiri Pirko wrote:
> Mon, Aug 12, 2024 at 04:57:24PM CEST, m.szyprowski@samsung.com wrote:
>> On 18.06.2024 16:44, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> Add support for Byte Queue Limits (BQL).
>>>
>>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>>> running in background. Netperf TCP_RR results:
>>>
>>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>>     BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>>     BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>>     BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>>     BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>>     BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>>     BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>>
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>> v2->v3:
>>> - fixed the switch from/to orphan mode while skbs are yet to be
>>>     completed by using the second least significant bit in virtqueue
>>>     token pointer to indicate skb is orphan. Don't account orphan
>>>     skbs in completion.
>>> - reorganized parallel skb/xdp free stats accounting to napi/others.
>>> - fixed kick condition check in orphan mode
>>> v1->v2:
>>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>>     propagate use_napi flag to __free_old_xmit() and only call
>>>     netdev_tx_completed_queue() in case it is true
>>> - added forgotten call to netdev_tx_reset_queue()
>>> - fixed stats for xdp packets
>>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>>> - handle the !use_napi case in start_xmit() kick section
>>> ---
>>>    drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>>>    1 file changed, 57 insertions(+), 24 deletions(-)
>> I've recently found an issue with virtio-net driver and system
>> suspend/resume. Bisecting pointed to the c8bd1f7f3e61 ("virtio_net: add
>> support for Byte Queue Limits") commit and this patch. Once it got
>> merged to linux-next and then Linus trees, the driver occasionally
>> crashes with the following log (captured on QEMU's ARM 32bit 'virt'
>> machine):
>>
>> root@target:~# time rtcwake -s10 -mmem
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Aug 10 12:40:26 2024
>> PM: suspend entry (s2idle)
>> Filesystems sync: 0.000 seconds
>> Freezing user space processes
>> Freezing user space processes completed (elapsed 0.006 seconds)
>> OOM killer disabled.
>> Freezing remaining freezable tasks
>> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> ------------[ cut here ]------------
>> kernel BUG at lib/dynamic_queue_limits.c:99!
>> Internal error: Oops - BUG: 0 [#1] SMP ARM
>> Modules linked in: bluetooth ecdh_generic ecc libaes
>> CPU: 1 PID: 1282 Comm: rtcwake Not tainted
>> 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
>> Hardware name: Generic DT based system
>> PC is at dql_completed+0x270/0x2cc
>> LR is at __free_old_xmit+0x120/0x198
>> pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
>> ...
>> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 43a4406a  DAC: 00000051
>> ...
>> Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
>> Stack: (0xe0805e80 to 0xe0806000)
>> ...
>> Call trace:
>>   dql_completed from __free_old_xmit+0x120/0x198
>>   __free_old_xmit from free_old_xmit+0x44/0xe4
>>   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>>   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>>   __napi_poll from net_rx_action+0x140/0x2b4
>>   net_rx_action from handle_softirqs+0x11c/0x350
>>   handle_softirqs from call_with_stack+0x18/0x20
>>   call_with_stack from do_softirq+0x48/0x50
>>   do_softirq from __local_bh_enable_ip+0xa0/0xa4
>>   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>>   virtnet_open from virtnet_restore+0x94/0x120
>>   virtnet_restore from virtio_device_restore+0x110/0x1f4
>>   virtio_device_restore from dpm_run_callback+0x3c/0x100
>>   dpm_run_callback from device_resume+0x12c/0x2a8
>>   device_resume from dpm_resume+0x12c/0x1e0
>>   dpm_resume from dpm_resume_end+0xc/0x18
>>   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>>   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>>   pm_suspend from state_store+0x68/0xc8
>>   state_store from kernfs_fop_write_iter+0x10c/0x1cc
>>   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>>   vfs_write from ksys_write+0x5c/0xd4
>>   ksys_write from ret_fast_syscall+0x0/0x54
>> Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
>> ...
>> ---[ end trace 0000000000000000 ]---
>> Kernel panic - not syncing: Fatal exception in interrupt
>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>
>> I have fully reproducible setup for this issue. Reverting it together
>> with f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning") (due to
>> some code dependencies) fixes this issue on top of Linux v6.11-rc1 and
>> recent linux-next releases. Let me know if I can help debugging this
>> issue further and help fixing.
> Will fix this tomorrow. In the meantime, could you provide full
> reproduce steps?

Well, it is easy to reproduce it simply by calling

# time rtcwake -s10 -mmem

a few times and sooner or later it will cause a kernel panic.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


