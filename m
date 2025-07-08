Return-Path: <netdev+bounces-204846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F107AFC3C8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2373189DB8B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A693255E34;
	Tue,  8 Jul 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqEmhAuj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BD2566D9
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958732; cv=none; b=F8X1TvYDtjtr62ppFyYCFtAOrPlebqctNy/zbNJW8XkpEf+Ni0Hx43dTLf9yW/nGUDQ73+vQkHqymd7qictf5ZUYvT4Y3biwyd0wpTUD8v95/NAE8VNZy3/xtzSLrs23zDB7Dr/Ul5nnMymK93kL9s+ECAM8JPNPHU+JBEXjbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958732; c=relaxed/simple;
	bh=5lwDy8ZYNMTW4ldI2+BzIqOokv8FO+QSb76sSEuZo+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L7ybnz2GcMMnU6Qf3bZ2wGb7JBQDHNbBK9SF+WwQB9iQWP+DzJzmWNt0CNTVHmjhiqRVYZvOyE/7UPMaMKx0bqcJ1QoAwiXdcdwhTUYs+elUw5TEb4IcWB7LMTlZrlgShXtlJhrVES8FUAhQT/uBYCyjYNm1lNsjUn28aVVKWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqEmhAuj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751958729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6al2WSZTd7CdtJL8s2F8tIL0jpPencH2sAuuH9551kk=;
	b=DqEmhAujnS8O6pFYoaf88NpiM7i5Z3NEJ2IhKI57mHxO31RTRjpzwNnNBemDuUNZTpvimi
	7XKeJB1NAuEX26onLHP/FOTA07s8/sL4/5JlrqUOpEfnhzCHDTbtnNO5IbnQtYY0JMxPHS
	Kp6ltTtkYlA98Uy6JvwGii9X/KNEgt0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-2QQuJsgAPU6mekACsCgc2w-1; Tue, 08 Jul 2025 03:12:08 -0400
X-MC-Unique: 2QQuJsgAPU6mekACsCgc2w-1
X-Mimecast-MFC-AGG-ID: 2QQuJsgAPU6mekACsCgc2w_1751958727
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2297466f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 00:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958726; x=1752563526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6al2WSZTd7CdtJL8s2F8tIL0jpPencH2sAuuH9551kk=;
        b=cfOoJpZbnDAuhxrF6+qlOvzWk9gvZ/PjrgA0rhwPyPPLWI6dP4yrRLgsX3Q+tSqg4i
         8jRQnwYVN1q9w6Eqk36kl3f3C/AYkx0+rImKgk2qlIAAPH41PqXbguS7s4tDEn1+5bKQ
         qsjbSV2hdLHKxuZV3NUxVeTxLx+HMOGc9OMSUJJKY+gpwULsyyekJKgOTWbNd/UEUPUW
         R9QZAjlt8E83e/D24qrZH46PqQWDMornqZMYYm9DMtN6SvqH/d+myjKEdMSjySokKu22
         SVSlI/vpCD/yAsGBUAuzFOxYKn19ahrBFgo76OP8w8VxMB2PbUDKd9VlyiVQqfQ/nB3D
         nfhw==
X-Gm-Message-State: AOJu0YzhB3ny0Y31RT+W2MXnA8NmgUNUJYCZWzuidYbfIE/se0/tnMtE
	8bu1SrbGYaxTouiOK91r6tvwmVzNcCjGOKhnCKkgwbiVrZefBfHvwutLOJ5ha53EEEJGlYatfjg
	Pg58S1cBRIQImYF0N4ioCTyV/X8bcsJgJHeP/keyikePf8Y73XUGgFmYkDa3ReTf8Aw00dM485a
	4EFbd1yFdIF0Z0mWSGNJq78d3Vtl0wKMFrIXF5CEs=
X-Gm-Gg: ASbGncudRFtEZdy6BByO4ePRJvhHTnVUXCQ7mykvzuPa3T1h1MJPIoT9jKPwCf/9wd7
	ZWCVmdzWmeWcCFwrKQIjEmy5195Z4sD49tEFFx1pf0i0ixon9dW0HxzrMmG+lLq8+l6l9sXqso6
	6X6pAJHWY4fGDGenEc+jfM0Y3msaNY1LlSM8O+HDW/CT7myeKqJQGUV4EDiUuGP1BJOOBYuKf1v
	MJBkmiiuBpPkX67pnURg/dPXCU+4Gvw6xJDdI4EC3fUkrAneBIeUFrGb6TUheOroUeI6MBaXgQb
	s2kydx6n3w+hovk9l1o7S3UoMsta4E9hXr4qZS5Uw+8fCiom82qszHOJaMBjuhDOJeuAVw==
X-Received: by 2002:a05:6000:2289:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3b49661da34mr13442621f8f.45.1751958726433;
        Tue, 08 Jul 2025 00:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUa0YAy1NBgIDOiXc5gNSB+BOVkjsJ3ZjAZUt++LCSItxzDjYj+HoOIwwZ6aldycNJxaG+/w==
X-Received: by 2002:a05:6000:2289:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3b49661da34mr13442567f8f.45.1751958725979;
        Tue, 08 Jul 2025 00:12:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4938ffsm12723525e9.21.2025.07.08.00.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 00:12:05 -0700 (PDT)
Message-ID: <41eb8d72-bfa3-4063-88af-1ec23593b0f8@redhat.com>
Date: Tue, 8 Jul 2025 09:12:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 0/9] virtio: introduce GSO over UDP tunnel
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1750753211.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1750753211.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 4:09 PM, Paolo Abeni wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
> 
> The virtio_net specification recently introduced support for GS over
> UDP tunnel, this series updates the virtio implementation to support
> such a feature.
> 
> Currently the kernel virtio support limits the feature space to 64,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69.
> 
> The first four patches in this series rework the virtio and vhost
> feature support to cope with up to 128 bits. The limit is set by
> a define and could be easily raised in future, as needed.
> 
> This implementation choice is aimed at keeping the code churn as
> limited as possible. For the same reason, only the virtio_net driver is
> reworked to leverage the extended feature space; all other
> virtio/vhost drivers are unaffected, but could be upgraded to support
> the extended features space in a later time.
> 
> The last four patches bring in the actual GSO over UDP tunnel support.
> As per specification, some additional fields are introduced into the
> virtio net header to support the new offload. The presence of such
> fields depends on the negotiated features.
> 
> New helpers are introduced to convert the UDP-tunneled skb metadata to
> an extended virtio net header and vice versa. Such helpers are used by
> the tun and virtio_net driver to cope with the newly supported offloads.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.
> 
> This is also are available in the Git repository at:
> 
> git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_24_06_2025
> 
> Ideally both the net-next tree and the vhost tree could pull from the
> above.

As Michael prefers to hide the warning in patch 4/9 and this series in
the current form has now conflicts with the current net-next tree, I
just shared a v7, with a more detailed merge plan in the cover letter.

Thanks,

Paolo


