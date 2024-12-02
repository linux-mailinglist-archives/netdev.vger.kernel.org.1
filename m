Return-Path: <netdev+bounces-148025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F609DFDC4
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A6EB21C90
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF51FC104;
	Mon,  2 Dec 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMVLHO2q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE321FBEA8
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132952; cv=none; b=GFENCw8OobfNZtDCPx+pxzdl/zztt+YXjkxAk2+Vh1y7H3AQnHCr0MNLspP/WIXxaHsevfZAYatVxjt7SGULPCrKhTbnHIzYPZC/vvPIrhSPLqIl7KP6WIYkQDd0+o1/PL7bhBuUPzwDpkV8cpKp6G1urn9xD/WzEcZRetqap8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132952; c=relaxed/simple;
	bh=/Afq/NexSzwCq4HP+zqtFUoykq9+KtMqpTtew1KrZJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOW96QHF+4+uDkzTaKRAXgZBl8V6ny/BOHZKyV6rdCMnPTqbNEZoIAq9PgklWNNgOMCKDNS5O3STY8pzZUqo9RiblyKitm/HCCD3Rg2eKEtlDMiDs+pj7G9zl5Xx/X5nU+wnrTIjq5f4ZBiJVEv3oG0BJXlNZNYaEvLmahO50kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMVLHO2q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733132949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/Lfs25Ng1MgLd8GioalVVZFha1NlhkmJQy+3UG2CHI=;
	b=SMVLHO2qI/+q2PgS/UyTW0nI3kx0BXw4UN1TIMRRjQqaoUi59wjnIGtxgMt6enpqeAzZSn
	EgtVV61D0y9JC6kTniWtHAKV9RTM0hWvVdTpzc0qM2VvtkgxvjwPHUVL0cCdrBByGvsqRi
	dSR7N7tIK6qAqjn5aE6xREZI2mCen2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-XK7EFbo_M3Sdzb5uh8UNeQ-1; Mon, 02 Dec 2024 04:49:08 -0500
X-MC-Unique: XK7EFbo_M3Sdzb5uh8UNeQ-1
X-Mimecast-MFC-AGG-ID: XK7EFbo_M3Sdzb5uh8UNeQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e9c698e7so802905f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 01:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132947; x=1733737747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/Lfs25Ng1MgLd8GioalVVZFha1NlhkmJQy+3UG2CHI=;
        b=d+oHeCRj2NjI1OtZeNieEk5B76GcdqNy6USNKiuIvhp8o1LN5tjba2vuqkxLLVoTnX
         gqV/wPKwAqC4DEM5JLtpf0Ue09oDStqOQAlOa0wkDFSv8j3G3UILNjXvNsEVExdmE2jw
         EcqvRpstE600rcOAsEtQSt+jV+o12GoOmGaq+BhT6rkXUo/Xe+ToxT30CuslU9JGLC6D
         xeS+r4utRvYbx+D0R2aK+g5cHT3pJLoCZx0ME7ydbRBYJTO5ZxZCz775+Ut/mi9r+k55
         ISA2lw10v8vLA8m4DPxPi1GAeQb7+lVBtxm8CPbr9ojo5IL2qVcGKiC4ogrthtwJnQ9T
         4K/A==
X-Gm-Message-State: AOJu0Yz6bQnQ9theVJRgK0i16Mrx8FJu94b1rNV57NfqZGf4cBs7YIxO
	T0fxT4EBeF4mgzawnpjouEFOc+vn0ZTGmMDkYHRRqn2WzGbFL53x39Wuxnnwv/XP8cX4n7jsvAY
	zjATa/WXCXaEtsjuR1onH7ptvsSHqzWsaX0gzWkVfm5YF4n6W8Q2D7g==
X-Gm-Gg: ASbGncvH6fV1Ft2+sUyigFJ10yDF06cQQ+uAM9CNMT0+2x0bz+/NXIkCzPqhvheM6hb
	b42t7p73kNyJ6yKzO8NqfEjwXTUf98h133mngBqLNGZS5vKTNRa3pJnpYGMJOGVl7sI+tAyVXtT
	BeYv/Pt9uSWgZH8rj26LhDMzmCgX1in6IvAObKfoDtpEP4AvKBXV046Vosg3MibX+iyEfxo/8BS
	0TNvDWqHjmMBeC+MRzngbtHbk6QQFxdjMW+DBEbcGE5AXukig/jCOCd/88eJ9PbgkZviyjPSgSH
X-Received: by 2002:a05:6000:2cc:b0:385:e4a6:5ae1 with SMTP id ffacd0b85a97d-385e4a65c0bmr6934660f8f.8.1733132946978;
        Mon, 02 Dec 2024 01:49:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9iMZIzf/KpFj3XmQr0C0FzKxV+ijxSXtjU8SpB7MNaEGzXvdHRrPbn7QNHLmOKe3+5GXH3Q==
