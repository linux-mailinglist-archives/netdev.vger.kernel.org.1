Return-Path: <netdev+bounces-65835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928883BEB1
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110F01F21902
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416391CA85;
	Thu, 25 Jan 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiZ5Ls9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DB1F614
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178368; cv=none; b=PRr4BZd9jZf1ZS/Gu2m189ll7HEup1Bv5IOf8s64veq4UDLkeWyCe/b6tn7OMX3GNNKtBih755fAUuiMlBd/7vcaKnLh8eIGGxATn9cMpN4JHkrQ1OQuviXa25z17ea3FvGB7CUxwrtAQhKys86y9XlFYL90ooLdpFY9vu0a2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178368; c=relaxed/simple;
	bh=62l7e7ulXgJYl6IITs7ss+STC2lvCVnr+pSL9SfM2mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b67QUxDn49La4hXkjSpcNyXdNy8ul9P8OqABFSzqFTi1eTN48q+T9WPn+1XSa2tpU6qAPF2DBgyVd0wH40tqM5XgkFlTMT/hEQXap7fUV0mbHqUAFDLKIqywpvkKcg5UMj9ToilGYQ7f3JzbK1fdT5OWeZWEZEW59uDymZaPZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiZ5Ls9/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a31a69df7ebso15076966b.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706178365; x=1706783165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EO1pzdqis7E31fsPY5lBt4DWhagoR5K6jB4ti4c1CJ8=;
        b=YiZ5Ls9/CpHvRG6jnrdCZQ2IRQWD4T2sqYVCvud6L1ZulsFL+oAKWZ7+ECIlZptyfm
         sJr0fTdq3+YXHnBz4aavI7SR7jfkYpdfyGkvOkLkn+8kdoQz/fqrd0ToLlbd52nwOW4+
         Jtiz3cXIRH1HKfhToiNtWN4gsTx368OCB9XTiymkVcd1E1a3twEcJPJRKYgEUnMQ0BYI
         MBZIwRZ2fO3SV4UjELU6R0uAbscuFfE9W/SSOqpgepUkwxXf7TJKgVqiCq7w5pDBcJqe
         9W8VCsR2kzm/GDjLxD0fMZHatqrvIA6cCwehEjvUwhvvmnplDZ7S4SgcdAnfFMLH4ZxP
         xRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178365; x=1706783165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO1pzdqis7E31fsPY5lBt4DWhagoR5K6jB4ti4c1CJ8=;
        b=SxaGNL+x3ext8gTkVSfPg0e4llqSSY0QoFEO7Pzh7P8w76lAtN43+enK7MmC2S+AVt
         YrtMc0rgWGjZIK1lOMVKq+k5ppQQGH/fw+gnSE/LI6F2DlVN76RFrpNIq0644BgwL69N
         5iqYpNXqJYs4j7cs91ul///GMiKqVQ6BZQZJde0CTfuSr8JKrpba7ZcLI8Yyg+45i0YG
         ch2vGXue2qMz29rTsIRisUEhcTcw+zwnzzznYvn0yg6XKsz/IRaPPqdxHMsr3LdpEDap
         DadfLZDRLsgqN/cHu35UQNQPR9lFYJeRLPF3rKF4zSPli79Cnd+2oaHG/v/DhKY3PuZZ
         +iAQ==
X-Gm-Message-State: AOJu0Yw7cwFeQbFTheDJ/8vY7qkXMuoXknRSrR/JStHWhXsdoV5p78Ry
	B63qbobCQpeGEnddBicIeiq8K6tjshgV05mAqq4xwA4jEGCwt7fp
X-Google-Smtp-Source: AGHT+IE5+bQGD3mj0BmC//9RZpLX3GG7UOZ6Md4qq7UMROsK4DvNTgWqAbvEqHcsuBtxZ38gYxllkA==
X-Received: by 2002:a17:907:a094:b0:a2f:c5d4:2f55 with SMTP id hu20-20020a170907a09400b00a2fc5d42f55mr451589ejc.77.1706178364605;
        Thu, 25 Jan 2024 02:26:04 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id vo8-20020a170907a80800b00a317165027fsm591843ejc.13.2024.01.25.02.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:26:04 -0800 (PST)
Date: Thu, 25 Jan 2024 12:26:02 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
Message-ID: <20240125102602.kgpolvknpqdppogb@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-5-luizluca@gmail.com>
 <20240123215606.26716-5-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-5-luizluca@gmail.com>
 <20240123215606.26716-5-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:55:56PM -0300, Luiz Angelo Daros de Luca wrote:
> Instead of copying values from the variant, we can keep a reference in
> realtek_priv.
> 
> This is a preliminary change for sharing code betwen interfaces. It will
> allow to move most of the probe into a common module while still allow
> code specific to each interface to read variant fields.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

