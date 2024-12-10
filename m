Return-Path: <netdev+bounces-150843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55C9EBB7C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939032865FA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F089230269;
	Tue, 10 Dec 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/+1kMLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092323024D;
	Tue, 10 Dec 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864748; cv=none; b=OFWxBvoPjgsQRWUko8nt8FInaaGKhO4YqR1zUe/EZ+rR2yvByARIrMu11qtRihsKMtih642Juegf9vivk8Q6qD/wZkGPDDobdahHRmnCdRqqVF/oiT30dNIMH0JiuEag3AB1bhk/KB+SgoHyQontWO1QXudvNl+hxvexlgenk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864748; c=relaxed/simple;
	bh=ejbmOJTBqR7xEm1e9LER2kA0EB3Jw24MnUDSaZCN97Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAidj1ANOU6NC+w+ReXAfqX/dcr7YpdR7igJq/HoLR1CBtvtSfoYujLVTVz+8dcbAOtG67o/qhOK5d2wAfL305nm+Jsw79RyCw3sZEpQD6MUU+zpGq4ENxoRUwkF46jatjSHk2E4qD+ijrdhjbLbXCitwfmr4TRKBfK171S+0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/+1kMLW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68ef1so841127a12.1;
        Tue, 10 Dec 2024 13:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864745; x=1734469545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCSUmM6tJtHk1cryES3nVKP4N3a8/9+7aIRBtf/l8Mg=;
        b=U/+1kMLWejjq782xtYbrDBlNWmh54h5OhALz8y+JjsTOeqyPr2IBWFiT7unwge8YXo
         0toQFN1dzS/Cg6+RG8tsTJ+p5Kdo698TEk2JgDwBYNONOqJ9KDi9f9h+v8Txpdk9f2Ol
         ApqfrNskGvOOado7qx9QtRK4iv9Om7NW3T9mW7IfRggQrA3/NOABChJEHRHMFFDCfjoQ
         nKF3JFvQi4cVTk8CV3btUegCJsoGFQT1rxgLUgZDJbkphNu6Odq3dqsNEbDpKEKPgn1d
         nhUJBH/PnFQpLU/lH0vb+wIFGYsITw/o9DhqhawyOI7WAl/00s5DcgT7AZn3BO18ifwZ
         v69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864745; x=1734469545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCSUmM6tJtHk1cryES3nVKP4N3a8/9+7aIRBtf/l8Mg=;
        b=cNJvknh5FcY9YTXFam62SUzAIb6CDvK1zavtgTOU5drstu4aAmp2iXnuVf+i3eruMI
         6aJSxkm+xXTcO3mCYlszRJw/oUcQbyfb88TyFoYAVMZnYdhMj2VUA+bfAen4V26yMxql
         BBGeT4iJfuRMqZp7EQesc/9WZ3r1wavxBz7TZOFpyC+VdVo7ynyikhgi3OF+At0J8Sxf
         lbI9XTPRPI+NerVNqT3N8xLX5cTxIR7AQafEVTyE3aQA3eoJjcvdCIsWs+OjR14tQS99
         2I9jKol2B9xYeXFCfzCJNk3cVzmUOxIdyl3GqWbIjVd9z7paamHxAM+vRcVXo74kw0M1
         b8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhOJ2FsT+R2EXJ2AUSh8OcnIyUXD9x5rZaTV1vTYq50+ePZ2qTMeOQf26TK3phIVvHinxDOh9P/Lnd@vger.kernel.org, AJvYcCW51XFnCOrjPdUXml3/NRynklkaomXvbTyjxBhbSeEzrAKZ4n6n9yD4HXmeU1kxWU2xDAj6Y96k@vger.kernel.org, AJvYcCX2bby+djxMI/dB9WQgvg0dqjb99aNYEIOs2gIaRyCADz0eZmQMvQ/GL8PYg0iWP4vvwBEkKCG+dnHLMlgp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13WyRzZG+Yujrs1fGMI9ggSTnNVbMjOH/rivrnrLQlBIx5gH6
	LjN7lZjf9dLHzCDQsHkh62kgKP5si6mAJFT8GlND/wzVZ9lgCQRd80EIkw==
X-Gm-Gg: ASbGnctOcbyfqTvWhjZkNbZVDGnnV8ef/hmf8QJ8tMEHLeZKnjt4DM59tqPRwm9COYk
	kei8Qlq0j7fuJyx5EgBx4x8eiMeJ5aKDu5DppDwAYk2c37IWHrs2cm2RZE/GtWxgoycyycT5n3+
	Zaim8de6TCwJuYOMf2iHWBSZu4yIlJlMFmHiUlGaEH92mP6foJLU3pQd0pmjL/R/CVv0N0T1NIp
	gjF3ktGh70h0c1dNE63XBu11In6pBzjNELsA2oyvg==
X-Google-Smtp-Source: AGHT+IH6uzJqyl9gC3tF9Zg5rL20SJAzl4Fe1it808wM2vN5YRgy4x6E1uwD9tzrmWPmIFxFqiytkQ==
X-Received: by 2002:a17:907:868a:b0:aa5:163c:69cb with SMTP id a640c23a62f3a-aa6b13ad3abmr7899166b.12.1733864744607;
        Tue, 10 Dec 2024 13:05:44 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a263efc1sm168094066b.68.2024.12.10.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:05:44 -0800 (PST)
Date: Tue, 10 Dec 2024 23:05:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20241210210540.jxhni4p2lrvdwoop@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209151813.106eda03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209151813.106eda03@kernel.org>

On Mon, Dec 09, 2024 at 03:18:13PM -0800, Jakub Kicinski wrote:
> On Mon,  9 Dec 2024 14:44:22 +0100 Christian Marangi wrote:
> > +	regmap = devm_regmap_init(priv->dev, NULL, priv,
> > +				  &an8855_regmap_config);
> > +	if (IS_ERR(regmap))
>             ^^^^^^^^^^^^^^
> > +		dev_err_probe(priv->dev, PTR_ERR(priv->dev),
>                                          ^^^^^^^^^^^^^^^^^^
> > +			      "regmap initialization failed\n");
> 
> wrong ptr?
> -- 
> pw-bot: cr

Also, why continue execution if devm_regmap_init() failed?

