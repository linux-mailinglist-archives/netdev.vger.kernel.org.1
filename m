Return-Path: <netdev+bounces-159991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824ADA17A58
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AA188667A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4051BFE00;
	Tue, 21 Jan 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hPBFXgts"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77E1B0422;
	Tue, 21 Jan 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452338; cv=none; b=fcJdEqmVcyCQ+4aMZS1woC7sSOgwcgnt8ltcDp7+3/boHx1KE8D5Isl/lD7IgcFRNo+OlsIyXafc8k/Albe+CAw/9s89jpbIm7qE8fgv/klx/k9JPloYCD+Xt50fTilma0gVr5JZyyYIP7fzW2E+N6Gm5MJ/n5Ui1AS09CwTilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452338; c=relaxed/simple;
	bh=Sflr5ivc+h5kHkfIOdrjf9wC6Lk8RuUAWf2GjGoKfy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNyA/ZmSGlimJdTC7toCKkgSHkEosWCJK12YvT9QhZGwerXXVQEedurFzXug3y4zFieLVoM1Vlm8QKNLSo2bZRcJF2DbdvxctTIUPu15aYR9H24ZzSaerjy5cnb0ioDN9CR0IqDkutKEq/aqZHJ0bFgZZG8GywE5lOBYcMgnmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hPBFXgts; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE43A240002;
	Tue, 21 Jan 2025 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737452328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NOmKNuSVD6s2UaRyy2HCIWTeSgPT4xEAHxy1IuzAhU=;
	b=hPBFXgtsFMxzyaxGrqEhGsaDNAVB3jpCoB200tlY77/UeTBtJxZhC9tDl2zcU3Q6skoMLy
	ADBT1fylDk1jnmHK3algFssYPkhM9+sTSKTNNbtVvdJi3yeF6tfmQeQzrZ9EKyL3W5Ko83
	GDrMo7e7tOUjDijdN6/Hb9vPlkAzzRSHnUIQYCRMSkN5azbkS1HX/HhIe+N/mIl2f+7kdH
	fCNQzqAUbPq97QWkLpmqiePubxhmVmI9ujnEGWkTubHnON0wWX7omznOP3x7sguTWS+ymZ
	ZjvAq+UdFgR6pem67eDAx3iomARjDgTP6266kngONCT7fIg4SuU6y30OOMxdXQ==
Date: Tue, 21 Jan 2025 10:38:45 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250121103845.6e135477@kmaincent-XPS-13-7390>
In-Reply-To: <20250120111228.6bd61673@kernel.org>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
	<20250120111228.6bd61673@kernel.org>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 20 Jan 2025 11:12:28 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote:
> > The path reported to not having RTNL lock acquired is the suspend path =
of
> > the ravb MAC driver. Without this fix we got this warning: =20
>=20
> I maintain that ravb is buggy, plenty of drivers take rtnl_lock=20
> from the .suspend callback. We need _some_ write protection here,
> the patch as is only silences a legitimate warning.

Indeed if the suspend path is buggy we should fix it. Still there is lots of
ethernet drivers calling phy_disconnect without rtnl (IIUC) if probe return=
 an
error or in the remove path. What should we do about it?

About ravb suspend, I don't have the board, Claudiu could you try this inst=
ead
of the current fix:

diff --git a/drivers/net/ethernet/renesas/ravb_main.c
b/drivers/net/ethernet/renesas/ravb_main.c index bc395294a32d..c9a0d2d6f371
100644 --- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3215,15 +3215,22 @@ static int ravb_suspend(struct device *dev)
        if (!netif_running(ndev))
                goto reset_assert;
=20
+       rtnl_lock();
        netif_device_detach(ndev);
=20
-       if (priv->wol_enabled)
-               return ravb_wol_setup(ndev);
+       if (priv->wol_enabled) {
+               ret =3D ravb_wol_setup(ndev);
+               rtnl_unlock();
+               return ret;
+       }
=20
        ret =3D ravb_close(ndev);
-       if (ret)
+       if (ret) {
+               rtnl_unlock();
                return ret;
+       }
=20
+       rtnl_unlock();
        ret =3D pm_runtime_force_suspend(&priv->pdev->dev);
        if (ret)
                return ret;

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

