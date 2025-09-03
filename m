Return-Path: <netdev+bounces-219462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927BB41626
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BD51A811F4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E742D97AC;
	Wed,  3 Sep 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzpC8NcT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380F2D6E64;
	Wed,  3 Sep 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883994; cv=none; b=WhEwrhAKKcymv77ii84sV3dojFWVDAmyVY88bnXvAqhzQLoUii5KrcN9YUGIqSxHLfZGZdwbUYnVhr8ilPvXW6EPPO6tBa/hc1PcNNi/lqHe5qjog8/ehLTsSgQhBK+z5NHPtvUxPad5GTT33A+aT0w89J2zNkP1+K+Mi3tJpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883994; c=relaxed/simple;
	bh=IvjNC842MxY+UMDgGJhsWF+myFJMSct3VEgfMUbeQZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng3G2yn1Qt4pjjO+2shp06CLw2t0UE+tWWfYYisBqgwE7A21lCzq64VpjUhS8SjujLX+iUVEpEFce2gRYxk4bcpasMpCt8zTR8n8U0FCDCUrDkBXWICOrAM+mTOYPJ8bjUsvxSnMQRpYzyfgdYQqLaWQba7Br0BXJgtMxjp6YtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzpC8NcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57A0C4CEF0;
	Wed,  3 Sep 2025 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756883993;
	bh=IvjNC842MxY+UMDgGJhsWF+myFJMSct3VEgfMUbeQZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzpC8NcTdV93L+kP5jVNgQ4UCYWOQzmQciejKr4kGXbl54WgEgZ1pSXr7Kaif45E4
	 i9RJZ69FyRGUaeXJ3cHFRwKsrvKePFVsPZYfVWjMkUsSh8S2Ky7z9dDQEqqrSf79aG
	 dzwBAKT3FBl0Q0wuAWlbE3V0YVDyysYmk6dN6c445HEYIbiBuiXCT1ZXjvlBoZvZHz
	 ZsXqyG0eOGvm6C5lByvbTLEBSNLj1wVODOZHWpxg98dD+QcCZha95ghAp1oCJNGFV5
	 PeFB9UT61Pv/iviFsqZVWJfVwGb3nL/j+mDNyqAeme5qmrKhzXEdr7xPo/qJaUI3HZ
	 HwRkZUcx6Lzkw==
Date: Wed, 3 Sep 2025 09:19:50 +0200
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
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
Message-ID: <20250903-peculiar-hot-monkey-4e7c36@kuoka>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902090746.3221225-3-danishanwar@ti.com>

On Tue, Sep 02, 2025 at 02:37:40PM +0530, MD Danish Anwar wrote:
> Extend the Texas Instruments K3 R5F remoteproc device tree bindings to
> include a 'rpmsg-eth' subnode.
> 
> This extension allows the RPMsg Ethernet to be defined as a subnode of
> K3 R5F remoteproc nodes, enabling the configuration of shared memory-based
> Ethernet communication between the host and remote processors.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index a492f74a8608..4dbd708ec8ee 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -210,6 +210,12 @@ patternProperties:
>            should be defined as per the generic bindings in,
>            Documentation/devicetree/bindings/sram/sram.yaml
>  
> +      rpmsg-eth:
> +        $ref: /schemas/net/ti,rpmsg-eth.yaml

No, not a separate device. Please read slides from my DT for beginners
talk from OSSE25. This is EXACTLY the case I covered there - what not to
do.

Best regards,
Krzysztof


