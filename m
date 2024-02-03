Return-Path: <netdev+bounces-68838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F48848777
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3781F21C21
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB092AF09;
	Sat,  3 Feb 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyoTqgZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF718636
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977810; cv=none; b=fD3DELIK3it/BvYFYreB5CJdT6WOIuLv6BY6hHlSA/Vetwpbxqm22/z6YAgWOysl52kszavDYUtwUcuOq2TZMQhFLOtYi48fAJEc1HViFIXWrpOLFHdtn8BEO+O60LKXg7zWeJMkoK/WnnjSTqPgMBHrBZSU3IWE+H0dmkz/9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977810; c=relaxed/simple;
	bh=+OljRcxjC1mklwyD/bZBrOBvNx6A3S0ZcFM1gFF2q5o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrY22phEuAPQYeMueAtCUCMJ9h9doXPz8aU+m6ioxoZg1KqAFu6zr2QnvNwxIDzsu3ehZrQ7XuVRwFZXSEEnbUxJZW6L3TEPyAnvfMl+UBUqSVIVfeNIMBbNU8mR68tKBd1DhqxzEalNRwLlQYJ/n0erkkCiu7eQoCuYF8pF+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyoTqgZK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339289fead2so1972773f8f.3
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706977807; x=1707582607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXy27Vu2corIDixtadziHhytUS1dHWW8iRnrl99HUak=;
        b=TyoTqgZKZtCt1GX2hMLkgeLuJJUQbIVGLeCz76hbJsm3uhfggSU09hwbi5/f9exydU
         YHI3TfkA0XsVIgUHESC/czdqLGRkhyIPHc/6xL2LtwXVvKESXYMrq412LlphCNfdu9b5
         MnN6nany6Xcf+xx83K/WnWD6mTEz4rN8fhr0Ri3QqRCVQWbclGokQ77CuZZJOLhCsn7W
         dU8BRsiQ9GjH6ObLq2FhyoRTW0/Uk/WyB/Pja8LiE5tYvMWjpCIVni4nUyCxdUNk6MPg
         g3bYzrucffj5ePWkh9HJ9BcOMSGfghZe+SjngdzVgSNRS/t3o8uhKk1klnXTuLcKPCTt
         +dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706977807; x=1707582607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXy27Vu2corIDixtadziHhytUS1dHWW8iRnrl99HUak=;
        b=IoeWw4HzKRNpLfqje8M9jmXqynDBhKq2w74xkuTIE6BJNGh7iNzAGDQspvrQFoNckw
         fHINmdEsHbQNJPMuew9M1YqQGGMX5w3q9/N5K2xl5mwI52iM4yVDwy6/eIhPlkboxBuH
         TH7b4iBj6ON6qhBhxGTt53LZ0Ttg7DO4TclcOUW+U38LxfqSCemLzuoEP7MRBSNZ73dj
         KDa3R1t0+FIBKU30GTaWYT4CS8KUqboJbngMcHDwP1OyI9LirE2BWtqncsmD2dzPlzLB
         aBG9Tq3y9/WeIS9ZdZ7V8LgtNHOEypfJybKdyhZQMt0QfuHaJmtVsiPcd9ZPKFAFl+F4
         zEng==
X-Gm-Message-State: AOJu0Yyi44gqUEaG2mxQg0RoUzybNoc5zIPSZJtULARFfSoS+mB/DGqa
	HuphVDxSgMKdoIkpXCmFgsCK6kQmW2ek9gfCB2fZRrGD+nW4TFrR
X-Google-Smtp-Source: AGHT+IEG0kuTTqX5xnhiVq8iGL041iU25nugdIqHrxTPlttgb1AZuJle8tk9knD/575pV4Ue3l0l0w==
X-Received: by 2002:adf:ef11:0:b0:33b:24d5:f542 with SMTP id e17-20020adfef11000000b0033b24d5f542mr2651675wro.6.1706977806439;
        Sat, 03 Feb 2024 08:30:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKrUZForK475OgM2OJRRZAWTyeqJ0M3uTohEzuYCpLg7YE6ypyHbXZ9SZRBZSXwkkYyv5zrhi8iJhN+Y9qvEHo/jUNNScFRQWnfvcWaseZiMzRyvjyFASxKMNXmEZ4BUOkEmLHJ/r5sW1BRhtm3Zj85XaZTaHffUdMgscJqUhxFnAKiBr5E9GyF7MtX1EK6i871yCaWLTucRmKOgfaTpP+7UsAplYACCmYvf+4kII6ewWscHp2HZFI
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b0033afcc899c1sm4362141wrq.13.2024.02.03.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:30:06 -0800 (PST)
Message-ID: <65be6a0e.df0a0220.eede7.2924@mx.google.com>
X-Google-Original-Message-ID: <Zb5qCr45m64_Ug-e@Ansuel-xps.>
Date: Sat, 3 Feb 2024 17:30:02 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH net-next 2/2] net: dsa: qca8k: consistently use "ret"
 rather than "err" for error codes
References: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
 <20240202163626.2375079-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202163626.2375079-3-vladimir.oltean@nxp.com>

On Fri, Feb 02, 2024 at 06:36:26PM +0200, Vladimir Oltean wrote:
> It was pointed out during the review [1] of commit 68e1010cda79 ("net:
> dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure") that
> the rest of the qca8k driver uses "int ret" rather than "int err".
> 
> Make everything consistent in that regard, not only
> qca8k_mdio_register(), but also qca8k_setup_mdio_bus().
> 
> [1] https://lore.kernel.org/netdev/qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te/
> 
> Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

