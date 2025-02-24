Return-Path: <netdev+bounces-168918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0EA41832
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF6F188A2B4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820186346;
	Mon, 24 Feb 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwOH2XVa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BB158558
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388135; cv=none; b=iLVvzQhPq1Q07tjDn8icbND27lc4PwHb8GF/q40ol6LyzEF6jY/wsRLaCHg+dSG2mNXwEV9lOPowyhzl7Uh4ZIL7VoMr0r4vET6SgjIUAzduLcHcWP2uiQns5VlL3Dw6lh/vl62C4HA+G9BPyqighXNK/raA/RxRUOXJSNs5yGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388135; c=relaxed/simple;
	bh=ebdNwdtfXJLB75mGSYkH+k5n1hTAiaOeNj0QO9BJS+8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=twdPwI1UWTDJBiDYz1TDhzZ73uVr3ccasDPUdzyZ4zCAAAYLzRRUwmwcaj1kfjSswiqNsRPOMxDqx53eRzF7q9cAq5XWgBFsNzFxU41hU7/ncPNYN/GEM86Z6l61biv9BRU+aknEz0Af/BBggcw4Rsbi5wpJc1gas9hUDfQIeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwOH2XVa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2235275f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740388132; x=1740992932; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWfjp8j/b4Jqm6YF5dmMZc5uiqXe2eQtNz8toYpbQOc=;
        b=PwOH2XVa9Cyb+QPVT/1M3RohXtZG6g1GYglzjI8FXD2jlY4U+56ms9wRdBPZ8ymKJr
         suWeZ2wkOEHrWVXmeaMhi+TgUyqDSXp0jjLGs3THvSXtKyhDonruRUd0XYGIlxlK9EiC
         5qQxzzNrKAkDmfHddHS8EDbx8fSyrfU2h20xEcpVwmKZpAfN5utSBnF+CUTDhWnMAyux
         hGf0SMcCeaD+JdHc0w+Y5UnUAKMvSX1PJr+xhV/7dQ1zddma7U0927D4HLOzPY9Apr8b
         Ef/7MPKymAMz56J6UuaKWdELKI7XP4kRzmjsS0zbkwAP3HQAI5mSxB2TVGaNlwLutDlN
         rr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388132; x=1740992932;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWfjp8j/b4Jqm6YF5dmMZc5uiqXe2eQtNz8toYpbQOc=;
        b=l2TysaKN78xoHHQaXXs0cyByfeoMPe+Zi46BohCEAWdTDpfhvkJ/6VGLn1/Qm0a3uX
         14wabhAUP4Xcu/5THf+bRIr+m69r/c6paaooNu3cHIcsCxHwsqL5cLoX9tE/26QdSctE
         qhXXzroTxlp2W5knUjhizU1DQKYiIqaQEp2Zt+ri9HjM0LgXKNZAl1KbqE/zec/owjvg
         YwxOD2MwwLLFfLzE6vXyrsgjwar/UGvcar/6QscqTQ3j2lHUcrk0TzcNQ+NFeXVoxx4l
         1c0UkbKM1yk01O9c4yLPfHwX3E9G5+OFCmnKMmu9ECZD0lBayufC20PGAFWTvOE+5rHh
         QpUw==
X-Gm-Message-State: AOJu0YzoeF+yF/0LC80gSHI3wVmrcjebtNPAf39rbwV0MARUofDxAt+Z
	PfHDVLsemUlvFSsGp+jLaHGnO6xpiulEXsY8zVSqMaiFsPKzXAuc
X-Gm-Gg: ASbGncvKb40lzNvwf/wFUjRLjbq+gXdJ6w7Ilv69jp04czo4OU1s6fvJv9mlclxxECY
	BkpFrKgFbD77FUyG1e/iCd20DEVOIqfz1bwdw6ExG21tQEY1tZjw+tvxax3z+T3nZ6zG6Lm8zw+
	1+jC1QTmXfv/avWiQqS/EMg7YFa2UGFk5wBPjaa5m0GfIqxtX8PzmlfWuBawvVmh/9kuKit/3ZX
	Ho0ZkZfj0OmcwzbjGhxrgTMyuOyGcrPRNByA8veB4ruUUr/yUPHiVQRlydmwwCDyLIIubS7S5ax
	ZdM22eyknopA45VRp2BDxqCUt4MW22qwoXYZygTACA==
