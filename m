Return-Path: <netdev+bounces-238173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB22C55375
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CE743469A1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF71DB54C;
	Thu, 13 Nov 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRTvazPw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQHGNEuJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3B1A9F93
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996212; cv=none; b=UMbhxqAT1BkmXXH9CEEkRLdX6RDjO/mVyCPXfyKRo4Qhr6bOPwxHKP5wmj/1KlQsNNBcaK6aXjsK9zjag783oyGppHfF8CAoL3OwVH0Jee65V28QDwCt7onB5QrhmVXX1/71zW1cuMKttKkq6J8+dejnpRflJR0inYkqd2F6f9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996212; c=relaxed/simple;
	bh=WTHbBFat8WgTLz0VXEBvhYA3zWQoc05BaGIUCPm9GuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0/Ho76QjMDsi48gLqskik5oMY0j1sEk1c57N+AnePD/aCrha3AGQgXPaKEBx/JDZoaWy4T3Y7w4PF4MimEURucXr1ksY77o8RQkjFu2UnnFsyu83YP+RtnUsdUi3XOU0TAOv34EgU0ESNUDxZFf2p3JFj0adSwOiZ/Ff58HN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRTvazPw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQHGNEuJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762996209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
	b=HRTvazPwQ+NNh7M+2cKlA/0+odj6BX9/5SV3nXJc1dvH7bRgNAtaRNGmECYos9kUi3xAFd
	Dv0x3zQBN+sbFDKU0OeYSj2JKkg7PafMigvKoBHQ28yBdYH8AqxNLrRV8WjmSt4Hf9GFH7
	TGdtYQejucXR3oBIIZoHFcol99fRvwI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-2EcER8NrNHiVNi7ikMRDbQ-1; Wed, 12 Nov 2025 20:10:08 -0500
X-MC-Unique: 2EcER8NrNHiVNi7ikMRDbQ-1
X-Mimecast-MFC-AGG-ID: 2EcER8NrNHiVNi7ikMRDbQ_1762996207
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341cd35b0f3so1505546a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762996207; x=1763601007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
        b=QQHGNEuJs9LXmrbTdfPeU/WsLfc0MV2BmSRhsV43n5Sei61RwAySXwebzTT+dxBHIS
         DWw9s9hQMk6tDT+zRJyItvktnqkiuRlMTjNVA2FsP5VcpS/v7Y1IAV+GwH6mV+x0LeOU
         OFF5ibqdahqWVnY94cH4SLkz6lngfEphcRfHlDMAIU4dtYd4v9xSgn9EMijTEnwo/jOw
         S7zCSdq2f/7vacnaOIXSDoEeTU0UYJWNGVT+fJraWbmIUT/2RwKs37j+TTwoPRsov2ai
         lneivCM61zIv8ONy78vt6iFoSMjEWgcV8shQDGl3z7+HpIgzuzWCl0PZHzNgkq6O+bN3
         jYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996207; x=1763601007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
        b=Bka2lz4Un0Na0NtkBjFrnac0sp1CoRSjuSVm56zcWmHhQ70YGX8hjN+S3GNNPwpA7S
         csMgRLItIssw88zQ4++s2NMG4nXiJvv2wXYssURMF6fiwc8OqSm1OX7SkF54ryWIN5A9
         NsMAg7rwhjtpKAaFKnsIFiCGLJCEBKIkjNBrPoPaYGv595IfwCz+eYnbTTkuEnXdJy68
         WD1N2fxcxrNDiwkadd7WyjMQyP7R5ZiXU6H4z/s6e3qaQGxREcX/zZb0md0fZk+EBeGn
         7rY0bES/4Uum5QDiY6mizPvLAcaVf50TA287wfu8tWrXwAIht5IyC1vNL+Aam934O68c
         rVdw==
X-Forwarded-Encrypted: i=1; AJvYcCWW4v6VgF0cpstNEgw5JLzdZRJjw3p7EF5/SI/NBSzskSUUwkuBqmc7tum4Rrfco0JwaSfRodQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oXTx/cnBm2ymhDCaoO7WzgEmtuBO5XikXDG7Va2veq0CTAGP
	mUQHU8XWPZOWHyojfvGHgZnMyl84VlvjY+O+XZnxq86AbqOzpapoKtGq7NZHcfaaOXC52jggu7t
	tM8WudmCnCndeUueEanNFZl74lGWBgC6A4PcAzMWMw5Spp1UOaHFFZAysXbpsbhqOGUd3oEPWQy
	PXKvReQHV7qG4HviTuT4fGzB2Vmsbl2DoZ
X-Gm-Gg: ASbGncs1YYfzcvgepGi9ZSGv0/aNve4MRAsxAO3Muz7ba37EqtEfCqzlKtt38873Ymq
	ZXemu0b4IMYAH1GPYLTNBdb+qw4DorFEmb7MqWsMO0vK1KZUPn6r6j/NUB0SsGFdE4wj6yVBn7C
	v0ZzQW+09sn8NiaD0pUWXTIn/TlHXO8RCGGUca6or6NMkeiFD2lfBhBQ==
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-343eab2d6e8mr1479309a91.4.1762996206963;
        Wed, 12 Nov 2025 17:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ygtEnet5AzKgZkKuFsP7FTx9uhPWvwXy5utv/ipBEByquxKdhaAV2Jg/+1bKSY7kHGa3WYdxox8Xs01KAxg=
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id
 98e67ed59e1d1-343eab2d6e8mr1479275a91.4.1762996206546; Wed, 12 Nov 2025
 17:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com>
In-Reply-To: <20251113005529.2494066-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Nov 2025 09:09:55 +0800
X-Gm-Features: AWmQ_bkNFI0Uak0BVc9mmMYVp98tX8j2dw19j09dCC_kLqXSmWRrmqmpo5b_MMY
Message-ID: <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> ("vhost: new device IOTLB API").

It has been used even before this commit.

> In a heavy UDP transmit workload on a
> vhost-net backed tap device, these functions showed up as ~11.6% of
> samples in a flamegraph of the underlying vhost worker thread.
>
> Quoting Linus from [1]:
>     Anyway, every single __get_user() call I looked at looked like
>     historical garbage. [...] End result: I get the feeling that we
>     should just do a global search-and-replace of the __get_user/
>     __put_user users, replace them with plain get_user/put_user instead,
>     and then fix up any fallout (eg the coco code).
>
> Switch to plain get_user/put_user in vhost, which results in a slight
> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
>
> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> RX: taskset -c 2 iperf3 -s -p 5200 -D
> Before: 6.08 Gbits/sec
> After:  6.32 Gbits/sec

I wonder if we need to test on archs like ARM.

Thanks


