Return-Path: <netdev+bounces-129645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B998516A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 05:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3643C1F24AA5
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 03:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DA14A4D0;
	Wed, 25 Sep 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc50jO1v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8E2F52
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235027; cv=none; b=KdJBKeAbSs/bWRuUH24COj1MhIcpI4QcZk/cD602AscIP92lSk+VytOiCVGD4XUAjVHfzy9bst6dXghNGFbzPptRhodYSexjVRcpMTAl1LrFlTdHjyVM9ek1YTLjYLRr99VJdBZ665ePV5eJUBRkUkSdqv+2tuJ4uLyL7UIz3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235027; c=relaxed/simple;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxguKGoP8K84E3dFHxzaYIk8aL4+MI8uQWik0CPU958qkAO1zszqCy28WgAeK2haUTSOogejmcjT6gryuGcztRIeqsVTrvB23IqV2oFcPrE0rzghnZkDWxlOWrmPx/9e4MpcP8UEgfp3bhd1GE0V0OUbvTcPwIZmnLl6W4RNGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc50jO1v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
	b=Cc50jO1vwKFaEKU2XlDyrbNt/ghI8Q4f7OyGi9IdYTcKsiVT1tASj2oYd0URyrZRUE7e1k
	5Xg3T3sKJYlPAyDMdt9z7r6570YQXa97L6GW7EBMhp5bQ1Y3llL19jXoLqYbkqozaQpyDb
	IvLuAhyly3Iw+ra5b+DjdRpRwy+KIH4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-bSPyuDnHM32rIiIlglVrgA-1; Tue, 24 Sep 2024 23:30:22 -0400
X-MC-Unique: bSPyuDnHM32rIiIlglVrgA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e070439426so349466a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 20:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235022; x=1727839822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pj+RCuXouKWKKmVNJjkG4mjtgCiJqE6IxJ4EvXxnE4=;
        b=ALzZsdYQFcssl4WIheQPHf7AsZhhQNjCqvjkOBQWUEZ9IsJN8MbKL/Y2rLDaUxPIMF
         8fC3cXG8BUEOicW8kB8u6xdDngc72TMawgBPH5kuZ16Vad6ZSHzIitGYAvJjsZrtozs2
         b7++pEiq1DhMkxtyS0wabhyF8zlE6JemOgDCkvmGFFGo5MY25Ub1fDloDWB8qD0zh7ng
         V8JGZoqUJcA95xBK4Bb2+3TqHCKv4a2mJOBgC0D6faI3UJeHMXI4kgQrrhbw0o+oweYZ
         IDBx49rAd/GC1cCQmh4t+gnuGECB8y37foW7+yq+wkwjDQaogbdJq8nnhCnSpMOYng+/
         tMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9LExV1Kvi/QCaiuP5AqCK11+pc2weVYGpiPIQZujK0xe+30qXfRIvRzSM2pyh7bveLONSBfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkQXkTx7y5GxTA9MO4oxvSHTq8InpLKG5shzHHJDCaepmGYwc
	O7bbzgSkD5NUuAPlxDeyGKEBIrjAYC+FPrCoNagPGJFMEsJDfRYRugMEp7U+As1TjRJlwtDgFxj
	T1WMfJILQhPNNWJPk4Rax6Hkh5/ADUx0w9W4mpWfvSsffLjlCmkfi/jo6bfFMNBPcIjpbYFnSsL
	x4Z77zN3/3AsM0AhMN9NZskclhjzMJ
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id 98e67ed59e1d1-2e06ae791a7mr1467803a91.21.1727235021749;
        Tue, 24 Sep 2024 20:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt284MvmYUlT8+AL6adgtTv8NmOQ1ld/MsvwYgsNGC040Pi/BgPI1vkZfb6OO4Jtnfla96r8UcK+AJSx61zg8=
X-Received: by 2002:a17:90a:f2d5:b0:2da:905a:d88a with SMTP id
 98e67ed59e1d1-2e06ae791a7mr1467782a91.21.1727235021240; Tue, 24 Sep 2024
 20:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:08 +0800
Message-ID: <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>

I wonder if we could clone the skb and reuse some to store the hash,
then the steering eBPF program can access these fields without
introducing full RSS in the kernel?

Thanks


