Return-Path: <netdev+bounces-210593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A54B1401C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399D218C1168
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F52277CA8;
	Mon, 28 Jul 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HGYrnCgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46309277C9B
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719543; cv=none; b=miW3ZY5milrQFgY2dTb01wQrHKW1RvSm1pwngHA5m/UdDLKbtvVq2ds0VZi9ZkOYH3frH36AhJrCh3I3h9N8X2YjxSVrUpmvCdvirIP3tv47gadag/fF6B/c1xBv75zdNMaiPzriMiNInts90SH7+FVZQOrJb6641ZgxxhrFCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719543; c=relaxed/simple;
	bh=60xIRlA+0ANYUYS/K4vR+KJQrRsfsTKa73vxrJMwLPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLQm0XfO/zkWHAnKz1R4PUch/5foVFFC/crdhVNbrI6hyXAkil7cCqpqCBDlcnqMc8mO6Pg9XuMd2BL+vep5zYASUaf+aSa2Hkbs48DtbOMMbz58zeXbmUEE2tZ37KUvg4kWFUiYIbBYpHcxhyFcUtsxycNEYl83D75VlPv0NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HGYrnCgU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so3646519a91.2
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753719541; x=1754324341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2cj4YfPSXVmYoc4IiWft3+ar6a3KqtRrSDGyMRAmig=;
        b=HGYrnCgUh6iI+Bym0MsIvBj2TZqykrw/F0F7sE0oCg/Y6uUX9AhN2ikUcmBiu1UANb
         40ua8fyEw5n7XNOlIG+qUQLdJ7OANLA2fmAuF8GGBvOeHBqkEa/bkgWqOjUbmQAYFal4
         o4ZcTY0z5ArpEdL8Fwk6HxIvZ5Eljd6uH08QjZX44+vFV5DpS/Rcw3ET4BADEASeVClV
         bUzH4zL/eqIsTn2A4eJlGCmR/2tT+9mCr0SCzXidehz5JawayYfWNbG9r/m1g/arOCwX
         Ej25mVQLUnQT7m3TENhqYlZq1AN281aN2GqwB+s3Ty6lX9GfTxJyouQmEq7rmJ3n7Y3H
         VDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753719541; x=1754324341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2cj4YfPSXVmYoc4IiWft3+ar6a3KqtRrSDGyMRAmig=;
        b=auFFmQwKE0HQSxHtl1T94hd6XFFA2cbgxf8oZ/vHm2o7c9FpELXsZsOz3O4XAYB/kX
         sFb02exnirafVK51nREaG8u79YjLpiHWKRNJMASpvSteyRA5FZZCGqOUpygcMSKWodTi
         ek7iOt8VcflL+j8WSd5hvfPuHzu1UxW1mSZ794gP79XmY1KTVwY89gmT2uKoOS/aJbVV
         x8wimhA0ALj6mj/X2881hof5lVLR9T28lqoOgq86jWrDDEgdSfiT16+GLEGiuxv4jn/c
         aFf5KEURXUIitP6qqHc1+4WGhbVZ0ZzGFegqg7QG+GBR1qRCXUnZskF/czrSEkSexTCm
         kepQ==
X-Gm-Message-State: AOJu0Yx83c8CDNxxxB83GkDoZm2H1tSk8RDpw32DiJjfcfffWoH8AnJM
	Sc6U1vBBCJ5/+xhJaorf7TPHLJjuwUEu/nfOzMU+6v3LPQgBEVxo7bFGnrBCbgdrygU=
