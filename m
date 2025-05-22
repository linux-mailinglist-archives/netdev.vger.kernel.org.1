Return-Path: <netdev+bounces-192507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EFAC0299
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 04:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD93B5370
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 02:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A02E406;
	Thu, 22 May 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ASCbXq9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5AEED7
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747882013; cv=none; b=WELTdc8enS6lqiltd2F9JukzqniFJMLPKLpIvXdj7nT6WAld+6eU59b5kzQjHEv25RGtYSls8RZc9wAJbrfVjMCU1oGABZCJO2bNsI6sZ2k3x73CPwnA4Yl6C+6zF655Mh9QibqDudazjNLBtvJNLNpCxjqPDNr2EY3seOaHp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747882013; c=relaxed/simple;
	bh=cpOKncLEcpg2HYHSfgOKP3yT9Il2SdUaIH98p7AGmpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBkM8y3pPF9qBpCYXyphGEeSzXXzAOIaTKIP3qDid5xb69t93Inacvd2Qb0Ljzo8QiP25U6c4FtRlqC6BdQup4y77D3oPyOMWMviw0BB1Mxi+khsDyIj2sfLNUoPV+JMVJAwNL+YfKBfGpB8OA4De39KuiuO/SrOtq7MhuXlXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ASCbXq9X; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4766631a6a4so77709191cf.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 19:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1747882010; x=1748486810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mr71AaCtvqVBAhTVUb1SE+JNl4iJF/6unTZctVh/yws=;
        b=ASCbXq9XDtiQdFeYyrT1MJUPKH7YArUSzh99telrTZcqI9lqJGw6YxY7zLSL9MiA7D
         +EFwu+2xbazG2yCftinQMQ+4sAwkZeGQNOBwOKjynREJOeMQ6NZMueezw5ajyPs0Xqs8
         nMkXAuupKMW+4O6BFSl8KM/i8h9H0slocgwSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747882010; x=1748486810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr71AaCtvqVBAhTVUb1SE+JNl4iJF/6unTZctVh/yws=;
        b=TvpyZ+Jbk6COHAlir4OgPMPzGuVPJR3Vhre10hz936k6e4sCCCxneu7ALsdHwcB4eN
         1NuMaY9vLDk4kTHT0StVjuCoYgqbXpEMcAWPDKk4RTMaHxLqyF1b7xUo2/w89plF8XJd
         HmPMUAiifefKVxAHPZyFOfZU6JxLXRmEUz2AuYxq1vEDFDYRu/mI4zcoiNxeXGzvwXB7
         cmx5wq+oOKNoJB+WngnZNdh7rpnS2asFxOSnmMCja1xYY4Je7AK0PyLpkpddO/QFzZHx
         KoeIPYNVOVr9UVaRdThVoQj+iyqKdZ1v2qkIKoqFNG7Jw/iqd3nrzIZ/t9JasduFXdEq
         JjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUgzJurfLcv2fuM0FtCUkMFCeSCH9Rj+b1tp1r18KyCoAl3SDiyiXoKCdT+7dbBqLrczWKEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCq38BYS9K4sUguwDjOeHjdTFmg/z3eWGcQgjb3BM4asCWtsZo
	/SxOyw9m+0XYwFMVT0jkJiM3p01Bvd1Ldu03ewetZ80GBR5S3mXfSX5FrKxXl53FpQ==
X-Gm-Gg: ASbGncsd4wFAjUX+5WZEcX9kbPxcud+Yh2THIw78SpRNJYzXKLYIYUpKfkUAgsI3dhD
	8OHVHZXN4KF6ve5DgKPdCyxBWcd9QnZRzM+4TAAzJ/If5qCMpmTc8lwaDpAf9Mx81nhqHYoHjps
	+aTXSAmbmG7gyBIU+XfAsYQxJ/8Tx843hoUyCNIerIEmLsIJZHKyiVXSSENCvsFMtlI0P5p/UBw
	0Uec3fKRkBtcM46a5wPLbqeR/CX/NSl3pgDDvbSpsyfakdOL6YgI9wPzB1UvweznR5DTc9+6cB6
	xaLm+p/Pn2P44dYMS7qarrP1+NznR8qQRnj4spsX6PDQYwo6844sYiwEP0M7Mbj6E1MT+1S9uVS
	6qC1XKbjZEg==
X-Google-Smtp-Source: AGHT+IFuRfWu7GcESNkglX3O7mC2+I8q2BLk8fPkB8g39depGVD2//DFqQSONTBqv71w+N66shUz0g==
X-Received: by 2002:a05:622a:2b09:b0:494:9fce:28f7 with SMTP id d75a77b69052e-494ae349eebmr398139451cf.17.1747882010085;
        Wed, 21 May 2025 19:46:50 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-494ae3d6d84sm92828951cf.16.2025.05.21.19.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 19:46:49 -0700 (PDT)
