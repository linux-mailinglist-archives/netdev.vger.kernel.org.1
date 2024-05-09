Return-Path: <netdev+bounces-94935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8E8C108C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3976F1F217B6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B59147C85;
	Thu,  9 May 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T/xHJ2pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7344152785
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262195; cv=none; b=SguhIaUWakB5OY6pzbJjUQlrCqTRPiqz1o1fPUciYVBYh0nwJf7IkH/kuDtEnY4b0BqjYaz0/mToNn/IwEUdNcb6myGNcUeJakx/XOzRehgZIG8FX4g2aBFuWy6pTtvtMR4gNg9T0fwFhY78OFRTe5mAEvWBwvlJ21FZNIXs/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262195; c=relaxed/simple;
	bh=1LA9t6z4WmkFv8ASpRbeQrBSBl/e7GkEVsUzCVfeBmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDetj8nZPjz7UKms6y6oaSqn0+1JgH4YCjhL+SceUSoJGZFqMTyVrcuAZ5GZvZdpnud82z7Kzrd+jWfFROsWT/IvQDNzRKYqHcYSi4ujpdnRyeQO4paWCCC1/gLvws2PVHDqv0B6Jmxl/zfgoLy5FMjPHmMQ4J3gPXk2eGDiISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T/xHJ2pO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so6354695e9.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715262191; x=1715866991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cq6FDuu3HMa01vzQsz2RflABmPX1yVARHaq2rWkIufE=;
        b=T/xHJ2pO/dBsmP/fHdP3o2+aJsRsAKLyNUNQw7WagMXbVrYI5xzSxh4t4uDJq+1AkH
         Tsy/Q6X+3TsJHhVXU9MOalb8r9Igt8WxBSyKHU2SKHEuz3bx4IRhpDiYEEpQMaD3vAOO
         ls1j+Ywu6KEpofcWsW9648DSwDL4ZZAv2Qfb7r32LUJTF6bbdugHCuKcvn2pDIybllzw
         hdTm7CNmAjPspOGnXyb6DVe+3IqscNlZvNFFoPlqL5jXf2FgXRfMXlreqB86+xU4uwpC
         NNlaBSnvgT39JLp9HYgXYlwHOlRNswKB10ELjvqYBx2FKS4sOwVyKDW5ljfWZGdJ0lVP
         mJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262191; x=1715866991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq6FDuu3HMa01vzQsz2RflABmPX1yVARHaq2rWkIufE=;
        b=rqe16ihQy2YvYOTIlYDLCh6VRTAfVnauNIE+U4VF1PiNmNIXtmFlBa6m+a2nnI48uF
         iR7PO2wZMGne2SSsE/PT+9nEUykqWcnxNh+2vu+8gAzBQSpGGGvXBr4GzI8UTXEEnCoa
         7sTB+6YpXNHC0JQpG08Tnkd0BRZh0Jg50191mjKoF5hhyjppuxkRQIWlMkcxa4k19Foo
         fGfq1qw2C2+IlU7B/Z5CTazRjtYNuKw1wXRzqSSzT+lEeq4Ng0du7alDOM679ryWtb/g
         DEx89Sf6yWX2wnpy16t1ap8SZ2v3sGOixaqajvKuUtjgF9XMPc1uTAE2ZGyROKZrFbEb
         mACA==
X-Gm-Message-State: AOJu0YxLWKP70usGMXGvr1D5pJHQSg9z1LC/tc9/n8Z5VLWpSjMotWwQ
	SkPASMrkhCVMq5DNZa6v/220pAiK0XWEc/4JFYE6qJqV1uH+JAhIQU69/dAKu9s=
X-Google-Smtp-Source: AGHT+IEbvm4NUOkoWwBgprQglq6actX066iIMetNC8RD+6AN4bwcq2pJumlP/KtY69WfYgqtppaptg==
X-Received: by 2002:a05:600c:4703:b0:41a:b56c:2929 with SMTP id 5b1f17b1804b1-41f721acb23mr48915485e9.34.1715262191131;
        Thu, 09 May 2024 06:43:11 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d1fe4fsm61431645e9.22.2024.05.09.06.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:43:10 -0700 (PDT)
