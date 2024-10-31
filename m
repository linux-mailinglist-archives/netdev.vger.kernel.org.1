Return-Path: <netdev+bounces-140792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D172F9B812F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A81C21E44
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34B1BE23C;
	Thu, 31 Oct 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j40/yvW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3E1BDAA4;
	Thu, 31 Oct 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395792; cv=none; b=tINelg2YKquMnZDX7TjWeg1tdFp8c2uowZeV345mNFf0bxMXocOMzD1Tc2v7p+pX6YiDkQ2ig+IIycsXCmjeW3HBwv4tsVrhSJ9l6z2F7WZ9W9lhVSC/tCsHwXe6hCQUx4WDzgXtVIZ6XgskLah+bZiww/yjmgJriZwne+aLV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395792; c=relaxed/simple;
	bh=a5u8tp56/AYeTIz8p+9JUb3Jf0C1KWhW1Qot8R2kHRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LydXtK5q/dSrl5JQNo+44Yw5cW5P/MiJUasIvPaEjNa6wXTO9Cdfk0VYnXLd9guOIfi0d7QSzhqAFyimQ57JFtF7AZe3Jtt5Hi1KcbySQmRDw9s0O60V1lYTBnrNKsIhr5fdy0E4IUAfN1j9mmlNp8yOw7v29CLaWxNyOwQMsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j40/yvW4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so1624155e9.2;
        Thu, 31 Oct 2024 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395789; x=1731000589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2c2+8hCBcHHsv3z7ugoMx+aG94aS+LJBUKz0Fv+Ygw=;
        b=j40/yvW4Equ6MND0a+EzAkKrCirqFFe1qpX/9SKuUBLYGGIAHAe8yCKpHPXCR4sOu6
         zxDXSJ18+hZVJo17mkmjol8HNfucN/g66/jgUVzh8KQADaEbmO0PKE5kKDcLbppEH+pw
         l1+zS28+Gz7tfg8v+eHdwUZZMhH00cZmPe1OF9n39JT11rqS5Zm2NVarbvuToDOJsVkA
         pLQXVYbCCZGpCrpxvyKsoitQAKdN2MUpWq3Gsn/z5bmC8hUZBFFD1DyauGKIxz9cC9RT
         EcPn61tFyNhMIwW2SzN+GNEVNiInomyu7lVdW3ephF/fj9u0DTgpGQgmreqOn0kSktMK
         NehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395789; x=1731000589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2c2+8hCBcHHsv3z7ugoMx+aG94aS+LJBUKz0Fv+Ygw=;
        b=IRd16r6GApMi3mRXVpHZvHROHameveVVSDqVqJzhqNh7cnDVbDMlOujhOr9RSWw7Q9
         B6K/rWce1ZnttL/XgkynJaF/kjDnEL++mWaRBR0vXZFNc8S44Y/g2HfohGTqqO0OQjlh
         yKHNgwS3aRNsXrhzVTO+TeJBk7l7jlV0bMnb6Q4Rcz1Q/ZO5wDJA6KJY8DT5QtGhdH66
         yGnd7xn/CFafHIOwsKf6GXn8Cbe4keCgjOkbIrAhK3U3XmKafGBVZDpyhUwLWOULkNyj
         KNMUL8TgfyeT/HgDYmt5dno7LMiR1iRQ5CA3NMTMk4WRmq6W+lX4x5razid/Ws5jeGCM
         OzvA==
X-Forwarded-Encrypted: i=1; AJvYcCU2izyt59GKNr4Vc5WG4A/ht8tL3UPxVxCQAHfg2hSOLg1BJvOqhUJ1OEu+CvKwfCbpIGG+sq21ER1+78I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxwI5vSXzQ2bfKYa8rT+CSPI06AkUhab7V4wFuXdOHdhlOAZO
	ryDv/uMrYbdJlJLvBDg+XtxdjNzxzn8Q60kTgTBSZDh+9huS5ARi
X-Google-Smtp-Source: AGHT+IHakfGneSPWq42iuCut70oQ1E9rhNIoV1udWPYkJZcYcJIwtNnTlcAC2SE6lmct2XjYknh6Xg==
X-Received: by 2002:a05:600c:1c91:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-4319ad2b318mr76969105e9.6.1730395788864;
        Thu, 31 Oct 2024 10:29:48 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm33621135e9.7.2024.10.31.10.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:29:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:29:44 +0200
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
Subject: Re: [PATCH net-next v7 1/8] net: stmmac: Introduce separate files
 for FPE implementation
Message-ID: <20241031172944.ykgvlsysz5srxyr4@skbuf>
References: <cover.1730376866.git.0x1207@gmail.com>
 <9876134957283296792864da97eab60328f8d478.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9876134957283296792864da97eab60328f8d478.1730376866.git.0x1207@gmail.com>

On Thu, Oct 31, 2024 at 08:37:55PM +0800, Furong Xu wrote:
> +void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
> +{
> +	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> +	unsigned long flags;
> +
> +	timer_shutdown_sync(&fpe_cfg->verify_timer);
> +
> +	spin_lock_irqsave(&fpe_cfg->lock, flags);
> +
> +	if (is_up && fpe_cfg->pmac_enabled) {
> +		/* VERIFY process requires pmac enabled when NIC comes up */
> +		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     false, true);
> +
> +		/* New link => maybe new partner => new verification process */
> +		stmmac_fpe_apply(priv);
> +	} else {
> +		/* No link => turn off EFPE */
> +		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     false, false);
> +	}
> +
> +	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
> +}
> +
> +void stmmac_fpe_apply(struct stmmac_priv *priv)

This is absolutely minor, but could you please sort the functions in
their natural calling order (callee first, caller second)? It's fine now
that stmmac_fpe_apply() has its function prototype exported, and that
works as a forward declaration because we also include stmmac_fpe.h.
But if somebody were to unexport stmmac_fpe_apply() in the future, they
would also have to move it too.

