Return-Path: <netdev+bounces-165851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B3A338A8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF316838C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4D209695;
	Thu, 13 Feb 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoWpDHqd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF376205E06
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431133; cv=none; b=eNw+9hw5KBEt1ViTOa26o4+T2cA//ce6/HrT/HKmzYl1/mBHO7jKFjQQbqfOBYV6/aIAFGOc5XadBEQuwpA7AMikAuHiEvlTi8j1yJ+ebPqB1RcsypE6Poaam5h12i19f+KDzJwW7XXfuJ8ZsNW2lKhVEoTzQP2deri/Z7qY4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431133; c=relaxed/simple;
	bh=ChdgDERxAxY49dY+v2WN3IknGnz2iHnVVF3p+KAYzZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB8VS6G1Xm9V8V1pCH06wI6RaZengbiJl952jAnhic3EVZO5uAFOWnXhZ7Qn/tiaIIYqOkQ86lKG+EYF99JLjQ1c2hjA2/hXuu9Jk7BQxh4F/DuoymofHusN4JNZ8xRiszRZoOMLGmE540DrbAWwA4iqspuVCfh9/M7DSgO51Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoWpDHqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739431129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2mPsKeDzh/gxf+lp5u5vn3UpATZaOjxGN8wZ5/rHhc=;
	b=IoWpDHqdfrkBB/f/Ad0+8tYwBRdptrZCYTZ21t9Kt/ucrkYOqfPFjtDL74aaKoO5H1pE5B
	HHs3ekEyacsVr6HYh4k39/7voNJkUWcAS02ARWrJcSuKkUYUt/hNH2+ciJelzbYJQu7GG3
	lmFd5bOW/7OB9cvdvKldnZ6+MTi/GOk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ds5omCDsO0iX9uYgcpiTFg-1; Thu, 13 Feb 2025 02:18:47 -0500
X-MC-Unique: ds5omCDsO0iX9uYgcpiTFg-1
X-Mimecast-MFC-AGG-ID: ds5omCDsO0iX9uYgcpiTFg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5da0b47115aso512958a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 23:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431126; x=1740035926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2mPsKeDzh/gxf+lp5u5vn3UpATZaOjxGN8wZ5/rHhc=;
        b=ghNdxsV9wZznztcaq+Kz5R0MoXaQPkOQ9Rf6JHiB+tU++30lbHtDonH1rTj0V7wYHK
         GQtNNrXvFmZM/YkNn8o7yrCQw0MBZzO0mGUWyp75KE9IGgsew3T8kjBVt48iHsykA9VL
         GXoLD38VKnhZm4VzbrkQ5Dfkj2cHxkQJeDAYDhAcdmSdSLa6LwoixsbRE2RPD8U/hEMn
         n9KPDHWek8V//w69PIeHIVDbEctykGgjAVW9+HFSBsrCefzKwq0xYDKAZd/eLWGqSyqz
         byZKpCM2NyhAgoJR5AvWf/Si1I4EjUKF8dBmR6PHCPkKFY3zZvPodjTVanXHdN+MoKUY
         pFfg==
X-Forwarded-Encrypted: i=1; AJvYcCVb/F2l97HFdfw3vrcst8WQ56gsDg5dh1VNjk1n5eFvP6jFcK9NRTMV+Ns1YLgPn1bzqJdeYhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zMY3All5Ffg5kOccqDh2QthHOshdeVYC7fzx3HDhr7miIIqY
	P4DwyxVL7bP6v8dRvzi/6MRc1nL2YHVQhQnC75gxipfY18usr1xfyLh4/dFNvB/8LjZyNPmvwaa
	OsPPEx7wReQK2lelqvivbffm0w6sBKDJjvGVIGN/tjjObSqcM7OrUyw==
X-Gm-Gg: ASbGncu4rh7TWUlJPYZXvgkgh5GbMyAa5svEGedv79gDbfmGIM0M3fechVQrHE15XVJ
	zjEXSyPKtYyzThdht3X9M1YNWILlPcRGIwoPi/iFRTQooCg0gVvRHN9TlR5xvZoM0SE9B9MM774
	rrngtD0/jTD8v1MsqT+tDyY6DQpG9TjTjjOYHqBsAaiJov7hRyvAtDUgpYCA4g5HGEme47BY9Ks
	jcxvpo0VttAwAKanIGm1jXfBt1UDWQAD001EEAzp5cRcsC5ZA2Wu/eMmeG/An+htvc1ov6/7A==
