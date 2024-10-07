Return-Path: <netdev+bounces-132808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCD9933D4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B2B1F24716
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947E1DC043;
	Mon,  7 Oct 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQnL+/AB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD821DBB1D;
	Mon,  7 Oct 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319767; cv=none; b=eMmn2hhmm5/PdmpVo17jlgiUGwMybi4bpQUkzUw6xzm+lgJMPAyNfi7sKdxxHRz1QAZKz/rPd8tibSxg0ESBY1gZpdSBXnFX/F5R29V3x4FNv925+f+ilYG0nylpIJ9N/DgoaeXfb3qndoSojf8liiR5ccRrkdDxzVUrsEwoLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319767; c=relaxed/simple;
	bh=zcnz6ab2KZYTFkJ6aK9fbWWkGtfF0XPIxtacuk08zy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFCxwsla6c6aiiEGrSb3aTh6sx8Hw6ItCrsTyVgF2BOm5QxSlTCmuponSw59COTLLq42+nmQmUZIDF7ntv927A1uSG/YOcgGleaLd4Q2XxuTOdwCKOL9/zlFAklLJlq5R8il/U8VrwXlvydRt/WWGSeQVqUeTdxTvL1C4pOlt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQnL+/AB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e029efecdso1036580b3a.3;
        Mon, 07 Oct 2024 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728319765; x=1728924565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dFPDfP6JDo/YdBwahtTzolkZdJXbJjncL5HT7EViGw=;
        b=LQnL+/ABxzUvm7ZAVG/ePaAqRzSbLLjJvcL6CKZdzRuaOKVqDXaQg95Soe8PtDoz7y
         vgoUn5O1GBgUByslFYyFnFSh/NyMdnc1jrmVe5pWVoCV4sJfiLozSa6jCgo6zCejnXDN
         drQtFLhHBteTuF1y4OBPf5VebB04hULHo3EKtw7Q1eHbyXgt59itiGDNTUD4Yi3cHEut
         rV5akqwtLX9k0pxZC6RLXW2WediEr84GOiCvX9AjRKjyq+dSHhLN8W2BL77n2P1v3SXC
         TsjGUX1qwgAPvpwduyV0vJmMI0ET+c/i2IcHx2Mlzx30nlDol8Ow+s6uTLUAnB6jzGEQ
         ZaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319765; x=1728924565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dFPDfP6JDo/YdBwahtTzolkZdJXbJjncL5HT7EViGw=;
        b=kdrsz060+j4xlBuNVhjIW+x8q6blEdUX0W9+vDeX0qgKb0y38GBm/PzSHWRfUJt3aE
         /A4bYJvH/N4vuDG+pwNBPd+diTd8XVhdVFGuil4xSFET6AM2Shx5aknuksW/pxbvvEQh
         xZz/PkvdHj6fK6GL/zH3KNOTcgMGZ6r/WhJXBsSs6A75xB44z6slMbwKe/BsAy5sW9Dl
         THTl2WlALK2wXFhR7YjTrZha/r34mSQ6d8nlk3IQSBxbHVH2zZro7CoMW1HP8kNe9LNe
         BQZ1XRoShEds2gnlKOiWgUPBKMSXOR04xZ07mb9tAf61EZhGc5K/8UvHK4P8MQM5TDFo
         eTkA==
X-Forwarded-Encrypted: i=1; AJvYcCVrhrRk1ylpathB0h3TMEYZqFyQIuysPvXpfprkYvnWNZzn0EAhvsITmweQUfo+L//AOyCio4FF@vger.kernel.org, AJvYcCX28t1LAxqrnvtiiU754fLfAdSP/VCFNlapueJGtIrXdA4nkaG20/TI+zp0zyI/p1ocR8tonsH+Ye1dthE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXv375RnA+9P6J5G63HLO4/EGNoNS9C5+WerElHBGtIEgPQZ+G
	q7d6A4fnk8xRKcuDTmJGGrw9fFPQdDFHw9zSGH13rQFo8vCoTlyL
X-Google-Smtp-Source: AGHT+IGg/yb16L5h5utylbHKr9WAsQD1zCbzQqELERT8nwvl8+WdtvA4k3xZSxLQO7ma51x63WBWbA==
X-Received: by 2002:a05:6a20:e605:b0:1cf:6953:2872 with SMTP id adf61e73a8af0-1d6dfafccf8mr17658332637.48.1728319764656;
        Mon, 07 Oct 2024 09:49:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c3778esm4437031a12.57.2024.10.07.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:49:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Oct 2024 09:49:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Frank Li <Frank.Li@freescale.com>,
	"David S. Miller" <davem@davemloft.net>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net 2/2] net: fec: Reload PTP registers after link-state
 change
