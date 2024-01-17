Return-Path: <netdev+bounces-64030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77594830BC0
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848171C24F76
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201E224D3;
	Wed, 17 Jan 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3rGZTlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45D225A1
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511514; cv=none; b=ekk7782GYU8p+pdH9MgkQd6uwXpMd2J6nVaMVdIDixExMAPaQTtzdB2Vc49dw26RKTksoWLcj90dz9Q06MWVVSkZG/+i50OTjv6Dgd5jprGUq94iMAFFsrKyZTX0Xd8CDFTcyT+2N9Xu7nnggFtzz+hCvSMLWoS0mDfwS9JwrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511514; c=relaxed/simple;
	bh=SuItVh+vHVjQottoyIEq0buSuq/UjXlSc47i+hPX0PY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=aJ0LQ72lHNQ/013/NT3CNzS9eVGLGBd/BsbknFWOebMoOkuNJgK4EpEXTQDsu+DCCaU6vzpi7Y3uh6djGtZ+E8kFBPgaG3QviWpCKRR6ig7QR0jvCwohd6QSArsicaR40fxXw2K1oSnuNcrDM0Rcap99qPyDLcz29Fo1uS22axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3rGZTlN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336746c7b6dso9646708f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511510; x=1706116310; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lla7aY0ywuKo9baqrT2akYyAYp9CX5vFrWadb8GUa2w=;
        b=S3rGZTlNOzklu3MvJx/fSjhUgDyVbeBQM1OGRKFCzTYWY1xu1eirnm8UQhtx5C7buP
         2+EuMi5YFHRpYG811bp61CM8qY+kbt7u/z7XKUtMPr8RYWwIFxfdW+SGZcsRhmDdL7Oa
         B58p9wsYqtqgOx4/ZEYljqykQEzsIv8ThJDU992fjhEILUVmSD4Yx8v+8SiB0kZE20Mx
         gMydyvbH6IDlTx4Akw3k1CYKFUfKE+PqJ8USRbHfB8HTloWrWB1dAXGKRAMJANcU+gBR
         u5v/N86HcxJLGZDnMQYiS1WLCR1FPiQ8GFO8f3w26je99wf2pUqBGFOvMyTQhYKZaIyq
         FS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511510; x=1706116310;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lla7aY0ywuKo9baqrT2akYyAYp9CX5vFrWadb8GUa2w=;
        b=hgpkB3ePg+GPFn09nD/AqT2KOdNkRvfXHUXw3MU+NovE1vxzfxd5IW4ZErdf7BgBmr
         1XXkYgS7xnf4LHL1GLMnhWJYbMGPdoOSPe0+6j28Xnx/R2O7R7ilpm1ZFou92J9k1Stk
         8E51jZU+Bm+EaW4MBfSpDsy323o9NaX6vi2/VRntTBmGJIzPAK0rytGDuKprzf71CimU
         fvBGzhp4lkx/48pDg0tsW40PI/pzoT7dqv0AYaxP8f4M7C0+Cbp5pua0CtMHgILXwocG
         LbFoBnHD6NgqocqvLFBbHS8j10Geh+My6w4Q8sphg+H1w7xsBSP0FjVhKZypKdvO06Jg
         pn+g==
X-Gm-Message-State: AOJu0YysUwA3ycdemC0J3ho7whyqPnNp+qm7jVxxpXMYhsW0RXMzslMz
	dGc+ozbgxbaoUeitmnuGlWGMwm/NfNPBCw==
