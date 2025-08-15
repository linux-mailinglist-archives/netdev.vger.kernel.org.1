Return-Path: <netdev+bounces-214143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2703DB2859F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A42DB66234
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D64308F0C;
	Fri, 15 Aug 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3ThbT8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C61F4CB7
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281477; cv=none; b=NbRZYJI63Vb2X7U4lXKGIl6MU2X6kMOdKF/gunCsj0BVGCiZB/1W+NQIrTOCBpLaQw6hN4cuCISf0xsl5V0p3+QoTPY/gQHCD0QDbHIKNmT67RJpSnRKspN04n1TTh0APtW4M83zs3NMlMVpkqUfPtdoNxSpsgGiSIzfsDZtyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281477; c=relaxed/simple;
	bh=YUKUSbRQfcRJYGciznGAVEEc0k853SnsoMEbrdMrwcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOTEWyqwOqGW/U/Vg7jQxn4biRhVgPP6RuIjVAUsu7SZz1C3dSrB/kSrhwWwnW2m5QXzv6nf91LbnP/b3Cgnej3O08Y1m5N5Cgb5eNYjXhg6PjE1TDpV5W/gEjwjExPAPj+KaQoRJ3yEef8Iig5pmF++TvBge5XK0k61Jj9824M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3ThbT8n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cdfd57585so735e87.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755281474; x=1755886274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T68Dg6hVyJ441LRbZpLNy1OW7oXBwA3ETEmAc0Ulr0o=;
        b=Z3ThbT8nxFKAqRc68fmqDQtTOXQia7vTt+n3570y4ciOA5ZZeKgFSc1F5WvxpwTRLP
         CliQJtGIlnMuveAAjh38X/hh9J+e+/72HohYlkx0z0+Jasb+H6e7g9Ir9H6GSiM28i3Z
         kCbINnroWMb/TJWW7ka826CvfMtJ/5si5tLUrylQrAZbusLNa0WrQsleIeSx5LgtbDvE
         U/CJdQ99oiDULfgQAlcVQQS6BnWGlvmdkCSwxPpBnY7CMkMLQG+hcrsOXKKqy8yAqRAK
         fKpemKU3TpvZdBTnZvpANDVXyD9CwTNVQHUnJbcqczeHgWAWaSwxwljUKvgvgbVhi8oE
         Ad5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281474; x=1755886274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T68Dg6hVyJ441LRbZpLNy1OW7oXBwA3ETEmAc0Ulr0o=;
        b=eFUtnK6aqEhGvJW0NUJTF/Y+7LOQhz6BIfrWmI/i0btLoWbp1tUfqET5DeScfppCS5
         yd8Zs8uY0GaFm+EnK9sEP9oIs4eLe0y/v9L5tUpM8jLJZAJzBccBohluGbswyXbNE8jM
         v304T/UP9gWl3r9pQH3OJkn0CI95zPSstjnjXv9gQw3HSxJZpVBbjREefkD0vfMsTrT4
         UHFFTmlZcXiAF3HmUACx6PCI14UYu1fO7AEJm0H6KVbjlFTg8CF9iRUhGsVaxRgiQzOo
         gsHYwUgBoWkPepgJQgAX9EZ0c6HfaPvvFaSQpEc+9bQdyvpvZtKDA/DzbFN6aqp+gzRo
         5/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW/X8xeEtEvg2iFVrtnLDiOebT5VfQpbrKR/wpgpQDXTGm3khXP4MbFpngjXvldCDOrReLSeWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67i6NWASKWOBsWksuWMXjG9N4mFL4nMgb5pOvtiITFHdSJHPK
	eEnBbCKHz4k0pRSzG6IQ1oqnAbUcbJrStZLwz1GrDrO3Saa3KgXkQFr9N/8hI0iTtax4xX8elQd
	fCMIWrwU711srR5PehwQ+64kxVbyABMpqC0+d6HZL
X-Gm-Gg: ASbGncsGFwPjswUTcsVkjkhHC9nfx+QQS1XnG0eZC4nwk21Ol52vqMAad0tjyCj62xF
	RUF+D4XWHL/4MnHpSwTWjmuZNT3t9UkdF96Xo+y0Ucw9tIBj33vijR75R6IOfxtHOun3G0vjU2R
	aoLEu9yjdRhu+ymyj3B1HLCGyLIQ+fsn4i+hjRMRwKo9bSypGodaQFc5pY+de1QJGlNKfP41BU9
	ijeqoZtY1FMZrU2Gy3hpyxnBteaDnHT70cXm7lQoYmbJFvwR3u8j64=
X-Google-Smtp-Source: AGHT+IFKSmNdib9JB61/Sk5lBJhAw12y8lbJAOgUf1Yma55YRjuud6QCO+Mmij3jccXJX6bX+I50uwE4rmdKjqjsuF0=
X-Received: by 2002:a05:6512:1356:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55cf2c27bc3mr19695e87.4.1755281473611; Fri, 15 Aug 2025
 11:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-3-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-3-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 15 Aug 2025 11:11:01 -0700
X-Gm-Features: Ac12FXwk5b4oDrlN4o9lHNf2J6UFW6GQVb9w9DkwAbXFitVbE53iDNwZghKWV4U
Message-ID: <CAHS8izMdevPuO4zFF9EFP2Q7tdAUk+w+bMOO-cz-=_N0q0V37Q@mail.gmail.com>
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> - Scalable Function netdevs [1] have the DMA device in the grandparent.
> - For Multi-PF netdevs [2] queues can be associated to different DMA
> devices.
>
> This patch introduces the a queue based interface for allowing drivers
> to expose a different DMA device for zerocopy.
>
> [1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switch=
dev.rst
> [2] Documentation/networking/multi-pf-netdev.rst
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  include/net/netdev_queues.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 6e835972abd1..d4d8c42b809f 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -127,6 +127,10 @@ void netdev_stat_queue_sum(struct net_device *netdev=
,
>   * @ndo_queue_stop:    Stop the RX queue at the specified index. The sto=
pped
>   *                     queue's memory is written at the specified addres=
s.
>   *
> + * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be=
 used

I'm wondering a bit why this dma-dev issue exists for memory providers
but not for the dma-dev used by the page_pool itself.

I'm guessing because the pp uses the dev in page_pool_params->dev
while I implemented the memory provider stuff to completely ignore
pp_params->dev and use its own device (sorry...).

We may want to extend your work so that the pp also ignores
pp_params.dev and uses the device returned by the queue API if it's
provided by the driver. But there is no upside to doing things this
way except for some consistency, so I think I'm complicating things
for no reason.

I think this looks good to me. With the helper moved to a .c file as
Jakub requested I can Reviewed-by.

--=20
Thanks,
Mina

