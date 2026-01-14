Return-Path: <netdev+bounces-249948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DBED217B1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0A643001014
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF063ACEE9;
	Wed, 14 Jan 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KttFzOT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525233ACA62
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428092; cv=none; b=R6si5o0AYUdDJvCEGV2N1DyXRix7rvVTgAZu/0PMBwbeV0CL8UWt2SUa3De5JY4Hsvrh8Ry0QLojHl9wGuo7gEjQJbDwLb2icHJb3py+Gy4jRk8AoO8g7VtQq1lDtOQsmFDdauLst1TSR8BQYVwd+5GiOU9CDVU5bcLWgLK+zCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428092; c=relaxed/simple;
	bh=UXt6S4TpfBRSqyKspcRGmcotgc+gMiJo0lHQ77R2USA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVKvz9okCjoY4fm1RzW5tTtDa4sQ+fDywWmY18a2WuwWZ3AYpm6/RL6QKU9JVKoQ62l0VKpTUyYe3dQN7qF1xqBgq1e3H6KR+VQiX3tW+WAMBU3yPchGJP24Aay6pngLaOtlt0GkR4r6DnlqD/sqJ1cYql4HFoxeBVsylMKoTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KttFzOT5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8773fcff60so5136966b.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428079; x=1769032879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fsIk4jpB+wwgEY/M1kmFIK656V2ZUNhMLdjvM35Gac=;
        b=KttFzOT5BJTlVyrqe3walj5H++1gvMw4CU12ijOqiZaHwc3GuReBLBhVCWsvLI5mQg
         nNt1hkLuviJeREgJyOltMIYpQlMZ2jVWXLL3mPyicoYuFUCrS6JGbnFvqOyj5Zg+4A3v
         sk06cfaMlJ6vQYZug3cxh2pufJmbaQoHSDljB+kWVOmk/c9Bc2o/fZT96FMd4bbtxthG
         SGt9XUla+Kn3SFbyLbmNJoX+VAUCwiJwQATfL+ku1dqiXDKURbSKf/wvRJE0Pv2/4tnc
         sqA2GqpsmV/rZd+OFzz5diGgDEs2+I3c23Zh3WhH4P0MidpxvqbL4dMx57Y9UNnVoJ/A
         LJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428079; x=1769032879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fsIk4jpB+wwgEY/M1kmFIK656V2ZUNhMLdjvM35Gac=;
        b=N651xKWsxxDomL/kegjO8+krvTQ0UThfkeEXfC5dG/4ffwjTGG0cZDssnGBUTBarzi
         2yP5tI7DzwwdwBygFqaIWNn/CRe5JKkxNMnwT47yC1NX4ki4KdFAEb7pxPuvsbRBpYUf
         TkWODHp3VyfBsPvPkbMCqT5OybIRIQrQLhwTk4U6qVCQKGV5+z7lWn4N7mkIMlV06gI2
         nu/v+z/M+agPIBNggCWIc3Ag9CvfZDUaHyo6EeCbsOHSH6PG+Eanje3g7vU4/eeZhVvf
         fhhJNJO7MmIkCx2KUhsPp40cqwXD62AJUQ3KRPUds/noVcG/FuOHB+VnxTXJ2gH/g00G
         MTCA==
X-Gm-Message-State: AOJu0YwQ/PAKcrrvhzdq+APuJeyukOy3lFGFVMoiWiMOIZBvJRC/5jxt
	UDCcq6pGn/eM5joWw+kNgOqg4WTdZxO2z7WMzH4ic6jOQ7D+i2GCpLkr
X-Gm-Gg: AY/fxX78Og80PBAq9AngHcE+YApvu/GBHvptAT57uk5mvVUDdTRu7blLYXY62Pg575J
	KtTX1oy/ADfR+sesVIUS77eoZIzLeBPFf95hlQaQTjqvLB3M9HBbYvhBRKOpU3nJDT59OY1DPQS
	ZfL607fNLx9lLocBIUxH3EtrRbDw/Dxj6jvUsLWky9pAhIzeFVOJYqxjF6yGucAKYBv8d8ZCqLv
	OF9gNz+XEz88I/rTN16NQW0t3hnX59pxFf+Hu+z3aunZ6cFM93kjNom1vceZYgJnAqyh1ETPXkK
	MWk8nIc88IotKBfVF/CIdulY9uftnjAT2CwNePNxo5L7gH1Exz8SbwcXcZBK7Y1aciE0PATbVAW
	BKfRuaFKVjdhfpq54Xt5r4rHH5iJ4zV77fVzgivJpmhHDxiEJJNSZcq8reS/yiw+w29cCdJphfM
	czNw==
X-Received: by 2002:a17:907:3f1e:b0:b87:1e1:e562 with SMTP id a640c23a62f3a-b87613efb71mr205604666b.8.1768428078730;
        Wed, 14 Jan 2026 14:01:18 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a233f2asm2560649266b.13.2026.01.14.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:01:18 -0800 (PST)
Date: Thu, 15 Jan 2026 00:01:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII
 slew rate configuration
Message-ID: <20260114220115.kou5rkxbvcn7hm2z@skbuf>
References: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
 <20260114104509.618984-1-alexander.sverdlin@siemens.com>
 <20260114104509.618984-3-alexander.sverdlin@siemens.com>
 <20260114104509.618984-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114104509.618984-3-alexander.sverdlin@siemens.com>
 <20260114104509.618984-3-alexander.sverdlin@siemens.com>

On Wed, Jan 14, 2026 at 11:45:04AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced maxlinear,slew-rate-txc and
> maxlinear,slew-rate-txd device tree properties to configure R(G)MII
> interface pins' slew rate. It might be used to reduce the radiated
> emissions.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

