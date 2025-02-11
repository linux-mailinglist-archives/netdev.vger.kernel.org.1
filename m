Return-Path: <netdev+bounces-165090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92698A305F3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B489D164954
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874C1F03C7;
	Tue, 11 Feb 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKc2PE6U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D526BDA8;
	Tue, 11 Feb 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263081; cv=none; b=Y5pf9EqjjX/VKj+dWhN0lkPMscukU7dTawvyvJ/GMjRpkjKZ3P7R3T21XKHnu0vwEITmlbmANxxY/fNBxIZIejtFHA1zN3q2vebQ3hnQa7n+7sRzURShNBjCIAUiXYm8PSiWm2ssAw/l6pv/Fu/eWRLJ5YpX5SrdzBALsIZyOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263081; c=relaxed/simple;
	bh=acDJAoI2Hy9Ib3oKvNTqC5QM2P0qdH2TPw3xnelV7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1BY+VYUVRJRjTYndVjKIW4Zv1yzDCrxGDNupg10zNMee+slaWrOXOtNJVHjA7M/i34wEmUh8TEUwD0NHsnnOYJrITJb9Bxqct3PIo7Gp6aSJUAbGpqLPom3s+5HAJ9K0pDsDVzJJYX5t2/EJc6uwjpFxDj72oKfTOlHm+3a4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKc2PE6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA10C4CEDD;
	Tue, 11 Feb 2025 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739263081;
	bh=acDJAoI2Hy9Ib3oKvNTqC5QM2P0qdH2TPw3xnelV7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKc2PE6UVRp+bbtAjc45TWebgPOJ3XvV+R4FKs0hwT7YQvom7Gc2tdw4AlDDH/gCK
	 fEu9mhJNsNjcYEU4y7jH5SkbfWHqJpHzBzbj/t3Y2lzpn6aSIIZfrEdqjrm47e5O8j
	 UqfOooY02/rHae3bIhMBz5XW/Ui1srWUPKF9mGL69E3sUO5c/LQyZKt9kpIlrBuEIv
	 Lr2oI2qGEjajZTYdz/tsgr5RYcmZ/b5ZyK9xEDR5OTTtL7DrS2hdm1v0lfSxUwHHh2
	 Rh6o8o3qx3VGDiIoGocinaEQlfEbAW7Z3OEfIoMhKO75UkbUVSSUqEDpKvMypA1ibz
	 aXDVKjQIY67fA==
Date: Tue, 11 Feb 2025 09:37:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v3 11/16] dt-bindings: arm: airoha: Add the NPU
 node for EN7581 SoC
Message-ID: <20250211-judicious-polite-capuchin-ff8cdf@krzk-bin>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-11-dba60e755563@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250209-airoha-en7581-flowtable-offload-v3-11-dba60e755563@kernel.org>

On Sun, Feb 09, 2025 at 01:09:04PM +0100, Lorenzo Bianconi wrote:
> This patch adds the NPU document binding for EN7581 SoC.
> The Airoha Network Processor Unit (NPU) provides a configuration interface
> to implement wired and wireless hardware flow offloading programming Packet
> Processor Engine (PPE) flow table.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/arm/airoha,en7581-npu.yaml | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a5bcfa299e7cd54f51e70f7ded113f1efcd3e8b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml

arm is for top-level nodes, this has to go to proper directory or as
last-resort to the soc.

> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/airoha,en7581-npu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha Network Processor Unit for EN7581 SoC
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  The Airoha Network Processor Unit (NPU) provides a configuration interface
> +  to implement wired and wireless hardware flow offloading programming Packet
> +  Processor Engine (PPE) flow table.

Sounds like network device, so maybe net?

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - airoha,en7581-npu
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 15

You need to list the items.

> +
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to the node describing memory used to store NPU firmware binary.

s/Phandle to the node describing//

Best regards,
Krzysztof


