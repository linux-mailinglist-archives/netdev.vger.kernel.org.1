Return-Path: <netdev+bounces-194089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05516AC74C5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2509E3A7CFA
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526461E492;
	Thu, 29 May 2025 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DV50x740"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21277BA3D
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476906; cv=none; b=cTgGpoDgICyWRsfwer/zjr6/M6OP2cnwBgs3ShBd/Wg9wmIKUSIvk7B+7LoYJs6Ff0lorrIhx/+AZ8Gg0CQoMuPXahSZxaQK3QCh9ypCE3TGQTmxoufVrdc00Nv50PD/ypje73AWRMHc1BVskZ1UxLdYwTC+MpS8HWJ85q+h8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476906; c=relaxed/simple;
	bh=T3juE1hOUm6DFe5iT/pHd3UmRK7XfYewH+PUs5EwYN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKJcXggNpbjd79DmadLE+r1mgwwwO7LJDhGOUSiOWOktUd6WgnQPUY8h5EmceFkK8elmX2fIuM26wXY50vMiwAWMyAV4c580ztc8ij3OxUw3ZNeO5zWu06pFSuFTgHlB0T8DgBPcxYOKU0NFkd/YRObBrWZ7vOrkpFgpczNFSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DV50x740; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c27df0daso225870b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748476903; x=1749081703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHrYl8KlTDJV9fZehVT6wNYFoGVLZmH/YM7SP1Otey4=;
        b=DV50x740ZiLdVCWqwMXcv60Mn8RJ2GTIDm9RssFMLLKlsTVJ7qvZwzKSQvTUMFKcDm
         pX9NFcvIoO6gQTqCB/XXC+I4YTZDJf2DJaP1h2NtUzIB009Rr8fxhRLWX0mbOhsFihZJ
         Ipefk4NVQBOSKfNa6+g3fpZlkts8X2YOoSY5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476903; x=1749081703;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHrYl8KlTDJV9fZehVT6wNYFoGVLZmH/YM7SP1Otey4=;
        b=eDZTs9ffVbgSkW4qaapRYfwDy2NoTyW9/YXyEOhCoDlqNaNwJgfwuiXwitW134hSEr
         z9KB74CRvj1T+IdasKHLbgGq40A6mg2BDuZ/+y/HO5RwCCcPXW6AgCjm/sVy+eUY+EAE
         JGZsXS5c0QIbWORcl5W7gZJbUPKzLhIkCxZjaCOobbFQbFzIPDan4onzAJJ1aFzdu6HK
         OYvlP+N953735iy9n8ffV+LmzO38QCUEFot4K5eL5Q1RmgzBa7Ur2tvV4OrYI5hOpzc/
         I4B0U/RUJFV+gFK7d9RZKJWMjcio2+Y0vvr1MbfVjOfDqj1zvX8Y/8gMClCjm29j/eZF
         WsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1VnMzSce0Nd1egj1mBmnPKQiLduzuKmUMGZN9dmeper5eAGO2KgpZDrQDxNl+kbdGUQQgdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbGSyoGwRK7A2LH+WCrlm87bvvF9Xz55t1a6MF9w5E5QPbnYm
	6eReMXvFAYBLmD4w+teAz07Mg/OXxc9SnMJlIoOQLqn7VYnsd3aunhZjm2m/73/qxBI=
X-Gm-Gg: ASbGncutotib9hu2DNnA22hN5ne2ZiLYCnr/lZVxSaq9OdobobbzTCiaRDLIV4QXEIr
	Mzq1xdLXgmtsI6/d+funGwwEeYtjqCVIR/uQylfUpXUOHf/tSwZDLxla/h/vhgmCY8zEyVZIR5B
	0ezO3q0zkm75Azy+BFleNdk7yyV85XFyLbOf/HqfPsbNTBrOI2eADHqRryKnS/4PVHAQEdQyRTm
	cTsSyKmszWNGxYQNJ6j4l+CUIdHhtq+jfX1aBArUHJmK58tNTibxVtJJG4LxzAWfE7YkezeRXqD
	Ln94SpRT4p/31mPTt+jP2Mrd5vIMAM1nKiJFFW6MrCcKpX+LKHTO9MkUkTzFd24R65P17uCp/4C
	EaHL/lPB/on3Pfw6sfQZ4vvA=
X-Google-Smtp-Source: AGHT+IGh6QFynq+YuUMFZqTG/73Ufan/2rkYRYNy6qC4rW91iir86PkvuJN/O02OksGF7UPuPg4WFQ==
X-Received: by 2002:a05:6a00:1407:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-747b0c72ba6mr275550b3a.4.1748476901844;
        Wed, 28 May 2025 17:01:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaebsm165546b3a.87.2025.05.28.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:01:41 -0700 (PDT)
Date: Wed, 28 May 2025 17:01:38 -0700
From: Joe Damato <jdamato@fastly.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: niklas.soderlund@ragnatech.se, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: rtsn: Fix a null pointer dereference in
 rtsn_probe()
Message-ID: <aDej4pD_ZzB8ZQdP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	niklas.soderlund@ragnatech.se, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250524075825.3589001-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524075825.3589001-1-haoxiang_li2024@163.com>

On Sat, May 24, 2025 at 03:58:25PM +0800, Haoxiang Li wrote:
> Add check for the return value of rcar_gen4_ptp_alloc()
> to prevent potential null pointer dereference.

Was the null deref observed in the wild? Asking because I am
wondering if this is clean up instead of a Fixes ?

> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/ethernet/renesas/rtsn.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
> index 6b3f7fca8d15..f5df3374d279 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -1260,6 +1260,10 @@ static int rtsn_probe(struct platform_device *pdev)
>  	priv->pdev = pdev;
>  	priv->ndev = ndev;
>  	priv->ptp_priv = rcar_gen4_ptp_alloc(pdev);
> +	if (!priv->ptp_priv) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
>  
>  	spin_lock_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv);
> -- 
> 2.25.1
> 
> 

