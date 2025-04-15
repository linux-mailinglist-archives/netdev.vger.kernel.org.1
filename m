Return-Path: <netdev+bounces-182725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34314A89C50
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D753BD8BC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9A297A61;
	Tue, 15 Apr 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T2SQSU20";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I6MRJx/r"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26580C13D;
	Tue, 15 Apr 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716101; cv=none; b=aayZWDbrhtMayO/Oj3UWmPYTc2RFNG2YtAlCscI1dMFsHzJ9vbNfJV8hIBPSzbhJjFnRXrpASOVIdbnyIefh2vmlaKfSj8wIhW7iCBh24HioykFxop0ocoaB9pHIXqcN/T213lthCs3ifN4dx2i9Dt7OEcAz4Qt9eIAXTqHwxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716101; c=relaxed/simple;
	bh=p6/YP/douaKQO1T/UeQNJVIJNuyBwac6PM5tU84+G7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0NAJhwAq0doeTEpYjzgBaHH+xx5zJ39aW1HQxxqsuos/pBtJ8kDqN8tZCOH+QxwqysFfeq7IzSAVmtFUV+hPzoJ2YOV2YmLKkA3m1jqe5Mn3d0ugAULXqis6bEZkyu4MY87K912/vkqe7kajTIac1BZzkfIuOurJfVbt01IgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=T2SQSU20; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=I6MRJx/r reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744716098; x=1776252098;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TMnAqpzrY02pHoPTNbvY3PZslZvc/QgN62hcBMzzO+E=;
  b=T2SQSU20VBTJpeto2l6fNG9XXtBpNyHkMe2gtr/CR6btrniWrGvBE0Kh
   dBmpCHa5sel0RO6PE0zhcysbJYT/lqWzIZril8QfTNVICiUQkS/KRvyRF
   ohvjri17CNBDTZEfCr4oJ7oJ5Out7jG0YFH/VKXlbSqB7ylc1mIyOEGX5
   5BOhrXlb2X9tFVdwv6x6wiLTMKqc5Ap/MEIRovuayJzhVPMDxOUWxdHar
   fhlyolFTvLOBZgzQvPQwE/lT0e6AtdIisl40Rhnj8Tekowkl1YcerHyVh
   qLa2bPs5tYlg7jYS2axsF8jAnBRHKztr0TaQMDNmipXt9NvYk1nJPoDcb
   A==;
X-CSE-ConnectionGUID: L4JEi/L5Q7qvy1dy9z59xA==
X-CSE-MsgGUID: Up2UxQSvRDu1WrpYJnpxpQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43539482"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 13:21:34 +0200
X-CheckPoint: {67FE413D-40-DC4DC9A0-F4F29281}
X-MAIL-CPID: 1F665C71A695893F14C3B49810C37D09_0
X-Control-Analysis: str=0001.0A00639F.67FE413B.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BED7166161;
	Tue, 15 Apr 2025 13:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744716089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMnAqpzrY02pHoPTNbvY3PZslZvc/QgN62hcBMzzO+E=;
	b=I6MRJx/rKBk94GF/GTO8H8BRD747mhW7zqwK52aiOPfH3LrSmunMHpe/AN6jGx+ICYtvjU
	8pxrd7fzPopJ9HuHnihBQvFLermjG/iDE5MzeE14wZwOWnWpu2me2eOU5xhfkSDChn8+JN
	8LZqvlO4IUPG7XIS2LqJuSsZ6h9w4LdyFb9N6yQJS2EtOZEvESwTUxrnNItG/NUfJ8wlHc
	XXq5NkykQJomJv/RpscRj0/hA8hFmP5MHT9Il6lfHs8rTT5dQAmaN3yf3AYWgFQPyI+VY8
	lzvomRTtiRiYf3U+GOPz+22ka6IOMSjEQWF7SeFFcFFl/p87lU0IZH5kcYW6zg==
Message-ID: <a40072f780a531e5274ce7f2ed28d1319b12d872.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>,  Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Andrew Lunn <andrew@lunn.ch>
Date: Tue, 15 Apr 2025 13:21:25 +0200
In-Reply-To: <20250415131548.0ae3b66f@fedora.home>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <20250415131548.0ae3b66f@fedora.home>
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

On Tue, 2025-04-15 at 13:15 +0200, Maxime Chevallier wrote:
> On Tue, 15 Apr 2025 12:18:04 +0200
> Matthias Schiffer <matthias.schiffer@ew.tq-group.com> wrote:
>=20
> > Historially, the RGMII PHY modes specified in Device Trees have been
>   ^^^^^^^^^^^
>   Historically
> > used inconsistently, often referring to the usage of delays on the PHY
> > side rather than describing the board; many drivers still implement thi=
s
> > incorrectly.
> >=20
> > Require a comment in Devices Trees using these modes (usually mentionin=
g
> > that the delay is relalized on the PCB), so we can avoid adding more
> > incorrect uses (or will at least notice which drivers still need to be
> > fixed).
> >=20
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  Documentation/dev-tools/checkpatch.rst |  9 +++++++++
> >  scripts/checkpatch.pl                  | 11 +++++++++++
> >  2 files changed, 20 insertions(+)
> >=20
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev=
-tools/checkpatch.rst
> > index abb3ff6820766..8692d3bc155f1 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -513,6 +513,15 @@ Comments
> > =20
> >      See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
> > =20
> > +  **UNCOMMENTED_RGMII_MODE**
> > +    Historially, the RGMII PHY modes specified in Device Trees have be=
en
>        ^^^^^^^^^^^
>       	 Historically
> > +    used inconsistently, often referring to the usage of delays on the=
 PHY
> > +    side rather than describing the board.
> > +
> > +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the=
 clock
> > +    signal to be delayed on the PCB; this unusual configuration should=
 be
> > +    described in a comment. If they are not (meaning that the delay is=
 realized
> > +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.
> > =20
> >  Commit message
> >  --------------
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 784912f570e9d..57fcbd4b63ede 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3735,6 +3735,17 @@ sub process {
> >  			}
> >  		}
> > =20
> > +# Check for RGMII phy-mode with delay on PCB
> > +		if ($realfile =3D~ /\.dtsi?$/ && $line =3D~ /^\+\s*(phy-mode|phy-con=
nection-type)\s*=3D\s*"/ &&
> > +		    !ctx_has_comment($first_line, $linenr)) {
> > +			my $prop =3D $1;
> > +			my $mode =3D get_quoted_string($line, $rawline);
> > +			if ($mode =3D~ /^"rgmii(?:|-rxid|-txid)"$/) {
> > +				CHK("UNCOMMENTED_RGMII_MODE",
> > +				    "$prop $mode without comment -- delays on the PCB should be de=
scribed, otherwise use \"rgmii-id\"\n" . $herecurr);
> > +			}
> > +		}
> > +
>=20
> My Perl-fu isn't good enough for me to review this properly... I think
> though that Andrew mentioned something along the lines of 'Comment
> should include PCB somewhere', but I don't know if this is easily
> doable with checkpatch though.
>=20
> Maxime

I think it can be done using ctx_locate_comment instead of ctx_has_comment,=
 but
I decided against it - requiring to have a comment at all should be suffici=
ent
to make people think about the used mode, and a comment with a bad explanat=
ion
would hopefully be caught during review.

Thanks,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

