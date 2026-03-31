Return-Path: <netdev+bounces-273687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMYXG1/wy2m5MgYAu9opvQ
	(envelope-from <netdev+bounces-273687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:03:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3936C4F4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5CC307BF3C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992A3DDDB2;
	Tue, 31 Mar 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MijGMHyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3C1B4F1F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972641; cv=none; b=nPM0wOpJIhsLFZmUAb0B+kh9rDBU24qpSbuyYPix1caP/ZwYiYXwM5palmnO/YGf0cfUaFLKnFvuEygKWkvQm7ZP9kH4Xj7AK1hoT4mcuuLLeUWiku7K0D88Zfvk9+W3pP6we+QCGzPhtEXc5KRCVxRJ0TfmRztDF/wOs315ZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972641; c=relaxed/simple;
	bh=DPTJyCdPoCoDyneM6M0FmPPEkq/VLIbVsXLygt16p2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSav3FVMu48KgEaOL6j0eWNAJyfv6L2mtwdIu/CQV4GPpqWMWrPJIsh78vSmf9YdPB0BoWHvqtuPo8wj/IBOcWvHaNDOnMR7Lj5lshxSuoRjBAVmRMDhJCNtG96Qa4HrJ9GWK4KdmcpIF4UKNsjk7Dwf6qE0e7mPsSmaRm+MdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MijGMHyZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b91db48b8so347301f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774972638; x=1775577438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fAH9/ijaiHpMm1oeNzIuX+qfUn4bHpXAlcZlLyM+x4w=;
        b=MijGMHyZuuucvOFENEPvTn37hLIacg2LaIjUc551hDx0DfHB8PW2hzdxd7tCwDL29R
         6dhwiwkXTRFjUxqJIR44Hs632LbVD4Kc0LAhI8HbBlmqi1rw9uCP3VOcD0Y0lCCnJdfK
         UNrr2Ow+/tTAFi39wT1H5uCt7Y2S/e7I+3zXqzd1n6YsfxgVzgqurSpC8VFVBOzAedbF
         IqDJXpO1G2yvBF23iXPxIr5bjcd1MAKeuKLng/+wcvOcgMfVqKtiPJWNNQ1gA0WbCHeV
         mccjtTGstuuiT4JsBPmJsrkoAdt3s/hKBkO/RI2uuiJ/LL1n+MtQjI5yiaPenT3tGI4S
         0hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774972638; x=1775577438;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAH9/ijaiHpMm1oeNzIuX+qfUn4bHpXAlcZlLyM+x4w=;
        b=NDMRZ1Kva6TeLWYu+FERh1gwFzKyLrP8I+bPsg8xczBOcPHz06iX5qDN2VZ6biE/Kh
         8VEoqoK7l1P9mvQM+JCuDILi77QZD5k6KPgFesae/IGZ+U0aXLMj99q8BLNZAG2tZv2I
         QuogILZmmVuSXrUXNwKxBuqh53WBPWuYHsBW4CPnHI3kN2xO1nL65LzOMyRMzq6Mw7fW
         pryQAEjFQkPD/JmJdbhpicATHjmGjYzhXE7UBfPsGBUMzWju9Rcse1r6H0FjDgES7zN5
         WWHfr9bQvUaDvfSQnyP5MANf2beLyV/kHurPbs+KAdBqvbTx2vhXPwQvEBPho80PBDRG
         Aghg==
X-Forwarded-Encrypted: i=1; AJvYcCW8IfS4js7zB8iw3svqZtA55ljKZeN4V8lC6q3oDAPJl+Bcu0HgXm8VBiSld4rFYBiQqkRYczg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2rcAxy7eyon0Ua3LsWYqbbTg8tjQLg8QuG4cT/ooO463ZwjQ
	zr9OGW7rKwuuUokD22AD0WDsLEG4lsPr9I+EoWt5GNtVw0/HHbtpGbCT9GDUKiisGPY=
X-Gm-Gg: ATEYQzzYP4DmQMwEVf2bOlhCP436MarNV2KJHXccI5Dqyg/3otWz3Nc9DKDbN1tpK3z
	+qJP9SYjClypK15gqUm/3uUtD1xXVSZpGwMLdFYRwT8DjKiWm729OFy/GBESn6gHxz0tJUnMo9Q
	oT+P6CcuyeHGwtOLy5h2DyEYzxOCiL3ahBlINJuvyd0dLenoiVGFf1uyZdJAcwEXhqHUpVGEUha
	vmGVLk8qCQwzPFaEU5z2QJnvJFVx10dCrhD+G3+9VSakxv3UO2rlq23VozR+G8wjeBW1JuhTlV6
	p+FQ51i6AdNxWMUg33QnUg8rv4opDs+iDgEzdXsudK2XbBeKpwWV3Ho+R+NUv9n4SfI8cmgMSuK
	FZHPlQwMDe8VTrbAFxJd6VxkICvFG04DmPmmhQ7KOYwWIj5oUfvWNQ69Pm0lc7lg0L6jxc9rSwS
	j8+AACSSsgI1rPZpa3Q0aHuhqTuYtHbpYWaEcsp/4EEhm32Kepv4s+gSfO8yXx+CG8x/57Lgbqf
	qXH
X-Received: by 2002:a05:600c:4755:b0:486:f7fd:9d7d with SMTP id 5b1f17b1804b1-48727f2ce17mr147920015e9.3.1774972638088;
        Tue, 31 Mar 2026 08:57:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf257cbc3sm28077376f8f.35.2026.03.31.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 08:57:17 -0700 (PDT)
Message-ID: <b16b18c3-5e15-43a2-8712-cebe6ba65d12@6wind.com>
Date: Tue, 31 Mar 2026 17:57:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] seg6: enable route leak for encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Lebrun
 <david.lebrun@uclouvain.be>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, stefano.salsano@uniroma2.it,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, ahabdels@cisco.com
