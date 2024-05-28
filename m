Return-Path: <netdev+bounces-98487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F808D1933
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BC71F218BE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4216C684;
	Tue, 28 May 2024 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaL1b6Qt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824D13C8F2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894946; cv=none; b=eA9x9bA8psNjzB/IaK1GXiqNN2nN5GJqzbjCpMxS3AaZg1IzsY0jgvpd9TczOW9w273p2r9A+JDzCOkMDrEGtAs7w/hEcZ1NrPEQ8A5AdwBSwp5UnnddvU3bTFNQFRkybq0FpNaOuMJEkbkSIhLNP1EhIlpXbjXgmylLQlopjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894946; c=relaxed/simple;
	bh=OtqlR/kfAhrhgzTPvmA3dqLtFY9GUvr9byBefqZDgWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlELMFJB+D81l5nwmrrXES2JRVTZjZtOqNUkmcxJ/tbx7rikjC7aveg+ktD6JO7QDLgSPmpNH9cHWnx94BX6xfXEWQI+dc+TRBWdySzp/oefidXXbBK/C37Vmo3s1asA4nRnF5KN4XGkk73NK49CAHokJNt5yoBTYgJLSrQZW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaL1b6Qt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716894943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S0dOsfxBcECFcTB2UIfBPFtLIYmqmV/NxAVaCynh02A=;
	b=gaL1b6Qt7DhRJo3+xMeblDg9kJzdFagK/FzIgosiXeExd3kMBgf+ydhOyrsbVAly6TCIU1
	Iq5SfiP0Ry2U0Dd/QsMrgf1jvAFuuGfC+1evL0QglXD21509j/NAqLMMrMOqmoB8RPPf3a
	8GvtNfQ02BCCXNlkaG7geAINSUGfmS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-liQPaaBoO1uWxHITJttEdA-1; Tue, 28 May 2024 07:15:41 -0400
X-MC-Unique: liQPaaBoO1uWxHITJttEdA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3550462d388so92145f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716894940; x=1717499740;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0dOsfxBcECFcTB2UIfBPFtLIYmqmV/NxAVaCynh02A=;
        b=Tcd/96vfSpC4in8u+MoNqqyG7dfzk17mxz3l9GU71n/murcmt3lxL84tZY64rqQkVq
         InHP8trnwvz85U3BmzlORZStTdbSvVBPWT1mZ5BL1fWJZoexpbLn+akRmUXXs4xkrElR
         Q/yAxMXnSkTWARjXJHHER1qLFYWWcynckX62ee97Ow0vv0f+6/Iw9g14nOEPdzygA6az
         W7a3CSWV5ZxcnnQbndU6gOZlLg0YyYo/nocvxwnQrlmSVJHqopLc6ACWxzJ2xTuBB6VZ
         lXSmO/ixdGvzfmPKk+JORnc/HWWp/xQhsB9YyqRJWdlV1QObvSeWxTRGHIaVNXQ3YEMq
         pd1w==
X-Gm-Message-State: AOJu0YwjwnmXY5Dh+vnO4VQyF8dd/xr7Hkql3FL9+2NP678UzofAEO/0
	r374fSyQOSHWLLrbmBbwlfpHN6POoNvSg0+yhLGS0uJJfp4ExK5fzXiwg4nfy/xqgGsob7acmXW
	IfzcJIPZskpJXMEQjrVbmTLym690kP6k50ughBNuT4r3Ib5qOuY9Jvw==
X-Received: by 2002:adf:e547:0:b0:34d:707c:9222 with SMTP id ffacd0b85a97d-35526c2b6c7mr8016862f8f.2.1716894939968;
        Tue, 28 May 2024 04:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvzfVUEM7ab/D1Y6B6WqndSUrmYziEFW2cqkayxz/DB2qLJRxcYO5x8Fkqrt1CoSpLuJv/+A==
X-Received: by 2002:adf:e547:0:b0:34d:707c:9222 with SMTP id ffacd0b85a97d-35526c2b6c7mr8016842f8f.2.1716894939449;
        Tue, 28 May 2024 04:15:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a091051sm11431944f8f.61.2024.05.28.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:15:38 -0700 (PDT)
Message-ID: <1a1b249e7d53984a3ea094cdf5b362cea3273dc4.camel@redhat.com>
Subject: Re: [PATCH net] ipvlan: Dont Use skb->sk in
 ipvlan_process_v{4,6}_outbound
From: Paolo Abeni <pabeni@redhat.com>
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, hannes@stressinduktion.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 May 2024 13:15:37 +0200
In-Reply-To: <20240525034231.2498827-1-yuehaibing@huawei.com>
References: <20240525034231.2498827-1-yuehaibing@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-05-25 at 11:42 +0800, Yue Haibing wrote:
> Raw packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device wi=
ll
> hit WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path.
>=20
> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm=
_kms_helper
> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:sk_mc_loop+0x2d/0x70
> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 8=
5 ff 74 1c
> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <IRQ>
>  ? __warn (kernel/panic.c:693)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ? report_bug (lib/bug.c:201 lib/bug.c:219)
>  ? handle_bug (arch/x86/kernel/traps.c:239)
>  ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>  ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
>  ? nf_hook_slow (net/netfilter/core.c:626)
>  ip6_finish_output (net/ipv6/ip6_output.c:222)
>  ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
>  ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
>  ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
>  dev_hard_start_xmit (net/core/dev.c:3594)
>  sch_direct_xmit (net/sched/sch_generic.c:343)
>  __qdisc_run (net/sched/sch_generic.c:416)
>  net_tx_action (net/core/dev.c:5286)
>  handle_softirqs (kernel/softirq.c:555)
>  __irq_exit_rcu (kernel/softirq.c:589)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)
>=20
> The warning triggers as this:
> packet_sendmsg
>    packet_snd //skb->sk is packet sk
>       __dev_queue_xmit
>          __dev_xmit_skb //q->enqueue is not NULL
>              __qdisc_run
>                sch_direct_xmit
>                  dev_hard_start_xmit
>                    ipvlan_start_xmit
>                       ipvlan_xmit_mode_l3 //l3 mode
>                         ipvlan_process_outbound //vepa flag
>                           ipvlan_process_v6_outbound
>                             ip6_local_out
>                                 __ip6_finish_output
>                                   ip6_finish_output2 //multicast packet
>                                     sk_mc_loop //sk->sk_family is AF_PACK=
ET
>=20
> Call ip{6}_local_out() with NULL sk in ipvlan as other tunnels to fix thi=
s.
>=20
> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive deref=
erence inside the stack")

The patch LGTM, but the above fixes tag looks incorrect, I think the
reproducer should splat even before such commit as the relevant warning
will be still there and should be still reachable.

Cheers,

Paolo


