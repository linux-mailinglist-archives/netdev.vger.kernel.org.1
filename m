Return-Path: <netdev+bounces-249939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F13D21374
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D73303196D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DD34846E;
	Wed, 14 Jan 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkgeI6x8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17126D4E5
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423729; cv=none; b=ErvEdLiS0shq201y6wwEEZamyVt5QmD96XacyALuDIZ5PbuWniR4bqholoX8+APh+riYYsCtp9Y9nO6ldlHNGN3MenUTq+HFCxr+e9c7aisXgclp8XQdlFoZLlWYlaTYYFwA2PRLq3xlJZ2Wijpi0/iw4fRv5bvQTC0Mo7aNc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423729; c=relaxed/simple;
	bh=8QxqO3FSD5L1Vmub+oryPemAGs1Qef51fqxuqIV6Ei8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDKA9blhLht+Xzo/kPX1cIH9MAnl8ObW+ifH/30OOLQdVL3So7u9a2pBooEcgC3wRLbRd3GN6t3lN5/nFD+/yqGsoHP0daZD4nckaXLmuw/4zUtSz98VIBJWXjLY4D+Me+9A/0Y8emqZ9xpTbK+TbnmvEW3ccDbMvTbDrfcEaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkgeI6x8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b876b5c69baso4983666b.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768423727; x=1769028527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=it8YUnHSXKXXQABJkL2UVvwmRP+gSrkDN7MsvYyaZ9k=;
        b=HkgeI6x8JApyEaDjNhQ3sd86gY0G9OYvP5k3LL1uuwJmqPQ/TyhW61RyQ9UYPa6N0d
         LSOtrj2RXe9k/0Znk+B6N/s5HM1ai5pQI3BP9FTw2WjAYA/zYHKuEWq2sDrLvRnTzP50
         z+3M3gNDsoNQCOcjqkXnMfYDm7hlykRa3fFQp8VDsGAk2SVnsraMzjB80BSnzRuMhK7i
         rMWEhPdQ0uCPa+zsvjZyFyFOgkQ9tM/Gg6osE8baYvMGvZPqEQhcPQPWcPF9zKQGB/H8
         NAtAmu0O2vYOy1TdPU2fcscVVhbjnlINXj0KghSlD8dZVoUrI2UhKs7mKfpPeyej3dKL
         XS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423727; x=1769028527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it8YUnHSXKXXQABJkL2UVvwmRP+gSrkDN7MsvYyaZ9k=;
        b=E8is9/+yEyyMLZlgDh6qCUtJVdRkoIl/l6Qpf8HJNow+q7tTDpsHfC6aYn7ls7MK56
         3ocgKYAgPSINBJbuVWAzXFX4K0H03RntICaGXls5Fo9RBozu3fwmHLAHDAEN9lKupt4W
         LyiQQ7DK9zaDUK2XCQZTsdWhphJn3Uw5mgJpWVWYQ5rp9lrcmy4bs8NeaU8URO4PM8Pk
         m9kxAB0wmFRIuyVTeuvVA8YmrIjRjNxTqPNYrfd17Ba3hm5q6u1vk4A/RT1DQpUaqF+o
         fm5xDGrvKXOa1MYpuzqLUAnZR7i55gYttenkxgLDqXgGLA67KR8BTGNRF832vSsNYw7f
         P55Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqI/HuJ8lz/uCOvPGMfnjsV9aqd+aiJKkJ6g/N3KnrZEHk/BFUB1eu7Ts3t+GXx8m3PV85zNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9g4pbLH5SSLAt6IhsxgX3B4IteUWx77fOLMAXnLrPYOJUtLd
	tktCrCMdfgnfKgT4Nvl1tHxfQX8KFgVDz6/vTm8u8HAehCbp4NCSj17D
X-Gm-Gg: AY/fxX73cx/nmCmfaXho0TJtHbsfXhi82uExhfAEJdsNu9pZ4jcAzKSK5i0OuigYghg
	BwpwdavVyJ17TpUcjNfLFyE8gmf62bJrBdqtFmUccm2KYjbHd57SpFfxRc/XkOsMpO5WX1UMeFy
	htggu31FIlXgMA/ck3ZPXOePLImvavhjpFVtg4ZPHYCzUyv3axp0TNemWUDXTKZ6VK+NpRO7xDf
	4wiRi82liY3DYr8FVFQ+YYEz4wdN0urLdarQJZGwTaqH+j2v7kRw+ysKDUP4Q4PmADhG8MYicSj
	1yK6q/czh9TI7vSlrThR0cQX8g84U2aGWx/2H9F9cHdKuPDBm2cB5wvvZAnHgK+uIGinEO43njw
	pI9Ao9a+LQrWSQh3eR9y7pfHvp6YjI3dkK05gki3Unwmsf8empyWEWZCC8OT5cLy961W+DnNgBC
	W9m1U=
X-Received: by 2002:a17:907:d1f:b0:b87:2780:1b33 with SMTP id a640c23a62f3a-b876114f9b7mr180435166b.3.1768423726590;
        Wed, 14 Jan 2026 12:48:46 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:9b39:8144:8a26:667e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm1111374666b.17.2026.01.14.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:48:45 -0800 (PST)
Date: Wed, 14 Jan 2026 22:48:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 01/14] net: stmmac: qcom-ethqos: remove mac_base
Message-ID: <20260114204843.e4pyfb64n5jn3wop@skbuf>
References: <aWfWDsCoBc3YRKKo@shell.armlinux.org.uk>
 <E1vg4vi-00000003SFh-0Abn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vg4vi-00000003SFh-0Abn@rmk-PC.armlinux.org.uk>

On Wed, Jan 14, 2026 at 05:45:14PM +0000, Russell King (Oracle) wrote:
> Since the blamed commit, ethqos->mac_base is only written, never
> read. Let's remove it.
> 
> Fixes: 9b443e58a896 ("net: stmmac: qcom-ethqos: remove MAC_CTRL_REG modification")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

I think we reserve the use of Fixes: tags for user-visible issues, not
cleanup of dangling variables. You can move the sha1sum and its commit
title in the main commit message body and delete that tag.

