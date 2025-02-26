Return-Path: <netdev+bounces-169884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F1A463E4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0008C188C4B6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9EE2222A5;
	Wed, 26 Feb 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="YLHiFxEY"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0482222BE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581954; cv=none; b=H4SJRHVd86H8ZcVsFmaONFvu7qpIHrkny1mjZuli8L+17MG8GpZgz5CqK9UDEHXUf5cLZYkGIM+4XZPOALa6e2cNz5bRZS2k9ZffFbuibGt2G8DW6pNYEX0nwZ5doKW30f6l1dnq3faeMaj39xpxD2arsw7gmTj74KG4o+PXWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581954; c=relaxed/simple;
	bh=5x1DDc9NUBR+BdN8UiBGQj4+McQqIlB8v1wgzKpz2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofmdZybSK0cuc6pH93b2Z+/BeZ9fHG0AC7f7n7D6QBxRvE4Ruv6c8ESn5BaLJ1zayQhwlCOqOXuu/QktskpHbdKWYp1vyy0ZwQmSK3vHwVzcQFNW/ryyIJLYNFz5nc4u5ThGJKe+N6MeEGZb7xyRtT5Gc2gGh8WVMO19svsswdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=YLHiFxEY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1958C240101
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740581949; bh=5x1DDc9NUBR+BdN8UiBGQj4+McQqIlB8v1wgzKpz2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=YLHiFxEYZbag4dM3K2ONaPGuIBKNDCvZTFQ+W8ub9DaBN2Rbd0y5jC3rUBsbZywpD
	 qFAqlk7OAWo1FJTxY+z6x368dyBHQoxm1EYVtLuJnx/XDXtphv36WMVLAXw89VHb2Q
	 zSiV/GPfe7dl8DucQZVtHm2n94VvSf7YJD8qH2MzkcZ+0w8Cpd3IvjMzq7NpD/caTy
	 mrUcLlVpmTa4k2EtIDBCohnYoiBo5gFQDSnGv2kStkgRscnSY/EJrVnv+tMl47hQiF
	 yBTG4OgZ9yZkgXeQmJZ6gIK2C/jgMiy6kD1/3u7uvLKxKW2nrYXzaZx2Oivy+2qtH4
	 OSP6ERw06afvg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z2yKk4KNTz9rxK;
	Wed, 26 Feb 2025 15:59:06 +0100 (CET)
Date: Wed, 26 Feb 2025 14:59:06 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to
 YAML
Message-ID: <Z78sOtFfNC8i2amq@probook>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-1-0ba97fd1ef92@posteo.net>
 <20250221163651.GA4130188-robh@kernel.org>
 <Z7zdawaVsQbBML95@probook>
 <Z72lqrhs50NtoK8m@probook>
 <20250226133114.GA1771231-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226133114.GA1771231-robh@kernel.org>

On Wed, Feb 26, 2025 at 07:31:14AM -0600, Rob Herring wrote:
> On Tue, Feb 25, 2025 at 11:12:42AM +0000, J. Neuschäfer wrote:
> > On Mon, Feb 24, 2025 at 08:58:19PM +0000, J. Neuschäfer wrote:
> > > On Fri, Feb 21, 2025 at 10:36:51AM -0600, Rob Herring wrote:
> > > > On Thu, Feb 20, 2025 at 06:29:21PM +0100, J. Neuschäfer wrote:
> > > > > Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> > > > > and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> > > > > file in YAML format, fsl,gianfar-mdio.yaml.
> > > > > 
> > > > > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > > > > ---
> > > [...]
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - fsl,gianfar-tbi
> > > > > +      - fsl,gianfar-mdio
> > > > > +      - fsl,etsec2-tbi
> > > > > +      - fsl,etsec2-mdio
> > > > > +      - fsl,ucc-mdio
> > > > > +      - gianfar
> > > > 
> > > > Can you just comment out this to avoid the duplicate issue.
> > > > 
> > > > Though I think if you write a custom 'select' which looks for 
> > > > 'device_type = "mdio"' with gianfar compatible and similar in the other 
> > > > binding, then the warning will go away. 
> > > 
> > > I'm not sure how the 'select' syntax works, is there a reference
> > > document I could read?
> > 
> > Ok, I think I figured it out, this seems to work as intended:
> > 
> 
> Looks pretty good.
> 
> > 
> > select:
> >   oneOf:
> >     - properties:
> >         compatible:
> 
> Add "contains" here. That way if someone puts another string in with 
> these we still match and then throw a warning.

Good idea.

> 
> >           enum:
> >             - fsl,gianfar-tbi
> >             - fsl,gianfar-mdio
> >             - fsl,etsec2-tbi
> >             - fsl,etsec2-mdio
> >             - fsl,ucc-mdio
> > 
> >       required:
> >         - compatible
> > 
> >     - properties:
> >         compatible:
> >           enum:
> >             - gianfar
> >             - ucc_geth_phy
> 
> You could move ucc_geth_phy because there's not a collision with it.

ucc_geth_phy also requires device_type = "mdio". It is more compact
to write it like this, but perhaps clarity wins out here, and this
requirement should be expressed with an "if:"?

> Add a comment somewhere that this is all because of a reuse of gianfar.

Will do.

> 
> >         device_type:
> >           const: mdio
> > 
> >       required:
> >         - compatible
> >         - device_type
> 
> You can move 'required: [compatible]' out of the oneOf.

Will do.


Thanks,
J. Neuschäfer

