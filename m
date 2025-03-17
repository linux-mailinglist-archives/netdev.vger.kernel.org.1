Return-Path: <netdev+bounces-175376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2AA657DA
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A642165A51
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964019DF62;
	Mon, 17 Mar 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjrsNFvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6E19D09C;
	Mon, 17 Mar 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228534; cv=none; b=F5rTTdNVtglSYP5CTB2OXPXHIUpvLFhAJjIPimKObvXeueuiAbtisGGZkOdS9EMFzlKL/cSBtonSs+8y68sD0NUiaP5MmliztRS7Kfzq/9BEoUq2YXMV6+Pk9ov8dOl+jzBSE7SzIjklsOGyCYlugEVLaeu/idmR9qxx5k64poQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228534; c=relaxed/simple;
	bh=0svckh3B/Ur9jjk3KUvtAqq/TolLLfjt21X84e1pv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKCYRF2f7jegKeETTzDu0Rn/HGjul0fd21YLmg6eQHm0mg7I7uxuBkXhiL2C6epk6RY6V8y+hsbb3f2ECZUj5MbDW4mInfsfPswT5nN9Ub/7CA9dCEHEe5SOYU+RwSImWvmFSOvNjUa5GBd3WO9elq8XE/FfKqMFkxeN6HpkZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjrsNFvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAEAC4CEE3;
	Mon, 17 Mar 2025 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228534;
	bh=0svckh3B/Ur9jjk3KUvtAqq/TolLLfjt21X84e1pv9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjrsNFvunrz0r+S3+meOeT86EC7RKhSfjAKDmdu2f3n00L9SeMslYa8gr1Xz2fwPS
	 yJ86j18koS0mdtT4wb2nBG9ZBVgztxzJjED4/pph3JNhM6MKgDIvfe3arTzo8tH2QO
	 huuQ+2TQxmo0GSEbaCYTekhX1LehfX54LuwUIYY2UXn3rTNbjVz1m8Ue4ihk8nVYaI
	 yn+R3egkK+0Yaj/TkKaKuAwjyOizlwbBJfdScICKg2q4IlyrjJwcsQsN03fzKGyl8M
	 WpylqTSuGDOFHd35Yx8Z3gtQ6PlALpuAEC6HmhUA8h8oR0DjJpeR01+p/WC5V/kqZN
	 BMSZTKxyZZYgw==
Date: Mon, 17 Mar 2025 11:22:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, upstream@airoha.com,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v13 04/14] dt-bindings: net: Document support
 for AN8855 Switch Internal PHY
Message-ID: <174222853284.168151.15677522554772356388.robh@kernel.org>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
 <20250315154407.26304-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315154407.26304-5-ansuelsmth@gmail.com>


On Sat, 15 Mar 2025 16:43:44 +0100, Christian Marangi wrote:
> Document support for AN8855 Switch Internal PHY.
> 
> Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
> PHYs on the MDIO bus.
> 
> Each PHY might need to be calibrated to correctly work with the
> use of the eFUSE provided by the Switch SoC. This can be enabled by
> defining in the PHY node the NVMEM cell properties.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


