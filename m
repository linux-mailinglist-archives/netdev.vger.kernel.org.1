Return-Path: <netdev+bounces-194181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CEAC7B47
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF68F1C02627
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860725B667;
	Thu, 29 May 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOKDzWPB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B82580F9
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511896; cv=none; b=bAzBtSf9sA71+u3YjYKQTexFG4oF48WgEowMPtFUXT5Vg/fDtN4126DinvG3oiXBMwhpUa03PUOlOoKcSXzrqzY+jrGUnHBaWHoPZS3Q+b6YKdC3RVVw45V1tc/5UcfUxYv/SIfZy2TEl51+u01cfxz8W/iyzOoTsFjT6V94O7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511896; c=relaxed/simple;
	bh=IIgLbmZb5VVLfEnTx1JFBOSoTlJnxmMCQ3WCKjBFomY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoYd8tvfeZ5FvmOfnlRTGU1VSNDVhOf8H9iCocvoh0PzNPjDWcRzQVEjOuhsOTLxsAI6t1/i/zavZRXNfmAZI8ME5ymZw8hhDhzGBuPlEkA/bkE3qnnrGq8bfHwC6nEMJgIu5sXX/A0Y4vyEemqq7YJwaIq3VXMDu+hSBDpV/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOKDzWPB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748511892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdW8Hr543lzTEv8j6D3eacs45YkEVK/xJsw4xCFBYMo=;
	b=WOKDzWPBUCmTWTYxR8Hny26aLk7IztIZp18xDYiS9Ycp+nng+Gf/5iEqDuUsNXBFb9G3Wm
	TXgqitVmoZSmo8QVKXStqF1jf5p7RuaHOPNzNwLRyC8EJPr85rFeQSnaVUTa85802SSki3
	XALrQ+aBrk76YZRVY1D82G3iTbkKkKM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-QZslNDg4MBmZk09uGyLgGg-1; Thu, 29 May 2025 05:44:50 -0400
X-MC-Unique: QZslNDg4MBmZk09uGyLgGg-1
X-Mimecast-MFC-AGG-ID: QZslNDg4MBmZk09uGyLgGg_1748511890
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eb9c80deso440672f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 02:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748511889; x=1749116689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdW8Hr543lzTEv8j6D3eacs45YkEVK/xJsw4xCFBYMo=;
        b=ofnP/hH9PluUSl8laQbiEME6TSp9vY0jeh1F3fFVaZwIJbbRX5Z9hXxTp0kZWKKcmq
         ufjDMyGRjuKcjuBx0tsKb3695ol0fFdoLSC38VyWbvW20DLUE0cwbT7AlO22CMTGjwJp
         +JEshfyDR3koOUXldbcFWh23GCR4DPxTqcJUqoBfdjtOjlPxu3pD+Ueqti0vN8CV64cn
         AHZd4PzR6u8zN3z7BSnrir8En0gSenfSpMLqkSrrHDQ2wev4I7/PZ6YsRm4II16o3blD
         4phBAfJAdPjiuk2S9eMsDkbnfT1/DOxZxOIWHNO3p9p1NdU20sZ95adZLzhwaZNNXn/U
         guvA==
X-Forwarded-Encrypted: i=1; AJvYcCWQuMPi6wVWVrXYfurMo/uLJvm74fMLBJh16QtxJpe734gPDORlaPqT80CHlw0lez3pvQZlRBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFM8X6KgBTNlMIC4MzfQDDKUxn1ZI4KofRsQGe0cNhyTK4MXTo
	jYL00h0wkjYnX7gr1y6w2t6NfyasWgnoOoogh3sIZstDxEv6D1FMXlhKezqNNojUEPkE8Jsh7uq
	zs+uTiFfe5mIo5QFbrI0WbXUxl+B+0FcYV0PtreRiiIAeYaNMaBwcVGTGtA==
X-Gm-Gg: ASbGncvA2/RPUk+g8NmcZpq2geVEBGa8YB9Xns3b5JauVchuMP0+8QTBlj/N6Z0Us1w
	K1yUKUsdgLgm4MWneFTFvwzFXsBNKGab4qNb0w23unbgsGWjJ6UBE7fr17ZMdM4NJ50RmvBUDDI
	ANTnoHNxcjQCxA5QIDM7PGEfLD5aYpTcQYFIuIP1z+DqtXJvPbiFabuZxKopnsvXQs6VzUSoC+S
	lYFVQpzGRlaWXmucYC5thKEpcHPRiOLnj5PhCfz7EL6loRMpyvpzUslVthqZA7nNUMbfzYqyVAw
	mBgqHpRnYJVcrk+Q4Dxw48SBk72k613bjoR32soHJ1J0oFX9XGgDqM628kc=
X-Received: by 2002:a5d:5688:0:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3a4eb8076b5mr3331026f8f.56.1748511889470;
        Thu, 29 May 2025 02:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPCJAiqtOwGMOdb/QuYa2R+wbdnhxl9fhQFE1ar6wenG3+AoYtKI/LPenSzV0wJ7MA0ZmydQ==
X-Received: by 2002:a5d:5688:0:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3a4eb8076b5mr3331012f8f.56.1748511889097;
        Thu, 29 May 2025 02:44:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a1678sm1462714f8f.99.2025.05.29.02.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 02:44:48 -0700 (PDT)
Message-ID: <d9cbe73c-1895-42d7-8c21-70487773c94f@redhat.com>
Date: Thu, 29 May 2025 11:44:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] ovpn: ensure sk is still valid during
 cleanup
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Qingfang Deng <dqfext@gmail.com>, Gert Doering <gert@greenie.muc.de>
References: <20250527134625.15216-1-antonio@openvpn.net>
 <20250527134625.15216-3-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250527134625.15216-3-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:46 PM, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index bea03913bfb1..1dd7e763c168 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -423,9 +423,14 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>  	ovpn_sock = ovpn_socket_new(sock, peer);
>  	/* at this point we unconditionally drop the reference to the socket:
>  	 * - in case of error, the socket has to be dropped
> -	 * - if case of success, the socket is configured and let
> +	 * - if case of success, the socket is configured and we let
>  	 *   userspace own the reference, so that the latter can
> -	 *   trigger the final close()
> +	 *   trigger the final close().
> +	 *
> +	 * NOTE: at this point ovpn_socket_new() has acquired a reference
> +	 * to sock->sk. That's needed especially to avoid race conditions
> +	 * during cleanup, where sock may still be alive, but sock->sk may be
> +	 * getting released concurrently.

This comment duplicate some wording from commit message contents and
don't add much value IMHO. It could be dropped.

> @@ -192,19 +189,30 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>  		rcu_read_unlock();
>  	}
>  
> +	/* increase sk refcounter as we'll store a reference in
> +	 * ovpn_socket.
> +	 * ovpn_socket_release() will decrement the refcounter.
> +	 */
> +	if (!refcount_inc_not_zero(&sk->sk_refcnt)) {

How could sk_refcnt be zero here? likely just sock_hold() is sufficient.
Also I think the reference could be acquired a little later, avoiding at
least the following chunk.

Also IMHO the comment is not very clear. I think it should state
explicitly which entity is retaining the reference (AFAICS the peer hash
table).

/P


