Return-Path: <netdev+bounces-138371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0579AD219
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42D31C2112C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499B1ADFF1;
	Wed, 23 Oct 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V323B4uX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD35D8F0;
	Wed, 23 Oct 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703236; cv=none; b=HlHCS+NQWJ9cl9CtSDH5tj17LsWATSvymzClaeVOo4Hn6bWRWUHaCAhRsbWIPf790fGS2lESnTaFB1vejooZxXLxGT38pwVr95QOTZIbohFNKsTdMQpRpGitX2BiPqSzLlUSq70rd3swnJ4yf7U+8oqVrp722Dh8gUk0exvKfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703236; c=relaxed/simple;
	bh=CTlopoKKj6U5/c+ds2UJezYeKZAdgEHqKqEv58+ekrc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeA9ylvC6ariB1pQmbbIXop84NRuMw7iHr9L5QGSgseqzjLRDOUGVDaWefDe9Dm/jdqS7TrQFhclHix3NB+mH37LoSSbvct1mJji3oJf6hJ0DAWaWoFCCutoIhmuzXvKvlG6gAPf7rMeqSFKr79T2vBj4sQJ24o2GXxrrHWrsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V323B4uX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baec681so73552455e9.2;
        Wed, 23 Oct 2024 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729703233; x=1730308033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JaWidJfU3IgjixW6d/XGsWauF1pbmfj8wOb/yZzKIoY=;
        b=V323B4uXVbTgxH4MHfL0L074GzF6vM1IjhslINNo2ckIhHLKGxtPh7l9t7PhY5/ylC
         ZD0i1puKWzgjO8OMMwmENWjeG8kjN6RPOE4hO9uVxkUS8EMavX6bJMvTgJ+yYSok4SUW
         OrqxNV5GFBjIapqH4RyS1ljCOO8o/ehu2z5A0VLHMlxwuHQAy1rmYuKbYVpSY4LAdQ77
         NVgskFyN+dqCx72jS2v+38aXNASrWTutzHPpGCVEcew9/ZfC6MrAaBn7mJX9IJYDgdRn
         XdgFeNrEQdhbIt+4uX/U7akGnUsEuxoskJJwG6pOyMmwyqdc5ymdl/E9sSw2AN3xE8pr
         QntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703233; x=1730308033;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaWidJfU3IgjixW6d/XGsWauF1pbmfj8wOb/yZzKIoY=;
        b=q1lBRjwoGG+wUHiv6iN2j/4ba5DgqD6vn19egKQv+tVvk+AiriDOEECkm5NvhBVx+k
         B4B6leLM37kVu5Y7D3HN1wj9JSAM6Cpc2BJp4LKFVaFpP52/uZXMjPkTRKVIo6jfjUA/
         tDdXs0PrKiw8FbJz0V6Z+ZeyG2qjRjtATTW1d5ilEkK6jpmefWGAG93yqSh1KfgNJjrP
         jQxQVlSif+hHvLi35ZrbuPG2H/7ugTn9ppbjoc1+vwiSCITmwkPLvwnggPTjtTVTazPx
         sUNt+tHG5PovpTqVa/PLA/15eO/xHnNgaK2kQ6cH1dgSbS3a23zN06aeO9GC4db+YfyO
         E3dA==
X-Forwarded-Encrypted: i=1; AJvYcCUdW8rvXqSmfylRuJE2M6Q/OGUyKAX3+S20ArSZBhohs3hqoVj8PViUPxHsf6NwYBGDKZg0HzVz++Ai@vger.kernel.org, AJvYcCUhdYn8bs2hxChgbalHSKv8bGqdn22BZfHPtB2aRLENm/meZ5xky3t/D20YY4tKAqO6FjuMAaiU@vger.kernel.org, AJvYcCV/qI15K1Rr09KNCI2I1AutBD6h42jGW8P7EGXSnLrgFTh8ULUbtj7H43SyJ2vjaX2bVCyWqucAVlMHSovA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiom60KCK7sv01eKpVp6zhnaC/sB/D8paZMRxtHtKDNudAOj3n
	tqsAW9p8ElQ9ht8sva4MIoFtF15PHIotFepRtW+R5uDL3OB7WXAR
X-Google-Smtp-Source: AGHT+IEZmQMRACMlxf5P/dPNhbQTZyftTXwVXCqJKPwGo13eY5omo7juc5h7J60TFFFp/09QSCJXuQ==
X-Received: by 2002:a5d:4704:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37efcf051afmr2301500f8f.7.1729703232740;
        Wed, 23 Oct 2024 10:07:12 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4aadcsm9357173f8f.40.2024.10.23.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:07:12 -0700 (PDT)
Message-ID: <67192d40.5d0a0220.33f6c1.23bc@mx.google.com>
X-Google-Original-Message-ID: <ZxktPEtzI2ItzdXA@Ansuel-XPS.>
Date: Wed, 23 Oct 2024 19:07:08 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
 <4ad7b2e9-ddf1-4a82-9d60-7afd1856c770@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad7b2e9-ddf1-4a82-9d60-7afd1856c770@lunn.ch>

On Wed, Oct 23, 2024 at 07:00:22PM +0200, Andrew Lunn wrote:
> > +static int an8855_config_init(struct phy_device *phydev)
> > +{
> > +	struct air_an8855_priv *priv = phydev->priv;
> > +	int ret;
> > +
> > +	/* Enable HW auto downshift */
> > +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
> > +	if (ret)
> > +		return ret;
> > +	ret = phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> > +			   AN8855_PHY_EN_DOWN_SHFIT);
> > +	if (ret)
> > +		return ret;
> > +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
> > +	if (ret)
> > +		return ret;
> 
> There are locking issues here, which is why we have the helpers
> phy_select_page() and phy_restore_page(). The air_en8811h.c gets this
> right.

Ugh didn't think about it... The switch address is shared with the PHY
so yes this is a problem.

Consider that this page thing comes from my speculation... Not really
use if 1f select page... 
From what I observed
0x0 PHY page
0x1 this strange EXT
0x4 acess switch register (every PHY can access the switch)

> 
> Is there anything in common with the en8811h? Does it also support
> downshift? Can its LED code be used here?
> 

For some reason part of the LED are controlled by the switch and some
are by the PHY. I still have to investigate that (not giving priority to
it... just on my todo)

For downshift as you notice it's a single bit with no count...
From their comments in the original driver it's said "Enable HW
autodownshift"

Trying to reach them but currently it's all very obscure.

-- 
	Ansuel