References: <20260327140709.959636-1-nicolas.dichtel@6wind.com>
 <20260329205846.801e8096bb8cde3eda5ed0c1@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260329205846.801e8096bb8cde3eda5ed0c1@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-273687-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7E3936C4F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 29/03/2026 à 20:58, Andrea Mayer a écrit :
> On Fri, 27 Mar 2026 15:06:24 +0100
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> The goal is to support x-vrf route. To avoid breaking existing setup, a new
>> flag is introduced: nh-vrf.
>>
>> The dev parameter is mandatory when a seg6 encap route is configured, but
>> before this commit, it is ignored/not used. After the srv6 encapsulation, a
>> second route lookup in the same vrf is performed.
>>
>> The new nh-vrf flag specifies to use the vrf associated with the dev
>> parameter to perform this second route lookup.
>>
> 
> Hi Nicolas,
>  
> thanks for looking into this. The use case is valid and limiting the
> effect of nh-vrf to routes that explicitly carry the attribute avoids
> regressions, which is good.
> 
> 
> I have a few thoughts on the nh-vrf semantics though. The attribute
> says "use the VRF of dev", but in your use case dev is not in any
> VRF, so the lookup ends up in the main table as a side effect of
> the loopback fallback, which is not obvious from the attribute
> name. Today dev is used for source address selection in
The 'no-vrf' / 'default-vrf', I don't know how to call it, is a kind of vrf. I
can try to find another name if it's clearer.
What about 'dev-context'?

> set_tun_src() and has no routing role; nh-vrf would give it one
> that does not match what actually happens.
> 
> 
>>
>> [snip]
>>
>> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> 
> This looks like a leftover from v1; since this is new UAPI on
> net-next, the Fixes tag should not be here.
Yep, I will remove it.

