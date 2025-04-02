Return-Path: <netdev+bounces-178839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BCA79271
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EB1895B08
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462F1917F0;
	Wed,  2 Apr 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="a+nRQyLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7D190462
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609005; cv=none; b=WZF5eyrIbL8livtnz4Bl2eGEH/twtJS1pyjzqqHP6cao7hZO30GegTU3dGyJ4KUvvFZj68EYos8BODxiiuz8Pr/Vq4ZQp4P3MP6/ibbnKsMPWCJhD9WkQL4z8+NSZS0wAJt9Ou54H5jchH9/yZc1GBsI1tfYq/H1lVwjCLi1dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609005; c=relaxed/simple;
	bh=9AxsPXpV33aro4Ehcz2kdnc997kXrIf8ngyB8rmtuTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8wSm8fojUbq1H2I5Tp5q4hkpE+SUfymG7n185TCaTN+YRHO3sqvpM8BEb/CLcGvGauCf3hV/1fAqAnVDvm+BEnHttg7PPqqF5i4yqrzVUgfJi+zju9LL4l51CBg8ji6i2Ld2rghfEshY2Ou7A+qZ/14r/f0FnloKeqAkO8hBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=a+nRQyLG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-739525d4e12so344021b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1743609003; x=1744213803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tts1PyQeFznPaCzX89s9ejnq18G5xStDhXIRY8gowkM=;
        b=a+nRQyLG2PBgSzkwuJgMLJIQNg7taSkiw7QXwh/MIR4zvWKkmwHFWTKpsJjrkNpftM
         OKy7Cr8DjgJHNYThFvfrVlcxYORtlNZkR9pdxXrXgFmSTU9jhdVEbCxmGu8IJiK+E2pp
         718wxdWo9hdiIaxgHjd38Yi+4mWqW4ARzTYd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743609003; x=1744213803;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tts1PyQeFznPaCzX89s9ejnq18G5xStDhXIRY8gowkM=;
        b=aduKYdAEbnAevvOcdd4T/+IcEfrkICxl1xMLLyFakW2idgcIeENrI7CzIkrwkz07OZ
         EevMmIcLGVUelav/mkEP56565BYW64ZAEf6VzL+PNEr5ArCTDI/0uUZh9vkhy7QQ4eVH
         K16VVBDmE1DhNQYB7x7ruMw1v/byRd6QOfgTc2VeCNPg5adynpd39WeNqZmu4TGmJKJd
         WQFwCYTmI0dPAkKC13lSEI0bEK+bzKM1KEpKAX3L1FUQFKDQ0AICLY5UQ1suK1iOPzJX
         kkJzMlULzav3IjvPuBH0SD7eZE/+NkvFtTMClWGP69ea86ZgOF/gYeZytcWxdKvXeOeW
         tVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgLaw70fiphjH7vgT07N/5Xr0LD8qOYUflOjucE+YmlA9YBQZpJPZI82+SfNJj0E1O9ZwfxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGcGYLmOladaY0o35AHES36oKv0+ChAUOso6lbUtaDfIreKsC
	Y/k1Xi9TlQlpkiGF2zT0XIU7qroiJFSD5/zAHw4yJHEN4OLCRfHPS/Vof8/2Q/8=
X-Gm-Gg: ASbGncv9CVs/Gu3VG56OLmkOZT3YYlbnsTk5Q1moTMfl+bcDk3ywq4Wx07xF8y5qJUB
	rvyNcSHnIRF+6IKWA8a3avxx4FbIyrkJQVWQTZV0kwizMmcZ/K7AG7e+0RwXTnNHlCf6wwg1rgn
	4XaivrZwrOlu84da5TKTMvEfD2EHa4uIdA8t1fMmv1A7SR2wG65cW1bGmmPFg+myfmgi5YXFqp9
	NZvuE9iamx1sD0ZJ48SPFw1cnnnB+Aekr8oXDew1xcwDyUvKeruUk1cQferYtriC04rVU0K6rRr
	LSQ4I6Yn+AA6JlpIXUXBrDDYVFojgx4e5XYcB2CwD+sIAPKKViClzA==
X-Google-Smtp-Source: AGHT+IGZ1aQVeL8ZtNpOc9vdjnGS61ySWE+2f6wBfYggOgsl/7d3plYh+nmllez0zd6VBQlgQIBh4A==
X-Received: by 2002:a05:6a00:885:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-739b60fc196mr11053193b3a.18.1743609002798;
        Wed, 02 Apr 2025 08:50:02 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e2245fsm11062809b3a.42.2025.04.02.08.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:50:02 -0700 (PDT)
Date: Wed, 2 Apr 2025 08:50:00 -0700
From: Joe Damato <jdamato@fastly.com>
To: Greg Thelen <gthelen@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: mlx4: select PAGE_POOL
Message-ID: <Z-1cqKd-2avzWQtI@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Greg Thelen <gthelen@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250401015315.2306092-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401015315.2306092-1-gthelen@google.com>

On Mon, Mar 31, 2025 at 06:53:15PM -0700, Greg Thelen wrote:
> With commit 8533b14b3d65 ("eth: mlx4: create a page pool for Rx") mlx4
> started using functions guarded by PAGE_POOL. This change introduced
> build errors when CONFIG_MLX4_EN is set but CONFIG_PAGE_POOL is not:
> 
>   ld: vmlinux.o: in function `mlx4_en_alloc_frags':
>   en_rx.c:(.text+0xa5eaf9): undefined reference to `page_pool_alloc_pages'
>   ld: vmlinux.o: in function `mlx4_en_create_rx_ring':
>   (.text+0xa5ee91): undefined reference to `page_pool_create'
> 
> Make MLX4_EN select PAGE_POOL to fix the ml;x4 build errors.
> 
> Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/Kconfig b/drivers/net/ethernet/mellanox/mlx4/Kconfig
> index 825e05fb8607..0b1cb340206f 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/Kconfig
> +++ b/drivers/net/ethernet/mellanox/mlx4/Kconfig
> @@ -7,6 +7,7 @@ config MLX4_EN
>  	tristate "Mellanox Technologies 1/10/40Gbit Ethernet support"
>  	depends on PCI && NETDEVICES && ETHERNET && INET
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	select PAGE_POOL

I didn't look, but I assume that mlx4 does not use page pool stats?

If it does, there might be a follow-up change to select
PAGE_POOL_STATS?

Reviewed-by: Joe Damato <jdamato@fastly.com>

