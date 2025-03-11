Return-Path: <netdev+bounces-173785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD40A5BADA
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A903ACDB4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17E22257B;
	Tue, 11 Mar 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kIvSIzH4"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4722156C;
	Tue, 11 Mar 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681841; cv=none; b=BSiTHKVkeKJyYHKAS555n3ymCRQ512hXXiSXSPZr8pNns6FxGYZ4kGq1XON9sgKZnyVFndyEA/zsUaHzYS2nwj/WVD1fhFiFTxs41WoxPpXoFKm1l/t8KmHRiUtEPG8Vst0pRVCeI1b6WJRfSV33h2+YHDUN57LZY5Obhkw9Z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681841; c=relaxed/simple;
	bh=TUAJigk2aodKdqcDX3lW0N6rz+6bc8s1kwMGBy8TwIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDJ0dxW++dYyP2cVxxQTDXjWPtIzZDKkzhTcaBU3/G4Tm0DT5L20sYiSN7YrOI/YTgoEqMHap6C5cZ4sYuCVINw6ODN/p10p08s8m+oSs6Gxs/6Qaq2u4d/X+LT66+11oGJMpzeEWjwtXYcnVziG7KRhDUXFHPX5nrH21+q1984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kIvSIzH4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E359D442D7;
	Tue, 11 Mar 2025 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741681836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1apLwXpfvTkWHh+6/5h2TiHju9pcs5d/PyiuJeHcyg=;
	b=kIvSIzH4kJatWgUgEJ/ehWNJgd5eY/pHjJ8Eo+UBMSKZ7o/Tu1XnxNisVpdGgkl4N2SZH3
	Y5p07kTQhnaD7ig2BQG6R8hVVqEVK0emh2Rfm3CoN/ZMKgHcvceKkY/0NFjRkgdqhzhMq0
	Bj7L70Lt/SR289hrtzbhqbTHuazZzueaurhmFPpYD/P+7j0VJn/9VhK/81LJ5x60IIe6Q9
	CiSUTVOXh6wh9oN2OP5qYp4eOGxHHYujfg9Wj9xKmOA5WLJh95DnfRdngPP0iglYgExbG/
	B6mD58s9tWiDnas9fiDHZs10Xlu1gcCcLbzzg2UmOBS9WWCJxC7ZoFAcbfyprQ==
Date: Tue, 11 Mar 2025 09:30:27 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for
 return value in intel_tsn_lane_is_available()
Message-ID: <20250311093027.4546e766@kmaincent-XPS-13-7390>
In-Reply-To: <3bc2cc11-3a87-479e-a0e0-c593e3214540@linux.intel.com>
References: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
	<20250310152014.1d593255@kmaincent-XPS-13-7390>
	<3bc2cc11-3a87-479e-a0e0-c593e3214540@linux.intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddujeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohephihonhhgrdhlihgrnhhgrdgthhhoohhngheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoo
 hhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 11 Mar 2025 13:33:42 +0800
Choong Yong Liang <yong.liang.choong@linux.intel.com> wrote:

> On 10/3/2025 10:20 pm, Kory Maincent wrote:
> > On Mon, 10 Mar 2025 13:08:35 +0800
> > Choong Yong Liang <yong.liang.choong@linux.intel.com> wrote:
> >  =20
> >> Fix the warning "warn: missing error code? 'ret'" in the
> >> intel_tsn_lane_is_available() function.
> >>
> >> The function now returns 0 to indicate that a TSN lane was found and
> >> returns -EINVAL when it is not found.
> >>
> >> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the
> >> interface mode")
> >> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com> =
=20
> >=20
> > This patch is a fix it should go net instead net-next.
> > Could you resend the patch with net prefix?
> >=20
> > Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > Thank you! =20
>=20
> Hi Kory,
>=20
> Thank you for your feedback. I understand that the patch is a fix. Howeve=
r,=20
> since the code is not yet in the 'net' tree, we are unable to apply the f=
ix=20
> there.
>=20
> I'm not sure if there is another way to handle this fix other than sendin=
g=20
> it to the 'net-next' tree. I would appreciate any guidance you might have=
=20
> on this matter.

Oh, my bad! In that case you are right to send it to net-next. Sorry for the
noise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

