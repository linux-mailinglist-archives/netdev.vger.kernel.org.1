Return-Path: <netdev+bounces-94950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C708C1146
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3921F23059
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F51E48B;
	Thu,  9 May 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dqPoz8LE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18211BC37
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265298; cv=none; b=AuAFMOfEV66odUSN/bzfcVLXpagohS6t4e6LA+pwr1hF0Hd3+1hSMcXV+PDhslWIXtb+bCRConjlqQ7d8jL/YP7falocbe3bVTPjarvKNOIGifCequcDHkR0+Y/J1EwatpPzAxVSvrrFXEEAfFBID9q2FPgIbP1fKBp8vdp00t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265298; c=relaxed/simple;
	bh=gBsX7NZXK/OzhsadDrlj2lehPbGiM/5/I8YPFqYGW0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/5cv8lTlG3W0mdWWmLiL8lKlFgByIOw1Ul946D0p82Tzxi+Y6Zt5EXEN5FuvQwTho1gKvlx0LrOyDt0zVvsUO7tw456YDVgheuaDz4OMdD4yDeZeextDOV0w3y7OlKs++7qa7BfZ/3dB1XwhQabnfPFkxlzEYLyABK9LKiiEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dqPoz8LE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so771533f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715265294; x=1715870094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D/G6CzPcZQ2Ak5cd1WzHMsx+sdnC43WX8JteP/sbt3k=;
        b=dqPoz8LEWaS/G4ywrn4q/FY9UrEYYwOt57M5TY3VBFvum5ZRYND3i/NAi7KGbY4kf1
         FnelrH7eK35142YfKw1+dfqXqSQxfao+D8khYxCCgV0K3zsaOfahfHx8GieMYO5Gq5Mp
         8PHUPj8pAmCAOita6XWqlB3ifLBoXX+sBDyeeBFman3f6IW7HVXf/0tDHDWAM5VgSEH0
         cD1anjE6ljZ3pD+yOPqfpIIJNKZtzH3dVk+ANcj2AE+stGSkPXaiOC5fDgPqHX4aiqeq
         TcrYD/+xb3LRkkCFCWMti0cV7+YbzC1r2453R2LSM/9Y6ZzYaKtGktHHRsbjIpg4GoKE
         nfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265294; x=1715870094;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/G6CzPcZQ2Ak5cd1WzHMsx+sdnC43WX8JteP/sbt3k=;
        b=tofXtSGjiboSCF4szQB9GIaxFZAbMHYK0gM4SajMlVL8iw57jKo3VDXiAqda2tF/VR
         S5zMurAuUGMcUqyrp5EP0yF7Ujp1LCQZenFc5w1gPL8tky+78FyWHSUaGoNqp/TR7L2L
         tivWuG48Tgs6VldSPAK6BgSfhBgrX5aFGYZjRvlWZJBuZJqebl7P5n4qVve14UK8WoNA
         GdxWA38+OeztJdr/v0dSlxPS9y/ASfSDNpbV+/hgltnb90DiMDbthvPE5s3C5nXt51Mr
         NrJ28khCHy/+CXSbWduOJ0aSJc6u+ThtFoLs1hyNjD+3sH7ZCAAEbakSdirdg7y2OLvU
         eIWA==
X-Gm-Message-State: AOJu0Yy8wM2MHRR2SH+Wa9/WHbuN8HyKpEJa1D764XUvkhnObhF+12pD
	AKLQOwaMz6IoYnPNb4fGfrhOcZ29hKB20Dcmz2UO6HkuhniVUjd00VDKetouCCxbhiMzT7Qv04W
	k
X-Google-Smtp-Source: AGHT+IFCaReI7zkBNmOlXwFo794rJVNeO6bHg7qgn3W71Y2jxZBSWX+ztg2CLVLKWqM/tO8DB40W3Q==
X-Received: by 2002:a5d:5288:0:b0:34d:a159:48e6 with SMTP id ffacd0b85a97d-34fc9893babmr4725138f8f.0.1715265294086;
        Thu, 09 May 2024 07:34:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbc56b7sm1840146f8f.114.2024.05.09.07.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 07:34:53 -0700 (PDT)
