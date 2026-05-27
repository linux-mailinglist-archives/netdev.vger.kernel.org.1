Return-Path: <netdev+bounces-292173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FrwD+ipFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF7D5E1058
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBB8F3008504
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554E3D7D9A;
	Wed, 27 May 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+X/rN1Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSX30n+m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8F218AB9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870179; cv=none; b=MWy6AlVPUXdNvGhM+KXAMqq6imaHFa8JMvYXiLPo+gh14cQ7E7l4rfkK+i8g2TzSUAuT6bgaQ7PV7koy3HuFrF9RCPBjoEJN1mgf1khK5j77uEi1qQYOWN7uudOx4sdHRkeHBIwYorZ+3lMmgMSoeLBSIQYcMKh/+oQF2YSuuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870179; c=relaxed/simple;
	bh=IO0LCu9wvwR0gVmpOORo7qk9LYRrfdCV/VG3gAEsoh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGQN02O0hHna7U98qrAXyo6taR9ZoeYPJiLQgw2wG32pO9Nprb4LU8L9oOCM3SxN7+KZNqzuYQAe8xayTcGp3Y0kDrXxFDnSymgS+DgjYCBhx93r9Vf4hvyLDWaN/yZSBUzT0IPwHLjkKxdDFUjmL4/ihk7tFeK5x9d9pcAoHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+X/rN1Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSX30n+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779870176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JJYrUrYP02/ZgBgvHJKIrFYj3i3UQzprHxuqCTJjKY=;
	b=Z+X/rN1Zi/xSow0L829jURYwbcOlp4kTHupv3PJ6vD+o3AomGp6YNQxYBmGgVqGQTwJrbK
	nRHGJZSLw4j4UwH6vPv7iWNTIe6g2Z/oyx+lj6+I711kA6MooSk6ltU6QJV4QD6gyY7D+y
	xGHKKFyvxSdA3iYzn3X6rJ7IsmUYYhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-bx1HivWtNWCwA6NPEVQLqg-1; Wed, 27 May 2026 04:22:53 -0400
X-MC-Unique: bx1HivWtNWCwA6NPEVQLqg-1
X-Mimecast-MFC-AGG-ID: bx1HivWtNWCwA6NPEVQLqg_1779870172
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso8029276f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779870172; x=1780474972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JJYrUrYP02/ZgBgvHJKIrFYj3i3UQzprHxuqCTJjKY=;
        b=bSX30n+mdqIOBraMids94nRak9JptVgpxiI74upbkbWFdwPAdGPqMuPPKVKjOb2H/O
         jkxmb4KyUw44PxMImU6tmBMWFKq97X1D3d4rJ1gqBF+ruV18YAoDNy54yGAKkWD/2/By
         uPLTxj74ftl0UjqCTe1Oo1YdPBNFE0HAZUmPxzAR74jB1ZKxSsPi+ByVF9F3TodJiztr
         Fa6wG2c3d5hPDAfhhyu8WV+CzJIZKfwvp3dwBTw8AC9JRweuaMBjd3rDKD4aagDLPPJ4
         U4dhbcQ/MBnPsG1g+SmF1Hf9aV9Tfsl+UpO7sPk+YXtdsDqQJNxAtCVx8QloxMQMVEJc
         0A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870172; x=1780474972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JJYrUrYP02/ZgBgvHJKIrFYj3i3UQzprHxuqCTJjKY=;
        b=AREtjeSM2rzNCiPPoyb7hDrwQacPIwEOi4IZRxOu7yC6nrPVvrOKQccFosrIlc1CIz
         ES/Tu2Gr9pee7iyh5So+sIcnGCHxsE2Wo2+/aL581kloSUdfQtq7ng1KMc2NSwGf8zk8
         9nbdr6wxwz+bhhKdTG34YI5WnJRKmgTClDte+UkU3jfvjvDsuBDqXxBMxc6wwugJ7PwJ
         m1BVpXZfb79+aFrDL4vG1HgTyIBKFM3rjbrVoRQji8vsqNjduC7a+6qvic/f62Wr/PH4
         V1kvsOV4AOdGmIdNyZr+QAyHNXOxNiv6lx4lNnCHoK8pWbvcFBadIxm0juMVMUr4hHzJ
         9jcA==
X-Gm-Message-State: AOJu0Yzgf9hL/H0jmy3uPKzgNVeE+eo8CZGVYNGKJZwOZYoCTCfXO7D3
	9ynRNgJQzK+xQ9u86SUrymboFFZcCILoFhUXLabJxHfkyn6i8ZVeZ0je8rueajQEcRblSvF4CeU
	ZIWU9SYv50ZX1Bz9Lv/6yoHAzeTrw0U+56o8GeyG+0PQfcv2BrBH5Z7kYnA==
