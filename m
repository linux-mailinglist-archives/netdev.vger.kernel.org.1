Return-Path: <netdev+bounces-202100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7AAAEC388
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A8C1BC5055
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38E3D544;
	Sat, 28 Jun 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxyBtsGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982910E4;
	Sat, 28 Jun 2025 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751070979; cv=none; b=qyb89VN2xmcFxU5E5rzWECL+vNtzc76r0VCMWOe8xCIour3jpEJzCi2V42gEvh2QePblfaGQSu3KB3Lf7st7Wesg2caNNohTDvpt8BSHIYgCre0/U0jHkjbV+Qh8e+3qNribEYDAsiJAFz5iFVo3IShEseiddd8lRnoTEAzRmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751070979; c=relaxed/simple;
	bh=UhXb7GonPtn0N2wqrLAjlkAH8FL6Uk163SDuufsqqdc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXP/0ImsDW3gVUDJVzkwlBsyne9P42U8Q6m3VRuGr34mbPyNky+vDZ3taTVTzxMWd43qXkCRDf12bqZv996lzlZQHDXr0mViwM9n0F2ITlp6cq1hiUiKGy/jHuMygQ/5VDlxkMj2Ap2jXFDmvyAobxRaekILv4Q44ew9qyDH/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxyBtsGK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45348bff79fso3888975e9.2;
        Fri, 27 Jun 2025 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751070975; x=1751675775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2IjCx//d1qx+mqfIPU3sajy9SJfXmPgvsGkk3PQ/Qvo=;
        b=IxyBtsGKgXWIGDrnQ10JIYDZ4EwelPQPXW4KODn+cpmV6nLEgdsZKDmYkJ74yVgOsb
         4MKfAf5ahfmJWiVSUne4S4CpGttLkGQMmlKx9GTXkCy+3VNDahnQC0bzg/NUjf1R1VwM
         SaYeG9tPlllWSwKszFevBReMzAR6LCZgzYzaJTr3eeHpoCW36eEL9UNXEzldjgz6op0u
         YzDsu0HfOpo0uiihOUWsm2CnANfsPU7nR05EeWpl6iiNL0sSfxKWKn9uyyaUAvCYtVcC
         JQyT0tfQUZndpHhlEPFVm4u3VkvCJOHFwl1C7Wqh5ea8+7ahz3BrNlroHCBx/zd1w2tw
         UflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751070975; x=1751675775;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IjCx//d1qx+mqfIPU3sajy9SJfXmPgvsGkk3PQ/Qvo=;
        b=diAnBnz5z7H3iMH9SYFDd3IIw2pU5cn0oQouL+8N7ctlINowvTw1btdz7XlND+sj5I
         WJOPCHvVKXtslZ+P9vL3C2ATiR+2hqjROlvKrnx2iiF8fi+z1yjyOm8njtnjg0VjbkJq
         koRv7Gas9PPIjx6pWAky4UnBjs3Pme08hIJKgDOzMLumrYNEPtmJgdTPCy5FZqfZ0V73
         q9vHN+nuWLpB7XnSqTaV4oTae0EbdaO4odPXiJ2P+oohw+eazY3af9bXG0r5kXyqRmNO
         zwHOCyl3I/+uwmWHB5l5/WOL4nUSDUK03WZ5Q6plwFvCln0uldQWXojBUoL7c4n3+FtZ
         PNxg==
X-Forwarded-Encrypted: i=1; AJvYcCVD7Up5F+GWNoG4/jroVdJv7OHa7zx27M3o2kcnVWpnPwEaJ8TfOtfx3m5g+8Q6bQwWVihFMDVhteuc@vger.kernel.org, AJvYcCVTZx3ifB6kpmAtTRUVmyJNJJVRI4b5aeZxz+dPYPgyycCD7/cNO6m7VKGwnJQ+FXgJkIc6y66H5ouV+ICT@vger.kernel.org, AJvYcCWCCa/n/0doUIwF0Ob+AdLChEXWRgi7X0mLecIM58VwcuJhFFklrj1J0wNMbYWY4XPLQ2M0QaBI@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxlUeXCSCdd4buWBLBz/lziLqw8elY/rdNthjTqLgYQATeUpC
	lZLL+AgK5j5xJ1YI38eIt69DeU+k6DMDPI5P8V2TDYwCNncePnj90AWV
