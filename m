Return-Path: <netdev+bounces-78694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5528762A8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E0BB23868
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030A55E50;
	Fri,  8 Mar 2024 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QeuYMBtl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6E5577A
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895640; cv=none; b=tiTCKDaPFd7iTNMzxXQ/dT3H+QjtEfiTQS4XUYjkB8kzoSENxxoj93E9Daaf5l1ht/5RpkvCwFsSUFnn5kgwukwFQJ5kE1/iwnYX77lPUp+c9uE/eokNipot5pGlEk1lHHDlnTXj4hntPS1I+fSyQgbBJIFgCqmq6IRr+VG/jKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895640; c=relaxed/simple;
	bh=nQoA/CGsWy613Da9LIbVYHocsWukzagE4y+OS8CdNEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPVzMrTYaK7Gqfk4D6vSiTucQ3W7DAfo9SjW+yr81ozqg51rszaVMeDXLLfNlBaQiQWHKZl6XX9Oq6pxQuaiUQRC43UELJBhfWumXK7zvvaXRicmPSNRfvPsljz2PYaed51ET2dNT2vZcXlGA6NsyA1RmzSOx7uyW05+HGgIBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QeuYMBtl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so2342509a12.3
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709895636; x=1710500436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sinDYr6ag43N86WtOtol/lHGxZkw0LGgOOG07U08Xc0=;
        b=QeuYMBtlp+1qn2dRuliDTAxXtHW1xDJebzmlZDXCdj40AOHRUXvjVTFID61p0/GAiF
         c2lz3NlHY6CuvEoeaKoW/fE44Xox23en7k0RI8es4sd6wDTOZhGOfC9s26xsB8S9xaYn
         HSeQYTx66KL/CRkqDCOkEoH5OODM1WKyFn2yPkRGpLjruLWSKPnCJUVPZBdZzlA9cxV5
         FKTUsKwjH8nKMgt65dZJcpUKW3vmmkptKhwZNVLPyyrH/oASZLsrWq31qPKqsgOFXn77
         G25LAx4ZijtcgBDRedeK8k3aONqkZDjxj7OB5fTRLO0m52Ygy+x77Wi/k5vcdzDBxjJJ
         iSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895636; x=1710500436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sinDYr6ag43N86WtOtol/lHGxZkw0LGgOOG07U08Xc0=;
        b=ZccDOtGFcozRASHvXDjPhZHk+KXeqzcogWr9EGEYBxNKNpUZ138WNqn0uyTBY40Btl
         Th6304iWJUrskrIILCTc2rkserGD6RtlUffL7b7ymZLQfhYFBr+HUFtn6R0LyWx//FIc
         AnObZd0v4dyAWNK8iVpnkkngy5IbDQynGOwkLJN0ZcWrvAJQU8RGcY1sNJ+Ydnqli/Os
         HqTALqaf14/Np2Nf2aYyap5vgvEVQXpvwmT+K2UsCsd66fsLtvca/C+7PJt5XkLNkRT7
         XpAlyJOsG6QZCmw5Y8C4t/oyZjZOf9TNw2qUMVZjNvmEqrWArQ1OwFhwK/mI5BIw9CMC
         fDgg==
X-Gm-Message-State: AOJu0YxXG0WsZ9thDN/tRMeUhLiTAKpSO+bReX9UBHfwygVbggg3awIK
	p0Y81uH0MqMgjHAO40t0ovzougmP4vNSRRhksBvq8kecqOk9LNpGw6jYSiO5050=
X-Google-Smtp-Source: AGHT+IFejud5FBgNp6Ox3ZNpenDLDcRp4UOCa8bPEBLdR+FwFAtjjDp02VTXE6ptt3HXR2dnq6DpQg==
X-Received: by 2002:a50:d483:0:b0:566:a526:21ea with SMTP id s3-20020a50d483000000b00566a52621eamr1730368edi.33.1709895636082;
        Fri, 08 Mar 2024 03:00:36 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:b873:e280:4c85:26d8? ([2001:67c:2fbc:0:b873:e280:4c85:26d8])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b00565af2ea649sm9411496edd.14.2024.03.08.03.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 03:00:33 -0800 (PST)
Message-ID: <88c29b7e-9541-47b3-974f-04c49ce24d2c@openvpn.net>
Date: Fri, 8 Mar 2024 12:00:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
 <3ee0ece4-c612-41d5-b5b9-743a849d8aef@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <3ee0ece4-c612-41d5-b5b9-743a849d8aef@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 03:04, Andrew Lunn wrote:
>> +static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
>> +{
>> +	return kref_get_unless_zero(&peer->refcount);
>> +}
>> +
>> +static inline void ovpn_peer_put(struct ovpn_peer *peer)
>> +{
>> +	kref_put(&peer->refcount, ovpn_peer_release_kref);
>> +}
> 
> It is reasonably normal in the kernel to use _get() which takes a
> reference on something and _put() to release it.

I think I got inspired by dev_hold(), but I agree that _get() is more 
appropriate.

Will change that.

> 
>> +struct ovpn_peer *ovpn_peer_lookup_transp_addr(struct ovpn_struct *ovpn, struct sk_buff *skb);
>> +struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_buff *skb);
>> +struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb);
>> +struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);
> 
> All these look to take a reference on the peer. So maybe replace
> lookup by get? It should then be easier to check there is a matching
> put to every get.

Alright, will do!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

