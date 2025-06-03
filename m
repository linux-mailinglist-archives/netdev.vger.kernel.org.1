Return-Path: <netdev+bounces-194729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BEACC285
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B432C3A334D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3562AEF1;
	Tue,  3 Jun 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4QUYpTe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870302C324C
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941341; cv=none; b=doiEX7j8MJYVwjfqQXm8o24BuqEewjCoxrhYwek8+aMOS8hTDz85q4YEtnyDJ1487nA40Y27i5GM0j42Em9fMOyg7wJo29aFZPbMkro4nKsxwytpHdnEhI3llgr/CSS4GJquwiMpYtdi2T/NSiIze80O02N8Rrj6zmHNGVJdjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941341; c=relaxed/simple;
	bh=YWIqRAreUQDNu/wiyAMfubB77Sef+k3duy8F2BANRcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAihbqjf0rz4tMleB4CGB9iKdiD3Xpiq0kdLkLU04GQVH4scN8gxvOs3/NekJkrTI54kXE68aHB5yac/UIYFczN7oxx+NCOxhTF4UsiblImCrJpSwv+A1B8rk6u0gE+RPdxfHvYlEHbO1wuy/lqyhl7QqeKolHBJQ7uAi8/kPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4QUYpTe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748941337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCrNHikZEstW+IjZRA7mymdwsw0FDXEjx4HZaS53qis=;
	b=Y4QUYpTes9FgfsiltFOI3LEpvyi77B2a+srk9u3faA0YYaQjfaDdq8gh4ZQ/7IsIn8HRyH
	SGxbZyBYBNiiuOvH1Al86JANcuGNQ5U+QUvvVbjuUnbCh+yLBu1khSyQwCzXfRb+LPZa0P
	AvsGscKDwVIsYMy00KVjqqOT+/H6i0c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-A8iSWLzOONqxNiNuxEDDCg-1; Tue, 03 Jun 2025 05:02:15 -0400
X-MC-Unique: A8iSWLzOONqxNiNuxEDDCg-1
X-Mimecast-MFC-AGG-ID: A8iSWLzOONqxNiNuxEDDCg_1748941335
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso13426785e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 02:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748941335; x=1749546135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCrNHikZEstW+IjZRA7mymdwsw0FDXEjx4HZaS53qis=;
        b=QgF4oAWlWZKU3iFXNLo4kek46+fV9N0/HbsIhe6tWWQ34FJBTO9Mjwrk01g2XQu9kn
         peBaeHWMICzQnsFzqVjZqsLc3JjIpsp2zd/oD6uCgYhsaEbbLwgiaED06YYDXeL8v9jD
         yBFNc2nR3Yno/bTGqjoZ4U8BUYNZLvT37SOLxmk3DkPse2jigsKqEKvOEl9BaqDq+B39
         Xgz/54nnFgxKwXJ5Q58nXmZHXzvOc+d8VI5p0K1nnm0AfI5yp34gRY9q293KbU5aUaEX
         nqc8tW06fYBr0m3j+5twi/e2bMdcx6W25FhY4C5Xk0hRri1Xs9yEx6h+N02+HZKb4cDI
         avCg==
X-Forwarded-Encrypted: i=1; AJvYcCVq79LM9NtNc1i5M6Qhp4za2BA3LEjEQWV3gulMEP0GZJsuu+TynpV8edpGOJ8JPDJMcbiGYPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzOZkEOZqU6DERM7ojwOCdbvpwncAXX3xGrrNTfBBaJ8lSHEr
	OHL96/ZbrtRZNje848CSEfK93B2ahd0lrw0nijdrarCv8foKqfB5TSPzdfgCsVVeSZLp+boQxHY
	Eaz2obdiv60/pBuaeJqqmRAhiCENm0Vi6O4saMHuba7ZelfoMZ8jsOb3qpg==
X-Gm-Gg: ASbGncvaUvegWEjTWqQ0xNmKYK9/b/n+fLX1UlUn6Fouo9P+Y0/hTXkeOAcuDvBjSuB
	EmP1CLSmFdO0mk1P/PmBSVgTl09CSH15jwH/jP0gC0QcO19sHfejE2E/VhDGdNut9uNZSC8qPQs
	ws44XMWjgtMQN3PrfhRbBAU24huaKzhZoPBcTxoFKbsHVcfmGbjR5hQ2XLeWQkrdz0yXj5eSjNy
	Ekr8Sio1IfxgS0tc6jJlbWaXrNDwlzhCh/pUhi4x22qHAlGh6zBnph3SE/iwg+urP/aw8pZi1jP
	i+t40Vy32SUciwwM50rx1HeLhtvPBjV9/axIewaeFjNZcuhYI0FN1Gmi
X-Received: by 2002:a05:600c:348a:b0:450:d5bf:6720 with SMTP id 5b1f17b1804b1-451191fd609mr128599765e9.3.1748941334763;
        Tue, 03 Jun 2025 02:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNCbtyTornrYP1iF1VA/vpS2pvzrTYnsiNGZacCb0+vLOwqdlfI/tcA59g6/uATtZgYF7jTA==
X-Received: by 2002:a05:600c:348a:b0:450:d5bf:6720 with SMTP id 5b1f17b1804b1-451191fd609mr128599315e9.3.1748941334385;
        Tue, 03 Jun 2025 02:02:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009752esm17553616f8f.74.2025.06.03.02.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:02:13 -0700 (PDT)
Message-ID: <292bd402-f9de-45ac-829a-9cf04c4ce22d@redhat.com>
Date: Tue, 3 Jun 2025 11:02:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-2-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250530101254.24044-2-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 12:12 PM, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index aef8c0406ec9..89bb50f94ddb 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>   */
>  void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>  {
> -	struct udp_tunnel_sock_cfg cfg = { };
> +	struct sock *sk = ovpn_sock->sock->sk;
>  
> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> -			      &cfg);
> +	/* Re-enable multicast loopback */
> +	inet_set_bit(MC_LOOP, sk);
> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> +	inet_dec_convert_csum(sk);
> +
> +	udp_sk(sk)->encap_type = 0;
> +	udp_sk(sk)->encap_rcv = NULL;
> +	udp_sk(sk)->encap_destroy = NULL;

I'm sorry for not noticing this earlier, but you need to add
WRITE_ONCE() annotation to the above statements, because readers access
such fields lockless.

/P


