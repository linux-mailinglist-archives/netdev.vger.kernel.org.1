Return-Path: <netdev+bounces-77569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC30872331
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B841F25329
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1439127B67;
	Tue,  5 Mar 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LLdUiEBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AC8595F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653963; cv=none; b=blCbcfVVW4rs4cqOxfMTJ4N17eXwso3k8PQL8BkzOVGi3PHyUy2LOE5TJeX6BUXB+Hkj7PeD4R2Lcqtt2pWSZiagc0Ts7qrPzJAZsUFg/zJIms9JRWZaNZHVnROYIc6ywBt1/1HWNgwDYzUQIv18Ef6ikwg+sXUFii5mxDkU1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653963; c=relaxed/simple;
	bh=M/gjJZkO4oXAuSoQHzsDX5MO7roYXdUjwX0oYEy9sOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWEKNb4qF5k8AZ/60rIlmoegTZzhkqN6P9hJRXwldSX6lmeQBU14qJ5J1HSZbBTsfc+sWK52zUaFAEOmqPBYFVqV7jg5HpqsanBaMo7rXYtIf2vDKfErgMicXvXn1TL2XRx+N6Lj5nZRrjlf8KsXOPfTBeE33iXud9makerB+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LLdUiEBG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5135486cfccso1016172e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709653959; x=1710258759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pS1jAzGtmjKVISIINCje7Cw5GkivCDGzJWuARn+F5qU=;
        b=LLdUiEBGsSBh85OzgJbqCHAbcBUKephfpb6UmUG/N0HOOOweu3xklVROFLstcI7gba
         pbaF9yEhHyptcxBK7Zr0Azx463HVin1/o8y6732apjDsrCOzfhkE2ICWRe6TDDHZcDfD
         32d2lCJQmOUeGZn7Xni2KPPNA3ilSs/m3E7TmDYKOlyib0EDACsR1ioBteWHtuO8KKQo
         mYqRHlGStLFe9XIB7mlFg1/7mLPMk5GepYJinIyCQ3bER5QNjdkB/DCbheMnQnGQ6WSY
         rzx3iAriOT9QNjQPZ1mrrd+EflhCFjKloUzWD04lrBeTKKex69odeSlMsA4gWB3dfkOX
         S0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653959; x=1710258759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS1jAzGtmjKVISIINCje7Cw5GkivCDGzJWuARn+F5qU=;
        b=miYye5gIpZY7kNI5z0NyjWAmb5I5Pv8+GeLvF7VfXRi/mTu5RNUic1mYNZiJE0jR5i
         U9vPR6BmQwUvky6yPjcoqHQq3q5jhN4UdF6tmNomf86hVNEx7BZ+sSytsPHczVX7z9Dj
         MSheqA0+zWHN5QlmxMJ0G1AjNRZRzQNLZJt/K7AH+Vk+wv6k+JXcrKlhWM/ifgNs14Fn
         6bqL/WkBABcrD3ApFAhnplYrwriVa6pFI4eqPcBcR9cblwSczTOStkx8+bPjRpP2zGJt
         kESqdig3KPGFnpYm8nRQNI7kjHE1Jt767cMG5mQyXXrtwoAVfgDR6ye9Ayo1Fj8gIan5
         jeQQ==
X-Gm-Message-State: AOJu0YxF4YDtTmozChnhaRC0OdytaVdgxKvM0zRd+pk2dveQBGQewf7X
	fd7WWeYdrFWVPUF2I1MCt4eCSBxzdyhPQXHZKg4SkLGOb87KC8jgepTDhEKkK7o=
X-Google-Smtp-Source: AGHT+IFpfBSlQt3DotLmYqNDA0gbz8IiOMuyl5GKUE7C1+25TyE9v0rsUjX7duFIDj7l39KjqBS/Ow==
X-Received: by 2002:a05:6512:3b84:b0:513:5883:6d0a with SMTP id g4-20020a0565123b8400b0051358836d0amr754192lfv.24.1709653959542;
        Tue, 05 Mar 2024 07:52:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:f33:beb3:62e8:b7a? ([2001:67c:2fbc:0:f33:beb3:62e8:b7a])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402500800b005648d0eebdbsm5931086eda.96.2024.03.05.07.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:52:37 -0800 (PST)
Message-ID: <b6845547-59e8-4b4e-9a8d-926bad117410@openvpn.net>
Date: Tue, 5 Mar 2024 16:52:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
 <8ca7da9c-b8c2-4368-9413-a06e7fa6713e@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <8ca7da9c-b8c2-4368-9413-a06e7fa6713e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2024 22:52, Andrew Lunn wrote:
> On Mon, Mar 04, 2024 at 04:08:57PM +0100, Antonio Quartulli wrote:
>> An ovpn_peer object holds the whole status of a remote peer
>> (regardless whether it is a server or a client).
>>
>> This includes status for crypto, tx/rx buffers, napi, etc.
>>
>> Only support for one peer is introduced (P2P mode).
>> Multi peer support is introduced with a later patch.
>>
>> Along with the ovpn_peer, also the ovpn_bind object is introcued
> 
> introduced
> 
>   > +/* Translate skb->protocol value to AF_INET or AF_INET6 */
>> +static inline unsigned short skb_protocol_to_family(const struct sk_buff *skb)
>> +{
>> +	switch (skb->protocol) {
>> +	case htons(ETH_P_IP):
>> +		return AF_INET;
>> +	case htons(ETH_P_IPV6):
>> +		return AF_INET6;
>> +	default:
>> +		return 0;
> 
> That feels like the sort of thing which should already exist
> somewhere. But a quick search did not find it...

Do you think we have a similar pattern in other drivers?
If so, it may be worth implementing this functionality in a kernel header.

Regards,


> 
> 	Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

