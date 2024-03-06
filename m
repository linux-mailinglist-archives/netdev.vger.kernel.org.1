Return-Path: <netdev+bounces-77968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36884873A85
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2645283FAE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D0134743;
	Wed,  6 Mar 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZYE/dE73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264B1EF1C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738318; cv=none; b=eMAFgNjls0Nqy92PdkXQfgffgtSbpSlPgjlowNcna2I6XY/AxGE79gU6KZdrCrlBaIC4PcD3ltmLWNQIuiZsKAHleTAUjJoYXizyLvYx9NR9aA4lN74aaifMpDMf5SXLZEB8BzSskC11lrRI1H/1XqpVhYCt4Dn+PrT9u1Teu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738318; c=relaxed/simple;
	bh=IeZX34fTGhNCkaAb+9daFZX6Ab7aBsYqym/YsG25FZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9dOh8Rpelp42wOPuk6OepI2HdgEmApjMzZBl1seoz/SRwzcA38q9SmMWtJHyhcXgR9eUD/djIpdk2nkylSquAijbz4NktIe+PHHoMDAlNfNDSkQPrl1mA1CHfPKV/ulRGy3SN3vss9UnSH6WwKjbtRdFvC4Opz/VX2dCNWKnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZYE/dE73; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso566297066b.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709738314; x=1710343114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wcHAVxbWOM5bDKGzHh09IkBa4HaQf76E0sUeVlnaLUE=;
        b=ZYE/dE73yeOMar7I+gjf7//wRHOfczre0LGvC4cMY0DUdygi+NUN9OrwmPcSy39VUH
         vGpKRe3c4ZNBREvqqSIWZpRyvofCOsTWmvTqsp0OFVN5wTKV3JpmQ1dTR67V68aU8bnJ
         iSpHJv+0p4BvtNY24JWSxAl8gGLDMGK/dGdcROrr4e+wNespFvAQnoYCJ0+/L/TD99h7
         Gl9OPnLxMRi9fhFinsuB46dAuuOzU77kzEP7f6V3TcIJ00NOzkr/ggJbyKtIpooExMxi
         aTF2OBT/8lAABdWDEqiqPuofWoaGTrpdkJfR1L3kmwHyrzFhke4d3SCYC50rukVAxO4w
         A1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738314; x=1710343114;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcHAVxbWOM5bDKGzHh09IkBa4HaQf76E0sUeVlnaLUE=;
        b=YIgFbIKFgdY4/4Dqswi5vRaJP6S+nla3H96JMKkwaQ4BtGa77vpLHalaGVqWpEztLZ
         pqdAsTps9HhI3WInYV/W9+C3DkNOI6skX3JaPs5riiih8oppwuUF+geKCY58eK+DUBu3
         LwW3rDFB0U4G09tssu77mD0GDJFp3d6/XB73IwD03cXCyDlpvTWGVOBukPIr6B2maW2z
         fxB5qjIfh5dXDVipqK2KAuAI/OguOdikFdL6Bv7bVxXHtxRbrtXu/53zUQRnOgPNTqv2
         fcRMo3KA7Wn5WQbQqU9akUef2ph//InvUjzn5d43ixpIYNIXWXKY3g7YKjS1WYVVmtXw
         2PmQ==
X-Gm-Message-State: AOJu0Yx+GSqFGK1OQh0mE2DduJvv8W2VMp/m9A5lsX/bZbTFJUDGLNDg
	rA1ygE68nfIPMHMkfbGn2/i+S0/G8tyMRujsleUpW5yuQJLaKbG0mr+x5HVVQLc=
X-Google-Smtp-Source: AGHT+IGU43D2yXdSAX3ZmpQ3Y4IPizAEGAC6YApSL8Wy8I0YncG0RCMQGEoNa/xefnHrrs5ScKqtsA==
X-Received: by 2002:a17:906:649:b0:a45:8b6d:9c92 with SMTP id t9-20020a170906064900b00a458b6d9c92mr4501778ejb.31.1709738314381;
        Wed, 06 Mar 2024 07:18:34 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906475600b00a449d6184dasm5925765ejs.6.2024.03.06.07.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:18:33 -0800 (PST)
Message-ID: <4a8aff06-2b9c-497d-a347-4568983926ea@openvpn.net>
Date: Wed, 6 Mar 2024 16:18:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-9-antonio@openvpn.net>
 <20240305114707.0276a2bc@kernel.org>
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
In-Reply-To: <20240305114707.0276a2bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 20:47, Jakub Kicinski wrote:
> On Mon,  4 Mar 2024 16:08:59 +0100 Antonio Quartulli wrote:
>> +	if (skb_is_gso(skb)) {
>> +		segments = skb_gso_segment(skb, 0);
>> +		if (IS_ERR(segments)) {
>> +			ret = PTR_ERR(segments);
>> +			net_err_ratelimited("%s: cannot segment packet: %d\n", dev->name, ret);
>> +			goto drop;
>> +		}
>> +
>> +		consume_skb(skb);
>> +		skb = segments;
>> +	}
>> +
>> +	/* from this moment on, "skb" might be a list */
>> +
>> +	__skb_queue_head_init(&skb_list);
>> +	skb_list_walk_safe(skb, curr, next) {
>> +		skb_mark_not_on_list(curr);
>> +
>> +		tmp = skb_share_check(curr, GFP_ATOMIC);
> 
> The share check needs to be before the segmentation, I think.

To be honest, I am not 100% sure.

I checked other occurrences of skb_gso_segment() and I don't see 
skb_share_check() being invoked beforehand.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

