Return-Path: <netdev+bounces-128497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E8979E66
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6881C22999
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172414A4E9;
	Mon, 16 Sep 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab148Y7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692714659B;
	Mon, 16 Sep 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478714; cv=none; b=Hc2Xn+7SuaF9FaRo6Jj1wHIHAzqCUaBvTFwoHdRZoI8CjYKKYxPgGls2RCPEuDfgSFuqbp31+W0aUBK6LAFLUoTQbfdBseEyF80xvCZrtgmPCvOU59yOOqifchm0eytGaE5ecSIjG4phC3ULpCpRDUuNInY8WvYs87dRMTCtsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478714; c=relaxed/simple;
	bh=vLrfIzpNtpqTfCOqfCAt9jt7gKeQhXhVTLWVC2YKFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS7YWelAgYUlgoiwvzCYNzfcwJeI0W/FEdeOj2hXf0MBKoeCarhFYXHRl7A3IdEBEM3wziyHDQPN1fsfF17rjflMAQeJe44bjwtmVxh+quA1DwsiGJzB72YVGMOi0gRXjCXdJRtOnNvZ29AWuweQODKSmpnIVe6zs14G44+iIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab148Y7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7B1C4CECC;
	Mon, 16 Sep 2024 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478714;
	bh=vLrfIzpNtpqTfCOqfCAt9jt7gKeQhXhVTLWVC2YKFFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ab148Y7b3rAN2wJtP+0rs6F8WuJGUh+t4Q+569KNaWahtaZZwazP8kXLyw3e2Pq5s
	 E4Ali9Ca/76F+iWaRO1GR0VntlhPOO9eNPDFQM8W8Xrb15bRuNylTRKskKGf0/EFya
	 EHajF3wzpfJCAD6Au6J3E3EnoULv/jh/Asm/jLcD9SUq4eRD3wOVIabIH/HqGkz/QO
	 wdTOlBGvJKi1KrEhPe6qJI6PVrRvmcXhz6YGf/eWTVa1OmJCF9nXrKcOR1N/3L6pgg
	 mKPJWTmsVlyLnlKewrnw0W+JbVPnyQuix1GEhHiBr2mIZGlO0oQ8ckLfgu0MCoiuDG
	 mY9JrPkt9zTbg==
Date: Mon, 16 Sep 2024 11:25:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Sen Chu <sen.chu@mediatek.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 1/3] regulator: dt-bindings: mt6323: Convert to DT
 schema
Message-ID: <iv2v4ywijimac7l336sgqqm4rfxpx73tgmsil63z7l2xilpivz@vmpff3oitslw>
References: <20240914132731.9211-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914132731.9211-1-macpaul.lin@mediatek.com>

On Sat, Sep 14, 2024 at 09:27:31PM +0800, Macpaul Lin wrote:
> Convert the MT6323 regulator binding from the old text-based format to
> the new DT schema style. The property "regulator-name" has been added
> as required property to reflect current usage in mt6323.dtsi.
> 
> Examples have been streamlined and relocated to the parent schema file:
>   mfd/mediatek,mt6397.yaml.
> 
> Update maintainer and submitter information with new entries from MediaTek.
> 
> The reference document cited in "mediatek,mt7530.yaml" has been updated
> to point to this new DT schema file
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


