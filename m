Return-Path: <netdev+bounces-202060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E9AEC242
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140C0566106
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE728A3ED;
	Fri, 27 Jun 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRrBwM0Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133D28A1E4;
	Fri, 27 Jun 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060768; cv=none; b=Scc5CckLYvftw3azpLdbNKS4XrzjDN7+8KtQ5/EAAMFhQ2X70LAIRIQnDQaNtOsAo40aw5fRHap45OxKOFzALjKm4uKP52eoF3iGebi2ZbxiscfhjEbq0tmvyfct4Copu5V++pAXnFI+1yeu2hQaE2QF7LQEnx+/dsgi+mFiwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060768; c=relaxed/simple;
	bh=Wa4ecWizOT5Iqtise/QjGf4n6skn5SZMXAZ5hYrTYRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCtlKDi+4mTmnv8RmrYjTBjoRgQOdj0cOgohrsvRq6VDiEWnEx14rZ9kBq8NlEnwr9or80LBpaFKavkvWY1LOBQDfSpTCqH+1mVW78gKmKTDEEZUs7DSGbnothOx8ntkeT9ugjPGjzoUZgBUw/HmilskW2gFDjJZ7yWK2nKO1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRrBwM0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25672C4CEE3;
	Fri, 27 Jun 2025 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060768;
	bh=Wa4ecWizOT5Iqtise/QjGf4n6skn5SZMXAZ5hYrTYRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRrBwM0QoCU5lHi0MAk1WbFBSz7918jSwXcUAsuuaA90vjTItz66KSqlfnTGIvm3s
	 63f3KpVEH8MM0fZ1M7lrpffXGgXIi3T3nje13ZvJQ/8lLHnxt+5YfxOySB2pfE96RS
	 0Y8rRTKoblzxauvdBHy6Ri/hiOEk15gRlI/hRt3KFeRJvGBNfGmfaT0zrHvOx3puD2
	 vZdeYh0ZVEMQNhtSiY8gbL66yJh6j4ooCO+CsYxent72DRn2wNZ9CpYXeOdz4yW4qG
	 Jt7tLQN3EyBIYrIaUY6MePBhDVSOfoxAiT7u/0mCb9Ln1eWkV9hkDZum7bONuz0Vd3
	 MjnwtJlybu7gw==
Date: Fri, 27 Jun 2025 16:46:07 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v15 03/12] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <20250627214607.GA193659-robh@kernel.org>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626212321.28114-4-ansuelsmth@gmail.com>

On Thu, Jun 26, 2025 at 11:23:02PM +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> new file mode 100644
> index 000000000000..fbb9219fadae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Gigabit Switch
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 is a 5-port Gigabit Switch.
> +
> +  It does expose the 5 Internal PHYs on the MDIO bus and each port
> +  can access the Switch register space by configurting the PHY page.
> +
> +$ref: dsa.yaml#/$defs/ethernet-ports
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855-switch
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet-switch {
> +        compatible = "airoha,an8855-switch";
> +
> +        ports {

ethernet-ports is preferred.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {

And ethernet-port@0


Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

