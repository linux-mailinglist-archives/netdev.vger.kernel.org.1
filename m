Return-Path: <netdev+bounces-164964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F3A2FEB3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F21888C67
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF215ECD7;
	Tue, 11 Feb 2025 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX5WbZS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D30AD2F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232080; cv=none; b=mKgBsHhBS0Lj07Czc3sWyCCc95Hk+yo1W3X6ZLgBDKVCIkNaxxVS2ddtXj/LUQaNLrsSGclx6Ly9juditoe18B9L+p/PmVwrfIR0iGq7HMKsDHMOfB+3yOmwwfqupzjkyMXGhCNiBjGBJ+gS/J5JHoB1kKvRaiskjw55E+OEUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232080; c=relaxed/simple;
	bh=nJ6LzyoeCFVUzoZJxDKWwrZWehljrX0DhSYi/LN5Rh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHzcKT2Y0OZj62zkK2xvvENRr7C17Qpw/pXVERbL8GR+OxTDmhLJUbeXkUwuMVvY/WaLZ/h8Ckg0hHvnrmEJFupOHJn8BrB3t7ukz9U992xgToHFhf1kc7tuavgWasIYrAAjl+UihdrfT8lo9qSbj/POTCjRviX3RjGkayrDHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX5WbZS+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85527b814abso45078639f.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739232076; x=1739836876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+6VjZyKkm05cc5abGkcRCYDQiyuvjp7DI1YWDZerk8=;
        b=iX5WbZS+JoAYBsgYxpl6YrW89+p70yhF992Vocgl1ivjdsv+Satdjm2HcL7lSdBpl7
         SOEeJpC9dxduVk8eQbhzyGyfRtI84+H8+5zVdhqxsg8ct01aHL96fo5EfI4zNh2sqSHt
         2ceVv45CI4Ub4aUp0R4dRks7NoYYo75pH8X8e8oERVapjcQAP8w2P6rkqKdcU30iASKB
         bnkSFwH7cSU2GIkcpT4SWfGfI6lo2RC0NJIfZ7o47OQ1zbtdZk6/ElOdg9qhjGEr3pPw
         OEvhYdS8nmV2sUGoqX5JwZAT7qFttafzr7Hzg/uuJ04wWSkdoY/dAKjaaLRal6NOeg2+
         N7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232076; x=1739836876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+6VjZyKkm05cc5abGkcRCYDQiyuvjp7DI1YWDZerk8=;
        b=mN35h+tePZNmTqwnkwahxa0hX96Br2lXkfQ/4m+f1AzHv+IE6jZHmquB2x9kkAOkQj
         aizrk0TDC5PiL0XlxwYjihlnj0985ljvWODVCWNlYFliF5vb+XlJtPcJafBofgyKMswt
         AoQmUuXoTKhfXmNOg1C4Otm9rhq9C8N32tGx1KKoEGwGC9UXxv/7ENkJMVrUtE1jnOXZ
         TzGgKt4eeKO0LB8g5wFelEWWlAejcNf3dgGfTIIQBXczeXDz2zyfItU6M5dixgRvZI5z
         zcUA1EC+0g6gMB/xzbOwbu2UCd9b/z/mTXpimEw2/zrkEVAmEMNqDCkTVSMRlUBhktdU
         lpVw==
X-Forwarded-Encrypted: i=1; AJvYcCV11JkYQddS//CQp9biYD3Cn96YzDmcrfWqDJLEX2TVqMedphI2ZTSggyO2g85CKnf2F3sUeSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48B0fP30lR7uvcJUGWkEvZchc9ckKLEpgb2iLtolTUweVRb0K
	2kbUxw5P6l/LnofSMH/6l98Yhby3U3JsnZltgS8gcgzZmazWX/D0hdn9uyhGkQ==
X-Gm-Gg: ASbGncvLF1EPTKJKBjewb+8v7PFOZ0cs4C2mZTfMyaPCcX9WqHYdcartx0RRrVjtawA
	oOiBwr1V5oUuGfBOdkF8kuAR8DP3tR8pn42OckvFiQoBYt+A8XD4DV8ONgnmtv3U//1MfSdPKIH
	bF+2LghPWua8q4ZmryA4L8mdgAL8+DNnsRQbfbGgwyp3gqmw8VxHsgdZkClT0Q4bh4/aHsUQLID
	U9unM0BlHy/ffNfg5LH/6k+G7A9eKCNlTnF87jICJZviy9QDCV9sRicUzfKn1NCD/SbT4dslxaX
	fsrAjl3o4J64JOQrvln+kbRS9+SkgEQCseJ/hPket3m9eZBxuzeYteM=
X-Google-Smtp-Source: AGHT+IEPW+Dnhu306cg6k4cp4JKL9h87jLz1ibbxMZeZMr5tSf0uulSyxZPsQKhKZyhcDka4DYJs9Q==
X-Received: by 2002:a05:6e02:b43:b0:3d0:23ac:b29f with SMTP id e9e14a558f8ab-3d13dcee786mr134115905ab.1.1739232076020;
        Mon, 10 Feb 2025 16:01:16 -0800 (PST)
Received: from google.com (143.96.28.34.bc.googleusercontent.com. [34.28.96.143])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecef0c9674sm1185594173.117.2025.02.10.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:01:15 -0800 (PST)
Date: Mon, 10 Feb 2025 16:01:10 -0800
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order
 value
Message-ID: <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
References: <20250210174504.work.075-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210174504.work.075-kees@kernel.org>

On Mon, Feb 10, 2025 at 09:45:05AM -0800, Kees Cook wrote:
> GCC can see that the value range for "order" is capped, but this leads
> it to consider that it might be negative, leading to a false positive
> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
> 
> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
>       |                                    ~~~~~~~~~~~^~~
>   'mlx4_alloc_db_from_pgdir': events 1-2
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                     |                         |                                                   |                     |                         (2) out of array bounds here
>       |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
>                  from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
>   664 |         unsigned long          *bits[2];
>       |                                 ^~~~
> 
> Switch the argument to unsigned int, which removes the compiler needing
> to consider negative values.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
>  include/linux/mlx4/device.h                | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> index b330020dc0d6..f2bded847e61 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
>  }
>  
>  static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
> -				    struct mlx4_db *db, int order)
> +				    struct mlx4_db *db, unsigned int order)
>  {
> -	int o;
> +	unsigned int o;
>  	int i;
>  
>  	for (o = order; o <= 1; ++o) {

  ^ Knowing now that @order can only be 0 or 1 can this for loop (and
  goto) be dropped entirely?

  The code is already short and sweet so I don't feel strongly either
  way.

> @@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
>  	return 0;
>  }
>  
> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
>  {
>  	struct mlx4_priv *priv = mlx4_priv(dev);
>  	struct mlx4_db_pgdir *pgdir;
> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
> index 27f42f713c89..86f0f2a25a3d 100644
> --- a/include/linux/mlx4/device.h
> +++ b/include/linux/mlx4/device.h
> @@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>  int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
>  		       struct mlx4_buf *buf);
>  
> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
>  void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
>  
>  int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
> -- 
> 2.34.1
> 

Justin

