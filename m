Return-Path: <netdev+bounces-220770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF16B48943
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7853E179FF3
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFE2EDD41;
	Mon,  8 Sep 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wcc1pfoW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29372222BF
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325536; cv=none; b=NpzdmZeMbLK95lSOcCeXDbkuNWj+d5S0p2OWfveTgX+WDWHAaPZ+n7dEdGX15RcLnVTb+Qu/zuU4cAT7IMY7kCr3UbSX8tq2G7x1d1+8q/ERpQ/aMvSlArCLkFXcepyoBgattdsfS3kxtyG+sp/lXw1ASvkaFk6DZinGVUdQJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325536; c=relaxed/simple;
	bh=a6bVpnE3HRsYuWmdgLXEHl1NWYRsqoRCh2FcSf2L0/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=laKLY4t5HTDpCz0H8mHHz/hnJuP4Pb7zIb9WaFMLXQiZuqH1HYZC/AFKQHGHytg9tZSh0iq4UyNSTIrrxkpVlV++wu1A+eXeIN5LPaKHTjNY1EQT41riNiqrvGstzjdxYO2gMJon5P37+0s3BcNHUYW7UuipoA12XapaKjGeTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wcc1pfoW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757325533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AS5TbPMoScatpfJs9X+pTZZBekuU2gBD3oRFuTdu1Fo=;
	b=Wcc1pfoWHAwrlWECrjy/Sxl6AWd+PuzQkm1e4DDTxthAYJVJw4jQ53HLWhH5BN66fEN5xQ
	deAQpVNKKaI9jGn+MOwRnBh3lTgxzmxVNPV0UVmtmyOApl3hmbUg0GK2YEtOdOF4lnMPu7
	XOGOVyF5UWULhPFlns6lW7TZ4dU3qXE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-_FNYPi52MKam79-q8FoC6A-1; Mon, 08 Sep 2025 05:58:52 -0400
X-MC-Unique: _FNYPi52MKam79-q8FoC6A-1
X-Mimecast-MFC-AGG-ID: _FNYPi52MKam79-q8FoC6A_1757325531
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e38ae5394aso2329421f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325531; x=1757930331;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5TbPMoScatpfJs9X+pTZZBekuU2gBD3oRFuTdu1Fo=;
        b=wir6SmiPpZlxWASxquCKYp236+mcdd5uyA1uyD5OL8upRJm6bUqfzBSaMo3KtFXN40
         Gt2zANrC2zXsvg8pwDmUg0buOST2WiiL1fAByoolLZOyFU6op52Bwgn6aAWdjIx1QwGX
         BI01mEewGNKRDlAYxi/KXGHmEVp5x7HGpIbz9TKSGowk+R7bQmLiHQxy+RFKraQljcvc
         5Z/cWPl4PEMqqDrNmBlP3+rvtBtzgHiGTtk/vpWx9K7nSpEo1Xu6kotnmp5fK5Rw3X82
         L42dCe51x/gh3NIrmFdi8u8HJMnptYKLwlHleUceIVqXShJHlsoskDsXJh1KciPCgL1z
         wx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/1lcepd56l7mKQYD1lHvKw66jsogAulf1DSlBUW1zigFodFaG1OUB/xtg+rT1EvO7J8xo6Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl7dVnDfR1QuW1Oj4kmgzg+7W7ETIpXUt91UGzJX8oHFvKWj6
	1fwwdMt0sWfEmLi4evEOteTOuDk81bEFiG2f2Cyc418OvioEv55RqbXco+Cfu0DCgqpAgpGyQ/X
	cNZ32BjtcJ1KZzcRrbY6yQX0sWOvTnsjxPKdq634+YWBEZ35OwpzUdH4A4Q==
X-Gm-Gg: ASbGnctWhEd9GcR17pWYCZnb5OfGPeiuWN5ck5ARLFLZNsMhntH6F7ouRhM9sE7RI4o
	ywm8j/caEOlyBobbFplESLm0iCnJcq2kxIIQtMr81FCJURR3FhhQx70PI1vmquNlUn3kYqweEOv
	NwpH94UlPOisE7V/87knlFB8Hsj02+jFirdFg2yZTDmXXQUMlNHebuAMmCB5USgAwJCOTHVY5G1
	OkQwi2gbF3wNcXZyKGEnE8rsm86KFncbFnJhVD4TGzkzs4B2XjaolEdx5z2Dl7pjYAw9wXkkqbh
	supSkc8dX3Z6ft7PThBtS2IIdIUoeIn9kpE=
X-Received: by 2002:a05:6000:2285:b0:3db:c7aa:2c19 with SMTP id ffacd0b85a97d-3e6428d7ccbmr5339171f8f.26.1757325531439;
        Mon, 08 Sep 2025 02:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzqDPXEG9KjjfatQRgfi7m9NqzdpNSgqCOLY881KppF3Xzcuz+JdS4DCAcNL2JTIUUxUGQog==
X-Received: by 2002:a05:6000:2285:b0:3db:c7aa:2c19 with SMTP id ffacd0b85a97d-3e6428d7ccbmr5339150f8f.26.1757325530995;
        Mon, 08 Sep 2025 02:58:50 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm240950065e9.0.2025.09.08.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:58:50 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Li Tian <litian@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Benjamin Poirier <bpoirier@redhat.com>
Subject: Re: [PATCH net] net/mlx5: Not returning mlx5_link_info table when
 speed is unknown
In-Reply-To: <20250908085313.18768-1-litian@redhat.com>
References: <20250908085313.18768-1-litian@redhat.com>
Date: Mon, 08 Sep 2025 12:58:49 +0300
Message-ID: <877by9fep2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Tian <litian@redhat.com> writes:

> Because mlx5e_link_mode is sparse e.g. Azure mlx5 reports PTYS 19.
> Do not return it when speed unless retrieved successfully.
>
> Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> index 2d7adf7444ba..a69c83da2542 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> @@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
>  	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
>  					  force_legacy);
>  	i = find_first_bit(&temp, max_size);
> -	if (i < max_size)
> +	/*
> +	 * mlx5e_link_mode is sparse. Check speed

The array is either 'mlx5e_link_mode' or 'mlx5e_ext_link_info' but both
have holes in them.

> +	 * is non-zero as indication of a hole.
> +	 */
> +	if (i < max_size && table[i].speed)
>  		return &table[i];
>  
>  	return NULL;

-- 
Vitaly


