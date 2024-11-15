Return-Path: <netdev+bounces-145222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189A9CDBF2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33B4B260FE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D7192D8E;
	Fri, 15 Nov 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="R3Oo6Gwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AD192D64
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664554; cv=none; b=c+Fi4p3iX9m5ymCAWAgUPY+/NQiAjYkpJw6Hk+MzvfOkndsA0E6Hh+VDBSHjl6vVLWDwSTvt0jDi7g14lsOILBbHimTfN0KhnDkTm0IhZJBFNKI7ooO+6t4SXiPNaTVYi/CFY6ZX3n2QFKczowdcPmw1nUTKgOwapxR9umsFoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664554; c=relaxed/simple;
	bh=yV9t0i2OAbdtyzVgIEVQZ5/RABRgy/1LtmNo/oxFyUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9Lc5yMMiPmrUE2Jr0xY1neP5yu8kVWQuGPngZJejAdk5gEdyD8Fquy/V/+vLo+ulv7k3iO5pnmKhYwJOenc8o3OggKSgNqljEQpcDGC7vDAJpYvXwj1EFHzgcx7GkphR4/SWZS66lc58m6d5qL8oQ6pNbID/yI9WvyuEnvLiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=R3Oo6Gwq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522c10bso229066866b.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731664550; x=1732269350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDM6dMgcaC3v448VH63QMEiug+aWbjvsWjmvgNSRweA=;
        b=R3Oo6Gwqtx4pMr+TmTFQtPPQYPooYWDWaXsvGo2X54ysmfdk/KZ/fgoKspBfQ4L39e
         E2xd0sNwS9Q/wk0nfwFq6LD2yBu0sG3KIkwJvG2PpvIHOeobxpEw1nRENVP0DEZFqnVF
         8G5fPAjf5PUMG/spzhifqF2+NsxuafOqmrv+DCY94ibVaB9VhY2iOffh7CyT/4sn3zkp
         PfuibpU+htDq6xEMbcxlFlARlz7Kx2PeaiTwpqK5smis8nfS0lIjpl0Knie5Dc4mQVrm
         Y3/kbaO1gU76YEBnV0gXwQv0NxBaLSZ6WgW+IUiY1dGVF45055ksOD3mFI1tZGoTEbrq
         QcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731664550; x=1732269350;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDM6dMgcaC3v448VH63QMEiug+aWbjvsWjmvgNSRweA=;
        b=wgPOEsDl/flY9Eu3arjY0wykB541FuRfntlhUuiUqVbT49J4EGXMQfUjTTxG/e5UVz
         0Nu4oVJWEjCfXdUXP7EJbObH94zpOhGEKA++p0ZIw+dGtZWRelmv2lDtjb3sNXK/idiK
         hMfGtgeWLnHlovdPSeXy8cTQk0cWoJ+ULu2PCQCh1hE+QtZMSfyNWnXdBIXDiVMbFfbu
         QrC1Do2W3ec98n/tLrXQwKUXvcsyjYjgIBbESHBI/Lf1bs6n7t5dl8qiKcDJyDRciI6E
         4/m5IqkeExmW9xkVdGOkpcKKIQ8ggLIAgK33i+vYQNzM74GHewfXiFAwbeatXqBw92rA
         rqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW23rD9JH3GCR5uaRcj5DvF9HRphgcGNWqO9HI/G9raNe4biwgael389O6Q2MA9ntY3M1flse4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRi3ANaCNSVzU217wxsfmpfqEUuKOnvsr+YQEvF2jfpwE7/aD
	4AgTSacjgvj+Ik5QPoKizBUzfxBH4lrZXtsh9veICCYUz3k5kmORmE2HgbzrbSI=
X-Google-Smtp-Source: AGHT+IHZzR8bnr9F+1dU3YpKAnm3Vdx9mXd1Kt96KJN2YXVxQxnkavsm2Eb1FazEBQ/yL7xWma74lQ==
X-Received: by 2002:a17:906:6a0f:b0:a9a:597:8cc9 with SMTP id a640c23a62f3a-aa4818a9875mr209386966b.12.1731664550379;
        Fri, 15 Nov 2024 01:55:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e042ed1sm161437066b.134.2024.11.15.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:55:48 -0800 (PST)