X-Gm-Gg: ASbGnct3vbs8nj5goITq0zsQKGtZRwLS90gpXqxocox6DAK62tcTgWAhcNM28krtzGs
	7DYGU9dssow/nGgyNhKawl5zBtrVUldbLn7wb7acbnRSOfC+RBVM5z0wF51sVRQxmO44FTIZm4n
	kPvx/d1y43OCmtvxBoQf2ue19ZXpaAlBdHEYNHkPiba4bWh0is14Z1lbaciMyXd+dnSsllkfPko
	jxgQmVj86DPsbrCWkZG8mcOoOLnoQ9bxxDB5fczCR1Z/VHz/6OwXsVrYTOGq5X/D74btrviGKiZ
	+uVJZCX2UzwgVqYQETavoTRm0P+LayxSv5NvA+dj48YANMhbcnYvaHDUS6nQVzXyBh0WZTYzsLI
	JdUOjL0JjXbST6V6Vew==
X-Google-Smtp-Source: AGHT+IEHtgdm3EqO3yYOzPZBoBm9oQn2yfor9srRlvtz2pBRLHW+QMm335DExTwAQ8ukAdcvDpliTw==
X-Received: by 2002:a05:600c:1e0d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-4538edf0902mr66989185e9.0.1751070975337;
        Fri, 27 Jun 2025 17:36:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c57d7sm99310995e9.40.2025.06.27.17.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 17:36:14 -0700 (PDT)
Message-ID: <685f38fe.050a0220.90fe0.c75c@mx.google.com>
X-Google-Original-Message-ID: <aF84-zuyPkn07ui4@Ansuel-XPS.>
Date: Sat, 28 Jun 2025 02:36:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v15 05/12] dt-bindings: mfd: Document support
 for Airoha AN8855 Switch SoC
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-6-ansuelsmth@gmail.com>
 <20250627214821.GA195510-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627214821.GA195510-robh@kernel.org>

On Fri, Jun 27, 2025 at 04:48:21PM -0500, Rob Herring wrote:
> On Thu, Jun 26, 2025 at 11:23:04PM +0200, Christian Marangi wrote:
> > Document support for Airoha AN8855 Switch SoC. This SoC expose various
> > peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> > 
> > It does also support i2c and timers but those are not currently
> > supported/used.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
> >  1 file changed, 175 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > new file mode 100644
> > index 000000000000..a683db4f41d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > @@ -0,0 +1,175 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN8855 Switch SoC
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: >
> > +  Airoha AN8855 Switch is a SoC that expose various peripherals like an
> > +  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> > +
> > +  It does also support i2c and timers but those are not currently
> > +  supported/used.
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an8855
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios: true
> > +
> > +  efuse:
> > +    type: object
> > +    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
> > +    description: EFUSE exposed by the Airoha AN8855 SoC
> > +
> > +  ethernet-switch:
> > +    type: object
> > +    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
> > +    description: Switch exposed by the Airoha AN8855 SoC
> > +
> > +  mdio:
> > +    type: object
> > +    $ref: /schemas/net/airoha,an8855-mdio.yaml
> > +    description: MDIO exposed by the Airoha AN8855 SoC
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mdio
> > +  - ethernet-switch
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        soc@1 {
> > +            compatible = "airoha,an8855";
> > +            reg = <1>;
> > +
> > +            reset-gpios = <&pio 39 0>;
> > +
> > +            efuse {
> > +                compatible = "airoha,an8855-efuse";
> > +
> > +                #nvmem-cell-cells = <0>;
> > +
> > +                nvmem-layout {
> > +                    compatible = "fixed-layout";
> > +                    #address-cells = <1>;
> > +                    #size-cells = <1>;
> > +
> > +                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
> > +                       reg = <0xc 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
> > +                        reg = <0x10 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
> > +                        reg = <0x14 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
> > +                       reg = <0x18 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
> > +                        reg = <0x1c 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
> > +                        reg = <0x20 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
> > +                       reg = <0x24 0x4>;
> > +                    };
> > +
> > +                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
> > +                        reg = <0x28 0x4>;
> > +                    };
> > +                };
> > +            };
> > +
> > +            ethernet-switch {
> > +                compatible = "airoha,an8855-switch";
> > +
> > +                ports {
> 
> Same comment here.
> 
> Why do we need 2 examples of the same thing? Isn't this 1 complete 
> example here enough?
>

Do you prefer if I drop example from every other schema and keep only
this?

And with this change is it ok to keep the review tag?

-- 
	Ansuel

