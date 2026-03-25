Return-Path: <netdev+bounces-271563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBOmOCzrw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:03:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 681CE3265AD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DB53021EA2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67E23EA94;
	Wed, 25 Mar 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HD4kmuHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBB23D291
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445866; cv=none; b=J2eMtW/z+Hgg+T9f8X0s6AQFzoF+LaiwFMITDyLfmA0I8PdctOmUAZaYlGiz8VUKFUCeSoTqltzvutacewzNWEj1Pyi0KQjNcZxkFnB0KNfmW+oGRTwgU0rlTswZpdQ1o1DdxFiLY1CqNKsUYF9D//eM3VZw/umBSQ2AIfkY32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445866; c=relaxed/simple;
	bh=ncR5lhX/qsO2JVZYs7+Bp85yHeEaVm57g6ZMzG6QEns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iherj6508k/Rk8HTGSbQPs05VdOnfJc6reQNH56/Q9EDC5c0LS5wxqMI1xvNdxhemojFL3P+l8hkHC/BnrHDyDkK0dXK0MVjqtFpboF1CFz2uq9yryNVBsdNhqbKUHPx7iPaBPCdoP8l3DDVduGAWMAMFfd1DjTmEDxcK2+EguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HD4kmuHo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509061dab77so21477511cf.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1774445863; x=1775050663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+5YqW3fm6oigALPQ3wls8hGT97SVDJk+JdeJhpsggHE=;
        b=HD4kmuHo+jT7bXCb/jiOx8xY04kKiLbzlNbcQulLYr1R9u9jdkVBSw6aUCXcYpJQyh
         EhuyQ7qSuUNgcgLPIdM09i36j3XyAbpO+r0nKESALxMooVm/cuvVc8eMzH36MJtsDu18
         rxEPXSrXq5yB9Jmz7cYIQc5a9Sw9+L6fef6TSD0fb0D6xw+sO4Q3ZPDQzRqFZxEH9E0V
         +H891HU0wBgD5CFNHzNQ1KrS2juQw2FKeLjh6kp5ns0hzCe7INFLEd09Mk3adzC7TZ9J
         LGk6202oXxb5NUqeDoOrRlHMf1lB8IcUsHieZ10uMluxccjWmN9x70jnRYqXJHFP7It4
         T6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774445863; x=1775050663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5YqW3fm6oigALPQ3wls8hGT97SVDJk+JdeJhpsggHE=;
        b=o8PACEahotnJ+vqi43f94r6/VtVBRP89bNONb78CjyVdOG4gH3990zLFk1yUmwGOAf
         FxecTm0ZkxroF80spHe5fpMHjkGtjhXR1BaHYs5+MoVtu98lq9C6gsEJkziaGomaIOSi
         kbqTeJW40Cf+FzYIqeajvfCRclntpU/FyIBA/dTLfFhvk6Q9i7ym1BnG6xcJ/m24P8Gl
         x4pp2t5UZL9XMZcBtuvez1k5jpkqqZuCiBZ8n3GEqQ7bsXRgpiWwrxAxzJmFxoyuIA/q
         3Hk6sLLOX2nefk0SZ48uCLgTF3DlVzv8u3dpwV+ENye8bPJGpK/2E/y4v+MAeHGaurqy
         8jjQ==
X-Gm-Message-State: AOJu0YxhU/V+9XyobJBBDvBzOQsObpO+XViNl3zOB7Xjx75eBpbIrVne
	aqKjUWnea5aTw7Uy6F3jEugsPXZKbkZvBykPO1QYiLqvihbzk1xexxa6UEuCJAdcgDLGiXwisUw
	Ze1xsT4w15Cy+UcvMn466DEIwf2en7JNoEHrA7BwSKWgcFB+CUX7O0VjBrzxv3mLf
X-Gm-Gg: ATEYQzxmGxR9qWEJOu2C0Irt4gC+Ar6AcyJAYp+bxCeU84KcwZFKL0QhYnCHx6OytMY
	SjZsGfhIp675G+lEiHf+WDGGej1SVqS+gBkKC4GUU9ATV6Z1fWOuqmh1MNLeyFah2HSifsFvkVZ
	U0gA+jyF3rkzoclsoRVm3UkM6fPWmE/J72fdfKegT9WaARB14WPs0MbZ2qgY4MSGzHaVS1YTlLK
	aR8iialGMFkUCkHxmlsrJ+g4qOkiiCExeiX3OAI9yHRaYOmJjW3OUXzjR2rK8SNbBLee4LaBpfM
	NhOaFKy0vaiZQYLQ4VNqmeH7Cuo42rkTqfMnPguQn4uYnNsuqfSvpFjMYGw12VLjU5qN22b6+0b
	re6aUAkaMWKo3e0okcsNIVqeyhIndilfM+mBhjWXY/vnKaIzsfc5zqCQrpLLHmOYrae3fAkArqA
	v3NjQXSgnfzDH1NffN6MFVM6Tiq3opO84HNZJkxoTbXG4Ow0JIzqKlKU16
