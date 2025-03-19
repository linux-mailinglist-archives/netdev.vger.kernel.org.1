Return-Path: <netdev+bounces-176024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C9A68643
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73DE189D6F2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4124EF76;
	Wed, 19 Mar 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+QYn2c7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D86849C
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371080; cv=none; b=bJjczBNCiaxQmBU4eRd0oIbU7iIbFEl4QmtcJrWdLcFuD7dxr2IFx+73M4i/E8XuQi4Pb1eGZWZ8CZ2MCgBTLkwCqA/JwRk3DFWhUSVTwJYLpdTBlT+3FuQkajc6b2ZCNr50/klgQlIelKZiu0mL+W2N/pWOPFj88Fuz/EhMgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371080; c=relaxed/simple;
	bh=V2zvzpyNAfPLCieeInwUQnsecRgIvLzFhVHZwxI+Fv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxrhL4X9bN9Bl55vLRs+QLTDr7Ni0pxRdcRhO1uUfZ3dMFBWRa2vuJSFhZGSvQNcUy2o/TS00TEJHsqNYq7zUzg/8NebEnRHeBJYx5ZeI4H5nPeC7HY8ogpDZx6T3WkH2KYgfY8TH859Vrn/o/w6Ek8wLjuyaiyFWiQ0cr6Hm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+QYn2c7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742371077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6AKbwaXbkW4Y2kgnzRrYm/8ElbSgDp3vijnzui4Q1w=;
	b=T+QYn2c7vp277AnY+JsKVbVMyndxQgkFI6guJDBnZRJVH0oa7mzR9wzl41rkrImShWEGxC
	J34O7pXIYUBDCPrQpzY4UhiRDYO4/W8tEclxD1D7TVukDvj4MuK0o3Cjmm8pErOGOQ+Xmw
	M/qNBbfP787RJsuSD2/7o/8Kfq2p0Yo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PTPAcvCqM3uCcX-QQf1lSg-1; Wed, 19 Mar 2025 03:57:55 -0400
X-MC-Unique: PTPAcvCqM3uCcX-QQf1lSg-1
X-Mimecast-MFC-AGG-ID: PTPAcvCqM3uCcX-QQf1lSg_1742371074
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so21456295e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371074; x=1742975874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6AKbwaXbkW4Y2kgnzRrYm/8ElbSgDp3vijnzui4Q1w=;
        b=Ys8REs5bnYNqD/JlHgnKthCotJWFH4mC9lVw4wJuHmAkrZ+XJOUVG4nsaeEKmtL05s
         Pi1QKmNZPludQiegZFEcvXU0blb5psBD1Srx8sLtAiuir9i1VeM0dgpuNOcB+SIO1XwD
         XbCNGUVQgZyc5vEGI0J2MiXibkCgOB9IuqrsYsec9fxagrHbT9hIt6Z8DmEUzjlLXE4w
         qTI8+2k7AaPWT0uQveGlpoe0OGyXOXihuow0pYczKHDdBpjBljuGQ4Kzt/f4ErB2NZ99
         d1QaGeOG+AtwZQZ3Mqt0Re1PXw/3V74W1V64eHfcOr5vmu+jxS2RXF1eDZZDUTk39ZhN
         ra4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLSo51SJeciutJn2aJTvz3MFTLOAPZ2EkmSXlWov3Zn5Ro6nl3eqd9sQh3FTe1yeV2/nnMq+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzC55Ti/7aeghqHD5zFbTK6I0h1mRtEPchxFk+3CI0oDUflKaf
	DASrLwsmc9OeuWx1oUDOV2DnLz//ALFz7/OMr+t8Ye/z713jl1MWfwmvTahKSh+6pwUDkvgel1v
	zhXMm9qnYUrf9VBCZ/yprfmso5O++NP+6z3BRhqisVFKXuqjwqGkTDw==
X-Gm-Gg: ASbGncsdUzEvY1qU2SKzbyzoK2JWuFta9VLwyGbQe2bd1VUyIoA1uTN0UbY7KzDGkSJ
	UBFB2eOmj9xyWLMOvAFih9RxINBI0SUBHBz2hE7tNyQ4j3BP5dvbNZvqN0O12Iocd7ENtxgWqSa
	P3E9TzGOAmsakPNUSVkr3OJwRzTrJFxXXhYHayW7DqIENfx2846YWEnTLM91IhAL1IQnb7P3E8V
	tVLlVuQ5tBdPtjiBs9rE8t2pC+GYYT00PU7JrNrGaqgoYmlsrnnThiu+9PfzX66MDH3hUSy5htG
	OHkNhR9EEdzXZoCBxTvbmChuPiDIK75XPrPSpeCoCn1HRw==
X-Received: by 2002:a5d:5987:0:b0:391:4763:2a with SMTP id ffacd0b85a97d-39973b434c4mr1469303f8f.47.1742371074222;
        Wed, 19 Mar 2025 00:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESBUZPSQPICu7K1+dOHQAqsjNDI6H7BmOCp1t0o6GDATX6WvmayRBKfbO1OQl4SXDvbyCCgw==
X-Received: by 2002:a5d:5987:0:b0:391:4763:2a with SMTP id ffacd0b85a97d-39973b434c4mr1469279f8f.47.1742371073773;
        Wed, 19 Mar 2025 00:57:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm20733018f8f.91.2025.03.19.00.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 00:57:53 -0700 (PDT)
