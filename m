Return-Path: <netdev+bounces-94385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A58BF4E2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B7FB21506
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355513AC5;
	Wed,  8 May 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHkePrNb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C310A31
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715138221; cv=none; b=KBzEC7Y1+bV4G9SyreAcHX0O/fQ5HJeesQKmYGKhKYmpSkm6H7fGrtJw8iKA+b7biwkcCvdP3A+cMgTWlVWmUKEq8ukw807HVn5VZMUXp5hIi0XlLDhasjuu+VRn1vuyX0N1Nr8N5N8abneTqDPoV78q2gyzbaX/sRkLay/tPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715138221; c=relaxed/simple;
	bh=5YlwT9+AGYtpgGE+ZaBdfrjkfWqqNSM9whMdgyvPNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4XcK0UWWUGmJ8rstM1mswK5jjf+ekeHDfS/ivBgfLqzUzKP+FAyMQDHgGMS0UxABhqmnmOh6GR8JxvwQJYQf0+u2Ew1EM94vefwvaAL3KJLHABLA+9k1pzML8iNL2cODaPycFD+Ylpw6HsuqVX1NdglIqvaWKPxnNw0qXtMUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHkePrNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715138218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBNdbtmMlMYW2VGt8wlb8qF8b+bm09hg0o22wzkONDk=;
	b=GHkePrNbdfEq31ltp0MNctD+0tOKoUp1AqC6fUZ4+iqJRUcEEeEYsfKhM+Gtseo7umfMau
	I2cBLL7ltfcx54Qvs8KK9UOikn7xy1pRVmDVCVpKNnj727coJ9EBmVJZjocP6NqltdJ0jR
	hAO8KeUXqqn2/uceu/O/o1lSA7+NaFI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-coeWBcRdPkiLECCOeGQwDg-1; Tue, 07 May 2024 23:16:57 -0400
X-MC-Unique: coeWBcRdPkiLECCOeGQwDg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so3122702a12.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 20:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715138216; x=1715743016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBNdbtmMlMYW2VGt8wlb8qF8b+bm09hg0o22wzkONDk=;
        b=dkAZx4rLWOqDPeqbaGP+wzxxW9f+X1wz6pdBG5UucsZBqxoE46iiqL2pMKnG815las
         hARviLN6Fk+blg8gbub8BC57CISlbgcg4yHqhOwGS2BNw2E+gVkg3Sn0rTuMjq5dPjEZ
         U6yT0Xs77jurPA3Qb5kMKZMn1Ae6Hu5BmIap+CfniMo6emGIo8QzR3p/Vb/RW/VFNgBv
         xoiUwIeuZloW2dN0RfVeWfl1UPg0Z7CFvXdpGrAC+ukfann2kEOmUYnKIoy3zO+iCBC7
         1KVoSoyEpkmdHtOgvGu9+yr6SxmR68i0yV8lKCQctvNmkOdUEmSI7C+3qLGdMOX2PMrO
         QYuQ==
X-Gm-Message-State: AOJu0YyNDOB+49cRWIp5bNma1Su/jebBKjagjlus3xF6daTJdBhsI2jB
	equ5mDmMkstZJk6zidmdSDV2nfYHhZ8EnTNIKWsxTTYAZXPwBUibGnKrYq+M5WLhGZUd7A0xjxl
	J4y/VvYd9vwPHojMCZayjEkjloKhinNE1dZTQ+Ik0yIrIJ4R26HVPWLzHYDqaQtIIyvErDpt8yx
	EBmaelPHwaeNS/Vx4Pw71JOkHQ0pXctwi3EhVOt7c=
X-Received: by 2002:a05:6a20:5650:b0:1af:9fba:e38f with SMTP id adf61e73a8af0-1afc8dbe1a2mr1293210637.40.1715138215703;
        Tue, 07 May 2024 20:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxDOC735IPszmwWjv/69v3XVXMSRDjdHX5DPxTzIUvCa7YY6od05dUxOllqrbkdMrT7Or8GsjKBzpgK2Lakl0=
X-Received: by 2002:a05:6a20:5650:b0:1af:9fba:e38f with SMTP id
 adf61e73a8af0-1afc8dbe1a2mr1293201637.40.1715138215262; Tue, 07 May 2024
 20:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0DC02AF7-2555-4BBB-847E-A235BCCF7069@gmail.com>
In-Reply-To: <0DC02AF7-2555-4BBB-847E-A235BCCF7069@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 11:16:43 +0800
Message-ID: <CACGkMEuxb9LEaYETrO9bow4Fw=FCT0emOs9S2mqCtkb3O7_P1Q@mail.gmail.com>
Subject: Re: Virtio Net driver crash in latest version of kernel 6.8.4>
To: Martin Zaharinov <micron10@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 3:32=E2=80=AFPM Martin Zaharinov <micron10@gmail.com=
> wrote:
>
> Hi all
>
> This is bug report with lastes version of kernel 6.8.4 > start getting th=
is crash .

