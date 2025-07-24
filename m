Return-Path: <netdev+bounces-209876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E16B11232
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27D5AC1FB9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36F23D2A4;
	Thu, 24 Jul 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e3U1AQ1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67143237164
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388711; cv=none; b=iTZuT5LOhJQmT8TBwsUC9eCkgheA4xpwq6yS7Z4xIdIhxmaDyLdjlTH1Pkm3OkBiEdK5xpaYSkW/NkJUa0OtmFOIxXGxhirojbsztEua4a9CVrt40skEqNyN8RpzeeN/5LyONX2tHSHJ5bNGStcAXJBjBJEwiWUemAzz995Nsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388711; c=relaxed/simple;
	bh=M/S0/7S8LCyDg3pVE8cNlERu5qdSEMXf/JCowNZDCoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RvaO+Y4oO/lS59QVrwzGwbRsdrhGb7PPoEiI+7xLhHdxUUOEYTKKYl6Xf9YE0VPtsvUIlHODn6hsQ7QSismWwRmXeRJcZXQ0czdKZFi84pRfIZyAStkYVhV5/+nfYt/GL9w9L5AurCTUYg2FAVLgxm2TepcV9rffEpHRYMs843s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e3U1AQ1O; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso5499945ab.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753388708; x=1753993508; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IySQOI7GYeMgMHfhqdodve6axYgAm2CZvFEfDYNh9Yw=;
        b=e3U1AQ1OPuAQWfJvzgmJBRjR+jjr3n7DfFKJSdDul8Moe+wZ+6wn7+L2DHVK/2pTMO
         MgJjYaD8KlqfcEXa/xmEg3mmoIdu+uaVcq/HblmDO/o+IsoWjBzwUhWraLFuVEpwyoHV
         tzCNlnlqXIIRG07rtY6s8URpqwZ3xWLoVhcnZAnIIlD0RKr7abn3hhOQh6S7MYK1EbZx
         rAsbMv0ZJR55rKaIHQIl/ylSe6s/66ej3gH7pwVHq4d+XL0mGU7vCgM4RVCVUrUHSMKT
         jkBo1B+iGf4egA5RNPu4FActQpojhD1j4ezeE0QG3QiMCMrRwaFdR7tgzMaljT/teR95
         wQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388708; x=1753993508;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IySQOI7GYeMgMHfhqdodve6axYgAm2CZvFEfDYNh9Yw=;
        b=KgStcWfS8DGgawOBgu6JWp3noRo06i/QnVNtWxU8w6iWq+47a31Wjt7fquF+pH6yVf
         IvvlChgUo1ZAEAP4intZO11BAFpZLPoF75aBY/IE0F4DpT0gYbuTFBfgRVOXDNunes4F
         wStiLbBVl7VoYIgvNSjefMGyAqUMWpbjdpI/JJZlqOujTdW5DqWSpCXJbgY2hDZqvX+I
         HtmSs0IKTaAny5EE+HjagQrwsXC4yVAmz+fzlht+exLdL2SnzD0dkqD5SFaBoBczBFfZ
         h1F4VnFoCvALNsFhVKGGnaQgI2fE3ScIAYMsjI1M2cT1sJ6FwE/403/MET7iWJ4YnAuV
         MwCQ==
X-Gm-Message-State: AOJu0YwAGc7x2SRjFG3ObEkKNotV5uJv/INLCOI5KsBgmcs8UUQ1h8vf
	OpcEKAJ5n5PwOG2GLn9jY35AEd+3DfIGUucjBDaKlNrjKulR+VDVMGpRMlLTgR1pDfs=
X-Gm-Gg: ASbGnctJgmAryFw97vYOfY2OJ6lKjsui4GplBqpoWCXMyM0us6wlf+Ql+uBgoYMc9aI
	sLpsEhx08QWX2PSyMvc3NML6PjaALFjogg4DKgqKl8/JwSH32lEnAE3LWG+/NQjQ2cLmSmqzAQB
	ohMT6Z41urAgLc15Q4LvO7j+zBbPAzt3GwEbwYB/zNKKruKJCsbhjDuWukOhQgWFdXv1P6XYyRI
	qGHqpAOvslKyupzTfB8ZAXUETSjo8rgfN27J2oKbumwWsptF/DUXGRtkxC9lG8DydS6YRajg8wP
	Mfy+ci7ghiTVM5Zv8dK6UkE4ywSiTsm/xh21cQe+pymthtbrX1N4nEvOEhtQpQGIEFk/906+zJP
	27w==
X-Google-Smtp-Source: AGHT+IGSnGleulhZWkm1BpKgp5a86MvvH3HHjml0VP9G1bidqZRg2ywUiuffylRdxrhhyavIZrakZw==
X-Received: by 2002:a05:6e02:2302:b0:3e2:9ffc:bcde with SMTP id e9e14a558f8ab-3e32fc8e2d9mr126914855ab.6.1753388708340;
        Thu, 24 Jul 2025 13:25:08 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8250:4e6::7d:7b])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3b711c757sm8506605ab.23.2025.07.24.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:25:08 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:25:05 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AndrewLunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, jbrandeburg@cloudflare.com
