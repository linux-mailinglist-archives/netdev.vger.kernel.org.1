Return-Path: <netdev+bounces-92914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732438B94F5
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE6B28224B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13BD1CD3D;
	Thu,  2 May 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUz/HEQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E581CAB8
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633270; cv=none; b=K0uDxSZAMFQlkJMk8xIkhDY9ZmGdJ0O6DPKQX8oln+uPj5hWYNnFienKeLE/Wgfwq2GKLHCIjlYkjD70U5afFdNjhDbwBODndfXRdoFUfp2Y1C4DZJqQIagEEPl2fEBtEStbBBrNt819HHz4wUgQnGbdIInt0006Bs9swW3KmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633270; c=relaxed/simple;
	bh=vR/vR3KeKWogJ1nIbprfh0Pi5nYPDFEvYQrVJRHP80Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gulX+CCnQP4s+REOixbg7rrjIuWuMoxNaxhUO+eZUAOJT2PdsfiBGKeV9uAjobXwkBJmrFYY42JNMyQi6Fmx+eOqhAi3djzDgNy98Cc7g5ifKeseSwHJmdzsFdk6qwTqShlqeLRHc70UG6P2OM8rPFmaCzm+7emLM4KLfNHMALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUz/HEQD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso178671e87.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714633267; x=1715238067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn0AU37unUAGgQKpTRiKCU79v6Wbl71XirUxH47D8f0=;
        b=MUz/HEQD1WvFMfu54NsNAkQaOdAOrwfWtLoVBnDXTnkytZ9dEs1Ks3m72VkzX5ohvK
         QhOwdaRwmz+kDefE2Iu9SittJHzGfFzwpD4maLLYc1c3sYD4QidexStZtSkDr+/IB9Dg
         AGhWm6wPPMVzl+EhfwvSZ5Wktwhm73y/Zx+CL4M3fCOuLnHQ7vWIw1C9bzv2cRTB+h3x
         szAP1vtP7nJceabWJi8ShCcloRvdsxqu9WqoLoM3nYAQexRQVXdmXYKB/fbcn1atSZSK
         dn4UKP/Otdg4hWXa7gsu6NsQFaeY6s8Dmyo+VWOx5QoppW+r4DK4HKZAZOaQYHWVwo90
         +G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714633267; x=1715238067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn0AU37unUAGgQKpTRiKCU79v6Wbl71XirUxH47D8f0=;
        b=oUKgZ2+cnwgXekKLMQsrgw6dP4QmzFfY+PWxoSBIkJJGDpbLBUh8FPLg/+XmHdklgI
         mXD32KmOkHyFwj8ddaWsOuqwn22CUyJ7CPgXphmuwRoGXCqRxront1PvX5tx1dRm1aX/
         JS6dA+3/qO7EwIHMtYrZfYVom2oll1aAq50gNgK88uHOcCFNGzsSbF8BuvsG816qX2Cx
         zPIylPBTn2Lj2haR2D+8AqxKfO+tfWTLjtVBLhZrpLuNRgweHn8JIVxwmiaP1X3DhiE6
         GHNI2YuMhszWhdKM9igFlIlmIHSqCzRyfdkc4bYn6dUd4//HTiN9CY5Ge961gaPYSe5c
         hlQg==
X-Forwarded-Encrypted: i=1; AJvYcCVIRSaSAxlwyrc2alpgJkm116f2FAnpCKmUf7bX8SQ7uL1U43lHo2FxOSJdl+Fv3poO1KUxBcxgfWJUM/KcDJ4ndhwQSvDO
X-Gm-Message-State: AOJu0Ywz6wRs59HIYGD/pdB+6tGdn1J+Qht/A5ehk7N25bUpBelPZ07o
	Xyo4ieK+t/J//FvID0/moIyRccKWs1v3k+6cjme0Rd3XIWYVFJeZ0Gxzpv+3aWM=
X-Google-Smtp-Source: AGHT+IEY2IStjAYtQ4PUx622viAZrRaV8Lyf1OfIMJOgU6WmIX9KqxxOfijFDA+nn+IyTmy6maWflw==
X-Received: by 2002:a05:6512:3ca7:b0:51a:cafd:3872 with SMTP id h39-20020a0565123ca700b0051acafd3872mr3624984lfv.3.1714633267220;
        Thu, 02 May 2024 00:01:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00516dc765e00sm65046lfr.7.2024.05.02.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 00:01:06 -0700 (PDT)
Date: Thu, 2 May 2024 10:01:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v3 3/9] octeontx2-pf: Create representor netdev
Message-ID: <054bf59a-7123-4d97-a0c1-0fd8ca271b2d@moroto.mountain>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
 <20240501180656.GX2575892@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501180656.GX2575892@kernel.org>

On Wed, May 01, 2024 at 07:06:56PM +0100, Simon Horman wrote:
> > +			goto exit;
> > +		}
> > +	}
> > +	err = rvu_rep_napi_init(priv, extack);
> > +	if (err)
> > +		goto exit;
> 
> Even with the above fixed, Smatch complains that:
> 
> .../rep.c:180 rvu_rep_create() warn: 'ndev' from alloc_etherdev_mqs() not released on lines: 180.
> .../rep.c:180 rvu_rep_create() warn: 'ndev' from register_netdev() not released on lines: 180.
> 
> Where line 180 is the very last line of the funciton: return err;
> 
> I think this is triggered by the error handling above.
> However, I also think it is a false positive.
> I've CCed Dan Carpenter as I'd value a second opinion on this one.
> 

Yeah.  It's a false positive.

regards,
dan carpenter


