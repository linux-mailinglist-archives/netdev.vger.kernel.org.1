Return-Path: <netdev+bounces-247440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72445CFAB84
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF02833E43A5
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC333985D;
	Tue,  6 Jan 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6+H7MW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D527FD74;
	Tue,  6 Jan 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726088; cv=none; b=VWNrZTzjNWbRrIg6MNfxQJsm7gYnspYsJALw26DOZlyGLEZhWXhIOAgmh8qjxY0+aFIPUGoi0ay373vi4MbiL37+rAk05tO1PcKjeh1ZbnxcG/BZWUsEGBkWElUc1dmFWmbME8WGm8REhktn12yD8FA7TAsTjyDlozsGjVtE008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726088; c=relaxed/simple;
	bh=mnBxn/Rz2DfcOBFabd4WdQGJtGWiMmCwwVsL6cusnNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GruRtKNnfamM5S5tgzcfi20Ffqy2YPqmnJSz+7W7GAhqY4yNlJYPUgmNwU4Q6r4cwbs+9avUzRQ6Mg+Gsr8NvUJIA9JPxo8Du7zUrf/mz4G9TbjP45lBdR0Q7d9tq+DqN2ksnCaGoVzZTIMMKjQkLc7wb+hlMkvS6guO8i4t4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6+H7MW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64BEC116C6;
	Tue,  6 Jan 2026 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726087;
	bh=mnBxn/Rz2DfcOBFabd4WdQGJtGWiMmCwwVsL6cusnNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6+H7MW4loyEJscRG5Psbu3gmX/Y5UgpqbgG7ATxtlOOdKw3U2y1JPyCyAxtKvEMN
	 UTG2O49hKxgvG+Avk6OJbu4iI2ziQpA8kyUMqIGJA9Wk0YfGcy0EEASCYgVjortKCp
	 F2cfdPwkllaLtN/xkYVdTKTrukryLKs3bIQFutNFv4vrlitPlIBCwPn3rGzd2v8g6f
	 UDcErOxPY0jUl5Ovlb2ke4XAZrxC40h8K3zCXVE+FVOjnz+SqdI3J5xzLi3cbdtxXH
	 WTB12R7tX6mmA0Y1mP9piXA4nfT2EfIfmXd040rjb5QASLy87QZFvcrX1UaVPwXceg
	 dg4w7k9xliGOg==
Date: Tue, 6 Jan 2026 13:01:26 -0600
From: Rob Herring <robh@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mamta Shukla <mamta.shukla@leica-geosystems.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	bsp-development.geo@leica-geosystems.com,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: net: altr,socfpga-stmmac: deprecate
 'stmmaceth-ocp'
Message-ID: <20260106190126.GA2537154-robh@kernel.org>
References: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
 <20260105-remove_ocp-v2-3-4fa2bda09521@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-remove_ocp-v2-3-4fa2bda09521@kernel.org>

On Mon, Jan 05, 2026 at 06:08:22AM -0600, Dinh Nguyen wrote:
> Make the reset name 'stmmaceth-ocp' as deprecated and to use 'ahb' going
> forward.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index fc445ad5a1f1..4ba06a955fe2 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> @@ -13,8 +13,6 @@ description:
>    This binding describes the Altera SOCFPGA SoC implementation of the
>    Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
>    families of chips.
> -  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> -  # does not validate against net/snps,dwmac.yaml.
>  
>  select:
>    properties:
> @@ -84,6 +82,15 @@ properties:
>        - sgmii
>        - 1000base-x
>  
> +  resets:
> +    minItems: 1

That's already the min in the referenced schema.

> +
> +  reset-names:
> +    deprecated: true
> +    items:
> +      - const: stmmaceth-ocp

This says stmmaceth-ocp is the 1st entry, but it is the 2nd.

You can't really fix this to validate a DT using stmmaceth-ocp. I would 
just drop this. So that leaves this with just dropping the TODO.

Rob

