Return-Path: <netdev+bounces-117746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C994F100
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAD1F21E74
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7F18309C;
	Mon, 12 Aug 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0jUSxi8"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647217D8A6
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474660; cv=none; b=GViMumOiJQxJvjT4F7gTfUBg/G8zkOsddb4sJyRC08c2cmoF2rjOnAWhij2KzcH/4UzZVLFHV40ieOy7EK4txTJD5zQ+MZoktcVJedfy7UCGQexCPxXDveX3O55uFI8FikgzwZKD11J3BVvYnDL8aMQswOpYoPF8OY9l9MogGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474660; c=relaxed/simple;
	bh=g6PtTwiUKlTHX6ZycttORBJIYtvWhDaalZEdqnPESeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fHyy+/Rj0ozck3CL82Tb2W3mIVsk0qjKeXOsnIxo5Eo8aBfEPWc9YVBIOWJQVcHg7er7iA+QwLDbr9vRNALHiJD8UAZ1JmbyiVB5mDvhlRzIHkXDA57YppGODDHGBU+0e4xQx/kjieAdy9g1OomVSu8xkXWxdgBQc/YpGI6pUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i0jUSxi8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240812145728euoutp029c0e28dc2501576c5df8c20cfad776bd~rAw-JrmqG2754527545euoutp02V
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240812145728euoutp029c0e28dc2501576c5df8c20cfad776bd~rAw-JrmqG2754527545euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723474648;
	bh=YHpqFJhw08LROWBMtjS2SDqcDJG9wJEsec8d94UkT5U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=i0jUSxi8eKMS76iV+Jhgbb1uQQ47kJojsIeYM6MIsmg3jeYJp7Qbo9CDRdFIaDv1P
	 kUBiyJEKi0JHCohqJsBdl9+PdiMpzt6xn6WaYqQkjgQ4Zc24Qua9kAGR76UOlF9Vxd
	 lXzXJCWPdgNXLA1g/3JVNm8rVJ5rU7PTP4GstQ7A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240812145728eucas1p27d6c19a4ac139db2d3903f21dafa3152~rAw_nO_wH1779817798eucas1p2G;
	Mon, 12 Aug 2024 14:57:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4E.7F.09624.7D22AB66; Mon, 12
	Aug 2024 15:57:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14~rAw9-t5f72668426684eucas1p2v;
	Mon, 12 Aug 2024 14:57:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240812145727eusmtrp194062271b04d9f3055d45a2605056f9f~rAw95nmPx0765207652eusmtrp1N;
	Mon, 12 Aug 2024 14:57:27 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-dd-66ba22d793cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.39.08810.7D22AB66; Mon, 12
	Aug 2024 15:57:27 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240812145725eusmtip28605f6e7a3df78773133dd4b351be62c~rAw7ssL100394203942eusmtip2S;
	Mon, 12 Aug 2024 14:57:24 +0000 (GMT)
