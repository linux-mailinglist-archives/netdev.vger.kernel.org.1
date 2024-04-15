Return-Path: <netdev+bounces-87892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF978A4E10
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6071C20B80
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8864A90;
	Mon, 15 Apr 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9tW/IzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C85FDA5
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181803; cv=none; b=PLI2/NN6RY1yBKDpCgO7ayW5r+c9xkBOiyQme9nPZhbRya5IgSOyl/ZXKXv05psYPIhkLc0Idg8ilXZOwFPu9kfybuC3oL2AUFW8GtqFW2GYfyjx2bykvWKUDSbYvKgytVxIySItBAL+bxuUMKpJUy/2EFTRVq/M07otTk0y5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181803; c=relaxed/simple;
	bh=DIQWcjCH4JQGyDYsAUinpSd2w56KdbDx2+IHZGif0u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kby5KekrW7/MWqPFYAFE/k0RZSV/F6hXIAEE+3rIWdMoygsGeNyI6dRDpWGz0o1pVOeChcxQwJ5PESeFMcrCaooojdTQR8VlEtYuQFvzGb/9I/qkdi5Kb9/XwitYBQNUh3Q0coyL1OtfRM6ngVVnlJfZxYzUrVL6yCjQ/2ZdA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9tW/IzK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da888330b2so12659461fa.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713181800; x=1713786600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9x548FJ1SiQ/y37wOVox0oJ8xJmfW7LB1+nDY8K/pJc=;
        b=l9tW/IzKwO2HF4kR+S3zUq38YdTm+Fw7qykQS7dM7Ri7vL1ffvg2EopelRiwKu7Ukm
         3tqUl6bvxNg500B1z7ka1l0aWOnubj89zewkbJbzGmONd3PJgZ/Gv767iNjUUjbjiOAB
         J2UnTtQ8cJ9mNCljw148lV1PfB2Zhz0CctlbbStl1WCnEaOT9wGCIEAPYEXLN5pTpqaP
         cwx14sUG6G8w90G/l6+ZNc//WBpT/vON0AIXu2C1dJNlgsCITUsDOSO35A+aNb8MiLc2
         vziENYZvSo3TQDw1/o0DxGX25keBsl5lbYJSNURe/EaaaXvW9K7D9rEFEvp8OI43HtR8
         NeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713181800; x=1713786600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x548FJ1SiQ/y37wOVox0oJ8xJmfW7LB1+nDY8K/pJc=;
        b=YN+f0+Q1oKgDH+ODRihc5bdmtOoOO6wTdGC75dncp6eYehJrLHCLaHwzU6IFtSfzYj
         99K94z5BqEaSP4qHvvNCX1W/olSELUV2SlOgFCqNSYf0HAn3akVJoe7XMboeM06JGHKL
         ZMfPzpgfTklXPUgRi3DIf+8k1lp0lXMt34G360OI1MExCpiSIfG+ZOqhwedUu9Vh+nvv
         De/xsQ9MGsxmmnZOQjmPcsttApGRvhyBz9qzQl8EcgiVSSE8XVtjn+RfCNX142619RGj
         DuOzlEmdxa+ThXfkgxGBqBj+t3aOb8OhkYeWN4vjfJBM7e++2WqG9+VzyeOBWVuqCi5W
         VRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNYec7ikACG2lhLyIN1syjXZXblCPupk/ubdQUSsSlgHDFvVti8uaEvQpbB7OZb+o5zJ//sA/CsQNON0ytE288Xh97zMq/
X-Gm-Message-State: AOJu0YzU22T2e8G1GxAdz8XQ5KEN4RwpXO96hfmtEGHBRdABFzd7A+0m
	1KClZOq2WASBkwEVsr33htpZJ5FAaqS7bRpJnV8PcJJ1u85/BMB4
X-Google-Smtp-Source: AGHT+IEsXxA+dRtrAj3yonpFLMEAndWqvj6No7ZazWFY2aDOd1y/4RfgNRpQQNRq3J6wqVN9iSGl9A==
X-Received: by 2002:a2e:9916:0:b0:2d6:f5c6:e5a1 with SMTP id v22-20020a2e9916000000b002d6f5c6e5a1mr7669923lji.12.1713181799927;
        Mon, 15 Apr 2024 04:49:59 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d108:9b00:f547:f722:ecdd:8689])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170906e94900b00a52241b823esm5138909ejb.109.2024.04.15.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:49:59 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:49:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: ar9331: provide own phylink MAC
 operations
Message-ID: <20240415114956.33fnormic4mqbvoc@skbuf>
References: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
 <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
 <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>

On Fri, Apr 12, 2024 at 04:15:19PM +0100, Russell King (Oracle) wrote:
> Convert ar9331 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

