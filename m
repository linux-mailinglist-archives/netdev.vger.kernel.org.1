Return-Path: <netdev+bounces-246872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE6CF1D2B
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 05:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5632F3007C8F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 04:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCB324B23;
	Mon,  5 Jan 2026 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ho85gyha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE048324712
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589036; cv=none; b=WqBfpsqci2rr5dH1B0HCAgQWxz3xWfKHFqGfd0kJ5OsGjDOWNM1lBA6sKDqhHftfTgRt74obleVhYP4KsZFJNs/hb1A3aUVIYG75kmAemNNSAjkRTPt8cxui5rfYQco4LuJ09XfAuHPt8NFkDXnJghF+tK+86sHmBDPEDYJ9NO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589036; c=relaxed/simple;
	bh=wdM/b8hJbUaslNLfaUyaSG8t8yHTFzri8J0kMFatf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVsJ/vNnbigmT2d03o67E8nIIT2jYh/TP0UaCI1FslmKGrpHLabVt+PA1qQpqjv9UmK9eez8uUPjuew/MYb0P2Y2UbSsDrLOSJ0GAlZfBzwUb2KBzq7N47a/akdEozEWzEnwWHjNJcjV9t6TtA63EUmOqJ6KlcChHuc7pRrNzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ho85gyha; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c3259da34so14381860a91.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 20:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589034; x=1768193834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=ho85gyhaKzhQd2LkobbDGyUs+P/owvm/KOpiZS4dO+Gf4YuFWvgFamob9qdCJ9r9lk
         CLr9/RyFtHqQFUBotNoAM7KhHAtZt1Jp5d0KrfTfEbwagr6SxMdsx/4fE0BSAkcxMDYW
         hBxIWUZzrdi1VxRIajuMMCUWM94J/ABCw0OqR1S9Q7KJQTpTvaIEnHNlkPc5J/4jESGd
         XTIkIW6zDUqzcVTAuqoCRGwL3BR2rGk9MaM3FmQJSNYeqluqV2cf553LNAaO+Ru5IIr6
         vpnPaBULT5dfb6ydqqvBTOTjU7RSO1ix7RqULQUiOx2UaSolPasj3CB9WpJAXHp8n2jn
         ZWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589034; x=1768193834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=wEUX1tf37D+2bmPOmu5Ux+BQTLq8YLfM2frLarEFIl9+FUyY+dkx2bqivGJmrWPKar
         kGsmsZXWIuhVNfbfwa+k/2mD0YjMal529zu30eddqQdH+RFvTJeHc2iq2EfAr1an0+EH
         mxQVIymT7ZJC0vQ6vlB6xT49b3awbUomqqoUc08aA8RFcRFLZBeJJtHt8S/bcOG4ZzmM
         q0i9hHIFQ+enc7cFahqyC7tlOqZAPL+p9jkDUxJG7qAdWWeiQPZoFanRwNNqrnqIeEB8
         MSTW8XZjCxyZ3DaVLlZz1QXccAOy+UeKaBBTBJ/VNqtkyZKG54We0jm64jKObYXlD05x
         r1wg==
X-Forwarded-Encrypted: i=1; AJvYcCUdRlAx3ccZZxYNG+/OKUzknAiLG0thtc6rJ7otazKjbgnI1xl5n7mYFPscdAoXU7FJoDk+Rw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnYqxDL+KAD26CjegYOT8Gate4uqh3gGEg2kLRBjRmlhdC+Z+
	duC9a/9/Q4Wd/7vFozgiIm8De1Y2KPwZ1OmMPw9ocSq7THJYJrE3sj1H7MOXrMfuk+M=
X-Gm-Gg: AY/fxX5CJAZPVnxK9xKvsSJOu90iNKiZifMEN1wwWe99b93QqxrYRul4ajcTNsBvrJe
	zD2WcNxNli3qdPqUUZbjM71W1jP44Am/UpFoCooATbITImHJZD40HT4KUKFh+vHLFR2bXSAUl05
	7BayKutqZxYODb4y/58ZRJRqXtFfKNVEpL0vQHV+YRxNPx+1D0FwH71J8dnj15UHEaQUr1nC+Rz
	+B+J5IucXoOX9dA98t5SfKSXlsAux3eHR4ro3xfq9EgSwWE2bmNgk7dhsZ2UF9Q8XV0JHHzFSPc
	8NFTPcjBkhLjphawKWMFRYRHet2AKv+WZ2s2wzAvOErzAchPs9JClgE18D8y0yk3Or4a8+1qgQW
	v0ZCmbJlywCMXkVr12nV3Aoo2Pa8R029dfTFq29QajymaoPEfqwNQesCf/q1AbEgHedXV4pPO36
	/RP+psNx70wmHX2u6MODkAQw==
X-Google-Smtp-Source: AGHT+IECK/LcBFPZYYyRh4cCx6nIWU2Vivu4V4Wo0++VXRb6DotO+ATVsJPLekWH+2yfoIoKe3qHow==
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34e921f0439mr39742351a91.35.1767589033897;
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec31dsm4899585a91.3.2026.01.04.20.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Date: Mon, 5 Jan 2026 10:27:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <w6to6itartzrxgapaj6dys2q3yqqoz3zetpb5bejnjb4heof2c@jkhmal3chyn2>
References: <cover.1767089672.git.mst@redhat.com>
 <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>

On 30-12-25, 11:40, Michael S. Tsirkin wrote:
> Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> last. This eliminates the need for __dma_from_device_aligned_end padding
> after the DMA buffer, since struct tail padding naturally protects it,
> making the struct a bit smaller.
> 
> Size reduction estimation when ARCH_DMA_MINALIGN=128:
> - request is 8 bytes
> - response is 2 bytes
> - removing _end saves up to 128-6=122 bytes padding to align rxlen field
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

