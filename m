Return-Path: <netdev+bounces-231545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93BBFA487
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC6C58553A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C52F0C78;
	Wed, 22 Oct 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="OLyGCzgv"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C92F0C79;
	Wed, 22 Oct 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115437; cv=none; b=lJMUN8phDH4LCCzyjGBTHhjCgG4c57hIeG/13vREjK6uYDmhepJ2A7oi8X12dyHpAJyTxGx+TK95Ox1a1DH90BFlbCSM679aFbYJG9OBhuQLqdHQVtPnd/0itGFvbEe8iskjgJ2sI3p6DbhzaGIqlsxwnqs+O7/63RRXJg98Kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115437; c=relaxed/simple;
	bh=7gpt6SAr9Ej9Lm/h7cLWDA1SQksm761w+fQa5zKtb64=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrWPeT7FAnZtgcU8otPfPL10etj//zHYL9Kk7MTtP0NlGgxe22rMiR+eDCesmAbGXl8qf4cyX/0hG/h42aKb08eeCrdIzfEr3eP5LiXRN3e0NOhvGyxOGIzCuQdZr4aLM154Si2qjC2p/zdvNEn420oBm0KGdeHzv+6EP0jXMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=OLyGCzgv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 98FF0A0576;
	Wed, 22 Oct 2025 08:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=XmDt+PyCxZZw/QrCXM3gKsTS/1FC5wq3krTMYdCAzZc=; b=
	OLyGCzgv4kxscWT5PWTpgS4jDhOS1nIiGCDQzhwFYirz0J/8FEf2Fd+4oXm9h1Sk
	v/8uH89K74kQENqNJnahcXjxDeJZSNPskuFcLFCx+VR6LBvcwZk3z8MJVftM0hQ9
	/mmhOUTWhmqeadTRBUtIE34DSLm9Rwl5VjucaH9t0B01fVZL0MosAAi+f2zfOVvu
	qZ0dTm2RDuNQ35WKQXABr7pixxCwi3RO0nVEHmTK+dMMtcBmyYltcsX7RoQpwkWY
	O3evWoKQ+62/ixUEW+27/Z1fCJ8brw31zsGJwfGAd2qDBBVyaYHOuRfxceT9LAwW
	9zUPpdoNBL7rpUgm1uYuR6MT1o6Tl7HxNDwXNqoh1oofv/pJhDt/Mqt60hV44qni
	EfPniZr0hySVMmQew2oDRsueULLMNwW9ZBEpZBocwTla1bHNp998CKVUS5yVhE4w
	eQDkc9NAAStBFjvfta3N6LOafYVx6ZXg3ZyupQ+ZLA0AMc0n1zv2h73PqqS1wld1
	Yybb0TerCdnp4Uoc+oTqAo15DoNntWWAaCRtpGT2BfUMatvGg1Ve5MaA29q3dlf5
	Sn7Mdal2cyU/CwY/mBbFnZQqMTkuVgcGbhFv5vV8eUkKxRx20nVt8mQOJH08U7n4
	dMW/ARAsbaGDUWhc9ioIB73Ydsg058n3aJVpItDLqN4=
Date: Wed, 22 Oct 2025 08:43:47 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
	<f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: net: mdio: add
 phy-id-read-needs-reset property
Message-ID: <aPh9IzFNZx8FD1hR@debianbuilder>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
 <20251015134503.107925-3-buday.csaba@prolan.hu>
 <20251021201023.GA741540-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021201023.GA741540-robh@kernel.org>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761115427;VERSION=8000;MC=3977854970;ID=128679;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647D62

On Tue, Oct 21, 2025 at 03:10:23PM -0500, Rob Herring wrote:
> On Wed, Oct 15, 2025 at 03:45:02PM +0200, Buday Csaba wrote:
> > Some Ethernet PHYs require a hard reset before accessing their MDIO
> > registers. When the ID is not provided by a compatible string,
> > reading the PHY ID may fail on such devices.
> > 
> > This patch introduces a new device tree property called
> > `phy-id-read-needs-reset`, which can be used to hard reset the
> > PHY before attempting to read its ID via MDIO.
> > 
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 2ec2d9fda..b570f8038 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -215,6 +215,14 @@ properties:
> >        Delay after the reset was deasserted in microseconds. If
> >        this property is missing the delay will be skipped.
> >  
> > +  phy-id-read-needs-reset:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Some PHYs require a hard reset before accessing MDIO registers.
> > +      This workaround allows auto-detection of the PHY ID in such cases.
> > +      When the PHY ID is provided with the 'compatible' string, setting
> > +      this property has no effect.
> 
> If the phy is listed in DT, then it should have a compatible. Therefore, 
> you don't need this property.
> 
> Rob
> 

Yes, it has a compatible, but most of the time it is just
"ethernet-phy-ieee802.e-c22" (or c45), and the specific ID is not provided.

Doing a quick search: of all the DTs only 126 specify a chip ID.
There are 198 matches for "ethernet-phy-ieee802.3-c22" only.

The current description reads: 
"
      - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
        description:
          If the PHY reports an incorrect ID (or none at all) then [...]
"

This description tells me, that we are only encouraged to hardcode the 
chip ID in the DT, when it is read incorrectly.

The PHY we are having trouble with reports its ID perfectly, once properly
initialized: clock established and hard reset asserted after that.

I only wish to implement this condition. Andrew had a concern, that if we
unconditionally assert the reset, that may lead breaking compatibility with
some existing systems, so my best idea was to come up with a DT property
that can be used to flag this.

I also wish to emphasize: there are 43 DTs out there still using the
deprecated "phy-reset-gpios" property of the fec driver, probably for the
same reason: there is no replacement for it. Because that property does
reset the PHY before the ID read, but it has all kind of other problems.
The worst is that reset gpio handle is tossed after the initialization,
see fec_reset_phy().

If we ever want to truly deprecate that, there must be some alternative
logic to implement the same funcionality.

Csaba


