Return-Path: <netdev+bounces-239936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B319C6E1EA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 700C62DF87
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C6351FDF;
	Wed, 19 Nov 2025 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqbYJs9W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uEVn1Wcs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC128350A2F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550261; cv=none; b=NIKUGzzG6IDwB+FESx+hWP579s7085CAMnZtHka5MFalwl9EPpDwhvH0yb5zemBRwJ/1NMzH+zEAhOzPfP6PvRrobwHSbcEIxunQe0YwXk98QUp+MFSPMimPPFDxZFuc6Rt+CPsEe5ogWC0PPdfRyuajv98fpUlpNfmLBv2jcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550261; c=relaxed/simple;
	bh=Or/iFwMt+BMeSO1coYhZawNSolBDuL6LbxtDXCET8WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcAZ+h1UBM9OV7sZL82ETmbNHyq46sCv+GUwGKgkM0YBOEoYe5Y/6mGSQWbvAnT7OFtKiMy/yzqyVEdyj8hF45zbwvZmVuuHxCsIZF4VlpfV/DWYD6Z154twOhXASa+wdFoRDj68xg29qH7/SDFBaVPc1jw595xJ8ZaNkNY69EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqbYJs9W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uEVn1Wcs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763550257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKuBd2HW8nRsL/d/yhqkB0zqQvQiI6NwLHvu1csy0yA=;
	b=QqbYJs9WyPur5F6SVXW39FmkvRxqjh2CM3mEN8+7L2gOsbr0Pj3L0MvqTRw/XX3rbCwZJd
	FXYNt3OxXhnmtDmFprqfBlVisAP6yDdkxR0VB/RdpkxZzd33TtfdiFbYn9Nf2cgiDd+6X9
	S3ijME4kkGK2hBPlfg3xJXT/KzHMSo8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-oFoBocoFNEmcqZTgxpCxEA-1; Wed, 19 Nov 2025 06:04:16 -0500
X-MC-Unique: oFoBocoFNEmcqZTgxpCxEA-1
X-Mimecast-MFC-AGG-ID: oFoBocoFNEmcqZTgxpCxEA_1763550255
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so3642944f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763550255; x=1764155055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKuBd2HW8nRsL/d/yhqkB0zqQvQiI6NwLHvu1csy0yA=;
        b=uEVn1WcsaTqMiRrKNZiy6NqgGLAEyAQeKJKvxdH9sw7zKLmC7HJuLg6Ihu0MPLA/A+
         S34IHb1FSNSZo1sH6oQ7iFK60B0HkN7x0qXzxwPuNHzU3h/fkpXMss6fUSW20zTWR2ss
         XGyQUfKd7i7aJrVm7r853a3oGjbTRcj9BrLUQA0dn1OhqRTCnIB2ZwB0mkAc6/9N7hxQ
         wDaxlXSZQJ8DeDvcbrJXXP/+kFXqB2UFhx7rwii40Rf9+mZ7jJ5RpYLMxqVyvNnK4Y1M
         s5kOV9y1MaqyqZ2mSVhVq6F9miKPhLuY5Y0hJrX21ViM/fgdmmlS6X0xYf/L4XfI0+qZ
         FvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550255; x=1764155055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKuBd2HW8nRsL/d/yhqkB0zqQvQiI6NwLHvu1csy0yA=;
        b=S28La2cAbZ4SaMcV1fcnwbZei/Tot9X7/fQLX26C+nb56z8/CjnJ+FpbcXyUJyrhCq
         rB9kKmDpyCkvYQ6l0NPkzTovhkg8ChfWHd4dCQB+dHxKDHWW1yYFdoFCJb8teF6yeyJS
         x5T1/N3i39/QifD9Crx+MvOvHfv4zbADNC86UIG2aCk9lFWl0I/qkoQlWcc6YwoPZCcy
         Nz+pXn4WANfmGEc8wIiqtLc5DjEusdGnELBg6YGxwvFXO2zaVJqEHJYLD+cnm76knEFf
         vrw2fVK9x4a3JWCax9POKvMPqoP8joazCTaOWPWDpC5SLr3P+h8GQjb6OOmWP9CFY+QP
         PwEA==
