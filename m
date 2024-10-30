Return-Path: <netdev+bounces-140362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090A9B62AD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A272AB21C16
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4D1E8836;
	Wed, 30 Oct 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvO+bm9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5F1E7C3A;
	Wed, 30 Oct 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290253; cv=none; b=dwlQd+FPvzJRmMwPZ9/7oXjR6S8qm/naH/9+rk11jaHN8cUBxy79Cga/zhvyeKbt0n2QyKtIE7p08ym59w0yvW8L5TEfPrKcgSnkC9tn80FTCgHGyiUFIwnVuI5Mdt9zv0j8sksVpYaSY8343Ib4y4hgK3pshRBgz+ufDjvMa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290253; c=relaxed/simple;
	bh=AmfT9ucx4FhxBwk868TdCqg9tBgD3Dp+w+zqKBS1vms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpFAjUJTHDZGbXlce51wBrkUXmHzeZbHEZeGVdAw/bH4RlXJtO0Qy7VkDiMS68KGbDGzSFxwenf1MdN0c/HrnyJ3nHXxRdbW/gbiZaQU3kfbM29SCX4UN3N+ghwxFaLc+LLjaw8JiLs5Fvn7p+HUFVmz4SjwpMGLMv57/j7f4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvO+bm9q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315855ec58so8020065e9.2;
        Wed, 30 Oct 2024 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730290250; x=1730895050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAHJQTr5TuW3GGReDV5UZFJDEXYorIucpYIzOsAyFUg=;
        b=NvO+bm9q4355/pT0StMZ5DWyZlrm3QTLWAJ0AazB7OUP7/hwIm80ZpUYBQv8DjgZDl
         ixArdlQrneaWPSgfOPn2WnZ9X3xH/FcZHyTKjP8c7XWpTO00JEKWnwT10MpMy6wBHy1c
         JT3xH/GSzw2ur7t0JhFwmwX8yaSWlZ5Pk/txf/6FAp2AE0lgSScGGNth/P+nKIlYhKL6
         PZgw4EipVzGHY7GHK4//LVHmgq9kodrI3zNEDi0SYr4PV/VB7VToeNxkPpfZvF5tpIVQ
         s5omuQX05fgEVKxQNLKfwcBzWoJuTGUjReDzzytrWA5Qgz7DF356cmiKWq8BhEW8rMp2
         04gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730290250; x=1730895050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAHJQTr5TuW3GGReDV5UZFJDEXYorIucpYIzOsAyFUg=;
        b=Il30JSmPWSwk+iNdHbHUWEnUKEAPqHHetdWG18kmDd0vmmkd7rdHT6FAnYF8gJGOEM
         gWx9AtN12MCjj6ktAZzgJrFGPBZqNOAleJjCV9cSpD5gLRdJN1IGthbGEu6/VBMosYlK
         oOvRFJ37B1/BT4K34Iyd/yO6vhMI+Kg1aLtg2CeMAeuRctSuC1+l+/BOlfM9nklSjrDw
         xmkOCbXh1wZ8KFZxhzSpiT6WL3FXywdRMz6aKfak0/JQGm8BuGr6LVg2MDcYu+0T18k5
         0SOjzcmn8dKlxbPzFgVbr7oPCXEpTphYYAdtZOMBuJXHyzMObu+Zv61gD/rWJAgjmgdb
         5TVA==
X-Forwarded-Encrypted: i=1; AJvYcCXgm6AJm35ItBnCjKGGMZyOFnZOFlzNU6jeZE7Ayo/vryl09sGvLzcQjgNrKMC6NaxDE/ZsGQgaPcW1/Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBiG5iMMECt1Hc2bHmJV5g65mtB9WtAANOaOuYAhBu58w+1qQ
	VJtup8PD3LU6WEnzVBPp3xhlePlLWVMyeAYltqQEuzR/VbCqWzvD
X-Google-Smtp-Source: AGHT+IHqD0tQoJjotGQMbkT9O5ybcV1GKcOxiI7uSjH0+aXwp1A/frWiXiw3u1p9Psnfso7u9ygY7w==
X-Received: by 2002:a05:600c:5494:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-4319ad4ee8emr55092335e9.9.1730290249500;
        Wed, 30 Oct 2024 05:10:49 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd98e823sm19903975e9.38.2024.10.30.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 05:10:48 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:10:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v6 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241030121046.ojd7zx3jbyg4l4iq@skbuf>
References: <cover.1730263957.git.0x1207@gmail.com>
 <cover.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>

On Wed, Oct 30, 2024 at 01:36:12PM +0800, Furong Xu wrote:
> +bool stmmac_fpe_supported(struct stmmac_priv *priv)
> +{
> +	return (priv->dma_cap.fpesel && priv->fpe_cfg.reg);
> +}

Should we also add the condition that stmmac_ops :: fpe_map_preemption_class()
is implemented? For future implementers to figure out what they need.

