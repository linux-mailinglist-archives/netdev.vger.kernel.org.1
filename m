Return-Path: <netdev+bounces-228102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE37BC16A9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4975B3C3D24
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB92DF3FD;
	Tue,  7 Oct 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJOeaBtU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7E2135C5
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841714; cv=none; b=fKGD7qOxNMKXKNYraQs1OzwxP/ETNNzM/VveL/1XtFqFt5XITIMzxw+WdAeM28W9tUvWy8t8GRT/slRur17d4L8WifnEvn5RlX/TMFDzGxEkpc6NMEEMh5tANUGyRoitGbmFalrO36GhPhKKN4kBh/lG6Ow/9bHEkEck2wSLjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841714; c=relaxed/simple;
	bh=sskRBZIq3ZV/qQ1N2FKi74Cz4KCa9C3J5w4ehhfzGn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIb9WMWJTqKzKd7Sa1DngilqE65GdGecBqDTbjLMWRw+rXhLMriGcS9uC/qeYGN8r8rdZXUVVuuQcBmTXamz7qZGgJKdm5KRRiTN7ktkdk9FKXNkjnSRnZ343r5aF+NTKKa8MJxWcDiEhuKEARVuuU7F+Q3xFAxnnVCMaFwNnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJOeaBtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759841711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JObPDM43kbrRGTVx2qicxdWSHWXv4jr/i/WMIAB1AqU=;
	b=KJOeaBtUmy1sGi+3AtW7QjtVJcRVGFdp/84lKPZRo+ApPzZeyoGkFIrscoXdo2dShFVhak
	ISPISpRxQg97lrL3o1iF1twusvAC1im4Lt0XJkybplCNxQRPswALwI8JF5GAMTQbmHANp0
	3IskintkSTV7Cwz38HMdR4ClQfr7STo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Q-ITudcEP2ev9VmSy59g1Q-1; Tue, 07 Oct 2025 08:55:10 -0400
X-MC-Unique: Q-ITudcEP2ev9VmSy59g1Q-1
X-Mimecast-MFC-AGG-ID: Q-ITudcEP2ev9VmSy59g1Q_1759841709
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e39567579so27201355e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 05:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841709; x=1760446509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JObPDM43kbrRGTVx2qicxdWSHWXv4jr/i/WMIAB1AqU=;
        b=Xwn/vbxvGF5GJQOaPDTcyGxgq/h8toozowlsTOwcBy+ST5qbb9yzaAhF9COiybhumW
         ohJ60wNr08EGAFeiw+PhPfEotk3mkf3XNOQrtvTQv80/4WubImfUQbYrk6+AqBlFdc4f
         7uHUuHNqUfukJ03ILWzIsULPaKwcrkNPj1JWdzRc1+bjo0CRbQZpvQgi7DcwgAgKt1U6
         +ykR7sdn67/awdD3i8Te6xxX8JOGyT0h/wmRnmHBrysYtncZjH8Byd3BY6Us9pU9Uhqo
         GRUjNKe0rsvHL5kGIhJpjmrRvOSiJuYqg3o3dCw9qeRgQM7Wchj37TlF16JAmp/1c0vj
         5DAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqcfSQhxDyqvWveeujwK1GjWJz8foq3TCJAv2QI9SJKgtc6LqknZ4ZnKIa5FSUxvOpbYp31HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3HN2lpnSIM0Smz4UutabMDZkwFgeAiBAbkUT5NGt5Pe3wFT79
	hbmVK69fQyMHAC0AdYa4urPg30cmFZc3iwJZRGYFsn5k+ArAsH8aX5zp4cZbjV5TrXB8qJZW6Aa
	AMfWGFlI3CZD/bg4WVOIVSBBaAASDqY197aA2KxnF+62XaClNOgB1Nqbjmg==
X-Gm-Gg: ASbGnctTkgC759Q39jWvdqZro2c0kD0asQ+U0ntwhuIhLaTgBgY1v7QmMAtGCsBT4ik
	GV0NkqXDVR6Wa5xv2NzZd2Xl+xWXhmPFF9dj393CJ/m+EtG9DjitGuxRY5UrmspzVUDLwduUao6
	v7/wDpK72ZvSNxyzkvn8DyvALRdpQ7YwAhbfZsaXpGsmkldWvIF2DMG6asAtjBJ7KxmVOHm3Mzy
	SuewYsYY8NvqddDSWdf/vQ/KQIGBRUdXf3n/J0+xr6m8YjT5taHVe4PeVCnjyR/JyJUB5E0ojAc
	E+KKfSaLkI/ZiioE1A7E6IjVhl6+LlbSM74vot4xEJxfGWWvBf75t4Sk4DPnbvaYoIrwYsXq6Mv
	GYGvlfMtyPoFomQsweg==
X-Received: by 2002:a05:600c:83cf:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46e7110e4edmr114208155e9.10.1759841709262;
        Tue, 07 Oct 2025 05:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf+yr0C4xLuJM/GLkBC+pknfkcsjQX8ZNgouB/KZMa7StJI4sxuc/r62BoMnwYLfDYtvHz+g==
X-Received: by 2002:a05:600c:83cf:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46e7110e4edmr114207955e9.10.1759841708852;
        Tue, 07 Oct 2025 05:55:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9703sm25776462f8f.30.2025.10.07.05.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:55:08 -0700 (PDT)
Message-ID: <af6253a8-5b21-4e32-84bf-62d11c7ce251@redhat.com>
Date: Tue, 7 Oct 2025 14:55:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wireguard: allowedips: Use kfree_rcu() instead of
 call_rcu()
To: Fushuai Wang <wangfushuai@baidu.com>, Jason@zx2c4.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251005133936.32667-1-wangfushuai@baidu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251005133936.32667-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/25 3:39 PM, Fushuai Wang wrote:
> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
> the code and reduce function size.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  drivers/net/wireguard/allowedips.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> index 09f7fcd7da78..5ece9acad64d 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>  	}
>  }
>  
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> -}
> -
>  static void root_free_rcu(struct rcu_head *rcu)
>  {
>  	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *node, struct mutex *lock)
>  	if (free_parent)
>  		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
>  						  lockdep_is_held(lock));
> -	call_rcu(&node->rcu, node_free_rcu);
> +	kfree_rcu(node, rcu);
>  	if (!free_parent)
>  		return;
>  	if (child)
>  		child->parent_bit_packed = parent->parent_bit_packed;
>  	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> -	call_rcu(&parent->rcu, node_free_rcu);
> +	kfree_rcu(parent, rcu);
>  }
>  
>  static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,

This is net-next material, and net-next is currently closed for the
merge window, but I guess Jason will take this patch in his tree.

Cheers,

Paolo