X-Google-Smtp-Source: AGHT+IHaf7KXTlLE9eJoMVptdUuTkeNL/5fWDwIiOyZjkAYDZ/OO5gbzwdT2iX9MMeL7DKeYygj9Xg==
X-Received: by 2002:a5d:47ca:0:b0:38d:e078:43a0 with SMTP id ffacd0b85a97d-38f6f0b1c8cmr14023800f8f.38.1740388131673;
        Mon, 24 Feb 2025 01:08:51 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm31469209f8f.52.2025.02.24.01.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2025 01:08:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Bug Report in Virtio_net driver and skb_try_coalesce
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <CANn89iJU9D5b6yYotQ1zVuxDv-pVwqeiT7YsB6Axh69YotKQnA@mail.gmail.com>
Date: Mon, 24 Feb 2025 11:08:40 +0200
Cc: netdev@vger.kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com,
 willemb@google.com,
 lulie@linux.alibaba.com,
 aleksander.lobakin@intel.com,
 dust.li@linux.alibaba.com,
 hustcat@gmail.com,
 jasowang@redhat.com,
 jdamato@fastly.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <87C19B32-53F2-435C-8B9F-15F80639226D@gmail.com>
References: <4115C55D-7699-41BF-8412-89C80A6C1A7B@gmail.com>
 <CANn89iJU9D5b6yYotQ1zVuxDv-pVwqeiT7YsB6Axh69YotKQnA@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hey Eric,

Yes i find a issue : =
https://patchwork.kernel.org/project/netdevbpf/patch/20240419222328.323107=
5-1-dwilder@us.ibm.com/#25819022=20

this patch i apply before many months , and this patch make issueee=E2=80=A6=
..


Sorry for disturbed you !!!


Best regards,
Martin



P.S.

Thanks for fast response.=20

And sorry again!

