Return-Path: <netdev+bounces-126454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE70971314
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AB6283706
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A91B3734;
	Mon,  9 Sep 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Iz7LJ3ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E81B2EFA
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873313; cv=none; b=KGYpkQTOElH4BelpvINM2uKKt+KL8OTfcW9WV6y7HrVPKhGknMHdocg/V+gJp4DT3vmKaUZCN0Iito3fT9IqR3Z0+zPZ3Zwq+Xfy8gEfIeY7izkoW8rz+LlyMVANmZMo/TJslrRLqSAvXStKY8RGWlQ5Yfdl+WI7O138sbWQlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873313; c=relaxed/simple;
	bh=17LTFi4By9NXlAGprw9zetGqQh7GYP6dRr9R/wDyQdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utX1cB/ITv6C6CpQREraGk6Y/2p2Jgdk6Kp7NbO9f7Xvaoo8+TMjVVMGXec3uFVlOAL2wFx9qAIoa0YlmOmxdkw2RAxjBqCnZ9FBhS8VYIEZwnSXl4+DOFSsJ4Etgn3fZZl6vKTaj1/0ObRzBPX1ZkTZ6BcVj0yqwUwHWYKIXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Iz7LJ3ng; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so223854066b.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725873310; x=1726478110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7/eh0LVmSTxIH7dgCBqKajVm+tCHRte0OAG48K17inM=;
        b=Iz7LJ3ngP44uNvuwf+HtxJiu0Kz62sUAAsALQo69jyS6dk4MNjjWyyhuZrs+AZBZAF
         /Zs4yFQoBGw+95qQ32ViHi37wos8RIK3oO1t4QeD0HiWUO4rOVlAw/k8qtU2bg8U1CiV
         SjRUjvQw4c75ZGZZbBAcIGAI/+vcRyz5GSZpK7die9umGfvc8BVhsJyF5baquBq4Ay01
         TUOLmRYbsDf8ypL3h0O13tuzkLQK/VUIVQy8tLzxfe5i1HMwGU8aT29JdZiigOTyQ7rn
         E9Y2hATWgBvQeeuNt+16jieC5TXbAY+cIBfvMIUO6NmSIZm7s1BabfXP226z4j4XHbkC
         zFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873310; x=1726478110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/eh0LVmSTxIH7dgCBqKajVm+tCHRte0OAG48K17inM=;
        b=VdL4rP/1MT/yfTW0V5/PVmZtkuwNSzAZ7la/q62cljJoj0u1kFX68fd97LkEKfH1Au
         /CfkyGs35+DLUOvgQCQO9V1AoPtDrAALyc9pmloJa2rOFbgzRcmKOW03ShoxS4G2okAq
         ZS5/7ivc0jFKuV10fS8M2yDWmoDujSWWZhY7BywSzkMMacio7meD2TwUBvGmcLDeY/wR
         qS1fgunrsX88UcvsbVvvInli10a21cvGwkave9sxjvoU7UAHeBtBXfSSFd2lxlYtl+fF
         zW8vpYIu1zo8wiy8IeZE79H3p/PTypyHS3xUM3ZFE6LRu0QHt8ePcjVTIIvmsbrBaOhY
         69xw==
X-Gm-Message-State: AOJu0Yy4oGfmoFjvSye7kjSjiZSYG9wGlY8j/JgjBOA9gB0d+WmhQ2w0
	iUl4iBzSNowHxEClfphvRX3RomFxAiNPMzuzNb0+QRhWuI/6pEP91DUoFmVV2a8=
X-Google-Smtp-Source: AGHT+IELj43wIoOtme7B55yLBd5WjuNsuUI0mHgyU898oiPhc3PIyS3gm/e1stFevQXzOPB/wKVZOw==
X-Received: by 2002:a17:907:7243:b0:a86:842a:104a with SMTP id a640c23a62f3a-a8a888dae61mr671530666b.57.1725873309922;
        Mon, 09 Sep 2024 02:15:09 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583c20bsm311480066b.22.2024.09.09.02.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:15:09 -0700 (PDT)
Message-ID: <06406844-5d35-4e35-ae35-d34503d3549c@openvpn.net>
Date: Mon, 9 Sep 2024 11:17:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 17/25] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-18-antonio@openvpn.net> <ZtcoblYi68X8t3Bd@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtcoblYi68X8t3Bd@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 03/09/2024 17:17, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:57 +0200, Antonio Quartulli wrote:
>> +static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_struct *ovpn,
>> +					    time64_t now)
>> +{
>> +	time64_t tmp_next_run, next_run = 0;
>> +	struct hlist_node *tmp;
>> +	struct ovpn_peer *peer;
>> +	int bkt;
>> +
>> +	spin_lock_bh(&ovpn->peers->lock_by_id);
>> +	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
>> +		tmp_next_run = ovpn_peer_keepalive_work_single(peer, now);
>> +
>> +		/* the next worker run will be scheduled based on the shortest
>> +		 * required interval across all peers
>> +		 */
>> +		if (!next_run || tmp_next_run < next_run)
> 
> I think this should exclude tmp_next_run == 0.

or, for better clarity of the flow, I will add:

if (!tmp_next_run)
         continue;

since 0 explicitly means "keepalive disabled" or "no keepalive needed 
for $reasons".

> 
> If we have two peers, with the first getting a non-0 value and the 2nd
> getting 0, we'll end up with next_run = 0 on return.
> 
> If we have three peers and ovpn_peer_keepalive_work_single returns
> 12,0,42, we'll end up with 42 (after resetting to 0 on the 2nd peer),
> and we could miss sending the needed keepalive for peer 1.
> 

Absolutely. Thanks for pointing this out!

Cheers,

>> +			next_run = tmp_next_run;
>> +	}
>> +	spin_unlock_bh(&ovpn->peers->lock_by_id);
>> +
>> +	return next_run;
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.