X-Forwarded-Encrypted: i=1; AJvYcCXkiG1siJa/jU2VBL8c6AZQx3M8BpnD3HWHd/wW+poYalPvatiFNuLBDnspeQhQyN0hHV9bN94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTMY8E0Iy4OOuphGk5xzZSNoT63Xo7BAhRT2hBI4wIregvexA
	InfR5I6KX4TT2T2J5sxxBsHoggxeTPkD3Uv83V/0P8KIDpj/+x5bH6bEXhtwOwpcd3srArpL6DW
	QJX1y9JezimZX0Aj6CZjVwgGAqaWN9Vw8le0o+RID5S5fXmVU0jyS3WeQDw==
X-Gm-Gg: ASbGnctS8ZdBTwNA5E8ewM9NBVveh2HBEfBMjnlt/0s/Kr1sdNMSbp1ylcDzqVs5WMk
	GiadifwTqQytUEjFI0DI9N4LFASfFsHdr9ptlWuF+H/GZK/IoolJQ8c7aNBa924EdQEMRbLyU6y
	lQIPrSO2sUhjlDyuypZYem8g8EZcnPdTfRo/fCSrLx++i+aW1isE2K3fjHe4RELxzNH7b5ye/yf
	2rTLzm7lkDcx5pWd729cYWf1ZKoeYd4NMN56AAjgF34orKwJdOzH95bywLfF4nVExJuUghJroSI
	Hy3qtMJxjDjNrcumZP0qBLPAW+4GHiIucl7K3tmkw5s2Im1TBui89W9XdKjhQOvP4a0Qvok3X0z
	AbPCHQaoRcliy
X-Received: by 2002:a05:6000:1ac9:b0:42b:2e65:655e with SMTP id ffacd0b85a97d-42b5935a880mr17671079f8f.27.1763550255256;
        Wed, 19 Nov 2025 03:04:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnOndlVgs3mj8Ki0CtCTtbt0/DkKKE/b2cx4wA0ZToqoDYX1G7zSXdvoOnOMWxyBTwFXC8VQ==
X-Received: by 2002:a05:6000:1ac9:b0:42b:2e65:655e with SMTP id ffacd0b85a97d-42b5935a880mr17671049f8f.27.1763550254851;
        Wed, 19 Nov 2025 03:04:14 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm37236036f8f.11.2025.11.19.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 03:04:14 -0800 (PST)
Message-ID: <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>
Date: Wed, 19 Nov 2025 12:04:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] vhost: switch to arrays of feature bits
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <cover.1763535083.git.mst@redhat.com>
 <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 7:55 AM, Michael S. Tsirkin wrote:
> @@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
>  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  			    unsigned long arg)
>  {
> +	const DEFINE_VHOST_FEATURES_ARRAY(features_array, vhost_net_features);

I'm sorry for the late feedback, I was drowning in other stuff.

I have just a couple of non blocking suggestions, feel free to ignore.

I think that if you rename `vhost_net_features` as
`vhost_net_features_bits` and `features_array` as `vhost_net_features`
the diffstat could be smaller and possibly clearer.

>  	u64 all_features[VIRTIO_FEATURES_U64S];
>  	struct vhost_net *n = f->private_data;
>  	void __user *argp = (void __user *)arg;
> @@ -1734,14 +1735,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  			return -EFAULT;
>  		return vhost_net_set_backend(n, backend.index, backend.fd);
>  	case VHOST_GET_FEATURES:
> -		features = vhost_net_features[0];
> +		features = VHOST_FEATURES_U64(vhost_net_features, 0);

Here and below you could use directly:

		features = features_array[0];

if you apply the rename mentioned above, this chunk and the following 3
should not be needed.

[...]> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 42c955a5b211..af727fccfe40 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
>  	return r;
>  }
>  
> +static const int vhost_test_features[] = {
> +	VHOST_FEATURES
> +};
> +
> +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)

If you rename `VHOST_FEATURES` to `VHOST_FEATURES_BITS` and
`VHOST_TEST_FEATURES` to `VHOST_FEATURES`, the following two chunks
should not be needed.

Thanks,

Paolo