Message-ID: <353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
 <20240924093705.2897329-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924093705.2897329-2-csokas.bence@prolan.hu>

On Tue, Sep 24, 2024 at 11:37:06AM +0200, Csókás, Bence wrote:
> On link-state change, the controller gets reset,
> which clears all PTP registers, including PHC time,
> calibrated clock correction values etc. For correct
> IEEE 1588 operation we need to restore these after
> the reset.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---

This patch results in a lockdep splat and ultimately crashes.
Seen when booting imx25-pdk (arm) and mcf5208evb (m68k) in qemu.

Crash and bisect log attached.

Guenter
---

imx25-pdk (arm):

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc2 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
Call trace:
 unwind_backtrace from show_stack+0x10/0x18
 show_stack from dump_stack_lvl+0x40/0x68
 dump_stack_lvl from register_lock_class+0x6a8/0x724
 register_lock_class from __lock_acquire+0x8c/0x24c4
 __lock_acquire from lock_acquire+0x114/0x360
 lock_acquire from _raw_spin_lock_irqsave+0x58/0x78
 _raw_spin_lock_irqsave from fec_ptp_save_state+0x14/0x6c
 fec_ptp_save_state from fec_restart+0x2c/0x740
 fec_restart from fec_probe+0xd40/0x16f0
 fec_probe from platform_probe+0x5c/0xc4
 platform_probe from really_probe+0xd0/0x2a8
 really_probe from __driver_probe_device+0x80/0x19c
 __driver_probe_device from driver_probe_device+0x44/0x108
 driver_probe_device from __driver_attach+0x74/0x114
 __driver_attach from bus_for_each_dev+0x74/0xcc
 bus_for_each_dev from driver_attach+0x18/0x24
 driver_attach from bus_add_driver+0xc8/0x1f0
 bus_add_driver from driver_register+0x7c/0x120
 driver_register from __platform_driver_register+0x18/0x24
 __platform_driver_register from fec_driver_init+0x10/0x1c
 fec_driver_init from do_one_initcall+0x5c/0x2f4
 do_one_initcall from kernel_init_freeable+0x190/0x21c
 kernel_init_freeable from kernel_init+0x10/0x110
 kernel_init from ret_from_fork+0x14/0x38
