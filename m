Return-Path: <netdev+bounces-226195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A9B9DD40
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC1D171157
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CC229B16;
	Thu, 25 Sep 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgGHIvup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFC42A82
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784643; cv=none; b=L/puiZM2E85cYhg2yGIciMbPH+43IxxfSBwf+gVpldHHC6C1LKPXfI//EKtDT2USIvz7qCTQW10c441yTRj8e4WKbuo/PfoTA6a+wuTSpoFiuFd08GasnIypNLYn2hyhYHT+0VsJsEd97EQjb2nnNWoFCCI2TosrVc/0qa4R3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784643; c=relaxed/simple;
	bh=wkJin5friuYJrNx8VdS5ZXRcPzSfIJsnWEQZPjkSx2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSh05QmVCTixtqZJ96ljGec152/0Odar1tD6LsTXEqgLH46TU0ruf+iWwda9TFR2JPmLaoWJB4fl7kq9QPHjb4yADRCJPayK7/YwjpYQ5i0Q9MnMlQgOv0W6Z+YhttJ6mmPTzUUkJVROr2rEZjx8Q6ADEL90rk6aVFxBtUyLKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgGHIvup; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso532429a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758784639; x=1759389439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lSVUKhs5/+Z/0Rr6WKY3+iJkDd0vKMZeqP+3Lmjnngc=;
        b=YgGHIvupYZxSZ97d8xB/CfG08F/31mAhnzKsAiHVPLek1JZQzKB99OorOE0ZQIhsSB
         cmcqpJTGJJCm+5jQ4LGuwNXqGJmbCemXmdTKDx8uDPURR19QXs6QY1Y2EVIIY4miOF/G
         +Brt8SAJh8Di55ohGNYsDYAB9Z+JZxfhOzqekZpiAgxBx/uJccUQD92em3npWYDTNrbV
         IPcLKMtgOc87XW3kjzDLyfXa2Uv6xBvGQFggFUhfriHMZXIbZAI2qR2jGU4BL+7s86hO
         0wQKSOQ+RFOkRZBTqTJmOImrOJOjpIokM4nqtnmhzBMUqtiCvf+o4u5KNmmHraWbzV4a
         oCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784639; x=1759389439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSVUKhs5/+Z/0Rr6WKY3+iJkDd0vKMZeqP+3Lmjnngc=;
        b=iyp8uPw7v1evBqkbZ1UcldYgbr8LJahLfbL5SizH1JhrHOJQBW8kTqEx+TGwZvpllH
         MmmlYXtchzgVPs0Yxks6qvlpiYy6+ZausdcIvjJMCv69NKThG+C2KTraGLftDBmgW3KJ
         Hqz30Q0000GqPc+haY6CVBFaRclrciCI9bMbGO5ohGgAW7vKJPzYSlIPImRF1qzL2xym
         vJaNxrZyKHQrK+PLGo1fdfl5lWKSroPtNv4xDtqSJIXOwBPVoVepbsQUGeuKbQPcA6t/
         6uF/i8/9nBu4kZrNKgb9SOUDnGG0IeNwYsGUH7QnQLu7CpnZhqXJgcMS1kUMFEj43I+t
         31uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7iuusVMgBDNoMLfP05G0aRq7LmiPsBBFVoWkYaHAAwnTKvjftMfrcOa/pAw0vUIvp6pdz7pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkY+D5F/V1pSr+eUSn2poWG0C4LqOpsK5G84mkEFzMIk+Kq69P
	Cd4EoQUl/firu4I1EDfBq4Qyw7/EO2/pcd2wFz3DNr/gTwFfRbf1EWztF/HiWfoZNzww9QtjxIT
	dG7nm0m8F5J83jlwnYqF7hUzLcfiSWbXrcSJrndbC
X-Gm-Gg: ASbGncub7hhqFOYdJW1Hx5iYH9wKOqete9z8PEw40i6n6N+ZXh+VnUHHFkUHAvaSszx
	1XtPZQ4rBqpMyaVOyi8VLPdAq+tSgE8B/FOHgaeaWpFv61gK0Nci/WcZiXHwnP3krl5kxCkVUSC
	G0+GQW1r16F0AtF8oSiQob73+WMqkDxyBwJLmamX1grsMH/wc/HFQQaO1skjfhvVJAR/bHkwAkj
	9eUXsxLWzDPQyIYC2ZVrtnkHi6/LEFOZMEIAWPY54sVgQ==
X-Google-Smtp-Source: AGHT+IFA9imzTAUtisyY1C+s9nbH6LSoPGfId9YQZDIVeQXECRAynYvQ4assMOUbG31nmZcEkcb7VvLbjX5oJqXfFC8=
X-Received: by 2002:a17:902:cec3:b0:261:1521:17a8 with SMTP id
 d9443c01a7336-27ed4a16b69mr31503615ad.16.1758784639044; Thu, 25 Sep 2025
 00:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com> <68d4eb92.050a0220.25d7ab.0003.GAE@google.com>