Message-ID: <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
Date: Mon, 12 Aug 2024 16:57:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue
 Limits
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240618144456.1688998-1-jiri@resnulli.us>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7rXlXalGRzfbmPx5edtdovFC78x
	W+zZeJLFYs75FhaLp8cesVvsad/ObNF4VdJi2aXPTBYXr6ZbNO1YwWSxe9t0dosL2/pYLf7/
	esVqcWyBmMW3028YLY5uX8lqca3JwkHQY8vKm0weO2fdZfdYsKnUo+vGJWaPTas62Tx2PrT0
	eLF5JqPH+31X2Tyu3qz2+LxJLoArissmJTUnsyy1SN8ugSvj09rXrAVXNStaTnYwNTAuVepi
	5OSQEDCRuL/9L1MXIxeHkMAKRokPW3awQjhfGCUWfF3HDOF8ZpS48GM6C0zLj0lzoFqWM0pM
	vH0fquUjo8Tl6YvZuxg5OHgF7CSadvuANLAIqErsnT2NCcTmFRCUODnzCdggUQF5ifu3ZrCD
	2MICARINT9+BxUUELCW+3vsNtplZ4AqTxPnbjWDNzALiEreezAez2QQMJbredrGB2JwCFhKr
	F69nh6iRl2jeOhusWULgFKfEkdmr2EAOkhBwkZj0NAfiA2GJV8e3sEPYMhKnJ/ewQNS3A/38
	+z4ThDOBUaLh+S1GiCpriTvnfoENYhbQlFi/Sx8i7ChxdfsCdoj5fBI33gpC3MAnMWnbdGaI
	MK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IspGCZheTLWUi+mYWwdwEjyypG8dTS4tz01GLDvNRy
	veLE3OLSvHS95PzcTYzAZHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCO/qlzvThHhTEiurUovy
	44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGphUlueFr/i1s/Z/bACbi9La
	c9eTFGqkhe8vOih6z2Wq9x2fU8X8rjnnl/3PaNzuFm0TMklM2+wU57w1ca8KFpyYNnfy5aUX
	7z18cFf6yLWnGlGhB4OfBT3f2dvQwxwh/9UzhKlrl6Ir+5wTn/RiUuuT3H7+Z9aWuBr1tEn5
	s0BU84xMhw3d7jvmrVaJyjU6tm3VncNBm34UR9g+CN/xtW/57DdflfNDt009vjS/bOvyvAMr
	/n1x2XI68OrBWU589g/LZ4fy3p477WBzlGLYnGLhCysOSGYEKd+tmXJxbt+pu9wlG7I2Hrpx
	7nT4TNdogeZjmvsENNazG6Z+Xqv48q7jNJ+5rTwekRtmVxvdN3dZrMRSnJFoqMVcVJwIADv8
	CMP1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7rXlXalGfxbxmvx5edtdovFC78x
	W+zZeJLFYs75FhaLp8cesVvsad/ObNF4VdJi2aXPTBYXr6ZbNO1YwWSxe9t0dosL2/pYLf7/
	esVqcWyBmMW3028YLY5uX8lqca3JwkHQY8vKm0weO2fdZfdYsKnUo+vGJWaPTas62Tx2PrT0
	eLF5JqPH+31X2Tyu3qz2+LxJLoArSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
	yFRJ384mJTUnsyy1SN8uQS/j09rXrAVXNStaTnYwNTAuVepi5OSQEDCR+DFpDlMXIxeHkMBS
	Ronj5x6xQiRkJE5Oa4CyhSX+XOtigyh6zyhx/fIqoAQHB6+AnUTTbh+QGhYBVYm9s6cxgdi8
	AoISJ2c+YQGxRQXkJe7fmsEOYgsL+EncmPQTbKaIgKXE13u/mUFmMgtcYZKYdPUxM0hCSMBc
	4tipjWANzALiEreezAcbyiZgKNH1FuQITg5OAQuJ1YvXQ9WYSXRt7WKEsOUlmrfOZp7AKDQL
	yR2zkIyahaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjf9uxn5t3MM579VHv
	ECMTB+MhRgkOZiUR3tUvd6YJ8aYkVlalFuXHF5XmpBYfYjQFBsZEZinR5Hxg+skriTc0MzA1
	NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDK6TFWZWQImB7wM0qq5Pzrnffv
	5nBnbM17GPJ1ccqEhpqJ2w+t/PXAV3/is5VztZ/359nv8FTj0ezhmP2Z6atEpuacSe2KJy85
	8n4u6VA58nvWXEOGurydd3Ke7WZvFA8u3ycYKbUhew17rODWtZO/lS7//V27Wn61RkarQk0w
	2/skweyHidbrTUJC7sR+LDxVEr68I8aKVfqJ5acy4T8uX7rPf2vg/Bf8WpHZd90+rSMbHA7d
	sFGu6T35//nX9yt36lXNaT617P25des/+WUzatqeePfp+fQfPIFfL505rX2ms2eWhYfM/XTx
	uYuEfTXWW6vbiT4Wcnz1oFh0ujf3vbu7V6ov3nVwslDh4TuXlViKMxINtZiLihMB24H/b4cD
	AAA=