Message-ID: <466ec41a-24b7-43a9-b75f-94556785800a@openvpn.net>
Date: Fri, 15 Nov 2024 10:56:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 02/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-2-de4698c73a25@openvpn.net>
 <f35c2ec2-ef00-442d-94cd-fa695268c4f2@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <f35c2ec2-ef00-442d-94cd-fa695268c4f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 01:31, Sergey Ryazanov wrote:
[...]

>> Both UDP and TCP sockets ae supported.
> 
> s/ae/are/

ACK

> 
>> As explained above, in case of P2MP mode, OpenVPN will use the main 
>> system
>> routing table to decide which packet goes to which peer. This implies
>> that no routing table was re-implemented in the `ovpn` kernel module.
>>
>> This kernel module can be enabled by selecting the CONFIG_OVPN entry
>> in the networking drivers section.
> 
> Most of the above text has no relation to the patch itself. Should it be 
> moved to the cover letter?
> 

I think this needs to be in the git history.
We are introducing a new kernel module and this is the presentation, so 
I expect this to live in git.

This was the original text when ovpn was a 1/1 patch.
I can better clarify what this patch is doing and what comes in 
following patches, if that can help.

[...]

>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
>>         Say N here unless you know what you're doing.
>> +config OVPN
>> +    tristate "OpenVPN data channel offload"
>> +    depends on NET && INET
>> +    select NET_UDP_TUNNEL
>> +    select DST_CACHE
>> +    select CRYPTO
>> +    select CRYPTO_AES
>> +    select CRYPTO_GCM
>> +    select CRYPTO_CHACHA20POLY1305
> 
> nit: Options from NET_UDP_TUNNEL to CRYPTO_CHACHA20POLY1305 are not 
> required for changes introduced in this patch. Should they be moved to 
> corresponding patches?

Originally I wanted to introduce all deps with patch 1, but then I added 
STREAM_PARSER to the TCP patch.

I will do the same with the others and add deps only when needed.

[...]

>> +/* Driver info */
>> +#define DRV_DESCRIPTION    "OpenVPN data channel offload (ovpn)"
>> +#define DRV_COPYRIGHT    "(C) 2020-2024 OpenVPN, Inc."
> 
> nit: these strings are used only once for MODULE_{DESCRIPTION,AUTHOR} 
> below. Can we directly use strings to avoid levels of indirection?

I liked to have these defines at the top as if they were some form of 
greeting :) But I can move them down and drop the constants.

> 
>> +
>> +/**
>> + * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>> + * @dev: the interface to check
>> + *
>> + * Return: whether the netdevice is of type 'ovpn'
>> + */
>> +bool ovpn_dev_is_valid(const struct net_device *dev)
>> +{
>> +    return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
> 
> You can directly check for the ops matching saving one dereferencing 
> operation:
> 
> return dev->netdev_ops == &ovpn_netdev_ops;
> 

I see all net drivers do what you are suggesting.
Will do the same, thanks

> You can define an empty ovpn_netdev_ops struct for this purpose in this 
> patch and fill ops later with next patches. This way you can even move 
> the ovpn_net_xmit() definition to the interface creation/destruction patch.

It's a device driver, so having a placeholder xmit() in the first patch 
doesn't sound that bad :-)
And xmit is more about packet flow rather than creation/destruction.

I prefer to keep the stub here.

[...]

>> --- a/include/uapi/linux/udp.h
>> +++ b/include/uapi/linux/udp.h
>> @@ -43,5 +43,6 @@ struct udphdr {
>>   #define UDP_ENCAP_GTP1U        5 /* 3GPP TS 29.060 */
>>   #define UDP_ENCAP_RXRPC        6
>>   #define TCP_ENCAP_ESPINTCP    7 /* Yikes, this is really xfrm encap 
>> types. */
>> +#define UDP_ENCAP_OVPNINUDP    8 /* OpenVPN traffic */
> 
> nit: this specific change does not belong to this specific patch.

Right. Like for the Kconfig, I wanted to keep "general" changes and 
things that touch the rest of the kernel in this patch.

But since we are moving other things to related patches, I will also 
move this to the UDP patch.

Thanks!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


