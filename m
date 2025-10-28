Return-Path: <netdev+bounces-233531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6CC15176
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B2D354022
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E6331A69;
	Tue, 28 Oct 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTQ+vJpO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F44259CA1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660826; cv=none; b=UXS+4mm40UyiESMGeyrusE5MpUPslWj/cgNX6uQLCnF2rQ7ul66TviASdQQbUb5ymboDzhEutZl1knlbNyV9iwkJ9Konmo6kEPd9idqBt8Fx+4dhhSYTnVs88VKKVYvDX+CboOOIPugYrIUj1apbVcrWf3q8bs61b2h+syjfWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660826; c=relaxed/simple;
	bh=ZYPPYcYAa1kfmT6ysEa9Ljp3mYRoXr0D4R/wdyfHVMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3nt+8UXtVKNSCvpQxjAqCjV5kX6mkecqTR/dR64vpXjKwE/NHoyVrEyYGeDqVRmZwWp3DBOVPLhPrbxIoR5rf2eMBsL7tiLW7/cDotqR1fwK3HX4UL5EmWlrg2vw9cyYLakfNASw1T7lWEUGQLXHtJQr9er5LqyThk47GxiZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTQ+vJpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761660824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLma0EwZTNjEWu7rLdG6tlLWGqLkYFGS9BPBZl6Fju0=;
	b=CTQ+vJpOuAamKgs3T5J9cUgT05j60SV7cpAv8VXEMq2gy3XK80oZwugIeTJjuIUR+lUQzk
	plRChTlgla+4G20naxO4qBg6J5M7sQWTbS/1aYH73qG03jnBy8cFI0if1nDxp0/GHKPnnL
	yvPmGG+Xrt6LbE6V5XkkfrMWZpVOZ6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-j3C9eKW1OKah3oJPy97DLA-1; Tue, 28 Oct 2025 10:13:41 -0400
X-MC-Unique: j3C9eKW1OKah3oJPy97DLA-1
X-Mimecast-MFC-AGG-ID: j3C9eKW1OKah3oJPy97DLA_1761660820
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso42936165e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660820; x=1762265620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLma0EwZTNjEWu7rLdG6tlLWGqLkYFGS9BPBZl6Fju0=;
        b=wbkNwe/BQGtnVHJ3P+BnZGXBNiEJYOb6PJk2aUpcqxY2OjuuaeMVlPPnNsVX50tErG
         LSxS5O6VEaH1YrkfM/GSLfoL76tbzq51hUpkBzuiYVRwxubfOybwMcrv7veDTAnwmn40
         LlEpXU+F/XSFr+W2OVBxJEpfoQDsj8lauTkVHIicVpjhwKV3JSdC7yhYca4Y/G0XaO8w
         0pHuwQ7r2z6+Z4dcTJtfW5yGiil5+pA8Jklo6eYYwl91p7z/DyOO4eARiDhno+Q2rY6G
         fvmZK366lmvpLcu4KaiWRKBmNP8zS9NVhIzW5dWx6bX5FYSvmovuFpmQHIPEjo0bC3Ku
         ZcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN0jh7WrIPMMIAhQ0Sy492tlmvQuRAcJK1itZjdDiuz+K83rwJuGi1kVvUzw2nx4e5KX4KyJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1xd2DDidhfls49MLlOArZlbM4f0dJhthuGSKJa5yG8wzeLLi
	mXZUAWG6df35Lslp0+zWoUZZDmoatZt7kGhdgITRnMGRUo2A9xLSDA85F70qgkDJmglpnL4Z63Q
	KKZk3oABvmbANaKXsmIzmgp5xmdZhZPNGqI2eA3ktEEeVkish2obcZ8+fow==
X-Gm-Gg: ASbGncvfJNJsAIVLpWjH0eN3Iy3yaA/IN+1q627WoLwlVdECTC0Zf8dgUvtWWBptDiL
	kx98FSM30wLZN80IWyNUvo1ZwJ8UdNq0kUnJq67uqytmvQsO17+9uWu2ahvUbYukTcAtathQ4tn
	rvWoxEDKRLmPF8p/Rd3/S3GrlgmGWX/+Y+XOnrTxlgCfrEqKOZdLzi23ZAYdeOGvwDLPRyJVM2H
	4s7v0g4HdQL3ohS5iXTN7G1C7UyZlUVqG5b+oNVL2nwx6uJ96kHvs9U1WmCmu93gyUOV7/pHqnT
	C4TdR3x+rk4tVUWha/baHrSiCO0tcX8Er3NdZKur3JqQ1yF9yblPfROJJqxuE+apiIcvsljWAFv
	BtMRyjBKD/oUWMMiUGfzNck4XKrQ8vkfnQjth1qa7IKmkhQ8=
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47717e30970mr30854275e9.26.1761660820104;
        Tue, 28 Oct 2025 07:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMJoIr+9VMwEM/UpHxSZ5ud3h8YOPEJx3EhGLMpRMZ3b2fEAstiZZWHLqNm0zTaKo1M5X22w==
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47717e30970mr30853985e9.26.1761660819662;
        Tue, 28 Oct 2025 07:13:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd03585esm197768795e9.6.2025.10.28.07.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:13:39 -0700 (PDT)
Message-ID: <785c8add-ab09-47b2-94bf-a4bfe8c13388@redhat.com>
Date: Tue, 28 Oct 2025 15:13:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] netrom: Preventing the use of abnormal neighbor
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: dan.carpenter@linaro.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20251023124107.3405829-1-lizhi.xu@windriver.com>
 <20251023135032.3759443-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023135032.3759443-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 3:50 PM, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> SIOCADDRT & NETROM_NODE commands to add new routes, there is no lock
> between them to protect the same nr_neigh.
> 
> Task0 can add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> release the neighbour because its refcount value is 1.
> 
> In this case, the following situation causes a UAF on Task2:
> 
> Task0					Task1						Task2
> =====					=====						=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node_lock()
> 					nr_node->routes[2].neighbour->count--
> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> 					nr_node_unlock()
> nr_node_lock()
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);								nr_add_node()
> 											nr_neigh_put()
> 											if (nr_node->routes[2].neighbour->count
> Description of the UAF triggering process:
> First, Task 0 executes nr_neigh_get_dev() to set neighbor refcount to 3.
> Then, Task 1 puts the same neighbor from its routes[2] and executes
> nr_remove_neigh() because the count is 0. After these two operations,
> the neighbor's refcount becomes 1. Then, Task 0 acquires the nr node
> lock and writes it to its routes[2].neighbour.
> Finally, Task 2 executes nr_neigh_put(nr_node->routes[2].neighbour) to
> release the neighbor. The subsequent execution of the neighbor->count
> check triggers a UAF.

I looked at the code quite a bit and I think this could possibly avoid
the above mentioned race, but this whole area looks quite confusing to me.

I think it would be helpful if you could better describe the relevant
scenario starting from the initial setup (no nodes, no neighs).

Thanks,

Paolo