X-Gm-Gg: Acq92OEtouHVRGXPhySSUhc2D7Y9VN/9wyry1ErhZ+CzTSUbsd7PvpR7c61qsf2rW1n
	K7NV/zJhgfFUgHjXYgxwoGR8sFdSxy/r4JjcNtbG8fiMQJm0lJjcyza73mwc3Liy6Z60l6rjtV8
	JQcghp7ph3EPw2Bw0Vb3TpG8wuNhbXq47wB7xL/ibZi0RjJ5IJXKEb0kCZMptHvj9yjX/IkyAIa
	tNxWSvrG3RoEOX3efbM806Je8eC5YuzWc4rgZ/BornxtnipnxX/sFZ7ZWqrEExWPtWW3M3BliUh
	tYs1tpHDBlu/bjeyasDi5a4m08JDqaBWCBMCQbCtXHP9y4KEVsUBYP0LXhssjsaO+dfixD/Pxqu
	ApzG4FkSCh7VwO/iGb5w7uPA5QnPpO1qwfqJaSzHG1MoJbWI7uOgD8H444w==
X-Received: by 2002:a05:600c:c4a4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4904225fbdamr328862275e9.2.1779870171929;
        Wed, 27 May 2026 01:22:51 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4904225fbdamr328861825e9.2.1779870171412;
        Wed, 27 May 2026 01:22:51 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm680567795e9.1.2026.05.27.01.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 01:22:50 -0700 (PDT)
Message-ID: <78db23f1-1ac7-4d87-97e5-668b685818c4@redhat.com>
Date: Wed, 27 May 2026 10:22:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/1] geneve: fix Use-After-Free in RX path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, victor@mojatatu.com,
 andrew+netdev@lunn.ch, rajat.gupta@oss.qualcomm.com
References: <20260521131436.748832-1-jhs@mojatatu.com>
 <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
 <CAM0EoM=CPeOaoMUjXEp3eGeBVjomyWYV-2qj0jMOP+DNvjuPMA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoM=CPeOaoMUjXEp3eGeBVjomyWYV-2qj0jMOP+DNvjuPMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292173-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,mojatatu.com:email]
