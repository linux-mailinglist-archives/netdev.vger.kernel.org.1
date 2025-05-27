Return-Path: <netdev+bounces-193743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B088AC5AB5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE92E3A9F29
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45060288C34;
	Tue, 27 May 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/DQK3SC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CE1E1C1A;
	Tue, 27 May 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374155; cv=none; b=mIMTxLXxXUEVIM6rBBLTL2MkJc52VU71jCuBrsaKC5ldoPLdIl5+0GOIYd0JrWIKb0E6ZG2h8/QsNCD216on79oKx8wyOtPKnI6YPkVHhm0FU422DdsS3Xw9XO293GOxI/vk1bvZAa+S74JKlYz+nq0MGMe8L3X4TD8CnL/csb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374155; c=relaxed/simple;
	bh=KARBt7V80dw1XzTrK5gyR4MyC6WRf9x90HmxHAgt/tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjLU0S/0SXrT8rKNFL61narvpwC2fqJEGmq5fIgmnS2utG4kys4c8vWocNkpCk5Nyry4cSb9YlvEFycsSpqAofshvlM4gJa5Bob5e/7bfpulDemlc83VvmRsPROwFPuiIAEkmOvN0ZeOIroTosG0Op9nxMH/r73inTqO7YSEQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/DQK3SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EBBC4CEE9;
	Tue, 27 May 2025 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374153;
	bh=KARBt7V80dw1XzTrK5gyR4MyC6WRf9x90HmxHAgt/tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/DQK3SCftLvg27nD3SbPiFtBNHZ3FRWUj3S4hc4ChHoL8l80dysUcxZXMMzeThma
	 fouJ7OoEgi5bEDbKKEbwUYc8fe+B6j5hpHlp7QjxPh5Mf8HANBgd704ZtOQr4vWvNp
	 GZnmxS7JTjNrTdY5kUsXKA9DPErJ6SB1N5tZH7dAoue2z62bz3Mj8yYKfq2soojL+M
	 L7qWran14kF9Pci5zZUQPUYQOGP+06FjLgqYcL08lKg+jy33RZEsWKZ5wlFoNN7OIJ
	 XCHzS/XpunLpHZs33rpUMfGRyfEqmw6EK0cYgJY6AZE8X3NLal9R0OaVFEEg0SM5WU
	 LPde+tHeqWsLQ==
Date: Tue, 27 May 2025 14:29:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: netdev@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: net: dsa: mediatek,mt7530: add
 internal mdio bus
Message-ID: <174837415111.1091232.14774319774329934407.robh@kernel.org>
References: <20250516180147.10416-1-linux@fw-web.de>
 <20250516180147.10416-5-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516180147.10416-5-linux@fw-web.de>


On Fri, 16 May 2025 20:01:34 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Mt7988 buildin switch has own mdio bus where ge-phys are connected.
> Add related property for this.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - change from patternproperty to property
> - add unevaluatedProperties and mediatek,pio subproperty
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


