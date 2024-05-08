Return-Path: <netdev+bounces-94440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62E8BF7C5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3D11F20F13
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034973AC08;
	Wed,  8 May 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ddf6FNF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37802C6B2
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154749; cv=none; b=YX+9AWZf94MalgS0OpaAKFywhpWViuLNDrx8FfoiejdfOgz1wi47XHEPluOiN64YHfvR0Gm/8//+S1ZggOpxadqVd2r1adCKIrmTFrkY2XrIjn9GvLBlyFt08aKCZq9yRnVJv2kaSK0VDkVZfw4VXMlmeM3xRCIwhBJt/NC/edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154749; c=relaxed/simple;
	bh=B4K0UXAMt/4BMSWk205ywb3OdnMecNmmYkz6QuNJXuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLfnL4C/x2ufUIAaWq58rh+uADY8+2OhhMg0LJ6VqvgypNVVgH3XlaHCHg9+LoLkXQydZ/zCUM4uWYRQY6azqQ0eUS7n7z++6Nd4a85Bd6Gz9A+yVLbt4ZmQvXpirptKNvd24b9CX3+IbCkhm9+F4xz20/x98Ijp0VUN1XIrizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ddf6FNF2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a934ad50so931109166b.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715154746; x=1715759546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ToC+ccNVImre8PquDiUFTtuakUAIwW0nehY1L9IOo/o=;
        b=ddf6FNF2Xam1K7LwdXeJ0UQH/5l7mqSOkWiPrAALNp4srxJRDBw/pFvds8OOD3b3/f
         pZJDOQLvNwg/nQJ2Jkptr7qDlZLTdmlP7POvMI4xW5ruV9x6Ob0UUEjrR7SP2aWuMMvV
         /oi2YfjZWQ9cn6TzK7VAFQqD6CkzofozOXTJ5niQPnDVVusCT0RErXaLvRtjKgvJe7XA
         9C2sM3gum/BQTmMk/atI/NUuwrMtdVC5l/+/LioLgxUxW/VhZI0O7hHdYW0iBh3YdjxJ
         1VQHChpbbI14RjWW8eBZ7Vpaywj4XLGfMeQCRlfJY1oDntR7+rJXBF631cPfF0Fg+DHy
         QlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154746; x=1715759546;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToC+ccNVImre8PquDiUFTtuakUAIwW0nehY1L9IOo/o=;
        b=JPUmvw4QKbpcmXfBRz2bW5nyxkqgnBzL4/SQKne+qPknpfDONCigJpz4fGOXQBqBhj
         vQkhRm0OoV1r+z99XxPglarKs/p/BB/sBAu5LO1D3nBoSme1ilWOOPe7OC7SmSOJbGPw
         Z51n9ebMJky3ZsiEb3sOdmIyTTV4Rh2sy4qUA+mLU3kNOixqt6EdwHzgMWWsXzKyrxSD
         HkiKc5+XlGMMOqY5AL7WGSwjJKWDIknpx/g9N1NR8ZgBcU+DtxZVEbFns/64jCNEEqbE
         0YrvjK+ASoZ5RfNTbAKe2NeAOKENTKt0ETDQfJ4AfndGlSnQgOOpdZ+1GrKi/Q+FwPma
         +akQ==
X-Gm-Message-State: AOJu0Yz4XRlz3V3N+msZoY0RGPWHI0VB8PxO1YiMbmQy9x1kUUggIkRj
	LHwaPNNsCjfkhA5oXCtkBlOIdkUVVnhcejHbW8L/Y6JnjHU4POAv6nJdU0vQt8M=
X-Google-Smtp-Source: AGHT+IF49vF2awiSavxSivUCk6tM0jdF3UWvtO7S82F6udy6i8r1C2lyajRvgbKprGD6VMZlw0Ey0g==
X-Received: by 2002:a17:906:b7d6:b0:a59:fca5:ccaa with SMTP id a640c23a62f3a-a59fca5ce2amr96279366b.13.1715154745923;
        Wed, 08 May 2024 00:52:25 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00a59b9b1abdfsm4455701ejb.185.2024.05.08.00.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:52:25 -0700 (PDT)
Message-ID: <6e7b19fd-c8da-439d-9b9d-4dd3b6a5567d@openvpn.net>
Date: Wed, 8 May 2024 09:53:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net>
 <20240507171835.1e92cffa@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240507171835.1e92cffa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 02:18, Jakub Kicinski wrote:
> On Mon,  6 May 2024 03:16:17 +0200 Antonio Quartulli wrote:
> 
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index ad3813419c33..338e99dfe886 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -11,6 +11,26 @@
>>   #include <linux/skbuff.h>
>>   
>>   #include "io.h"
>> +#include "ovpnstruct.h"
>> +#include "netlink.h"
>> +
>> +int ovpn_struct_init(struct net_device *dev)
>> +{
>> +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	int err;
>> +
>> +	ovpn->dev = dev;
>> +
>> +	err = ovpn_nl_init(ovpn);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> 
> Set pcpu_stat_type, core will allocate for you

ok

> 
>> +	if (!dev->tstats)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
> 
>> +/**
>> + * ovpn_struct_init - Initialize the netdevice private area
>> + * @dev: the device to initialize
>> + *
>> + * Return: 0 on success or a negative error code otherwise
>> + */
>> +int ovpn_struct_init(struct net_device *dev);
> 
> Weak preference for kdoc to go with the implementation, not declaration.

oh ok - this wasn't clear.
Will move the kdoc next to the implementation.

> 
>> +static const struct net_device_ops ovpn_netdev_ops = {
>> +	.ndo_open		= ovpn_net_open,
>> +	.ndo_stop		= ovpn_net_stop,
>> +	.ndo_start_xmit		= ovpn_net_xmit,
>> +	.ndo_get_stats64        = dev_get_tstats64,
> 
> Core should count pcpu stats automatically

Thanks for pointing this out.
I see dev_get_stats() takes care of all this for us.

> 
>> +};
>> +
>>   bool ovpn_dev_is_valid(const struct net_device *dev)
>>   {
>>   	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>>   }
> 
>> +	list_add(&ovpn->dev_list, &dev_list);
>> +	rtnl_unlock();
>> +
>> +	/* turn carrier explicitly off after registration, this way state is
>> +	 * clearly defined
>> +	 */
>> +	netif_carrier_off(dev);
> 
> carrier off inside the locked section, user can call open
> immediately after unlock

ok, will move it up.


-- 
Antonio Quartulli
OpenVPN Inc.

