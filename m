Return-Path: <netdev+bounces-139918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D89B49B5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5376281B9D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E197F9;
	Tue, 29 Oct 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Dhtz41"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD9621;
	Tue, 29 Oct 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205074; cv=none; b=osRv0YenbzrkmYYVERy7TTJbJkkDTwXRBpflp0SN+KLxiX2LZJgllcc8JYQ6wHr3zKpqRsLc8LPEFiKKqGTi4f/qufxLo9lLEnrTGnJlbizmN6szQ8ToMd3PwHLBCazrxMlWDba44uPjmuoRH0oLInG3k6yxehKn6qbJWXYiUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205074; c=relaxed/simple;
	bh=TYPIu0SfR+TN4j062E5hryA9cXK0q/3ENU8V6QOjjVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuwFqM9DOhEFGICpuBrjVIRIckbOEmUMTotpmAReIgu/pHFf3isFN7OmELOYp4e9/eqeuesK6F5xUJg44J+p8f98+zo6YhX76kNwGr879oIFDJArl51EUYsjBtNDiHZPkflORB43ptAmghyjVkl4dpXJ9y8SD1b2KUjJCL9mQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8Dhtz41; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5045987dso430846f8f.1;
        Tue, 29 Oct 2024 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730205071; x=1730809871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ7aKdVifpnHdKeUSiwbE32Nz4syIUyUTJuxzmlVQkM=;
        b=K8Dhtz41Am2MrURjHvRYI7lNcxMk3/iQp2f0loxvcS0uGzO97NKDhOS07Ubdqysz1L
         46sItM7UJVNYA2BZortNNrGVfiPVrcKMeoQeQ6E0XWzc4L16HQzfcGmn33xsZDdeGriV
         3YBMwC6yu+sF0zH8UkFs5wqIJt0DUnLxgGHGeok2gx25I9xzFkyZBmzGAA5p6vyf19eE
         20MUJvuUkt07xqCC8rBEJ7nw1JhmAqI9m8bjff2lxKdk3aHwQ4QMJ417FkxU48XWeEUP
         3hyrSi1EuYgIO8aXBv6lpTBezEd/04oggDIfenVoNokkm0KmZ9TbQwMZGrWXVG9d1Ls8
         PASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205071; x=1730809871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ7aKdVifpnHdKeUSiwbE32Nz4syIUyUTJuxzmlVQkM=;
        b=k+3HTZ1OVrMwWAUpNFAwP/cEOHmyfJblEc4vivAKYhS/Ui14oVDkE8dGQB2ihrMq2k
         XGj/F41uIlv3cTUcoFihEG5eUJQTiv6tXBT5XHU5DwlKreMejC51h4FxVRAd7++dq+Qk
         pq2mzzWg15sqKe4ZMxvd9beZq58yUo7OPcALUTzZS2rijFBjIHLd1paydmFfDZuEQHnf
         ixI6Hu/YcLL3X+p36qRJpYVlZNYkLaSe4+oH+Z2I8l6F6y/GX7T+JyW0FZt4hdrS8rVn
         UEKUVcEERWwFP58NdFMsaxA6Wg2T1QhVUr8Z2lyAyZKhHqAswP6zPS0aAtlZnF39QorC
         c6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0KXc705xJuiUUcuRAQ0xcQ6mlR1tTWxx03QQfJGEQEa+nVo/0kucqRI2zJos0EIAKXvRO9YQqkV+w@vger.kernel.org, AJvYcCUhkKYct+tOazFadxZvYdYZKk9Mk1fM8bVASGV8bmM61DVJwCmr0EgWN0VvRTfp6i98RvEgHLDN@vger.kernel.org, AJvYcCX664/cqDnpBogC2Fj1uul4EOI4JXQWePNDydDz/9brxEhZK/DzPHQF8EhmJ5UtLTZE9Ixc9nrxFKy2hjvB@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNCtqkDs49ogEHkBNFkfqs/H7mhI5vb265xYOujXTm5Teg5nj
	p6gpSbqzQrIvNplZ/UTe8sJffDlY92zWo4FRLV8K1pRua1Fsgit0
X-Google-Smtp-Source: AGHT+IF7v8Sw+x2Tqh2kJZeOySvkxMSlwOCzePbp5aDIKfhNrRB639HqLFpTiwIN88Ct1hVS15JJnQ==
X-Received: by 2002:a05:6000:401f:b0:37d:4517:acfb with SMTP id ffacd0b85a97d-380610eed1amr4037086f8f.2.1730205070555;
        Tue, 29 Oct 2024 05:31:10 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c3absm12446497f8f.21.2024.10.29.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:31:09 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:31:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH net-next v2 2/5] dt-bindings: net: dsa: ksz: add
 mdio-parent-bus property for internal MDIO
Message-ID: <20241029123107.ssvggsn2b5w3ehoy@skbuf>
References: <20241029110732.1977064-1-o.rempel@pengutronix.de>
 <20241029110732.1977064-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029110732.1977064-3-o.rempel@pengutronix.de>

On Tue, Oct 29, 2024 at 12:07:29PM +0100, Oleksij Rempel wrote:
> Introduce `mdio-parent-bus` property in the ksz DSA bindings to
> reference the parent MDIO bus when the internal MDIO bus is attached to
> it, bypassing the main management interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index a4e463819d4d7..121a4bbd147be 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -84,6 +84,15 @@ properties:
>    mdio:
>      $ref: /schemas/net/mdio.yaml#
>      unevaluatedProperties: false
> +    properties:
> +      mdio-parent-bus:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          Phandle pointing to the MDIO bus controller connected to the
> +          secondary MDIO interface. This property should be used when
> +          the internal MDIO bus is accessed via a secondary MDIO
> +          interface rather than the primary management interface.
> +
>      patternProperties:
>        "^ethernet-phy@[0-9a-f]$":
>          type: object
> -- 
> 2.39.5
> 

I'm not saying whether this is good or bad, I'm just worried about
mixing quantities having different measurement units into the same
address space.

Just like in the case of an mdio-mux, there is no address space isolation
between the parent bus and the child bus. AKA you can't have this,
because there would be clashes:

	host_bus: mdio@abcd {
		ethernet-phy@2 {
			reg = <2>;
		};
	};

	child_bus: mdio@efgh {
		mdio-parent-bus = <&host_bus>;

		ethernet-phy@2 {
			reg = <2>;
		};
	};

But there is a big difference. With an mdio-mux, you could statically
detect address space clashes by inspecting the PHY addresses on the 2
buses. But with the lan937x child MDIO bus, in this design, you can't,
because the "reg" values don't represent MDIO addresses, but switch port
numbers (this is kind of important, but I don't see it mentioned in the
dt-binding). These are translated by lan937x_create_phy_addr_map() using
the CASCADE_ID/VPHY_ADD pin strapping information read over SPI.
I.e. with the same device tree, you may or may not have address space
clashes depending on pin strapping. No way to tell.

Have you considered putting the switch's internal PHYs directly under
the host MDIO bus node, with their 'real' MDIO bus computed statically
by the DT writer based on the pin straps? Yes, I'm aware that this means
different pin straps mean different device trees.

Under certain circumstances I could understand this dt-binding design
with an mdio-parent-bus, like for example if the MDIO addresses at which
the internal PHYs respond would be configurable over SPI, from the switch
registers. But I'm not led to believe that here, this is the case.