X-CMS-MailID: 20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14
References: <20240618144456.1688998-1-jiri@resnulli.us>
	<CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>

Hi,

On 18.06.2024 16:44, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add support for Byte Queue Limits (BQL).
>
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
>
> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>    BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>    BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>    BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>    BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>    BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>    BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v2->v3:
> - fixed the switch from/to orphan mode while skbs are yet to be
>    completed by using the second least significant bit in virtqueue
>    token pointer to indicate skb is orphan. Don't account orphan
>    skbs in completion.
> - reorganized parallel skb/xdp free stats accounting to napi/others.
> - fixed kick condition check in orphan mode
> v1->v2:
> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>    propagate use_napi flag to __free_old_xmit() and only call
>    netdev_tx_completed_queue() in case it is true
> - added forgotten call to netdev_tx_reset_queue()
> - fixed stats for xdp packets
> - fixed bql accounting when __free_old_xmit() is called from xdp path
> - handle the !use_napi case in start_xmit() kick section
> ---
>   drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>   1 file changed, 57 insertions(+), 24 deletions(-)

I've recently found an issue with virtio-net driver and system 
suspend/resume. Bisecting pointed to the c8bd1f7f3e61 ("virtio_net: add 
support for Byte Queue Limits") commit and this patch. Once it got 
merged to linux-next and then Linus trees, the driver occasionally 
crashes with the following log (captured on QEMU's ARM 32bit 'virt' 
machine):

root@target:~# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Aug 10 12:40:26 2024
PM: suspend entry (s2idle)
Filesystems sync: 0.000 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.006 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in: bluetooth ecdh_generic ecc libaes
CPU: 1 PID: 1282 Comm: rtcwake Not tainted 
6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
Hardware name: Generic DT based system
PC is at dql_completed+0x270/0x2cc
LR is at __free_old_xmit+0x120/0x198
pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
...
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 43a4406a  DAC: 00000051
...
Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
Stack: (0xe0805e80 to 0xe0806000)
...
Call trace:
  dql_completed from __free_old_xmit+0x120/0x198
  __free_old_xmit from free_old_xmit+0x44/0xe4
  free_old_xmit from virtnet_poll_tx+0x88/0x1b4
  virtnet_poll_tx from __napi_poll+0x2c/0x1d4
  __napi_poll from net_rx_action+0x140/0x2b4
  net_rx_action from handle_softirqs+0x11c/0x350
  handle_softirqs from call_with_stack+0x18/0x20
  call_with_stack from do_softirq+0x48/0x50
  do_softirq from __local_bh_enable_ip+0xa0/0xa4
  __local_bh_enable_ip from virtnet_open+0xd4/0x21c
  virtnet_open from virtnet_restore+0x94/0x120
  virtnet_restore from virtio_device_restore+0x110/0x1f4
  virtio_device_restore from dpm_run_callback+0x3c/0x100
  dpm_run_callback from device_resume+0x12c/0x2a8
  device_resume from dpm_resume+0x12c/0x1e0
  dpm_resume from dpm_resume_end+0xc/0x18
  dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
  suspend_devices_and_enter from pm_suspend+0x270/0x2a0
  pm_suspend from state_store+0x68/0xc8
  state_store from kernfs_fop_write_iter+0x10c/0x1cc
  kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
  vfs_write from ksys_write+0x5c/0xd4
  ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
...
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Fatal exception in interrupt
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

I have fully reproducible setup for this issue. Reverting it together 
with f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning") (due to 
some code dependencies) fixes this issue on top of Linux v6.11-rc1 and 
recent linux-next releases. Let me know if I can help debugging this 
issue further and help fixing.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


