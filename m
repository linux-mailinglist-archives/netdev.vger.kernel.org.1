Return-Path: <netdev+bounces-125952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE596F64A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C251C2149A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D691CFED9;
	Fri,  6 Sep 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrjad079"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73513B5AF
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631671; cv=none; b=TGg+YTos5RUCRld3GmK+kVV0j6JAb0Qt91hQr7Te/x47V5HIt/iaINAMw90OMEJS4vn0XBwTlHDNqJfyebFIJhbvsDXKheLeg4jmWQDB9EUTZnPl7ud1JPvP6V7uLs5oiS7r36tus8O4szlOaVAu1ceEKBLrzcEfjnUzFb3emSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631671; c=relaxed/simple;
	bh=GdxkN9L01BvXZwqi1n37BsmdAoSSwwOS7k3cLJ8qDlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=creupJynE+zlQ6WxZjADq2HObBYG9fvSu4eDNaOqwmjmplkaR1naHOQNRVSRZLX/n+u/MF2pzG/WRkLL1PdXx3YA1FTshmp5U7Xzw8M3hgUY3ThhPNhk8ilRYaso/J/dUjUlJ7kkkw0IXJ824glYgZWNr80fDhRsQ4gRnjtrdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrjad079; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso1548657a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725631669; x=1726236469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oahn2HXlei7mNIkyyU5g/wit6gTTgI2vN61xnKl/pgM=;
        b=hrjad079ESpbgt+5c1PMGPULKkYQTFPkXmsT3VlibkG5ga+UYb9L6limAgTl1w0O7G
         H8Z9H9noqrAtNLe8ft75CuXsL29ty4qVFHwg6gio90yzPR24J+Hs1XbQVtDsVM2AbOR5
         MDZLQ0a+4o7PyS3LXYwsaFzOQtuXK4hd9hiDx84wJxDNbUYl1ncXmYdmSu08YaydTtXx
         han5XVLJQkWszHOMhCW624cJxhErghsuivpt1xl9YUzke+GrKZp83ihua/MNaGNchDWa
         nYbUS70LXphHZG5jpKV78rbK4vDx9bs7gB+pJM9WwkUWEbP/KYUPHYRQrH7Ndh9aGGSp
         n1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631669; x=1726236469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oahn2HXlei7mNIkyyU5g/wit6gTTgI2vN61xnKl/pgM=;
        b=IXSzo/zU/BJjVf0JIJEap9MQC5CnM7681/3S3GISM66ByeERe9nBqP27iuV8pm5hdv
         5t05hfdA0CwSHFcB8MRTaW72FanoO/nBxbXSLuABz8OhX5Xx2vEdpPoEJLolWwvqtBnL
         lWSNxVR70XeF9SgcD7NVS3kQZTMxTV/tZEwSSZRNDrpIMZuaoBT7E/gehqJwqedvLxVk
         DUH+sEv5QMLvzGnS5Umfjt1UIxzMrL2Pw6yceRQipQlPsFF8d3jhQyGft6Tp1+KOm/am
         sXQi79rxxpaniMn80a/fsCyGYIXItYfgfll3NsOqKfsyPJKjH5pX2h90LSKMS89amHtL
         kYUA==
X-Forwarded-Encrypted: i=1; AJvYcCVc01RZb0/Gar/Zzk0kqn+0QhwzRNDBPhthDL8kAPGw+0Zc2ie1uSm8AqiyohX1bRSw9ooZBPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemnuweGBh+gToiAM5KallXyY40ihecgQXtiAPFWdjus5fezw0
	FVDG4hL8f9R4xsZVYu+NcMoMTV9u/0dePIOMH96DVYnpvt/YJ3sX
X-Google-Smtp-Source: AGHT+IEKLsmsfDZYYKlBPUx1cRWRnafO4cmFqckWTtYt5h9imsub4zErRgPwRcOkJJZRl2MgVYHMMg==
X-Received: by 2002:a17:90b:4c92:b0:2cb:511f:35f with SMTP id 98e67ed59e1d1-2dad50d82damr2985795a91.15.1725631668925;
        Fri, 06 Sep 2024 07:07:48 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbff3c6dsm1594130a91.3.2024.09.06.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:07:48 -0700 (PDT)
Date: Fri, 6 Sep 2024 07:07:46 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH -next v2 1/2] ptp: Check timespec64 before call
 settime64()
Message-ID: <ZtsMsouumhHTuEmB@hoboy.vegasvil.org>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
 <20240906034806.1161083-2-ruanjinjie@huawei.com>
 <ZtqEtVBEQQEp5gPV@hoboy.vegasvil.org>
 <3815e749-a642-d5f3-7503-ee9d04a63938@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3815e749-a642-d5f3-7503-ee9d04a63938@huawei.com>

On Fri, Sep 06, 2024 at 02:37:58PM +0800, Jinjie Ruan wrote:

> > See SYSCALL_DEFINE2(clock_settime, ...)
> > 
> >> +	if (!timespec64_valid(tp)) {
> >> +		pr_warn("ptp: tv_sec or tv_usec out of range\n");
> >> +		return -ERANGE;
> >> +	}
> > 
> > Shouldn't this be done at the higher layer, in clock_settime() ?
> 
> Maybe it is more reasonable?

I think so.  If you code that up, please include lkml and the time
keeping folks (Miroslav, John Stultz, tglx) on CC.

Thanks,
Richard

