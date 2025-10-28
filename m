Return-Path: <netdev+bounces-233507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D04C14881
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DA4E637C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75F30595F;
	Tue, 28 Oct 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="glPIhDjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DB303A23
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653333; cv=none; b=qXWjqYkzPJH50GJI/M4u88yLfK/I/UzLYCeYV6BA4p42Pxmk3p3gdgCipLmePeBq7R5ZzA84iGimcERaaKK0Tyo/BqTHy8yVpP5N1H76FnVx4zAMERGvutAgDT5GKTAK8Yjl8cNqcBaLOmsu5lNTcfSqMwe3GLL6NzB5K+8ecJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653333; c=relaxed/simple;
	bh=1yXRGBWk5rrCw+MhtqbD+EquskK4jILqeUJdeiT8ofI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS5yIA8yaTKE/7G8pIESS6Wa9Tu3XCvjduSpJD4OqLmV9ti4xLh3GWZjjEYarVbe/4rrA0RiCwAvK4sg9viWWVyVC/iA/VNC/QUqgLLWKyziFMTiml4JxZ1d7XBbbij0G1SxWJbxUbjADqtjr/Xs3BqRKaS5JcZfxZidTfFKJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=glPIhDjx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso4392228b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1761653331; x=1762258131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG3yvw5e8BkhcWmgpE+RvWz0KKkfCoVKTL2Nd88xFLM=;
        b=glPIhDjxpzp4t4lxw29VOy18PWXmMpn971AAi+EerZNGsAV1St/x+rkfo+AWZ51TJk
         zt0J8mXwelPjOOjQ60DWkhtQSH59BK7dz2CQnQ6niCa1ozljaYaOPtHLvW55Msfh81IF
         hDRlFrulXGDNcrPqlcOD9aIkOvDz4HJzLiuQnMCXFViQKU1FQlRxCpMTiQ9UyKs5rpyx
         AOmpjsE2ee1ySt0Z7U+Wqi9pjsYrpPXwmjZUnQ6MXK81jhyD4J/Rcq7ZPtr7TdHiOhKu
         M/CgjL6NG1EsuBY5ovnzdrTkZ8tRdyyhI49SR7DodKUZNRmVY4s0QjN7HE+Mu76WVH4f
         WVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653331; x=1762258131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG3yvw5e8BkhcWmgpE+RvWz0KKkfCoVKTL2Nd88xFLM=;
        b=PPId7rQCVKDm56npILR8CtuTY3H/d6DF45mh6aBUE6MmTl/vMHAaCT7vlqZTQjTRaC
         NZllmjY7WF47NzWhMRp+kBQo2Rf200UmxWRMt6WQK/HARmYa4ii8MBKYCE+CmJ6e3C6B
         EBTt9K1iYrJ7IyYfqnWVqyyWS/KoB3nz0XviSvMbJlAQx0jXqsUvNwQW69h1mKBUXnV4
         bqOXMPfyJW7my+7otgCK4uCm+lZSpsLpCbtbYcFduKdfuw7zHMrcZ6KwivRwL1dQvX8p
         hYs5qvEnFfFgx9Yq0I9o71YQMg8pWcBSdCPB37G1PNLSUvvpjn90jJ9OGvLkSRqlkZ2+
         roOA==
X-Forwarded-Encrypted: i=1; AJvYcCVrn/81mDtEg7f7VccGtQQGz+GRuzcLSJixggD3WHzlnXVTw5LLPqawxHzZtR5hWfVZujTXiMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ub0qGZ5XMoVsVl3hrE3E+YRwKSjjpBy9dwUV8/bI3N+fk3Ps
	i2RU7hPWvq7YvfPTsA6PXASaMm8sfRUHZUXlo8dqEZkdCxrQHons088RWQytzxaxVnRiFjimSm8
	+aOmuSmmcMEr0MLPZVB+Mpno3ZqsjY/RQauB6dsLV
X-Gm-Gg: ASbGncvvqpgQ9XeFWmaZqLi46DsW6JrWdK43jOoqWCraDPMiB2DXiQcIIjF4gCwYN57
	S1kBvItN2mHCF6qqOZQKj8C5smSyj8NYlR+wNSefLTHfb8aSC2VMBOheSxt47JWpb7ox9XRqDRm
	ychda3z0rJfdcAy65JF+2hCPuT1hvjoHIjW+tgnTBd3Fp8oHlnq9Iy7k6MTz1ck2PGNC92Bw6T+
	dXFU9ROUZVz6C76zVyhHXXMFLtq2uTrGIwrTgCWCMPZI9vhwuPpl3ewdmT/HFpfpVU2bz3EYxYX
	y+ajFqMP5EKertmD+Hv2SumUxHEyu1xdsVfy
