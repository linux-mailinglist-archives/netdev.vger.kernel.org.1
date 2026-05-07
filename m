Return-Path: <netdev+bounces-285361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ln3APSl/GmwSQAAu9opvQ
	(envelope-from <netdev+bounces-285361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:47:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4854EA775
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E935830055AC
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C77402BBD;
	Thu,  7 May 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="y6sHvENc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49D3FBEDF
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165234; cv=none; b=IVvEXUOFFmrqk9dhqpRCS9o+cbg8jt4DB+OS0SUTxvIVBXpMfkMIfwFVw4zDA1iCQYh7tCAA0g9S6dMZGsOC7s7T+yeMFsKtDHsx8wZjyAZYymKUckVWhG88JWGbU2V81cHEhV27lu8gqgZoNem2ATGVPeBZB8OBI/U3UxP9lRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165234; c=relaxed/simple;
	bh=/OysdnbnOtECLkkSa00qUIDUT8c+z8rBTm0QaKE643Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyTTxOGJ20zd+WLN86YdZJcs3YTJPBpmYKxZNa7SZqE0UJI+2/Ue5OriGW8tWznZ9NgVGXQz1bbd/0KyqJl6YDF6bkQO5u6Dr2bq3frDQwisPyKmxRbRqWn57G/4oxduNdrl7Os6M4xty7AFnRldViWczcVt0xR77EVidjTdbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=y6sHvENc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso9138085e9.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778165230; x=1778770030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZB38wJGIZd42iBI3srRP0pjjAxDTyyGTqCWJp8RgtQ=;
        b=y6sHvENcFjVQHrSBavIoyq7oFwxMGglGYH82YKxB3rYUBU2WXPRYsxMkRmjaL8UJtJ
         8qCHl9DPDYrsxc98WoBL2OVnRxquMXDR7DJkEJ9EsIq4AZGGHrWcAHRBS18gya1ZxKtR
         EnlmuxisPmWVI/FCv2UT17Z2tvp0mlc86/WG39g8c3YrEIGrOiRRn5f3rGEvIAe9NK4M
         G3PU4X1W2bs7CtqpYJU4OLJ9+/f8MTwSAHunB19JS2FigfTQbWc1FjXIgGDLFSsZnLYJ
         srSccQtsHw2YSHp5ap4GUnDf1aUWOpktSnhkWm07DoTgrs60aRygAE7qvb6LOWLgEOL6
         oFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165230; x=1778770030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZB38wJGIZd42iBI3srRP0pjjAxDTyyGTqCWJp8RgtQ=;
        b=QnKHjNaEyOhvyaM/s8mHP36RdeZcpMYweXD1Y6tQGZs19szCsZhsQoae1e0PsiBtvP
         ftXHSBwQcutiH3wRPWfVljSCeDAh+oTD3rClB+RyZlBBt2NaqJA+HuEgGIASS6meL2Ag
         vyOsiYj0eDnR2WRtcs7ApvjsFcVjlc9px35woN2YS2slWcj2NQpJP+MsJtwBG9u30cpG
         oD27K4j+/HTBMrkrNjG+60C3KeAYe/P4oHfPtSCfLajq0O8trUDFFiLD0+gf8rQSXx4s
         bsugbgd6Vf9R0t9bLH7JGV7yNSBWUJWLcArnX8m7vG9LFqspPGJECSwkRkhlos6Tjetc
         tYCA==
X-Forwarded-Encrypted: i=1; AFNElJ+V7DVUJGaXbSZia7nVnZNu/c/0/MpHRvq/7EZMjSiNQlJg+nzsrg7aLskumY6CFGPl3Fcx7tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymeNPD9DuVT75Km4icVYMyobsYdQjkx0IqZ1Fm2olJF7Q0mVlg
	jEIrrRx0OaI/A+FFU0s2kS8JWS8bSDJX2Pm3cFvVdxPq8Q+swo+Q7JBBz0ktu1PEFcM=
X-Gm-Gg: AeBDievXzPnn6jGWbSugeiNPL/VH1pwRfxgytLNVngFKiLGDuzoPBq04pJHTvGTHITx
	GL/XNrSJmjed0qD+Xb/BoOU9nv1fht9F8NOFy2A96/nvG2piIXr6TezCaV25XYeLbAqWv3CwG/6
	CWqeIrbUpI4Op38XLKs8Gcoy+DM8aIhzLCJwnVwXn/R4wILLnmwe0J2iFWPbLtCroK+0ikv0K/I
	7rSpaHGZcUE+I9bGWuoj7kVRzlvxyXGH/CEMAJodPktU05JYGPbSLqqKE4i8LyS+A9KAPp6sQYd
	pd5/+flbMvs2DFDiV8oK4I6WYKYaB/ZddWn5zS2ALxcSL//TJ1zy5+YxBF1SSZ/m+SIYG4CVaCj
	3RQGbde0w+P0HpUQ8lzBn/axQO7rQy2bdy1HLHqiRFVNGweiDL/3l57/r2Iq1qZQBcNiu1mZ8ao
	zGXCm7gS9ihexpdVybWOE6ZIf/ff766aCmxD09skvtXp8QJDdzPvZIZiEGOsmBVIiZAXILmQhoi
	uBwCNpD8KhyhvggLUmged78WWatkGXElJj2tHJcKK64V/TntUpWn5DhgSb7qfFp5s8WcnA2rkrH
	Imq0D4QyWe9G1wTv5Tc=
X-Received: by 2002:a05:600c:a317:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48e52bd4f32mr100824405e9.19.1778165230150;
        Thu, 07 May 2026 07:47:10 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a5486sm134813275e9.6.2026.05.07.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:47:09 -0700 (PDT)
Date: Thu, 7 May 2026 15:47:06 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
Message-ID: <afyl6gpHLlAnxir7@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-9-elder@riscstar.com>
 <20260504-fascinating-teal-tarsier-b116c8@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-fascinating-teal-tarsier-b116c8@quoll>
X-Rspamd-Queue-Id: 8F4854EA775
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285361-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_ALLOW(0.00)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.567];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspen.lan:mid,0.0.0.0:email]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 01:00:07PM +0200, Krzysztof Kozlowski wrote:
> On Fri, May 01, 2026 at 10:54:16AM -0500, Alex Elder wrote:
> > From: Daniel Thompson <daniel@riscstar.com>
> >
> > Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
> > bridges.
> >
> > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > Signed-off-by: Alex Elder <elder@riscstar.com>

