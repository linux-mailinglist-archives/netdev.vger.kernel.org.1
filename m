Return-Path: <netdev+bounces-148904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B359E360C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E3EB34F7C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC7F198E90;
	Wed,  4 Dec 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WZ8XdoOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D3197A9F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301764; cv=none; b=MKSrOE+wLmN2W3TnT+fGJT65ic0pF2B1V1CMuU9JIM+lQMY0gEivMdjVwPpYKGmYFSdOaP+a9C6uCNHof7HpSI0qgL6ZP2TvKeW6drUpm2A0ImN7tNI0/HXczDLxJ0PlrpSJSK7jzIbooFejZptQVIdPQe5LWCofiHY9Qf3b6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301764; c=relaxed/simple;
	bh=fjEvVtLccharBw3OrDrLgtyYjXSAEgcWSb1bNawUsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ2IVZl67GCyAd9WwrxVtV4k7l/YpVLIzkgWEKp1steeZhY2BSEYEsvx80Ki2XLcM0LN6kH2F/j8nclCP+Z1lg6RMSNwJVr2YFS4s768WB7YuSpmk212CmA81gwqdkzqj03rNGY/7BWDeEUmzCEb1aFDX3FS9wJh14cDF3mXDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WZ8XdoOy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so6240522a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733301761; x=1733906561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GpsfTfUICfzCAXT9xiVRag8nVJBIPwyu/jXg6HVeCRY=;
        b=WZ8XdoOyu7+lnNTDwgIwLgW8HU9ehyNBkA76YLeP5tOGaMtIYJMxzEqPHotb7m8xeb
         y3ujxl7QBgyU+sVJeSUeC1+q/sfntD6/VNhzFlRkQshYyuA6wt0VwOFBPf443Mor5mr6
         0PP1E+mOJWZuzdbmm6WhgQcefHDTgEIJ2yhhiZpERtrLHnDGxjsskE7yrXnd7I14yBwi
         pN5lqzjoSb9YfkP1D6aTpOHVQhQeJ7UT1zTBoSTAT5y+IDnfocSx5naaw9IFevyc+7GR
         Mt/Bey0ZCyRcYH+TM+UdtHzfsP21bf/XS4X9o+dxH4XG7JZeScHjKO72OKa+epGhjJia
         rzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301761; x=1733906561;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpsfTfUICfzCAXT9xiVRag8nVJBIPwyu/jXg6HVeCRY=;
        b=GxKpZJyeISo/oC/Ny2E6TzMWWYQUB43ELBIxqN6bFAnArA+/8eWbqZIJN0ITo06fcR
         tc9hnKOEyT0vYlF+n8gx7ISTP5zfrjx5hk/Jc4m/0sj/FI2Suv2hfLYqUxzGrF9inGSS
         i1VwTnuYim2/NFIVDtLJ6SDR/e1PFEYkQYe8Qu8uTY0LfVpSjZsqd2pbtrgw5ERXycQ8
         qK/M4Oaj4POklHZWdwkFuA94UYnlzkM72tZPlAHi2K5/C7d2AyNxMtY19IGKYQATX8mk
         0sdVsr8iQtbaAM6W3wJkXAP9dxr1sXUfjXHTBGJHkGdxDKu+Ua2pAaFbNEa9w+mFFwOn
         6OQg==
X-Forwarded-Encrypted: i=1; AJvYcCW8SqHsoSHKnY9BlnihWA6YJVMsYaokGw/VpYF9EmDPQtbTuCddLqvSHcfuj6X+G4ZGR8Gm65k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14GBctX+V2SVYUf1dXwuho32o35wF/kAhg8cDldsTSn42Uqr4
	63gZFuDvZk/TpgvvUcoZBUWpy4pRwcZE2q2EG6DtkdkGV0J10/fZ7X82IPp6sXA=
