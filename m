Return-Path: <netdev+bounces-190547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0FCAB77C2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048754A7BB1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A028CF7B;
	Wed, 14 May 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FysNDajb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A0170A0B;
	Wed, 14 May 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257493; cv=none; b=Oszm1J2t5WYctsLAH2mA927syvIdULftlZ9zg1SQj57w27s2qO+xIT2rF45U+BHZIO4dX7zbE8CeKSLRulOic1015pznukY1NRVhZLy0Oh8ColrCOZWUqe1rywfaq+foWE3Cax51kFi6dh3mkvKDxU7jojGFtDF4XVRQ/LYOOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257493; c=relaxed/simple;
	bh=ZIb9Fz+xqmgrAxD9mfna0sZwGimSQAAHyT/UwWtLC/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhauUqLlHXxTVSAxHZDLN/wcu02KWeIa6td7tF1bklJsfRWyT4zELxqZXnKoDKB0HF259weQEXw7gIpT71KVGkhaLBxw9MDd62+1MkDo1WXu79YJxJ6X3djvzAYVr6jhFHeyHky4s4DFrAr9bse1p2vBbWSv+1CVEWOnVingn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FysNDajb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9CBC4CEEF;
	Wed, 14 May 2025 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747257492;
	bh=ZIb9Fz+xqmgrAxD9mfna0sZwGimSQAAHyT/UwWtLC/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FysNDajbvFLErLLS+ewABWamu9qsKftwQ/avnuariznR2rGW7L75r8/aTCRP3Y9Ep
	 UmF//7v1v1Jaeggu5nWZjUaNDP605R5np/adPcjWhAYxvcGtkbPQg9JKyq5npQ1h0N
	 fuFGoVT+L774iCPRmmaXhJTHMvaNGRi07aoegw38eAvR71Gl5OVHEwMKnYwZu7VLRz
	 E1AQkBGQAme98CoiJtarJ4cZvUMW42VuIJb1npm0o/qegBKXprmaw+sL6pL8n8ylV0
	 9c7VJZ2zAXHO7m7jgKlnkzZPdhA7ZMfoqtiDO5erTnnoAp1zses1IeoSQLX1+0YZcP
	 l6/tMa1mvWmaw==
Date: Wed, 14 May 2025 16:18:10 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 03/14] dt-bindings: net: dsa: mediatek,mt7530: add
 internal mdio bus
Message-ID: <20250514211810.GA3051536-robh@kernel.org>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-4-linux@fw-web.de>

On Sun, May 11, 2025 at 04:19:19PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Mt7988 buildin switch has own mdio bus where ge-phys are connected.
> Add related property for this.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index bb22c36749fc..5f1363278f43 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -156,6 +156,9 @@ properties:
>      maxItems: 1
>  
>  patternProperties:
> +  "^mdio(-bus)?$":

Really need 2 names?

> +    $ref: /schemas/net/mdio.yaml#

       unevaluatedProperties: false

> +
>    "^(ethernet-)?ports$":
>      type: object
>      additionalProperties: true
> -- 
> 2.43.0
> 

