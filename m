Return-Path: <netdev+bounces-118366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497BF95166A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE771C21A57
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD813D524;
	Wed, 14 Aug 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f+Yr8yR+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21313D518
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623441; cv=none; b=HPPmPPY0FJ+WtRTxvdfPkQntRcYg5u5BtBkekB+FcljA/IpfAzPOFeaUqgHarOI62YBH5BrjPTyKvUOejxOfXaLEoAu/7BUmHbbs3TSi+o7Nh53i3RubyllgH8RlX3m+U+qVGy3Dn1IuYUhnEPTAKE+20QRv51LeH3lYDg3Illw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623441; c=relaxed/simple;
	bh=4WZ0OzGPLTIXH39Ubaflx7d0PRdTJVJTTnLk0JUUY2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1ySgr1kulChfnz/5DD6V3vQtew6sVfj75G0ixE9KZiu9z8ATDgN8SlFVpf/Sve4jfRLa12KzUhdqioHdktj3ykiqC6Ie/GxpLlRGf3EkeSTxqVy3YTnt0nVs/85XAS2LuJqmjUTMDS4yZLWWZJ9pgWPOqcE1NlvczQE7bP34bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f+Yr8yR+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so2863490a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723623437; x=1724228237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGKH4VT+6oIZ05Mg/wtc5j5EPbFWisi/zDz8nVxU9W8=;
        b=f+Yr8yR+0dH9WxP87EXx4HwQR4R//tjSz/sOp98RVfSOEIW0uDNMMqX2TnBtXi0IIV
         brx5eyN3K37TeWcFxSZ+0gQf1hGlUb/A5+5Eq3rhxOOdHGuSBUi63Ys0qz9JQr6q3n0z
         2eajdfIah7JVyql3+4g3gvL/xS9SREk06A4ASZne/vDol3NDa7e1VTNExv0ONINpce3O
         Ks/8SGvcgYeXa7kyAbDmEpzIrk9a3PzFkxNIvTrDFnNhXJeGo9iKONkcItkzJwQ59a+n
         qV4yB16JEhopMRbylPwsePuwNIjrg//rmWOB0Si9MIZRs6PDQVBTtJkCci+zZW/D4pPb
         /XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623437; x=1724228237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGKH4VT+6oIZ05Mg/wtc5j5EPbFWisi/zDz8nVxU9W8=;
        b=p9XMCIOgfH3h1dry729gX93LIQfy4k2R6vjnq04BO7sx+6RkUpl+sz11ZDDYD38NM+
         Oo345z+fK9EGaiQAv7BzSnmPBMXZDRI14Abq694AmgTObLNMWUTzZ+iiw3Sy/fLtOd+S
         EQJ2f+f72U85QwkJJqOiJWHNFZjUdxSybbAen1bOXgFj9x2zvfJYvLmtN5aJMSkVq7RL
         SndQLOgHoRtWJgli29JUh3dbCK8RDiIuZWHB4q+v7L+zd4smJee5YdonXuvSX8Il0dFA
         yGxZiF2v9AWASvvyV4b6KVTUP2vVZgVKuh+0n9Mm/sOwcXRbX2mkp2/GnD076XSE2Hwi
         uoFw==
X-Gm-Message-State: AOJu0Yxx3zBR+GdvhWIB86qVpMJzjkHY7b+Kba+QjTSy57DjHO8mPJuQ
	xEtej5wILCFYsxEPEjM1HSRH7HWISc/CMduPTJ1z48Z5Pk7PKEQopMP0E01iG9s=
X-Google-Smtp-Source: AGHT+IGJUV9VKtFAaK5scsW7KwbH6afPR2cjc8d17/h0tffxEHW4y7gQog39aiaK6j22dbIHpYoXzA==
X-Received: by 2002:a05:6402:26c7:b0:5a2:6142:24c1 with SMTP id 4fb4d7f45d1cf-5bea1c6abe2mr2073402a12.5.1723623437150;
        Wed, 14 Aug 2024 01:17:17 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bd72sm142852966b.140.2024.08.14.01.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:17:16 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:17:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZrxoC_jCc00MzD-o@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
 <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
 <Zro8l2aPwgmMLlbW@nanopsycho.orion>
 <e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
 <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>

