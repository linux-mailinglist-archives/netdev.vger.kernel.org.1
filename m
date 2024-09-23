Return-Path: <netdev+bounces-129320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCB97ED3F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6FE1F21FDF
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370519922E;
	Mon, 23 Sep 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GE7InRkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F272433D6
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102208; cv=none; b=sEyUft66UYQ06GE+fEmLQEJBLCHz3KwUe9IXkOntHWD2RnTVxK6LjtdxnKEyUGIPga60txLdfy/jlXxKqaCSJuKLtBvpZ1sCbm9fog747T3WPvyHgBGowBfcc+J82K+kbe26mWUNp7hKZppTorQpuceeXb83sDlH2VosUHZ5tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102208; c=relaxed/simple;
	bh=27S5K30ZKiVk+Il4XS6xkKjJ7Xhn5A3SMCPfMAwVUb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxTdYFs2YtcpTGEOqyAWwUBk/smGRPvWMG6+r10ZIWIbfjgiYdK5UZq9ZyDw33WC3pHDFtn1jdCnoVTvSeEn1hhQar7DSO+BXDaJ/mzWUMyyf3DPGS2JbECOFfLwSFYrkrCvu+ULQwcqTdEkBYVpGdZRhB6FzJN5PJTRj7gATXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GE7InRkc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-378e5d4a80eso3359895f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727102205; x=1727707005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy27aIauyr1g1GgFXjl7fd/Snj7Jkn+t+ps3LXSWfUw=;
        b=GE7InRkc5/l2FSyei2Z6daqTSo9tb9EErjvHW4RX04t4NifU60R52YisvK7TMQhG8y
         LN4cDY0U+vQ/XqDARM8YnTlc1OvE50AHOdwdsvqaTVUY57sziuz7yhHWO3sXFc75/6Ph
         s0I7kDBEfXVnBHENKpKKmiMuRHbKuufukVEVJjvL+576imRbvIn4Pz/ohWF9Tbwfc7Zn
         HT1qUbtoyVhxi0Dhj8yTrghss15AoixCy03hJE/SyaAZK5Uvl3QZOipg8bU9Mf0DNRlu
         yfsna9/OvPKe4aXYzz6rknxxm4IBuR9wLTZRbfZGxRCA+PjL8rda0dug4/T1r0bD3oli
         E+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102205; x=1727707005;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy27aIauyr1g1GgFXjl7fd/Snj7Jkn+t+ps3LXSWfUw=;
        b=vv0OxcAEkmMm6+Fjhxy4GcNvjeB1m6p5oFFSKbAbBTYHoXEq7abvYhfjXtTgqMLSHJ
         5oo4yMGkw/Muk872RYimDUB2r4lJ8okP6od2xR72vmF/mlBJE+S57eem2D15yLePW8N1
         HwidPYYILhf87vF/ZP+Wdk3OCElNujz8KIVaMPOSnES/0qd8xFDMlH76E/SVQZhlyAls
         nFkyYxGCuSmuozn3MKayhZ2qe5oZK1EFZYAh381eiyso7aEpAtY1U4BeZ7Flkg90+rDb
         q52s7isvBNSD2uETOnJLy1c3Ue2p4rL3VM9+DMXhAI/3B/bEVTBvLFGeryLzROV53J+Q
         m8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUhAAjp2ofaQ+jPOkP6/oIcXpu6FETh/vK2PivkVmw2c3rphb/7yHe70Tdyngb8q5K1BBlHHAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJ5S0s7YE0kpYsyixQHgWb4GWMQki7x0yfP/wQImYjr0/UqmV
	wADxEO0FyeTfNyurnFL9i/l1CLO7O9iW9UwHc+F9EYeU3jVQ6/TLjuU/GuTI3IM=
X-Google-Smtp-Source: AGHT+IF9Ub7BdPv2pesV4/9veb7ilGC8otZCOEM53glYt/oxarpKh/QSYRwqCQXxWTTsqDwqW4KS8Q==
X-Received: by 2002:a5d:6e05:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-37a422c028bmr5698492f8f.28.1727102204806;
        Mon, 23 Sep 2024 07:36:44 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc? ([2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c643csm128169055e9.45.2024.09.23.07.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 07:36:44 -0700 (PDT)
Message-ID: <b3b6158e-bb8f-42cd-879c-b246300ca04c@openvpn.net>
Date: Mon, 23 Sep 2024 16:36:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 20/25] ovpn: implement peer add/dump/delete
 via netlink
To: sd@queasysnail.net
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-21-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240917010734.1905-21-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

On 17/09/2024 03:07, Antonio Quartulli wrote:
[...]
>   int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
>   {
[...]
> +	/* VPN IPs cannot be updated, because they are hashed */
> +	if (!new_peer && (attrs[OVPN_A_PEER_VPN_IPV4] ||
> +			  attrs[OVPN_A_PEER_VPN_IPV6])) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "VPN IPs cannot be updated");
> +		ret = -EINVAL;
> +		goto peer_release;
> +	}

while answering some other email I realized that right now we are 
rejecting VPN IPs updates.

The reason is (as written in the comment above) that VPN IPs are used 
for hashing the peer.

I think this barrier can be lifted if I implement the VPN IP hashing 
using hlist_nulls, as I have done for the tranport_addr in case of 
floating peers.

What do you think?
Can you see any drawback in this approach?

Doing that would allow us to remove the check above and allow userspace 
to change IP to peers at runtime.


Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.

