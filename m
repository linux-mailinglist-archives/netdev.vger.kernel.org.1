Return-Path: <netdev+bounces-202909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4FAEF9FF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B283BC0B0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6A2741C0;
	Tue,  1 Jul 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpsIyvqV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBB1D79A5
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375677; cv=none; b=nN1+wxrdTKSb6QDsYqauU1lyvzIi+FOIf15DPogie9lpCERET6ugMkYIcJecwcU/5LTvKq4wljR4b2T0UKpoS4+ssQRr8vLcVb7Tfechb7W5VlWq+0mlbN/U5vywWnypBsaZ4IBShE0H8k9P+nRaPbl5AsEpOqIiO0xhS97lOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375677; c=relaxed/simple;
	bh=wWx/R4U9PK8jepw+D3683xhQW4S3Vgkd3HPrFrk+zoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t//WvqTUkjnvt+qIVqbHAmZDSjXZ5gUeWA3WBSYC9IvMSoFlN9AWxwquYiXe7gzc0ez3xcdWlO+rTqfwtJFUEONhYizE94BQlsbL/hkpTeGfkQqoemoykDQ2i84QArUokqnWagOVn39fRmJb8yFQQBbfIyPnZFyzr6b3KOd5iUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpsIyvqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751375673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvvTnjBcgdOO4554CVH4S87knZyerapiXWuGgPQCqyg=;
	b=LpsIyvqVbGuWLj88jnvYD8MkUTlCk3Hb9wLMRU1QIX1savI4QqCX//v3jE5fNwzSjIsfHv
	OUpheqZf3c5uR0Ax4Yq1uXol2aFWjMB4V+x69Z4PnFU5hc02uKRhexJ24vpIlOqucOB/zu
	NKGyU2KfGZDdta7cx445qsx4e80WlvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-fj4hI8jiPwyQnCCrHhOF9Q-1; Tue, 01 Jul 2025 09:14:29 -0400
X-MC-Unique: fj4hI8jiPwyQnCCrHhOF9Q-1
X-Mimecast-MFC-AGG-ID: fj4hI8jiPwyQnCCrHhOF9Q_1751375667
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d244bfabso28958915e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375667; x=1751980467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvvTnjBcgdOO4554CVH4S87knZyerapiXWuGgPQCqyg=;
        b=a3i/WYpMh7e4h91D0yE6r00ChfJhH+4lAqmQw5vX1emYxTfLu9CkzPKLEMAyHE/s9t
         dgM1UNyLR0EkRcxNu0mJT4eQsNYxnIJZfa9ishShgoXZZbZaPPwyyEhUrZ1hmRW623f8
         TX4V1cDcZRfWPu5V/4I0miHgrUIawyb2g2D6gm/SCJmy1ScjL9x2v5kQn0deyYxEz+Xv
         L86lMC+OWt3Qwsz056YrqDsNI3JUm2qgxdHEezvE2g7jz/C3RUFfvFAcXew99iCn0hoE
         r1Ve0vLKTrme5QGqyw8fwvBbRzupC2jLYCvxRmuc2Kx5HSW+G24hh0D57aI2gUufMBJG
         mhCQ==
X-Gm-Message-State: AOJu0YxkdeYYdRCAQKmu7jswIUOf5tz0lx/ldGAHycYxchIV2IRLjBsI
	8lQ3E4sex03DHtjRrDTuCGueQV04fH0HrQGF3B08RaQ2E7qvAmCDXCza3rIJ+MjayEksLQa1KuF
	yE2/IOD4tJDEYxQYF3h5kgPBbHr0M01y3TykQ6Bvg+bTI/i3+UzIU053Q8w==