> 
> 
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>
>> v1 -> v2:
>>  - target net-next instead of net
>>  - add a new attribute to avoid breaking the legacy behavior
>>  - use dst_dev_rcu()
>>
>>  include/uapi/linux/seg6_iptunnel.h            |  1 +
>>  net/ipv6/seg6_iptunnel.c                      | 23 ++++++++++--
>>  .../selftests/net/srv6_end_dt46_l3vpn_test.sh | 35 +++++++++++++++++--
>>  .../selftests/net/srv6_end_dt4_l3vpn_test.sh  | 33 +++++++++++++++--
>>  .../selftests/net/srv6_end_dt6_l3vpn_test.sh  | 33 +++++++++++++++--
>>  5 files changed, 116 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
>> index 485889b19900..d7d6aa2f72c5 100644
>> --- a/include/uapi/linux/seg6_iptunnel.h
>> +++ b/include/uapi/linux/seg6_iptunnel.h
>> @@ -21,6 +21,7 @@ enum {
>>  	SEG6_IPTUNNEL_UNSPEC,
>>  	SEG6_IPTUNNEL_SRH,
>>  	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
>> +	SEG6_IPTUNNEL_NH_VRF,
>>  	__SEG6_IPTUNNEL_MAX,
>>  };
>>  #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
>> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
>> index e76cc0cc481e..f8c6f0d719be 100644
>> --- a/net/ipv6/seg6_iptunnel.c
>> +++ b/net/ipv6/seg6_iptunnel.c
>> @@ -50,6 +50,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
>>  struct seg6_lwt {
>>  	struct dst_cache cache;
>>  	struct in6_addr tunsrc;
>> +	bool nh_vrf;
>>  	struct seg6_iptunnel_encap tuninfo[];
>>  };
>>  
>> @@ -67,6 +68,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
>>  static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
>>  	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
>>  	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>> +	[SEG6_IPTUNNEL_NH_VRF]	= { .type = NLA_FLAG },
>>  };
>>  
>>  static int nla_put_srh(struct sk_buff *skb, int attrtype,
>> @@ -499,9 +501,15 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>>  	 * now and use it later as a comparison.
>>  	 */
>>  	lwtst = orig_dst->lwtstate;
>> -
>>  	slwt = seg6_lwt_lwtunnel(lwtst);
>>  
>> +	if (slwt->nh_vrf) {
>> +		rcu_read_lock();
>> +		skb->dev = l3mdev_master_dev_rcu(dst_dev_rcu(orig_dst)) ?:
>> +			dev_net(skb->dev)->loopback_dev;
>> +		rcu_read_unlock();
>> +	}
>> +
>> [snip]
>>
> 
> Overwriting skb->dev alters flowi6_iif, which affects ip rule matching
yes, this is the goal of the patch.

> on the ingress interface and changes what netfilter FORWARD sees as "in"
> device. Also, seg6_output_core() never checks nh_vrf and its fl6 is
Sure, but it enables filtering on the vrf interface. It won't break anything
because the flag doesn't exist for now.

> built without involving skb->dev, so this only works for forwarded
> traffic. These aspects would need to be addressed in any case.
Yes, I saw this. There is already a difference between the forwarding path and
the local output path. On the forwarding path, the input vrf is used for the
second route lookup. On the local output path, the 'default-vrf' is always used.
I didn't want to mix problems, so I targeted the forwarding path to start.

> 
> 
> Looking at this from a different angle, specifying the FIB table ID
> directly could be a more natural fit here. Something like
> SEG6_IPTUNNEL_TABLE (u32) with fib6_get_table() + ip6_pol_route(),
> similar to seg6_lookup_any_nexthop() in seg6_local.c.
> It would work for both input and output with no need to touch skb->dev.
> For example:
>  
>   ip -6 route add cafe::1/128 vrf vrf-100 \
>       encap seg6 mode encap segs fc00::1 lookup 254 dev veth0
> 
>  
> Beyond the semantics, a table ID is also more general: it covers
> the main table, tables associated with VRFs, and custom tables with
> the same mechanism, and keeps dev consistent with its current role
> across behaviors. I think we should explore this direction before
> moving forward. I am happy to help if you want.
My goal is to 'fix' the current behavior, not to add a new feature.
Today, the dev arg is mandatory but not used, this is misleading. The selftests
shows the inconsistency. The device of the encap route is in the 'default-vrf'
but another route in the same vrf is needed, with the same nexthop (dev).

Regards,
Nicolas

