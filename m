Return-Path: <netdev+bounces-291621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MOBLTdsFWoBVAcAu9opvQ
	(envelope-from <netdev+bounces-291621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FD5D3A81
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF32C3045B4B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851F3B9949;
	Tue, 26 May 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ6p7JhY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cF2nCzyJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215F3CFF67
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788744; cv=none; b=EN31uXEdcqFgztEX0a7Ap8tROueBuuvYJU+mSbt4PKP1MPm3mywo86Mrkoh0D+XNSCN2kZfcIOcAggmxVii0+TkJOdJ04eGBQStrr2olO4rwyt/jnDM8/TyufaBo34YYNDqmCWmvmkgDk7JAjQsYd5ROOIs8yX/51Y8aJZXmMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788744; c=relaxed/simple;
	bh=BpmP5pIyxKOzZZqt7U1hcUbz2VjT1H6zAtvYEIyeqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdFeKl7lLIfgV5IqZAWYsVHMyqfnW5oN7K7CWs+ns+RWRvRtcjul6eO88P5JjJG9oIc3CrS6OXZwKDf9izvWKubSC7KQZbFCTRVJulBlNwtXtARD7ZUa7zKNOkU9E/6KvL9ApTaz/78I3UN4bNHY3l5tfCTYYsljOHp5MX1TOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZ6p7JhY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cF2nCzyJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779788741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSV8zFrfc5JTKclTo1Bn9H/Wy/w7YQlqN4eIQfiBwh4=;
	b=hZ6p7JhYBcYxAeHJROnBj0gZ6oXMAfXasxIin/QYz2fDwgnEmjAajmi+7Q44f+31u3L4Wk
	cbloS9S2oa85NJsYOQco+4axHEd9Fp+wf6Uc+rCkKWK/Rsqi7+iGisShmXUlk0h/JW/C10
	dH5NTlbEVz5U3jJe/SvdNVoLX8ADa8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-VZGNjGBuM6CFvMhpo6Rrog-1; Tue, 26 May 2026 05:45:39 -0400
X-MC-Unique: VZGNjGBuM6CFvMhpo6Rrog-1
X-Mimecast-MFC-AGG-ID: VZGNjGBuM6CFvMhpo6Rrog_1779788739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e79219704so72086325e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779788738; x=1780393538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSV8zFrfc5JTKclTo1Bn9H/Wy/w7YQlqN4eIQfiBwh4=;
        b=cF2nCzyJr/wZkQDI6do8UzF4NkUo8fiQBdIxErsTQqYXg6W7Aqf7CV/reTf3WzQmrc
         NFk+VqpJreFOIq3Y1GPEW62JiYxOWNhRIfYBpOSF9qkXdjte8za0NKCuzHl+w1mE0swN
         QKkSmC1viPKdc4INAoOecXmQ8wN6UB0qoi7bpbu/omgWn/raQ0qoOzqfpS/Xf/wh4+2u
         4Qe5EEcnx7q5b/j03tDcFVQ5ozNaVM3loG+BtmKj+ZVNrz3ChtVerMBuSdWBzwU+cTSY
         0G5DNr0N8YwR27yTwJ2uoGFE84LtZRtBbt7zYMAz17NRSXExiUXM/S27cIi5I4wQnYAY
         ZaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788738; x=1780393538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSV8zFrfc5JTKclTo1Bn9H/Wy/w7YQlqN4eIQfiBwh4=;
        b=YwWp/iq96McQOCRPRvPLHnp0Yj1bUW/e8xojo6Z58oQYvu9bIT+q/MnQ3KzQCnVdio
         EaE4//44IMol+CGkxZgVvbK/rOuKkz+UgHoYnjBCzYzQnABIAm2yraNz8+bErLkPH3/6
         a+Fxp4Fp/T8wbWjHPjO6TOBkCYLKZYnZzCt7ferf1/6J8wdD/V3tAbvIjT4AVxErWsxr
         a+w70QnOWTS/JRFlBKTQGI9ejscJHft6UEPt0WsWX4Z1WNQR9DuHmP0k0kJixODs+RLq
         c5YRD6rT2CKJgXBdSrwRvdhehs9Rhh44NxKMMnp1LAqQ1qqyjuygHpN9ZPoT6usD9zD1
         fzhA==
X-Forwarded-Encrypted: i=1; AFNElJ+wMElexUQWMKyx5zKRaqRLyiGG1DQHeP1swev5EpcasgkU7OlDo9noRifaqtBDbKOQwVw+yks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlwcUDh53oXSF2UMifbg26rT+q+6hFsMwychi5G20PybTpmCO
	rtDosv0hrKAiPgU8aEcxQEn30FsLe9zr+soG4PeWOzR4lNkh8E5yeWIYZ7R27kz+dGmKXlxgHSS
	qvKNYXf33dw3OhsSfY1nnGtEjy5gzxlYU4xyrb/1JWNNj5SCGf7YjwWVP7w==
X-Gm-Gg: Acq92OFecgwAWBXgM4Fw2xE/dnfxZOzZDee0S/X//1NbnQ5OqUAdkuVk/6z5nqpZ51+
	gYoIlHM7/L3t3EVmxjrlgCn060CCSszhd8WNQ3SjOJUAaWZ3G9pPWoLG6gq9ta2rqXFaEaNQ/ad
	sm6Bfc6TyRVkGzT2CRU7PUy/y6cuPfGxJmFf6IKOeQZrhtOpBiKZWAd/8mgPZiDuSdkbR7Pgdbt
	axqkMYAiK5bdxKKuM0GDSLdAB2K75XvuMPVttGHhQYPPIJv0X+Q5ED3zprOjsTJUOZl3sLMSaGj
	E5v+tQ5W/VdXonzv1m+CVanbKR1ooXi4zgzlGtDoRTIzEc0JhFgAk5McyiLS8LWCSQTPcBUUGCw
	luYY1So6Q4v3HDKCGyjGqMnTqouLps5FmtnXMhhjNxIU+c8iCYTn+kq3/Dw==
X-Received: by 2002:a05:600d:8486:10b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-4904249d1ecmr211861505e9.3.1779788738589;
        Tue, 26 May 2026 02:45:38 -0700 (PDT)
X-Received: by 2002:a05:600d:8486:10b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-4904249d1ecmr211860915e9.3.1779788737985;
        Tue, 26 May 2026 02:45:37 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045620c05sm312170795e9.14.2026.05.26.02.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 02:45:37 -0700 (PDT)
Message-ID: <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
Date: Tue, 26 May 2026 11:45:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/1] geneve: fix Use-After-Free in RX path
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, victor@mojatatu.com, andrew+netdev@lunn.ch,
 rajat.gupta@oss.qualcomm.com
