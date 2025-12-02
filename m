Return-Path: <netdev+bounces-243187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B07C9B179
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1343A7638
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619730FC29;
	Tue,  2 Dec 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIAxxvoc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWqlNVfz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358A30DD18
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670705; cv=none; b=ngpNUuysJgjxJHbWhnsRcpq1Ff67/55gt/HF89PlSPC57HvVji4/I6yWn34THtKBbEZZ7KUON3Ax/Tn9uTVTiO1R5hMaeFz3PDq0MVNz+fJFAJ0AFsvFaitq8v0m6fOD65OMFXNLLyxePjh6vEPl+kfjOLzcVxOSMD6jUz0M6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670705; c=relaxed/simple;
	bh=C4AsMPURAFZJ6fstRBG4Qg4vpP3aNkGXJBTFj94MTzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqQiEjNScLrFpx2Eg1n0+xwgC6vzJtGSAsrULbK0DtoSTNEs0gYkPA2CnclwUBZ+Gdzpb7BGnxG3EhXPBulfe5lS81Lv0nlJaJrLWNOBg8Etxpa4udt4hq+5HYAtlvTB48GnFBeBfDgFrduNujrb2t1/57CiIoZ6DRb5mFOutzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIAxxvoc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWqlNVfz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764670702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
	b=ZIAxxvocve9hXq1bo/xjKXvCHcocs+AB+65FToAoIFLWg4sWQ4j/TApoK+wEw2ZNWIHP18
	WbCYpHtCiSlG/BIk9mmh0gPIcrhVbqLMQkrm6C/IIWJljZbhLs/IKzSexnJ9OjAeaHs0bd
	AKKONl6UOIFDzj57q7O0g92CiskoswY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ExBLlfxkMFagKlpZK4VPnA-1; Tue, 02 Dec 2025 05:18:21 -0500
X-MC-Unique: ExBLlfxkMFagKlpZK4VPnA-1
X-Mimecast-MFC-AGG-ID: ExBLlfxkMFagKlpZK4VPnA_1764670701
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64203afd866so10120287d50.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764670701; x=1765275501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
        b=YWqlNVfzJ2B+5RypcZGlhYXrKy4RwJ1V7YRi9LFlH/uQgPuttuE4q21nihPcAL1d3y
         NxMsMNM0xcm/Xr7+nveTr+KUeRKozzOgI2IygnagWoH/N1afXmuzp+ENv8S0glgh07vO
         2pUxvV0Z+X5vvKpKwYglz6G42mmbo9qcc6kAdeQ7WhH7dIZfpv1DAd5DXvcny5x3G7+A
         HZse3ajvAWzv6CDjYbkSR1VLF4TFxxBIeAPOtNKLLinyjNUwEoHsfE5P9VALj24dGov8
         8ZanDs0UXrGroviMEKexh6fV5rUyz+eNC+zFQsm7CKyPj79wlPQci4SNmL22NlpGZ8zf
         0EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764670701; x=1765275501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTt4I/sl26XWVMJJrirBgM5lGXHO7o89v/gepGPRQ/c=;
        b=wfaPfZSdazbBu9EkgQeB6Usz4Te//S8X7EmiahdCxt63oMSZEDm1vspBckFdoU1aGL
         TJH8lGpEh/vYhGqXVd241tfR7q34ZnZxZE0VpSN5+nLPF2tU/4mc3S9pWBLQAHRVItgQ
         +r8oNZEqh3WSaosPSMBBC1OVWopVAJvmfdy2KEiyLcTiNu4xWAsCjnQsZ+3aEKk0aYcx
         uMHRROWOsY4qBWimaSW9ejhY1aPHPRlGXLYWwDusnS90zeVtuIVyALN7GFqOc7bgvBax
         v24qxmkWQGyqdtAb7g8jVu0+0m2+v/OcKuIrNnFrZ/xEda1NSgwmvrG39TQ1uFOHBkqj
         ObGw==
X-Forwarded-Encrypted: i=1; AJvYcCWgovmsiNtv1K+VCuUpHDJVKTWF80T4ETljJysMuNPwraO9rJxZKOwuhwMZE6OKMfUYevWEx4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKmD7ZY6jtAIO6xLNrnrAIbbkUWV+0FEfSEafhUhe/mx6gO5d
	rQuiJKPV2rY7drL7A12bAlGCLqcch/Bb9O4WIJGEn9+R37TDOHnz8Vkrl1L1XozoT4R1qyJy/Hq
	x2DmtjXH1Ld1yj7ZumzHAh03zkzkUWVRSI7XsKkvHgrr9XaY2pgW2vzdfYQ==
X-Gm-Gg: ASbGncuA5xMqP+IQpvUr7NYokRdEOPsWI+Z8lyl/QytVJkql2xyS9bpYgPQB9n5Mtjy
	Iqjyl+ZG8WZC6Q5L25YkxkiabqcMgH8bma4U1OMeQSPxh+maFiNMeiAmv7aphEAXh5IS/UBJytA
	r905FxVErx5n+xgkltIQ/pxG3qJUZhJ1YjOmiLxkt+Sbdy9lOKXuM3ME9LIslDUptqjh636OJdp
	KmnwFxz/F7cw6x7dWmfNM2otXnJcM8wp0Zw1dMLs/KXqJAkG451kJ7smnd7ZnAcPWtPorH2HtD3
	byWaOBXqjR38OJ8S5iuQ89UNcpeOWK4riZnARasTrLedszRdEu24LNNqDrJWMXANktFraBqKCOt
	IEoTX7yxlNq9Ntg==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347954d50.42.1764670701043;
        Tue, 02 Dec 2025 02:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Y2QIm+VTnIL7mAD4ACmwgT3wSBe6KSOZFrHyLZqmktUrNUAn/hV1QCPy5jYE4S4xdld0TA==
X-Received: by 2002:a05:690e:d03:b0:641:f5bc:6959 with SMTP id 956f58d0204a3-6442f18c515mr1347929d50.42.1764670700596;
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c089431sm6041059d50.10.2025.12.02.02.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:18:20 -0800 (PST)
Message-ID: <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
Date: Tue, 2 Dec 2025 11:18:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  
> +	net = current->nsproxy->net_ns;
> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> +
> +	/* Store the mode of the namespace at the time of creation. If this
> +	 * namespace later changes from "global" to "local", we want this vsock
> +	 * to continue operating normally and not suddenly break. For that
> +	 * reason, we save the mode here and later use it when performing
> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> +	 */
> +	vsock->net_mode = vsock_net_mode(net);

I'm sorry for the very late feedback. I think that at very least the
user-space needs a way to query if the given transport is in local or
global mode, as AFAICS there is no way to tell that when socket creation
races with mode change.

Also I'm a bit uneasy with the model implemented here, as 'local' socket
may cross netns boundaris and connect to 'local' socket in other netns
(if I read correctly patch 2/12). That in turns AFAICS break the netns
isolation.

Have you considered instead a slightly different model, where the
local/global model is set in stone at netns creation time - alike what
/proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and inter-netns
connectivity is explicitly granted by the admin (I guess you will need
new transport operations for that)?

/P

[1] tcp allows using per-netns established socket lookup tables - as
opposed to the default global lookup table (even if match always takes
in account the netns obviously). The mentioned sysctl specify such
configuration for the children namespaces, if any.