Message-ID: <70ca4d5c-90c3-4a96-b47b-fbf5034c7450@redhat.com>
Date: Wed, 19 Mar 2025 08:57:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250318233240.53946-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/25 12:31 AM, Kuniyuki Iwashima wrote:
> Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
> done without RTNL.
> 
> Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.
> 
> Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
> this series.
> 
> rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
> needs more work due to the left-to-right rbtree walk, which looks prone
> to node deletion and tree rotation without a retry mechanism.
> 
> 
> Kuniyuki Iwashima (7):
>   nexthop: Move nlmsg_parse() in rtm_to_nh_config() to
>     rtm_new_nexthop().
>   nexthop: Split nh_check_attr_group().
>   nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
>   nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
>   nexthop: Remove redundant group len check in nexthop_create_group().
>   nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
>   nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.
> 
>  net/ipv4/nexthop.c | 183 +++++++++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 71 deletions(-)

This series is apparently causing NULL ptr deref in the nexthop.sh
netdevsim selftests. Unfortunately, due to a transient nipa infra
outage, a lot of stuff landed into the same batch, so I'm not 110% this
series is the real curprit but looks like a reasonable suspect.

Kuniyuki, could you please have a look?

---
[    1.653896] BUG: kernel NULL pointer dereference, address:
0000000000000068
[    1.653963] #PF: supervisor read access in kernel mode
[    1.654003] #PF: error_code(0x0000) - not-present page
[    1.654037] PGD 7828067 P4D 7828067 PUD 782a067 PMD 0
[    1.654077] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    1.654119] CPU: 0 UID: 0 PID: 303 Comm: ip Not tainted
6.14.0-rc6-virtme #1
[    1.654176] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    1.654219] RIP: 0010:rtm_new_nexthop+0x645/0x2260
[    1.654263] Code: 70 02 00 00 48 85 db 75 0e eb 1f 48 83 c3 10 48 8b
1b 48 85 db 74 13 3b 43 60 72 ef 76 0c 48 83 c3 08 48 8b 1b 48 85 db 75
ed <8b> 53 68 4c 8d 63 68 85 d2 0f 84 f1 02 00 00 8d 4a 01 89 d0 f0 41
[    1.654390] RSP: 0018:ffffae348037b860 EFLAGS: 00010246
[    1.654430] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
0000000000000000
[    1.654482] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff992d066b8000
[    1.654534] RBP: ffffae348037bab0 R08: ffff992d012d2fa8 R09:
ffff992d055d1780
[    1.654587] R10: ffffae348037b860 R11: ffff992d055d17c8 R12:
ffffae348037bb60
[    1.654638] R13: 0000000000000000 R14: 0000000000000001 R15:
ffff992d055d17c8
[    1.654692] FS:  00007f8b6fb0c800(0000) GS:ffff992d3ec00000(0000)
knlGS:0000000000000000
[    1.654749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.654791] CR2: 0000000000000068 CR3: 00000000067ae005 CR4:
0000000000772ef0
[    1.654844] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.654900] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    1.654957] PKRU: 55555554
[    1.654974] Call Trace:
[    1.654993]  <TASK>
[    1.655015]  ? __die+0x24/0x70
[    1.655049]  ? page_fault_oops+0x15a/0x450
[    1.655080]  ? mas_topiary_replace+0x9ba/0xca0
[    1.655121]  ? exc_page_fault+0x69/0x150
[    1.655162]  ? asm_exc_page_fault+0x26/0x30
[    1.655202]  ? rtm_new_nexthop+0x645/0x2260
[    1.655239]  ? virtqueue_notify+0x1c/0x40
[    1.655269]  ? virtio_fs_enqueue_req+0x50c/0x570
[    1.655311]  ? __pfx_rtm_new_nexthop+0x10/0x10
[    1.655351]  ? rtnetlink_rcv_msg+0x361/0x410
[    1.655391]  rtnetlink_rcv_msg+0x361/0x410
[    1.655417]  ? __remove_hrtimer+0x39/0x90
[    1.655448]  ? sysvec_apic_timer_interrupt+0xf/0x90
[    1.655494]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    1.655528]  netlink_rcv_skb+0x58/0x110
[    1.655560]  netlink_unicast+0x247/0x370
[    1.655592]  netlink_sendmsg+0x1bf/0x3e0
[    1.655624]  ____sys_sendmsg+0x2bc/0x320
[    1.655656]  ? copy_msghdr_from_user+0x6d/0xa0
[    1.655696]  ___sys_sendmsg+0x88/0xd0
[    1.655729]  __sys_sendmsg+0x6c/0xc0
[    1.655760]  do_syscall_64+0x9e/0x1a0
[    1.655793]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.655834] RIP: 0033:0x7f8b6fd189a7
[    1.655864] Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[    1.655986] RSP: 002b:00007ffebd919418 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[    1.656043] RAX: ffffffffffffffda RBX: 00007ffebd919f80 RCX:
00007f8b6fd189a7
[    1.656099] RDX: 0000000000000000 RSI: 00007ffebd919480 RDI:
0000000000000005
[    1.656151] RBP: 00007ffebd919940 R08: 0000000006ba3910 R09:
0000000000000000
[    1.656202] R10: 00007f8b6fbd1708 R11: 0000000000000246 R12:
0000000006ba3918
[    1.656254] R13: 0000000067da36b9 R14: 0000000000498600 R15:
0000000006ba3910
[    1.656307]  </TASK>
[    1.656324] Modules linked in: netdevsim
[    1.656356] CR2: 0000000000000068


