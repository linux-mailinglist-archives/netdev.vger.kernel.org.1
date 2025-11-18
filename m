Return-Path: <netdev+bounces-239502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA6C68D9B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6590C2AA4C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A7F33F8C7;
	Tue, 18 Nov 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NahMNgS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0A30BBA0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461589; cv=none; b=j7Eyd6DN6HAHhdqDMJW4We3U2/oVqLrX5tisRulZtTgnFCb0jwmLce12uHCLMpdDpK4x6C7WO2KyJiEfgVQd1qePBSis1WgBBzUkTYt8Ip/RihGHxEbewdqitc6KQq+OTQ9MfsimIkLlUR3ULdqKp0XJCJp8v3I/vERU/4fJYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461589; c=relaxed/simple;
	bh=oay2Y0RYtBNA35kUgmNA70K3Qe/H7tL7ZlQWPWImoU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7bTlmVIu38ykinc3MzC9bTGNS8jYlE+/GO8lI5J2z8HeDgTgP89goBhZmHHxxfA1wbxjKjGywymWyha752Q1JeLxtUQ1kucGaaQA4heOOT8uuRrKVRgSG8vR1F/SSa58z1HIT9uoElGyD7BwqEWoosgzZqjnNuv/Y8CZDYdwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NahMNgS3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b739ef3f739so322076166b.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763461581; x=1764066381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTTsu0LjJ22YPCAfK50R8FQVgllWZ9069adGRfH0gk=;
        b=NahMNgS32eTtYm08Az70NZQVJL1HpOhmWhBMO9qrC5de/9p3HEPb8ebScqLRIINdZU
         SnhKmqgDyj/0sJQFAf++6cw0G+0N4OP+D+MqD7SSYEVJLxO+3ce5v/HFlwYY37XBgLCe
         AgOkXkjssyT+ZNBxdyhktEQFGUGCjGtrDTHndvGIQzse8cktJQEUQEZMF59aav542T1D
         fJnYm5pRvUZtcvEbLYeLtqLCvmlOcpFU1K8W0nyFYM1QbB0dNp7wMghEou6eX5B7mmyZ
         yCx9L6UrN6zPSuzOceYCQRv997VzLCeejCgYvlnr7uk0URFUHp7Cb8RReDY6ncLJ3Gj4
         J4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461581; x=1764066381;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OTTsu0LjJ22YPCAfK50R8FQVgllWZ9069adGRfH0gk=;
        b=SUAVRgfivbW3T0CRCWcJB1zQ/HRnVeQljQVJbj2QRZtn3RgPrfBDmEoija6mPCU27s
         8t5xj7p9sLd4KbR4ho1AlyMfiYE62DakLZAzXwhA1NYVIzqKHKQh8nSAvsoiII4AV+hi
         zQqbYVxzQOinIMQSnRIJAYxklh5fbMMPLZZOBkvg6uUvQBybRgM/JLqrIXjQO5G+UYUY
         bv5zCRl6C9OZPl2NsoxePM1qoeYHAciMoNtm40UeuIlYgFdo+JOOGJ/ndgFG2+9/ORug
         88Q86fKrt2rmt6JahkT3HqAwgmXyRZf+UVD3TsLZvdMbqJSUF1pkn1alrb2WNAjZ1NCu
         P22Q==
X-Gm-Message-State: AOJu0YyJQaZZK7PAvAlZfSadrlO0wfQZzdrPL3/qEPrRdjnaMv8w93WP
	ChUfhc/kFJeK+7w7BgTOAy7/gGtHRAXoq5uiEJt7fn4y/P6DsBwbxV/zi8gvW2rXPvkh//VBghW
	haEZn+/pUM3eljjuImJisIX6OVm77GUFmLW74IdC4qZHDcQKAwD4=
X-Gm-Gg: ASbGncs1pw8kF5Sxwgogsfj3UXQwGiZS1137Jc35M2Owx+YpsGXv2040H3SmrrdZKQz
	YZ9X/EjtX70Aj1ZVrly5kTQE7eBbqCaxF/hGESszEb92nJJ4VYBL8eJK4jzbrCFt6OTIy7Zg/K4
	pzpORxgYtSk9UlFl4C5f3iYOIRqqEqvReRFHgX8wZOuEP9+rfcGn2+X5lsXGahfvtsZcnl/kJ6b
	nWd578Y9+rHJoIKjmdawrdE7EFYYwxery73DMw9EWQK+KqLXU1QP89jZY2wPdHYb0vVTJJDxgA+
	tez0iPe845WvaWFmWGcyLDsn9f0O2J5tMyILEu+ukGjGLLEseU+6lEK8IMq17b0gXWGDZ3okMqD
	w4IBaZb0leeUjAeZjD7m64lH/iC87wcT3fhJyjN9Q1hQV7iTvQqUY3kHxjWZauS4o1AGQB3D5iS
	VaRe/Bae75AXe9IZLiUaykio9KIV98BWNl+kg5POj0QN8iv8qnaw==
X-Google-Smtp-Source: AGHT+IFNYEFrAG7pmSV+LK/IVfb35+vI+/316e49HgB5Fw83Rsc8L3++7RCFm60Ztr1YEaF80OkYEg==
X-Received: by 2002:a17:907:989:b0:b73:5936:77fc with SMTP id a640c23a62f3a-b7367829d26mr1634736566b.13.1763461581446;
        Tue, 18 Nov 2025 02:26:21 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:63aa:7ccd:fa6e:231b? ([2001:67c:2fbc:1:63aa:7ccd:fa6e:231b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7359bfb238sm1235848566b.14.2025.11.18.02.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:26:20 -0800 (PST)
Message-ID: <819ccede-6edf-49d4-b07f-a973552e02a9@openvpn.net>
Date: Tue, 18 Nov 2025 11:26:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] ovpn: Allow IPv6 link-local addresses
 through RPF check
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-5-antonio@openvpn.net> <aRdTkDHlRi0WbsVS@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aRdTkDHlRi0WbsVS@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2025 17:06, Sabrina Dubroca wrote:
> 2025-11-11, 22:47:37 +0100, Antonio Quartulli wrote:
>> From: Ralf Lici <ralf@mandelbit.com>
>>
>> IPv6 link-local addresses are not globally routable and are therefore
>> absent in the unicast routing table. This causes legitimate packets with
>> link-local source addresses to fail standard RPF checks within ovpn.
>>
>> Introduce an exception to explicitly allow such packets as link-local
>> addresses are essential for core IPv6 link-level operations like NDP,
>> which must function correctly within the virtual tunnel interface.
> 
> Does this fix an existing bug, or does it only become a problem for
> some of the new features in that series (multipeer-to-multipeer?)? If
> this is a problem for existing use-cases, there should be a Fixes tag.
> 

Actually, after having spent more time on this patch, we realized that 
this patch is not really needed, because we can't truly route packets to 
addresses that are not known to ovpn (we wouldn't know which peer to 
send them to).

Hence this is a change that we originally thought to be needed, but 
further tests proved what I said above.

I'll drop this patch from the next PR.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


