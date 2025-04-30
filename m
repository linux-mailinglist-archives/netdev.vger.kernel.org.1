Return-Path: <netdev+bounces-186957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE377AA4412
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1199A67A7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766E1E9B0B;
	Wed, 30 Apr 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jrRARUnH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J9J6do0u"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D12DC78E;
	Wed, 30 Apr 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998468; cv=none; b=mKinj5aBWpLYwFSvUIMed4OI4Cy5t3vuqCocUhX26j1iDfU8zfCW/LqcRlBL/ZKaiuEAsyi3HT+gBiOcHXaBVtRyweut1KWhZyjxIyeJKwfSSkuVXr/ljCsanwrtDXCWH54HZSOHC5V+kf71nQomrJZreP41VjsUX1dcvRqGIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998468; c=relaxed/simple;
	bh=PKzz4GpXNCgGIa0rzM71L1KvZojTAwW+w9ousOBD410=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nl/qbFN3fxI41R9Dcu//N8zV+PVPAbJmOuiYRRXrNTL5RtPZLcL3iailQAo3Ts+druNtF/yQIQ6zM7seU0kTCJSilomIWfi2omx4ZHjBlxCORuXezUCJE5eilq3OIprKTlHiVQ0CnfPjxu1eofRqVle7v8Y9/rAO+vJtfCkWlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jrRARUnH; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J9J6do0u reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1745998465; x=1777534465;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PKzz4GpXNCgGIa0rzM71L1KvZojTAwW+w9ousOBD410=;
  b=jrRARUnHAAMRDWfRCVCrO3C/3hak6YMoZ12DeuS+t3LrjIpUNekj7BuN
   RUDu0+pzAmc7/Mbx5H4qmRECMzn9DfF4+AUajL8i3OWuAipgBbuudMIA9
   +QjMaTzMMhTNoB+wVFdCauquzrNgpw/WCgsMYnv8RHbV2HwJ7aSBgLJzH
   PnWTjxSOzVy+BJdlapVwFx0PtzWmOrC5+V4nEtzZskUU3uw6XNe1FSXNH
   CRlysuZ4bifntKbtOoSLc7AJNqqRrhp3Vj5FfjX3ZbgAwjbI6wNsbjj+Y
   qlPrj/2obTGZePT51OtOs+2iE4XdwAGpoPCG0A1vPdL4NDnCZnHeSc6cw
   Q==;
X-CSE-ConnectionGUID: qmb9bHPUQHiR/k58rQHINQ==
X-CSE-MsgGUID: 1V3sw6rvRYuTXG+k7tCkMg==
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="43800249"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Apr 2025 09:34:15 +0200
X-CheckPoint: {6811D277-8-45F3AE15-E90F7DFA}
X-MAIL-CPID: D0705AEC16E75CCAA574D1B56E0DBAE6_5
X-Control-Analysis: str=0001.0A006375.6811D276.00A5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C78C816423A;
	Wed, 30 Apr 2025 09:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1745998450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKzz4GpXNCgGIa0rzM71L1KvZojTAwW+w9ousOBD410=;
	b=J9J6do0u8lEE2W16t5i5xBUE6OJvrffKuBw+MpImOunqIfiVKeYE0BF1sStqNNQvxjJODt
	UjucfkRCh+D43AMion7i5NCU+MQPz5wanjoNSfStQl3Ok8XSFJ/M1fEd7YPPhpmuI+o5VK
	O2otQKOGgN+QE0qjCOqSKM1W+XutJD/1GguHf/QohJpOMg3+eyZ2Gk199+r6r8uGkVGwn2
	c+ZFl7j8PZgRHcDKWYEtDfU6/9nMKpJeFzQ0ZV6KE0xynYuR9wF/Nkey4cftRH1LtdZG7m
	1hTvePO6pVG6DhfJomE8hfZcjS0wn/daruChpIVQVj17lP3qvyeGwmV+zoK3YA==
Message-ID: <24fab53831b359f3e3d809d22ace7572e196cdf0.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Date: Wed, 30 Apr 2025 09:33:59 +0200
In-Reply-To: <d00838cc-5035-463b-9932-491c708dc7ac@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
	 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
	 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
	 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
	 <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
	 <b75c6a2cf10e2acf878c38f8ca2ff46708a2c0a1.camel@ew.tq-group.com>
	 <d00838cc-5035-463b-9932-491c708dc7ac@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2025-04-29 at 14:08 +0200, Andrew Lunn wrote:
> On Tue, Apr 29, 2025 at 09:24:49AM +0200, Matthias Schiffer wrote:
> > On Mon, 2025-04-28 at 16:08 +0200, Andrew Lunn wrote:
> > >=20
> > > > > However, with the yaml stuff, if that is basically becoming "DT
> > > > > specification" then it needs to be clearly defined what each valu=
e
> > > > > actually means for the system, and not this vague airy-fairy thin=
g
> > > > > we have now.
> > >=20
> > > =20
> > > > I agree with Russell that it seems preferable to make it unambiguou=
s whether
> > > > delays are added on the MAC or PHY side, in particular for fine-tun=
ing. If
> > > > anything is left to the implementation, we should make the range of=
 acceptable
> > > > driver behavior very clear in the documentation.
> > >=20
> > > I think we should try the "Informative" route first, see what the DT
> > > Maintainers think when we describe in detail how Linux interprets
> > > these values.
> >=20
> > Oh, we should not be Linux-specific. We should describe in detail how *=
any OS*
> > must interpret values.
>=20
> There is two things here. One is related to delays on the PCB. Those
> are OS agnostic and clearly you are describing hardware. But once you
> get to implementing the delay in the MAC or the PHY, it is policy if
> the PHY does it, or the MAC does it. Different OSes can have different
> policy. We cannot force other OSes to do the same as Linux.

If we want to support fine-tuning properties and other driver-specific
attributes that rely on the specific delay mode used on the MAC or PHY side=
, we
must make this policy a part of the binding docs.

Also, we make decisions how DT bindings work in Linux all the time, and oth=
er OS
must implement them in the same way to be compatible with Device Trees usin=
g
these bindings. I don't see how in this case we suddenly can't make such a
decision.

> =20
> I drafted some text last night. I need to review it because i often
> make typos, and then i will post it.

Thanks, I'll give it a read later.

Best,
Matthias

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

