Return-Path: <netdev+bounces-78695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FF8762BB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127161F23A9D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D655C3A;
	Fri,  8 Mar 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VpGnF9Ei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DB56748
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896026; cv=none; b=JAsgjudbzwxf/+DHaZQwRuY+3HALG0UPwRQtyzhcX3wocnSUSh5Us+lnkcEky3+LxZFUV80gMBEbqpNAfVb28pOc664/+2VhZ/vz9Bo2/vZbtvgAtoHwle6jnnCnDsk939ff3CD5LMu/jnt6tn6bCgzvrRIIVFmJiGj7zEXZi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896026; c=relaxed/simple;
	bh=MRkohaLiUN5BHehj7WGOvVOkQISIlM4qrD0qErutq8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twE7lGK5XpKb1rrY7XbGNaiwMQwPpa29oRrp0kJcsqjlPXtJ9WJBS4SoJDTeo8mK250VM4ANYGdh/nqi1Dr9g8j9cm7DbDrY6NhYAyD3jmFfKjCAJIsYAqN/4Xaqa/wCMPG5YmGUpHOvTjhHNBi546GEDEdAM5h2CJLlIyIDhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VpGnF9Ei; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-567fbbd723cso805995a12.3
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709896023; x=1710500823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ROhx7Xti2+zZ0lJ/c08/MIW8BW30JDS2gYndLq8QZ6Y=;
        b=VpGnF9EiaE1/cedpOUF/sTkhSDPELZ4v7kSyQWn30NjL79tDOPKMDJZfAizM3zwHKg
         lzNGy4D54bXoz9Jdh/BaLlw0Q0/WCF6slKDrytR/ExGBFENkQvRvHdLvqgt0Qlat0hBQ
         bKyXeEgoyuwG8UTrue7cR5gtzbzgifjRiIshiSEkhR/g+sqO4ZaQwdXR5VUO+1OTIbNG
         xCVehjlbx5mdWptTXWHZkZKeOQ8XQVYB8RovPJWSM0pJqOPANGblOlSBO4ZoFJ7Z9m8h
         kZG0uS/P2S5D6+zSj510rRTCtu+IzkVBsxDwm36JhAIklE+v3dCMrzVkxNjK1SO/2VdN
         G5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896023; x=1710500823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROhx7Xti2+zZ0lJ/c08/MIW8BW30JDS2gYndLq8QZ6Y=;
        b=wiBXBjboM0DrKaZLi8htNr4AqKlfDdtXM6yXFLNHBqFBf/D9ZdJKpPGMAT/hXXj5Ax
         fC3HQ9I4FI6vEpsNOwHt+b3cV9LIn1IupgtSfjJZmKBDX8jqA3pGnxLaGN5dnsxk2mzh
         u3ndOpR5x0l55wfBKG1fDw9PbXTecOyDegHA2QRm6KpmEaBegjJIc7spfkRQO3AC6RTv
         hf0u3KIO6bX1yImfBsXP7sswRkq0ythdz9CNkqQ6oMQeSMHRnEuv3ryLUEOwaZfTnF2p
         b/iakgJEdZ/SJSYhqNxL8NbexgAWtga6/kA8T8iaw+gUNNo0WS4Hq1zRgXpL9IWvIQUO
         8WYA==
X-Gm-Message-State: AOJu0YwFZl3fnaE7PsS/V5ZdLZOYnjIsfmFa3ocl9EBhj2uomxW0rQHT
	0fTwL51Em27oR/4SmiO2y7+Jyqr8HR0/+3vUk4H7olBtYXSydpVxihVTcX8ILsM=
X-Google-Smtp-Source: AGHT+IFmNOo+FsyLImY+hRFnRsZtrbdxFYnJLHOCisKQtFfDjdq04SXoboOaQD9AsLcfhmfyHSskUA==
X-Received: by 2002:a50:9f61:0:b0:565:bb25:bb7b with SMTP id b88-20020a509f61000000b00565bb25bb7bmr1899248edf.6.1709896022820;
        Fri, 08 Mar 2024 03:07:02 -0800 (PST)
Received: from [192.168.182.20] ([151.59.116.198])
        by smtp.gmail.com with ESMTPSA id es14-20020a056402380e00b00566d9c8e6cesm7788958edb.21.2024.03.08.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 03:07:02 -0800 (PST)
Message-ID: <28f8785d-65c3-49df-aacb-c80bc19b0a2b@openvpn.net>
Date: Fri, 8 Mar 2024 12:07:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/22] ovpn: implement basic RX path (UDP)
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-10-antonio@openvpn.net>
 <0dcf1824-5819-4280-828d-46cf5bce3527@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <0dcf1824-5819-4280-828d-46cf5bce3527@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 03:17, Andrew Lunn wrote:
>> +++ b/drivers/net/ovpn/io.c
>> @@ -53,6 +53,113 @@ int ovpn_struct_init(struct net_device *dev)
>>   	return 0;
>>   }
>>   
>> +/* Called after decrypt to write IP packet to tun netdev.
>> + * This method is expected to manage/free skb.
> 
> tun?
> 
> The userspace implementation uses tun, but being in the kernel, don't
> you just pass it to the stack?

Sorry - this is just me being used to refer to the tunnel interface as 
"tun".

Whenever you read "tun", I actually refer to the interface created by 
ovpn. This is totally unrelated to the tun module.

But I agree that this doesn't make sense for anybody other than me.

I will get rid of any word "tun" in the comments/doc.

> 
>> + */
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	/* packet integrity was verified on the VPN layer - no need to perform
>> +	 * any additional check along the stack
>> +	 */
>> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +	skb->csum_level = ~0;
>> +
>> +	/* skb hash for transport packet no longer valid after decapsulation */
>> +	skb_clear_hash(skb);
>> +
>> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto tun
>> +	 * interface, based on __skb_tunnel_rx() in dst.h
>> +	 */
>> +	skb->dev = peer->ovpn->dev;
>> +	skb_set_queue_mapping(skb, 0);
>> +	skb_scrub_packet(skb, true);
>> +
>> +	skb_reset_network_header(skb);
>> +	skb_reset_transport_header(skb);
>> +	skb_probe_transport_header(skb);
>> +	skb_reset_inner_headers(skb);
>> +
>> +	/* update per-cpu RX stats with the stored size of encrypted packet */
>> +
>> +	/* we are in softirq context - hence no locking nor disable preemption needed */
>> +	dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
>> +
>> +	/* cause packet to be "received" by tun interface */
>> +	napi_gro_receive(&peer->napi, skb);
>> +}
>> +
>> +int ovpn_napi_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct ovpn_peer *peer = container_of(napi, struct ovpn_peer, napi);
>> +	struct sk_buff *skb;
>> +	int work_done = 0;
>> +
>> +	if (unlikely(budget <= 0))
>> +		return 0;
>> +	/* this function should schedule at most 'budget' number of
>> +	 * packets for delivery to the tun interface.
> 
> More tun. Did you copy code from the tun driver?

Same as above.

Thanks for nothing those.

Regards,

> 
>       Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