X-Google-Smtp-Source: AGHT+IEdl8ihn5xn8GU5RxHcX+v/MaTOdPb+W1Xjkk52OlBFeVC9tFni8l8DmzSM5pOtOXAK8I0jYQ==
X-Received: by 2002:a5d:618d:0:b0:337:4a1d:8944 with SMTP id j13-20020a5d618d000000b003374a1d8944mr5067503wru.70.1705511509960;
        Wed, 17 Jan 2024 09:11:49 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00337bea8856dsm2095675wrv.8.2024.01.17.09.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:11:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [RFC,net-next] tcp: add support for read with offset when using
 MSG_PEEK
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <9522107c-90bd-e803-4397-16a357613a22@redhat.com>
Date: Wed, 17 Jan 2024 19:11:38 +0200
Cc: netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <964350FD-0978-4BFF-93C2-DDBC701FDADA@gmail.com>
References: <F0655F8D-EBEB-403E-BA89-0C8AAAE56E1D@gmail.com>
 <b17a1cda-2a3e-2a79-ff88-7f7fe3c30f37@redhat.com>
 <BDDD81F3-146F-4DCB-9B47-3BF0618607CD@gmail.com>
 <9522107c-90bd-e803-4397-16a357613a22@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Jon,

Two scenarios :

1. in machine with 1 test client , i try to open nginx web interface and =
machine restart :)

2. when machine boot and start all service and start connect ppp users =
machine reboot with this bug.

m.


P.S.

this is bug when try to open web:=20