Subject: ice: General protection fault in ptp_clock_index
Message-ID: <aIKWoZzEPoa1omlw@CMGLRV3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Linux 6.12.39, we appear to hit a race reading ethtool while the
device is removed.

We have automation to remove unused interfaces during early boot
process, and when systemd is restarting the network afterwards, we
get a page fault and get into a boot-crash-loop state. We're currently
renaming the interface to something like unused0 to circumvent the
issue.

I was able to reproduce with the following snippet:

$ watch -n0.1 /sbin/ethtool -T ext0
$ echo -n "1" | sudo tee /sys/class/net/ext0/device/remove

ice 0000:41:00.0: Removed PTP clock

...

Oops: general protection fault, probably for non-canonical address 0xae09e2b3b0c665f1: 0000 [#1] PREEMPT SMP NOPTI
Tainted: [O]=OOT_MODULE
Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS HR355M_V3.G.031 02/17/2025
RIP: 0010:ptp_clock_index (drivers/ptp/ptp_clock.c:476 (discriminator 1))
Code: 38 1b 4e 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 94 03 00 00 e9 07 1b 4e 00 66 66 2e 0f 1f 84 00 00 00 00 00
All code
========
   0:	38 1b                	cmp    %bl,(%rbx)
   2:	4e 00 66 66          	rex.WRX add %r12b,0x66(%rsi)
   6:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
   d:	00 00
   f:	66 90                	xchg   %ax,%ax
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	f3 0f 1e fa          	endbr64
  25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  2a:*	8b 87 94 03 00 00    	mov    0x394(%rdi),%eax		<-- trapping instruction
  30:	e9 07 1b 4e 00       	jmp    0x4e1b3c
  35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  3c:	00 00 00 00

Code starting with the faulting instruction
===========================================
   0:	8b 87 94 03 00 00    	mov    0x394(%rdi),%eax
   6:	e9 07 1b 4e 00       	jmp    0x4e1b12
   b:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  12:	00 00 00 00
RSP: 0018:ffffb5664f657c88 EFLAGS: 00010282
RAX: ffff9f4854c201a0 RBX: ffffb5664f657d34 RCX: ffffffffc1c6a5c0
RDX: 555485607aaada55 RSI: ffffb5664f657d34 RDI: ae09e2b3b0c6625d
RBP: ffffb5664f657df0 R08: 0000000000000000 R09: ffff9f3124c570a8
R10: ffffb5664f657cc0 R11: 0000000000000001 R12: ffffffffafab4680
R13: 00007ffc828fdbb0 R14: ffff9f3124c57000 R15: ffffb5664f657d80
FS:  00007ff5abba1340(0000) GS:ffff9f402f600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff5ac03f0c0 CR3: 0000000a8768e006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
<TASK>
ice_get_ts_info (drivers/net/ethernet/intel/ice/ice_ethtool.c:3776 (discriminator 1)) ice
__ethtool_get_ts_info (net/ethtool/common.c:713)
__ethtool_get_ts_info (net/ethtool/common.c:713)
dev_ethtool (net/ethtool/ioctl.c:2651 net/ethtool/ioctl.c:3312 net/ethtool/ioctl.c:3390)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? trace_call_bpf (kernel/trace/bpf_trace.c:151 (discriminator 38))
? security_file_ioctl (security/security.c:2909)
? trace_call_bpf (kernel/trace/bpf_trace.c:151 (discriminator 38))
? __x64_sys_ioctl (fs/ioctl.c:893)
? kprobe_ftrace_handler (arch/x86/kernel/kprobes/ftrace.c:45 (discriminator 1))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
dev_ioctl (net/core/dev_ioctl.c:720)
sock_ioctl (net/socket.c:1242 net/socket.c:1346)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:907 fs/ioctl.c:893 fs/ioctl.c:893)
osnoise_arch_unregister (??:?)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7ff5abe13d1b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall
  2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
  2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  31:	77 1c                	ja     0x4f
  33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	2b                   	.byte 0x2b
  3b:	04 25                	add    $0x25,%al
  3d:	28 00                	sub    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	89 c2                	mov    %eax,%edx
   2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   7:	77 1c                	ja     0x25
   9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   e:	64                   	fs
   f:	48                   	rex.W
  10:	2b                   	.byte 0x2b
  11:	04 25                	add    $0x25,%al
  13:	28 00                	sub    %al,(%rax)
	...
RSP: 002b:00007ffc828fdb20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000056370e675800 RCX: 00007ff5abe13d1b
RDX: 00007ffc828fdb80 RSI: 0000000000008946 RDI: 0000000000000005
RBP: 000056370e6757e0 R08: 00007ff5abee8c60 R09: 0000000000000000
R10: 00007ff5abd2f310 R11: 0000000000000246 R12: 00007ffc828fdd80
R13: 0000000000000005 R14: 00007ffc828fdb80 R15: 00007ffc828fff1a
</TASK>


