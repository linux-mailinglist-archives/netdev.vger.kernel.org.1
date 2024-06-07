Return-Path: <netdev+bounces-101802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29E900218
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB61F22C13
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F659186E56;
	Fri,  7 Jun 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhTric3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83215B127;
	Fri,  7 Jun 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759595; cv=none; b=ooZC4/6GOSnEyUxLeffrcESTIY2R5D32Yb6Kt2/TELKP0tG0eMfCByTew6hmF+OAp/34uny55NQGINN+PsuRv3fhh8Rv7XT3zrV+FaWrK6izaadFjxZZ5W1GykVJPPEafhkn5fSa8sngVSNeaiZc/cv8uMazNhXcfRwFdzsYI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759595; c=relaxed/simple;
	bh=AbcMb/L5a4AmYRIDu75x5xfW/RxUUQYfDS6SE+8f2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWL8n7X88G2zdp+68l90g52vicj1U+7I2xsoYOobMPB5Acu/MVCe6lAYUNZRlbA/UEPp+t97DTz2Ir1IkW5fmJSlVHA8X4+tAaX0A4CfATRuqD7x4aJKdXB9WNwvTdxAMuNJFQ0fUVVsacJ2N8rQSzQFLA0tBrL9cXyp+fz2meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhTric3T; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68c2915d99so228833066b.2;
        Fri, 07 Jun 2024 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759592; x=1718364392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XLvtuYWsS72aHkO97kYnyni8Xi8vzmSMj4dEoYB4MI=;
        b=hhTric3Tk5Exhfjwr55PODx77pAe6w+d8VQv90+YzH1L6l2zkd0RcLS3WNMW38dfh8
         Aj/u1Z7Jh0Sw9w0pOdRHbm1wbL/opWaP0Rq1kJEWd4CAykvzwWY9ekczNvxedbjluEy3
         vgH1PRsF+JKw/DmSKgZbA1wDZcyFWXj/dDwppgjp20jjK8utFWHVxV+XuyYDIJjZtD1e
         wpYvLb1qsW5jgw3n9P/qg45Avkb3sWPnT7QGpi+UJCOHFXSyzzooMvSRhK+PxsgqzK88
         XdzEl36yMrL3ZoFzuKx3IPg/I8LzKc778yptc7Ok1qmifGaT7cEBEBUUGwud6etWSxex
         6ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759592; x=1718364392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XLvtuYWsS72aHkO97kYnyni8Xi8vzmSMj4dEoYB4MI=;
        b=tWoulEVJLdW8HBAIhpi3jpcUpbqwLWarhveMQZWxlK9p0nyeRw+O+cLVTwMDJ5JeOQ
         h0Y0HKNNllSmMMhSlqQzO88D+nQy0Zj4EJHZATW/5JQobCeNy3Q/Zqv38Nt4HEejsXRh
         1JuFBSInuTRs3DHyCI3KseFjWb7HQm+Q0M8x61pHgnxg8MYrmbRU4MoiVeWeQmBWLJSe
         XUTjwOIt60h/h3PKmHTXjbXPB32Pwl09rX0cqVCYc4fFXAeQUQ+M6S5POxeMKHmZbViD
         TTLuBUVT9kzcdfuIlf+i2jn9TyhXW6juQTXZEmm4LSXosCF/oBkI9ZyPtU0heFNASO8E
         kmPg==
X-Forwarded-Encrypted: i=1; AJvYcCXcqq2uxL0D8aWUoJO3LullwLcS0eD2TureXptozQo4OVAwXl/RT9e9GnepVxXhmWo1TlYd9xhwioEpprYm6Ki2pIF2f5yniS18rDTntNsa/l5yJb5B523l6j0tjDoFsZZezlNTVv+NCnx/AK+z8a3nOmXm8wMHQd3WsymVLEW4jg==
X-Gm-Message-State: AOJu0YycT6MSR/vSrn6qnbc+vgtGJcJ3k+PhIqCW+FchtaTZuhoGjsYy
	c5QPFUCUjyAPfKkdJt/KP7mX0LA4wF1/KWpg4lm70SLj9AM91d1X
X-Google-Smtp-Source: AGHT+IHkCEZPmvS6rqHoafK+T0ZcYkcg2yucT3oE/5dkXRScUbyWuL5iYba/DlatDvSy1gQYX4NOFw==
X-Received: by 2002:a17:906:fb0e:b0:a66:3ef1:9ed9 with SMTP id a640c23a62f3a-a6cdb2f8523mr144750166b.56.1717759591785;
        Fri, 07 Jun 2024 04:26:31 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cc764sm230647266b.76.2024.06.07.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:26:31 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:26:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/13] net: dsa: lantiq_gswip: Forbid
 gswip_add_single_port_br on the CPU port
Message-ID: <20240607112628.igcf6ytqe6wbmbq5@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-10-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-10-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:30AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Calling gswip_add_single_port_br() with the CPU port would be a bug
> because then only the CPU port could talk to itself. Add the CPU port to
> the validation at the beginning of gswip_add_single_port_br().
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index ee8296d5b901..d2195271ffe9 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -657,7 +657,7 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
>  	unsigned int max_ports = priv->hw_info->max_ports;
>  	int err;
>  
> -	if (port >= max_ports) {
> +	if (port >= max_ports || dsa_is_cpu_port(priv->ds, port)) {
>  		dev_err(priv->dev, "single port for %i supported\n", port);
>  		return -EIO;
>  	}
> -- 
> 2.39.2
> 

Isn't the new check effectively dead code?

