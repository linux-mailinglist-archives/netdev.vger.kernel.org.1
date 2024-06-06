Return-Path: <netdev+bounces-101191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71DE8FDB5F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34267B20BA9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3050F2563;
	Thu,  6 Jun 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNpBr32h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB253BE;
	Thu,  6 Jun 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633290; cv=none; b=LLAMYtFxxDHvjBqid9sT6yWQ13sjn/Zt5QUaAQOcHJ8ZMh3qZ4inhwTMFPJtzsl0eqHNMz+I/HuCHG+IGxGXbR9NDcF/jZOwiyQ0BsNP3hu47FJjDFh84gyvmV9YTvZ7vouvMrIw9ogHhEHg/V9j7qc4TV8hLbyRxrNYI9rBdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633290; c=relaxed/simple;
	bh=0eqwJwhSDudfIsQGh0ug1pR2nn0XzPNrcqHG9ZVooZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH7wYVwM8UMPCc6ceauhBJ/SQd1q8xkn972aHWhQILAuMo0ONfFJ6A8cGch9UxvvPufsoPkmIT7j/zZqz6Wwg84nK1+8kZ6z8pB8Ot2jc86nj97LwX/j0pc6zIrswRUOGMsd81V7zQSecYV/nGIt3TEhA232sVkjce5XyXdld9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNpBr32h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EADC2BD11;
	Thu,  6 Jun 2024 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717633289;
	bh=0eqwJwhSDudfIsQGh0ug1pR2nn0XzPNrcqHG9ZVooZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNpBr32h9yuMuy3yQWmdzA992nM0YscVDDU+fePYeKMrz2XPrvz4qpbbfaNBylmgu
	 UAry4ljCEaibcrHuCEk8Skkox4YS3ZiSOietntDckKfJl09TEridoFIwLY2PM5/qvd
	 gG4S4EHeSk/MBknaSFI35L2z1nIX52XM8yEV5KovqZokvsnewF1cdQYxGNds73KqLO
	 18eDogdGvH82Z25Toi2xnVkES985Zln1jJwUprn4jTfsjNqUpSw5O8/isPmLYcRu+Y
	 P3v1mCugSqAMB2EA43vZH25iEdtBNi5+qlMcW7qqvFuD5kh+YbaHKLKWtvW0bjq73v
	 eiW3dDWgagiGA==
Date: Wed, 5 Jun 2024 18:21:26 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christophe ROULLIER <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
Message-ID: <20240606002126.GA3496044-robh@kernel.org>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-2-christophe.roullier@foss.st.com>
 <067d41e5-89cf-45eb-8cfa-b6c3cd434f76@linaro.org>
 <70b66190-2c55-4228-8c31-f58a05829d8b@foss.st.com>
 <c6ff5778-f928-4a65-8a32-a3582d9d8f94@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6ff5778-f928-4a65-8a32-a3582d9d8f94@linaro.org>

On Wed, Jun 05, 2024 at 01:46:33PM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2024 11:55, Christophe ROULLIER wrote:
> > 
> > On 6/5/24 10:14, Krzysztof Kozlowski wrote:
> >> On 04/06/2024 16:34, Christophe Roullier wrote:
> >>> New STM32 SOC have 2 GMACs instances.
> >>> GMAC IP version is SNPS 4.20.
> >>>
> >>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> >>> ---
> >>>   .../devicetree/bindings/net/stm32-dwmac.yaml  | 41 +++++++++++++++----
> >>>   1 file changed, 34 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> >>> index 7ccf75676b6d5..ecbed9a7aaf6d 100644
> >>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> >>> @@ -22,18 +22,17 @@ select:
> >>>           enum:
> >>>             - st,stm32-dwmac
> >>>             - st,stm32mp1-dwmac
> >>> +          - st,stm32mp13-dwmac
> >>>     required:
> >>>       - compatible
> >>>   
> >>> -allOf:
> >>> -  - $ref: snps,dwmac.yaml#
> >>> -
> >>>   properties:
> >>>     compatible:
> >>>       oneOf:
> >>>         - items:
> >>>             - enum:
> >>>                 - st,stm32mp1-dwmac
> >>> +              - st,stm32mp13-dwmac
> >>>             - const: snps,dwmac-4.20a
> >>>         - items:
> >>>             - enum:
> >>> @@ -75,12 +74,15 @@ properties:
> >>>     st,syscon:
> >>>       $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>       items:
> >>> -      - items:
> >>> +      - minItems: 2
> >>> +        items:
> >>>             - description: phandle to the syscon node which encompases the glue register
> >>>             - description: offset of the control register
> >>> +          - description: field to set mask in register
> >>>       description:
> >>>         Should be phandle/offset pair. The phandle to the syscon node which
> >>> -      encompases the glue register, and the offset of the control register
> >>> +      encompases the glue register, the offset of the control register and
> >>> +      the mask to set bitfield in control register
> >>>   
> >>>     st,ext-phyclk:
> >>>       description:
> >>> @@ -112,12 +114,37 @@ required:
> >>>   
> >>>   unevaluatedProperties: false
> >>>   
> >>> +allOf:
> >>> +  - $ref: snps,dwmac.yaml#
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - st,stm32mp1-dwmac
> >>> +              - st,stm32-dwmac
> >>> +    then:
> >>> +      properties:
> >>> +        st,syscon:
> >>> +          items:
> >>> +            maxItems: 2
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - st,stm32mp13-dwmac
> >>> +    then:
> >>> +      properties:
> >>> +        st,syscon:
> >>> +          items:
> >>> +            minItems: 3
> >> I don't think this works. You now constrain the first dimension which
> >> had only one item before.
> >>
> >> Make your example complete and test it.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Hi Krzysztof,
> > 
> > "Official" bindings for MP15: st,syscon = <&syscfg 0x4>;
> > "Official" bindings for MP13: st,syscon = <&syscfg 0x4 0xff0000>; or 
> > st,syscon = <&syscfg 0x4 0xff000000>;
> > 
> > If I execute make dt_binding_check 
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/stm32-dwmac.yaml with:
> > 
> >     For MP15: st,syscon = <&syscfg>; 
> > =>bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: st,syscon:0: 
> > [4294967295] is too short
> > 
> >     For MP15: st,syscon = <&syscfg 0x4 0xff0000>; 
> > =>devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: 
> > st,syscon:0: [4294967295, 4, 16711680] is too long
> > 
> >     For MP13: st,syscon = <&syscfg 0x4>; => 
> > devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
> > st,syscon:0: [4294967295, 4] is too short
> > 
> >     For MP13: st,syscon = <&syscfg 0x4 0xff0000 0xff>; => 
> > devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
> > st,syscon:0: [4294967295, 4, 16711680, 255] is too long
> > 
> > So it is seems good :-)
> 
> Code is still incorrect, although will work because of how schema parses
> matrix. But even by looking it is not symmetrical between allOf:if:then
> and properties:. Make it symmetric - apply the number of items on the
> second dimension.

It looks correct to me. But it could also be like this:

st,syscon:
  items:
    - minItems: 3

Either way works. Is that what you are asking for? I'm just happy when 
folks can write a working schema.

Rob

