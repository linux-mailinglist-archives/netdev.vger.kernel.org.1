Return-Path: <netdev+bounces-73304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B408985BD06
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A01F23D17
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992046A32F;
	Tue, 20 Feb 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7WJ1xsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC616A32C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435141; cv=none; b=CH8Swhu7Mpdh2DWQYbM6ea6r5/eDfPeayMkE+xZn5H6NzWDdIlj4veo7/HOAVje5RJp0Qqu8Ncb/V6QHWbLsmrqKlBo+GKVSHEKhQLsY3uZJ7atBa5xbbi3ROaeKZyEIjm1YnkwuFiEFr/KINKowvxnBOK0ek4rBIGSPmShN3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435141; c=relaxed/simple;
	bh=GH4PlmRBuaCdvFGkEmuWzpMqBBl9xQONUKK2mXPImd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR3FC4fBnJI8UKwZe8yeMuWfPrtDHdPzSDUlsV70QoKNMU1Zt1ibVJdGLBtI0s9K0RHxkDIcjj0V4Snjh+0mTmoikdPXZGnstAa/dERoH4PxInc8eRDWMk42k26P7F4GKVCseOv0UNzDQSv/sm9h8PSnoPFBn+I85r5cZlHt5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7WJ1xsG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b13bf764so2678735e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 05:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708435138; x=1709039938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj8o5vGsVMWD5o3D/OhLH5a1tKP5mDvU8BSIE3v+ooE=;
        b=F7WJ1xsG0QzaX0f8Ti80R6tHzGuezHojTAiDeizwq8gh3k9mmOIJLKY5xcEba6i/Pd
         SydZbYag7vio1E7cGediGIKcWBlO8R5jLk3v4AGe0vPu4ZSL7Ro9ToV+JY1o60TOrwSM
         ruSbp4qyoSV1pPLzsWgu33ksEpGnqaPJFKIrwPYJwvnl8Upk61rjf0d4aEt4/BjMq6uH
         wX2x2CE5pbSOtD1c0dIVUt0oWcBLpzmg/f77RNACY4jck4nu7dKEPTq03yetFTnRWUEK
         LyjzaYM7MWtAgn6n3jdcPm0ZYBYpLi80VBPlVoEYmZSpPushU96xV/P0B65QkCzDrCJe
         Et8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435138; x=1709039938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj8o5vGsVMWD5o3D/OhLH5a1tKP5mDvU8BSIE3v+ooE=;
        b=dwQZN4cdNtppLgiDWKx/DHvRYcPh6+XF/5imUrhzcAnVe5KqZiYFjwvILX0kXU/LRy
         8d6POyIZRAABWnWwFkpTkYnR7ncQ6fX5v596yZjSvREoJUP8/GAt8yBHJkbfLGiJNHLu
         hWuo8dePCF3QNvf10YKZRR6ASZOxItCYeitUq4EecnEfP0Y+pFb86i7eyddhAt84fkky
         yteNEtITUXKXzBieGNkVMECIjBrrPbVbcchAyE+Izj72WDu7YefJJu6MRyDmRXKfRcyj
         IpmO5fWFtTJquMMU/NAKF216MFajn+s6fo6j6T7x3iutKBvqO4C3n7c1vmK9MnS7sXSd
         lZww==
X-Gm-Message-State: AOJu0YxkZ4fu2eMXyRzie8hKlfNHiBKDhG3Qrl63F0pOGYD+RSC5gm4k
	8ISwzecLH9yL2W9vhd5UPRca8CxEBKo/YVg/l+fpqs0rDK4sq7Sx
X-Google-Smtp-Source: AGHT+IEMuqAV8UHv8HGhy5IFO0OAhmGRYdQ2ZYhgvKfx4YiD7THg/uKmNsViMV1yOxT+UUZT7GfLXA==
X-Received: by 2002:a05:6512:514:b0:511:8677:67bf with SMTP id o20-20020a056512051400b00511867767bfmr11187179lfb.44.1708435137614;
        Tue, 20 Feb 2024 05:18:57 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f14-20020a19380e000000b00512cb241a8asm107404lfa.33.2024.02.20.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:18:57 -0800 (PST)
Date: Tue, 20 Feb 2024 16:18:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
Message-ID: <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0h7wg8u.fsf@kurt.kurt.home>

Hi Kurt