Message-ID: <9a612b07-fe02-40d6-a1d4-7a6d1266ed18@ieee.org>
Date: Wed, 21 May 2025 21:46:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Damien_Ri=C3=A9gel?=
 <damien.riegel@silabs.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Silicon Labs Kernel Team <linux-devel@silabs.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 greybus-dev@lists.linaro.org
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
 <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
 <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/25 10:23 AM, Andrew Lunn wrote:
>> I think Andrew pulled Greybus in the discussion because there is some
>> overlap between Greybus and CPC:
>>    - Greybus has bundles and CPorts, CPC only has "endpoints", which
>>      would be the equivalent of a bundle with a single cport
>>    - discoverability of Greybus bundles/CPC endpoints by the host
>>    - multiple bundles/endpoints might coexist in the same
>>      module/CPC-enabled device
>>    - bundles/endpoints are independent from each other and each has its
>>      own dedicated driver
>>
>> Greybus goes a step further and specs some protocols like GPIO or UART.
>> CPC doesn't spec what goes over endpoints because it's geared towards
>> radio applications and as you said, it's very device/stack specific.
> 
> Is it device specific? Look at your Bluetooth implementation. I don't
> see anything device specific in it. That should work for any of the
> vendors of similar chips to yours.
> 
> For 802.15.4, Linux defines:
> 
> struct ieee802154_ops {
>          struct module   *owner;
>          int             (*start)(struct ieee802154_hw *hw);
>          void            (*stop)(struct ieee802154_hw *hw);
>          int             (*xmit_sync)(struct ieee802154_hw *hw,
>                                       struct sk_buff *skb);
>          int             (*xmit_async)(struct ieee802154_hw *hw,
>                                        struct sk_buff *skb);
>          int             (*ed)(struct ieee802154_hw *hw, u8 *level);
>          int             (*set_channel)(struct ieee802154_hw *hw, u8 page,
>                                         u8 channel);
>          int             (*set_hw_addr_filt)(struct ieee802154_hw *hw,
>                                              struct ieee802154_hw_addr_filt *filt,
>                                              unsigned long changed);
>          int             (*set_txpower)(struct ieee802154_hw *hw, s32 mbm);
>          int             (*set_lbt)(struct ieee802154_hw *hw, bool on);
>          int             (*set_cca_mode)(struct ieee802154_hw *hw,
>                                          const struct wpan_phy_cca *cca);
>          int             (*set_cca_ed_level)(struct ieee802154_hw *hw, s32 mbm);
>          int             (*set_csma_params)(struct ieee802154_hw *hw,
>                                             u8 min_be, u8 max_be, u8 retries);
>          int             (*set_frame_retries)(struct ieee802154_hw *hw,
>                                               s8 retries);
>          int             (*set_promiscuous_mode)(struct ieee802154_hw *hw,
>                                                  const bool on);
> };
> 
> Many of these are optional, but this gives an abstract representation
> of a device, which is should be possible to turn into a protocol
> talked over a transport bus like SPI or SDIO.

This is essentially how Greybus does things.  It sets
up drivers on the Linux side that translate callback
functions into Greybus operations that get performed
on target hardware on the remote module.

> This also comes back to my point of there being at least four vendors
> of devices like yours. Linux does not want four or more
> implementations of this, each 90% the same, just a different way of
> converting this structure of operations into messages over a transport
> bus.
> 
> You have to define the protocol. Mainline needs that so when the next
> vendor comes along, we can point at your protocol and say that is how
> it has to be implemented in Mainline. Make your firmware on the SoC
> understand it.  You have the advantage that you are here first, you
> get to define that protocol, but you do need to clearly define it.

I agree with all of this.

> You have listed how your implementation is similar to Greybus. You say
> what is not so great is streaming, i.e. the bulk data transfer needed
> to implement xmit_sync() and xmit_async() above. Greybus is too much
> RPC based. RPCs are actually what you want for most of the operations
> listed above, but i agree for data, in order to keep the transport
> fully loaded, you want double buffering. However, that appears to be
> possible with the current Greybus code.
> 
> gb_operation_unidirectional_timeout() says:

Yes, these are request messages that don't require a response.
The acknowledgement is about when the host *sent it*, not when
it got received.  They're rarely used but I could see them being
used this way.  Still, you might be limited to 255 or so in-flight
messages.

					-Alex

>   * Note that successful send of a unidirectional operation does not imply that
>   * the request as actually reached the remote end of the connection.
>   */
> 
> So long as you are doing your memory management correctly, i don't see
> why you cannot implement double buffering in the transport driver.
> 
> I also don't see why you cannot extend the Greybus upper API and add a
> true gb_operation_unidirectional_async() call.
> 
> You also said that lots of small transfers are inefficient, and you
> wanted to combine small high level messages into one big transport
> layer message. This is something you frequently see with USB Ethernet
> dongles. The Ethernet driver puts a number of small Ethernet packets
> into one USB URB. The USB layer itself has no idea this is going on. I
> don't see why the same cannot be done here, greybus itself does not
> need to be aware of the packet consolidation.
> 
> 	Andrew


