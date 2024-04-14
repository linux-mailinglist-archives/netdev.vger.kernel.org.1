Return-Path: <netdev+bounces-87684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D80B8A413F
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38402281B19
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0217565;
	Sun, 14 Apr 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYPKsv4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0E22F17
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083712; cv=none; b=OLlhgLEPSSgGTGRGgZUdAOQqF6G18tAYQI40LRiPZoPcFHx3WnWEPnJ8JtRlm61mgrvHHkIWdhzu/IdSRUJaMiiQWaOGZ39IbRi/Dyi+cX0vC0yShKmuinP/04jmQbkY5YlGeuLvZMP9b92QTo0dgLhZDhptFGLRdaHU7Crd/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083712; c=relaxed/simple;
	bh=ZPYqqtyateQAglR+k6OVKvCAe8YRzI/MA8ssd/t5pbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2K9mb5hCYFqF5URMLfLwB63fXoOE28XmWO5oss7zf7Km7VnY6i1WYPfYrqK+eiPzO7gVJ3taICRLDTo4/WqzDXxjTQRqhdZUdzXX8St857B/uyHWoxtn0CGlY2zVvLDlVzBz6hNxUkCZqoRxkylxPkWgPnOH7KA50+KCaSwU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYPKsv4n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713083709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
	b=XYPKsv4nHsJyS3QUHXmumrhZXZRXuITOhEcFQsM+ndkOKREgXxt7P9E8OKYyFHquOIwQdS
	cREg5IMBoYHBapoQ/dio9L1mbAwKw/nS+txgLUzS60PYht+bBpWjlo7Pc95fj3ElAK6nCv
	YSdsVJ6SYqSnHRz2aQZGd+h3b7LoUEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-udPqRSTOMkqbM1pVg-9VTg-1; Sun, 14 Apr 2024 04:35:08 -0400
X-MC-Unique: udPqRSTOMkqbM1pVg-9VTg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343da0a889dso1719158f8f.0
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 01:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083707; x=1713688507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
        b=jJUi1Hi5AgNIiNkm6SdQgoEUpCiYsFYG7xKFX8I5RGCkYVgr0xlOG9R6X9ltwYk+G2
         jyofA81mMPwyq/sQGo3vkvZ6YSLFhXG0pGhkncOU8wZpVY2brL3gJeRDBFgrDJ0E1b+0
         rd9Q3mzk3xmxF9Xvw1lOEBUaSFAOVHZEC6YqWSJGcx7kbr6AZUTG+i/U2pRN9rdc2n+E
         TTZnW/hXkra4IxSoEJeRpFJ66nJVYVQRR0ARXncHptWhOgvSMdmEdL+IZZ/05bhpdHmI
         Byxns929D4/6puBZue0gqG10gEwysIuKcnKu/tx4ohMeS9D97dn5aCpuAvJ6ZiCsfb8L
         fK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq7yfJGcqAAjjuJU9tprwKlrj3xmj7dKG7jdAmC31u85DZ+9PxgU4iVTyvoTT1982wVuLYwfqDYCwrt+xUyf5+kBdHcQJh
X-Gm-Message-State: AOJu0Yz6Arli/1Q8HHAOiW1dUWDtM8ziEAj75MyYbnvk8igLS796K6Cm
	r58mgPBprxSGiN1c5KbxI+En8ycfSkVKRou5x4qnNA61Eh0v7RWOGBUZpW0eHyM93Zr1pfL4KGb
	jzwJfdgsTTqDl/SFDZzENUpTY/LBafXeHD4nPZT+oMbAYeFZ9LhjyMw==
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215824wrz.55.1713083706784;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEud3PzT7Nr9AygoJHk6xDRgJwZJGsPs20hazfYSLls12vM50Lh6SjxqeEIXzgG7uN3p2DHqQ==
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215809wrz.55.1713083706195;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b00344a8f9cf18sm8576894wrm.7.2024.04.14.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:35:05 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:35:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240414043334-mutt-send-email-mst@kernel.org>
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>

On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of

What's buInputt? But?

> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Jason, wanna ack?

> ---
>  drivers/vhost/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..849b9d2dd51f 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1534,7 +1534,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>  	struct vhost_vdpa *v =
>  	       container_of(device, struct vhost_vdpa, dev);
>  
> -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> +	ida_free(&vhost_vdpa_ida, v->minor);
>  	kfree(v->vqs);
>  	kfree(v);
>  }
> @@ -1557,8 +1557,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  	if (!v)
>  		return -ENOMEM;
>  
> -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> +	minor = ida_alloc_max(&vhost_vdpa_ida, VHOST_VDPA_DEV_MAX - 1,
> +			      GFP_KERNEL);
>  	if (minor < 0) {
>  		kfree(v);
>  		return minor;
> -- 
> 2.43.0


