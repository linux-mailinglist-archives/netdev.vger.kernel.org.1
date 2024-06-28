Return-Path: <netdev+bounces-107734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72591C321
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1820A283CEF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E441C8FBC;
	Fri, 28 Jun 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz5p1tt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7E1C8FA5;
	Fri, 28 Jun 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590707; cv=none; b=fm2lgOhrh8fyEI37SVBilCq7ZO+R13q/xmOl8V7IPlLDqaKG3rURvglieqJhodip1kp65GCYj6edqk+I8jcysLnDSk6PslXoqNX2kOwsaPkZOFCFX/mxN7gnr3rxVojBIBTOyMxuuBM8bW/pIPy9dE0MPy4bk/6ovHuHlPih33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590707; c=relaxed/simple;
	bh=sMXJ4hkiFWt7Cv3QmxHGQ2Pskam/5kqC+bIYDv0pZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsCLz1mAeps1JTfoT+Q9NDXtmZjS7l45cXxoQePVXWaNYjc4nPuQAFLoXLqOgqsRZS8J3+Mlqj5bcT4u1DrK1f0vcZRB3Ii4ZjzKtF76jbTJqpUbwLV6Og7L3sHxSaB6ZEetQJ6ouUZSVcPent+2mjNUVgYL4jaq40AkmFkYuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz5p1tt7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so834413e87.2;
        Fri, 28 Jun 2024 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719590704; x=1720195504; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kLzM9/030cAER8BTD3NcNMTjqO5oML/8R1yU28wqQaU=;
        b=iz5p1tt7MOPmjJwGcZw3RbfoZmEmymgLWjLi74OnWhh0s8uW5gxLDY8kvt5YYGVQNJ
         BtbxC+ikDWGFGXfDh7Ferayf5lU9FurlUp9w+MEocttMoKsyBOtfABCfFQW1KaBn2ICs
         3M4GYTNVubMX9k0OwLDKqEQTEaUji70X6G4NHjDE1GY04qjj/L4Z0VqjhrTCMesjAkSD
         REPRYS/bPYxIB6/mU6Xh8VUZOhLlEs/O2j2Gq/TKTEc+vnkcHuVRMvqsYDKb5xQXrtSe
         m/XnAqJ6Omzxagqs/n6z3Z3tEQIRjOhb5STnOt9oJ5AxAsoxox3pL1KCxXwLzCc9v/l7
         MOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719590704; x=1720195504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLzM9/030cAER8BTD3NcNMTjqO5oML/8R1yU28wqQaU=;
        b=KrWsg9Gy+ZGiW02qMBkb6jomrpN6d3BpelxD/uqLLGKa8jehsAY4M94xsHFVrY5H+L
         P1uOoo91YgYdcfxoJPBuPEmTLpsmr3bhfGJpzITpw1I279pzwj579VZy/KYgzrFPJ/oD
         RSbAFCucMYHjtE9oH60aUMT5LiZ3ALDU8gCaVCpfEoytOg+1iDG3wBO1JTWpkF4xio2J
         jhKrANmls+QOgbhHlYBnLKUsvJi6D9IfjKhju1b+53RioNs+3rGw9ih2NFvts8SRAxKS
         JbPWhQky9m7Y4+wuY/qsaGYBW8aKwHel/YBSUr5EN8JxuILdHWZ4kQ/57UFDc6BUyTzS
         0A3w==
X-Forwarded-Encrypted: i=1; AJvYcCUP/go7uQBLXr0z2KDX5tIv6n0A2fkktRDFfFpXlhahDsSlcc7Ij/08PbrtUg7vAkcGRfg8Ii9Uo6fdgPb89IqEIkdjs7e6w3GwV8xZJS3DshKLajQxGocKcWuamc45CK+HCIcGTbFiLcf88TRhqh4tMMVN0Cz54SGiyE+EeX21LQ==
X-Gm-Message-State: AOJu0Yzvq7lPdGqTc4a1us0xnRJO6ITy336BvZjwTcaSAVjN6LMpUQ10
	iGavqYn3j/Z9KgOVSjRXSxbT8WW1X+Yjdiwt5cfqLgNxnIdxuilEJQm3gDog
X-Google-Smtp-Source: AGHT+IF4B20Xs61JY2WDdTljN5tsITuP6RpEAeKzP4VISYuoULX3SqB9Os9Bd+hpX4ErLC3PU0Crfg==
X-Received: by 2002:a05:6512:304b:b0:52c:ec24:e3ea with SMTP id 2adb3069b0e04-52cec24e4f4mr10337474e87.10.1719590703368;
        Fri, 28 Jun 2024 09:05:03 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b2e4sm309663e87.272.2024.06.28.09.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:05:02 -0700 (PDT)
Date: Fri, 28 Jun 2024 19:05:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] dt-bindings: net: Define properties at top-level
Message-ID: <v55chwj4xl7t6qfgmahtc2yi2c3zc3fqavuj2px4njv4oz3kwk@zbfo47rlaq4z>
References: <20240625215442.190557-2-robh@kernel.org>
 <gr7rgy7cptnpj2rkeufhgqkve4ytqddpts6gdekeszoq7znwf2@ivyjpaiyxruk>
 <CAL_JsqLYHbr=Wqg-S0t_hK3uDATe9KKob9chFGFnoTcyt2ttyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLYHbr=Wqg-S0t_hK3uDATe9KKob9chFGFnoTcyt2ttyg@mail.gmail.com>

On Thu, Jun 27, 2024 at 01:03:01PM -0600, Rob Herring wrote:
> On Wed, Jun 26, 2024 at 9:05 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Rob
> >
> > On Tue, Jun 25, 2024 at 03:54:41PM -0600, Rob Herring (Arm) wrote:
> > > Convention is DT schemas should define all properties at the top-level
> > > and not inside of if/then schemas. That minimizes the if/then schemas
> > > and is more future proof.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/net/mediatek,net.yaml |  28 +--
> >
> > >  .../devicetree/bindings/net/snps,dwmac.yaml   | 167 +++++++++---------
> >
> > For Synopsys DW MACs you can just move the PBL-properties constraints to
> > the top-level schema part with no compatible-based conditional
> > validation left. It's because the DMA PBL settings are available on all the
> > DW MAC IP-cores (DW MAC, DW GMAC, DW QoS Eth, DW XGMAC, DW XLGMAC).
> > Moreover the STMMAC driver responsible for the DW MAC device handling
> > parses the pbl* properties for all IP-cores irrespective from the
> > device compatible string.
> 
> That's definitely better.

> Will still need the TSO flag part though,
> really, who cares if someone wants to set that on h/w without TSO...

Besides the TSO property description is wrong in describing the
semantics of the DT-property and MAC HW-capability. The description
says that the property enables the TSO feature "otherwise it will be
managed by MAC HW capability register." So it means that the
"snps,tso" property was supposed to be utilized for force-enabling the
TSO feature irrelevant of the MAC HW-capability register data. Instead
the STMMAC driver enables the TSO engine only if both "snps,tso"
DT-property is specified and the TSO-feature has been detected via the
MAC HW capability. 

> 
> >
> > Alternatively you can just merge in the attached patch, which BTW you
> > have already reviewed sometime ago.
> 
> Can you send that to the list since it changed from the last version.

Ok. Please find the submitted patch here:
https://lore.kernel.org/netdev/20240628154515.8783-1-fancer.lancer@gmail.com

-Serge(y)

> 
> Rob