Alex already replied to most of your comments but on this one
specifically...


> > ---
> >  .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 ++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > new file mode 100644
> > index 0000000000000..d95d22a3761da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > @@ -0,0 +1,111 @@
> > <snip>
> > +examples:
> > +  - |
> > +    pcie {
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +
> > +      tc956x_emac0: pci@0,0 {
> > +        compatible = "pci1179,0220";
> > +        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        device_type = "pci";
> > +        ranges;
> > +
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +
> > +        phy-mode = "10gbase-r";
> > +        phy-handle = <&tc956x_emac0_phy>;
> > +
> > +        mdio {
> > +          compatible = "snps,dwmac-mdio";
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          tc956x_emac0_phy: ethernet-phy@1c {
> > +            compatible = "ethernet-phy-id311c.1c12";
> > +            reg = <0x1c>;
> > +          };
> > +        };
> > +      };
>
> Keep only one example, unless you have different properties (not their
> values, but their presence),

At some point I simplified the example by stripping out excess
properties from each ethernet-phy. In the process it looks like I
removed too much and eliminated reason I thought it important to
include both PCI functions in the example!

Each ethernet-phy will typically describe a reset gpio but we expect
only eMAC0 to act as a gpio-controller. For that reason I wanted to
show that. You can see part of that that in the current example because
tc956x_emac1 is not a gpio-controller.

In other words tc956x_emac**1**_phy will, in the real world, include a
reset-gpios property that references tc956x_emac**0**. For example:

    reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>


So... is it better to strip it back the example to describe only a
single PCI function or should I add back the reset-gpios that I
accidentally removed?


Daniel.