X-Rspamd-Queue-Id: 9CF7D5E1058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 2:38 PM, Jamal Hadi Salim wrote:
> On Tue, May 26, 2026 at 5:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
>>> Context: This commit fixes a UAF in Geneve. The UAF component was discovered
>>> because it is triggered by a buggy 'pedit' action[1]. the buggy pedit uses
>>> skb_store_bits() and can write into shared or non-linear data without copying
>>> the entire skb head. The Geneve device invoking either pskb_may_pull() or
>>> iptunnel_pull_header() is much more likely to reallocate the skb head, freeing
>>> the memory pointed to by geneve's stale geneveh pointer.
>>>
>>> Note, although the patch looks big it's mostly re-arranging functions to avoid
>>> forward declaration.
>>>
>>> Sample UAF below:
>>> ....
>>> BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
>>> Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
>>>
>>> CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g0e3e91779b94 #551 PREEMPT(full)
>>> Workqueue: ipv6_addrconf addrconf_dad_work
>>> Call Trace:
>>>  <IRQ>
>>>  dump_stack_lvl+0x8c/0xd0
>>>  print_report+0xce/0x5e0
>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>  ? kasan_complete_mode_report_info+0x80/0x200
>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>  kasan_report+0xd6/0x110
>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>  __asan_report_load1_noabort+0x18/0x20
>>>  geneve_udp_encap_recv+0x2e8c/0x3190
>>>  ? get_stack_info+0x38/0xc0
>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>  ? __pfx_geneve_udp_encap_recv+0x10/0x10
>>>  ? udp4_lib_lookup2+0x31c/0x700
>>>  ? __pfx_udp_ehashfn+0x10/0x10
>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
>>>  udp_queue_rcv_one_skb+0x65e/0xd20
>>>  udp_queue_rcv_skb+0x142/0xb00
>>>  udp_unicast_rcv_skb+0xd3/0x2c0
>>>  udp_rcv+0x198f/0x2570
>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>  ip_protocol_deliver_rcu+0x1f8/0x3c0
>>>  ip_local_deliver_finish+0x362/0x5d0
>>> ....
>>>
>>> [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss.qualcomm.com/
>>> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
>>> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>> ---
>>> v1->v2 Address gemini-sashiko.
>>> 1. local variable "len" initialization in geneve_post_decap_hint()
>>>    Although doesnt contribute to the fix, it was introduced in fd0dd796576e
>>> 2. resolve out-of-bounds transport header for non-GSO packets
>>> ---
>>>  drivers/net/geneve.c   | 174 ++++++++++++++++++++++-------------------
>>>  include/linux/skbuff.h |   5 ++
>>>  2 files changed, 98 insertions(+), 81 deletions(-)
>>>
>>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>>> index c6563367d382..dc5f5394836a 100644
>>> --- a/drivers/net/geneve.c
>>> +++ b/drivers/net/geneve.c
>>> @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
>>>       return NULL;
>>>  }
>>>
>>> +/*
>>> + * Look for GRO hint in the genenve options; if not found or does not pass basic
>>> + * sanitization return 0, otherwise the offset WRT the geneve hdr start.
>>> + */
>>> +static unsigned int
>>> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
>>> +                     unsigned int *gh_len)
>>> +{
>>> +     struct geneve_opt *opt = (void *)(gh + 1);
>>> +     unsigned int id, opt_len = gh->opt_len;
>>> +     struct geneve_opt_gro_hint *gro_hint;
>>> +
>>> +     while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
>>> +             if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
>>> +                 opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
>>> +                 opt->length == GENEVE_OPT_GRO_HINT_LEN)
>>> +                     goto found;
>>> +
>>> +             /* check for bad opt len */
>>> +             if (opt->length + 1 >= opt_len)
>>> +                     return 0;
>>> +
>>> +             /* next opt */
>>> +             opt_len -= opt->length + 1;
>>> +             opt = ((void *)opt) + ((opt->length + 1) << 2);
>>> +     }
>>> +     return 0;
>>> +
>>> +found:
>>> +     gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
>>> +
>>> +     /*
>>> +      * Sanitize the hinted hdrs: the nested transport is UDP and must fit
>>> +      * the overall hinted hdr size.
>>> +      */
>>> +     if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
>>> +         gro_hint->nested_hdr_len)
>>> +             return 0;
>>> +
>>> +     if (gro_hint->nested_nh_offset +
>>> +         (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
>>> +                                   sizeof(struct iphdr)) >
>>> +         gro_hint->nested_tp_offset)
>>> +             return 0;
>>> +
>>> +     /* Allow only supported L2. */
>>> +     id = gro_hint->inner_proto_id;
>>> +     if (id >= ARRAY_SIZE(proto_id_map))
>>> +             return 0;
>>> +
>>> +     *type = proto_id_map[id];
>>> +     *gh_len += gro_hint->nested_hdr_len;
>>> +
>>> +     return (void *)gro_hint - (void *)gh;
>>> +}
>>> +
>>> +static const struct geneve_opt_gro_hint *
>>> +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
>>> +{
>>> +     return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
>>> +}
>>> +
>>> +static unsigned int
>>> +geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
>>> +                    __be16 *type, unsigned int *gh_len)
>>> +{
>>> +     const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
>>> +
>>> +     if (!gs || !gs->gro_hint)
>>> +             return 0;
>>> +     return geneve_opt_gro_hint_off(gh, type, gh_len);
>>> +}
>>> +
>>>  /* geneve receive/decap routine */
>>>  static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>>>                     struct sk_buff *skb, const struct genevehdr *gnvh)
>>> @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>>>       if (tun_dst)
>>>               skb_dst_set(skb, &tun_dst->dst);
>>>
>>> +     if (skb->encapsulation) {
>>> +             unsigned int len = 0, hint_off;
>>> +             __be16 p;
>>> +
>>> +             hint_off = geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &p, &len);
>>> +             if (hint_off && len <= skb_headlen(skb)) {
>>> +                     const struct geneve_opt_gro_hint *gro_hint;
>>> +
>>> +                     gro_hint = geneve_opt_gro_hint(gnvh, hint_off);
>>> +                     skb_set_transport_header(skb, gro_hint->nested_tp_offset);
>>> +             }
>>> +     } else {
>>> +             skb_unset_transport_header(skb);
>>> +     }
>>
>> It's not clear to me why the above chunk is needed.
> 
> I think you understand this so i may be stating the obvious:
> The main motivation was to isolate the pulls from making the transport
> header stale
> IOW, geneve_hdr(skb) pointer could become "stale" if the packet's head
> was reallocated (because geneve_rx() is called after all the "pull"
> operations) - so this ensures that the inner transport header is only
> set after all header pulling is done - otherwise we get a UAF.

Uhmm... my questions sparked because this patch adds quite a bit of new
conditionals in the data-path, which I would like to avoid them.

But I must admit that re-reading the code - I'm likely low on coffee - I
don't see the UaF. This sequence:

	pskb_may_pull(skb...)
	geneveh = geneve_hdr(skb);

is correct/does not yield to UaF, and AFAICS `geneveh` is always
reloaded after pskb_may_pull()/iptunnel_pull_header(). Could you please
share a decoded stack trace for the UaF you are observing? So it's clear
where exactly kasan reports the problem.

>> Why can't
>> geneve_post_decap_hint() retain the transport header set in the current
>> place? it would make this patch much shorter.
>>
> 
> It was more to ensure clean state for cases where we dont have GRO hints.
> The "else {skb_unset_transport_header(skb);} " handles the case where
> we are missing GRO hints - at that point outer UDP header is stripped
> but tranport header is still pointing to where this outer header used
> to be and something down the road may misintepret the header.

This looks like an unrelated problem?!? And possibly not a problem at
all?!? Upper layers (outside GSO) are expected to re-evaluate the
transport header as needed.

/P


