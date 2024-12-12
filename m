Return-Path: <netdev+bounces-151554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B335B9EFF81
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC7F2863EB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003621D7E5F;
	Thu, 12 Dec 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="W98m/OmJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03251ADFF8
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043529; cv=none; b=gO0IxV08g1F6NWZCrfC75nS8gdBMi94DlcRMNeU2j5UVLoQ/IxyiJBZOZ3LmyOZQ9/N9Aa4CslGcRFeIXvMcb9BwS2+7CVglxnDoUwPoajCffA75dbCUFAwW0QYCi71Ns3q/ieXtELaFeKMHdcduztBoXF17FqBD8v/K+svV1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043529; c=relaxed/simple;
	bh=XpEtdsrgb4tWlq/LargblSbGeI9jhQhkhPTRrqvon8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHin0NDQV89pEqRTv5z335fJk7mq+PyIzhF7/NX0NVEnUHrnDQUxRh/QFHSY5e7/XbPC4gq1RfATi2Am/1p8nc3MLK3EH+T4CgV5H0c7P536vKacONKXoxELbi5X+7lcukIZQbyv3k2f7isDzHUC4FBhLPAEPrC8L2Xfm95pP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=W98m/OmJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67f31a858so196937066b.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734043526; x=1734648326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUsJkf4J+j/xiECkG4sE5rLGWyn8q8xGGB06NtynjQE=;
        b=W98m/OmJUPXrjeok+jriss0vDObb0KKDK/COOVBg9Ggzm/RTpblnYppu8hHFJgX/SM
         r2k3g2hCkXCos/bViZJn+8kiqxtPBPeWRBE+2vf3PwOAefxR0VHeGJiGLjDn2B05f2mn
         DgmjcMYBA3M3acIzUajJga2+n7gRkkB1rwFZ1r+BSarF7+8aELX+8JqochSfAqWTmchT
         r2WC2cMX7O4PvIouPYgKOMxnhXiTRDoMxtPi7SUwm6FZIpY1hSieD38WrP7dCfW+6Mcl
         qPLfcT7SZcqNmVmlnrXfHX/WWcaGTH7LqgYhD7NM6rhUG0Cl+6krRQ9voehXXMj0HO7n
         xGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043526; x=1734648326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUsJkf4J+j/xiECkG4sE5rLGWyn8q8xGGB06NtynjQE=;
        b=sqkC9pU37ukVjp8fE587+N8ssd9A5MbUl3nQxDTACWYg3fiNER2E3v6OGniwuSb6wY
         J/7/XjOMu3U5JJ0jsFCy8TZXJ2VAc2RWovXnqkSc8MWgZy4RjrLf4+sQHfY7vYnh+WST
         mjj7wqxDjd/xNUImjkTehWZge8L2IH/3iW9lPIr8hR/U3sQQiosaaFF8ndaE1XuAcj8h
         j+Vg8gRiGV/LncucJlCf55fNGiT/hvs1zVf3s33xcnKf2U2d0fIU0UyKgSjfrZklXTQB
         R0VEpmVE/NI3Z7Wl30lUuTKwhH4ozVT1I6XltgFkjmIbNTkV1QJJ2TDb21iZ/CQFXgrb
         CSYQ==
X-Gm-Message-State: AOJu0YzgHIi1AjnJ9JDQvQ2KFvWV4zRXCm6645vu4XHAb5r+yVZjVBTd
	HOOWda9QxUGMF+BXISTh1sXi6+1EcidhNQcwYlVxqTZ8T03MADhqQq7IspcmSWA=
X-Gm-Gg: ASbGncsX7PwFmdNVfDWhYbBuVxiTJbqxh9BNFyI65vAwycHuyaYT9BE4nMRrE1Sj87K
	QjY8bxt6I0S0ieSo1Er5ygcnPAMwouznVJu33we9+bz9v/Op+sXQmVhMCvNtU5lEbJrDVhq5UyH
	vXYXoNuTyRbjeYm1Vv2bxc8I1RML1AsySG77fnc5YnyRphOFwbVPpoJgUw+DsG844meUQjFY0E9
	2I0yw4m79pR87lnA27Pl4bZ1VQDFAGc8+q03rDwXSSYq8J4BgusOsePs3oTT/DlLUsO2f7iDmJR
	gUGYfHYb+Yj+pBcHeYM=
