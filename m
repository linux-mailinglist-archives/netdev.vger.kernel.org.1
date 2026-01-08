Return-Path: <netdev+bounces-248049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09643D03D3F
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34F43149AEA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717F389470;
	Thu,  8 Jan 2026 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXNJAOji";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKablw+A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2E469230
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871679; cv=none; b=gSnbv9mxTHroOYTlTQ18uQJVYqiyaX2ZUjCJtXaqMfc80KPDON7OUOUS+fzPYxdvq4CxrEI8EpOmYlPuWqNvr/PdyEP+oUrd61y+Rc5Hx2qb+3wuvcjMZRUnRcXD/FPTMF/pVNE8Pqp5qAaZTsOFQsYFvtHEr1HqvpjDzkwj1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871679; c=relaxed/simple;
	bh=DXVRxgEjQyIFhLiJRSIIYHf6s0Xh3efyK6PB23H68Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHnTupoaaGKVaLEonk1XB0bFXjw+CXtZIxpE0DIqemubi2avO12X6ROVc87rlkFnQFWMjb/uYjWHNSyGAimV0e/yU/Upbf0tG8BjP0PFQOZmZEUEeEogOGhCIvmO91shqQO+8gw2B8T86mNYltpudr273s0lW1jAL/Eh2wQwmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXNJAOji; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKablw+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767871674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OLB5of9LH4Xgr0g/cKdpkyNCBxF+ZVgPMqVenfELd8=;
	b=VXNJAOji900LbBB3YipqIIEnHHd09fRytx1wSbSkMJjgNoMIFWPi808TFBWER22JZAyo3h
	zuaOogzChP+mHw5JgkDog7P2ZscdXwkHq4LLU67BT1HHYCDa9jDe6od92w6ofxx/P0be1q
	dxcq+YoQRy6psmsKyiyE0qy5PoN0DDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-PQXX-ZqPMUaRAA7blS_05A-1; Thu, 08 Jan 2026 06:27:53 -0500
X-MC-Unique: PQXX-ZqPMUaRAA7blS_05A-1
X-Mimecast-MFC-AGG-ID: PQXX-ZqPMUaRAA7blS_05A_1767871672
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d4029340aso29936105e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767871672; x=1768476472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OLB5of9LH4Xgr0g/cKdpkyNCBxF+ZVgPMqVenfELd8=;
        b=gKablw+ACVcLJ6DvTE9rQO7V6DTsNNxQw+BMfHf4bN/t/62m81D3wxPKm9zWG/vzUA
         ta7xgfNwl4K+FPLXCwswbzUa+553v+xo1cz9ojeRZBE1E0PGJ1oZkh9GGEuHQgywGjHQ
         PuQ79p8T+X6WR5VOlHIleeMDyPRWjLIcZJ/imT/YOqX2pZSie4wLKS3rlBtLNw1vZ8lh
         rFnumjKGmfjyjL+1N7A6TbyRexqpAugySIJRzpRnl8IKPMqxZtZylmkzxpfa8LoaS7Fw
         bSZrDoQdvLDYaZhp5siaDq7alwWrJat30sSc02G3aTYISGE3YjJrBZbgBsnAUEd2YAAM
         nEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871672; x=1768476472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OLB5of9LH4Xgr0g/cKdpkyNCBxF+ZVgPMqVenfELd8=;
        b=pFWM32aqi8g5N1RY0ricyWiO3EpwbSItNo1X/RDYC0T/yOARbmBV5Am1eZpHSLMSdE
         I4gKfM11iuQAaCWA1elmIm2TD3RqZsL0BA8Zqe9VYVjkaVSzK4EgBn3S4IpHMPTy6+oH
         QUm1AEEKS0p/aIrEe5b5A1sCiuecenlllMbnI+TpCSnIyztyy+kO51F0BitC1s5hc4Zm
         B+HqR3nZAqKTh6tX53paPr3wSOZvi88pCFXJBKnXAYCjXXzzq+XdMeoYTfm/3yTmNEJs
         yl0mDnZ1iZ0u7KCbAOzLrDPzX4ljKgOM6lvRmwKfdNsdOZ1JUViQHORCSv1cwYeyx0q0
         CmGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/qqu6ANomv5M/Oznx6beRG71n2PWHnFgTFonmKeuPWyv9hNjIY++X89vRPk0yLr9GaH2RoOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybu7tRL1n6RrNIHIkTOiv5tOfkayLKfdtnfSqpkkAGUjxIPaRu
	N9p5WKIYy3iALVz2V/rVbfArPlPzLWSxOtKdxcSI42aMoa4v2IwSoKwJ3vjbmWWUwhsvQUcOI3g
	zML6OXWl76lVIRosfE9E3TCEKCOKyl5Yb7j4fAbflD4UM1TcoUIHl7Dx+Eg==
X-Gm-Gg: AY/fxX45ATPtFm9hTgZ2gpX79kDK7FnJINphTIZbKAtc2VWSlmvst6rmFk3Lr/Szq7u
	24h16ozO6MFziFudOjHSn1t/p/8yNLirGz+CLvK4uttZlec0lbhNgS1d05SeySW/sZad8ujWWQO
	gRzPsLj0jFRDG/SPn4O6qLi8pjRSfUhDtR9gUv2U0X4/HEQ5VwUsJibbWsjL3sB4W/fWSNthNrQ
	DmOFAx9jqZbD0JgRpYydtb6XLE7EhxFY4Qlan0LvTZDM6o6LsC9SCH/wZzPyyL/Hp3IPeMFNBvT
	GwS1TeOEtu9suFw8akjxfHK7mOO3qldU3ErSWStvtuxfJAD8n7N1s61eYExTOCVaFYiWOiOKMA0
	v8sOhW0Q5I/7n0smi
X-Received: by 2002:a05:600c:648a:b0:47a:9560:ec22 with SMTP id 5b1f17b1804b1-47d84b17ae4mr64276195e9.14.1767871672375;
        Thu, 08 Jan 2026 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCrhVJUOXGI01OCCuWHNzKXAge7t6WHbeU8FiHMv65fBH2sXqaXVpMSUa0Er0tnD1FeKLcmw==
X-Received: by 2002:a05:600c:648a:b0:47a:9560:ec22 with SMTP id 5b1f17b1804b1-47d84b17ae4mr64275905e9.14.1767871671965;
        Thu, 08 Jan 2026 03:27:51 -0800 (PST)
Received: from sgarzare-redhat ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm154398805e9.14.2026.01.08.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:27:51 -0800 (PST)
Date: Thu, 8 Jan 2026 12:27:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aV-UZ9IhrXW2hsOn@sgarzare-redhat>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>

Hi Melbin and happy new year!

On Thu, Dec 18, 2025 at 10:18:03AM +0100, Stefano Garzarella wrote:
>On Wed, Dec 17, 2025 at 07:12:02PM +0100, Melbin K Mathew wrote:
>>This series fixes TX credit handling in virtio-vsock:
>>
>>Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
>>Patch 2: Cap TX credit to local buffer size (security hardening)
>>Patch 3: Fix vsock_test seqpacket bounds test
>>Patch 4: Add stream TX credit bounds regression test
>
>Again, this series doesn't apply both on my local env but also on 
>patchwork:
>https://patchwork.kernel.org/project/netdevbpf/list/?series=1034314
>
>Please, can you fix your env?
>
>Let me know if you need any help.

Any update on this?
If you have trouble, please let me know.
I can repost fixing the latest stuff.

Thanks,
Stefano


