Return-Path: <netdev+bounces-138491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DE9ADDD8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C409DB23F9E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1ED19E990;
	Thu, 24 Oct 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNBU8c/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6397176227;
	Thu, 24 Oct 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755410; cv=none; b=Tf6YZipOH53VdUyLL/8CvGZJCyGBydCZr+8oqFXjSGuTbxJBVzOUzYkYViAXusQCkmtyI43+JPYg1hQpTSYH7dLw9OZYP1VxpUJifszo7aSqGvnhTnGssf27XlwE7DC435p9aNinlK1Nq7jauGyEcHcsqqHFEBvND1I/9mbFIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755410; c=relaxed/simple;
	bh=QY6Un/nev6q0K4IVTPVcnizClruEWQyqCjq/Y1/z2B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUk7eNbQ9uvrXiT16RlR+W5Iz40NXyL4PwPbFxtoyIFz37kWiKN/N47Yf6mSvVQZ5uIQUywqpZNNJqlmYx1eJQcAHukU/gFEAxHCx0w3pjSb5cGg+BZrABiZOUxarDdiZ3hCFGr/kTWsV6oz5vVlh2TDcKcf781uT0vMFY13M/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNBU8c/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB2DC4CECC;
	Thu, 24 Oct 2024 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729755410;
	bh=QY6Un/nev6q0K4IVTPVcnizClruEWQyqCjq/Y1/z2B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNBU8c/WiyeL9WVczfmjAYJCL9CTE6jQVDPAs3/nHx0zD6vcK/RwDw1i31n9VrYxa
	 ufUmqBC9TO61KirSfykPfJ0yxhLQzuv6gpy70yBpWmaoexZO/7c/N7/YSgQ4pm9b/b
	 txeylAYt2kRYEZuXhIyVOYhC+cGoAQXMjtMHjUraoAetc8NpoWK1hLRB/PzWx2GWQL
	 DJ1CkWyb2UJc6lErdUUBCfl7RBBfAku3/iYOZ01bgRXyWZKFh6RLhDuWClWzx47tXt
	 e5KVHr3vtfoGOZH5Rm82iIkMJzGREHFPe7vu1QKL+sKZPEIxrpB8aIiEG2pIS1gQO/
	 U9hVOUdIhIxqg==
Date: Thu, 24 Oct 2024 09:36:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	horatiu.vultur@microchip.com, jensemil.schulzostergaard@microchip.com, 
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com, 
	ast@fiberby.net, maxime.chevallier@bootlin.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 13/15] dt-bindings: net: add compatible
 strings for lan969x targets
Message-ID: <t63jnh4ncssaajq6ef4pnhsmn7jjp7cstw6q5gay5hxzfjjvrh@xuepiohildao>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
 <20241024-sparx5-lan969x-switch-driver-2-v2-13-a0b5fae88a0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-13-a0b5fae88a0f@microchip.com>

On Thu, Oct 24, 2024 at 12:01:32AM +0200, Daniel Machon wrote:
> Add compatible strings for the twelve different lan969x targets that we
> support. Either a sparx5-switch or lan9691-switch compatible string
> provided on their own, or any lan969x-switch compatible string with a
> fallback to lan9691-switch.
> 
> Also, add myself as a maintainer.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  .../bindings/net/microchip,sparx5-switch.yaml        | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> index fcafef8d5a33..dedfad526666 100644
> --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> @@ -9,6 +9,7 @@ title: Microchip Sparx5 Ethernet switch controller
>  maintainers:
>    - Steen Hegelund <steen.hegelund@microchip.com>
>    - Lars Povlsen <lars.povlsen@microchip.com>
> +  - Daniel Machon <daniel.machon@microchip.com>
>  
>  description: |
>    The SparX-5 Enterprise Ethernet switch family provides a rich set of
> @@ -34,7 +35,24 @@ properties:
>      pattern: "^switch@[0-9a-f]+$"
>  
>    compatible:
> -    const: microchip,sparx5-switch
> +    oneOf:
> +      - enum:
> +          - microchip,lan9691-switch
> +          - microchip,sparx5-switch
> +      - items:
> +          - enum:
> +              - microchip,lan969c-switch
> +              - microchip,lan969b-switch
> +              - microchip,lan969a-switch
> +              - microchip,lan9699-switch
> +              - microchip,lan9698-switch
> +              - microchip,lan9697-switch
> +              - microchip,lan9696-switch
> +              - microchip,lan9695-switch
> +              - microchip,lan9694-switch
> +              - microchip,lan9693-switch
> +              - microchip,lan9692-switch

Usual order is increasing, not descreasing. It's fine to keep different
style than usual, but then just keep it in mind and enforce on any
future changes (because I will not remember the exception here and I
will always ask for increasing alphanumerical order).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