X-Received: by 2002:a05:6402:4316:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5deadd7b874mr6281566a12.6.1739431126524;
        Wed, 12 Feb 2025 23:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW3dzz4GC0XINK0kmKeWK7mkdp+xAoG7xnRiNVKpnkfhaNZCHX7+nWUVopuAQVF8sBoIRGYA==
X-Received: by 2002:a05:6402:4316:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5deadd7b874mr6281534a12.6.1739431126110;
        Wed, 12 Feb 2025 23:18:46 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:fdf4:7340:1015:94e8:5ba3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4692sm674233a12.31.2025.02.12.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:18:45 -0800 (PST)
Date: Thu, 13 Feb 2025 02:18:39 -0500
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
Subject: Re: [PATCH net-next] tun: Pad virtio headers
Message-ID: <20250213020702-mutt-send-email-mst@kernel.org>
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>


Commit log needs some work.

So my understanding is, this patch does not do much functionally,
but makes adding the hash feature easier. OK.

On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic

I think you mean "this will become especially problematic"

> when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.


What is missing here is description of what the patch does.
I think it is
"Replace advancing the iterator with writing zeros".

There could be performance cost to the dirtying extra cache lines, though.
Could you try checking that please?

I think we should mention the risks of the patch, too.
Maybe:

	Also in theory, a user might have initialized the buffer
	to some non-zero value, expecting tun to skip writing it.
	As this was never a documented feature, this seems unlikely.


> 
> The specification also says the device MUST set num_buffers to 1 when
> the field is present so set it when the specified header size is big
> enough to contain the field.

This part I dislike. tun has no idea what the number of buffers is.
Why 1 specifically?


> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c      |  2 +-
>  drivers/net/tun.c      |  6 ++++--
>  drivers/net/tun_vnet.h | 14 +++++++++-----
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 1287e241f4454fb8ec4975bbaded5fbaa88e3cc8..d96009153c316f669e626d95002e5fe8add3a1b2 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -711,7 +711,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr vnet_hdr;
> +		struct virtio_net_hdr_v1 vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b14231a743915c2851eaae49d757b763ec4a8841..a3aed7e42c63d8b8f523c0141c7d970ab185178c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1987,7 +1987,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  	ssize_t ret;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr gso = { 0 };
> +		struct virtio_net_hdr_v1 gso = {
> +			.num_buffers = cpu_to_tun_vnet16(tun->flags, 1)
> +		};
>  
>  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> @@ -2040,7 +2042,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1 gso;
>  
>  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>  		if (ret)
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index fd7411c4447ffb180e032fe3e22f6709c30da8e9..b4f406f522728f92266898969831c26a87930f6a 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -135,15 +135,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>  }
>  
>  static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -				   const struct virtio_net_hdr *hdr)
> +				   const struct virtio_net_hdr_v1 *hdr)
>  {
> +	int content_sz = MIN(sizeof(*hdr), sz);
> +
>  	if (unlikely(iov_iter_count(iter) < sz))
>  		return -EINVAL;
>  
> -	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
> +	if (unlikely(copy_to_iter(hdr, content_sz, iter) != content_sz))
>  		return -EFAULT;
>  
> -	iov_iter_advance(iter, sz - sizeof(*hdr));
> +	iov_iter_zero(sz - content_sz, iter);
>  
>  	return 0;
>  }
> @@ -157,11 +159,11 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  					const struct net_device *dev,
>  					const struct sk_buff *skb,
> -					struct virtio_net_hdr *hdr)
> +					struct virtio_net_hdr_v1 *hdr)
>  {
>  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  
> -	if (virtio_net_hdr_from_skb(skb, hdr,
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>  				    tun_vnet_is_little_endian(flags), true,
>  				    vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> @@ -179,6 +181,8 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  		return -EINVAL;
>  	}
>  
> +	hdr->num_buffers = cpu_to_tun_vnet16(flags, 1);
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: f54eab84fc17ef79b701e29364b7d08ca3a1d2f6
> change-id: 20250116-buffers-96e14bf023fc
> prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
> prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
> prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
> prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
> prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
> prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
> prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
> prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