X-Received: by 2002:a05:622a:1e99:b0:50b:29a6:8696 with SMTP id d75a77b69052e-50b80cced67mr48052361cf.7.1774445859374;
        Wed, 25 Mar 2026 06:37:39 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b607:a944:9f53:da? ([2001:67c:2fbc:1:b607:a944:9f53:da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d04889sm136409611cf.9.2026.03.25.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 06:37:38 -0700 (PDT)
Message-ID: <9c891d6c-1064-4f35-8982-3e2dcb3290f5@openvpn.net>
Date: Wed, 25 Mar 2026 14:37:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260320100351.2283994-1-antonio@openvpn.net>
 <20260320100351.2283994-2-antonio@openvpn.net>
 <20260323184304.42c3930f@kernel.org> <20260323184543.764a903e@kernel.org>
 <acJix6cQZyqb94pA@krikkit> <20260324143006.60e7ca2e@kernel.org>
 <acMS5PU_CfOMQPtQ@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <acMS5PU_CfOMQPtQ@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271563-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 681CE3265AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

On 24/03/2026 23:40, Sabrina Dubroca wrote:
> 2026-03-24, 14:30:06 -0700, Jakub Kicinski wrote:
>> On Tue, 24 Mar 2026 11:09:11 +0100 Sabrina Dubroca wrote:
>>> -------- 8< --------
>>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>>> index c7f382437630..ebec8c2ff427 100644
>>> --- a/drivers/net/ovpn/netlink.c
>>> +++ b/drivers/net/ovpn/netlink.c
>>> @@ -90,8 +90,11 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>>>   	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
>>>   	struct ovpn_priv *ovpn = info->user_ptr[0];
>>>   
>>> -	if (ovpn)
>>> +	if (ovpn) {
>>> +		if (READ_ONCE(dev->reg_state) >= NETREG_UNREGISTERING)
>>> +			ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
>>>   		netdev_put(ovpn->dev, tracker);
>>> +	}
>>>   }
>>>   
>>>   static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
>>> -------- 8< --------
>>>
>>> This would clean up a peer that may have been added while we were
>>> starting device unregistration. We hold a reference on the device so
>>> no UAF possible, netdev_wait_allrefs_any will wait for this. If we
>>> don't have a racing peer creation, ndo_uninit takes care of the peers.
>>
>> LGTM. This or change all the write paths to check if the device is still
>> alive after taking the lock.
> 
> I think peer_new is the only relevant path here (other paths use an
> existing peer and modify/delete the peer itself or its keys while
> holding a reference), and we don't take a lock except to insert the
> peer in the ovpn instance (ie netdev)'s hashtable (or peer slot, for
> single-peer instances). I guess we could add the reg_state >=
> NETREG_UNREGISTERING check to ovpn_peer_add_{p2p,mp} and reject adding
> the peer. It seems cleaner than my ovpn_nl_post_doit() diff above.

Yeah, I like the check in ovpn_peer_add_* too.

> 
>>> Or we can call ovpn_peers_free on every NETDEV_UNREGISTER notification
>>> that netdev_wait_allrefs_any sends us (but then we don't need it in
>>> ndo_uninit).
>>
>> Hm, wouldn't we need a notification _after_ netdev_wait_allrefs_any() ?
> 
> netdev_wait_allrefs_any() will never complete if we don't clean up all
> the peers, since they hold a ref on the netdev.
> 
> But calling ovpn_peers_free on netdev_wait_allrefs_any()'s
> 
>      /* Rebroadcast unregister notification */
> 
> should clean up peers that got added while we were unregistering.

But with the check in ovpn_peer_add_*, we don't need this extra call to 
ovpn_peers_free(), right?

> 
>>> And s/cancel_delayed_work_sync/disable_delayed_work_sync/ for the
>>> keepalive_work.

ACK

Regards,

>>>
>>>
>>> LLM claims it's because of parallel_ops, I don't think this is
>>> related? It also claims this issue is only for UDP sockets (and TCP
>>> would see a UAF on the keepalive), but ovpn_peer_new always holds the
>>> ovpn netdev, so I don't think there's a difference there.
>>
>> Yup, I think the LLMs are trying to be helpful and are looking for some
>> write lock earlier in the path. As much as they are annoying I can't
>> blame them here, I feel like we try to make things lockless too often.
> 
> Well, if we want to protect against netdev removal, we have to use the
> one lock one we're trying hard to not depend on so much (rtnl)?
> At the ovpn level operations are not lockless.
> 
> The LLM found a legit race that I missed, but I'm always puzzled by
> inconsistencies like that.

-- 
Antonio Quartulli
OpenVPN Inc.


