Return-Path: <netdev+bounces-101792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160DD900198
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF01F21D6E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD38186E4E;
	Fri,  7 Jun 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDEkQSEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C15DBA3;
	Fri,  7 Jun 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758474; cv=none; b=FRSylwzh8CJgL8EzYmFSCH8/eNfluOqj/nGRWvwDmzV7g3uT+Lvi7HGdy5X0v5mipgM8WKqAzRDDcNx7q3RTX+jQetbtIXWrF0ciE/kOjI3AqZN1/6SuJqm6dDw1ROJWaiU/CeuXaIcmgIIWm6BnydmGsxUTbsUH13thoNOd234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758474; c=relaxed/simple;
	bh=yaJzSUIG1L7vHjglq5LBpdfym6nOV4qXdvbcEwWsOyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2SgDZh/HD/BQWaoxssKMU4O2wRvrSDd8v01tyhIweabZ30oqHxeuyvocbrMcSCDOw/WaVkPnn+yWM8+88TAKiMc27fNDh8Wo7vtQwJwQu9LwtlT/4Vm9+9PDvrT8F8AqXwkPwXKXr6Jfhwb3WKlYo+OFtrxZ/ywiozhF11JwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDEkQSEF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso2853610a12.1;
        Fri, 07 Jun 2024 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758471; x=1718363271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwoB1I2CoqSrADBSqDpZDueAN3lp7krkHSyqi5h/Lrg=;
        b=VDEkQSEF8hG4nOeTPlL3Wnv0iEU5qKWEjWMWYxUeu//cGmu5O9Iny68T0CSIMWVFRt
         AngASh3m55t587XbMv9UKrJyMEPs6hO9e87IchI1gG5gKuT/lgyN5DwHiS1z2UhR0wtA
         k3D9YDfMhShoJDUVoKd22zbdMbsvkCiaVzrEopajpui8V9URfWZpRzske1BF883g4IWu
         Coh1sieAjhIKlbg+R6oA0JbZ3hyssCdhGrOrT2N1i9d2KRPZyPVnK5+aJnwN+GVrsK1J
         PbgF7vZKYcw8OsFuBHjRKxOhpYSYeS2bRYxdgeIZ5KLtA0SohfygNYE+e6KF86NN1FfM
         hAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758471; x=1718363271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwoB1I2CoqSrADBSqDpZDueAN3lp7krkHSyqi5h/Lrg=;
        b=tuQeHeGPpjOAcHDaV9iYjZ5Uu0Ln8d5/pngmj54T0LqHfuP9fYWcObaFwJG416XgBv
         uGi8I1jLdlJFHdFTU5qjHYTj21c+tx8dAI22Jj3I2/RJmgD5ayjLM7fPX92s20Ufs4GG
         QRdLwDhiwkX3yRXry+bdDqAnD8xy+zjhjcB+35AOnyPt1OMDTqoo6s1YGPmH6BnK0MKO
         wC3abFHfqK++BZKdr39YBKnThsInuAc0n7IaMCdD39G+g/REwSREvwYLvwDSdPQAc5Z6
         AyFTTQEaNK8wZxdB54UP9Y3J2ugTF8yaXxDo7DOn2CBnOGtNgqfkvsEcXFgDRvTnaoeL
         C5nw==
X-Forwarded-Encrypted: i=1; AJvYcCXjm+rgaKmKSKYaXYpxraYYjZO8b2AHBosQ7/A8r2LDNJyrBFIkmKxJUfBdV99ugSbSaavM86hOc/gEXBWdedW2A8gGJzBWfuYxhMociwo5+0Zvzq2UOHIfNBX/1TlRSEZkN4Z1KIRdag5tcU2dgkfRaLoPdrBxPbnmYPbZRyNL7g==
X-Gm-Message-State: AOJu0YxQxPtkjKcr4+vxYvqQIu+SaWe2M6xw4MvhNtVaSALrUAbjKkMV
	2rV4gvMX0z23lZts96rtX8R+Eot9wM0Ox+D321TBHVv3aq/mTtZ2
X-Google-Smtp-Source: AGHT+IH6rZ9zLdc8fiE9PfrZZyWV332mnTZ/6+FIHUz//Qahy67ncSDhq+u1qaDIyiqhJKGU1Z/udw==
X-Received: by 2002:a17:906:eece:b0:a68:ecd5:6083 with SMTP id a640c23a62f3a-a6cd637e1f0mr205666366b.27.1717758470759;
        Fri, 07 Jun 2024 04:07:50 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072a46asm230426466b.206.2024.06.07.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:07:50 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:07:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] net: dsa: lantiq_gswip: Use dev_err_probe
 where appropriate
Message-ID: <20240607110747.zsiahnzge2bvxd4l@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-4-ms@dev.tdt.de>
 <20240606085234.565551-4-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-4-ms@dev.tdt.de>
 <20240606085234.565551-4-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:24AM +0200, Martin Schiller wrote:
> @@ -2050,8 +2048,9 @@ static int gswip_gphy_fw_list(struct gswip_priv *priv,
>  			priv->gphy_fw_name_cfg = &xrx200a2x_gphy_data;
>  			break;
>  		default:
> -			dev_err(dev, "unknown GSWIP version: 0x%x", version);
> -			return -ENOENT;
> +			return dev_err_probe(dev, -ENOENT,
> +					     "unknown GSWIP version: 0x%x",
> +					     version);
>  		}
>  	}
>  
> @@ -2059,10 +2058,9 @@ static int gswip_gphy_fw_list(struct gswip_priv *priv,
>  	if (match && match->data)
>  		priv->gphy_fw_name_cfg = match->data;
>  
> -	if (!priv->gphy_fw_name_cfg) {
> -		dev_err(dev, "GPHY compatible type not supported");
> -		return -ENOENT;
> -	}
> +	if (!priv->gphy_fw_name_cfg)
> +		return dev_err_probe(dev, -ENOENT,
> +				     "GPHY compatible type not supported");
>  
>  	priv->num_gphy_fw = of_get_available_child_count(gphy_fw_list_np);
>  	if (!priv->num_gphy_fw)
> @@ -2163,8 +2161,8 @@ static int gswip_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		break;
>  	default:
> -		dev_err(dev, "unknown GSWIP version: 0x%x", version);
> -		return -ENOENT;
> +		return dev_err_probe(dev, -ENOENT,
> +				     "unknown GSWIP version: 0x%x", version);
>  	}
>  
>  	/* bring up the mdio bus */
> @@ -2172,28 +2170,27 @@ static int gswip_probe(struct platform_device *pdev)
>  	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
> -		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
> -			priv->hw_info->cpu_port);
> -		err = -EINVAL;
> +		err = dev_err_probe(dev, -EINVAL,
> +				    "wrong CPU port defined, HW only supports port: %i",
> +				    priv->hw_info->cpu_port);
>  		goto disable_switch;
>  	}

Nitpick: there is no terminating \n here.