> On 24 Feb 2025, at 9:21, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Mon, Feb 24, 2025 at 6:13=E2=80=AFAM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>=20
>> Hello all,
>>=20
>> i have this issue fro kernel 6.12 and still is here with kernel =
6.13.4
>>=20
>> when run vm with virtio_net as ethernet card
>> start traffic like try to scp file to this vm and machine crash with =
second debug.
>> First is when system boot .
>>=20
>> any help to fix this .
>>=20
>> Best regards,
>> Martin
>>=20
>> [   19.070538][    C7] ------------[ cut here ]------------
>> [   19.071165][    C7] WARNING: CPU: 7 PID: 0 at =
net/core/skbuff.c:6075 skb_try_coalesce+0x495/0x520
>=20
> This is a bit strange, because in 6.13.4 the WARN_ON_ONCE(delta <
> len); should be at line 6072
>=20
>> [   19.072094][    C7] Modules linked in: nf_conntrack_sip(-) =
nf_conntrack_ftp nf_conntrack_pptp nft_ct nft_nat nft_chain_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables netconsole vmxnet3 =
virtio_net net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring e1000 e1000e tap tun =
aesni_intel gf128mul crypto_simd cryptd
>> [   19.075316][    C7] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: =
G           O       6.13.4 #2
>> [   19.076047][    C7] Tainted: [O]=3DOOT_MODULE
>> [   19.076456][    C7] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [   19.077608][    C7] RIP: 0010:skb_try_coalesce+0x495/0x520
>> [   19.078049][    C7] Code: 00 00 0f 85 ef fd ff ff 49 8b 11 80 e2 =
40 0f 84 e3 fd ff ff 49 8b 51 48 f6 c2 01 0f 84 d6 fd ff ff 4c 8d 4a ff =
e9 cd fd ff ff <0f> 0b e9 fc fd ff ff 0f 0b 31 c0 e9 cd fe ff ff 4c 8d =
4e ff e9 b4
>> [   19.079500][    C7] RSP: 0018:ffff9aaf002a4c90 EFLAGS: 00010297
>> [   19.079969][    C7] RAX: ffff9aaf002a4d03 RBX: ffff917408a6b900 =
RCX: 00000000000000c0
>> [   19.080582][    C7] RDX: 00000000fffffdc0 RSI: ffff9174059e3800 =
RDI: 0000000000000598
>> [   19.081178][    C7] RBP: ffff917408a6b100 R08: 0000000000000001 =
R09: 0000000000000000
>> [   19.081781][    C7] R10: 0000000000000000 R11: 00000000000000c0 =
R12: ffff9aaf002a4d04
>> [   19.082600][    C7] R13: 0000000000000598 R14: ffff9175059e35c0 =
R15: ffff9175059e2dc0
>> [   19.083465][    C7] FS:  0000000000000000(0000) =
GS:ffff917577dc0000(0000) knlGS:0000000000000000
>> [   19.084492][    C7] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> [   19.085203][    C7] CR2: 00007f56364bdd78 CR3: 0000000104866000 =
CR4: 00000000003506f0
>> [   19.086077][    C7] Call Trace:
>> [   19.086436][    C7]  <IRQ>
>> [   19.086751][    C7]  ? show_trace_log_lvl+0x1a2/0x260
>> [   19.087312][    C7]  ? inet_frag_reasm_finish+0xef/0x380
>> [   19.087903][    C7]  ? skb_try_coalesce+0x495/0x520
>> [   19.088442][    C7]  ? __warn.cold+0x90/0x9e
>> [   19.088917][    C7]  ? skb_try_coalesce+0x495/0x520
>> [   19.089460][    C7]  ? report_bug+0xf2/0x1f0
>> [   19.089934][    C7]  ? handle_bug+0x4f/0x90
>> [   19.090397][    C7]  ? exc_invalid_op+0x17/0x160
>> [   19.090907][    C7]  ? asm_exc_invalid_op+0x16/0x20
>> [   19.091447][    C7]  ? skb_try_coalesce+0x495/0x520
>> [   19.091993][    C7]  inet_frag_reasm_finish+0xef/0x380
>> [   19.092560][    C7]  ip_frag_queue+0x507/0x670
>> [   19.093059][    C7]  ip_defrag+0x93/0x130
>> [   19.093493][    C7]  ip_local_deliver+0x38/0xc0
>> [   19.094013][    C7]  process_backlog+0xcb/0x1f0
>> [   19.094516][    C7]  __napi_poll+0x20/0x130
>> [   19.094992][    C7]  net_rx_action+0x306/0x3e0
>> [   19.095486][    C7]  ? enqueue_dl_entity+0x42f/0xa80
>> [   19.096047][    C7]  ? enqueue_task_fair+0x21a/0xb00
>> [   19.096595][    C7]  ? __napi_schedule+0x97/0xa0
>> [   19.097101][    C7]  handle_softirqs+0xde/0x1d0
>> [   19.097605][    C7]  irq_exit_rcu+0xac/0xd0
>> [   19.097964][    C7]  common_interrupt+0x79/0xa0
>> [   19.098414][    C7]  </IRQ>
>> [   19.098737][    C7]  <TASK>
>> [   19.099055][    C7]  asm_common_interrupt+0x22/0x40
>> [   19.099599][    C7] RIP: 0010:default_idle+0xb/0x10
>> [   19.100144][    C7] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 =
4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 37 =
f9 33 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 35 98 ff 55 7c f0 80 4e 02 20 =
48 8b 06 a8
>> [   19.102223][    C7] RSP: 0018:ffff9aaf000efef0 EFLAGS: 00000202
>> [   19.102825][    C7] RAX: ffff917577dc0000 RBX: ffff91740083bdc0 =
RCX: 00000000ffffffff
>> [   19.103447][    C7] RDX: 0000000000000000 RSI: 000000046bc5c460 =
RDI: 00000000000234d4
>> [   19.104075][    C7] RBP: 0000000000000007 R08: 0000000000000001 =
R09: 00000000fff8da2a
>> [   19.104703][    C7] R10: 0000000000000001 R11: 0000000000001800 =
R12: 0000000000000000
>> [   19.105326][    C7] R13: 0000000000000000 R14: 0000000000000000 =
R15: 0000000000000000
>> [   19.105953][    C7]  default_idle_call+0x20/0x40
>> [   19.106334][    C7]  do_idle+0x1a4/0x1d0
>> [   19.106658][    C7]  cpu_startup_entry+0x20/0x30
>> [   19.107042][    C7]  start_secondary+0xe1/0xf0
>> [   19.107405][    C7]  common_startup_64+0x13e/0x148
>> [   19.107802][    C7]  </TASK>
>> [   19.108041][    C7] ---[ end trace 0000000000000000 ]=E2=80=94
>>=20
>>=20
>>=20
>> [  101.473110][    C5] BUG: unable to handle page fault for address: =
ffff91742f6ed1ec
>> [  101.473731][    C5] #PF: supervisor write access in kernel mode
>> [  101.474181][    C5] #PF: error_code(0x0003) - permissions =
violation
>> [  101.474661][    C5] PGD 233c01067 P4D 233c01067 PUD 101bbf063 PMD =
13f3cf063 PTE 800000012f6ed121
>> [  101.475326][    C5] Oops: Oops: 0003 [#1] SMP
>> [  101.475662][    C5] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: =
G        W  O       6.13.4 #2
>> [  101.476318][    C5] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
>> [  101.476706][    C5] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [  101.477616][    C5] RIP: 0010:memcpy_orig+0x68/0x110
>> [  101.477997][    C5] Code: 83 c2 20 eb 44 48 01 d6 48 01 d7 48 83 =
ea 20 0f 1f 00 48 83 ea 20 4c 8b 46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e =
e0 48 8d 76 e0 <4c> 89 47 f8 4c 89 4f f0 4c 89 57 e8 4c 89 5f e0 48 8d =
7f e0 73 d2
>> [  101.479467][    C5] RSP: 0018:ffff9aaf0022cc58 EFLAGS: 00010206
>> [  101.479918][    C5] RAX: ffff91742f6ec840 RBX: ffff91740ac63100 =
RCX: 0000000000000000
>> [  101.480519][    C5] RDX: 0000000000000974 RSI: ffff917400396630 =
RDI: ffff91742f6ed1f4
>> [  101.481110][    C5] RBP: 00000000000009b4 R08: bd71b2c82ec828b5 =
R09: 516abfaa22e30e4c
>> [  101.481705][    C5] R10: 70129ddb96fbe60f R11: 877be8f28680b588 =
R12: ffff917400395c90
>> [  101.482294][    C5] R13: 000000000000000c R14: 0000000000005c9c =
R15: fffff4a18400e400
>> [  101.482889][    C5] FS:  0000000000000000(0000) =
GS:ffff917577d40000(0000) knlGS:0000000000000000
>> [  101.483554][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> [  101.484041][    C5] CR2: ffff91742f6ed1ec CR3: 0000000109555000 =
CR4: 00000000003506f0
>> [  101.484635][    C5] Call Trace:
>> [  101.484878][    C5]  <IRQ>
>> [  101.485088][    C5]  ? show_trace_log_lvl+0x1a2/0x260
>> [  101.485478][    C5]  ? page_to_skb+0x378/0x5e0 [virtio_net]
>> [  101.485903][    C5]  ? __die+0x4d/0x8a
>> [  101.486190][    C5]  ? page_fault_oops+0x83/0x190
>> [  101.486553][    C5]  ? =
kernelmode_fixup_or_oops.constprop.0+0x33/0x1d0
>> [  101.487049][    C5]  ? exc_page_fault+0x91/0xa0
>> [  101.487395][    C5]  ? asm_exc_page_fault+0x22/0x30
>> [  101.487771][    C5]  ? memcpy_orig+0x68/0x110
>> [  101.488103][    C5]  page_to_skb+0x378/0x5e0 [virtio_net]
>> [  101.488518][    C5]  receive_buf+0x2ba/0xb70 [virtio_net]
>> [  101.488930][    C5]  ? kmem_cache_free+0x287/0x2d0
>> [  101.489295][    C5]  virtnet_poll+0x4f6/0x6c0 [virtio_net]
>> [  101.489717][    C5]  __napi_poll+0x20/0x130
>> [  101.490037][    C5]  net_rx_action+0x1c7/0x3e0
>> [  101.490376][    C5]  ? __napi_schedule+0x97/0xa0
>> [  101.490732][    C5]  handle_softirqs+0xde/0x1d0
>> [  101.491078][    C5]  irq_exit_rcu+0xac/0xd0
>> [  101.491398][    C5]  common_interrupt+0x79/0xa0
>> [  101.491755][    C5]  </IRQ>
>> [  101.491972][    C5]  <TASK>
>> [  101.492188][    C5]  asm_common_interrupt+0x22/0x40
>> [  101.492564][    C5] RIP: 0010:default_idle+0xb/0x10
>> [  101.492939][    C5] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 =
4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 37 =
f9 33 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 35 98 ff 55 7c f0 80 4e 02 20 =
48 8b 06 a8
>> [  101.494404][    C5] RSP: 0018:ffff9aaf000dfef0 EFLAGS: 00000212
>> [  101.494860][    C5] RAX: ffff917577d40000 RBX: ffff917400839b40 =
RCX: 00000000ffffffff
>> [  101.495455][    C5] RDX: 0000000000000000 RSI: 000000179b776480 =
RDI: 00000000000510ec
>> [  101.496048][    C5] RBP: 0000000000000005 R08: 0000000000000001 =
R09: 00000000fffaf2b0
>> [  101.496643][    C5] R10: 0000000000000001 R11: 0000000000016c00 =
R12: 0000000000000000
>> [  101.497234][    C5] R13: 0000000000000000 R14: 0000000000000000 =
R15: 0000000000000000
>> [  101.497829][    C5]  default_idle_call+0x20/0x40
>> [  101.498183][    C5]  do_idle+0x1a4/0x1d0
>> [  101.498488][    C5]  cpu_startup_entry+0x20/0x30
>> [  101.498842][    C5]  start_secondary+0xe1/0xf0
>> [  101.499183][    C5]  common_startup_64+0x13e/0x148
>> [  101.499553][    C5]  </TASK>
>> [  101.499777][    C5] Modules linked in: xsk_diag unix_diag pppoe =
pppox ppp_generic slhc nf_conntrack_sip nf_conntrack_ftp =
nf_conntrack_pptp nft_ct nft_nat nft_chain_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables netconsole vmxnet3 virtio_net =
net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring e1000 e1000e tap tun =
aesni_intel gf128mul crypto_simd cryptd
>> [  101.502860][    C5] CR2: ffff91742f6ed1ec
>> [  101.503168][    C5] ---[ end trace 0000000000000000 ]---
>> [  101.503578][    C5] RIP: 0010:memcpy_orig+0x68/0x110
>> [  101.503959][    C5] Code: 83 c2 20 eb 44 48 01 d6 48 01 d7 48 83 =
ea 20 0f 1f 00 48 83 ea 20 4c 8b 46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e =
e0 48 8d 76 e0 <4c> 89 47 f8 4c 89 4f f0 4c 89 57 e8 4c 89 5f e0 48 8d =
7f e0 73 d2
>> [  101.505439][    C5] RSP: 0018:ffff9aaf0022cc58 EFLAGS: 00010206
>> [  101.505897][    C5] RAX: ffff91742f6ec840 RBX: ffff91740ac63100 =
RCX: 0000000000000000
>> [  101.506492][    C5] RDX: 0000000000000974 RSI: ffff917400396630 =
RDI: ffff91742f6ed1f4
>> [  101.507084][    C5] RBP: 00000000000009b4 R08: bd71b2c82ec828b5 =
R09: 516abfaa22e30e4c
>> [  101.507679][    C5] R10: 70129ddb96fbe60f R11: 877be8f28680b588 =
R12: ffff917400395c90
>> [  101.508269][    C5] R13: 000000000000000c R14: 0000000000005c9c =
R15: fffff4a18400e400
>> [  101.508864][    C5] FS:  0000000000000000(0000) =
GS:ffff917577d40000(0000) knlGS:0000000000000000
>> [  101.509533][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> [  101.510024][    C5] CR2: ffff91742f6ed1ec CR3: 0000000109555000 =
CR4: 00000000003506f0
>> [  101.510631][    C5] Kernel panic - not syncing: Fatal exception in =
interrupt
>> [  101.511284][    C5] Kernel Offset: 0x2000000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
>> [  101.512159][    C5] Rebooting in 10 seconds..



