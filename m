Return-Path: <netdev+bounces-292379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JnXMP4dF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:38:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7F5E7DFC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E94F3051BA1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEFF43637D;
	Wed, 27 May 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0VmpCuq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2od+M+Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C142B738
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899541; cv=none; b=S/c3yTNKggzkWnEVoSGatzXz3rMLyU1R4TQomt9kUnJu+hj5P+RsByCEqvco3Bs5tnEPR1DB2860N3rN34P9Lg0eM7ro9tyKeKcji4le6TdmMmK/hLa91Gc3jG8bp5fj1MX/VvdJjaR5XUdwWgxceInjvuwEerc5ssnW3FCXUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899541; c=relaxed/simple;
	bh=cEVmglzyymIEtjT542+nEwh6s0tSgZWZ100poznSHOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt+wDfKI37q8ts0UlAe/EiMLUsJRHqJPD7vUNfkbll/T1zWe9yRLSQboLu/UOfESRppG3ItWQXrhmlrMnVbsZBmep14u/SUEf9fe3Fyh/h2sL2nuo2rb2S9XuJTngpTqFjNO9kXiq3bNL6sH3T8FC2e6F4+jIgNZVDxQ2aRYZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0VmpCuq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2od+M+Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779899538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tm+u0t/wd00+M9ekVI19c+wOtWYQ3WUs+D0eMcleQ4w=;
	b=c0VmpCuq+rknEci4ndOiOwOD+1THm7cL55eya3Xmg37FB1N4h9IoS89hdqYsmaFJ87jNjy
	uYUdO/Rra36cth0/YACuXaImPCf1Re2Q+CyHJhgs4G4C9ndlcw591AmdvRB+Gz5GyfqCgG
	+LBX7fE49ATb2gTjB/uxAue5qrlQJZU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-lsMkfP_-OIiewFrAk_hjNw-1; Wed, 27 May 2026 12:32:16 -0400
X-MC-Unique: lsMkfP_-OIiewFrAk_hjNw-1
X-Mimecast-MFC-AGG-ID: lsMkfP_-OIiewFrAk_hjNw_1779899535
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-676fb54c0cdso10143373a12.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779899535; x=1780504335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tm+u0t/wd00+M9ekVI19c+wOtWYQ3WUs+D0eMcleQ4w=;
        b=W2od+M+Yp3wi6E/xeuJiILV82JkWO/Lu+a8ylr76R1mKW/9vxQynUMj6uQsO6glqCu
         22SS8mNlTjz4GgsXMzSW46QLEFYMWtIQNM+0xhaFB7po4ptlC+t3G2a88PCzgsuUP6CP
         LkqqlqF0+c2B609QIOuO6aoHJ5BxbvKThvWKrjnTSVtLa/nL2qRBTQg1dNHXmQJxjZLD
         pC061k0PyvDvOgUoJg7qQSl8bYbOeC3SM1+7JPJZcNa1iOEWhZK/syaazI/38Eo7l5bF
         Bkd/ajNiW7bfqJCexDYokHLu79SpgXrgXApoLt3zPMjrlisETPYryXBXYVxCccsR9o1W
         UcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899535; x=1780504335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm+u0t/wd00+M9ekVI19c+wOtWYQ3WUs+D0eMcleQ4w=;
        b=RXSc+RjtAn+hJOTqERzJAiRDEctj06YEXTYOJ4InezLOgw1IvpF7mNOeN7oP/+8P+4
         WXvZAkNFN/zUkvVSp/zZKLTL/nsBvuWs0Au1b0ZUR6M1zMO2vKqP/fyJ14uL3iuY7BkX
         +lw4Noe8thirs4JoIp8ke4zuKvhdyruzPoGKqeRaUJ44/UVxdE3iFQQuAYbbLm6y8WgF
         iCnMiaRzaoNaczxavwGNC+XLJlt4oV75poQGFJo53M02xegnV3Z/3ghNcYtm8K4aM9H2
         zBDUoCMQVAmrdGA2slvnn3dXSLsBoBLKamMnbaPI8IHaVFdxxer+JYMw9xjhRfvDTzlP
         FkKA==
