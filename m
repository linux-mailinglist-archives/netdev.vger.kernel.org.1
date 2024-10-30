Return-Path: <netdev+bounces-140204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB39B5897
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE6283B80
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927B13FEE;
	Wed, 30 Oct 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="cjFkvgNn"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B0CA64
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248151; cv=none; b=NJ6uhHahnmcxbnPZtOjX0FGOVQXvL4LbGesqELW6MT7HdBx+mqkhwK6gU69FnQ5SZyc6WtOfiKEU9a8ank2dk0F5KixpRwU02PvtG/ZNvDUkafjCISjUg/R8Vo+eiVmiW5oFVD30XUHYZO3uwnsehPjOFkRFhHjrgeRTi48RTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248151; c=relaxed/simple;
	bh=CrVP5Ds7sG6Go5mXJBPjBGB9xYccOZwpdusd2f6yilE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mAQ2A/z4Vkqq8erMBftYbGiU9iCGVr9fD/E4D2Z0mcPs54Ka/B3fskB1GPpSMX9lIC40FLI/s8tN1La2nzCm1FueP7AjtFLJXYqsdcfx2xaNCrtIlW54iX9s+c41gBzHObBnt4oqfcXuem3q660WpyV5qbaQH8MICBDUMbgpWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=cjFkvgNn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730248146;
	bh=CrVP5Ds7sG6Go5mXJBPjBGB9xYccOZwpdusd2f6yilE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cjFkvgNnJPEHqShuPv+lA/gduoUOCcSuqlNOEFNKuFfM5pulh3RAth1m/RFhU9Snc
	 pPPV6gsfepGHn4EaQ3XbDSYn1fMJfcxKMsYxgbNplOh1pjNtVS7nhtxszrd1IJ/Rh+
	 DYbFxMXDFYTtXsboMnveOBb4+pIaXYAaGvo/e7e5aT+FMfb192OCSkWJ1e7i4WkQFa
	 /vUDELVUDVA0NWsyuIe4KMcbOskw9vpNwp6S0seZg5uEhUve4GnG1TR9AWaVPQVq1Q
	 iIUjg9jroc5vK3VqnK6dCatLkPs53ZJAT7/FB+jy0bYoj9CvnPHSDm0UzfeGuSAdfc
	 OfWWpTR3X+C6w==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EA0786A1CD;
	Wed, 30 Oct 2024 08:29:05 +0800 (AWST)
Message-ID: <198a796d5855759ca8561590d848c52028378971.camel@codeconstruct.com.au>
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after
 free on unregister when using NCSI
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Date: Wed, 30 Oct 2024 08:29:05 +0800
In-Reply-To: <20241029153619.1743f07e@kernel.org>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
	 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
	 <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
	 <20241029153619.1743f07e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > As the ordering in ftgmac100_remove() is:
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (priv->ndev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ncsi_unregister_dev(priv->ndev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unregister_netdev(netdev);
> >=20
> > which, is (I assume intentionally) symmetric with the _probe, which
> > does:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 priv->ndev =3D ncsi_register_dev(netdev, ftgmac100_nc=
si_handler);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ... */
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_netdev(netdev)
>=20
> To be clear - symmetric means mirror image.

Totally agree with you both on the concept, but I had flipped the
unregister order in my head, sorry!

So, this worth a try with the _remove sequence reordered with respect
to the ncsi device. I'll work on a replacement patch to see if that can
be done without other fallout, and will send a follow-up soon.

Cheers,


Jeremy