Wed, Aug 14, 2024 at 09:49:57AM CEST, jiri@resnulli.us wrote:
>Mon, Aug 12, 2024 at 06:55:26PM CEST, m.szyprowski@samsung.com wrote:
>>On 12.08.2024 18:47, Jiri Pirko wrote:
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
>>>>>     BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>>>>     BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>>>>     BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>>>>     BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>>>>     BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>>>>     BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>>>>
>>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>> ---
>>>>> v2->v3:
>>>>> - fixed the switch from/to orphan mode while skbs are yet to be
>>>>>     completed by using the second least significant bit in virtqueue
>>>>>     token pointer to indicate skb is orphan. Don't account orphan
>>>>>     skbs in completion.
>>>>> - reorganized parallel skb/xdp free stats accounting to napi/others.
>>>>> - fixed kick condition check in orphan mode
>>>>> v1->v2:
>>>>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>>>>     propagate use_napi flag to __free_old_xmit() and only call
>>>>>     netdev_tx_completed_queue() in case it is true
>>>>> - added forgotten call to netdev_tx_reset_queue()
>>>>> - fixed stats for xdp packets
>>>>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>>>>> - handle the !use_napi case in start_xmit() kick section
>>>>> ---
>>>>>    drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>>>>>    1 file changed, 57 insertions(+), 24 deletions(-)
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
>>>>   dql_completed from __free_old_xmit+0x120/0x198
>>>>   __free_old_xmit from free_old_xmit+0x44/0xe4
>>>>   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>>>>   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>>>>   __napi_poll from net_rx_action+0x140/0x2b4
>>>>   net_rx_action from handle_softirqs+0x11c/0x350
>>>>   handle_softirqs from call_with_stack+0x18/0x20
>>>>   call_with_stack from do_softirq+0x48/0x50
>>>>   do_softirq from __local_bh_enable_ip+0xa0/0xa4
>>>>   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>>>>   virtnet_open from virtnet_restore+0x94/0x120
>>>>   virtnet_restore from virtio_device_restore+0x110/0x1f4
>>>>   virtio_device_restore from dpm_run_callback+0x3c/0x100
>>>>   dpm_run_callback from device_resume+0x12c/0x2a8
>>>>   device_resume from dpm_resume+0x12c/0x1e0
>>>>   dpm_resume from dpm_resume_end+0xc/0x18
>>>>   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>>>>   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>>>>   pm_suspend from state_store+0x68/0xc8
>>>>   state_store from kernfs_fop_write_iter+0x10c/0x1cc
>>>>   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>>>>   vfs_write from ksys_write+0x5c/0xd4
>>>>   ksys_write from ret_fast_syscall+0x0/0x54
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
>>
>>Well, it is easy to reproduce it simply by calling
>>
>># time rtcwake -s10 -mmem
>>
>>a few times and sooner or later it will cause a kernel panic.
>
>I found the problem. Following patch will help:
>
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 3f10c72743e9..c6af18948092 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> 	if (err < 0)
> 		goto err_xdp_reg_mem_model;
> 
>-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> 	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
>+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);

Hmm, I have to look at this a bit more. I think this might be accidental
fix. The thing is, napi can be triggered even if it is disabled:

       ->__local_bh_enable_ip()
         -> net_rx_action()
           -> __napi_poll()

Here __napi_poll() calls napi_is_scheduled() and calls virtnet_poll_tx()
in case napi is scheduled. napi_is_scheduled() checks NAPI_STATE_SCHED
bit in napi state.

However, this bit is set previously by netif_napi_add_weight().


>
> > ...
>
>Best regards
>-- 
>Marek Szyprowski, PhD
>Samsung R&D Institute Poland
>


> 
> 	return 0;
>
>
>Will submit the patch in a jiff. Thanks!
>
>
>
>>
>>Best regards
>>-- 
>>Marek Szyprowski, PhD
>>Samsung R&D Institute Poland
>>

