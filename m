Return-Path: <netdev+bounces-95887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA18C3C28
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DB42814BC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AA146A90;
	Mon, 13 May 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ffYRtbIf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01052F9B
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585751; cv=none; b=EpVHi5Y63ec3V+2E8OsPDzw216a09sj8OgyvUTr+1c6121u8hAM8ctR6e6BAROXjhwQ31af0BhNunFAE0C48lsWUgBC6/AoZiQGtFD/Bl90gMWC38T+QmPhLwZ4jXvppbVy9HOFc5Y9rq+33avFJ0m4msz1oKlH7j2/aXPSwZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585751; c=relaxed/simple;
	bh=4cIrc/E8A5ybYuhVek/cW9oEJk7CrmDN3KWg5zwhe/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4BflBOZYw9EQ3015cEzuc/EOQSQVgzRuzEv9HMJ/97tjggSB0OWMqtqn62b7l6l9QgG0Sw0QwcOihQng0xbrMMPuyPuNkfCfRFkXAzIY5V0vcIRz8ZplL/TKRABt5lOdoy2CV9RfbXn1urkRwk9SXS8X4IIazNO/Fhpeo7WKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ffYRtbIf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34da35cd01cso3720632f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715585747; x=1716190547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gxKMlAJ9xsNVzATST5iRcV5rstc1hetrsbISa0qs8VM=;
        b=ffYRtbIfYff4WHl6hm8IIzXeJF8CMoWhhq1qyr7rj//XHz8feQzzUI2ITMJw/2Nc8K
         kBFMby9FIUcKh+hJIHBBTtF27AO9a8ANQiRxHIeNrd0UCttVX/eNGVctkqySWGe9Yb7k
         FeohM3i1UMkrogB9kM2kj04DrskieE5O9wL9T8jFuhdk/K+a04YTVVa1/sueHjUJyupF
         6e44Hy6U25lbFC69LjaMDsLmxpOsSYWObJEdHq9kM0ATo5CNCQjjdJiJircB+TiEuPPP
         4/nhQsi2UA/cbxvYCVuLo2xln+coHYE2Y69oEswxe42MB8GWcVeNJbqRze6F+Nwk5zSN
         fQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585747; x=1716190547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxKMlAJ9xsNVzATST5iRcV5rstc1hetrsbISa0qs8VM=;
        b=rKhrvfS1a42wqHn9XyeN6b9ebezjBfcI1z2FySivfsHY0eGTS+/sclQih40xwJQ5VP
         /DqhgDU9gsLlg9USU8aovBwKk2DT7ZA2ZjcFoTbDwIDw24upeIsaSZEA+G45rr/kYFk8
         v9aThngimxyVmY+TfQZ7RkYbGpJbKsSA7KYIMhlt67+/EzIcSIZPxZNP61FBlhSAhhE9
         eoBHxpjII7cI0OVjA2gYGMdo3rJUL5MRBebEqjzaAXUUuUW2KD+pxsQBKA7oPLAfVrKN
         cDzR+nmzegqnPbwsW4mQ50257i8olsIhH2DvDvh0qYGiVtmyP3mZ/zCcP8gv22C73/cK
         rVrw==
X-Gm-Message-State: AOJu0YwBmQrWJ3IRuIWH7/C+cbuPgTMjQN8KLCFzCdvzw8N8r7P1qxXQ
	monl/dFkPn0vGxwvRqW9PjS1lyj4+OhIGlel1LZU2YuUBcUmZkzSvJ2eRNh0LXc=
X-Google-Smtp-Source: AGHT+IFbMmry92FhIMA9zhM4Q9v3HxUUAprWCCP+AG/XNxpzIEzwDVHGeCc/jGFYeSdCwu5UwdsMLw==
X-Received: by 2002:a5d:40c1:0:b0:34c:71d0:1151 with SMTP id ffacd0b85a97d-3504a631050mr7583867f8f.10.1715585747316;
        Mon, 13 May 2024 00:35:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a777dsm10349951f8f.50.2024.05.13.00.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:35:46 -0700 (PDT)
Message-ID: <2d707980-72d1-49d1-a9e8-f794fcc590cb@openvpn.net>
Date: Mon, 13 May 2024 09:37:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-10-antonio@openvpn.net> <ZkE2JmBCj-yJ3xYK@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkE2JmBCj-yJ3xYK@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2024 23:35, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
>> +/* send skb to connected peer, if any */
>> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb,
>> +			   struct ovpn_peer *peer)
>> +{
>> +	int ret;
>> +
>> +	if (likely(!peer))
>> +		/* retrieve peer serving the destination IP of this packet */
>> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
>> +	if (unlikely(!peer)) {
>> +		net_dbg_ratelimited("%s: no peer to send data to\n",
>> +				    ovpn->dev->name);
>> +		goto drop;
>> +	}
>> +
>> +	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
>> +	if (unlikely(ret < 0)) {
>> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n",
>> +				    peer->ovpn->dev->name);
>> +		goto drop;
>> +	}
>> +
>> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
>> +		ovpn_peer_put(peer);
> 
> I wanted to come back to this after going through the crypto patch,
> because this felt like a strange construct when I first looked at this
> patch.
> 
> Why are you using a workqueue here? Based on the kdoc for crypto_wq
> ("used to schedule crypto work that may sleep during TX/RX"), it's to
> deal with async crypto.
> 
> If so, why not use the more standard way of dealing with async crypto
> in contexts that cannot sleep, ie letting the crypto core call the
> "done" callback asynchronously? You need to do all the proper refcount
> handling, but IMO it's cleaner and simpler than this workqueue and
> ptr_ring. You can see an example of that in macsec (macsec_encrypt_*
> in drivers/net/macsec.c).

Aha! You don't know how happy I was when I found the doc describing how 
to convert the async code into sync-looking :-) With the detail that I 
had to move to a different context, as the code may want to sleep (hence 
the introduction of the workqueue).

It looks like I am little fan of WQs, while you are telling me to avoid 
them if possible.

I presume that using WQs comes with a non-negligible cost, therefore if 
we can just get things done without having to use them, then I should 
just don't.

I think I could go back to no-workqueue encrypt/decrypt.
Do you think this may have any impact on any future multi-core 
optimization? Back then I also thought that going through workers may 
make improvements in this area easier. But I could just be wrong.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

