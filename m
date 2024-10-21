Return-Path: <netdev+bounces-137478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C49A6A75
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F561F25B06
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10961EBA1B;
	Mon, 21 Oct 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcqkH9pp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7A1D1E61;
	Mon, 21 Oct 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517773; cv=none; b=mPUYq4s6H1V1v658CaNpIkBfOMo5lq0t+EYawSRswA7PC6qR2j1As3sy95Ou2vGlkshz+yesG8w/AQTxvcbijPiaAUQajLsFSFy/7R6AT/HXSFKp9plTKbw2S+1kQhLk083rXqwxlw+LsYKVGCWvQBYgbIoEpwPFdA8oy1w5tKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517773; c=relaxed/simple;
	bh=7ejbPkgmBzrbdcIDBY7U2DR3YaP99NE2v5gBEHCZrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJD+sMBjmXbAW+JrtoaoB1Gsrmy4CuFdaxgQMiE8paIxWFCjmgS2qETJmp0Rl3HO/TUbXm76h8GtuJoDBm8RrE+zFVl1+mS04t7WDOzJSH6L8hU5LovhH1E0t99uLbB/qv/hBqX1edzeS5dPtSew7wHKT3w3X2mD6OOb+oFRiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcqkH9pp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a966de2f4d3so47842466b.2;
        Mon, 21 Oct 2024 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517770; x=1730122570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ejbPkgmBzrbdcIDBY7U2DR3YaP99NE2v5gBEHCZrjA=;
        b=KcqkH9ppXOgdtISYrjtsqTesriVTDQnGRSB0dMjzdQvEMspiLL4zSn/D4byFGbTZsK
         YL8KdP+JPF00KyjsyI9zhuyYdlHEO/HMw/FphVW6l68JcYzrCAwAYMYUAHERaZcKL/RG
         y6CsYEh0n7VC5YZYPvmRF2dmzQKrPRHhvdt1TbsRyco7hJVHr2GV0BpOB7P61n3Ab4Ih
         lDWOvhXr0EyUnU8K8o/dJWO7N3rD39iZB5STY8ZULbP/1v8iJqo7a0Hl9DMPAJLC1WWm
         gAFzeu+cVbby+ECpUy1G4iZD291c8Ze1KbodeGeDJpBJeOjIH2Aq9KVLohzzz0Ov6miG
         9s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517770; x=1730122570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ejbPkgmBzrbdcIDBY7U2DR3YaP99NE2v5gBEHCZrjA=;
        b=arwDL1x1pEylJ5BEfkX7fi2YN8ya63EPBZY/2CcvrxSwMFqkqa6HTDGKZL7d5Awg5G
         EbfVBqOwL10VlsTT1AMNMUU593EdEpDtmy/ndm/cK4bizIK0QBiZLE8ifUMCmAgCHY4/
         +vDWYNOl/KxJPRfkOevF2sULgrimswGClY39QkB6vkzzmP0qrVkywI9jHMUJkahCwJwN
         IIiGw0WM1ODAIkoQT+u/V7QamxHFLAnhTbMPpKet9jJJoLZ6LWTW7lHiVJ3CwRzgs3/w
         uSuhEOI45lM2y22W1tnvmNdTPDfDRFH/aSfjDlvhYnRjXNd29d6gC85JsZP07OlSjBSr
         OCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZGkl4ehbJcdxsARn/XUv3yus6rovB2qxZ0u80OwLMBSbv1/Usj7AOv3HfbCIXOMEzf6FFMrI@vger.kernel.org, AJvYcCW+HV0VyIHzEZDL1Qa+bvowSGoXYkQGOs56ClA/828rCEgKlEUCgNgl2sDNkay/BUre7aGi7GPkzxr053tM@vger.kernel.org, AJvYcCWBtCcaBcpqU4/vsFfJYzUxeP+h7HgnC19GkRN0jNPEpzQDUZsS9rNVu/3608sCNzAWiLG8xY+P9fQd@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLPbO1SDeDpABZ3eNNzn/joKlljmVyAzWzcx2F3/VtNZyfHGr
	SewvGAATD8nKGsyXLIHOam/q2DlKNePWhH0+4Sbq+FMhA4mQy4sY
X-Google-Smtp-Source: AGHT+IGNYJBaRpTS/ccI6Q7hA9PHsmRJtd+/a127r5kJAH8ZNrCayA8KVxqY86ZKxcGODMA4JgMC/g==
X-Received: by 2002:a17:907:2d89:b0:a9a:2afc:e4dc with SMTP id a640c23a62f3a-a9a69c9b851mr468402266b.11.1729517769359;
        Mon, 21 Oct 2024 06:36:09 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm206007266b.67.2024.10.21.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:36:08 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:36:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/4] net: dsa: Add Airoha AN8855 support
Message-ID: <20241021133605.yavvlsgp2yikeep4@skbuf>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021130209.15660-1-ansuelsmth@gmail.com>

On Mon, Oct 21, 2024 at 03:01:55PM +0200, Christian Marangi wrote:
> It's conceptually similar to mediatek switch but register and bits
> are different.

Is it impractical to use struct regmap_field to abstract those
differences away and reuse the mt7530 driver's control flow? What is the
relationship between the Airoha and Mediatek IP anyway? The mt7530
maintainers should also be consulted w.r.t. whether code sharing is in
the common interest (I copied them).

