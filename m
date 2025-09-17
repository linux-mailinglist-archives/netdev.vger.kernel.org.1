Return-Path: <netdev+bounces-223945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FBB7E0F7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA904520FE6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B70350D4E;
	Wed, 17 Sep 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUhpTyNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83F34A330
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103881; cv=none; b=h/OouVgbC2hb2iheCex1uqz/mjrlP4R/8th7052ql+hrfMKOiREnnBnfnt0b7fkzq/XBAUTmO1eqAVRcnUNI5+1KCiC5sopljOwmiGD9lMCc2oJS9fongFXTQk61aQBpCbTj7/WYL8lNRYiMb5ffgxGAxKvJaffpE/tUzr9XDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103881; c=relaxed/simple;
	bh=4ga+azf3in2hBznJTvkA4X779mL4ML+24lGMfj0nOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHyHU+PDq0lX6sCct8qAkEWH0SSP6YrVJWNg9L1Qhvqw/5by43gHVCYb3BdTnRvPS5Bw66bNZXE4m5zGD7u+LUPclJLCGS83bcE4NqulLtLZ6dCoQtko1Br+bcbALIf68p7PjmTbE8Q5p8Bcqy2XhGg6rHfOEz1F2Xso6kiEW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUhpTyNX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so14016635e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103878; x=1758708678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFlgCXptLNgS0oUFv7P/jnH+n8Ia5ZxafQyZ/H5sxnA=;
        b=MUhpTyNX/GINaDZeI389tgHDDW8Iot5T8E8vryV5EYWiBHdMXKiKz4ErdSibSbOtv0
         b5nTyXNQfKyGEXzqNiQhyE81tnq+Bf6uoScQZ4si8+8wGtqi5Um9Oji8OlnjqeoBQT/l
         k0HV1W88o8UHmcbXHyEfkyNwD8dS5eucgA2UPWtC1VxxM5r/ezoin+p4NN+KbMQkwt0m
         +H3asFVkENIYAM/fQikTZ8ughU2pumIMXMfA98ROCJvNQNisnhsxa7luxfKcHuZN8p/I
         ItnHtdeRqdbFYAY6dqkZSeHoMsdgKT1APsgH2umX3P2r8ym9wMjZ8dkxKd7pyhIQyPnb
         l9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103878; x=1758708678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFlgCXptLNgS0oUFv7P/jnH+n8Ia5ZxafQyZ/H5sxnA=;
        b=Dhoz0pOTN0FBO+pVoczFwDYt8PCVyE9sY51jAOZnR56pPviLf7Dq60qMH+dqyoLCqp
         gT19torurMlw2j47Q575JTJnjtGQ2iVKI9PXPwyW5sPTcaOiYqrLZEnrVUohpbjUejXk
         XVph48Ws6Ufv3tUU4+nPv/+NydIVRHylXbgJk4VG5Wfj0uhwCfEbuRQvn1lfUBLxdNXE
         3q6uFHsam+IPHwBs62l625kSGyp+ZGq3LC4wUCDSr3nhRMucC9dAo2NYqQodBUdqdPj5
         emEnjnn3qOWe9ZaQgKJEOHf7dLDF3021W6yEMiIieCZ1p4aqtaNo9vTdMrlZZ6wrFkww
         rjpw==
X-Forwarded-Encrypted: i=1; AJvYcCVOoH6cvgQh5fy9k0S+j3FFoBYMua5YD7sLtAYcrGvlfODt7bkE6nZ+buOa8zPr6BAEHL26Gvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNT+RqRw3aUY5eTCC0hno9gsdaBDeCVju1xy3Oau65GDJNIbf
	tL0d3TyUO2Px31aGBIcdBFf59QtZLH3TFxUpQXK9oee3a6bdSNqPIVKk
X-Gm-Gg: ASbGnctmvSCUcM8u7O23z/YA110K6LK78TBY6gXiSa957E6hnPRwZZqdv1HdaPCi1EZ
	73Fed9V+ABEJ1n79x427RZ4bHsrMnIV1s8TsxzI7d3tepeSWryxea6qcHYcnBTKIQpamv9LVoPS
	v3e8FX+lSc2V3ZdN0AvdZJ3Sx3/+fKQI1o/hV2OSj4gf6ooPomWvWd8fKwG/WplhzA/TLxE2ye2
	3ioOJQ4jKVc3bKhTa0xGbv2uNg9E+o0QQAmwGIG530pbY6k7LGslqwT1k7W8pfCkVaWIl58Aeyy
	u9IrB6vrUaoioicnbVrcPltkr/W3yeBqrHFkOh9LxShNmCACa4xk0fl8472YwWVZv9PD2NaSMBH
	aZnhG5/fMHvEDF4Q=
X-Google-Smtp-Source: AGHT+IEGAWHbOGCVA8E1ghCrTfok0wf8HrSSu83uqpK5rtG+yvptJ+uZiWuJFaorxUfrNpWZkT3p1g==
X-Received: by 2002:a05:6000:400e:b0:3e9:e2cf:cda2 with SMTP id ffacd0b85a97d-3ecdfa5ad4fmr599670f8f.8.1758103878166;
        Wed, 17 Sep 2025 03:11:18 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece0fba34dsm1092120f8f.9.2025.09.17.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:11:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:11:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250917101112.555jzhzlmpkhgmh5@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-7-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:42PM +0200, Christian Marangi wrote:
> +static int an855_regmap_phy_reset_page(struct an8855_core_priv *priv,
> +				       int phy) __must_hold(&priv->bus->mdio_lock)

s/an855/an8855/ throughout this file.

