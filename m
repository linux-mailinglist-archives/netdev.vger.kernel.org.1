Return-Path: <netdev+bounces-156556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C874A06F0A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC0618894A0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277E2144C2;
	Thu,  9 Jan 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNLUKGhm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7C8F5E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407903; cv=none; b=Y/lLC3S64g8eOcCNNHO5RrvXZwLxLGrFIYUUJIMeAR+ZsueZ+PDBhhcMw+eyCwTh0bBfvL/68vQR56n6BKfua0V9sOtth8XpkYfTVr/ZnpTOvOORFg7TDjuXgtWZ9udZ8/PKZKQmdV0WRNnV9x1vCMYAF49d67rcomzwyUXmHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407903; c=relaxed/simple;
	bh=rBPdYEnZvtSaWGeIKaMzYx3ocXn/sfrS1kD4E5tn0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKriXcvFpb2Vz2MR8x9nfiXrCFS7jbAV3tmyKJPUMyc1LxkZdjKbwEjKA8cT2T74MDaVKtUdgbeFIVXC7V5rtxxeKvdQ5MCyHA2P+eu7f6VvdX5y39WP7YlLt2ZNojQD3H4+maty4tmG9cyHbFJMvYytQQig+w1VXMHnkOZcCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNLUKGhm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736407900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr4ssIrc4EtFfekk83GYUXsTrXGomg6Zpaa+C070Fnc=;
	b=HNLUKGhm6SCt3oyDMvXbdLFfbuFvA5CsBmvocje5pbNRQwNsTBMC38Xzr6dbQ7h32iy4qd
	GaiaAvO64x/1SmsaBkQ0t5QHN0rsK1huPTRj8snoXCplh2fNjsXFGXtQoOu1WbCj4vbFqU
	e/BA4euhYO8V71d1/8zWeE13BQZtQ4I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-od633-fBO2K7uZECWoLZBQ-1; Thu, 09 Jan 2025 02:31:39 -0500
X-MC-Unique: od633-fBO2K7uZECWoLZBQ-1
X-Mimecast-MFC-AGG-ID: od633-fBO2K7uZECWoLZBQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6a831f93cso68010966b.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407898; x=1737012698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr4ssIrc4EtFfekk83GYUXsTrXGomg6Zpaa+C070Fnc=;
        b=TRSDpcQGdZDdjYeTYGSjK5YZeszAVEQ3sUiFnL5FZCr95wO6kz4EwwQnrTeCX3YFGW
         oxxdvOhZQCqfAH5FnLGbuLSv12sDNxWLjJl8nbaiVwo0xhDJOH3bHv2gOiMASkoQuh86
         NCH0nKZQJhIJVgwmsIz6zfEhQC09miRgcQ+IeHZO3o1CuA19FgiRW2HNhAxnmPdqlhcV
         raLcumkytxBKI/abcQwD4fCnxFlgXstShAIg+33DiELSFs4Z1xQjfAt0wzozL8MA+Xbo
         +ZxFv3uccdQ9K9jshLPm9Qhi3ceTlHF5S1FE33KwOn5BQAVWGS4vgrGuDdPYYgb8bFdN
         W/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEZt0Fr0JW3x8NWBmBVHqLJp7Qkusba7Uo00y+pz6rdm4ZXclLXRViO3nhwznm8SQ3cP8oIJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUPMNGfbohO1RxJ6TEjDxGyKrHt4HkA5gnQuBcwQbY4vex3PX
	agLxDX3+95TG+ES5WkROgCIBNEgS2WUd1A0t8EtYbkxwzLnthsVM99sg4Jf0fkzplFzh5kAb+en
	fEeJJJm9ZmZz7F5VcvNwuxNn1X754iT27RjERh9Jeeny89Mth+k4lrQ==
X-Gm-Gg: ASbGncvF7XNLIdshgVuOM58h3bJEyPwRKdbFT1uQCKB4a3Ynp8ZuyJ8tKemz6msn+yB
	1iL9bnVifk4XfK0rDHKIFc+t3HUUNCSearvzTGwA6sXj6u9y7ISBFlznBoj+hiTyxJF97t3eJtJ
	h315pgy57cRIQAahPxWXgdEtozHxXHsua3kIxC6U6ah8/nNFY+EvAsUy87cF4OcACabcfvGQDxS
	3ieM6KEahugHOo7x6uUB23QfghIz50mqfDE1voqyI2h08b2mzE=
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:128c with SMTP id a640c23a62f3a-ab2ab6a8dc8mr488065066b.11.1736407897987;
        Wed, 08 Jan 2025 23:31:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ZKe0mzkcp2svj7dRwqQX0ex75ZtTovLeEL0VhHSiIUTDBhHXztbYHy36NKkZRj6x0d75Jg==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:128c with SMTP id a640c23a62f3a-ab2ab6a8dc8mr488061666b.11.1736407897607;
        Wed, 08 Jan 2025 23:31:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm42482166b.20.2025.01.08.23.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:31:36 -0800 (PST)
Date: Thu, 9 Jan 2025 02:31:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250109023056-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-tun-v2-2-388d7d5a287a@daynix.com>

On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

But if the user did it, you have just overwritten his value,
did you not?

> ---
>  drivers/net/tun_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index fe842df9e9ef..ffb2186facd3 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>  		return -EFAULT;
>  
> -	iov_iter_advance(iter, sz - sizeof(*hdr));
> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +		return -EFAULT;
>  
>  	return 0;
>  }
> 
> -- 
> 2.47.1


