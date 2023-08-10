Return-Path: <netdev+bounces-26452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB070777DC7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181061C2159E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6720F85;
	Thu, 10 Aug 2023 16:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D21E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37CFC433C7;
	Thu, 10 Aug 2023 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691683848;
	bh=hU3zEJqh3v/qDDuwBKbxUUN5LenjFbRiKXk6hZBPbkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ov/ISR/VUh/E/BVRWOz0QgqVAECA8Syehms+PpjS07xKA5ZI4OqwY/vYO29RAgZ7h
	 dMAU7YmZWhRsa/3euTGYup3zU1fvMTUcrjz77+Ur1N8y6GtGlntBPqLM5TChgU7ThY
	 OxDPsQYgxk/tvNAaCHRqt4tczeafnCEjkZXnDC/PNP7NBEiBKf1FiN+Tsq96u/2FR6
	 K1wTqHVUhhngmhhalIBcvQF2+Sd1ALTB11SbYC44LuKc2ZVtZGQh0X1RBSPsOw5Ego
	 ZfzW4Kt95N/6WpNykRZNlwS/G3BUBmnlJBM5bpSa9nrSIKhPWqmhf7RT3vwva3nWfZ
	 Oshf8AHsJxJ9A==
Date: Thu, 10 Aug 2023 23:59:06 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <ZNUJSvJi+9QsWhAf@xhacker>
References: <20230807164151.1130-1-jszhang@kernel.org>
 <20230807164151.1130-10-jszhang@kernel.org>
 <20230808-clapper-corncob-0af7afa65752@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808-clapper-corncob-0af7afa65752@spud>

On Tue, Aug 08, 2023 at 08:39:58AM +0100, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 12:41:50AM +0800, Jisheng Zhang wrote:
> > The IP supports per channel interrupt, add support for this usage case.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 5d81042f5634..5a63302ad200 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -109,6 +109,7 @@ properties:
> >        - description: The interrupt that occurs when Rx exits the LPI state
> >        - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> >        - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> > +      - description: All of the rx/tx per-channel interrupts
> >  
> >    interrupt-names:
> >      minItems: 1
> > @@ -118,6 +119,38 @@ properties:
> >        - const: eth_lpi
> >        - const: sfty_ce
> >        - const: sfty_ue
> > +      - const: rx0
> > +      - const: rx1
> > +      - const: rx2
> > +      - const: rx3
> > +      - const: rx4
> > +      - const: rx5
> > +      - const: rx6
> > +      - const: rx7
> > +      - const: rx8
> > +      - const: rx9
> > +      - const: rx10
> > +      - const: rx11
> > +      - const: rx12
> > +      - const: rx13
> > +      - const: rx14
> > +      - const: rx15
> > +      - const: tx0
> > +      - const: tx1
> > +      - const: tx2
> > +      - const: tx3
> > +      - const: tx4
> > +      - const: tx5
> > +      - const: tx6
> > +      - const: tx7
> > +      - const: tx8
> > +      - const: tx9
> > +      - const: tx10
> > +      - const: tx11
> > +      - const: tx12
> > +      - const: tx13
> > +      - const: tx14
> > +      - const: tx15
> 
> I don't think Rob's comment about having added 2 interrupts but 32
> interrupt names has been resolved.

I misunderstood Rob's comment. Now I'm not sure whether dt-binding
can support regex or something or not, or let ask for advice in the
following way: how could I write the dt-binding in this case? I didn't
find similar examples so far. I'm not sure listing possible
description and const properties for all channel interrupts is suitable.

> Did you actually test putting this many interrupts into a node?
> AFAICT, any more than 6 will cause complaints.

I tried 12rx and 12tx interrupts in a node, didn't see dtc warning.
so I guess the complaints are from dtb check? I will try to reproduce
them.

> 
> Thanks,
> Conor.