X-Google-Smtp-Source: AGHT+IEnd+D7X8TzYQBVe2H+wexdsZa1tb6lj6B+PXBw/DjlnuLHbieso5Q07N5vS1ESwsrUnIOZ3A==
X-Received: by 2002:a17:907:1ca3:b0:aab:7588:f411 with SMTP id a640c23a62f3a-aab779c8bcamr43821666b.25.1734043526035;
        Thu, 12 Dec 2024 14:45:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:a1c0:e394:b652:4ab3? ([2001:67c:2fbc:1:a1c0:e394:b652:4ab3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e6c67sm1164937766b.187.2024.12.12.14.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 14:45:25 -0800 (PST)
Message-ID: <fa19f3a8-c273-4d2c-a10e-e9bda2375365@openvpn.net>
Date: Thu, 12 Dec 2024 23:46:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/22] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 willemdebruijn.kernel@gmail.com
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-6-314e2cad0618@openvpn.net> <Z1sNEgQLMzZua3mS@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z1sNEgQLMzZua3mS@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 17:19, Sabrina Dubroca wrote:
> 2024-12-11, 22:15:10 +0100, Antonio Quartulli wrote:
>> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +
>> +	rcu_read_lock();
>> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>> +	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
> 
> Could we hit this situation when we're removing the last peer (so
> detaching its socket) just as we're adding a new one? ovpn_socket_new
> finds the socket already attached and goes through the EALREADY path,
> but the refcount has already dropped to 0?
> 

hm good point.

> Then we'd also return NULL from ovpn_socket_new [1], which I don't
> think is handled well by the caller (at least the netdev_dbg call at
> the end of ovpn_nl_peer_modify, maybe other spots too).
> 
> (I guess it's not an issue you would see with the existing userspace
> if it's single-threaded)

The TCP patch 11/22 will convert the socket release routine to a 
scheduled worker.

This means we can have the following flow:
1) userspace deletes a peer -> peer drops its reference to the ovpn_socket
2) ovpn_socket refcnt may hit 0 -> cleanup/detach work is scheduled, but 
not yet executed
3) userspace adds a new peer -> attach returns -EALREADY but refcnt is 0

So not so impossible, even with a single-threaded userspace software.

> 
> [...]
>> +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +	int ret;
>> +
>> +	ret = ovpn_socket_attach(sock, peer);
>> +	if (ret < 0 && ret != -EALREADY)
>> +		return ERR_PTR(ret);
>> +
>> +	/* if this socket is already owned by this interface, just increase the
>> +	 * refcounter and use it as expected.
>> +	 *
>> +	 * Since UDP sockets can be used to talk to multiple remote endpoints,
>> +	 * openvpn normally instantiates only one socket and shares it among all
>> +	 * its peers. For this reason, when we find out that a socket is already
>> +	 * used for some other peer in *this* instance, we can happily increase
>> +	 * its refcounter and use it normally.
>> +	 */
>> +	if (ret == -EALREADY) {
>> +		/* caller is expected to increase the sock refcounter before
>> +		 * passing it to this function. For this reason we drop it if
>> +		 * not needed, like when this socket is already owned.
>> +		 */
>> +		ovpn_sock = ovpn_socket_get(sock);
>> +		sockfd_put(sock);
> 
> [1] so we would need to add
> 
>      if (!ovpn_sock)
>          return -EAGAIN;

I am not sure returning -EAGAIN is the right move at this point.
We don't know when the scheduled worker will execute, so we don't know 
when to try again.

Maybe we should call cancel_sync_work(&ovpn_sock->work) inside 
ovpn_socket_get()?
So the latter will return NULL only when it is sure that the socket has 
been detached.

At that point we can skip the following return and continue along the 
"new socket" path.

What do you think?

However, this makes we wonder: what happens if we have two racing 
PEER_NEW with the same non-yet-attached UDP socket?

Maybe we should lock the socket in ovpn_udp_socket_attach() when 
checking its user-data and setting it (in order to make the test-and-set 
atomic)?

I am specifically talking about this in udp.c:

345         /* make sure no pre-existing encapsulation handler exists */
346         rcu_read_lock();
347         old_data = rcu_dereference_sk_user_data(sock->sk);
348         if (!old_data) {
349                 /* socket is currently unused - we can take it */
350                 rcu_read_unlock();
351                 setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
352                 return 0;
353         }

We will end up returning 0 in both contexts and thus allocate two 
ovpn_sockets instead of re-using the first one we allocated.

Does it make sense?

> 
>> +		return ovpn_sock;
>> +	}
>> +
> 
> [...]
>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
>> +{
>> +	struct ovpn_socket *old_data;
>> +	int ret = 0;
>> +
>> +	/* make sure no pre-existing encapsulation handler exists */
>> +	rcu_read_lock();
>> +	old_data = rcu_dereference_sk_user_data(sock->sk);
>> +	if (!old_data) {
>> +		/* socket is currently unused - we can take it */
>> +		rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +	/* socket is in use. We need to understand if it's owned by this ovpn
>> +	 * instance or by something else.
>> +	 * In the former case, we can increase the refcounter and happily
>> +	 * use it, because the same UDP socket is expected to be shared among
>> +	 * different peers.
>> +	 *
>> +	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
> 
> (since I'm commenting on this patch:)
> 
> s/Unlikely/Unlike/

ACK

> 
> [I have some more nits/typos here and there but I worry the
> maintainers will get "slightly" annoyed if I make you repost 22
> patches once again :) -- if that's all I find in the next few days,
> everyone might be happier if I stash them and we get them fixed after
> merging?]

If we have to rework this socket attaching part, it may be worth 
throwing in those typ0 fixes too :)

Thanks a lot.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


