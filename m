Return-Path: <netdev+bounces-122487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB29617D3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0721F21ECA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25861D4142;
	Tue, 27 Aug 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KtVLoJtO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA65148FE5;
	Tue, 27 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785847; cv=none; b=hZq6LkMpBiBLXAS6mS8KpgzptBpfRMCxlczLGRxwpd83Tc3Vgxe6S36kHa8CEgZhKuH/HWXvlFw/nS19YMq4q6V7x9l8jJ/0h1Lq3iGy66mMYuh7qN2zXwpXqgt/kAFIFRWZdw7rXo3zgypqb9RYXoC4iqGjmbyKwpxwuFNzHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785847; c=relaxed/simple;
	bh=oRk73755Ab6XaVcx93FEYeUlYSOEDnuSor+FnYJ+JKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtIpxmqbEs4Tc1gwTTbpFiwYJHMDmDZ/PPoDysAmqXQJ5FCB09o9tgXg1FX4f+60fMqCv+g0JQiygYr/a3KwZgzBvlq9WKMEAN3fhTj5KZwTQJfAqT+uh9G3GJliGVvHj06QmiGtGye8Vkh4D00XE/uNY9kwxfLMNgaw/bfNDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KtVLoJtO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785829; x=1725390629; i=wahrenst@gmx.net;
	bh=vinKMheLarOF4ojWh2zc9izCXo/2DVtUtAGCi3VT5SA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KtVLoJtOzr60WpkVurG6azlVFCW/dT82cAurqJDCP2WwO64HVMTUwtbarSy62p0f
	 OtUljZRK1lQGg4OJDFiX11wj17n5hBsQZ5JUTJAHjqGCRK8k2eMCrIcm/muv2Texo
	 xZ9ZdLrFD+fW9ajh8k/TT0VvIPRLeE0CG0KAiW1qfcmsIMZdw2MUM8T7AnwyuB/X7
	 8clZvL0HwIZNAC5ZGOvMMfj1QFucL/hAXePS13LILzjJOdHipvCtAluaCrSHSUaIR
	 abpbqN86B6fvL6A+kgLl8zVdvFBChoSGAW03l+ArE9y73Dq5xqnU641Mds/hV3Nck
	 VTJsfUWOt+iUuOrmbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1saG9t0iFE-00Sliw; Tue, 27
 Aug 2024 21:10:29 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/5 next] net: vertexcom: mse102x: Use DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue, 27 Aug 2024 21:09:56 +0200
Message-Id: <20240827191000.3244-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827191000.3244-1-wahrenst@gmx.net>
References: <20240827191000.3244-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KX8dbKW5fftM/5aJ56zxGBxMMzoBIEO4rn79qEadYztoB6l+uK3
 S04R83gzWt0pROkRm36FqiSlliowt9umZKZOzX4Y8vopF+qp27sH7XnFxO4WGcFNvpbKPZZ
 Jim7gSCHq065EMb6JZRn01oOwOJWgkHW2OZqvO04InrOu/GFurx4NlptbIjVub9TeAenoLd
 lkLaT1Qa5IE+pIiJHWKrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w7TMYXbNAEc=;sISBO2LyCnBQwQmZEeHeFp5kTeb
 KHiosM3IHvH76Y2bGzw86C/ACZrj9iayk/BzVVZ95uygYumZ7gR7c+gO785gLwTQt3Tt+Qx1E
 yoiYVekEaOl02OEDvVvjswGizVkI+Qhlue0hZxgCGAk4Nf4JrIVOcRpbLqoXJjKgG85Et+aXZ
 lClcun9wGd3yvIV1iDA7iliISjeDiB329ikualhYyR94J8wVZmQ49vrf0d9J3N+Z9kbULPK0X
 wj5CRIxJNmX0lkvSkd8PbshDOzaTP/DjRmusgSdxkO3c3JVcAU1Z/e/++nH4Gv+fUU4WB0Ti6
 6RwwqGRCaImmXnPbKHdCacbjUAWciVsoUtmbyRLu0nWNuj5X0AXYVbvxi6EPJW29Ne1rRN64n
 jjH/z+tL6kcKRvgAZiXRwMCa4/6q1OEVZxn7HrshfeLgEMgxkqineCRT8Jh2OLVS66XUcnlXE
 pEbjXF1sgzAG5THCaQuIjDvoueZFp/NofuH/Frseq6++hjHvLtke2WKl5mvvAOKq3bxyDI4LG
 YVLnGgbrZySZ2/LUkOSYz50y1rKq/R6kd6IsYF/Z7b1R2qULPYyH3+pQ0/dH+aKjwHoDdVFc4
 0uomRPgangTyG53R8J+r5WcclRc1OAkVBpGPc+v18hnwH+vp3sY7dXK28rs+ucQpqoNsYU3i0
 gTxlQYToxwVqnV7vJ2K9gaJwa/aTIUhEKe+PYhe+VWSwo8F2NXrD1Yv3ijX/d6hDLewHJgxOn
 wsoD7iLPUvTGJrQYQM58yZ5sFWpy/ihE9MFgURSFRkBkHMRwXqjC5pfrmO3KPn5RSwdiE3hF/
 O8oVviN/pyPVf5xnysl5Ltmw==

This macro has the advantage over SET_SYSTEM_SLEEP_PM_OPS that we don't
have to care about when the functions are actually used.

Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
stuff if CONFIG_PM_SLEEP isn't enabled.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index edd8b59680e5..0711641fc3c9 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -622,8 +622,6 @@ static const struct ethtool_ops mse102x_ethtool_ops =
=3D {

 /* driver bus management functions */

-#ifdef CONFIG_PM_SLEEP
-
 static int mse102x_suspend(struct device *dev)
 {
 	struct mse102x_net *mse =3D dev_get_drvdata(dev);
@@ -649,9 +647,8 @@ static int mse102x_resume(struct device *dev)

 	return 0;
 }
-#endif

-static SIMPLE_DEV_PM_OPS(mse102x_pm_ops, mse102x_suspend, mse102x_resume)=
;
+static DEFINE_SIMPLE_DEV_PM_OPS(mse102x_pm_ops, mse102x_suspend, mse102x_=
resume);

 static int mse102x_probe_spi(struct spi_device *spi)
 {
@@ -761,7 +758,7 @@ static struct spi_driver mse102x_driver =3D {
 	.driver =3D {
 		.name =3D DRV_NAME,
 		.of_match_table =3D mse102x_match_table,
-		.pm =3D &mse102x_pm_ops,
+		.pm =3D pm_sleep_ptr(&mse102x_pm_ops),
 	},
 	.probe =3D mse102x_probe_spi,
 	.remove =3D mse102x_remove_spi,
=2D-
2.34.1


