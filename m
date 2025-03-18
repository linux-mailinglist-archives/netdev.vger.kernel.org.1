Return-Path: <netdev+bounces-175762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE4A676A1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168CB7A826D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070420E6ED;
	Tue, 18 Mar 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPZ4/oc3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8814B08E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308765; cv=none; b=t0cGIzs4kJh15IYn6EYpgu86UohD1qC6kg/AyS+TkC4KE2sdSIf+OclEGBJwcBlJRjXq8YodL8+eI+4LNMKGUMU1uUMb1CevdNCqpum/welZZvX7JIN7+hGsKgDUQ9GVE+uIUC3ssOX6qGZlF2FoVALj5Z9hVCsVy+KcQxNCRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308765; c=relaxed/simple;
	bh=VlmrhLeJPUEFA+lzg8T6jHkvVs+Rt91krv8MHtKaYng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwkJJ94diXBj3nkffzygOpuO6EcwKN6bQQiS3OYhvb8VkvC6/rIzXxOjTZaTVZtLNcw6TF2m1P41gdIvITE6VRPF8c+He6xp6j5AQD8KC3a/IMuqeaKVS1SMiSRtlyAgVh0hEBEox3P4OQhZlaEugz5XjahD8K0LqnftuHRnmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPZ4/oc3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742308758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
	b=YPZ4/oc3qQkd8NDHnt+27Xqv8TY5SjNZEUZhxH3Um6/AQaZUC4RdG4Z5vGJvpKuMTKnVAn
	CIAKVjpWNp9NUQfXZsAyy4LfWwfAkgSojb2Q+kCz3NjV5ykbA7SMeMaYtEMBZOlMVjUlXf
	wLn1K0Bnbf53vqOqo2e9MyJy6IFiUhA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-2jLXClfJPG2qVYEFWNYzCw-1; Tue, 18 Mar 2025 10:39:16 -0400
X-MC-Unique: 2jLXClfJPG2qVYEFWNYzCw-1
X-Mimecast-MFC-AGG-ID: 2jLXClfJPG2qVYEFWNYzCw_1742308755
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so20091865e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308755; x=1742913555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsQlwRAe+Vfyt5oYdUWSq8JNPzE0Apo55NHwyi1kdq0=;
        b=OjKe03L55MxLnY6rV4qEO+P20Kue4m4fDSi9uqergrhFbh0jGJRoMhHsnWXEJbQVBW
         fTiaqLKl2PFT8OX4L/gJNtK4s3ZZxv8ERIYP+4yJ3xljjRF/PI/E/doKwiUhaoAvIIX0
         RSzisoIn/8M9hrGF/4DK3cS38FIc+kfutRAya1hZHv4zS1z2ytoVr91f4pLr6bLqFf1G
         EB046gTYSi8d770Its+Zu4FRKO6gYPvq3sSFmNg4MkRt1kg5egplFYhfH05V5+O5t6nn
         LmWX7kPttwwIwzdKeWHZRjbejZ1z+1Hd25fOvZOAG585046N+tH8XpYVeitdAiwYzVPb
         JKcw==
X-Forwarded-Encrypted: i=1; AJvYcCVAHmBsKAW0mT/fO9Jzwabd72xr6szVrqSyFbv+2EJHcpao+fPFlXZG+pVsDYTlAOalG7+fo3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwlaBOBRFMC+ZKhtgsrOmsXr0K/DIf4/2aicIcXGDalx3mZBI
	+6nZkv7i73VTex1AmtJjHVbKlxijlfA6//SFrHYNW0EbzqUsV+g/EKC+ShcRY4h6BxdUzayote/
	nQsbbyhSUWivX6Y8BwLui12qyJOMw7cPxzEV2S37hjkcZjqBrI/CIhg==
X-Gm-Gg: ASbGnctdr2YvHI4ojAmqhNBkxHVKGEYDc9M6WJd1XGU4pSuIKWQF+Hp+ESRyMokzoZQ
	ZYAGeZm5e3bYv2cBBeIcmg+wfOVLi74bEULTOzZ5l7aRfwruMsBIae7dISGE4+xM6r/oQHmuqz8
	zX4wJHqjrVPuStT72bCstv11/JKmb75ApDBoY+FOaSvlDPeC8aVnD8xTf4yVF/QyU0AVTfdNiI+
	zvOJ0lG8STnYJV9mCtJXqnkp+Rt2E/rXi9OPX01L8DdGnIfOGhBI1hrKN42Eug8UJe+QMC8eFP+
	KgHWxGPY7Eot7SdmFnWUOxi0wu6KIzKkKWDzL/dOFhRXPQ==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184605e9.6.1742308755367;
        Tue, 18 Mar 2025 07:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWUKBTOZHulBPKccJIMkih2ejX9HgOTZC6YQk6IraOUM0a3ImJsw3fgLjtFZUV+DmHGg37Vw==
X-Received: by 2002:a05:600c:138a:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-43d3bc12751mr24184395e9.6.1742308754930;
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d393bb288sm27247155e9.29.2025.03.18.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:39:14 -0700 (PDT)
Message-ID: <d67a6f99-3d67-4843-8a32-83b086952ab2@redhat.com>
Date: Tue, 18 Mar 2025 15:39:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove sb1000 cable modem driver
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20250312085236.2531870-1-arnd@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312085236.2531870-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 9:51 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This one is hilariously outdated, it provided a faster downlink over
> TV cable for users of analog modems in the 1990s, through an ISA card.
> 
> The web page for the userspace tools has been broken for 25 years, and
> the driver has only ever seen mechanical updates.
> 
> Link: http://web.archive.org/web/20000611165545/http://home.adelphia.net:80/~siglercm/sb1000.html
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../networking/device_drivers/cable/index.rst |   18 -
>  .../device_drivers/cable/sb1000.rst           |  222 ----
>  .../networking/device_drivers/index.rst       |    1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |    1 -
>  drivers/acpi/acpi_pnp.c                       |    2 -
>  drivers/net/Kconfig                           |   24 -
>  drivers/net/Makefile                          |    1 -
>  drivers/net/sb1000.c                          | 1179 -----------------
>  include/uapi/linux/if_cablemodem.h            |   23 -
>  9 files changed, 1471 deletions(-)
>  delete mode 100644 Documentation/networking/device_drivers/cable/index.rst
>  delete mode 100644 Documentation/networking/device_drivers/cable/sb1000.rst
>  delete mode 100644 drivers/net/sb1000.c
>  delete mode 100644 include/uapi/linux/if_cablemodem.h

I'll wait a little more before applying this one, to possibly allow
explicit ack for the ACPI and powerPC bits.

/P


