Return-Path: <netdev+bounces-165091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D70A305FD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B49C1888408
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF91F03EE;
	Tue, 11 Feb 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVdIrvsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202851F03C7;
	Tue, 11 Feb 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263248; cv=none; b=U17RxelSXKTmpJjAYEDH0fuLjyf/HV6qqjleordR+PhKXWRraIQm0LXHrqWozLJU34ZCFiOuAeBXcI/9PYmTmRkIKhs3UB/qAQ5izWJvyV7T+q6Ys0zcspn+KOUyFGL/vcV0N9ThHlCl8dS8zbvN2xPwUcVaSqxPQ+UgMekBNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263248; c=relaxed/simple;
	bh=yfxUOCmD0cUqeG9HoTFs80RQBFgDMIs07GaFv6eezd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKg1osSm+HR9cR8T53E1cWJQBXsB4QsbpFHwfFdpzyTsiXOKimcY3NR+UlC78IbxCrmzHTSdv/Trf/v/XqFJQbGF/2Q2EvrC8S8XwQQEq5l6ljDBvIo/6JFsMjfMqQ0ZyTcKiUXVeU+cgenfNG6a3iT+UferjNpeqCvmsexkxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVdIrvsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D22C4CEDD;
	Tue, 11 Feb 2025 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739263247;
	bh=yfxUOCmD0cUqeG9HoTFs80RQBFgDMIs07GaFv6eezd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVdIrvsA3Ht1DgAfLA+b9wt7TVUMk00P//UZrubEEcFld6Uu3p36AS3GGw3PAn9d2
	 GxW2sE+52XrKmk0bkzeYTqAWAcJxcVLo8lVhMgErfYJsMFNn9aT2aZ04Y8ihOporMv
	 pdRCPmNUoOIpSjgsFUJTjVEVbpnXisDLwKjN5hP5hVWsXwhDNLAuCkc3PGEgwpoy9w
	 +e4g8LhB+VnpQ9iWHDwq93J+rKf63T1Ir6mMwTs2fq4J1hT9AxRpqaYdJfYw4Jejhi
	 OPM70gsFKgKLHOh+yAozEUPNV3g0QHdph2IyrxRfQMQudr0Y+6KGUNun4HU/ErFrxL
	 Ysn/NLU3MXudA==
Date: Tue, 11 Feb 2025 09:40:44 +0100
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
Subject: Re: [PATCH net-next v3 12/16] dt-bindings: net: airoha: Add
 airoha,npu phandle property
Message-ID: <20250211-chinchilla-of-luxurious-focus-950fc7@krzk-bin>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-12-dba60e755563@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250209-airoha-en7581-flowtable-offload-v3-12-dba60e755563@kernel.org>

On Sun, Feb 09, 2025 at 01:09:05PM +0100, Lorenzo Bianconi wrote:
> Introduce the airoha,npu property for the NPU node available on
> EN7581 SoC. The airoha Network Processor Unit (NPU) is used to
> offload network traffic forwarded between Packet Switch Engine
> (PSE) ports.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index c578637c5826db4bf470a4d01ac6f3133976ae1a..0fdd1126541774acacc783d98e4c089b2d2b85e2 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -63,6 +63,14 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  airoha,npu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the node used to configure the NPU module.
> +      The Airoha Network Processor Unit (NPU) provides a configuration
> +      interface to implement hardware flow offloading programming Packet
> +      Processor Engine (PPE) flow table.

I see Conor had here objections, but it looks fine to me. So unless
Conor naks it:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


