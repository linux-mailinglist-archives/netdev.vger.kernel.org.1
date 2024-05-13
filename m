Return-Path: <netdev+bounces-95949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED78C3E55
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B311C2130E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6EB147C8F;
	Mon, 13 May 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bRMv5IOh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE21487FF
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593601; cv=none; b=S8DpBhOZxa7gfp/XNys0tYdJz2FJydxdM31T4IwL6oIZaruH4ZJdUKGlidy/4irHkjaSrFD8jtJwv8b9RZWSrgLHkKIYGD6CFhfjSoxrDPmKn80tx4mzZgWElvFq6g0VetLRCtbx2FrHz32FWfWDpsdsfMD9tmnXtRN4cOpub28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593601; c=relaxed/simple;
	bh=6w9wc/f1teV7QysgF5MTaHI2OySQk9aLrfqFBrnYogo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACA1bu78S+OAzPTg/F+xssUEU3DjiSIUq70PCW58FbmDh0EClGK6/usfXLvx8QsrB/AYMs2Hi2JIMDGfLUYm6ITP8w/kLv5GfcRAGvdS2k6lFtxdseUyJqQe/IjlEj21D8EI2lp23xWwUzDDd1T9TVTPiIYqLiPZ32vrgRuyO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bRMv5IOh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42011507a54so8331325e9.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715593597; x=1716198397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a1x38b19wMu5qVC43ACUjn7K9wBVUR6+ePMmVHjFogc=;
        b=bRMv5IOhemN+Ae5Hezgmik7Sr0qnvKnapcMIigtFiLrlDxR+LWTbLrETeYPma95IOM
         IWQJTCKz0nC8uiRKvCPmOURnYFVJgaLWUAF+ZEnogs2rZLO3eT2U47kn1mHpUOLK3ZR1
         tDD4Rb9iD51tViyvJcmPm15Xenf3WyfwEX8cR83ffv9mGCfI4t2Yb5maKh4PqBU5qgGS
         YCyd79rf8jqkOCrrHwkvoyyDW3bFU1OAAdwLyd1naA5clKSilhLXEOzTAaEEvks0iZXy
         b9BY+dWbtFXtsD4zy4+28oZFDr2P6q+sT47I3xhJUqSfdQCuN9FUGl9ADdweVej+RjFB
         4zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715593597; x=1716198397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1x38b19wMu5qVC43ACUjn7K9wBVUR6+ePMmVHjFogc=;
        b=C86IyFTjdsKh7LfJkGklusobEV296iKRofofZmI3rPXbtZpwsxKeCW63kMddukJnrs
         0QPzvwoY0lKpGkHvKstzvi45enna/THdNQAppO8Xnw0iMe9IYdfC0k8FSPh7Psk5+/5z
         ve5UzTBLYBol1BWHUln3hawMNRATK3FTdd4QdYZrwG50+YDLmCTVr+czlzIsnDjU1C1g
         5ZwEyChThLkeYOfJQHjpyPC3fX8YWe9/cOmzy136bdvEaDbjnHhdxb++tBZ9KNhUd37d
         6ZBLpwIFnTWDCp+V7HTh6Z67CBjpPtiq69oeiRhoTJB7k7JdyLeL5hGvsxUgnqznYZYx
         EkvA==
X-Gm-Message-State: AOJu0Yy5ID+UpXJjBlHFCCK9SH+WiLt92389J9wrdAlnofZs4fHbz8g2
	NvZXdZMrV8KjFuUcYWbHv+nPPVUbwn12Y8fvy/asO17Bjj+QIganoh85E1P29ymCP7uVGEFX9GN
	6
X-Google-Smtp-Source: AGHT+IGNyWauwXp9MqYC8VmEyCxUEiq8LXWPMSzfQez2WWT8UjFnX+VVX5AjtY0KL7Gvq0WH0DVSfg==
X-Received: by 2002:a05:600c:458f:b0:418:3d59:c13a with SMTP id 5b1f17b1804b1-41fbcb4fe53mr112131685e9.9.1715593597315;
        Mon, 13 May 2024 02:46:37 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2449sm153117165e9.16.2024.05.13.02.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:46:36 -0700 (PDT)