X-Gm-Message-State: AOJu0YwRGiLFiER8rblSrf1+4/Kb3hiirATwUlT1qU4M+FgXH0967lww
	zJvZh6AxrmWQaV2FIgbdQ17jm9qfkt50xtuqfn9pO4MO/99I0M0IfDWEzub2H/1uNzk0N495xJQ
	71mzrn7JrH97SQ3Co1Oj7e3YYeqjdIHDgXJQA8BNmB2Rs66TUE07uzkohvw==
X-Gm-Gg: Acq92OHIF7T5LUBOMtXYGUmOs/WksE2+mrNEE44eLLdckHTbksd/g0i1AY1Ah494zZq
	gHgkE6JPdTNcrPUrlzL92n++yJEWXWH843mtwobbJIMkfox7IMiUuRuJfK24mukOuRXTmB9eddN
	DFgKFzuChSQKtf3fKuKmpO130LZQW0pbKhnk7/kVwSp/VKCee3KdfYax4O0N+1ZMMVspsbXvndW
	w0Brbs1TD2eRwKYfBt77hHl7xvUdAnstLUEmkCNyc0nVpfxRDGXg6hiX+WGB2owqD1fl4/UDZwm
	6pV54rnmlR8ydQzcurSO4nUhKIWvOgvCRO2YV34FLNSs3QwpkwQCQ4YcX+EXf0M42AD2YVwDB2S
	6l0JmLqgEWLxuJ3LkQHkSp4JKS7nwd4uaSagmdGWw3HKd3f6T9a0v0xYMZA==
X-Received: by 2002:a05:6402:40cb:b0:678:ce1e:a5cb with SMTP id 4fb4d7f45d1cf-6889cc5f75fmr12192479a12.21.1779899534688;
        Wed, 27 May 2026 09:32:14 -0700 (PDT)
X-Received: by 2002:a05:6402:40cb:b0:678:ce1e:a5cb with SMTP id 4fb4d7f45d1cf-6889cc5f75fmr12192451a12.21.1779899534124;
        Wed, 27 May 2026 09:32:14 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fa2a017sm943150a12.0.2026.05.27.09.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:32:12 -0700 (PDT)
Message-ID: <6c4e1859-bd3f-4227-b268-1c7dbe5935cb@redhat.com>
Date: Wed, 27 May 2026 18:32:11 +0200
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
 <78db23f1-1ac7-4d87-97e5-668b685818c4@redhat.com>
 <CAM0EoMnaqFgKBYBKrXh4tdbo6-JXC1HBhHWqOx=kQu9yFxk2fQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMnaqFgKBYBKrXh4tdbo6-JXC1HBhHWqOx=kQu9yFxk2fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292379-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: C4C7F5E7DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 5:34 PM, Jamal Hadi Salim wrote:
