Return-Path: <netdev+bounces-84908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4E898A06
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B7B247F5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15012A145;
	Thu,  4 Apr 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdS0xPAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2587350E
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240671; cv=none; b=ajqbOgtCHNFAfIN7QVIWkn2XHq01txwcP3RlLsC4IRjAkhPlHkQ5DYLnXinIR0/PC62uKdR+rz3MkPXjOxv8WuQlg+5EVk5ZLB3tEv4/9pBZyFRgV/qD9ySMXJRGDyJZw7UO7zCClAA3Cu/byfpPYmUjNQBnDmV8SbM36jmQn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240671; c=relaxed/simple;
	bh=Vjs9fiDyEPCiUH5V97YlzYYK9hVDZiame31wpvVYE20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv6rT5nkAWaqqoWMrsJ2KAg9Pezx1h9ctOgz3mbn8fKQJi+k9dePwzBNLN09gtTHF3VVMS6gg1t2PsGuXdE+A2vC6FlQfnp/G0biqYy1Z0bofrCjbe1SYUJ/oPeyvc9zNlsTjNQK6XlAQ/Tq+wOt4YPsLtUuwNvpBHEqBc4f79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdS0xPAr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5193f56986so54788066b.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712240668; x=1712845468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73VFeujZ5zRSnfDeve047kxeX/QzAwRRioVRteiOY0c=;
        b=OdS0xPAr3SPdUwnKKcNya6NXo3tYIx31vHdM4Wp+gKzcowRsPRO1pC6AXGMsho9lMd
         7fpiRYOfp/Rs5RwGzePNVIpJvjm7tC+Y3UuuwEsCRAnu5s0kqLYWMxKyOceUTzv1LPbp
         z3ZtGwHAXYIUqcCJMLxx94Q8k0MNmafxjLAAu2CjUxZxnswImWioca2803X9AgsdGo35
         PpISXs4OLFBmnh11BBdlJ+KzpWN4Zbx6xXzR4ZgrSaBtqbu5gAsmIoyy5XLHrjVGALoF
         6m5O6OI43uT40JfypoPi/X8ctrlHDIFoZwEm/hkFdy0FrNc+kXUbZ0xqLHvM2Nhuqhuj
         OEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240668; x=1712845468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73VFeujZ5zRSnfDeve047kxeX/QzAwRRioVRteiOY0c=;
        b=ojbv3qaTBdPrjFBkOJnT4JFtDme8FEIzv23AKJmyLm2MtRFKr9Vv2yV+7Cr8kJTRub
         lbjeBRDFdZXINOOcNajeXbS76ZOcvWfBOJrS4qjr+/ZTJTSq77BXJFP24eQQ6Sc5uXFw
         nB1mqtBmFPBVEe5YYvbpW16FyDCLoO4cWkZcoOimjs8U9lftttcQK/PQF1oBfBiZ2jyR
         NfdULLqfFVRZmEeVDIKRgV0YWuMhcM9SveiKYOMsXshKCYarjMkLj9HJDWG2UQAxyrg/
         Nha+nZG1so2vqObiDpu1yOsjZ5zJghe2gZ2cTxrRO62L070vi3vu7E6pnlbJZLKxhcQs
         G5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMgDgATsrI7LQqjiCVbKdF+s7zc9WXHZHndXfvpA6jSUmkTqJI9LkiqAc3e6PnpzG6BkBf2jBDtotIgvMzOFQfC0ptiGEw
X-Gm-Message-State: AOJu0Yyng6wxi18uezdvehWTWGJdzBHHSl03OMKecesrKOSIrWo1TzoR
	DExnUzQdri/USQLL8nlkcbs4nyfWkhehu02rnJddZQ3KCu3IVzndsZCOo42IB58=
X-Google-Smtp-Source: AGHT+IE95d2GyKE88haqUxd82qWyW9YDQkqTlbBv2liHK6vJPSxaCXRx7+j2iffF7lQ5Hkbtdl0/2Q==
X-Received: by 2002:a17:906:dfe3:b0:a51:982e:b3f7 with SMTP id lc3-20020a170906dfe300b00a51982eb3f7mr348369ejc.37.1712240668315;
        Thu, 04 Apr 2024 07:24:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090720ae00b00a4e35cc42c7sm7998858ejb.170.2024.04.04.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:24:27 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:24:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v6 15/21] ip_tunnel: use a separate struct to
 store tunnel params in the kernel
Message-ID: <5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-16-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327152358.2368467-16-aleksander.lobakin@intel.com>

On Wed, Mar 27, 2024 at 04:23:52PM +0100, Alexander Lobakin wrote:
> +bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
> +{
> +	struct ip_tunnel_parm p;
> +
> +	strscpy(p.name, kp->name);

We need to clear out p before copying to user space to avoid an
information leak.  So this strscpy() needs to be strcpy_pad()

> +	p.link = kp->link;
> +	p.i_flags = kp->i_flags;
> +	p.o_flags = kp->o_flags;
> +	p.i_key = kp->i_key;
> +	p.o_key = kp->o_key;
> +	memcpy(&p.iph, &kp->iph, min(sizeof(p.iph), sizeof(kp->iph)));

And this memcpy() doesn't necessarily clear the whole of p.iph.

> +
> +	return !copy_to_user(data, &p, sizeof(p));
> +}

regards,
dan carpenter


