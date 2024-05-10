Return-Path: <netdev+bounces-95554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8558C2A22
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB51C21AF3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B638DDC;
	Fri, 10 May 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DuZOsR09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F01BDC8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367380; cv=none; b=svBjhtG6MpL5N4fGaMamtBmbkLvinqsrM6PzDkvXDJ5afWU9QhGVNw4R1GbFC65T6af//65IMGK7wSddyek3852it+i5diqExJ4UjBWKVzfVqgICGnp/0hFKKT4RkytHtYQ0KPfuCfGehfyWM+XHgnVWAabWuznnG4ISntVM/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367380; c=relaxed/simple;
	bh=VK03pnvSTKi9iA8fnkMqQ4nlMLAZuISLbV0pyMWbVAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXFpKndi0RwAEi1yPHWA+AIqcqWvBvT6MgGUT9hx0wxSoeRrenbPonzJT1sk44ri0qZA3CW9AgA1kRHHLb2qq5R2r598N3cG6R8Uq6SWSzqfGkhsxAJ4Go9s1qhUxsk+uqnpnwh1TPXdOCMimsjncmC/57bvBj1JpKLCFlNT2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DuZOsR09; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59cdd185b9so614282066b.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715367376; x=1715972176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=638eMvUMs/WrEcshGPMEygcwyKYqrpQAJvz2/fdDOa8=;
        b=DuZOsR09sGBx/f5ZcoItlSjb559THcmzcX6vUTUvPyJ5I1dIV1b2G2thwPqUinnG6E
         Hrrdzsl/5JBaFk9Y+Z4D9fXBm0ZdVcXAzWxtzcdoFdUPaXx2hz9CMJaw+k75S+mVxZqG
         Je9+xVvUHs4mdFMMALxt+ONE5767r9S1rR4+VegvciFun66DBt8IQAnDh/rUlMS6vOFD
         BYOkAWk7WQQSN4TRQ8mw1MoDNXZJZc0PhlTm4Ud1IxlRmsfq9yih+eud84Ha0D8SvPXT
         +orkwVorLspDPsc2D6Ef4/k0K9273gIrTyGT6XoOtJWxYI7yer02xxYNE4Ck1NDVii+B
         PyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367376; x=1715972176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=638eMvUMs/WrEcshGPMEygcwyKYqrpQAJvz2/fdDOa8=;
        b=aeqzu9QrW9SDTUTky8FHFYj6XY8ABNsQyYTUCllwfOFIIrm0MWLVu9mWLDzp3q0+j2
         VdmJwPHKQ4B8IbjzclFNdlRq06XgDYyhZv2TE/OZaZ6+sZoVFIOwPk0ZgHdcCCqmd8qY
         QycjD8sjAchAjYBJWXLsIaeDJuR541AlCfVgT+MWmEkrQpPNvtsPXB2ZOu7/P0Z169V2
         vfV9vJGGUXm3E2oOi2iBZbYBQCUo+32/dDeS1HsOx4tjOIdpS9nZ6oUd2OiX0By2UHGj
         JBy4KR15G0nnkaHfIl2s/3bNhoTu+xAOVzQwzCipM0kAWX40OXufyZ/LmvBWUssKS+U3
         n1LQ==
X-Gm-Message-State: AOJu0Yyvk/4ccjQ4k1B0QiHxRTFyI1KkKSe/0GeSeqT9hE+QLjre6MI5
	ztJg8RVMuM6mXsyQ4i/p2B5n5Y6RC5Ri6uzxcTX/AstfAwFxm9feYhOCIXvL6ZE=
X-Google-Smtp-Source: AGHT+IG+WUQV16+waMnFfFI/+AdfUg/eEORdapDylX7a9SA+binYloVqYgX0HqzJU06fkQnL/iExpA==
X-Received: by 2002:a17:906:3499:b0:a59:c307:2a4c with SMTP id a640c23a62f3a-a5a1184583cmr536776866b.25.1715367376608;
        Fri, 10 May 2024 11:56:16 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9710:6fb0:8ed1:ded8? ([2001:67c:2fbc:0:9710:6fb0:8ed1:ded8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c6b1sm211515666b.57.2024.05.10.11.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:56:15 -0700 (PDT)
Message-ID: <9ab2bee8-2123-4401-8a82-446d9bf97316@openvpn.net>
Date: Fri, 10 May 2024 20:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
To: Andrew Lunn <andrew@lunn.ch>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net> <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net> <ZjzJ5Hm8hHnE7LR9@hog>
 <50385582-d0ae-4288-8435-8db5f5f69a13@lunn.ch>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <50385582-d0ae-4288-8435-8db5f5f69a13@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 15:24, Andrew Lunn wrote:
> On Thu, May 09, 2024 at 03:04:36PM +0200, Sabrina Dubroca wrote:
>> 2024-05-08, 22:31:51 +0200, Antonio Quartulli wrote:
>>> On 08/05/2024 18:06, Sabrina Dubroca wrote:
>>>> 2024-05-06, 03:16:20 +0200, Antonio Quartulli wrote:
>>>>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
>>>>> index ee05b8a2c61d..b79d4f0474b0 100644
>>>>> --- a/drivers/net/ovpn/ovpnstruct.h
>>>>> +++ b/drivers/net/ovpn/ovpnstruct.h
>>>>> @@ -17,12 +17,19 @@
>>>>>     * @dev: the actual netdev representing the tunnel
>>>>>     * @registered: whether dev is still registered with netdev or not
>>>>>     * @mode: device operation mode (i.e. p2p, mp, ..)
>>>>> + * @lock: protect this object
>>>>> + * @event_wq: used to schedule generic events that may sleep and that need to be
>>>>> + *            performed outside of softirq context
>>>>> + * @peer: in P2P mode, this is the only remote peer
>>>>>     * @dev_list: entry for the module wide device list
>>>>>     */
>>>>>    struct ovpn_struct {
>>>>>    	struct net_device *dev;
>>>>>    	bool registered;
>>>>>    	enum ovpn_mode mode;
>>>>> +	spinlock_t lock; /* protect writing to the ovpn_struct object */
>>>>
>>>> nit: the comment isn't really needed since you have kdoc saying the same thing
>>>
>>> True, but checkpatch.pl (or some other script?) was still throwing a
>>> warning, therefore I added this comment to silence it.
>>
>> Ok, then I guess the comment (and the other one below) can stay. That
>> sounds like a checkpatch.pl bug.
> 
> I suspect it is more complex than that. checkpatch does not understand
> kdoc. It just knows the rule that there should be a comment next to a
> lock, hopefully indicating what the lock protects. In order to fix
> this, checkpatch would need to somehow invoke the kdoc parser, and ask
> it if the lock has kdoc documentation.
> 
> I suspect we are just going to have to live with this.

since we are now requiring new code to always have kdoc, can't we just 
drop the checkpatch warning?

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