Jan 17 09:32:49 BUG: unable to handle page fault for address: =
00007ffd7e893a70
Jan 17 09:32:49 #PF: supervisor read access in kernel mode
Jan 17 09:32:49 #PF: error_code(0x0001) - permissions violation
Jan 17 09:32:49 PGD 14347a067 P4D 14347a067 PUD 135bc2067 PMD 104e33067 =
PTE 800000025667d067
Jan 17 09:32:49 Oops: 0001 [#1] SMP
Jan 17 09:32:49 CPU: 2 PID: 1805 Comm: nginx Tainted: G           O      =
 6.7.0 #1
Jan 17 09:32:49 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Jan 17 09:32:49 RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:49 Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 =
f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 =
44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
Jan 17 09:32:49 RSP: 0018:ffffb7a9039d7d00 EFLAGS: 00010202
Jan 17 09:32:49 RAX: 0000000000000042 RBX: ffff94ae43581c80 RCX: =
00000000662a8e9e
Jan 17 09:32:49 RDX: 00007ffd7e893a70 RSI: ffffb7a9039d7e18 RDI: =
ffff94ae43581c80
Jan 17 09:32:49 RBP: ffffb7a9039d7d78 R08: ffffb7a9039d7d90 R09: =
ffffb7a9039d7d8c
Jan 17 09:32:49 R10: 0000000000000002 R11: ffffb7a9039d7e18 R12: =
ffff94ae43581c80
Jan 17 09:32:49 R13: 0000000000000000 R14: 0000000000000000 R15: =
ffffb7a9039d7d44
Jan 17 09:32:49 FS:  00007f957a7b4740(0000) GS:ffff94af77c80000(0000) =
knlGS:0000000000000000
Jan 17 09:32:49 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 09:32:49 CR2: 00007ffd7e893a70 CR3: 000000014346f000 CR4: =
00000000003506f0
Jan 17 09:32:49 Call Trace:
Jan 17 09:32:49  <TASK>
Jan 17 09:32:49  ? __die+0xe4/0xf0
Jan 17 09:32:49  ? page_fault_oops+0x144/0x3e0
Jan 17 09:32:49  ? unix_stream_read_generic+0x24f/0xb20
Jan 17 09:32:49  ? exc_page_fault+0x5d/0xa0
Jan 17 09:32:49  ? asm_exc_page_fault+0x22/0x30
Jan 17 09:32:49  ? tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:49  ? __schedule+0x36c/0x960
Jan 17 09:32:49  tcp_recvmsg+0x5c/0x1e0
Jan 17 09:32:49  ? schedule_hrtimeout_range_clock+0x28b/0x310
Jan 17 09:32:49  ? vmxnet3_tq_tx_complete.isra.0+0x2b0/0x2b0 [vmxnet3]
Jan 17 09:32:49  inet_recvmsg+0x2a/0x90
Jan 17 09:32:49  __sys_recvfrom+0x15e/0x200
Jan 17 09:32:49  ? ep_busy_loop_end+0x60/0x60
Jan 17 09:32:49  ? ktime_get_ts64+0x44/0xe0
Jan 17 09:32:49  __x64_sys_recvfrom+0x1b/0x20
Jan 17 09:32:49  do_syscall_64+0x2c/0xa0
Jan 17 09:32:49  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Jan 17 09:32:49 RIP: 0033:0x7f957a8f62a9
Jan 17 09:32:49 Code: 0c 00 64 c7 02 02 00 00 00 eb bf 66 0f 1f 44 00 00 =
80 3d a9 e0 0c 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
Jan 17 09:32:49 RSP: 002b:00007ffd7e893a48 EFLAGS: 00000246 ORIG_RAX: =
000000000000002d
Jan 17 09:32:49 RAX: ffffffffffffffda RBX: 00007f9579cb73d0 RCX: =
00007f957a8f62a9
Jan 17 09:32:49 RDX: 0000000000000001 RSI: 00007ffd7e893a70 RDI: =
000000000000000d
Jan 17 09:32:49 RBP: 0000000001b29250 R08: 0000000000000000 R09: =
0000000000000000
Jan 17 09:32:49 R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000000000
Jan 17 09:32:49 R13: 0000000001a871a0 R14: 00007ffd7e893a70 R15: =
0000000000000000
Jan 17 09:32:49  </TASK>
Jan 17 09:32:49 Modules linked in: pppoe pppox ppp_generic slhc =
nf_conntrack_sip nf_conntrack_ftp nf_conntrack_pptp nft_ct nft_nat =
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables netconsole virtio_net net_failover failover virtio_pci =
virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring vmxnet3 =
aesni_intel crypto_simd cryptd
Jan 17 09:32:49 CR2: 00007ffd7e893a70
Jan 17 09:32:49 BUG: unable to handle page fault for address: =
00007ffd7e893a70
Jan 17 09:32:50 ---[ end trace 0000000000000000 ]---
Jan 17 09:32:50 #PF: supervisor read access in kernel mode
Jan 17 09:32:50 RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:50 #PF: error_code(0x0001) - permissions violation
Jan 17 09:32:50 Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 =
f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 =
44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
Jan 17 09:32:50 PGD 10d24b067
Jan 17 09:32:50 RSP: 0018:ffffb7a9039d7d00 EFLAGS: 00010202
Jan 17 09:32:50 P4D 10d24b067
Jan 17 09:32:50 RAX: 0000000000000042 RBX: ffff94ae43581c80 RCX: =
00000000662a8e9e
Jan 17 09:32:50 PUD 10334e067
Jan 17 09:32:50 RDX: 00007ffd7e893a70 RSI: ffffb7a9039d7e18 RDI: =
ffff94ae43581c80
Jan 17 09:32:50 PMD 11299d067 PTE 8000000148d73067
Jan 17 09:32:50 RBP: ffffb7a9039d7d78 R08: ffffb7a9039d7d90 R09: =
ffffb7a9039d7d8c
Jan 17 09:32:50
Jan 17 09:32:50 R10: 0000000000000002 R11: ffffb7a9039d7e18 R12: =
ffff94ae43581c80
Jan 17 09:32:50 Oops: 0001 [#2] SMP
Jan 17 09:32:50 R13: 0000000000000000 R14: 0000000000000000 R15: =
ffffb7a9039d7d44
Jan 17 09:32:50 CPU: 4 PID: 1807 Comm: nginx Tainted: G      D    O      =
 6.7.0 #1
Jan 17 09:32:50 FS:  00007f957a7b4740(0000) GS:ffff94af77c80000(0000) =
knlGS:0000000000000000
Jan 17 09:32:50 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Jan 17 09:32:50 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 09:32:50 RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:50 CR2: 00007ffd7e893a70 CR3: 000000014346f000 CR4: =
00000000003506f0
Jan 17 09:32:50 Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 =
f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 =
44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
Jan 17 09:32:50 Kernel panic - not syncing: Fatal exception
Jan 17 09:32:50 RSP: 0018:ffffb7a9039e7d00 EFLAGS: 00010202
Jan 17 09:32:50 RAX: 0000000000000042 RBX: ffff94ae137cc780 RCX: =
000000000a5a62eb
Jan 17 09:32:50 RDX: 00007ffd7e893a70 RSI: ffffb7a9039e7e18 RDI: =
ffff94ae137cc780
Jan 17 09:32:50 RBP: ffffb7a9039e7d78 R08: ffffb7a9039e7d90 R09: =
ffffb7a9039e7d8c
Jan 17 09:32:50 R10: 0000000000000002 R11: ffffb7a9039e7e18 R12: =
ffff94ae137cc780
Jan 17 09:32:50 R13: 0000000000000000 R14: 0000000000000000 R15: =
ffffb7a9039e7d44
Jan 17 09:32:50 FS:  00007f957a7b4740(0000) GS:ffff94af77d00000(0000) =
knlGS:0000000000000000
Jan 17 09:32:50 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 09:32:50 CR2: 00007ffd7e893a70 CR3: 0000000103369000 CR4: =
00000000003506f0
Jan 17 09:32:50 Call Trace:
Jan 17 09:32:50  <TASK>
Jan 17 09:32:50  ? __die+0xe4/0xf0
Jan 17 09:32:50  ? page_fault_oops+0x144/0x3e0
Jan 17 09:32:50  ? unix_stream_read_generic+0x24f/0xb20
Jan 17 09:32:50  ? exc_page_fault+0x5d/0xa0
Jan 17 09:32:50  ? asm_exc_page_fault+0x22/0x30
Jan 17 09:32:50  ? tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:50  ? __schedule+0x36c/0x960
Jan 17 09:32:50  tcp_recvmsg+0x5c/0x1e0
Jan 17 09:32:50  ? schedule_hrtimeout_range_clock+0x28b/0x310
Jan 17 09:32:50  ? vmxnet3_tq_tx_complete.isra.0+0x2b0/0x2b0 [vmxnet3]
Jan 17 09:32:50  inet_recvmsg+0x2a/0x90
Jan 17 09:32:50  __sys_recvfrom+0x15e/0x200
Jan 17 09:32:50  ? ep_busy_loop_end+0x60/0x60
Jan 17 09:32:50  ? ktime_get_ts64+0x44/0xe0
Jan 17 09:32:50  __x64_sys_recvfrom+0x1b/0x20
Jan 17 09:32:50  do_syscall_64+0x2c/0xa0
Jan 17 09:32:50  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Jan 17 09:32:50 RIP: 0033:0x7f957a8f62a9
Jan 17 09:32:50 Code: 0c 00 64 c7 02 02 00 00 00 eb bf 66 0f 1f 44 00 00 =
80 3d a9 e0 0c 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
Jan 17 09:32:50 RSP: 002b:00007ffd7e893a48 EFLAGS: 00000246 ORIG_RAX: =
000000000000002d
Jan 17 09:32:50 RAX: ffffffffffffffda RBX: 00007f9579cb73d0 RCX: =
00007f957a8f62a9
Jan 17 09:32:50 RDX: 0000000000000001 RSI: 00007ffd7e893a70 RDI: =
000000000000000a
Jan 17 09:32:50 RBP: 0000000001b29250 R08: 0000000000000000 R09: =
0000000000000000
Jan 17 09:32:50 R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000000000
Jan 17 09:32:50 R13: 0000000001a871a0 R14: 00007ffd7e893a70 R15: =
0000000000000000
Jan 17 09:32:50  </TASK>
Jan 17 09:32:50 Modules linked in: pppoe pppox ppp_generic slhc =
nf_conntrack_sip nf_conntrack_ftp nf_conntrack_pptp nft_ct nft_nat =
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
nf_tables netconsole virtio_net net_failover failover virtio_pci =
virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring vmxnet3 =
aesni_intel crypto_simd cryptd
Jan 17 09:32:50 CR2: 00007ffd7e893a70
Jan 17 09:32:50 ---[ end trace 0000000000000000 ]---
Jan 17 09:32:50 RIP: 0010:tcp_recvmsg_locked+0x498/0xea0
Jan 17 09:32:50 Code: a3 07 00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 =
f1 04 00 00 41 8b 8c 24 d8 05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 =
44 <48> 83 3a 00 0f 85 e5 fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
Jan 17 09:32:50 RSP: 0018:ffffb7a9039d7d00 EFLAGS: 00010202
Jan 17 09:32:50 RAX: 0000000000000042 RBX: ffff94ae43581c80 RCX: =
00000000662a8e9e
Jan 17 09:32:50 RDX: 00007ffd7e893a70 RSI: ffffb7a9039d7e18 RDI: =
ffff94ae43581c80
Jan 17 09:32:50 RBP: ffffb7a9039d7d78 R08: ffffb7a9039d7d90 R09: =
ffffb7a9039d7d8c
Jan 17 09:32:50 R10: 0000000000000002 R11: ffffb7a9039d7e18 R12: =
ffff94ae43581c80
Jan 17 09:32:50 R13: 0000000000000000 R14: 0000000000000000 R15: =
ffffb7a9039d7d44
Jan 17 09:32:50 FS:  00007f957a7b4740(0000) GS:ffff94af77d00000(0000) =
knlGS:0000000000000000
Jan 17 09:32:50 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 17 09:32:50 CR2: 00007ffd7e893a70 CR3: 0000000103369000 CR4: =
00000000003506f0
Jan 17 09:32:50 Shutting down cpus with NMI
Jan 17 09:32:50 Kernel Offset: 0x25000000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
Jan 17 09:32:50 Rebooting in 10 seconds..

> On 17 Jan 2024, at 18:33, Jon Maloy <jmaloy@redhat.com> wrote:
>=20
>=20
>=20
> On 2024-01-15 23:59, Martin Zaharinov wrote:
>> Hi Jon,
>>=20
>> yes same here in our test lab where have one test user all is fine .
>>=20
>> But when install kernel on production server with 500 users (ppp) and =
400-500mbit/s traffic machine crash with this bug log.
>> Its run as isp router firewall + shapers =E2=80=A6
> Just to get it straight, does it crash when you are running your test =
program on top of that heavily loaded machine, or does it just happen =
randomly when the patch is present?
>=20
> ////jon
>=20
>=20
>=20
>=20
>>=20
>> m.
>>=20
>>> On 16 Jan 2024, at 0:41, Jon Maloy <jmaloy@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2024-01-15 16:51, Martin Zaharinov wrote:
>>>> Hi Jon
>>>>=20
>>>> After apply the patch on kernel 6.7.0 system hang with this bug =
report :
>>> Hmm,
>>> I have been running this for weeks without any problems, on x86_64 =
with current net and net-next.
>>> There must be some difference between our kernels.
>>> Which configuration are you using?
>>> It would also be interesting to see your test program.
>>>=20
>>> Regards
>>> ///jon
>>>=20
>>>=20
>>>> Jan 15 22:27:39 6.7.0,1,863,194879739,-,caller=3DT3523;BUG: unable =
to handle page fault for address: 00007fff333174e0
>>>> Jan 15 22:27:39 6.7.0,1,864,194879876,-,caller=3DT3523;#PF: =
supervisor read access in kernel mode
>>>> Jan 15 22:27:39 6.7.0,1,865,194879976,-,caller=3DT3523;#PF: =
error_code(0x0001) - permissions violation
>>>> Jan 15 22:27:39 6.7.0,6,866,194880075,-,caller=3DT3523;PGD =
107cbd067 P4D 107cbd067 PUD 22055d067 PMD 10a384067 PTE 8000000228b00067
>>>> Jan 15 22:27:39 6.7.0,4,867,194880202,-,caller=3DT3523;Oops: 0001 =
[#1] SMP
>>>> Jan 15 22:27:39 6.7.0,4,868,194880297,-,caller=3DT3523;CPU: 12 PID: =
3523 Comm: server-nft Tainted: G           O       6.7.0 #1
>>>> Jan 15 22:27:39 6.7.0,4,869,194880420,-,caller=3DT3523;Hardware =
name: To Be Filled By O.E.M. To Be Filled By O.E.M./EP2C612D8, BIOS =
P2.30 04/30/2018
>>>> Jan 15 22:27:39 6.7.0,4,870,194880547,-,caller=3DT3523;RIP: =
0010:tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,871,194880709,-,caller=3DT3523;Code: a3 07 =
00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 =
05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 =
fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
>>>> Jan 15 22:27:39 6.7.0,4,872,194880876,-,caller=3DT3523;RSP: =
0018:ffffa47b01307d00 EFLAGS: 00010202
>>>> Jan 15 22:27:39 6.7.0,4,873,194880975,-,caller=3DT3523;RAX: =
0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
>>>> Jan 15 22:27:39 6.7.0,4,874,194881096,-,caller=3DT3523;RDX: =
00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,875,194881217,-,caller=3DT3523;RBP: =
ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
>>>> Jan 15 22:27:39 6.7.0,4,876,194881338,-,caller=3DT3523;R10: =
0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,877,194881458,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
>>>> Jan 15 22:27:39 6.7.0,4,878,194881579,-,caller=3DT3523;FS:  =
00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,879,194881703,-,caller=3DT3523;CS:  0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> Jan 15 22:27:39 6.7.0,4,880,194881802,-,caller=3DT3523;CR2: =
00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
>>>> Jan 15 22:27:39 6.7.0,4,881,194881922,-,caller=3DT3523;DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,882,194882043,-,caller=3DT3523;DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Jan 15 22:27:39 6.7.0,4,883,194882164,-,caller=3DT3523;Call Trace:
>>>> Jan 15 22:27:39 6.7.0,4,884,194882257,-,caller=3DT3523; <TASK>
>>>> Jan 15 22:27:39 6.7.0,4,885,194882347,-,caller=3DT3523; ? =
__die+0xe4/0xf0
>>>> Jan 15 22:27:39 6.7.0,4,886,194882442,-,caller=3DT3523; ? =
page_fault_oops+0x144/0x3e0
>>>> Jan 15 22:27:39 6.7.0,4,887,194882539,-,caller=3DT3523; ? =
zap_pte_range+0x6a4/0xdc0
>>>> Jan 15 22:27:39 6.7.0,4,888,194882638,-,caller=3DT3523; ? =
exc_page_fault+0x5d/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,889,194882736,-,caller=3DT3523; ? =
asm_exc_page_fault+0x22/0x30
>>>> Jan 15 22:27:39 6.7.0,4,890,194882834,-,caller=3DT3523; ? =
tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,891,194882931,-,caller=3DT3523; ? =
__call_rcu_common.constprop.0+0xbc/0x770
>>>> Jan 15 22:27:39 6.7.0,4,892,194883031,-,caller=3DT3523; ? =
rcu_nocb_flush_bypass.part.0+0xec/0x120
>>>> Jan 15 22:27:39 6.7.0,4,893,194883133,-,caller=3DT3523; =
tcp_recvmsg+0x5c/0x1e0
>>>> Jan 15 22:27:39 6.7.0,4,894,194883228,-,caller=3DT3523; =
inet_recvmsg+0x2a/0x90
>>>> Jan 15 22:27:39 6.7.0,4,895,194883325,-,caller=3DT3523; =
__sys_recvfrom+0x15e/0x200
>>>> Jan 15 22:27:39 6.7.0,4,896,194883423,-,caller=3DT3523; ? =
wait_task_zombie+0xee/0x410
>>>> Jan 15 22:27:39 6.7.0,4,897,194883539,-,caller=3DT3523; ? =
remove_wait_queue+0x1b/0x60
>>>> Jan 15 22:27:39 6.7.0,4,898,194883635,-,caller=3DT3523; ? =
do_wait+0x93/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,899,194883729,-,caller=3DT3523; ? =
__x64_sys_poll+0xa7/0x170
>>>> Jan 15 22:27:39 6.7.0,4,900,194883825,-,caller=3DT3523; =
__x64_sys_recvfrom+0x1b/0x20
>>>> Jan 15 22:27:39 6.7.0,4,901,194883921,-,caller=3DT3523; =
do_syscall_64+0x2c/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,902,194884018,-,caller=3DT3523; =
entry_SYSCALL_64_after_hwframe+0x46/0x4e
>>>> Jan 15 22:27:39 6.7.0,4,903,194884116,-,caller=3DT3523;RIP: =
0033:0x7f4941fe92a9
>>>> Jan 15 22:27:39 6.7.0,4,904,194884210,-,caller=3DT3523;Code: 0c 00 =
64 c7 02 02 00 00 00 eb bf 66 0f 1f 44 00 00 80 3d a9 e0 0c 00 00 41 89 =
ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 =
67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
>>>> Jan 15 22:27:39 6.7.0,4,905,194884377,-,caller=3DT3523;RSP: =
002b:00007fff33317468 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
>>>> Jan 15 22:27:39 6.7.0,4,906,194884499,-,caller=3DT3523;RAX: =
ffffffffffffffda RBX: 00007fff333174e0 RCX: 00007f4941fe92a9
>>>> Jan 15 22:27:39 6.7.0,4,907,194884620,-,caller=3DT3523;RDX: =
0000000000000001 RSI: 00007fff333174e0 RDI: 0000000000000005
>>>> Jan 15 22:27:39 6.7.0,4,908,194884740,-,caller=3DT3523;RBP: =
00007fff33317550 R08: 0000000000000000 R09: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,909,194884860,-,caller=3DT3523;R10: =
0000000000000002 R11: 0000000000000246 R12: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,910,194884980,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: 00007f49418850a0
>>>> Jan 15 22:27:39 6.7.0,4,911,194885101,-,caller=3DT3523; </TASK>
>>>> Jan 15 22:27:39 6.7.0,4,912,194885191,-,caller=3DT3523;Modules =
linked in: nft_limit pppoe pppox ppp_generic slhc nft_ct nft_nat =
nft_chain_nat nf_tables netconsole coretemp bonding igb i2c_algo_bit =
i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos aesni_intel crypto_simd =
cryptd
>>>> Jan 15 22:27:39 6.7.0,4,913,194885507,-,caller=3DT3523;CR2: =
00007fff333174e0
>>>> Jan 15 22:27:39 6.7.0,4,914,194885602,-,caller=3DT3523;---[ end =
trace 0000000000000000 ]---
>>>> Jan 15 22:27:39 6.7.0,4,915,194885698,-,caller=3DT3523;RIP: =
0010:tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,916,194885797,-,caller=3DT3523;Code: a3 07 =
00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 =
05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 =
fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
>>>> Jan 15 22:27:39 6.7.0,4,917,194887079,-,caller=3DT3523;RSP: =
0018:ffffa47b01307d00 EFLAGS: 00010202
>>>> Jan 15 22:27:39 6.7.0,4,918,194887177,-,caller=3DT3523;RAX: =
0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
>>>> Jan 15 22:27:39 6.7.0,4,919,194887298,-,caller=3DT3523;RDX: =
00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,920,194887418,-,caller=3DT3523;RBP: =
ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
>>>> Jan 15 22:27:39 6.7.0,4,921,194887538,-,caller=3DT3523;R10: =
0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,922,194887658,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
>>>> Jan 15 22:27:39 6.7.0,4,923,194887779,-,caller=3DT3523;FS:  =
00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,924,194887901,-,caller=3DT3523;CS:  0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> Jan 15 22:27:39 6.7.0,4,925,194888000,-,caller=3DT3523;CR2: =
00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
>>>> Jan 15 22:27:39 6.7.0,4,926,194888120,-,caller=3DT3523;DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,927,194888240,-,caller=3DT3523;DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Jan 15 22:27:39 6.7.0,0,928,194888360,-,caller=3DT3523;Kernel panic =
- not syncing: Fatal exception
>>>> Jan 15 22:27:40 6.7.0,0,929,195391096,-,caller=3DT3523;Kernel =
Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
>>>> Jan 15 22:27:40 6.7.0,0,930,195391224,-,caller=3DT3523;Rebooting in =
10 seconds..
>>>>=20
>>>>=20
>>>>=20
>>>> m.
>>>>=20
>=20