X-Google-Smtp-Source: AGHT+IFZWfMXdRFzs82sJiyvKvhc8Zfc6jYqO9KlU4vLFN9C2+SgiGU34JJ1Mp2PZPpyEyqHtXUX0iSccLqcclp4x4Q=
X-Received: by 2002:a05:6a20:7348:b0:33e:410e:4b4d with SMTP id
 adf61e73a8af0-344d17c36f0mr4137604637.5.1761653331255; Tue, 28 Oct 2025
 05:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028035859.2067690-1-kuniyu@google.com>
In-Reply-To: <20251028035859.2067690-1-kuniyu@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Oct 2025 08:08:40 -0400
X-Gm-Features: AWmQ_bkxmqLAjxxuPF3mxmmxtUNrjKAo6ca4a4XleprdzgHsqEVEEaUf3gPVkU4
Message-ID: <CAM0EoM=3O3Nyy7rb47WxxWz-KN9xxabc5LpQz3ZhhWp7V-9c+w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: sched: Don't use WARN_ON_ONCE() for
 -ENOMEM in tcf_classify().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:59=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> As demonstrated by syzbot, WARN_ON_ONCE() in tcf_classify() can
> be easily triggered by fault injection. [0]
>
> We should not use WARN_ON_ONCE() for the simple -ENOMEM case.
>
> Also, we provide SKB_DROP_REASON_NOMEM for the same error.
>
> Let's remove WARN_ON_ONCE() there.
>
> [0]:
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250
>  should_fail_ex+0x414/0x560
>  should_failslab+0xa8/0x100
>  kmem_cache_alloc_noprof+0x74/0x6e0
>  skb_ext_add+0x148/0x8f0
>  tcf_classify+0xeba/0x1140
>  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
> ...
> WARNING: CPU: 0 PID: 31392 at net/sched/cls_api.c:1869 tcf_classify+0xfd7=
/0x1140
> Modules linked in:
> CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:tcf_classify+0xfd7/0x1140
> Code: e8 03 42 0f b6 04 30 84 c0 0f 85 41 01 00 00 66 41 89 1f eb 05 e8 8=
9 26 75 f8 bb ff ff ff ff e9 04 f9 ff ff e8 7a 26 75 f8 90 <0f> 0b 90 49 83=
 c5 44 4c 89 eb 49 c1 ed 03 43 0f b6 44 35 00 84 c0
> RSP: 0018:ffffc9000b7671f0 EFLAGS: 00010293
> RAX: ffffffff894addf6 RBX: 0000000000000002 RCX: ffff888025029e40
> RDX: 0000000000000000 RSI: ffffffff8bbf05c0 RDI: ffffffff8bbf0580
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 1ffffffff1c0bfd6
> R10: dffffc0000000000 R11: fffffbfff1c0bfd7 R12: ffff88805a90de5c
> R13: ffff88805a90ddc0 R14: dffffc0000000000 R15: ffffc9000b7672c0
> FS:  00007f20739f66c0(0000) GS:ffff88812613e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2d2a80 CR3: 0000000024e36000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  multiq_classify net/sched/sch_multiq.c:39 [inline]
>  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
>  dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
>  __dev_xmit_skb net/core/dev.c:4214 [inline]
>  __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
>  packet_snd net/packet/af_packet.c:3076 [inline]
>  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2630
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
>  __sys_sendmsg net/socket.c:2716 [inline]
>  __do_sys_sendmsg net/socket.c:2721 [inline]
>  __se_sys_sendmsg net/socket.c:2719 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f207578efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f20739f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f20759e5fa0 RCX: 00007f207578efc9
> RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
> RBP: 00007f20739f6090 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007f20759e6038 R14: 00007f20759e5fa0 R15: 00007f2075b0fa28
>  </TASK>
>
> Reported-by: syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69003e33.050a0220.32483.00e8.GAE@g=
oogle.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> targetting net-next since there's no real bug.
> ---
>  net/sched/cls_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ecec0a1e1c1a..f751cd5eeac8 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1866,7 +1866,7 @@ int tcf_classify(struct sk_buff *skb,
>                         struct tc_skb_cb *cb =3D tc_skb_cb(skb);
>
>                         ext =3D tc_skb_ext_alloc(skb);
> -                       if (WARN_ON_ONCE(!ext)) {
> +                       if (!ext) {
>                                 tcf_set_drop_reason(skb, SKB_DROP_REASON_=
NOMEM);
>                                 return TC_ACT_SHOT;
>                         }
> --
> 2.51.1.838.g19442a804e-goog
>