On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> Hello netdev community,
> 
> after updating to v6.8 kernel I've encountered an issue in the stmmac
> driver.
> 
> I have an application which makes use of XDP zero-copy sockets. It works
> on v6.7. On v6.8 it results in the stack trace shown below. The program
> counter points to:
> 
>  - ./include/net/xdp_sock.h:192 and
>  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> 
> It seems to be caused by the XDP meta data patches. This one in
> particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").
> 
> To reproduce:
> 
>  - Hardware: imx93
>  - Run ptp4l/phc2sys
>  - Configure Qbv, Rx steering, NAPI threading
>  - Run my application using XDP/ZC on queue 1
> 
> Any idea what might be the issue here?
> 
> Thanks,
> Kurt
> 
> Stack trace:
> 
> |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
> |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
> |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUFF_POOL RxQ-1
> |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> |[  255.822602] Mem abort info:
> |[  255.822604]   ESR = 0x0000000096000044
> |[  255.822608]   EC = 0x25: DABT (current EL), IL = 32 bits
> |[  255.822613]   SET = 0, FnV = 0
> |[  255.822616]   EA = 0, S1PTW = 0
> |[  255.822618]   FSC = 0x04: level 0 translation fault
> |[  255.822622] Data abort info:
> |[  255.822624]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> |[  255.822627]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> |[  255.822630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085fe1000
> |[  255.822638] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
> |[  255.822655] Modules linked in:
> |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
> |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> |[  255.822696] sp : ffff800085ec3bc0
> |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000000001
> |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000000001
> |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000000000
> |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000000000
> |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000000008
> |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000008507
> |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080e32f84
> |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000003ff0
> |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000000000
> |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> |[  255.822764] Call trace:
> |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> |[  255.822772]  stmmac_napi_poll_rxtx+0xc4/0xec0
> |[  255.822778]  __napi_poll.constprop.0+0x40/0x220
> |[  255.822785]  napi_threaded_poll+0xd8/0x228
> |[  255.822790]  kthread+0x108/0x120
> |[  255.822798]  ret_from_fork+0x10/0x20
> |[  255.822808] Code: 910303e0 f9003be1 97ffdec0 f9403be1 (f9000020) 
> |[  255.822812] ---[ end trace 0000000000000000 ]---
> |[  255.822817] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> |[  255.822819] SMP: stopping secondary CPUs
> |[  255.822827] Kernel Offset: disabled
> |[  255.822829] CPU features: 0x0,c0000000,4002814a,2100720b
> |[  255.822834] Memory Limit: none
> |[  256.062429] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Just confirmed the same problem on my MIPS-based SoC:

Device #1:
$ ifconfig eth2 192.168.2.2 up
$ pktgen.sh -v -i eth2 -d 192.168.2.3 -m 4C:A5:15:59:A6:86 -n 0 -s 1496

Device #2:
$ mount -t bpf none /sys/fs/bpf/
$ sysctl -w net.core.bpf_jit_enable=1
$ ifconfig eth0 192.168.2.3 up
$ xdp-bench tx eth0
...
[  559.663885] CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 809a81e0, ra == 809a81dc
[  559.675786] Oops[#1]:
[  559.678324] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc3-bt1-00322-gb2c1210b8fe6-dirty #2176
[  559.695824] $ 0   : 00000000 00000001 00000000 00000000
[  559.701676] $ 4   : eb019c48 00000000 bf054000 81ddfe53
[  559.707524] $ 8   : 00000000 84ea05c0 00000000 00000000
[  559.713372] $12   : 00000000 0000002e 816e9d00 81080000
[  559.719221] $16   : 00000002 a254c020 00000000 00000000
[  559.725069] $20   : 84ea05c0 00000000 852b8000 00000040
[  559.730917] $24   : 00000000 00000000
[  559.736766] $28   : 815d8000 81ddfd88 84ea05c0 809a81dc
[  559.742615] Hi    : 00000007
[  559.745826] Lo    : 00000000
[  559.749029] epc   : 809a81e0 stmmac_tx_clean+0x9f8/0xd64
[  559.754974] ra    : 809a81dc stmmac_tx_clean+0x9f4/0xd64
[  559.760909] Status: 10000003 KERNEL EXL IE
[  559.765588] Cause : 0080040c (ExcCode 03)
[  559.770063] BadVA : 00000000
[  559.773266] PrId  : 0001a830
[  559.777740] Modules linked in:
[  559.781150] Process swapper/0 (pid: 0, threadinfo=9e75df13, task=e559c9e5, tls=00000000)
[  559.790194] Stack : 00000001 00000001 00003138 00000001 001a07f2 4696b1a6 00000000 00000000
[  559.799552]         00000000 00000001 00000000 81080000 00000001 00000000 84ea0b40 84ea2880
[  559.808909]         84ea0e20 00000000 00000000 00000001 81600000 81ddfe53 810d6bcc 817b0000
[  559.818265]         815d8000 81ddfe10 0000012c 80e83fd4 84ea05c0 a254c020 00000000 80142518
[  559.827622]         00800400 eb019c48 81600000 00000040 81ddfebc 84ea05c0 00000000 84ea1320
[  559.836979]         ...
[  559.839710] Call Trace:
[  559.842435] [<809a81e0>] stmmac_tx_clean+0x9f8/0xd64
[  559.847985] [<809a8610>] stmmac_napi_poll_tx+0xc4/0x18c
[  559.858885] [<80b2db94>] net_rx_action+0x128/0x288
[  559.864232] [<80e84d48>] __do_softirq+0x134/0x4e0
[  559.869489] [<80142484>] irq_exit+0xd4/0x138
[  559.874261] [<807cc768>] __gic_irq_dispatch+0x154/0x1f0
[  559.880101] [<80102d50>] except_vec_vi_end+0xc4/0xd0
[  559.885641] [<80e78884>] default_idle_call+0x64/0x168
[  559.891288] [<801975c4>] do_idle+0xf4/0x198
[  559.895965] [<80197990>] cpu_startup_entry+0x30/0x40
[  559.901513] [<80e78c1c>] kernel_init+0x0/0x120
[  559.906477] 
[  559.908126] Code: 0c2682db  afa50048  8fa50048 <aca20000> aca30004  1000fded  8fc208b0  8fc308ac  0000a825 
[  559.919047] 
[  559.920734] ---[ end trace 0000000000000000 ]---
[  559.925908] Kernel panic - not syncing: Fatal exception in interrupt

No problem has been spotted for the XDP drop and pass benches.

As you pointed out reverting the commit 1347b419318d ("net: stmmac:
Add Tx HWTS support to XDP ZC") fixes the bug.

-Serge(y)


