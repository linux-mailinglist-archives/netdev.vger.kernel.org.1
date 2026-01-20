Return-Path: <netdev+bounces-251464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDuWJ3aDcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-251464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:55:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0336092C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 044C98272A9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409D40B6C6;
	Tue, 20 Jan 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VneoogXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0542188C
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909203; cv=none; b=CCshUVVlUb9+b0Gs+Sbdie1yfkarNUOyzpj9svbOUo/5FfoVvIiwQ9ocjsv3vo4L/ADLISAyXVzvTdK33ZPEyo8H7pfWWYS6MOUy3eYUU/Eo6OYvO/qyfZ5FuaPSpZNn+jIwYvwHQXPLsT7r56S+9O0g66V63xQIdjoCj9tiK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909203; c=relaxed/simple;
	bh=jrQhr8hRcob+nmP7FXhfmRMEqhWFIhwmQ2N3yM90I3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiMD489zW2H0q5l5zKccg+yXcxGjT67FfsEM8bPzabUCWBy7lUGrSPUYzg5DffnnzCo2KLEOMkRDr8QXM8wJcqlQfPTx2vRCSEx5SToQJjQL8OxSs0MixzjlGz8sVi6lZ63WXE4GOCxo1lijFd6XyOSr6/lmnMi7iT8otmjzAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VneoogXh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b1981ca515so5659904eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909201; x=1769514001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QeACF3mv4Ishn0NV7RQhnzhSMHx1UMVLhYGwPqoV7AE=;
        b=VneoogXhouU1bgDmoCFpGVIO0NQ12Tu1rmi6aayCtGwxDdscrGNYffXXIiaWX7M8cx
         hyo9Bvn8vBwg5d8PiMjm1wCFlCyBdGQx+BILG0SMBFVaaDtojpo5/fnZ9Gu3JJs0DMu2
         uzwCjm+BGX1W7gYJJTKH386Z63vVMwDJE3nyP+bchcH0TpcMTrs9GAYyrneuA4MidQTE
         5fr+gxPTCCMBJzwXW8MX16Rzn2+F6ttFg84FeutdUKyAREoUpPcMGRM0OeemWPju7oMN
         pO+ICJe9pWKPTAdKvzI152THat+6X1fn0E9ktvSeLQgPT1prEcJlJost3F1qEMvenSqG
         K0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909201; x=1769514001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeACF3mv4Ishn0NV7RQhnzhSMHx1UMVLhYGwPqoV7AE=;
        b=sarH6cks0OJftz0fjjDKABP5tXPQlnUNPIOUL+RGOPbJXL696tBV+NhnIKJQ1WfP/R
         rELzm2Napwc5VmULkFAtjLdJCfO5PtsFmnZaZboRc+gO0BSDQmPPyGrVZxePIEt0Bdr3
         VDit5ydtzPZJqmCUS2fbG7MfObz+FE1uJaEZjBiE11piKHSL/TmW5meO5WXxhHwi8V0C
         DMftrN7m6Co3GjCDG0btPZxW/8LYaq+17FzoPGvBOWrY+AhH8rw8eO3teX8pUUup0rVr
         hmA5bNaNwweG5dUdOWN2pb/80gZ/u292d4E9KDnJpfx/Hp49UukOXJb3ifPn6Wstu+Ot
         +IAg==
X-Gm-Message-State: AOJu0YzJtR8KOnisGRU+uUOuSo8Omc1AvICORg35gj34K5tr+50yUqay
	uomX8/uQ2bHtg2bUi53DUdAa/cRJV/ZQIeDLpvXsfDHg1BnmvW5roetl
X-Gm-Gg: AZuq6aLUF+7gmmLVQV+bqOCKR7Il5TehYzadFNGZWVIjPb8r94OanaeNBze2vmfyyyJ
	Why5xqWQh7HLzZYGxuQJO5yCz7dxQ4XjymVz8/r4mgeNrrYF2/JEkeNxykX+GrNFNBd0PzVHQsC
	J6RRE/4/n/ihJOWQGoXiC3AboPWVTVOs5WLp5W7Zv+Vqa9WZyLUaLlf/mbMQnBARkD2P7NTnFMk
	86EhhDLBxTEuQGnpSl2Hc9kzczY1FMpoWhDiB4xKI0tH3/fzbppDRklNbvjMorJ08y5+lrbAwWk
	Ncfa18zVbaprp43OP4QxMp3QE7n2uQY+nrPBsEPHC/vkoVAuFwHN4vKD/W0ZEfIoN4IzyPXZXVU
	R0X9Z5nIKNO5XSpAfIft+8FCmOfYTGCAFaCcFrExk+bw+tefNveTwMt/FkyIfLMh970Uelsuh8c
	E5JG4HuvT0eQ==
X-Received: by 2002:a05:7300:2315:b0:2ae:5967:db5d with SMTP id 5a478bee46e88-2b6fd746cacmr1048269eec.13.1768909200775;
        Tue, 20 Jan 2026 03:40:00 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6beeb4b9csm17558900eec.30.2026.01.20.03.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:40:00 -0800 (PST)
Date: Tue, 20 Jan 2026 19:39:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yao Zi <me@ziyao.cc>, Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: Add support for Spacemit
 K3 dwmac
Message-ID: <aW9ou-lsQQ5dVzqW@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-2-inochiama@gmail.com>
 <aW9fL7r0AM0flALJ@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9fL7r0AM0flALJ@pie>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[38];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[ziyao.cc,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Queue-Id: EE0336092C
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 10:55:43AM +0000, Yao Zi wrote:
> On Tue, Jan 20, 2026 at 12:36:06PM +0800, Inochi Amaoto wrote:
> > The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
> > MAC (version 5.40a) with some extra clock.
> > 
> > Add necessary compatible string for this device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
> >  .../bindings/net/spacemit,k3-dwmac.yaml       | 107 ++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> 
> ...
> 
> > diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> > new file mode 100644
> > index 000000000000..58dd98f79e8a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> 
> ...
> 
> > +  clocks:
> > +    minItems: 3
> > +    items:
> > +      - description: GMAC main clock
> > +      - description: PTP clock
> > +      - description: TX clock
> > +      - description: PHY clock
> 
> Why does the MAC require "phy" clock? Shouldn't this be handled in PHY
> driver instead, or I get its meaning wrong?
> 

IIRC, the "phy" clock is used to pass the phy from the mac core, I will
double check if it is possible to connect to the phy directly.

> Also, I don't see "phy" clock is acquired anywhere in the driver. Is it
> really necessary for the MAC?
> 

This is a mistake, I remove this by accident, if it is necessary, I
will add this in the next version.

Regards,
Inochi

