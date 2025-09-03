Return-Path: <netdev+bounces-219460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CEB41618
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5770484453
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323114A4CC;
	Wed,  3 Sep 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onavuu25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2972D8399;
	Wed,  3 Sep 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883907; cv=none; b=gFhCM2noGOJwp7josZ3Ts/V2rNlUacU/44+5ifs6DfodShAT2P24cKzWAnTiY/LNMrTJNUwAkQanJK81RvASQ7fp7CpjZvAoodO2w3L8CXNeE1+BNZMaz5kR4ACo5u2lHnZYwDePhUic0CZM++0y6XwhwTQSkBJsX86QgOfPnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883907; c=relaxed/simple;
	bh=YuoISYCyGQJP6CZlxMjw80wdeLcQLhpCqTKRpVB9WGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV+4DmuDcqRjOjqdvp+XLDIgQzUMAOIm/SZPcD4fjj3oW+jTA76bHRAHKaoEkbaiw0ThMbGV7ozsU+eNkN8KOCOdKHz/gg/EAfyW9FoL09eeOVgrVaCC1WWS6B7DX1Uf8r3qQ0RuBAcZuYmbOq3mlUeCpSXTu8H9DutD6BhIZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onavuu25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4367C4CEF0;
	Wed,  3 Sep 2025 07:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883907;
	bh=YuoISYCyGQJP6CZlxMjw80wdeLcQLhpCqTKRpVB9WGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Onavuu25vmdsBWj3aAVpuIn0haCHhtOp0Ucgqa+e3guMFePD70UzmO3VarK12SaQx
	 MhI8xYFXTDMvSw4aiGbmzcnCCGlM9YVQzLP3E+9xR7cG7fcaLZu3bS+yFmr3J0OMJX
	 hiVOhRGgBtePUldLKUlszstDLfYIU9bSiOdquNB1Utdt/qAH9bYwgg1Oo7fRgbVoJx
	 /KpbvsKsvueX80BtwbSw7WVP9zpbr2MkceGhy/vQOm8QdHYdDUOBMKz+XIJzioMkK5
	 jefMMNyqHoSz4ynxNBO8dckT2rKDJZd/GU3SXvJ0Ip/eqdkWIp0TID/ivpjp4MgIGJ
	 q0lR6Myo4T04A==
Date: Wed, 3 Sep 2025 09:18:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Xin Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>, 
	Michael Ellerman <mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
	Suman Anna <s-anna@ti.com>, Tero Kristo <kristo@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com, 
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: ti,rpmsg-eth: Add DT
 binding for RPMSG ETH
Message-ID: <20250903-dark-horse-of-storm-cf68ea@kuoka>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902090746.3221225-2-danishanwar@ti.com>

On Tue, Sep 02, 2025 at 02:37:39PM +0530, MD Danish Anwar wrote:
> Add device tree binding documentation for Texas Instruments RPMsg Ethernet
> channels. This binding describes the shared memory communication interface
> between host processor and a remote processor for Ethernet packet exchange.
> 
> The binding defines the required 'memory-region' property that references
> the dedicated shared memory area used for exchanging Ethernet packets
> between processors.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,rpmsg-eth.yaml | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
> new file mode 100644
> index 000000000000..1c86d5c020b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,rpmsg-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments RPMsg channel nodes for Ethernet communication
> +
> +description: |
> +  RPMsg Ethernet subnode represents the communication interface between host
> +  processor and a remote processor.
> +
> +maintainers:
> +  - MD Danish Anwar <danishanwar@ti.com>
> +
> +properties:
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the shared memory region used for communication between the
> +      host processor and the remote processor.
> +      This shared memory region is used to exchange Ethernet packets.
> +
> +required:
> +  - memory-region
> +
> +additionalProperties: false

This cannot be really tested and is pointless binding... Really, one
property does not make it a device node.


> +
> +examples:
> +  - |
> +    main_r5fss0_core0 {
> +        mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> +        memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +                        <&main_r5fss0_core0_memory_region>;

All this is irrelevant, drop.

> +        rpmsg-eth {
> +            memory-region = <&main_r5fss0_core0_memory_region_shm>;
> +        };
> +    };
> -- 
> 2.34.1
> 

