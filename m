Return-Path: <netdev+bounces-250648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92267D38760
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE85F3013D43
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6936369207;
	Fri, 16 Jan 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+0m35Qh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqfWysMf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14534DB54
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594891; cv=none; b=c4QDBZhUZOjBASwBp5IAhKhzZlkn7XA6YsERqy1khEneK+dnP0oFZwdXEWj2FIUpvcleHvYoqNYdOWForJMRNZNUPrlfJZ132O0bd+T+eiFtKoaweeFjWNhRSAJpqFXqx40PCsNf3DOM/xUiN3FOnS7wfBrWKnzOdEGi0C3JJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594891; c=relaxed/simple;
	bh=yCSdMD4ToLGgmxhqQUtjj3m1ZlUrBUAba/VP+IyFmpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex0LqShtPV00ef+ZZ4eqsNB31YgNJqb9aLUeHI9oETfvDh/rNV/8rHD6gqCJi7wcjDTk4kKG6GNgbE0HZRT7BowKbRXQXnkV8/N5FibRr1f1wqMyZCByImquxzLwdB6pU9uY4UpxKzTDANIh5vROMrfm+F8aFg7xwbd/5xW7wJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+0m35Qh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqfWysMf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TM7qIG6S/L7S3GUslC1W7AHVB3tEGDHeSbLotnEOSBU=;
	b=N+0m35QhUEwLhUvf3fxmrxIsR4VjRGbSADtKUMZYBY2jDbaEZy/HOrytN2nSlVkMW0vwvl
	6b5M1ydVHbY9W2RCsvxzY45AqI554N7BT7i5Ydpy2RtZXjykkhTN4KISRWZZbEq2P6Ista
	e1IfZiw2r/iG0j/N08Phaft1CnOT/+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-1tPK8GnJO4qKkATSvLNczg-1; Fri, 16 Jan 2026 15:21:28 -0500
X-MC-Unique: 1tPK8GnJO4qKkATSvLNczg-1
X-Mimecast-MFC-AGG-ID: 1tPK8GnJO4qKkATSvLNczg_1768594887
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso25530705e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594887; x=1769199687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TM7qIG6S/L7S3GUslC1W7AHVB3tEGDHeSbLotnEOSBU=;
        b=TqfWysMf5/Sm44U77BSspMLayV7elnkjJoWwstzfZ18Ctl1LMQWUVoFEjxzilvSjrR
         ezhN06IKrJDl7ihqZUedxzcXhduXtGua4bdIBaoKSwkY54bePPn/3EHdBdRzL5j8XENN
         1e9d6L1ElzHrlK8xKxnGV1Qixn4wuthc/q232ZZcWFhkBR1dpRe80o0ZqCEAcCejo6Bb
         GSSFv8HzRRAHQtwZsBpFftU1MZl8ocaBcMYGswgFMYtm+cG1sS0dEOzoPgWB9pbdRAsz
         rcy7eUsLnTpPJsw+qnA2DgDYGJvsgtRLvJC2jMjWGcqwIocwRX0WcTS9Xe1i2pVMWpAJ
         7akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594887; x=1769199687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM7qIG6S/L7S3GUslC1W7AHVB3tEGDHeSbLotnEOSBU=;
        b=IRBXv08yiI0OpTrVI1q/Pa9BOY2ZkquThKXFuKKuBpUMthwyfwM9as8XFROoOWns26
         DEllOLSd2B7FFABYpevN7sbr9Em03PB3FwAXk76Hyj46yPUmiM1L1KqV7/Q0os980hoP
         Oi/huWETbvfmUixoCt0C5oME66WmJNIlmE6fupO5OZQcGkGR46s2w4Nen0XqqPC1ps4O
         giWSMJa37Gr4+C5//IWwpSncYsjJYNW2cRzqMFQ8lTxlwPmluUbNUrcv8shN9Jp0bRoS
         JhRPQE3FtBdVMKuKM7U89GqLkzD+eEW4HZiKTqYyS4jXt5H/Bn9PDTk3NvrnXM5wLKGR
         1K8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQVI3w7N5vyvNLXWKLk//vVOu0QQl3WgRrR7+KVuf8ZzHNWd5NSDh/VDY4v0ADN78KIsKIs5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfK+EM8AICOyhSX2gZyejhaSU137tiPXp+jTa9X9dedbPIpEf
	eccJUsJe+e3BczAJ3/GR5MushUKiwc1F6NTJ2kYBAldoAKSBHflAqpnrpPy4rDzWz0qpGNYvikn
	iYH/YIGG0uDwYV9o8fwJo02tR0sVwP3w/LoyZKwVr2pcI/ToH/V0HdB4KUQ==
X-Gm-Gg: AY/fxX6jbJ4dEUaUj40wPbTtOjk6QgP1XK25dzZfQvaOyoUl37gXKSuGdbd8F9NmKrF
	M+AJ8p2ParD7GWEjttZn4oj2b8BWBcLJe//tmkZbWk7xnCxYPYyKbKpz8nBQWAzJ/YK1BpWruUA
	EJ9CPDxC224VitVtfRqS76dQH9ZKzBN9DlgrGlizl66CDQhEI/SfAxgQ6Efa3cxdXIfcdbf822o
	tsR2r64xTEHXKqQ0Y0gfx9wrYTSGnj74EwgFfknensVn3332FAt/Wt+ITf0Dn65WWuli5+8ngAv
	gwyVpQSa2Zq3TsSBx+Qno1HnxAmfDg6eJyjRasfqgYLc7Ize2/AFcwezCJAoW73IOrxHVLW2gKd
	U39oJsRpfpbUjCPIMINgBbqAOk6LztiSGySDpNnPhMAuLhuV/qKJMAT/gDDY=
X-Received: by 2002:a05:600c:1d16:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-4801e2f912amr62205915e9.8.1768594887006;
        Fri, 16 Jan 2026 12:21:27 -0800 (PST)
X-Received: by 2002:a05:600c:1d16:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-4801e2f912amr62205655e9.8.1768594886479;
        Fri, 16 Jan 2026 12:21:26 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm144369235e9.15.2026.01.16.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:21:25 -0800 (PST)
Date: Fri, 16 Jan 2026 21:21:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aWqdjSUeEWMf53g9@sgarzare-redhat>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
 <aV-UZ9IhrXW2hsOn@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aV-UZ9IhrXW2hsOn@sgarzare-redhat>

On Thu, Jan 08, 2026 at 12:27:41PM +0100, Stefano Garzarella wrote:
>Hi Melbin and happy new year!
>
>On Thu, Dec 18, 2025 at 10:18:03AM +0100, Stefano Garzarella wrote:
>>On Wed, Dec 17, 2025 at 07:12:02PM +0100, Melbin K Mathew wrote:
>>>This series fixes TX credit handling in virtio-vsock:
>>>
>>>Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
>>>Patch 2: Cap TX credit to local buffer size (security hardening)
>>>Patch 3: Fix vsock_test seqpacket bounds test
>>>Patch 4: Add stream TX credit bounds regression test
>>
>>Again, this series doesn't apply both on my local env but also on 
>>patchwork:
>>https://patchwork.kernel.org/project/netdevbpf/list/?series=1034314
>>
>>Please, can you fix your env?
>>
>>Let me know if you need any help.
>
>Any update on this?
>If you have trouble, please let me know.
>I can repost fixing the latest stuff.

Since it's almost a month without any reply, I fixed the latest stuff 
and sent a v5 here: 
https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/

Thanks,
Stefano