References: <20260521131436.748832-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260521131436.748832-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291621-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C8FD5D3A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
> Context: This commit fixes a UAF in Geneve. The UAF component was discovered
> because it is triggered by a buggy 'pedit' action[1]. the buggy pedit uses
> skb_store_bits() and can write into shared or non-linear data without copying
> the entire skb head. The Geneve device invoking either pskb_may_pull() or
> iptunnel_pull_header() is much more likely to reallocate the skb head, freeing
> the memory pointed to by geneve's stale geneveh pointer.
> 
> Note, although the patch looks big it's mostly re-arranging functions to avoid
> forward declaration.
> 
> Sample UAF below:
> ....
> BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x3190
> Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
> 
> CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182-g0e3e91779b94 #551 PREEMPT(full)
> Workqueue: ipv6_addrconf addrconf_dad_work
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x8c/0xd0
>  print_report+0xce/0x5e0
>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? kasan_complete_mode_report_info+0x80/0x200
>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>  kasan_report+0xd6/0x110
>  ? geneve_udp_encap_recv+0x2e8c/0x3190
>  __asan_report_load1_noabort+0x18/0x20
>  geneve_udp_encap_recv+0x2e8c/0x3190
>  ? get_stack_info+0x38/0xc0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_geneve_udp_encap_recv+0x10/0x10
>  ? udp4_lib_lookup2+0x31c/0x700
>  ? __pfx_udp_ehashfn+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
>  udp_queue_rcv_one_skb+0x65e/0xd20
>  udp_queue_rcv_skb+0x142/0xb00
>  udp_unicast_rcv_skb+0xd3/0x2c0
>  udp_rcv+0x198f/0x2570
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip_protocol_deliver_rcu+0x1f8/0x3c0
>  ip_local_deliver_finish+0x362/0x5d0
> ....
> 
> [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@oss.qualcomm.com/
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1->v2 Address gemini-sashiko.
> 1. local variable "len" initialization in geneve_post_decap_hint()
>    Although doesnt contribute to the fix, it was introduced in fd0dd796576e
> 2. resolve out-of-bounds transport header for non-GSO packets
> ---
>  drivers/net/geneve.c   | 174 ++++++++++++++++++++++-------------------
>  include/linux/skbuff.h |   5 ++
>  2 files changed, 98 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index c6563367d382..dc5f5394836a 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
>  	return NULL;
>  }
>  
> +/*
> + * Look for GRO hint in the genenve options; if not found or does not pass basic
> + * sanitization return 0, otherwise the offset WRT the geneve hdr start.
> + */
> +static unsigned int
> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
> +			unsigned int *gh_len)
> +{
> +	struct geneve_opt *opt = (void *)(gh + 1);
> +	unsigned int id, opt_len = gh->opt_len;
> +	struct geneve_opt_gro_hint *gro_hint;
> +
> +	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
> +		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
> +		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
> +		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
> +			goto found;
> +
> +		/* check for bad opt len */
> +		if (opt->length + 1 >= opt_len)
> +			return 0;
> +
> +		/* next opt */
> +		opt_len -= opt->length + 1;
> +		opt = ((void *)opt) + ((opt->length + 1) << 2);
> +	}
> +	return 0;
> +
> +found:
> +	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
> +
> +	/*
> +	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
> +	 * the overall hinted hdr size.
> +	 */
> +	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
> +	    gro_hint->nested_hdr_len)
> +		return 0;
> +
> +	if (gro_hint->nested_nh_offset +
> +	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
> +				      sizeof(struct iphdr)) >
> +	    gro_hint->nested_tp_offset)
> +		return 0;
> +
> +	/* Allow only supported L2. */
> +	id = gro_hint->inner_proto_id;
> +	if (id >= ARRAY_SIZE(proto_id_map))
> +		return 0;
> +
> +	*type = proto_id_map[id];
> +	*gh_len += gro_hint->nested_hdr_len;
> +
> +	return (void *)gro_hint - (void *)gh;
> +}
> +
> +static const struct geneve_opt_gro_hint *
> +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
> +{
> +	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
> +}
> +
> +static unsigned int
> +geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
> +		       __be16 *type, unsigned int *gh_len)
> +{
> +	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
> +
> +	if (!gs || !gs->gro_hint)
> +		return 0;
> +	return geneve_opt_gro_hint_off(gh, type, gh_len);
> +}
> +
>  /* geneve receive/decap routine */
>  static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>  		      struct sk_buff *skb, const struct genevehdr *gnvh)
> @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
>  	if (tun_dst)
>  		skb_dst_set(skb, &tun_dst->dst);
>  
> +	if (skb->encapsulation) {
> +		unsigned int len = 0, hint_off;
> +		__be16 p;
> +
> +		hint_off = geneve_sk_gro_hint_off(gs->sock->sk, gnvh, &p, &len);
> +		if (hint_off && len <= skb_headlen(skb)) {
> +			const struct geneve_opt_gro_hint *gro_hint;
> +
> +			gro_hint = geneve_opt_gro_hint(gnvh, hint_off);
> +			skb_set_transport_header(skb, gro_hint->nested_tp_offset);
> +		}
> +	} else {
> +		skb_unset_transport_header(skb);
> +	}

It's not clear to me why the above chunk is needed. Why can't
geneve_post_decap_hint() retain the transport header set in the current
place? it would make this patch much shorter.

If the above is really needed, I think it would be better to move the
code around in a separate, pre-req, patch.

Thanks,

Paolo


