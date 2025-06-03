Return-Path: <netdev+bounces-194786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72295ACC73C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD11733DC
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB822A1D5;
	Tue,  3 Jun 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schettke.com header.i=@schettke.com header.b="RUMmr3Uk"
X-Original-To: netdev@vger.kernel.org
Received: from wp280.webpack.hosteurope.de (wp280.webpack.hosteurope.de [80.237.133.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371F12B73
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.133.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955743; cv=none; b=OfrDJKhazfdvQYTs4IWjagydBpTmSVIX4JxqdiFWdZX04E7cM9PaH9wpZKDfXJOwt+dCnqMqCDIaW5qlbxjMPtOXItbmAY93PLG8JN9HK2RizGaYMiZxoUq2YycZ/2WsBLRG+ep74kjgMHWEh9c3I9e/w3dn/ZJmXsU5anA45Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955743; c=relaxed/simple;
	bh=BFCnypDV9ua8ZBvfaJ+n1paLQOszq4z0nwWXZAPy75A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VNrvEftB9TNmReKznBR2eBI8KzlgVTzI381R3exApfY1SDxd2MGA7lr8Dn8z22KPYE7ZwRKCbbk4GSXWXAEd17qWgVBwsFAn03xr3h/JhEL8EDr6QpT8AQSawaBw+JFcncBKf75VYGe/+g048db0CeBAUaXapMfIuFNhnxEFDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schettke.com; spf=pass smtp.mailfrom=schettke.com; dkim=pass (2048-bit key) header.d=schettke.com header.i=@schettke.com header.b=RUMmr3Uk; arc=none smtp.client-ip=80.237.133.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schettke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schettke.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=schettke.com; s=he211272; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:Cc:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5kjkJiLuXwDqD4+qSp6P0QqShEllQ1plsIl3pz6Ih9I=; t=1748955740; x=1749387740; 
	b=RUMmr3UkugkNFuEGg2aALOjd7eQkzkLCIPJEA0xfq9LF1UHc+gD+aDA8iIHVhauUac8Bb2Z89zb
	ksUYbxAW0JNb2HQbX8qyeXSsUltg8s3qGKbxzy6GMlYIEdVOG2xVxJsZgXx2rQjtxTzZXNzXNzNgN
	O/DmLeEtXvfpSslECOYYs78LCHSMNthxad3LAu3wiFp7RTDBZqHX5wUPUMI4i0UZttuBEiKT0BSiY
	Tg59I9AhKar8fo5I8jWxie9dbOzacqUbWv0SPs1d/aytqtJT+lh5EW4T48mDyxueqgg3pEL10/Oqg
	q8LB5Uf312xpS3+c9aGElg3DFt227L3OpEKA==;
Received: from 2a0a-a546-4feb-0-c7eb-dec0-e7c3-d908.ipv6dyn.netcologne.de ([2a0a:a546:4feb:0:c7eb:dec0:e7c3:d908]); authenticated
	by wp280.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uMQc8-001fse-23;
	Tue, 03 Jun 2025 14:19:32 +0200
Message-ID: <00a8cce8-410e-4038-98af-49be6d93d7bd@schettke.com>
Date: Tue, 3 Jun 2025 14:19:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org
From: Florian Zeitz <florian.zeitz@schettke.com>
Subject: ptp_vclock bug: Obtaining a mutex during RCU lock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;florian.zeitz@schettke.com;1748955740;48a9f4f7;
X-HE-SMSGID: 1uMQc8-001fse-23

Hi,

I believe I have found a bug in the PTP vclock implementation.

Occasionally, when running ptp4l and phc2sys on a virtual clock, I 
encounter the following warning from within the ptp4l process (full 
backtrace below):
"Voluntary context switch within RCU read-side critical section!"

As the backtrace shows the warning originates from 
`ptp_convert_timestamp()` in drivers/ptp/ptp_vclock.c, specifically line 
203 where `mutex_lock_interruptible()` is called inside an RCU read-side 
critical section.
Having read up on RCU, it seems to me that trying to obtain a mutex 
during an RCU lock is generally not allowed and voids the RCU lock 
should scheduling happen.

This can occur whenever a timestamped packet is received while the mutex 
is still held by another call, in my case `ptp_vclock_gettime()`.

To make this easier to reproduce, I've written a small test program that 
triggers frequent locking:
```c
#define _GNU_SOURCE

#include <fcntl.h>
#include <sys/stat.h>
#include <sys/timex.h>
#include <time.h>

#define CLOCKFD 3
#define FD_TO_CLOCKID(fd) ((~(clockid_t)(fd) << 3) | CLOCKFD)

int main(void) {
   struct timespec time;
   struct timex tmx = {0};

   int fd = open("/dev/ptp1", O_RDWR);
   clockid_t clock = FD_TO_CLOCKID(fd);

   while (1) {
     clock_gettime(clock, &time);
     clock_adjtime(clock, &tmx);
   }
}
```

Running this in parallel with ptp4l (in a gPTP setup, which sends SYNC 
messages at a higher rate than the default profile) typically reproduces 
the issue within a few minutes.

Best Regards,

Florian Zeitz

```
[ 1084.825057] ------------[ cut here ]------------
[ 1084.825072] Voluntary context switch within RCU read-side critical 
section!
[ 1084.825091] WARNING: CPU: 1 PID: 677 at kernel/rcu/tree_plugin.h:331 
rcu_note_context_switch+0x4e4/0x
530
[ 1084.825118] Modules linked in: rfkill rtc_pcf85063 regmap_i2c emc2305 
v3d vc4 snd_soc_hdmi_codec binf
mt_misc gpu_sched drm_display_helper cec drm_shmem_helper drm_dma_helper 
bcm2835_codec(C) bcm2835_isp(C) rpi_hevc_dec bcm2835_v4l2(C) 
snd_soc_core drm_kms_helper bcm2835_mmal_vchiq(C) videobuf2_vmalloc 
snd_compress vc_sm_cma(C) v4l2_mem2mem snd_pcm_dmaengine 
videobuf2_dma_contig raspberrypi_hwmon i2c_mux_pinctrl videobuf2_memops 
videobuf2_v4l2 i2c_mux videodev snd_bcm2835(C) i2c_brcmstb snd_pcm 
snd_timer raspberrypi_gpiomem i2c_bcm2835 videobuf2_common mc snd 
pps_gpio nvmem_rmem uio_pdrv_genirq uio drm fuse 
drm_panel_orientation_quirks backlight dm_mod ip_tables x_tables ipv6
[ 1084.825259] CPU: 1 UID: 0 PID: 677 Comm: ptp4l Tainted: G         C 
       6.12.30-v8-ptpfix+ #2
[ 1084.825269] Tainted: [C]=CRAP
[ 1084.825272] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)
[ 1084.825277] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[ 1084.825283] pc : rcu_note_context_switch+0x4e4/0x530
[ 1084.825291] lr : rcu_note_context_switch+0x4e4/0x530
[ 1084.825298] sp : ffffffc08162b7e0
[ 1084.825302] x29: ffffffc08162b7e0 x28: ffffff8046414200 x27: 
ffffff807fb78c40
[ 1084.825313] x26: 0000000000000001 x25: 0000000000000000 x24: 
0000000000000000
[ 1084.825324] x23: ffffff8046414200 x22: 0000000000000000 x21: 
ffffff8046414200
[ 1084.825335] x20: 0000000000000000 x19: ffffff807fb79a40 x18: 
0000000000000000
[ 1084.825345] x17: 0000000000000000 x16: 0000000000000000 x15: 
0000000000000000
[ 1084.825355] x14: fffffffffffc78ef x13: 216e6f6974636573 x12: 
206c616369746972
[ 1084.825365] x11: ffffffd7ed4c54f8 x10: 00000000000001a8 x9 : 
ffffffd7ec11e494
[ 1084.825375] x8 : 0000000000017fe8 x7 : 00000000fffff1a7 x6 : 
ffffffd7ed51d4f8
[ 1084.825386] x5 : ffffff807fb663c8 x4 : 0000000000000000 x3 : 
0000000000000027
[ 1084.825396] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffffff8046414200
[ 1084.825406] Call trace:
[ 1084.825410]  rcu_note_context_switch+0x4e4/0x530
[ 1084.825418]  __schedule+0xac/0xb58
[ 1084.825425]  schedule+0x3c/0x150
[ 1084.825429]  schedule_preempt_disabled+0x2c/0x58
[ 1084.825435]  __mutex_lock.constprop.0+0x464/0x940
[ 1084.825440]  __mutex_lock_interruptible_slowpath+0x1c/0x30
[ 1084.825446]  mutex_lock_interruptible+0x68/0x80
[ 1084.825452]  ptp_convert_timestamp+0x8c/0xd0
[ 1084.825459]  __sock_recv_timestamp+0x2f0/0x490
[ 1084.825466]  __sock_recv_cmsgs+0x5c/0x168
[ 1084.825472]  packet_recvmsg+0x130/0x540
[ 1084.825482]  sock_recvmsg+0x78/0xd0
[ 1084.825487]  ____sys_recvmsg+0xb0/0x250
[ 1084.825494]  ___sys_recvmsg+0xd8/0x100
[ 1084.825500]  __sys_recvmsg+0x8c/0x100
[ 1084.825507]  __arm64_sys_recvmsg+0x2c/0x40
[ 1084.825513]  invoke_syscall+0x50/0x120
[ 1084.825522]  el0_svc_common.constprop.0+0x48/0xf0
[ 1084.825529]  do_el0_svc+0x24/0x38
[ 1084.825536]  el0_svc+0x30/0xd0
[ 1084.825543]  el0t_64_sync_handler+0x120/0x130
[ 1084.825550]  el0t_64_sync+0x190/0x198
[ 1084.825556] ---[ end trace 0000000000000000 ]---
```

