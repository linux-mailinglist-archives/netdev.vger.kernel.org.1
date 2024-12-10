Return-Path: <netdev+bounces-150844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989F9EBBAB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE01889C25
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAB22B59D;
	Tue, 10 Dec 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMgjCp/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0123ED4A;
	Tue, 10 Dec 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865337; cv=none; b=h5+ROOCk0/uIlDSs96juwN4uPx8hClB+iaLu7lrufWkrH95WEFuRFd35oKa5po8kM6Jw0cV3hs6JTAvIJHa5me1ijnDAS13nkkJO2zLQo43h3mm6OR/KxMSc6NKmyR+e2P523aXfghKTbobRPGi8yQL8wfi1iYqH/ovJvrR6xqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865337; c=relaxed/simple;
	bh=loF/WZMc4MUUZFW1S1NBMDs3YzeWx6d+kwJy5sZJzZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttlb8aqEVZMYsxe5MgiIn425XDtz5Fkd694LwCb1mIgEkmvVhOkWYHkUSJL3avI+nhMz4veLajkI3OK/pWA6woJ3THcEOuOSfocRUiiFE7TE5VnKstMXc5PWnYnvT/0yb5AxCftO5xig2awkyclV1wjfoH05TXoPijrg3R2Tvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMgjCp/h; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6935b4f35so37407666b.0;
        Tue, 10 Dec 2024 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733865334; x=1734470134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7QDnRhBemOiZezpHGKSoMKm4TcZsXptVa4lYZVMKw4=;
        b=XMgjCp/hbtV5wxKZJ1yTeKTavlJofuAgGl4vW4GVI1n6EqeVf3788/Vn9w2qnssQCX
         hKnexHVjCUBqkPYMKV0a51RLLIMxlFbN0WMieU+Dc768y1/T6KAzxBFyq7E49SMWfAFJ
         12stgWmDI56kG6pmYmGEbVR5oTe2ivR5sqz4VOLP8qVk615F9ziV2BTGaUEZBMFVBP9T
         6P5qywjgbXsPg0nzpOvkhIM8QaLeIufqEmE83mznQwc2BJpIkdCpBoC1DiATFTycO/aP
         DBut+TlDhGYdiNjcGTjfI+osqHPUm8ukUr+uL7MrGZeTgJKe1ryChtZ2Vnd5t2C4NdGX
         mfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733865334; x=1734470134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7QDnRhBemOiZezpHGKSoMKm4TcZsXptVa4lYZVMKw4=;
        b=OTkdgF5JNVU/0gTmbNKGXmLBR+NzO5EeqcpugdYFCObFWyOrHafme3b8DAkVyM52jX
         jVbg5KoE6IJiN/qJD6B2pc/lbxhJeRMPutD3rK90OBoA7qGHKYPX/RfYjlyhmHWAtRcb
         SRLLeIYdeiJqbdGS0vnc6ApuuxGFx6Tnvxu6U/HtLhrKlrGmfS9TXzwY9dxD24oIXXV+
         XpMMURCU6Qv5wec+Dy191xDqoA4oG+/grmvHSFqH8TcE+wHfqGlYQbXXZKTEs27kVu/v
         g8oiXXbdR/UdDpVH9o+PdIAqHfLiXHeANCbQGczbB0fpRhowurjQ64fAVXxboF0UHO/n
         KUGA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LAnPxc1Aes6SRcMHLPI5yLK7nlRfGdRPcr7KqqW6twqqAgI8s9cCitdQkcbJvzGjYfaHAOHg1iLL@vger.kernel.org, AJvYcCVTceGi+R131pO1wlBp9chOLAJqP+fSqHbQjsHy/frhyrOYJXokoAM5wkI7By2q79gCtgTwK+ZZ@vger.kernel.org, AJvYcCXdsTkUYm4dLBkRDppf/UPBYYQkBlCxSVSjBea0pUSU6zWxvjzILas3C8dUKuhYVBImMruKeR+S9iZPXcwo@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIKH7F6dyF6YkCIbK4nQX6tK39mweKoX1NK9GGArOGK0CWPGH
	fCBhxPxrc5SSsg5ul7OkxHAsZ76WMFkIKUWoaFpY9XdL8A3fwMAg
X-Gm-Gg: ASbGncsi2F4meM7NIsEF5Cjk4N16VXEot31HBG4Oi5+Fxwh8+7u2Y5PPu0qcSIiUGXH
	9OhikyOTqxbXhYdT0iF8WaPluoJgAQ064xfYAfCRK9Leukz1q/CYD8PNfMqtvHBW0qvgYWUe/Ik
	xcPXBmgAn5W4kEsfw4o78I6XakZK2Q0srjJc8Hs1PeRAjeLLT4nZeOPWndQ8k94Dv6XNYpeWcOQ
	1bVSCi4JUGYtYtf96UIIbK0ttffFKmhVf4Vgyia8g==
X-Google-Smtp-Source: AGHT+IGxAjFXMAf+F8mEXMc+auUHpdwpbNPCA+k5jUjJE3/MSupwfdCkIxkoOyQU//98Mv9Et2opNA==
X-Received: by 2002:a17:907:2cc6:b0:a9a:b50:1c4f with SMTP id a640c23a62f3a-aa6b13c92a2mr5523866b.13.1733865333794;
        Tue, 10 Dec 2024 13:15:33 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa650ea7369sm596924566b.74.2024.12.10.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:15:32 -0800 (PST)
Date: Tue, 10 Dec 2024 23:15:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20241210211529.osgzd54flq646bcr@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>

On Mon, Dec 09, 2024 at 02:44:22PM +0100, Christian Marangi wrote:
> +int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
> +			u8 page) __must_hold(&priv->bus->mdio_lock)
> +{
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
> +	if (ret < 0)
> +		dev_err_ratelimited(&bus->dev,
> +				    "failed to set an8855 mii page\n");
> +
> +	/* Cache current page if next mii read/write is for switch */
> +	priv->current_page = page;
> +	return ret < 0 ? ret : 0;
> +}
> +EXPORT_SYMBOL_GPL(an8855_mii_set_page);

You could keep the implementation more contained, and you could avoid
exporting an8855_mii_set_page() and an8855_mfd_priv to the MDIO
passthrough driver, if you implement a virtual regmap and give it to the
MDIO passthrough child MFD device.

If this bus supports only clause 22 accesses (and it looks like it does),
you could expose a 16-bit regmap with a linear address space of 32 MDIO
addresses x 65536 registers. The bus->read() of the MDIO bus passthrough
just performs regmap_read(), and bus->write() just performs regmap_write().
The MFD driver decodes the regmap address into a PHY address and a regnum,
and performs the page switching locally, if needed.

