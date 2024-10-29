Return-Path: <netdev+bounces-139951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B709B4C7E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033F11F23BAA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69E18C939;
	Tue, 29 Oct 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dICxjCjw"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3A18FC8F;
	Tue, 29 Oct 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213370; cv=none; b=AENWDQFx0LogISrVfVcRfGwitvQ5uZ9C40P7WBqL0+7nZmw+4ixttEcXypgJu0WwgwUYd9Xe4roiTgWByi5kTeP8h/3+/CSwIGcE6shW8ZejdPgCe68bHJmTXY6N96I3NiuoaCdRSoFjH0JYltNpdqlkq2Gtsp6aif+aFSfCqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213370; c=relaxed/simple;
	bh=Fe+BNDAVp+hxy0uO2RSCAT7tz1AIgIN1gmz3UfF7bLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbc/2dUZ5yaAxGA5uHRoSEh82eneMMtlTgtH8bpj1TjSsFxcgM9EbCWZega+CDhGeoYhj7VzXFOHlgcAqs5n8aQ+L41fNpsZvT3DMxEL4AtW36fExsQ2e6VBEZmvRa5oxhnSo4HlxbFGDuZN7yhb32W8UyUA9QyVWtUNIefZEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dICxjCjw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8653460007;
	Tue, 29 Oct 2024 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730213359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FlNVllC/D5JV5n+6Shvus7HZtUjXDU01fqL2ePQhSc=;
	b=dICxjCjwm+um0i4q+atY1uQqjl32KNZ8qxO8kWbplQejYNtXxu2Wud+VHsz7+grDnoXcCJ
	7jxD5wu28OEX6xHBVr+1da9zPR31VEYekHdCecOEpTbIROIeIv1aIjRg37KQ1KoOgYql5X
	lAN0DUVLyiEO419475dlwSIsco1mpDnYWwgGMQ1ipBJq9Ov+TUD1i7u7OhOfCdGk9sU4sb
	HoHlxgjZjsMKBjMvTTGJFeyaxogSzQyp4kcU75nCU3IQY3C0oKPOle0lGghCZYUVZeRpA1
	fLSxDmPUhtlJ8Selj9r9QVHwoS8//S2pV+1tUEwtVpIdvyljnvDYwJGFs19m9w==
Date: Tue, 29 Oct 2024 15:49:16 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] Support external snapshots on dwmac1000
Message-ID: <20241029154916.50b5f188@fedora.home>
In-Reply-To: <a905c45d-344b-49e9-a0c9-fb7b6445edad@bootlin.com>
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
	<a905c45d-344b-49e9-a0c9-fb7b6445edad@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexis,

On Tue, 29 Oct 2024 15:45:07 +0100
Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:

> Hello Maxime,
>=20
> On 10/29/24 12:54, Maxime Chevallier wrote:
> > Hi,
> >=20
> > This series is another take on the pervious work [1] done by
> > Alexis Lothor=C3=A9, that fixes the support for external snapshots
> > timestamping in GMAC3-based devices.
> >  =20
>=20
> [...]
>=20
> > [1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.loth=
ore@bootlin.com/
> >=20
> > Thanks Alexis for laying the groundwork for this,
> >=20
> > Best regards,
> >=20
> > Maxime =20
>=20
> Thanks for making this topic move forward. I suspect the series to be mis=
sing
> some bits: in the initial series you mention in [1], I also reworked
> stmmac_hwtstamp_set in stmmac_main.c, which is also currently assuming a =
GMAC4
> layout ([2]). I suspect that in your series current state, any new call to
> stmmac_hwtstamp_set will overwrite any previously configured hardware tim=
estamping.

You are correct indeed, I missed this bit in the series. I'll update
that for v2.=20

Thanks,

Maxime

