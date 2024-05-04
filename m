Return-Path: <netdev+bounces-93417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A48BB9D7
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785FC283472
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F664C8D;
	Sat,  4 May 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXizey1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8574DF5B
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807932; cv=none; b=BseaQsRmJyyYbtgnYE4nqHP0rJfhEnBK3ez97bexXK85xbJCyxQrWHp6E+9p5sndPvzr2hb72/vQIKh/aYxiWSp7w+kcwfCkMDAyrVsDjgVaG5oU2FeGhWaC6nAueMRtTUElcCvZ+0m42UMkMMaKFvehS3KDEmEowvHaouzOo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807932; c=relaxed/simple;
	bh=R49l+mhwhitdlHaaH3xW581b2m2wVMSYO04MCy1Htnk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=VBzEi6wzUmxeer3VFZP4HYqLCDyfPRYfF3XhfWjwdaBVr8qWtAH9sURFGXqPo6NDlDfTu7PYj5KObTxRPNsu4VOv449UJ2S8ZLbOUM3Y8C1ffYvYvXJ2NJXcHoq3Zr/hUoPxZ1AmTNKdUWVWIjxyp5Ns846z8pMgj53QZItk84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXizey1A; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599eedc8eeso65178166b.1
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714807929; x=1715412729; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfERDrr+hXPPAsh6QW7Uuu0UfodLRjq1afDMA3m3CfU=;
        b=bXizey1A/XXVCzr/VxscjbyaMlC0QkvFY6yJzlfL6geRvVMDKzfLNj8B8U+DvV5yVX
         gdaDy5KO77HW5s5swUZKNQbPQmiUwqtZa+zHK08TLtR2i27JvKOFqzAmUVg3KcHyojaR
         pwx2ErJSKqGmLfuBjfOfhN2K1eq2IesTYiZi9gDxDH7o8/YXBQGMJYFF+p//euM60izz
         XDIGp+WwGbMi2nIMRxX21deY9dvaNhGC83eBDPnXAJrHIcy895V5fZ+KGTStbGWXBlEb
         ujdM4EQxPm3SSe2hNGtQrxcmIthUHB+7lM6lZJdAE2ZfLn3OLLxEFaIG/nHF4mv2Y8Ko
         IneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807929; x=1715412729;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfERDrr+hXPPAsh6QW7Uuu0UfodLRjq1afDMA3m3CfU=;
        b=ZagtDufTSkzH5mbaSPk8/Rlp7CM7oZxYfRjs+oD2gtvSfw5QdyTwqKH8rdmIdFDuEG
         JGBOnq+DrTKKVDC7kXUpjML873JKgtAoa2cwj2OmRhdSVyQrnxxBTepVK87IHMwFxc3i
         yDWCEiUcV2bcV4W5aet8/JMGL4Qy+mRxp6gRFGOIbVHh8ml7cCmzvHOv0sfFuii0UDqQ
         Dmsd6chsxksJ2/nQy8uJNLMtaZIhu3eyG1Gq2gVwpDextfBV6OSitc+7krI2TqZ5tFJZ
         Xt5oMfEmlEB6jvwsL7XZMCMiBAQB8AEK9ugrkTvBV3YnBO5AfZdK/MMwBfHNQz7cqlof
         tYhA==
X-Gm-Message-State: AOJu0YxCQhZYv+GjfMGqW90cBGd7ovM4X2VxD00yrBelyg5K7lLkHTHT
	2S+6xFb9e73opf6CgO7OqHfLCXHk3mTHNQ820Lg3p2G4tgUyOrWgckkG/A==
X-Google-Smtp-Source: AGHT+IHCuY34625lQiEvdkglQMlGqu/w8MIc6DSQ6pobXInopZbo32OOKKqyHupRlVogNzsK1McAMg==
X-Received: by 2002:a50:c355:0:b0:572:2f0d:f4cb with SMTP id q21-20020a50c355000000b005722f0df4cbmr3019932edb.1.1714807928445;
        Sat, 04 May 2024 00:32:08 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00562d908daf4sm2635500edq.84.2024.05.04.00.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2024 00:32:07 -0700 (PDT)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Virtio Net driver crash in latest version of kernel 6.8.4> 
Message-Id: <0DC02AF7-2555-4BBB-847E-A235BCCF7069@gmail.com>
Date: Sat, 4 May 2024 10:31:56 +0300
Cc: virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com,
 jasowang@redhat.com
To: netdev <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi all

This is bug report with lastes version of kernel 6.8.4 > start getting =
this crash .

If any find fix patch please add me.

