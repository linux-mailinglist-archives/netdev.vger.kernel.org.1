Return-Path: <netdev+bounces-61126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD18229F7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594921C23019
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F9182AF;
	Wed,  3 Jan 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mLPvaeDJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7B182A9;
	Wed,  3 Jan 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E39060003;
	Wed,  3 Jan 2024 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704273094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0d2TPKJzfDkr9YkXLiJF5yuJVu7qTBvfkcRucs3iN8=;
	b=mLPvaeDJhmpcd4+AQdE8hESe2HAJTBF+SLjydD+IEzfZNIl7pseOiJDieFtN/5sfE16P+Z
	tf7jLMdlz1IcDyMwzhxgRdltCTHAkj36HY0Zwu83CFIgTf9SXOi0x/iqCB82lj+knRY6zS
	KtWOmHhHIPLajSqx1jhIXoz8HiSwL5ixUloCCJVgSrcFN/1fq81DHOhpWNJtfodkZAW44i
	AQQaEHmybha0NE0lEWSLNPkaUz7zcAcZXOTecUIQko8+RVkDKvyjrd6MzWCuASUl6u1IgO
	QUYutMEEpJ0hgETlQmnwb4/4iRmT323grPCnJZAdGnxzKYu+l52YGp2NlLvYJQ==
Date: Wed, 3 Jan 2024 10:11:54 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>, 
    Sylvain Girard <sylvain.girard@se.com>, 
    Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
    Pascal EBERHARD <pascal.eberhard@se.com>, 
    Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
In-Reply-To: <CACRpkdZjOBpD6HoobgMBA27dS+uz5pqb8otL+fGtMvsywYBTPA@mail.gmail.com>
Message-ID: <d3d73e26-10a9-bd2b-ff44-cbdc72e1f6ee@bootlin.com>
References: <20240102162718.268271-1-romain.gantois@bootlin.com> <20240102162718.268271-2-romain.gantois@bootlin.com> <CACRpkdZjOBpD6HoobgMBA27dS+uz5pqb8otL+fGtMvsywYBTPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Linus,

On Tue, 2 Jan 2024, Linus Walleij wrote:
...
> > +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> > +{
> > +       __be16 proto = eth_header_parse_protocol(skb);
> 
> I made a new function for this in my patch
> https://lore.kernel.org/netdev/20231222-new-gemini-ethernet-regression-v4-2-a36e71b0f32b@linaro.org/
> 
> I was careful to add if (!pskb_may_pull(skb, ETH_HLEN)) because Eric
> was very specific about this, I suppose you could get fragment frames that
> are smaller than an ethernet header.

Okay nice, then I'll rewrite this series to use the new function once your 
changes make it in.

> Should we add an if (!pskb_may_pull(skb, ETH_HLEN)) to
> eth_header_parse_protocol()?
That does sound logical to me but I couldn't tell you what the impact on current 
callers would be. The net maintainers will probably have a better idea of this.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

