Return-Path: <netdev+bounces-245033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44ECCC5A9D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 02:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F86A300980C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1222F76F;
	Wed, 17 Dec 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+kvoubX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2819E839;
	Wed, 17 Dec 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765933448; cv=none; b=YbwJuuykq5QmGlZPI9pwawqt3IYjBPzid6S2HOC4Au6007Oy4jeFifwKxDLg7tI3keIv3m9BiHUnZuEL3RF/ll5y5vkJ5nIVwyqjLIy0SRx4zBbi18zQIIjNn0EsYDSATf1BNHMoMRab/XKqEZH9yj92iPFfUvMMvPzI0uapxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765933448; c=relaxed/simple;
	bh=rA8m553sjOXTqrA/1tm7Zp2jR5sngGgp7J+kIfy6AU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/S3sZ2NaiiwUKMnKWvUs9NWIl2lnz6tVBaN/hHZ9wSesOAWFcKFHGOOGOODHyg9VJMbMt9CmxPblYZOQZhtd/lscDhvvNsMbGGA0h09IT/qhkvRYKlAJHCmQhuVCLGM/xcf60Q4YrqxCuV+c6dl/WjRUp6bQCYUt93JDsxIixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+kvoubX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9FBC4CEF1;
	Wed, 17 Dec 2025 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765933445;
	bh=rA8m553sjOXTqrA/1tm7Zp2jR5sngGgp7J+kIfy6AU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+kvoubX/6VRDqapcXGj2PwFwd+FSL67UFm4+Ggr1OE94ngwM1CVSa1lS7lKbFQqQ
	 0UysnBIa5ApyGsgEkVbdrOQBF5WXU6Zxd96dnPS4IwrcBGB7EfO9EfoEILYm7Bnvz7
	 OfC5QGchnkQ+tjeh1a1mASK9NbKtb3+eNpKFjLuASzJt+5JeeopG/9MMgMk9FKrDWi
	 knYDYDGCRDTu9PaPsfQlQM3IltvJom4mxtBFlTzu8rzo35CIyu85qGN+yq1H/3XuyA
	 pBmUPMVlyWm9NJdz/s4N2V5mOto9IN90qwuBOzEdmJbHjX/nkyHtD6+NjTMbRRagch
	 Zxl5ej9Usz5Tw==
Date: Tue, 16 Dec 2025 19:04:03 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 1/4] dt-bindings: net: dsa: add bindings
 for MaxLinear MxL862xx
Message-ID: <20251217010403.GA3467893-robh@kernel.org>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>

On Mon, Dec 15, 2025 at 12:11:22AM +0000, Daniel Golle wrote:
> Add documentation and an example for MaxLinear MxL86282 and MxL86252
> switches.

Since you have to resend, drop 'bindings for' in the subject.

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> RFC v3: no changes
> RFC v2: better description in dt-bindings doc
> 
>  .../bindings/net/dsa/maxlinear,mxl862xx.yaml  | 162 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