X-Gm-Gg: ASbGncu2mCbhKMdO7Oe1xc23uBYlZNEfdwc6HIiVykopy/clWZjNjWMPz0IBn6JE6GJ
	hcHnFbxuH/twS8/lErN2uZ1jZ3DUzfIKzQiw/zcJN8aiv/9OSG0vwfCgewdlWbEZ3hHf8akxx0d
	umNyPnRJcSXuXJ7VxdpXmlqkEQx3kNbIfNuVhv7VKUFBT7S2jMTSp9vMsRZV4l98hnFnz/6acba
	R2xSrV3hPDfiFc14jpsV4oU3a9og96DbojyPbLMSSx34JAWNGucBD4XpmT8LQ8/GCDpFF3HNDea
	ScHVqNAALMV/Hqcr6Fz69kmyRgFPNnBO1iCAf9Kpl5X8UP9cg3R+XhMpxS+gr7G4QUtXe0bepRy
	+sqApEjBi7YtHYtm6vctAulNkIgPNHVbZ7LEnGxAKqw==
X-Google-Smtp-Source: AGHT+IEFX22EWCqIkNp4/fQDHmFrpLU/BsbuivBi5shbtLhS/OV5Qc6cgb1uvEXTNr14F3ZT8SfVHQ==
X-Received: by 2002:a17:90b:3c88:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-31e77b0a72dmr17767843a91.27.1753719541243;
        Mon, 28 Jul 2025 09:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([104.28.237.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ec1c5cfc9sm4054288a91.28.2025.07.28.09.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jul 2025 09:19:00 -0700 (PDT)
Message-ID: <8743bbc9-8299-495c-8aef-842197bd8714@cloudflare.com>
Date: Mon, 28 Jul 2025 09:18:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ice: General protection fault in ptp_clock_index
To: Frederick Lawler <fred@cloudflare.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AndrewLunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com,
 intel-wired-lan@lists.osuosl.org
References: <aIKWoZzEPoa1omlw@CMGLRV3>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
In-Reply-To: <aIKWoZzEPoa1omlw@CMGLRV3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+IWL

Hi Intel team, anyone have an idea on this? Looks like maybe removal of 
device 0 that had originally registered PTP clock isn't handled well?

On 7/24/25 1:25 PM, Frederick Lawler wrote:
> Hi,
> 
> On Linux 6.12.39, we appear to hit a race reading ethtool while the
> device is removed.
> 
> We have automation to remove unused interfaces during early boot
> process, and when systemd is restarting the network afterwards, we
> get a page fault and get into a boot-crash-loop state. We're currently
> renaming the interface to something like unused0 to circumvent the
> issue.
> 
> I was able to reproduce with the following snippet:
> 
> $ watch -n0.1 /sbin/ethtool -T ext0
> $ echo -n "1" | sudo tee /sys/class/net/ext0/device/remove
> 
> ice 0000:41:00.0: Removed PTP clock
> 
> ...
> 
> Oops: general protection fault, probably for non-canonical address 0xae09e2b3b0c665f1: 0000 [#1] PREEMPT SMP NOPTI
> Tainted: [O]=OOT_MODULE
> Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS HR355M_V3.G.031 02/17/2025
> RIP: 0010:ptp_clock_index (drivers/ptp/ptp_clock.c:476 (discriminator 1))
> Code: 38 1b 4e 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 94 03 00 00 e9 07 1b 4e 00 66 66 2e 0f 1f 84 00 00 00 00 00
> All code
> ========
>     0:	38 1b                	cmp    %bl,(%rbx)
>     2:	4e 00 66 66          	rex.WRX add %r12b,0x66(%rsi)
>     6:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
>     d:	00 00
>     f:	66 90                	xchg   %ax,%ax
>    11:	90                   	nop
>    12:	90                   	nop
>    13:	90                   	nop
>    14:	90                   	nop
>    15:	90                   	nop
>    16:	90                   	nop
>    17:	90                   	nop
>    18:	90                   	nop
>    19:	90                   	nop
>    1a:	90                   	nop
>    1b:	90                   	nop
>    1c:	90                   	nop
>    1d:	90                   	nop
>    1e:	90                   	nop
>    1f:	90                   	nop
>    20:	90                   	nop
>    21:	f3 0f 1e fa          	endbr64
>    25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    2a:*	8b 87 94 03 00 00    	mov    0x394(%rdi),%eax		<-- trapping instruction
>    30:	e9 07 1b 4e 00       	jmp    0x4e1b3c
>    35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
>    3c:	00 00 00 00
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	8b 87 94 03 00 00    	mov    0x394(%rdi),%eax
>     6:	e9 07 1b 4e 00       	jmp    0x4e1b12
>     b:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
>    12:	00 00 00 00
> RSP: 0018:ffffb5664f657c88 EFLAGS: 00010282
> RAX: ffff9f4854c201a0 RBX: ffffb5664f657d34 RCX: ffffffffc1c6a5c0
> RDX: 555485607aaada55 RSI: ffffb5664f657d34 RDI: ae09e2b3b0c6625d
> RBP: ffffb5664f657df0 R08: 0000000000000000 R09: ffff9f3124c570a8
> R10: ffffb5664f657cc0 R11: 0000000000000001 R12: ffffffffafab4680
> R13: 00007ffc828fdbb0 R14: ffff9f3124c57000 R15: ffffb5664f657d80
> FS:  00007ff5abba1340(0000) GS:ffff9f402f600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff5ac03f0c0 CR3: 0000000a8768e006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ice_get_ts_info (drivers/net/ethernet/intel/ice/ice_ethtool.c:3776 (discriminator 1)) ice
> __ethtool_get_ts_info (net/ethtool/common.c:713)
> __ethtool_get_ts_info (net/ethtool/common.c:713)
> dev_ethtool (net/ethtool/ioctl.c:2651 net/ethtool/ioctl.c:3312 net/ethtool/ioctl.c:3390)
> ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> ? trace_call_bpf (kernel/trace/bpf_trace.c:151 (discriminator 38))
> ? security_file_ioctl (security/security.c:2909)
> ? trace_call_bpf (kernel/trace/bpf_trace.c:151 (discriminator 38))
> ? __x64_sys_ioctl (fs/ioctl.c:893)
> ? kprobe_ftrace_handler (arch/x86/kernel/kprobes/ftrace.c:45 (discriminator 1))
> ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> dev_ioctl (net/core/dev_ioctl.c:720)
> sock_ioctl (net/socket.c:1242 net/socket.c:1346)
> __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:907 fs/ioctl.c:893 fs/ioctl.c:893)
> osnoise_arch_unregister (??:?)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7ff5abe13d1b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> All code
> ========
>     0:	00 48 89             	add    %cl,-0x77(%rax)
>     3:	44 24 18             	rex.R and $0x18,%al
>     6:	31 c0                	xor    %eax,%eax
>     8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
>     d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
>    14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
>    19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
>    1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
>    23:	b8 10 00 00 00       	mov    $0x10,%eax
>    28:	0f 05                	syscall
>    2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
>    2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>    31:	77 1c                	ja     0x4f
>    33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
>    38:	64                   	fs
>    39:	48                   	rex.W
>    3a:	2b                   	.byte 0x2b
>    3b:	04 25                	add    $0x25,%al
>    3d:	28 00                	sub    %al,(%rax)
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	89 c2                	mov    %eax,%edx
>     2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>     7:	77 1c                	ja     0x25
>     9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
>     e:	64                   	fs
>     f:	48                   	rex.W
>    10:	2b                   	.byte 0x2b
>    11:	04 25                	add    $0x25,%al
>    13:	28 00                	sub    %al,(%rax)
> 	...
> RSP: 002b:00007ffc828fdb20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000056370e675800 RCX: 00007ff5abe13d1b
> RDX: 00007ffc828fdb80 RSI: 0000000000008946 RDI: 0000000000000005
> RBP: 000056370e6757e0 R08: 00007ff5abee8c60 R09: 0000000000000000
> R10: 00007ff5abd2f310 R11: 0000000000000246 R12: 00007ffc828fdd80
> R13: 0000000000000005 R14: 00007ffc828fdb80 R15: 00007ffc828fff1a
> </TASK>
> 


