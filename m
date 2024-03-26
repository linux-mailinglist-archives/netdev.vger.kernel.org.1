Return-Path: <netdev+bounces-82269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3388D041
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505F81C2FC34
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023513D885;
	Tue, 26 Mar 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KjSS30Vw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4412AAF6
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489405; cv=none; b=i01NvAdeyWBMLJrXzBH+TwPOzpsHkXXiqBD1Qkk/w3X7xpmeYFEsIzJYySaUJjnNzkAoAzM5CfkPLZ606reFswv8G7Yw+HLbHAyZ/ST18BwAVWamz1G5ROTnRNFYHoe6MKf2NBeYDHmj56P22YHMLbBm2M4l6C+G8C5UHe71ouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489405; c=relaxed/simple;
	bh=pEV1hxXOAo3PKM3VoAdgR+/wC/wm3QxIdcy28/Wwrrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAOv6VArwJAIKHzbq9pK23H2shEkmOWI51JMChcyvg0elPt4sQt0URq/T5TZGPaklaM/atvt+pZj/2R28T2NPEMxbCL9vjYYh80SoOP/bqNG5BtpVxSOYI1RFLCVBYKrM8KNQEF6lrrElSbO5QjE0uIc2DX+4q8sjTtCWTKvn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KjSS30Vw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34005b5927eso4212827f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1711489402; x=1712094202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jAO3QrzOBFcf/k3Zh5hbIglynGJxd6YaZsx9czmLBkc=;
        b=KjSS30VwYNIFiauvc8QquoTKnkbn9sk9sRgtpPHvjfUC6u1lJHUZ4x8DH9DHlaCv81
         bsL5PBTnnTAZduyEbl5HbMjJ8+hDFKd0SxprQqQBYJCz5zEQwvGsSOtIEHAm+JVxF6Hd
         hdInEfRquWdSzPpINSaULhppzG0naYzIN4wrZnGoSGLQB/QuShA6KAY8OEZZorpJmSsb
         F9LCcWmIR434bRDAGEDZ6tnGeQ51uKZUNs/HGojU+P8OyrAdAiOBXJ4ULAPps51zAlmr
         vBN0QZIjJe0RyOO2wsic1BNubP5HjCUZbtB/V2QhSEB7Lv4I0T3lvVUWyNL823xwyh0J
         pttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711489402; x=1712094202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAO3QrzOBFcf/k3Zh5hbIglynGJxd6YaZsx9czmLBkc=;
        b=KCzefdLa2CVm1Eou1+9jbmFfTEIEUucH5OPyZZD11QUi62VYS6A82j6k3eaByFMCo0
         IgBvtUwY1oBCQxk2z7lPsJPse2mzZaCydqfM/IABz8ZXXv1zsfz+it/gLuWz8lYpJwQU
         XuApnh5fF8FXE2boLDP83xln9c9uYAXYQo6clhY5WOOgJ7zH9h8ot6q9qpqFW56qxIgM
         Gc0VoMarA7Zdkm5Yp1itmOfEfk0QvDsWaSTsMoazcPxbjnfqWN9AYUQzSc/7EUfa/Ecq
         nQEuJSgefIJs+LELbsj+DXu0lHluSnnJF4uj8evhXqjMDbaMQc2uWveWYHonVxPPAWOb
         lNSA==
X-Gm-Message-State: AOJu0YzHXHDZ+QxTtduMHIIh8rMtAWVj3ndaP7BA1v+yrcIAo/RU/MPr
	CqBqgm1vu5IKB3bf4cOFbqCC0emb2b28GtPyoA9nLeMw7ajxhAOOMjprpk5MftE=
X-Google-Smtp-Source: AGHT+IE+iAM2BKjTB+oRb2CjaraSb8NenLsX7oQTGc/wIeijlrEQl+c8J6pUxb6BcPqjVWmbqIp72Q==
X-Received: by 2002:a5d:68c3:0:b0:341:ba6a:6995 with SMTP id p3-20020a5d68c3000000b00341ba6a6995mr1741834wrw.47.1711489401730;
        Tue, 26 Mar 2024 14:43:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:2da8:e89c:e33f:a4e3? ([2001:67c:2fbc:0:2da8:e89c:e33f:a4e3])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00341c563aacbsm9306519wrb.1.2024.03.26.14.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:43:21 -0700 (PDT)
Message-ID: <57a773fc-dc1e-4f8b-b60b-13582e6d057c@openvpn.net>
Date: Tue, 26 Mar 2024 22:44:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/22] ovpn: implement interface
 creation/destruction via netlink
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-6-antonio@openvpn.net> <871q7yz77t.fsf@geanix.com>
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
In-Reply-To: <871q7yz77t.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2024 16:01, Esben Haabendal wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> Allow userspace to create and destroy an interface using netlink
>> commands.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 2e855ce145e7..02b41034f615 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
>>   		dev_put(ovpn->dev);
>>   }
>>   
>> +static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	enum ovpn_mode mode = OVPN_MODE_P2P;
>> +	struct net_device *dev;
>> +	char *ifname;
>> +	int ret;
>> +
>> +	if (!info->attrs[OVPN_A_IFNAME])
>> +		return -EINVAL;
>> +
>> +	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
>> +
>> +	if (info->attrs[OVPN_A_MODE]) {
>> +		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
>> +		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
>> +			   mode);
> 
> Maybe print out the message even if the default mode is used, as the
> mode is applied in ovpn_iface_create anyways.

Being this a debug message, my reasoning was "let's print what we got 
via netlink" (if nothing is printed, we know we are applying the default).

Otherwise, when printing "P2P" we wouldn't be able to understand if it 
was set by default or received via netlink.

Does it make sense?

Cheers,


> 
> /Esben

-- 
Antonio Quartulli
OpenVPN Inc.