Message-ID: <04558c43-6b7d-4076-a6eb-d60222a292fc@openvpn.net>
Date: Thu, 9 May 2024 16:36:09 +0200
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
 <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net> <ZjzbDpEW5iVqW8oA@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjzbDpEW5iVqW8oA@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 16:17, Sabrina Dubroca wrote:
> 2024-05-09, 15:44:26 +0200, Antonio Quartulli wrote:
>> On 09/05/2024 15:04, Sabrina Dubroca wrote:
>>>>>> +void ovpn_peer_release(struct ovpn_peer *peer)
>>>>>> +{
>>>>>> +	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * ovpn_peer_delete_work - work scheduled to release peer in process context
>>>>>> + * @work: the work object
>>>>>> + */
>>>>>> +static void ovpn_peer_delete_work(struct work_struct *work)
>>>>>> +{
>>>>>> +	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>>>>>> +					      delete_work);
>>>>>> +	ovpn_peer_release(peer);
>>>>>
>>>>> Does call_rcu really need to run in process context?
>>>>
>>>> Reason for switching to process context is that we have to invoke
>>>> ovpn_nl_notify_del_peer (that sends a netlink event to userspace) and the
>>>> latter requires a reference to the peer.
>>>
>>> I'm confused. When you say "requires a reference to the peer", do you
>>> mean accessing fields of the peer object? I don't see why this
>>> requires ovpn_nl_notify_del_peer to to run from process context.
>>
>> ovpn_nl_notify_del_peer sends a netlink message to userspace and I was under
>> the impression that it may block/sleep, no?
>> For this reason I assumed it must be executed in process context.
> 
> With s/GFP_KERNEL/GFP_ATOMIC/, it should be ok to run from whatever
> context. Firing up a workqueue just to send a 100B netlink message
> seems a bit overkill.

Oh ok, I thought the send could be a problem too.

Will test with GFP_ATOMIC then. Thanks for the hint.

> 
> 
> 
>> This said, I have a question regarding DEBUG_NET_WARN_ON_ONCE: it prints
>> something only if CONFIG_DEBUG_NET is enabled.
>> Is this the case on standard desktop/server distribution? Otherwise how are
>> we going to get reports from users?
> 
> That's pretty much why I'm suggesting to use it. For those things that
> should really never happen, I think letting developers find them
> during testing (or syzbot when it gets to your driver) is enough. I'm
> not convinced getting a stack trace from a user without any ability to
> reproduce is that useful.
> 
> But if you or someone else really want some WARN_ONs, I can live with
> that.

I would personally prefer to keep the WARN_ON.

Since these bogus conditions may have consequences, users will open 
report in any case.
Having some extra text that they can post for us to contextualize the 
issue may be useful.

> 
>>>>> And if this happens during interface deletion, aren't we leaking the
>>>>> peer memory here?
>>>>
>>>> at interface deletion we call
>>>>
>>>> ovpn_iface_destruct -> ovpn_peer_release_p2p ->
>>>> ovpn_peer_del_p2p(ovpn->peer)
>>>>
>>>> so at the last step we just ask to remove the very same peer that is
>>>> curently stored, which should just never fail.
>>>
>>> But that's not what the test checks for. If ovpn->peer->ovpn != ovpn,
>>> the test in ovpn_peer_del_p2p will fail. That's "objects getting out
>>> of sync" in my previous email. The peer has a bogus back reference to
>>> its ovpn parent, but it's ovpn->peer nevertheless.
>>>
>>
>> Oh thanks for explaining that.
>>
>> Ok, my assumption is that "ovpn->peer->ovpn != ovpn" can never be true.
>>
>> Peers are created within the context of one ovpn object and are never
>> exposed to other ovpns.
>>
>> I hope it makes sense.
> 
> Ok, so this would indicate that something has gone badly wrong. Is it
> really worth checking for that (or maybe just during development)?
> 

A peer is created in ovpn_nl_set_peer_doit(), where the ovpn object is 
used to first assign peer->ovpn and then to store the peer in its own 
members. This all happens in one call and the value of ovpn can't be 
switched.

Anyway, bugs hide where we are most confident that things cannot go 
wrong :) So I'll still add a WARN_ON, just in case.

Thanks

-- 
Antonio Quartulli
OpenVPN Inc.

