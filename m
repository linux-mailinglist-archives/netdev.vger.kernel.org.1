Return-Path: <netdev+bounces-195106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27607ACE001
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355EF7A0434
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8770810;
	Wed,  4 Jun 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NCG+qbWG"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417544207F
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046527; cv=none; b=qjlYQe/945TovsqaFM9a1J56MRJ3oKkBT1V3V0JOY7Tmmd2DwYMaELCWrC0O0MaLXiRnu0ofExr0iM9ctLFagW0MUKCGmtlNhm0t8jWviNfnzn0bR1AcOTfBuohePwreJlaulZP91ycKo/YNbyZl2O3V4ThpEymODEzlYsSbUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046527; c=relaxed/simple;
	bh=aq9zI0qJSBFJwGii0gj0hrTLS1pDyymUIUuvv+Bpi3o=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=JqbXIh9KDZ5bDEPMk1Z37WW5907KJT14Gn+Dpf3Nlj7/ycJVvHDF8wcAQeiMypLkh9M3Xw6IG6oPJ53BwkDMSEvxJq0pk4t3up1Hq/T7ese4Xf5VDM5FsrZMcYLYVnuQmJxzX6MVvzjGDBdOIS3Aq+db5es9UOweZ9s3a7oyDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NCG+qbWG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250604141522euoutp021150b2dbd3406a42c782031f5a8e8855~F3IuN4FCv0166901669euoutp02K
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 14:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250604141522euoutp021150b2dbd3406a42c782031f5a8e8855~F3IuN4FCv0166901669euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749046522;
	bh=aq9zI0qJSBFJwGii0gj0hrTLS1pDyymUIUuvv+Bpi3o=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=NCG+qbWGKcv1JlZxQTrrwDS0yn0GgDxt+hWOoRX2Z4Pktw6TgNZBJ3audyaJNnDGI
	 ZIaYUDxdTj/wZdcAYSqo5Rv8ahql6hyMnSziwTloh49iG9V84eoGgCfMfYadGZEXf3
	 NfemDcl6ZN3Lce7UdYC8HH2xmIn4CjpkZW3KmPyc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free
 in __xsk_generic_xmit()
Reply-To: e.kubanski@partner.samsung.com
Sender: Eryk Kubanski <e.kubanski@partner.samsung.com>
From: Eryk Kubanski <e.kubanski@partner.samsung.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <aEBPF5wkOqYIUhOl@boxer>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250604141521eucms1p26b794744fb73f84f223927c36ade7239@eucms1p2>
Date: Wed, 04 Jun 2025 16:15:21 +0200
X-CMS-MailID: 20250604141521eucms1p26b794744fb73f84f223927c36ade7239
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <aEBPF5wkOqYIUhOl@boxer> <aD3LNcG0qHHwPbiw@boxer>
	<aDnX3FVPZ3AIZDGg@mini-arch>
	<20250530103456.53564-1-e.kubanski@partner.samsung.com>
	<20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
	<aD3DM4elo_Xt82LE@mini-arch>
	<20250602161857eucms1p2fb159a3058fd7bf2b668282529226830@eucms1p2>
	<CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p2>

>=C2=A0Thanks=20for=20shedding=20a=20bit=20more=20light=20on=20it.=20In=20t=
he=20future=20it=20would=20be=20nice=0D=0A>=20if=20you=20would=20be=20able=
=20to=20come=20up=20with=20a=20reproducer=20of=20a=20bug=20that=20others=0D=
=0A>=20could=20use=20on=20their=20side.=20Plus=20the=20overview=20of=20your=
=20deployment=20from=20the=0D=0A>=20beginning=20would=20also=20help=20with=
=20people=20understanding=20the=20issue=20:)=0D=0A=0D=0ASure,=20sorry=20for=
=20not=20giving=20that=20in=20advance,=20I=20found=20this=20issue=0D=0Aduri=
ng=20code=20analysis,=20not=20during=20deployment.=0D=0AIt's=20not=20that=
=20simple=20to=20catch.=0D=0AI=20thought=20that=20in=20finite=20time=20we=
=20will=20agree=20:D.=0D=0ANext=20patchsets=20from=20me=20will=20have=20mor=
e=20information=20up-front.=0D=0A=0D=0A>=20I'm=20looking=20into=20it,=20bot=
tom=20line=20is=20that=20we=20discussed=20it=20with=20Magnus=20and=0D=0A>=
=20agree=20that=20issue=20you're=20reporting=20needs=20to=20be=20addressed.=
=0D=0A>=20I'll=20get=20back=20to=20you=20to=20discuss=20potential=20way=20o=
f=20attacking=20it.=0D=0A>=20Thanks=21=0D=0A=0D=0AThank=20you.=0D=0AWill=20=
this=20be=20discussed=20in=20the=20same=20mailing=20chain?=0D=0A=0D=0ATechn=
ically=20we=20need=20to=20tie=20descriptor=20write-back=0D=0Awith=20skb=20l=
ifetime.=0D=0Axsk_build_skb()=20function=20builds=20skb=20for=20TX,=0D=0Aif=
=20i=20understand=20correctly=20this=20can=20work=20both=20ways=0D=0Aeither=
=20we=20perform=20zero-copy,=20so=20specific=20buffer=0D=0Apage=20is=20atta=
ched=20to=20skb=20with=20given=20offset=20and=20size.=0D=0AOR=20perform=20t=
he=20copy.=0D=0A=0D=0AIf=20there=20was=20no=20zerocopy=20case,=20we=20could=
=20store=20it=0D=0Aon=20stack=20array=20and=20simply=20recycle=20descriptor=
=20back=0D=0Aright=20away=20without=20waiting=20for=20SKB=20completion.=0D=
=0A=0D=0AThis=20zero-copy=20case=20makes=20it=20impossible=20right?=0D=0AWe=
=20need=20to=20store=20these=20descriptors=20somewhere=20else=0D=0Aand=20ti=
e=20it=20to=20SKB=20destruction=20:(.