May  4 09:22:50 [  257.064343][    C5] BUG: unable to handle page fault =
for address: ffff889c54c225c0
May  4 09:22:50 [  257.064923][    C5] #PF: supervisor write access in =
kernel mode
May  4 09:22:50 [  257.064923][    C5] #PF: error_code(0x0003) - =
permissions violation
May  4 09:22:50 [  257.064923][    C5] PGD 255c01067 P4D 255c01067 PUD =
10008b063 PMD 8000000254c001a1
May  4 09:22:50 [  257.064923][    C5] Oops: 0003 [#1] SMP
May  4 09:22:50 [  257.064923][    C5] CPU: 5 PID: 0 Comm: swapper/5 =
Tainted: G           O       6.8.9 #1
May  4 09:22:50 [  257.064923][    C5] Hardware name: QEMU Standard PC =
(Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org =
04/01/2014
May  4 09:22:50 [  257.064923][    C5] RIP: =
0010:__build_skb_around+0x87/0x100
May  4 09:22:50 [  257.064923][    C5] Code: 24 b8 00 00 00 66 41 89 94 =
24 b2 00 00 00 66 41 89 8c 24 ae 00 00 00 65 8b 15 d1 ae 86 58 48 01 d8 =
66 41 89 94 24 86 00 00 00 <48> c7 00 00 00 00 00 48 c7 40 08 00 00 00 =
00 48 c7 40 10 00 00 00
May  4 09:22:50 [  257.064923][    C5] RSP: 0018:ffffa012c021cc58 =
EFLAGS: 00010286
May  4 09:22:50 [  257.064923][    C5] RAX: ffff889c54c225c0 RBX: =
ffff889b54c22800 RCX: 00000000ffffffff
May  4 09:22:50 [  257.064923][    C5] RDX: 0000000000000005 RSI: =
ffff889b54c22800 RDI: ffff889b03273800
May  4 09:22:50 [  257.064923][    C5] RBP: 00000000000001c0 R08: =
0000000000000000 R09: 000000000000000c
May  4 09:22:50 [  257.064923][    C5] R10: 0000000000000002 R11: =
0000000000000800 R12: ffff889b03273800
May  4 09:22:50 [  257.064923][    C5] R13: ffff889b00e52e48 R14: =
00000000000000c0 R15: ffff889c77d62fa0
May  4 09:22:50 [  257.064923][    C5] FS:  0000000000000000(0000) =
GS:ffff889c77d40000(0000) knlGS:0000000000000000
May  4 09:22:50 [  257.064923][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
May  4 09:22:50 [  257.081266][    C5] CR2: ffff889c54c225c0 CR3: =
000000010e8b7000 CR4: 00000000003506f0
May  4 09:22:50 [  257.081266][    C5] Call Trace:
May  4 09:22:50 [  257.081266][    C5]  <IRQ>
May  4 09:22:50 [  257.081266][    C5]  ? __die+0xe4/0xf0
May  4 09:22:50 [  257.081266][    C5]  ? page_fault_oops+0x144/0x3e0
May  4 09:22:50 [  257.081266][    C5]  ? =
search_exception_tables+0x42/0x50
May  4 09:22:50 [  257.081266][    C5]  ? fixup_exception+0x1d/0x2d0
May  4 09:22:50 [  257.081266][    C5]  ? exc_page_fault+0x92/0xa0
May  4 09:22:50 [  257.081266][    C5]  ? asm_exc_page_fault+0x22/0x30
May  4 09:22:50 [  257.081266][    C5]  ? __build_skb_around+0x87/0x100
May  4 09:22:50 [  257.081266][    C5]  __napi_alloc_skb+0x1d8/0x3e0
May  4 09:22:50 [  257.081266][    C5]  page_to_skb+0x19d/0x5d0 =
[virtio_net]
May  4 09:22:50 [  257.081266][    C5]  receive_mergeable+0x10b/0x560 =
[virtio_net]
May  4 09:22:50 [  257.081266][    C5]  receive_buf+0x4df/0xda0 =
[virtio_net]
May  4 09:22:50 [  257.081266][    C5]  ? detach_buf_split+0xab/0x1a0 =
[virtio_ring]
May  4 09:22:50 [  257.093416][    C5]  virtnet_poll+0x20b/0x690 =
[virtio_net]
May  4 09:22:50 [  257.093416][    C5]  __napi_poll+0x20/0x190
May  4 09:22:50 [  257.093416][    C5]  net_rx_action+0x29f/0x380
May  4 09:22:50 [  257.093416][    C5]  __do_softirq+0xcd/0x1f8
May  4 09:22:50 [  257.093416][    C5]  irq_exit_rcu+0x82/0xa0
May  4 09:22:50 [  257.093416][    C5]  common_interrupt+0x7a/0xa0
May  4 09:22:50 [  257.093416][    C5]  </IRQ>
May  4 09:22:50 [  257.093416][    C5]  <TASK>
May  4 09:22:50 [  257.093416][    C5]  asm_common_interrupt+0x22/0x40
May  4 09:22:50 [  257.093416][    C5] RIP: 0010:default_idle+0xb/0x10
May  4 09:22:50 [  257.093416][    C5] Code: 07 76 e7 48 89 07 49 c7 c0 =
08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 =
0f 00 2d 37 3a 3e 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 04 25 40 38 02 00 =
f0 80 48 02 20 48 8b 10
May  4 09:22:50 [  257.093416][    C5] RSP: 0018:ffffa012c00cfef0 =
EFLAGS: 00000206
May  4 09:22:50 [  257.093416][    C5] RAX: ffff889c77d61268 RBX: =
0000000000000005 RCX: 0000000000000000
May  4 09:22:50 [  257.093416][    C5] RDX: 0000000000000000 RSI: =
0000000000000083 RDI: 0000000000091294
May  4 09:22:50 [  257.093416][    C5] RBP: ffff889b0032dd00 R08: =
000000000001f340 R09: ffff889c77d5f340
May  4 09:22:50 [  257.093416][    C5] R10: ffff889c77d5f340 R11: =
0000000000100000 R12: 0000000000000000
May  4 09:22:50 [  257.093416][    C5] R13: 0000000000000000 R14: =
ffff889b0032dd00 R15: 0000000000000000
May  4 09:22:50 [  257.093416][    C5]  default_idle_call+0x1f/0x30
May  4 09:22:50 [  257.093416][    C5]  do_idle+0x1df/0x210
May  4 09:22:50 [  257.110747][    C5]  cpu_startup_entry+0x20/0x30
May  4 09:22:50 [  257.110747][    C5]  start_secondary+0xe1/0xf0
May  4 09:22:50 [  257.110747][    C5]  =
secondary_startup_64_no_verify+0x170/0x17b
May  4 09:22:50 [  257.110747][    C5]  </TASK>
May  4 09:22:50 [  257.110747][    C5] Modules linked in: xsk_diag =
unix_diag pppoe pppox ppp_generic slhc nf_conntrack_sip nf_conntrack_ftp =
nf_conntrack_pptp nft_ct nft_nat nft_chain_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables netconsole virtio_net =
net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring vmxnet3 aesni_intel crypto_simd =
cryptd
May  4 09:22:50 [  257.110747][    C5] CR2: ffff889c54c225c0
May  4 09:22:50 [  257.110747][    C5] ---[ end trace 0000000000000000 =
]---
May  4 09:22:50 [  257.110747][    C5] RIP: =
0010:__build_skb_around+0x87/0x100
May  4 09:22:50 [  257.110747][    C5] Code: 24 b8 00 00 00 66 41 89 94 =
24 b2 00 00 00 66 41 89 8c 24 ae 00 00 00 65 8b 15 d1 ae 86 58 48 01 d8 =
66 41 89 94 24 86 00 00 00 <48> c7 00 00 00 00 00 48 c7 40 08 00 00 00 =
00 48 c7 40 10 00 00 00
May  4 09:22:50 [  257.110747][    C5] RSP: 0018:ffffa012c021cc58 =
EFLAGS: 00010286
May  4 09:22:50 [  257.110747][    C5] RAX: ffff889c54c225c0 RBX: =
ffff889b54c22800 RCX: 00000000ffffffff
May  4 09:22:50 [  257.110747][    C5] RDX: 0000000000000005 RSI: =
ffff889b54c22800 RDI: ffff889b03273800
May  4 09:22:50 [  257.110747][    C5] RBP: 00000000000001c0 R08: =
0000000000000000 R09: 000000000000000c
May  4 09:22:50 [  257.126458][    C5] R10: 0000000000000002 R11: =
0000000000000800 R12: ffff889b03273800
May  4 09:22:50 [  257.126458][    C5] R13: ffff889b00e52e48 R14: =
00000000000000c0 R15: ffff889c77d62fa0
May  4 09:22:50 [  257.126458][    C5] FS:  0000000000000000(0000) =
GS:ffff889c77d40000(0000) knlGS:0000000000000000
May  4 09:22:50 [  257.126458][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
May  4 09:22:50 [  257.126458][    C5] CR2: ffff889c54c225c0 CR3: =
000000010e8b7000 CR4: 00000000003506f0
May  4 09:22:50 [  257.126458][    C5] Kernel panic - not syncing: Fatal =
exception in interrupt
May  4 09:22:50 [  257.126458][    C5] Kernel Offset: 0x26000000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
May  4 09:22:50 [  257.126458][    C5] Rebooting in 10 seconds..=

