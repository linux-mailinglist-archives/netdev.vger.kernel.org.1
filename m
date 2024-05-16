Return-Path: <netdev+bounces-96731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B29D8C767C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A61F2169F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8943687;
	Thu, 16 May 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf4x5SsI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE9250EC
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862801; cv=none; b=YPw8xvqLNkiQINl8YAq+eP2+Abv40wNoS0nErGeNsDTo9rVl/BkYHw8f50EUzd+Kr7pRao1lnIICFaNUbQ+l9xTTCSnCbLBZK2jj3xtD7j41+U1JxYmu0N/ETEqXWHjsT+HgOxNhHD2TD15Ui21oY28ecviO0DGgsWy/4EJaFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862801; c=relaxed/simple;
	bh=kG4YbPhbEHf2GsE98OI9GeD5VDcN/gjk8FDCVUgYQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ07zMLx+VAeEqdG9GV+/M4hRms9vmbbrnSx09F78P6gLr+Jpbe0CCl1CqI1LSqb0i7hLcU+z5byuQu8VeWVNl4FWYazJmhkQghqAjdw96SVgQtfxY8V6VLJ9KhtWnXVJWaRub2w0yaC7I5rfCuUN0oCAUIWZ7JIH4GnZpWlPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yf4x5SsI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715862798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tTC7ohyTAFY3GRYmUhC1nAYpxmmnw9+Ospuc7sYSlA=;
	b=Yf4x5SsIQDsjTl5PZrPGk/skHif2d87fnKOGYvl7NBMYcKzbOiv/Woy2AIAA3kH8f5twst
	qJBISd1ZVJ0yBPhqXLfsmUO1A6VWwrbGkt84pQCy7OO6+twxKQns/zNfSeP0T5S1l3slFN
	EUzF9xGKL+cvnG0jXSeb1ieh9oDyLfE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-PJ-nwxMyOPOGDyoGO7GaJQ-1; Thu, 16 May 2024 08:33:17 -0400
X-MC-Unique: PJ-nwxMyOPOGDyoGO7GaJQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5ce62fb8dfso80576066b.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862796; x=1716467596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tTC7ohyTAFY3GRYmUhC1nAYpxmmnw9+Ospuc7sYSlA=;
        b=C7HkUTNgEWEQd3wN0tdLIT/5BSz28xfBbAtSDMMjiDzQQiB0QK8jgOMK7gdB7+UTyC
         7qrWdx4dK8AUaiA61QtMSL8EjG0Qnmc5r6QqllcU187Uw/0A5zwywxC03TDyrHU3bBd9
         Cki/qGxvTFiovNXxog3uKUov8hBm06aBqfSKCOrzl/PM9g7YLsVZH70evWSVkMbngiuV
         +kA8kdHr/Kfj2EP5OEd8QUOPQc3Uzi25ygkR+ertj8YZt/wUVNCj6I37nIgtFS9WL8ym
         jPV1e+2b39pJWBnhEmoDNN0HN6SdfOjGehCL6dO6sVHEd8wAKs4osY9l8MbITVwWiKkb
         AZsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RuhxM1He9ZUOpglWjqht0V9TnMdaUr9dbVwU0knbT3JL8W10bQMXk+incElSr2tRnr3aiRW6HOr9nBgopQVtO1GfSS3u
X-Gm-Message-State: AOJu0Yywxm3VvL1R9fvQ8C1FFYsolo5yx9e8vbJdNCTGGh6BRiFJ1tkl
	E6bp0wM5mKguxFGFmBZ+j1KpdZiRA2ElnYsC648w23gMYIkz8KGaNhaCcxaEbAeB5a70HkmpW7A
	XaDLF7Kp5ks64nZaWHh3jSJrv6+Sv6aWfMp42snq7wqSmaIYo/TFAhQ==
X-Received: by 2002:a05:6402:13d3:b0:572:b83e:e062 with SMTP id 4fb4d7f45d1cf-57332686076mr22078704a12.3.1715862795991;
        Thu, 16 May 2024 05:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCxXOUkrsCcpZ7D9SIlwb/5j8SMjlf2OmY4LpAd4O74EkS4uDCh+dxB/DAz92Y/peO5r9Xkw==
X-Received: by 2002:a05:6402:13d3:b0:572:b83e:e062 with SMTP id 4fb4d7f45d1cf-57332686076mr22078674a12.3.1715862795469;
        Thu, 16 May 2024 05:33:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733beb89e7sm10768239a12.21.2024.05.16.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:33:14 -0700 (PDT)
Date: Thu, 16 May 2024 08:33:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] vhost: use pr_err for vq_err
Message-ID: <20240516083221-mutt-send-email-mst@kernel.org>
References: <20240516074629.1785921-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516074629.1785921-1-peng.fan@oss.nxp.com>

On Thu, May 16, 2024 at 03:46:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use pr_err to print out error message without enabling DEBUG. This could
> make people catch error easier.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This isn't appropriate: pr_err must not be triggerable
by userspace. If you are debugging userspace, use a debugging
kernel, it's that simple.


> ---
>  drivers/vhost/vhost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..0bff436d1ce9 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -248,7 +248,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>  			  struct vhost_iotlb_map *map);
>  
>  #define vq_err(vq, fmt, ...) do {                                  \
> -		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
> +		pr_err(pr_fmt(fmt), ##__VA_ARGS__);       \
>  		if ((vq)->error_ctx)                               \
>  				eventfd_signal((vq)->error_ctx);\
>  	} while (0)
> -- 
> 2.37.1