X-Gm-Gg: ASbGnctBp4dMDZzel1CtFBCIvX71Dt9XZcrwkwWgDKsTHxSEZgKkY+5F2AF+2l7eIYE
	o5adpwMbn+cptA1FjGQLYFK+BwvAMG5Jm+b9HkPvkAky/8K3bv/3+MfIf/6voDxye6315Dvn35I
	FeOkHZ9yzbEX5f7iTQL6UGkZHuxQWzkaYAaSXogYKL2ehDyOaeL3YP1eW3pNBUQSJgCS7DdRMqd
	jFeEnvwRIdbHuFlHDf+eRhiRZ2sTKV3Pd5ZMd2d4QGiNNSqrwxvFZEmwkDy9wkeqF5IPvRwkGCt
	vXvwNmD32B7Btbtb51xJnqaEXo5d9y3TW72IzjuoN+1LNTXyznSHqlIuv/171uKex2gzhw==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr172393495e9.8.1751375666588;
        Tue, 01 Jul 2025 06:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC5ps6Q91kPndL/lhmDgGX1flj6In0Onrf1zs9HttuR11vkEtmy2+qCYAbK1xskrZlvw6VJA==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr172393155e9.8.1751375666116;
        Tue, 01 Jul 2025 06:14:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52ca4sm13334256f8f.58.2025.07.01.06.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:14:25 -0700 (PDT)
Message-ID: <e858532f-3e70-4d97-a088-3218d9822df5@redhat.com>
Date: Tue, 1 Jul 2025 15:14:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/14] net: mctp: separate routing database
 from routing operations
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
 <20250627-dev-forwarding-v4-3-72bb3cabc97c@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250627-dev-forwarding-v4-3-72bb3cabc97c@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:52 AM, Jeremy Kerr wrote:
> @@ -133,34 +133,33 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	if (msk->addr_ext && addrlen >= sizeof(struct sockaddr_mctp_ext)) {
>  		DECLARE_SOCKADDR(struct sockaddr_mctp_ext *,
>  				 extaddr, msg->msg_name);
> -		struct net_device *dev;
> -
> -		rc = -EINVAL;
> -		rcu_read_lock();
> -		dev = dev_get_by_index_rcu(sock_net(sk), extaddr->smctp_ifindex);
> -		/* check for correct halen */
> -		if (dev && extaddr->smctp_halen == dev->addr_len) {
> -			hlen = LL_RESERVED_SPACE(dev) + sizeof(struct mctp_hdr);
> -			rc = 0;
> +
> +		if (!mctp_sockaddr_ext_is_ok(extaddr) ||
> +		    extaddr->smctp_halen > sizeof(cb->haddr)) {
> +			rc = -EINVAL;
> +			goto err_free;
>  		}
> -		rcu_read_unlock();
> +
> +		rc = mctp_dst_from_extaddr(&dst, sock_net(sk),
> +					   extaddr->smctp_ifindex,
> +					   extaddr->smctp_halen,
> +					   extaddr->smctp_haddr);
>  		if (rc)
>  			goto err_free;
> -		rt = NULL;
> +
>  	} else {
> -		rt = mctp_route_lookup(sock_net(sk), addr->smctp_network,
> -				       addr->smctp_addr.s_addr);
> -		if (!rt) {
> -			rc = -EHOSTUNREACH;
> +		rc = mctp_route_lookup(sock_net(sk), addr->smctp_network,
> +				       addr->smctp_addr.s_addr, &dst);

AFAICS mctp_route_lookup() intializes 'dst' only when it returns 0...

> @@ -175,30 +174,16 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	cb = __mctp_cb(skb);
>  	cb->net = addr->smctp_network;
>  
> -	if (!rt) {
> -		/* fill extended address in cb */
> -		DECLARE_SOCKADDR(struct sockaddr_mctp_ext *,
> -				 extaddr, msg->msg_name);
> -
> -		if (!mctp_sockaddr_ext_is_ok(extaddr) ||
> -		    extaddr->smctp_halen > sizeof(cb->haddr)) {
> -			rc = -EINVAL;
> -			goto err_free;
> -		}
> -
> -		cb->ifindex = extaddr->smctp_ifindex;
> -		/* smctp_halen is checked above */
> -		cb->halen = extaddr->smctp_halen;
> -		memcpy(cb->haddr, extaddr->smctp_haddr, cb->halen);
> -	}
> -
> -	rc = mctp_local_output(sk, rt, skb, addr->smctp_addr.s_addr,
> +	rc = mctp_local_output(sk, &dst, skb, addr->smctp_addr.s_addr,
>  			       addr->smctp_tag);
>  
> +	mctp_dst_release(&dst);
>  	return rc ? : len;
>  
>  err_free:
>  	kfree_skb(skb);
> +err_release_dst:
> +	mctp_dst_release(&dst);

So here 'dst' should be uninitialized when reaching here via 'goto
err_free' above

/P


