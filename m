Return-Path: <netdev+bounces-238141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60862C549AB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F243B854B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CC2DFA32;
	Wed, 12 Nov 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvQuMR9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D532DF707
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982018; cv=none; b=YfzjntaHCR/poN5yh+dmkFRXRwGDlppHL+ncJZexPleaLMVeqA55wbXhaxBI7EyS3t7PCotKbc5l82cXNw7T6UHDIOyTgxEytbBdlVJimNJHBWBQfmAjL1ecegr5UNOWnyCIlKo0crwgrf+VWXD2fYEdqvOTfOX30KgWwNtPnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982018; c=relaxed/simple;
	bh=0TVuy2oZ4WBEXZqVTNXxVrYp1QoYnVerala9K848fkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUFOtaNOubPo90URLC0FmoXkIgCQ4QAfq6q1KwVGUm1L+x3SPHqDANb8xHCObnq3Ju4DEidWY4ozft/iyKuAgyZQS7p79SLvsx9sPe+3XM1JPHZrYJiiQTX3Q+8XpgMBfCAenYCZCXAkLYq5LvxZXgdOTz5jEEKD1IbaK8f/OlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvQuMR9l; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b2dd19681so19455f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762982015; x=1763586815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5eQ4aAoy/FCgLIi0D7QATsQ+lFAFEjQEiLSkVeNLqM=;
        b=NvQuMR9lYwT2K3tvVM0I5fRkBfGyHdglBTq2i3QyEjV4fgTg3T2qeH0DgKPZLnoelL
         5dx0xuK37B7bNdI9pIrRDJnyYd/OcIcpc5TivsxUb4RLPAnde668+LuafGpI8PzXzE5O
         3COjTLG5crHN/5kEKhfdLxiG4PUFEP4vNY8/PqObnCyrlIJ3WKzuvZWis3GAL8ItqEAO
         L1qRHFHkSQyMJE7UygfK8p100ZRkTZNN3u1vbOcgu8tPYcIYkeQKVZW0N5Z5DCSAtr3R
         BcE+9DzjPJp+iHUaafzMCzvnV2ZvOZvPzwGmxuHu7FnZ3swOmPeZZcy0gjbTFfqNkVC1
         3IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982015; x=1763586815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5eQ4aAoy/FCgLIi0D7QATsQ+lFAFEjQEiLSkVeNLqM=;
        b=Qq8WWIExDxQrr0vJdD9/mebq4JNYKVu9igSzUyzI8VJ3ukAi18mjToXCLGeZHzcpp0
         soaWwUwgiINVSH8hVmrHgCpGnllkKSzQfQyQsVvdVo4Wq+12o29WsjvvE+vvEejqcauh
         HDZHTX3y+kMwkJhBKa3+CKxl0w09g2UPz5pzM2s2Ib3hBrfY7AhX9ovP45Eqz8I2rQBS
         D6Q1QRK9U92Y6LfA5542i2KmCH6eS3cNmlrs5tBMmgZHhko9PdwHV+cu6iSHtF/E7GG3
         yKpl/RDa2viBJjoer4Gegd0qX1Zy6CRn1XtIYG1Z3moZKQy/zbicg57E7RbjVjJEza2M
         HozQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeO+njBTv4315NZOIE4+2Str6SxYDgmHDEw3vZyLQE/nk4esPhlYA5DEf65Mofx1Pctau1JMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycjth0lNHmNy+kpiv4f2HEQipTeOVoLeBZRpVEosn52fya6uu2
	K/jzkBqKbI2lzi0+gjglEd85QB0sGwuBIX0YxY8JApV6IsTc2iFoENoxxjGSdw==
X-Gm-Gg: ASbGncumQTh3/XfGZGl4PC/ZSW9ePqCs+bJyzhOPbvN+/0qAdqcZAnP1vO6lXjdYRzg
	CRkgEdhbar51Z2slLsfwaDi6Qb0BUcY6yxkhXKfYhk3QYdlAkgMLgIpGYDHnn7ppqlNzGUAhryy
	IPJBS8I9r8tjDdy7OgSZddvla6TMFsQ4488ImhiYc9Ge5BamsJZyyW+lZXsqQn2g217iLA370VB
	tdnktIt1WYT6syJDnuhteYWDByy8P6AFG0edd+C3QG1z8st7ur5zP/rW9FKExiTfrUupxqVCLZT
	29x0CAAMq51Ch3b7xHlM9PHc+kQ2Awqqgo3T5IQmhifcsTglzS2/t65JSnbC6v47YJBIc2TXXLi
	0ooGBhUPbZeXmyqLeTNaBZIqFCc2gwVyNFKcU4jMgSGPA5KE10fhbAr5o0Tz2w8TSyl/G
X-Google-Smtp-Source: AGHT+IGUfIqFA1B8BE0hj++aIwBzbIztQKFB9DEDgqkeBbvhrURqgm7qdx5mpTDPFwF8cSyBRMoSBA==
X-Received: by 2002:a05:600c:350b:b0:477:598d:65e7 with SMTP id 5b1f17b1804b1-477870cbd17mr20098425e9.4.1762982014484;
        Wed, 12 Nov 2025 13:13:34 -0800 (PST)
Received: from skbuf ([2a02:2f04:d503:6f00:5125:db14:ba9d:8fdd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787ea39ccsm51689705e9.15.2025.11.12.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:13:32 -0800 (PST)
Date: Wed, 12 Nov 2025 23:13:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: remove definition of struct
 dsa_switch_driver
Message-ID: <20251112211329.6hm7an4lwi43kqis@skbuf>
References: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>

On Wed, Nov 12, 2025 at 09:46:24PM +0100, Heiner Kallweit wrote:
> Since 93e86b3bc842 ("net: dsa: Remove legacy probing support")
> this struct has no user any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/net/dsa.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 67762fdaf..d7845e83c 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1312,11 +1312,6 @@ static inline int dsa_devlink_port_to_port(struct devlink_port *port)
>  	return port->index;
>  }
>  
> -struct dsa_switch_driver {
> -	struct list_head	list;
> -	const struct dsa_switch_ops *ops;
> -};
> -
>  bool dsa_fdb_present_in_other_db(struct dsa_switch *ds, int port,
>  				 const unsigned char *addr, u16 vid,
>  				 struct dsa_db db);
> -- 
> 2.51.2
> 

Thanks. I think I also have this patch in some git tree on some computer
somewhere...

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Are you working on something, or did you just randomly notice it?