Message-ID: <42f564cb-8a54-4ea0-b8a3-8c1f4bc3d97a@openvpn.net>
Date: Mon, 13 May 2024 11:47:56 +0200
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
 <2d707980-72d1-49d1-a9e8-f794fcc590cb@openvpn.net> <ZkHfLWPJAznta1A4@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EY5uLRwEIAME8xlSi3VYmrBJBcWB1ALDxcOqo+IQFcRR+hLVHGH/f4u9a8yUd
 BtlgZicNthCMA0keGtSYGSxJha80LakG3zyKc2uvD3rLRGnZCXfmFK+WPHZ67x2Uk0MZY/fO
 FsaMeLqi6OE9X3VL9o9rwlZuet/fA5BP7G7v0XUwc3C7Qg1yjOvcMYl1Kpf5/qD4ZTDWZoDT
 cwJ7OTcHVrFwi05BX90WNdoXuKqLKPGw+foy/XhNT/iYyuGuv5a7a1am+28KVa+Ls97yLmrq
 Zx+Zb444FCf3eTotsawnFUNwm8Vj4mGUcb+wjs7K4sfhae4WTTFKXi481/C4CwsTvKpaMq+D
 VosAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJjm4tHAhsMBQkCx+oA
 AAoJEEjwzLaPWdFMv4AP/2aoAQUOnGR8prCPTt6AYdPO2tsOlCJx/2xzalEb4O6s3kKgVgjK
 WInWSeuUXJxZigmg4mum4RTjZuAimDqEeG87xRX9wFQKALzzmi3KHlTJaVmcPJ1pZOFisPS3
 iB2JMhQZ+VXOb8cJ1hFaO3CfH129dn/SLbkHKL9reH5HKu03LQ2Fo7d1bdzjmnfvfFQptXZx
 DIszv/KHIhu32tjSfCYbGciH9NoQc18m9sCdTLuZoViL3vDSk7reDPuOdLVqD89kdc4YNJz6
 tpaYf/KEeG7i1l8EqrZeP2uKs4riuxi7ZtxskPtVfgOlgFKaeoXt/budjNLdG7tWyJJFejC4
 NlvX/BTsH72DT4sagU4roDGGF9pDvZbyKC/TpmIFHDvbqe+S+aQ/NmzVRPsi6uW4WGfFdwMj
 5QeJr3mzFACBLKfisPg/sl748TRXKuqyC5lM4/zVNNDqgn+DtN5DdiU1y/1Rmh7VQOBQKzY8
 6OiQNQ95j13w2k+N+aQh4wRKyo11+9zwsEtZ8Rkp9C06yvPpkFUcU2WuqhmrTxD9xXXszhUI
 ify06RjcfKmutBiS7jNrNWDK7nOpAP4zMYxYTD9DP03i1MqmJjR9hD+RhBiB63Rsh/UqZ8iN
 VL3XJZMQ2E9SfVWyWYLTfb0Q8c4zhhtKwyOr6wvpEpkCH6uevqKx4YC5
Organization: OpenVPN Inc.
In-Reply-To: <ZkHfLWPJAznta1A4@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 11:36, Sabrina Dubroca wrote:
> 2024-05-13, 09:37:06 +0200, Antonio Quartulli wrote:
>> On 12/05/2024 23:35, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
>>>> +/* send skb to connected peer, if any */
>>>> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb,
>>>> +			   struct ovpn_peer *peer)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (likely(!peer))
>>>> +		/* retrieve peer serving the destination IP of this packet */
>>>> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
>>>> +	if (unlikely(!peer)) {
>>>> +		net_dbg_ratelimited("%s: no peer to send data to\n",
>>>> +				    ovpn->dev->name);
>>>> +		goto drop;
>>>> +	}
>>>> +
>>>> +	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
>>>> +	if (unlikely(ret < 0)) {
>>>> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n",
>>>> +				    peer->ovpn->dev->name);
>>>> +		goto drop;
>>>> +	}
>>>> +
>>>> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
>>>> +		ovpn_peer_put(peer);
>>>
>>> I wanted to come back to this after going through the crypto patch,
>>> because this felt like a strange construct when I first looked at this
>>> patch.
>>>
>>> Why are you using a workqueue here? Based on the kdoc for crypto_wq
>>> ("used to schedule crypto work that may sleep during TX/RX"), it's to
>>> deal with async crypto.
>>>
>>> If so, why not use the more standard way of dealing with async crypto
>>> in contexts that cannot sleep, ie letting the crypto core call the
>>> "done" callback asynchronously? You need to do all the proper refcount
>>> handling, but IMO it's cleaner and simpler than this workqueue and
>>> ptr_ring. You can see an example of that in macsec (macsec_encrypt_*
>>> in drivers/net/macsec.c).
>>
>> Aha! You don't know how happy I was when I found the doc describing how to
>> convert the async code into sync-looking :-) With the detail that I had to
>> move to a different context, as the code may want to sleep (hence the
>> introduction of the workqueue).
>>
>> It looks like I am little fan of WQs, while you are telling me to avoid them
>> if possible.
> 
> I'm mainly trying to simplify the code (get rid of some ptr_rings, get
> rid of some ping-pong between functions and changes of context,
> etc). And here, I'm also trying to make it look more like other
> similar pieces of code, because I'm already familiar with a few kernel
> implementations of protocols doing crypto (macsec, ipsec, tls).

Thanks for that, you already helped me getting rid of several constructs 
that weren't really needed.

> 
>> I presume that using WQs comes with a non-negligible cost, therefore if we
>> can just get things done without having to use them, then I should just
>> don't.
> 
> If you're using AESNI for your GCM implementation, the crypto API will
> also be using a workqueue (see crypto/cryptd.c), but only when the
> crypto can't be done immediately (ie, when the FPU is already busing).

Right.

> 
> In the case of crypto accelerators, there might be benefits from
> queueing multiple requests and then letting them live their life,
> instead of waiting for each request separately. I don't have access to
> that HW so I cannot test this.
> 
>> I think I could go back to no-workqueue encrypt/decrypt.
>> Do you think this may have any impact on any future multi-core optimization?
>> Back then I also thought that going through workers may make improvements in
>> this area easier. But I could just be wrong.
> 
> Without thinking about it too deeply, the workqueue looks more like a
> bottleneck that a no-workqueue approach just wouldn't have. You would
> probably need per-CPU WQs (probably separated for encrypt and
> decrypt). cryptd_enqueue_request (crypto/cryptd.c) has an example of
> that.

Ok. Sounds like something we can re-consider later on.

Let's start by killing the wq in the current code.

Thanks for the pointers.


-- 
Antonio Quartulli
OpenVPN Inc.