Message-ID: <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>
Date: Thu, 9 May 2024 15:44:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net> <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net> <ZjzJ5Hm8hHnE7LR9@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjzJ5Hm8hHnE7LR9@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 15:04, Sabrina Dubroca wrote:
[..]
>>>> +	struct workqueue_struct *events_wq;
>>>> +	struct ovpn_peer __rcu *peer;
>>>>    	struct list_head dev_list;
>>>>    };
>>>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>>>> new file mode 100644
>>>> index 000000000000..2948b7320d47
>>>> --- /dev/null
>>>> +++ b/drivers/net/ovpn/peer.c
>>> [...]
>>>> +/**
>>>> + * ovpn_peer_free - release private members and free peer object
>>>> + * @peer: the peer to free
>>>> + */
>>>> +static void ovpn_peer_free(struct ovpn_peer *peer)
>>>> +{
>>>> +	ovpn_bind_reset(peer, NULL);
>>>> +
>>>> +	WARN_ON(!__ptr_ring_empty(&peer->tx_ring));
>>>
>>> Could you pass a destructor to ptr_ring_cleanup instead of all these WARNs?
>>
>> hmm but if we remove the WARNs then we lose the possibility to catch
>> potential bugs, no? rings should definitely be empty at this point.
> 
> Ok, I haven't looked deep enough into how all the parts interact to
> understand that. The refcount bump around the tx_ring loop in
> ovpn_encrypt_work() takes care of that? Maybe worth a comment "$RING
> should be empty at this point because of XYZ" (for each of the rings).

Yeah, all piped skbs will be processed before exiting.
Ok, will add a comment.

> 
>> Or you think I should just not care and free any potentially remaining item?
> 
> Whether you WARN or not, any remaining item is going to be leaked. I'd
> go with WARN (or maybe DEBUG_NET_WARN_ON_ONCE) and free remaining
> items. It should never happen but seems easy to deal with, so why not
> handle it?

Sure, passing consume_skb as destructor to ptr_ring_cleanup should be 
enough.

> 
>>>> +void ovpn_peer_release(struct ovpn_peer *peer)
>>>> +{
>>>> +	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>>>> +}
>>>> +
>>>> +/**
>>>> + * ovpn_peer_delete_work - work scheduled to release peer in process context
>>>> + * @work: the work object
>>>> + */
>>>> +static void ovpn_peer_delete_work(struct work_struct *work)
>>>> +{
>>>> +	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>>>> +					      delete_work);
>>>> +	ovpn_peer_release(peer);
>>>
>>> Does call_rcu really need to run in process context?
>>
>> Reason for switching to process context is that we have to invoke
>> ovpn_nl_notify_del_peer (that sends a netlink event to userspace) and the
>> latter requires a reference to the peer.
> 
> I'm confused. When you say "requires a reference to the peer", do you
> mean accessing fields of the peer object? I don't see why this
> requires ovpn_nl_notify_del_peer to to run from process context.

ovpn_nl_notify_del_peer sends a netlink message to userspace and I was 
under the impression that it may block/sleep, no?
For this reason I assumed it must be executed in process context.

> 
>> For this reason I thought it would be safe to have ovpn_nl_notify_del_peer
>> and call_rcu invoked by the same context.
>>
>> If I invoke call_rcu in ovpn_peer_release_kref, how can I be sure that the
>> peer hasn't been free'd already when ovpn_nl_notify_del_peer is executed?
> 
> Put the ovpn_nl_notify_del_peer call before the call_rcu, it will
> access the peer and then once that's done call_rcu will do its job?

If ovpn_nl_notify_del_peer is allowed to run out of process context, 
then I totally agree.

Will test again.

> 
> 
>>>> +/**
>>>> + * ovpn_peer_del_p2p - delete peer from related tables in a P2P instance
>>>> + * @peer: the peer to delete
>>>> + * @reason: reason why the peer was deleted (sent to userspace)
>>>> + *
>>>> + * Return: 0 on success or a negative error code otherwise
>>>> + */
>>>> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
>>>> +			     enum ovpn_del_peer_reason reason)
>>>> +{
>>>> +	struct ovpn_peer *tmp;
>>>> +	int ret = -ENOENT;
>>>> +
>>>> +	spin_lock_bh(&peer->ovpn->lock);
>>>> +	tmp = rcu_dereference(peer->ovpn->peer);
>>>> +	if (tmp != peer)
>>>> +		goto unlock;
>>>
>>> How do we recover if all those objects got out of sync? Are we stuck
>>> with a broken peer?
>>
>> mhhh I don't fully get the scenario you are depicting.
>>
>> In P2P mode there is only peer stored (reference is saved in ovpn->peer)
>>
>> When we want to get rid of it, we invoke ovpn_peer_del_p2p().
>> The check we are performing here is just about being sure that we are
>> removing the exact peer we requested to remove (and not some other peer that
>> was still floating around for some reason).
> 
> But it's the right peer because it's the one the caller decided to get
> rid of.  How about DEBUG_NET_WARN_ON_ONCE(tmp != peer) and always
> releasing the peer?

sounds good. I should force myself to use more WARN_ON for conditions 
that are truly unexpected.

This said, I have a question regarding DEBUG_NET_WARN_ON_ONCE: it prints 
something only if CONFIG_DEBUG_NET is enabled.
Is this the case on standard desktop/server distribution? Otherwise how 
are we going to get reports from users?

> 
>>> And if this happens during interface deletion, aren't we leaking the
>>> peer memory here?
>>
>> at interface deletion we call
>>
>> ovpn_iface_destruct -> ovpn_peer_release_p2p ->
>> ovpn_peer_del_p2p(ovpn->peer)
>>
>> so at the last step we just ask to remove the very same peer that is
>> curently stored, which should just never fail.
> 
> But that's not what the test checks for. If ovpn->peer->ovpn != ovpn,
> the test in ovpn_peer_del_p2p will fail. That's "objects getting out
> of sync" in my previous email. The peer has a bogus back reference to
> its ovpn parent, but it's ovpn->peer nevertheless.
> 

Oh thanks for explaining that.

Ok, my assumption is that "ovpn->peer->ovpn != ovpn" can never be true.

Peers are created within the context of one ovpn object and are never 
exposed to other ovpns.

I hope it makes sense.

-- 
Antonio Quartulli
OpenVPN Inc.