X-Gm-Gg: ASbGnctREQgKqVFUTV5wIbw3/P774J8cbGULVeI6T0TxXpT3KKa8OZcB1uhynxCngJj
	iYU1aZiLP21syQOQwWrIgwB87XWNWGiOBGF5liwjDjvcodUR8zTt5xAXTt3s5oZP5GJrJfz9siw
	xAesIKyfMffHHmkIGWGJ96qpjJEBqaeJoHVnsTMQJrne1+sYxPYVtv40XxHlyM0kf7gfKY0NEk/
	CTj6AKgtoz9plDkRIVOT4lE4ua4/GlBlhDKt/PH7MkPYRwDBQr3V3UEVBKp2nujsjAfmpRRhEED
	iMbD6mCQ5gyx
X-Google-Smtp-Source: AGHT+IH+4UdC7PPD55te0VL0jClyrUfAzN4BNPp2pqdgPe1HA3JZqBAE6b7QL6znRAsN1/ZIvy5A6A==
X-Received: by 2002:a05:6402:1e8e:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d10cb5bcafmr4903940a12.19.1733301760877;
        Wed, 04 Dec 2024 00:42:40 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:85f4:5278:b2f6:64fb? ([2001:67c:2fbc:1:85f4:5278:b2f6:64fb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097db0bbesm6930084a12.29.2024.12.04.00.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:42:39 -0800 (PST)
Message-ID: <b66e3ee0-4283-4de2-9131-2cfe13d868f9@openvpn.net>
Date: Wed, 4 Dec 2024 09:43:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-17-239ff733bf97@openvpn.net>
 <c6ec324f-dcfe-46c0-8bfb-1af77c03cb59@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <c6ec324f-dcfe-46c0-8bfb-1af77c03cb59@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 18:46, Paolo Abeni wrote:
> On 12/2/24 16:07, Antonio Quartulli wrote:
>> +/**
>> + * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
>> + * @peer: the peer to modify
>> + * @info: generic netlink info from the user request
>> + * @attrs: the attributes from the user request
>> + *
>> + * Return: a negative error code in case of failure, 0 on success or 1 on
>> + *	   success and the VPN IPs have been modified (requires rehashing in MP
>> + *	   mode)
>> + */
>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>> +			       struct nlattr **attrs)
>> +{
>> +	struct sockaddr_storage ss = {};
>> +	u32 sockfd, interv, timeout;
>> +	struct socket *sock = NULL;
>> +	u8 *local_ip = NULL;
>> +	bool rehash = false;
>> +	int ret;
>> +
>> +	if (attrs[OVPN_A_PEER_SOCKET]) {
>> +		if (peer->sock) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "peer socket can't be modified");
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* lookup the fd in the kernel table and extract the socket
>> +		 * object
>> +		 */
>> +		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
>> +		/* sockfd_lookup() increases sock's refcounter */
>> +		sock = sockfd_lookup(sockfd, &ret);
>> +		if (!sock) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot lookup peer socket (fd=%u): %d",
>> +					       sockfd, ret);
>> +			return -ENOTSOCK;
>> +		}
>> +
>> +		/* Only when using UDP as transport protocol the remote endpoint
>> +		 * can be configured so that ovpn knows where to send packets
>> +		 * to.
>> +		 *
>> +		 * In case of TCP, the socket is connected to the peer and ovpn
>> +		 * will just send bytes over it, without the need to specify a
>> +		 * destination.
>> +		 */
>> +		if (sock->sk->sk_protocol != IPPROTO_UDP &&
>> +		    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
>> +		     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "unexpected remote IP address for non UDP socket");
>> +			sockfd_put(sock);
>> +			return -EINVAL;
>> +		}
>> +
>> +		peer->sock = ovpn_socket_new(sock, peer);
>> +		if (IS_ERR(peer->sock)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot encapsulate socket: %ld",
>> +					       PTR_ERR(peer->sock));
>> +			sockfd_put(sock);
>> +			peer->sock = NULL;
> 
> This looks race-prone. If any other CPU can do concurrent read access to
> peer->sock it could observe an invalid pointer
> Even if such race does not exist, it would be cleaner store
> ovpn_socket_new() return value in a local variable and set peer->sock
> only on successful creation.

Yeah, this race is not possible because at this time the peer is not 
hashed yet, so it only exists in this local 'peer' variable.

However, you're not the first one to comment this piece of code.
I'll definitely switch to using a local variable for the sock.

Thanks!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


