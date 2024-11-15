Return-Path: <netdev+bounces-145303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73669CE889
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE5D28637B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE31D4350;
	Fri, 15 Nov 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J8u15Ls3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949A1BBBE4
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683098; cv=none; b=KB3aZZnbuhh3pHzEkpMuGANaBgW7IETcB9CcCIakgR3Ig7CqaD7+2Rpl9TXhWmVre2o5oLMFyygGr1pDVOLocc0qqRptqr1lxC+JGIxEwQ6tLJWS+/+oqEJZIC/5IRNcpQE5FzfHy0+d4bkHmEJY79aD8xTKAEU3HWi6yqGtQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683098; c=relaxed/simple;
	bh=M/zjC2v8MMt9fpVVQXPTVsxDsQ+WB9x9h0E3nl9Mlxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvyVnLvSxJ6yUTUpl4RFOF59dxVexvC8evERLK2Hb8anAUYsuSPBFbysJifbLqHMHeLbMNUoIHUjVepPaVoxIMayv67U2MiHzeFKXcgOC4iA2+AMh+qzH0TQmRAuev7W9HTim1GdmmD8+RWVpFGMUKgFECFHrj2b4CcixOlEkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J8u15Ls3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1300600f8f.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731683094; x=1732287894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ywXNL2Wg3yXwb5/5rIZiURVE80M8ljEd7LOq9ImH8YI=;
        b=J8u15Ls3gA2z23XJVk2WPvC8Ksm6CK7zneyopY5MbtCUExk1ve69BpFMsaWjktnZ1b
         uiXnNKLA4nVKBt7pCJWFdE8LkxF4FQfo4D1Cf7Ax0OoboaCzkiEfeNWhcA5oiV6H7+6z
         c6ib2mLFYJhAuyHyEg6mkvEHv0PRNP/EUJq07HEFl1KJ9yDmfZEIuv5pomVLwE9i4zsB
         abbbrbl34jJlBlxQQSIiEu8p9bRC41oKsylEBa9ODjk/e9+CajT91aGW4t82X4LfxCYH
         F8EfiJWwKngjO+imrBhcLWxh4oGql7q7LAPfaNgXvafgBoUjarfXeV0pVWqyW8kM4VtJ
         035A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683094; x=1732287894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywXNL2Wg3yXwb5/5rIZiURVE80M8ljEd7LOq9ImH8YI=;
        b=HUvd9ZIZd8NUjI8gQlzG9ixrEjjP9v2Y9/IRBpdHVwOQ3VqDYA/4wZ6joU1nn26OKo
         JL+oAhTDiIaue5Jq+2Yjg6Md2lOsnFkmB0zUqWDHhTYtzhoHzcRphMajSdo4wNrfGbVA
         G5DWehkErHq38a+RHXOyH79prQvi073FWLCNAaQcqgeGn1pfWrIX9lgdvUDCfdlVGXNJ
         j/CHpsie4SR+RLcCf94eMAYhiK1iFkKAwF1HrKY+w3Uz1GCpvhjB9A22GqiDrW5GX7zm
         HDi22MEUJrwSTQKWElBzwDmQmvCgIDMhqTMTK8uRlRHPr+jKzIFzbKt1gTERX65f7e9o
         Divg==
X-Forwarded-Encrypted: i=1; AJvYcCXbw5EHMxTGhVVs4ROQkXYzYrQxbTK70GvRHjpsAVdsHkP8g4HCzAJYXUgG6MMLppoHiA0y9+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Gcn9GVfgP6aa+kS8X4H87bKQK26rFJvKLN5vA0taD1MhyyX6
	ryF6sCgVNPPkpTRAs99Ei+87jxaUKOmcPXVjm3wzacdcDyQyKZ2WW8Btt3i1l70=
X-Google-Smtp-Source: AGHT+IG+yblpOh4glEcmxospiPIgobJqIdgUH4aBe41gxx/doUSx7ZsBf33MSe8gDNmrTGtANEMVvw==
X-Received: by 2002:a5d:648a:0:b0:37d:3eec:6214 with SMTP id ffacd0b85a97d-38225aa625emr2050642f8f.50.1731683093596;
        Fri, 15 Nov 2024 07:04:53 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382224253f6sm3267149f8f.111.2024.11.15.07.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:04:52 -0800 (PST)
Message-ID: <0afdd7a2-328a-4a14-9f18-f47416041dc2@openvpn.net>
Date: Fri, 15 Nov 2024 16:05:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <3bfdd5c2-2564-4122-9e44-36ce944cba21@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <3bfdd5c2-2564-4122-9e44-36ce944cba21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 01:16, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff 
>> *skb)
>> +{
>> +    unsigned int pkt_len;
>> +
>> +    /* we can't guarantee the packet wasn't corrupted before entering 
>> the
>> +     * VPN, therefore we give other layers a chance to check that
>> +     */
>> +    skb->ip_summed = CHECKSUM_NONE;
>> +
>> +    /* skb hash for transport packet no longer valid after 
>> decapsulation */
>> +    skb_clear_hash(skb);
>> +
>> +    /* post-decrypt scrub -- prepare to inject encapsulated packet 
>> onto the
>> +     * interface, based on __skb_tunnel_rx() in dst.h
>> +     */
>> +    skb->dev = peer->ovpn->dev;
>> +    skb_set_queue_mapping(skb, 0);
>> +    skb_scrub_packet(skb, true);
>> +
>> +    skb_reset_network_header(skb);
>> +    skb_reset_transport_header(skb);
>> +    skb_probe_transport_header(skb);
>> +    skb_reset_inner_headers(skb);
>> +
>> +    memset(skb->cb, 0, sizeof(skb->cb));
>> +
>> +    /* cause packet to be "received" by the interface */
>> +    pkt_len = skb->len;
>> +    if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>> +                     skb) == NET_RX_SUCCESS))
> 
> nit: to improve readability, the packet delivery call can be composed 
> like this:
> 
>        pkt_len = skb->len;
>        res = gro_cells_receive(&peer->ovpn->gro_cells, skb);
>        if (likely(res == NET_RX_SUCCESS))
> 

hm, you don't like calls on two lines? :-)

ok, will change it.

Regards,

>> +        /* update RX stats with the size of decrypted packet */
>> +        dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>> +}

-- 
Antonio Quartulli
OpenVPN Inc.