In-Reply-To: <68d4eb92.050a0220.25d7ab.0003.GAE@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 25 Sep 2025 09:16:42 +0200
X-Gm-Features: AS18NWATumRaSLUFu677suqFcBV3K3UsryeU-HULamMGZj_eosgCQ-JFsU4-Q98
Message-ID: <CANpmjNM7cCDoLUGV4J+MfAbQFedmEXhNrhf7fYiFs7Gi7Yz0mg@mail.gmail.com>
Subject: Re: [syzbot ci] Re: fixes two virtio-net related bugs.
To: syzbot ci <syzbot+ci4290219e4732157d@syzkaller.appspotmail.com>
Cc: alvaro.karsz@solid-run.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, hengqi@linux.alibaba.com, 
	jasowang@redhat.com, jiri@resnulli.us, kuba@kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev, 
	willemb@google.com, xuanzhuo@linux.alibaba.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz upstream

On Thu, 25 Sept 2025 at 09:13, syzbot ci
<syzbot+ci4290219e4732157d@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v1] fixes two virtio-net related bugs.
> https://lore.kernel.org/all/20250925022537.91774-1-xuanzhuo@linux.alibaba.com
> * [PATCH net 1/2] virtio-net: fix incorrect flags recording in big mode
> * [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>
> and found the following issue:
> WARNING in virtio_net_hdr_from_skb
>
> Full report is available here:
> https://ci.syzbot.org/series/41a78b3d-b982-4507-b02f-1991c8d827c9
>
> ***
>
> WARNING in virtio_net_hdr_from_skb
>
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      f8b4687151021db61841af983f1cb7be6915d4ef
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/bb3f28da-9370-44d7-be20-9c443d5ebfc9/config
> C repro:   https://ci.syzbot.org/findings/7af48589-24a5-4e09-bfe0-1969f5d98f4d/c_repro
> syz repro: https://ci.syzbot.org/findings/7af48589-24a5-4e09-bfe0-1969f5d98f4d/syz_repro
>
> syz.0.17 uses obsolete (PF_INET,SOCK_PACKET)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6010 at ./include/linux/skbuff.h:3024 skb_transport_header include/linux/skbuff.h:3024 [inline]
> WARNING: CPU: 0 PID: 6010 at ./include/linux/skbuff.h:3024 skb_transport_offset include/linux/skbuff.h:3175 [inline]
> WARNING: CPU: 0 PID: 6010 at ./include/linux/skbuff.h:3024 virtio_net_hdr_from_skb+0x669/0xa30 include/linux/virtio_net.h:222
> Modules linked in:
> CPU: 0 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:skb_transport_header include/linux/skbuff.h:3024 [inline]
> RIP: 0010:skb_transport_offset include/linux/skbuff.h:3175 [inline]
> RIP: 0010:virtio_net_hdr_from_skb+0x669/0xa30 include/linux/virtio_net.h:222
> Code: 00 00 00 fc ff df 0f b6 04 10 84 c0 0f 85 b0 03 00 00 41 c6 45 00 05 48 8b 74 24 08 83 c6 08 e9 ca fd ff ff e8 c8 1c 72 f7 90 <0f> 0b 90 e9 a7 fa ff ff e8 ba 1c 72 f7 90 0f 0b 90 e9 62 fc ff ff
> RSP: 0018:ffffc90002def490 EFLAGS: 00010293
> RAX: ffffffff8a4da238 RBX: 1ffff11004dafca6 RCX: ffff888023c9b980
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> RBP: 1ffff1100537cbd8 R08: ffff88804138e059 R09: 0000000000000000
> R10: ffff88804138e050 R11: ffffed1008271c0c R12: ffff888029be4000
> R13: ffff888026d7e536 R14: ffff888029be5ec4 R15: 000000000000ffff
> FS:  0000555557e59500(0000) GS:ffff8880b8615000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000003000 CR3: 00000000414a0000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  tpacket_rcv+0x15c8/0x3290 net/packet/af_packet.c:2416
>  __netif_receive_skb_one_core net/core/dev.c:5991 [inline]
>  __netif_receive_skb+0x164/0x380 net/core/dev.c:6104
>  netif_receive_skb_internal net/core/dev.c:6190 [inline]
>  netif_receive_skb+0x1cb/0x790 net/core/dev.c:6249
>  tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
>  tun_get_user+0x2aa2/0x3e20 drivers/net/tun.c:1950
>  tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x5c9/0xb30 fs/read_write.c:686
>  ksys_write+0x145/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe74f78ec29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffd7d9aa28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fe74f9d5fa0 RCX: 00007fe74f78ec29
> RDX: 0000000000000fb5 RSI: 0000200000002780 RDI: 0000000000000004
> RBP: 00007fe74f811e41 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fe74f9d5fa0 R14: 00007fe74f9d5fa0 R15: 0000000000000003
>  </TASK>
>
>
> ***
>
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>   Tested-by: syzbot@syzkaller.appspotmail.com
>
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/68d4eb92.050a0220.25d7ab.0003.GAE%40google.com.