How did you reproduce this and Could you reproduce this with the
latest net.git? (I have a smoking test on net.git and it doesn't seem
to trigger).

Thanks

>
> If any find fix patch please add me.
>
> May  4 09:22:50 [  257.064343][    C5] BUG: unable to handle page fault f=
or address: ffff889c54c225c0
> May  4 09:22:50 [  257.064923][    C5] #PF: supervisor write access in ke=
rnel mode
> May  4 09:22:50 [  257.064923][    C5] #PF: error_code(0x0003) - permissi=
ons violation
> May  4 09:22:50 [  257.064923][    C5] PGD 255c01067 P4D 255c01067 PUD 10=
008b063 PMD 8000000254c001a1
> May  4 09:22:50 [  257.064923][    C5] Oops: 0003 [#1] SMP
> May  4 09:22:50 [  257.064923][    C5] CPU: 5 PID: 0 Comm: swapper/5 Tain=
ted: G           O       6.8.9 #1
> May  4 09:22:50 [  257.064923][    C5] Hardware name: QEMU Standard PC (Q=
35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2=
014
> May  4 09:22:50 [  257.064923][    C5] RIP: 0010:__build_skb_around+0x87/=
0x100
> May  4 09:22:50 [  257.064923][    C5] Code: 24 b8 00 00 00 66 41 89 94 2=
4 b2 00 00 00 66 41 89 8c 24 ae 00 00 00 65 8b 15 d1 ae 86 58 48 01 d8 66 4=
1 89 94 24 86 00 00 00 <48> c7 00 00 00 00 00 48 c7 40 08 00 00 00 00 48 c7=
 40 10 00 00 00
> May  4 09:22:50 [  257.064923][    C5] RSP: 0018:ffffa012c021cc58 EFLAGS:=
 00010286
> May  4 09:22:50 [  257.064923][    C5] RAX: ffff889c54c225c0 RBX: ffff889=
b54c22800 RCX: 00000000ffffffff
> May  4 09:22:50 [  257.064923][    C5] RDX: 0000000000000005 RSI: ffff889=
b54c22800 RDI: ffff889b03273800
> May  4 09:22:50 [  257.064923][    C5] RBP: 00000000000001c0 R08: 0000000=
000000000 R09: 000000000000000c
> May  4 09:22:50 [  257.064923][    C5] R10: 0000000000000002 R11: 0000000=
000000800 R12: ffff889b03273800
> May  4 09:22:50 [  257.064923][    C5] R13: ffff889b00e52e48 R14: 0000000=
0000000c0 R15: ffff889c77d62fa0
> May  4 09:22:50 [  257.064923][    C5] FS:  0000000000000000(0000) GS:fff=
f889c77d40000(0000) knlGS:0000000000000000
> May  4 09:22:50 [  257.064923][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
> May  4 09:22:50 [  257.081266][    C5] CR2: ffff889c54c225c0 CR3: 0000000=
10e8b7000 CR4: 00000000003506f0
> May  4 09:22:50 [  257.081266][    C5] Call Trace:
> May  4 09:22:50 [  257.081266][    C5]  <IRQ>
> May  4 09:22:50 [  257.081266][    C5]  ? __die+0xe4/0xf0
> May  4 09:22:50 [  257.081266][    C5]  ? page_fault_oops+0x144/0x3e0
> May  4 09:22:50 [  257.081266][    C5]  ? search_exception_tables+0x42/0x=
50
> May  4 09:22:50 [  257.081266][    C5]  ? fixup_exception+0x1d/0x2d0
> May  4 09:22:50 [  257.081266][    C5]  ? exc_page_fault+0x92/0xa0
> May  4 09:22:50 [  257.081266][    C5]  ? asm_exc_page_fault+0x22/0x30
> May  4 09:22:50 [  257.081266][    C5]  ? __build_skb_around+0x87/0x100
> May  4 09:22:50 [  257.081266][    C5]  __napi_alloc_skb+0x1d8/0x3e0
> May  4 09:22:50 [  257.081266][    C5]  page_to_skb+0x19d/0x5d0 [virtio_n=
et]
> May  4 09:22:50 [  257.081266][    C5]  receive_mergeable+0x10b/0x560 [vi=
rtio_net]
> May  4 09:22:50 [  257.081266][    C5]  receive_buf+0x4df/0xda0 [virtio_n=
et]
> May  4 09:22:50 [  257.081266][    C5]  ? detach_buf_split+0xab/0x1a0 [vi=
rtio_ring]
> May  4 09:22:50 [  257.093416][    C5]  virtnet_poll+0x20b/0x690 [virtio_=
net]
> May  4 09:22:50 [  257.093416][    C5]  __napi_poll+0x20/0x190
> May  4 09:22:50 [  257.093416][    C5]  net_rx_action+0x29f/0x380
> May  4 09:22:50 [  257.093416][    C5]  __do_softirq+0xcd/0x1f8
> May  4 09:22:50 [  257.093416][    C5]  irq_exit_rcu+0x82/0xa0
> May  4 09:22:50 [  257.093416][    C5]  common_interrupt+0x7a/0xa0
> May  4 09:22:50 [  257.093416][    C5]  </IRQ>
> May  4 09:22:50 [  257.093416][    C5]  <TASK>
> May  4 09:22:50 [  257.093416][    C5]  asm_common_interrupt+0x22/0x40
> May  4 09:22:50 [  257.093416][    C5] RIP: 0010:default_idle+0xb/0x10
> May  4 09:22:50 [  257.093416][    C5] Code: 07 76 e7 48 89 07 49 c7 c0 0=
8 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 0=
0 2d 37 3a 3e 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 04 25 40 38 02 00 f0 80 48=
 02 20 48 8b 10
> May  4 09:22:50 [  257.093416][    C5] RSP: 0018:ffffa012c00cfef0 EFLAGS:=
 00000206
> May  4 09:22:50 [  257.093416][    C5] RAX: ffff889c77d61268 RBX: 0000000=
000000005 RCX: 0000000000000000
> May  4 09:22:50 [  257.093416][    C5] RDX: 0000000000000000 RSI: 0000000=
000000083 RDI: 0000000000091294
> May  4 09:22:50 [  257.093416][    C5] RBP: ffff889b0032dd00 R08: 0000000=
00001f340 R09: ffff889c77d5f340
> May  4 09:22:50 [  257.093416][    C5] R10: ffff889c77d5f340 R11: 0000000=
000100000 R12: 0000000000000000
> May  4 09:22:50 [  257.093416][    C5] R13: 0000000000000000 R14: ffff889=
b0032dd00 R15: 0000000000000000
> May  4 09:22:50 [  257.093416][    C5]  default_idle_call+0x1f/0x30
> May  4 09:22:50 [  257.093416][    C5]  do_idle+0x1df/0x210
> May  4 09:22:50 [  257.110747][    C5]  cpu_startup_entry+0x20/0x30
> May  4 09:22:50 [  257.110747][    C5]  start_secondary+0xe1/0xf0
> May  4 09:22:50 [  257.110747][    C5]  secondary_startup_64_no_verify+0x=
170/0x17b
> May  4 09:22:50 [  257.110747][    C5]  </TASK>
> May  4 09:22:50 [  257.110747][    C5] Modules linked in: xsk_diag unix_d=
iag pppoe pppox ppp_generic slhc nf_conntrack_sip nf_conntrack_ftp nf_connt=
rack_pptp nft_ct nft_nat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 nf_tables netconsole virtio_net net_failover failover virtio_=
pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring vmxnet3 =
aesni_intel crypto_simd cryptd
> May  4 09:22:50 [  257.110747][    C5] CR2: ffff889c54c225c0
> May  4 09:22:50 [  257.110747][    C5] ---[ end trace 0000000000000000 ]-=
--
> May  4 09:22:50 [  257.110747][    C5] RIP: 0010:__build_skb_around+0x87/=
0x100
> May  4 09:22:50 [  257.110747][    C5] Code: 24 b8 00 00 00 66 41 89 94 2=
4 b2 00 00 00 66 41 89 8c 24 ae 00 00 00 65 8b 15 d1 ae 86 58 48 01 d8 66 4=
1 89 94 24 86 00 00 00 <48> c7 00 00 00 00 00 48 c7 40 08 00 00 00 00 48 c7=
 40 10 00 00 00
> May  4 09:22:50 [  257.110747][    C5] RSP: 0018:ffffa012c021cc58 EFLAGS:=
 00010286
> May  4 09:22:50 [  257.110747][    C5] RAX: ffff889c54c225c0 RBX: ffff889=
b54c22800 RCX: 00000000ffffffff
> May  4 09:22:50 [  257.110747][    C5] RDX: 0000000000000005 RSI: ffff889=
b54c22800 RDI: ffff889b03273800
> May  4 09:22:50 [  257.110747][    C5] RBP: 00000000000001c0 R08: 0000000=
000000000 R09: 000000000000000c
> May  4 09:22:50 [  257.126458][    C5] R10: 0000000000000002 R11: 0000000=
000000800 R12: ffff889b03273800
> May  4 09:22:50 [  257.126458][    C5] R13: ffff889b00e52e48 R14: 0000000=
0000000c0 R15: ffff889c77d62fa0
> May  4 09:22:50 [  257.126458][    C5] FS:  0000000000000000(0000) GS:fff=
f889c77d40000(0000) knlGS:0000000000000000
> May  4 09:22:50 [  257.126458][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
> May  4 09:22:50 [  257.126458][    C5] CR2: ffff889c54c225c0 CR3: 0000000=
10e8b7000 CR4: 00000000003506f0
> May  4 09:22:50 [  257.126458][    C5] Kernel panic - not syncing: Fatal =
exception in interrupt
> May  4 09:22:50 [  257.126458][    C5] Kernel Offset: 0x26000000 from 0xf=
fffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> May  4 09:22:50 [  257.126458][    C5] Rebooting in 10 seconds..
>