> On Wed, May 27, 2026 at 4:22 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/26/26 2:38 PM, Jamal Hadi Salim wrote:
>>> On Tue, May 26, 2026 at 5:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
>>>>> Context: This commit fixes a UAF in Geneve. The UAF component was discovered
>>>>> because it is triggered by a buggy 'pedit' action[1]. the buggy pedit uses
>>>>> skb_store_bits() and can write into shared or non-linear data without copying
>>>>> the entire skb head. The Geneve device invoking either pskb_may_pull() or
>>>>> iptunnel_pull_header() is much more likely to reallocate the skb head, freeing
>>>>> the memory pointed to by geneve's stale geneveh pointer.
>>>>>
>>>>> Note, although the patch looks big it's mostly re-arranging functions to avoid
>>>>> forward declaration.
>>>>>
>>>>> Sample UAF below:
>>>>> ....
>>>>> BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
>>>>> Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
>>>>>
>>>>> CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g0e3e91779b94 #551 PREEMPT(full)
>>>>> Workqueue: ipv6_addrconf addrconf_dad_work
>>>>> Call Trace:
>>>>>  <IRQ>
>>>>>  dump_stack_lvl+0x8c/0xd0
>>>>>  print_report+0xce/0x5e0
>>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>>  ? kasan_complete_mode_report_info+0x80/0x200
>>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>>>  kasan_report+0xd6/0x110
>>>>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>>>>>  __asan_report_load1_noabort+0x18/0x20
>>>>>  geneve_udp_encap_recv+0x2e8c/0x3190
>>>>>  ? get_stack_info+0x38/0xc0
>>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>>  ? __pfx_geneve_udp_encap_recv+0x10/0x10
>>>>>  ? udp4_lib_lookup2+0x31c/0x700
>>>>>  ? __pfx_udp_ehashfn+0x10/0x10
>>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>>  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
>>>>>  udp_queue_rcv_one_skb+0x65e/0xd20
>>>>>  udp_queue_rcv_skb+0x142/0xb00
>>>>>  udp_unicast_rcv_skb+0xd3/0x2c0
>>>>>  udp_rcv+0x198f/0x2570
>>>>>  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>>  ip_protocol_deliver_rcu+0x1f8/0x3c0
>>>>>  ip_local_deliver_finish+0x362/0x5d0
>>>>> ....
>>>>>
>>>>> [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss.qualcomm.com/
>>>>> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
>>>>> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>>>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>> ---
>>>>> v1->v2 Address gemini-sashiko.
>>>>> 1. local variable "len" initialization in geneve_post_decap_hint()
>>>>>    Although doesnt contribute to the fix, it was introduced in fd0dd796576e
>>>>> 2. resolve out-of-bounds transport header for non-GSO packets
>>>>> ---
>>>>>  drivers/net/geneve.c   | 174 ++++++++++++++++++++++-------------------
>>>>>  include/linux/skbuff.h |   5 ++
>>>>>  2 files changed, 98 insertions(+), 81 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>>>>> index c6563367d382..dc5f5394836a 100644
>>>>> --- a/drivers/net/geneve.c
>>>>> +++ b/drivers/net/geneve.c
>>>>> @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
>>>>>       return NULL;
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * Look for GRO hint in the genenve options; if not found or does not pass basic
>>>>> + * sanitization return 0, otherwise the offset WRT the geneve hdr start.
>>>>> + */
>>>>> +static unsigned int
>>>>> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
>>>>> +                     unsigned int *gh_len)
>>>>> +{
>>>>> +     struct geneve_opt *opt = (void *)(gh + 1);
>>>>> +     unsigned int id, opt_len = gh->opt_len;
>>>>> +     struct geneve_opt_gro_hint *gro_hint;
>>>>> +
>>>>> +     while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
>>>>> +             if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
>>>>> +                 opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
>>>>> +                 opt->length == GENEVE_OPT_GRO_HINT_LEN)
>>>>> +                     goto found;
>>>>> +
>>>>> +             /* check for bad opt len */
>>>>> +             if (opt->length + 1 >= opt_len)
>>>>> +                     return 0;
>>>>> +
>>>>> +             /* next opt */
>>>>> +             opt_len -= opt->length + 1;
>>>>> +             opt = ((void *)opt) + ((opt->length + 1) << 2);
>>>>> +     }
>>>>> +     return 0;
>>>>> +
>>>>> +found:
>>>>> +     gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
>>>>> +
>>>>> +     /*
>>>>> +      * Sanitize the hinted hdrs: the nested transport is UDP and must fit
>>>>> +      * the overall hinted hdr size.
>>>>> +      */
>>>>> +     if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
>>>>> +         gro_hint->nested_hdr_len)
>>>>> +             return 0;
>>>>> +
>>>>> +     if (gro_hint->nested_nh_offset +
>>>>> +         (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
>>>>> +                                   sizeof(struct iphdr)) >
>>>>> +         gro_hint->nested_tp_offset)
>>>>> +             return 0;
>>>>> +
>>>>> +     /* Allow only supported L2. */
>>>>> +     id = gro_hint->inner_proto_id;
>>>>> +     if (id >= ARRAY_SIZE(proto_id_map))
>>>>> +             return 0;
>>>>> +
>>>>> +     *type = proto_id_map[id];
>>>>> +     *gh_len += gro_hint->nested_hdr_len;
>>>>> +
>>>>> +     return (void *)gro_hint - (void *)gh;
>>>>> +}
>>>>> +
>>>>> +static const struct geneve_opt_gro_hint *
>>>>> +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
>>>>> +{
>>>>> +     return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
>>>>> +}
>>>>> +
>>>>> +static unsigned int
>>>>> +geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
>>>>> +                    __be16 *type, unsigned int *gh_len)
>>>>> +{
>>>>> +     const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
>>>>> +
>>>>> +     if (!gs || !gs->gro_hint)
>>>>> +             return 0;
>>>>> +     return geneve_opt_gro_hint_off(gh, type, gh_len);
>>>>> +}
>>>>> +
>>>>>  /* geneve receive/decap routine */
>>>>>  static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>>>>>                     struct sk_buff *skb, const struct genevehdr *gnvh)
>>>>> @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>>>>>       if (tun_dst)
>>>>>               skb_dst_set(skb, &tun_dst->dst);
>>>>>
>>>>> +     if (skb->encapsulation) {
>>>>> +             unsigned int len = 0, hint_off;
>>>>> +             __be16 p;
>>>>> +
>>>>> +             hint_off = geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &p, &len);
>>>>> +             if (hint_off && len <= skb_headlen(skb)) {
>>>>> +                     const struct geneve_opt_gro_hint *gro_hint;
>>>>> +
>>>>> +                     gro_hint = geneve_opt_gro_hint(gnvh, hint_off);
>>>>> +                     skb_set_transport_header(skb, gro_hint->nested_tp_offset);
>>>>> +             }
>>>>> +     } else {
>>>>> +             skb_unset_transport_header(skb);
>>>>> +     }
>>>>
>>>> It's not clear to me why the above chunk is needed.
>>>
>>> I think you understand this so i may be stating the obvious:
>>> The main motivation was to isolate the pulls from making the transport
>>> header stale
>>> IOW, geneve_hdr(skb) pointer could become "stale" if the packet's head
>>> was reallocated (because geneve_rx() is called after all the "pull"
>>> operations) - so this ensures that the inner transport header is only
>>> set after all header pulling is done - otherwise we get a UAF.
>>
>> Uhmm... my questions sparked because this patch adds quite a bit of new
>> conditionals in the data-path, which I would like to avoid them.
>>
>> But I must admit that re-reading the code - I'm likely low on coffee - I
>> don't see the UaF. This sequence:
>>
>>         pskb_may_pull(skb...)
>>         geneveh = geneve_hdr(skb);
>>
>> is correct/does not yield to UaF, and AFAICS `geneveh` is always
>> reloaded after pskb_may_pull()/iptunnel_pull_header(). Could you please
>> share a decoded stack trace for the UaF you are observing? So it's clear
>> where exactly kasan reports the problem.
>>
> 
> The only one i have is what is in the commit. Comments below..
> 
>>>> Why can't
>>>> geneve_post_decap_hint() retain the transport header set in the current
>>>> place? it would make this patch much shorter.
>>>>
>>>
>>> It was more to ensure clean state for cases where we dont have GRO hints.
>>> The "else {skb_unset_transport_header(skb);} " handles the case where
>>> we are missing GRO hints - at that point outer UDP header is stripped
>>> but tranport header is still pointing to where this outer header used
>>> to be and something down the road may misintepret the header.
>>
>> This looks like an unrelated problem?!? And possibly not a problem at
>> all?!? Upper layers (outside GSO) are expected to re-evaluate the
>> transport header as needed.
> 
> Let me provide context, maybe that will help explain or provide a way
> to fix this better.
> 
> I received multiple patches (via security) to resolve the pedit issue;
> Rajat's was the first one.
> Rajat's repro tricks geneve into having _negative transport offsets_.
> Does that trigger anything for you? geneve just trusts those headers
> are valid.
> It was not Rajat's patch that caused this splat but one of the
> multiple other reported alternative patches. I would have to dig in to
> find which patch caused the splat.
> 
> Does this help? The key i believe is looking at the effect of negative
> transport headers.

Indeed, thank you for the context! My (very) wild guess/first suspect is
that what really fixes the issue is the transport header reset.

> I can send you the repro maybe you will be able to have a better approach.

I think I already have that one. Let me try to use it and do some
experiments. Unfortunatelly it will require a little calendar time, due
to obvious EOUTOFTIME :(

/P


