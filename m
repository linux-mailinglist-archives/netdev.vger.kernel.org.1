Return-Path: <netdev+bounces-231596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26294BFB1AD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE891A049A7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF63128D7;
	Wed, 22 Oct 2025 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gC+8vG2q"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4B28A72B;
	Wed, 22 Oct 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124518; cv=none; b=gHC+KHhFDK+pTmTwzTzc0M10pGu/FANvdjVcrLFd8Xa2wrvvezq/FjWO+UE0wEIrjFW2StjtpHJYqDP24MSpBmee//8/qSvihe3WPkVGcZ/VK9mZjugB2aX8QZe2VLOc7BhHzdLbxszQoxAkfejMANlfBP+Hd1AMAZb4HS3q/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124518; c=relaxed/simple;
	bh=2xq3R/jwURMT3riPJBPbFF6dNSZ4etKP0GyAxX70bV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X02ovAqVblNtFcDXHSXwOhYSRt7L2oO9f0Doxx47FsZ1J6SAYUIsAIyUdR/T9hjmS2glQ3JRR1Y/lSVhM2/5ER1OcFin7xBJoPrTHkg4PG+1i0uGXIxHNjAUMgTE2WXg9yQSCMajRXCLCMQFlQFyt1RFJqO1FcsJgvxVa5hWwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gC+8vG2q; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 24377A0771;
	Wed, 22 Oct 2025 11:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=IjnnSkeO7vyXJXiM/UlwPYh5yPokHe5N0lGveEU0HQk=; b=
	gC+8vG2qE9BkuL4gh/EFMYPhtvEf9aNatdC8D9hDQAgEFmv9vxXT1Bc4mLFigO1l
	dv0mB1nRrkbVB6rXpep/8QefXofBk63mZ2U7v9gyMig6TXA5hl2l89o7WUVQaJD+
	gQXrq/lXHVsGMhQHKLcvPhlhllZiPw5zOFIrvtiRxPiUs52fGLKihkQp6CUScQkH
	gRh0LwH2Mhg30ZHELML0IlH/S0Vi9gJXZdUUsMB2DqtSZGDhJF21rkdFKDDZNd2/
	j1pTa2QGKd6W94huNXE/ZHDnbXCIey8MAj1w7mE9d/b/KfNa0Do1Va03KDFeJ4Zy
	rGQFPRdYzWuUcG+0W71mNcU3vhf9p28aI6xL7Znsb9IJt+V7E8yb/mtBeIREHqw+
	mnqIdcyLSJaT/vNi8CkdLhxHBLTGgSsgR7oZ07xGctcO2qPpQf/PowrB+9ke+ssA
	zRsLyb/PrJ5SkQOwt8cQWysXlXXaPfxl5dMMkqiM76k/uQIsBoMVd+bZm2wLoDFU
	AvzAVN+cOfjnmqd9sJid8ACtOWR/5pBqi+xs8Kju7oMDkaIbQjmzxkYTBHVUNiY2
	/Y4vCOu/DkGA4wuJB07IzBlCXNI8lospJ+MrfLJMMaM9sCzR1Ugznc8boOWLOItU
	WCFMqTjGCGzPq80O5/3nNetQQU9wUwhusDIirczGs+4=
Date: Wed, 22 Oct 2025 11:15:14 +0200
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
Message-ID: <aPigoh4E3_g2LzoE@debianbuilder>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761124514;VERSION=8000;MC=63647446;ID=130266;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Actually, please partly ignore my previous letter. I managed to do it
without a new DT property, and this seems to be a more elegant solution
after all.

If you wish to take a look at the next patch, you can find it here:
https://lore.kernel.org/netdev/cover.1761124022.git.buday.csaba@prolan.hu/

Thanks for the feedback!

Csaba