X-Received: by 2002:a05:6000:2cc:b0:385:e4a6:5ae1 with SMTP id ffacd0b85a97d-385e4a65c0bmr6934632f8f.8.1733132946636;
        Mon, 02 Dec 2024 01:49:06 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d5fb37sm163195975e9.0.2024.12.02.01.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 01:49:06 -0800 (PST)
Message-ID: <9646e7b4-d49c-48df-8b29-e21186ef89b4@redhat.com>
Date: Mon, 2 Dec 2024 10:48:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ipmr: tune the ipmr_can_free_table() checks.
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>
References: <7d13b21f439acd027e510890ba4b353994bad058.1733129879.git.pabeni@redhat.com>
 <CANn89iKTA7YN=cZebH5NaNV41LuGKk5GfcZTf3yyrcJJE8EBpQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKTA7YN=cZebH5NaNV41LuGKk5GfcZTf3yyrcJJE8EBpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/24 10:11, Eric Dumazet wrote:
> On Mon, Dec 2, 2024 at 9:59 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> Eric reported a syzkaller-triggered splat caused by recent ipmr changes:
>>
>> WARNING: CPU: 2 PID: 6041 at net/ipv6/ip6mr.c:419
>> ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
>> Modules linked in:
>> CPU: 2 UID: 0 PID: 6041 Comm: syz-executor183 Not tainted
>> 6.12.0-syzkaller-10681-g65ae975e97d5 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
>> Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c
>> 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 44 ef a9 f7 90 <0f> 0b
>> 90 e8 3b ef a9 f7 48 8d 7b 38 e8 12 a3 96 f7 48 89 df be 0f
>> RSP: 0018:ffffc90004267bd8 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff88803c710000 RCX: ffffffff89e4d844
>> RDX: ffff88803c52c880 RSI: ffffffff89e4d87c RDI: ffff88803c578ec0
>> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: ffff88803c578000
>> R13: ffff88803c710000 R14: ffff88803c710008 R15: dead000000000100
>> FS: 00007f7a855ee6c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f7a85689938 CR3: 000000003c492000 CR4: 0000000000352ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>> <TASK>
>> ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
>> ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
>> ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
>> setup_net+0x4fe/0x860 net/core/net_namespace.c:394
>> copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
>> create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
>> unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
>> ksys_unshare+0x45d/0xa40 kernel/fork.c:3334
>> __do_sys_unshare kernel/fork.c:3405 [inline]
>> __se_sys_unshare kernel/fork.c:3403 [inline]
>> __x64_sys_unshare+0x31/0x40 kernel/fork.c:3403
>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f7a856332d9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f7a855ee238 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
>> RAX: ffffffffffffffda RBX: 00007f7a856bd308 RCX: 00007f7a856332d9
>> RDX: 00007f7a8560f8c6 RSI: 0000000000000000 RDI: 0000000062040200
>> RBP: 00007f7a856bd300 R08: 00007fff932160a7 R09: 00007f7a855ee6c0
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a856bd30c
>> R13: 0000000000000000 R14: 00007fff93215fc0 R15: 00007fff932160a8
>> </TASK>
>>
>> The root cause is a network namespace creation failing after successful
>> initialization of the ipmr subsystem. Such a case is not currently
>> matched by the ipmr_can_free_table() helper.
>>
>> New namespaces are zeroed on allocation and inserted into net ns list
>> only after successful creation; when deleting an ipmr table, the list
>> next pointer can be NULL only on netns initialization failure.
>>
>> Update the ipmr_can_free_table() checks leveraging such condition.
>>
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>  - move the netns init completed check in a new helper
>> ---
>>  include/net/net_namespace.h | 5 +++++
>>  net/ipv4/ipmr.c             | 2 +-
>>  net/ipv6/ip6mr.c            | 2 +-
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>> index 873c0f9fdac6..ac301c7d48a4 100644
>> --- a/include/net/net_namespace.h
>> +++ b/include/net/net_namespace.h
>> @@ -325,6 +325,11 @@ static inline int check_net(const struct net *net)
>>  #define net_drop_ns NULL
>>  #endif
>>
>> +/* Returns true if the netns initialization is completed successfully */
>> +static inline bool net_initialized(struct net *net)
>> +{
>> +       return net->list.next;
> 
> It is unclear what lock protects this read (or context it can be used)
> 
> Perhaps we could make clear no lock is needed (and add a const qual)
> 
> static inline bool net_initialized(const struct net *net)
> {
>        return READ_ONCE(net->list.next);
> }

Thanks, I will do in v3.

Paolo