Exception stack(0xc8825fb0 to 0xc8825ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc2 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
PC is at timecounter_read+0xc/0xbc
LR is at fec_ptp_save_state+0x28/0x6c
pc : [<c00cdfac>]    lr : [<c08a00a4>]    psr: 60000193
sp : c8825c98  ip : 00000000  fp : c1ddc6a0
r10: 00000000  r9 : c18c73a0  r8 : c1f68410
r7 : c7ef4a38  r6 : c1ddc904  r5 : 40000113  r4 : c1ddc940
r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 80004000  DAC: 00000053
Register r0 information: NULL pointer
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: slab kmalloc-4k start c1ddb000 data offset 4096 pointer offset 2368 size 4096 allocated at __kvmalloc_node_noprof+0x14/0x108
    __kmalloc_node_noprof+0x3a0/0x50c
    __kvmalloc_node_noprof+0x14/0x108
    alloc_netdev_mqs+0x58/0x44c
    alloc_etherdev_mqs+0x1c/0x30
    fec_probe+0x54/0x16f0
    platform_probe+0x5c/0xc4
    really_probe+0xd0/0x2a8
    __driver_probe_device+0x80/0x19c
    driver_probe_device+0x44/0x108
    __driver_attach+0x74/0x114
    bus_for_each_dev+0x74/0xcc
    driver_attach+0x18/0x24
    bus_add_driver+0xc8/0x1f0
    driver_register+0x7c/0x120
    __platform_driver_register+0x18/0x24
    fec_driver_init+0x10/0x1c
 Free path:
    kobject_uevent_env+0x10c/0x55c
    driver_register+0xb0/0x120
    __platform_driver_register+0x18/0x24
    dm9000_driver_init+0x10/0x1c
    do_one_initcall+0x5c/0x2f4
    kernel_init_freeable+0x190/0x21c
    kernel_init+0x10/0x110
    ret_from_fork+0x14/0x38
Register r5 information: non-paged memory
Register r6 information: slab kmalloc-4k start c1ddb000 data offset 4096 pointer offset 2308 size 4096 allocated at __kvmalloc_node_noprof+0x14/0x108
    __kmalloc_node_noprof+0x3a0/0x50c
    __kvmalloc_node_noprof+0x14/0x108
    alloc_netdev_mqs+0x58/0x44c
    alloc_etherdev_mqs+0x1c/0x30
    fec_probe+0x54/0x16f0
    platform_probe+0x5c/0xc4
    really_probe+0xd0/0x2a8
    __driver_probe_device+0x80/0x19c
    driver_probe_device+0x44/0x108
    __driver_attach+0x74/0x114
    bus_for_each_dev+0x74/0xcc
    driver_attach+0x18/0x24
    bus_add_driver+0xc8/0x1f0
    driver_register+0x7c/0x120
    __platform_driver_register+0x18/0x24
    fec_driver_init+0x10/0x1c
 Free path:
    kobject_uevent_env+0x10c/0x55c
    driver_register+0xb0/0x120
    __platform_driver_register+0x18/0x24
    dm9000_driver_init+0x10/0x1c
    do_one_initcall+0x5c/0x2f4
    kernel_init_freeable+0x190/0x21c
    kernel_init+0x10/0x110
    ret_from_fork+0x14/0x38
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab kmalloc-1k start c1f68000 data offset 1024 pointer offset 16 size 1024 allocated at platform_device_alloc+0x20/0xc4
    __kmalloc_noprof+0x39c/0x508
    platform_device_alloc+0x20/0xc4
    of_device_alloc+0x30/0x174
    of_platform_device_create_pdata+0x60/0x104
    of_platform_bus_create+0x198/0x25c
    of_platform_bus_create+0x1e4/0x25c
    of_platform_bus_create+0x1e4/0x25c
    of_platform_populate+0x78/0xfc
    of_platform_default_populate_init+0xc8/0xe8
    do_one_initcall+0x5c/0x2f4
    kernel_init_freeable+0x190/0x21c
    kernel_init+0x10/0x110
    ret_from_fork+0x14/0x38
Register r9 information: non-slab/vmalloc memory
Register r10 information: NULL pointer
Register r11 information: slab kmalloc-4k start c1ddb000 data offset 4096 pointer offset 1696 size 4096 allocated at __kvmalloc_node_noprof+0x14/0x108
    __kmalloc_node_noprof+0x3a0/0x50c
    __kvmalloc_node_noprof+0x14/0x108
    alloc_netdev_mqs+0x58/0x44c
    alloc_etherdev_mqs+0x1c/0x30
    fec_probe+0x54/0x16f0
    platform_probe+0x5c/0xc4
    really_probe+0xd0/0x2a8
    __driver_probe_device+0x80/0x19c
    driver_probe_device+0x44/0x108
    __driver_attach+0x74/0x114
    bus_for_each_dev+0x74/0xcc
    driver_attach+0x18/0x24
    bus_add_driver+0xc8/0x1f0
    driver_register+0x7c/0x120
    __platform_driver_register+0x18/0x24
    fec_driver_init+0x10/0x1c
 Free path:
    kobject_uevent_env+0x10c/0x55c
    driver_register+0xb0/0x120
    __platform_driver_register+0x18/0x24
    dm9000_driver_init+0x10/0x1c
    do_one_initcall+0x5c/0x2f4
    kernel_init_freeable+0x190/0x21c
    kernel_init+0x10/0x110
    ret_from_fork+0x14/0x38
Register r12 information: NULL pointer
Process swapper (pid: 1, stack limit = 0xc8824000)
Stack: (0xc8825c98 to 0xc8826000)
5c80:                                                       c1ddc6a0 40000113
5ca0: c1ddc904 c7ef4a38 c1f68410 c08a00a4 c1ddc000 c1ddc000 c1f68400 c0899dd8
5cc0: c1ddc84c c012856c c1d74800 c0a329c8 00000001 c1ddc6a0 c1ddc0f8 c002222c
5ce0: c1ddc780 c1ddc000 c11a4e58 c0a32a08 c1ddc780 c10db96c c1ddc6a0 c1ddc000
5d00: 00000000 c1f68400 c7ef4a38 c1f68410 c18c73a0 00000000 c1ddc6a0 c089da94
5d20: 00000000 c8825d7c c0f6c1c0 c11a14a0 00000000 00000000 00000001 00000008
5d40: c1ddc780 fffffff8 c0ccd84a c8825dcc 00000003 00000008 c7ef4a38 c0ccd5b4
5d60: c7ef4a38 00000000 00000007 00000001 00000001 00000001 82902800 c0f8be54
5d80: 00000000 c02995e0 c28d4bb8 00000000 c1d2ce7c c02996f0 c1f17848 c28d4bb8
5da0: c1f17848 c0299200 00000000 c28d4bb8 c28d4848 c1f17848 c0fbe7ec 00000000
5dc0: c28d4848 54524bb8 56341200 12005452 c1f15634 c10db96c 00000000 00000000
5de0: c1f68410 c1195160 00000000 c28d6858 c0fce780 c10b5854 00000000 c07b0790
5e00: 00000000 c1f68410 c1195160 c07ade1c c1f68410 c1195160 c1f68410 00000000
5e20: c28d6858 c07ae074 60000113 c11a14a0 c7ef4a38 c18c5520 60000113 c1f68410
5e40: 00000000 c28d6858 c0fce780 c10b5854 00000000 c07ae224 00000000 c0c288fc
5e60: c07ad13c c1f68410 c1195160 c07ae3bc c1d82c00 c07ae430 00000000 c1195160
5e80: c07ae3bc c07abd24 c1d82d04 c1d82cac c1f151d4 c10db96c c1d82ce0 c1195160
5ea0: c28d6800 00000000 c1d82c00 c07ad6a4 c1195160 c07acee0 c0f67004 c0fce780
5ec0: c1195160 c1d74800 c11ca0a0 00000000 c102dbc4 c07af1dc c10a2998 c1d74800
5ee0: c11ca0a0 c07b05cc c10a2998 c10a29a8 c10a2998 c0009f70 00000000 00000000
5f00: c1d602bf c102f300 00000135 c004553c c102dbc4 c0f995e4 c1072400 00000000
5f20: 00000006 00000006 00000060 c1d602a9 c1d602b1 c10db96c c0fce780 00000006
5f40: 00000135 c10db96c 00000006 c10d2248 00000007 c1d60260 c10b5874 c1073284
5f60: 00000006 00000006 00000000 c1072400 00000000 00000135 00000000 00000000
5f80: c0c22ac4 00000000 00000000 00000000 00000000 00000000 00000000 c0c22ad4
5fa0: 00000000 c0c22ac4 00000000 c000851c 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace:
 timecounter_read from fec_ptp_save_state+0x28/0x6c
 fec_ptp_save_state from fec_restart+0x2c/0x740
 fec_restart from fec_probe+0xd40/0x16f0
 fec_probe from platform_probe+0x5c/0xc4
 platform_probe from really_probe+0xd0/0x2a8
 really_probe from __driver_probe_device+0x80/0x19c
 __driver_probe_device from driver_probe_device+0x44/0x108
 driver_probe_device from __driver_attach+0x74/0x114
 __driver_attach from bus_for_each_dev+0x74/0xcc
 bus_for_each_dev from driver_attach+0x18/0x24
 driver_attach from bus_add_driver+0xc8/0x1f0
 bus_add_driver from driver_register+0x7c/0x120
 driver_register from __platform_driver_register+0x18/0x24
 __platform_driver_register from fec_driver_init+0x10/0x1c
 fec_driver_init from do_one_initcall+0x5c/0x2f4
 do_one_initcall from kernel_init_freeable+0x190/0x21c
 kernel_init_freeable from kernel_init+0x10/0x110
 kernel_init from ret_from_fork+0x14/0x38
Exception stack(0xc8825fb0 to 0xc8825ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e12fff1e e92d41f0 e1a04000 e5900000 (e5903000)
---[ end trace 0000000000000000 ]---
note: swapper[1] exited with irqs disabled
note: swapper[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

mcf5208evb (m68k):

*** ILLEGAL INSTRUCTION ***   FORMAT=4
Current process id is 1
BAD KERNEL TRAP: 00000000
PC: [<00000000>] 0x0
SR: 2704  SP: (ptrval)  a2: 40841678
d0: 00002700    d1: 00000000    d2: 403b2000    d3: 00000000
d4: 00000000    d5: 40344cd0    a0: 00000000    a1: 00000018
Process swapper (pid: 1, task=(ptrval))
Frame format=4 eff addr=4006f5ea pc=00000000
Stack from 4081fd50:
        403b2000 00000000 40344b8c 40344cd0 40021ae2 fffffff8 40841460 40841000
        401dfa1e 40841678 403b5fc2 403b5fb8 401dacd8 40841460 403b5fc2 00000000
        40344b8c 40344cd0 40021ae2 fffffff8 403b5fb8 40841000 408414fc 40344b82
        4081fe24 40841460 00000000 00000000 401dbd90 40841000 00000000 00000000
        4031c96e 00000000 00000000 403e8bf8 403b5fc2 403d3f54 401bb68a 403eeb0a
        400a2aec 00000000 00000008 00000003 00000003 4084149a 00000000 40c2a800
Call Trace: [<40021ae2>] clk_get_rate+0x0/0x12
 [<401dfa1e>] fec_ptp_save_state+0x24/0x5c
 [<401dacd8>] fec_restart+0x24/0x7b0
 [<40021ae2>] clk_get_rate+0x0/0x12
 [<401dbd90>] fec_probe+0x6fe/0xe2c
 [<4031c96e>] strcpy+0x0/0x18
 [<403e8bf8>] fec_driver_init+0x0/0x12
 [<401bb68a>] bus_notify+0x0/0x4e
 [<400a2aec>] __kmalloc_cache_noprof+0x0/0x15a
 [<401be2cc>] platform_probe+0x22/0x58
 [<401bbf4e>] really_probe+0xa0/0x2aa
 [<4032fa5a>] mutex_lock+0x0/0x36
 [<401bc4f0>] driver_probe_device+0x24/0x112
 [<4032f5ca>] mutex_unlock+0x0/0x38
 [<401bc80e>] __driver_attach+0xe6/0x1d0
 [<402fefd4>] klist_next+0x0/0x140
 [<401bc728>] __driver_attach+0x0/0x1d0
 [<401ba576>] bus_for_each_dev+0x6e/0xca
 [<401bba5e>] driver_attach+0x16/0x1c
 [<401bc728>] __driver_attach+0x0/0x1d0
 [<401bb4ae>] bus_add_driver+0x12e/0x20e
 [<401bd28e>] driver_register+0x4c/0xd4
 [<401bd29c>] driver_register+0x5a/0xd4
 [<403e8c06>] fec_driver_init+0xe/0x12
 [<403dab82>] do_one_initcall+0x74/0x250
 [<4031c96e>] strcpy+0x0/0x18
 [<400400d8>] parse_args+0x0/0x374
 [<403daf02>] kernel_init_freeable+0x14c/0x19c
 [<403e8bf8>] fec_driver_init+0x0/0x12
 [<40326a8a>] _printk+0x0/0x18
 [<4032d026>] kernel_init+0x0/0xf0
 [<4032d040>] kernel_init+0x1a/0xf0
 [<400204a0>] ret_from_kernel_thread+0xc/0x14
Code: 0000 0000 0000 0000 0000 0000 0000 0000 <0000> 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Disabling lock debugging due to kernel taint
note: swapper[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---
# bad: [8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b] Linux 6.12-rc2
# good: [9852d85ec9d492ebef56dc5f229416c925758edc] Linux 6.12-rc1
git bisect start 'HEAD' 'v6.12-rc1'
# bad: [fe6fceceaecf4c7488832be18a37ddf9213782bc] Merge tag 'drm-fixes-2024-10-04' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad fe6fceceaecf4c7488832be18a37ddf9213782bc
# bad: [8c245fe7dde3bf776253550fc914a36293db4ff3] Merge tag 'net-6.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad 8c245fe7dde3bf776253550fc914a36293db4ff3
# good: [9c02404b52f56b2c8acc8c0ac16d525b1226dfe5] Merge tag 'v6.12-rc1-ksmbd-fixes' of git://git.samba.org/ksmbd
git bisect good 9c02404b52f56b2c8acc8c0ac16d525b1226dfe5
# bad: [e5e3f369b123a7abe83fb6f5f9eab6651ee9b76b] Merge tag 'for-net-2024-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
git bisect bad e5e3f369b123a7abe83fb6f5f9eab6651ee9b76b
# bad: [c20029db28399ecc50e556964eaba75c43b1e2f1] net: avoid potential underflow in qdisc_pkt_len_init() with UFO
git bisect bad c20029db28399ecc50e556964eaba75c43b1e2f1
# good: [e609c959a939660c7519895f853dfa5624c6827a] net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size
git bisect good e609c959a939660c7519895f853dfa5624c6827a
# good: [a1477dc87dc4996dcf65a4893d4e2c3a6b593002] net: fec: Restart PPS after link state change
git bisect good a1477dc87dc4996dcf65a4893d4e2c3a6b593002
# bad: [1910bd470a0acea01b88722be61f0dfa29089730] net: microchip: Make FDMA config symbol invisible
git bisect bad 1910bd470a0acea01b88722be61f0dfa29089730
# bad: [d9335d0232d2da605585eea1518ac6733518f938] net: fec: Reload PTP registers after link-state change
git bisect bad d9335d0232d2da605585eea1518ac6733518f938
# first bad commit: [d9335d0232d2da605585eea1518ac6733518f938] net: fec: Reload PTP registers after link-state change


