Return-Path: <netdev+bounces-149793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75929E7858
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C000F16DA43
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C761FFC6D;
	Fri,  6 Dec 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XSXqNBol"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01661D4359;
	Fri,  6 Dec 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510826; cv=none; b=FpLhR69v8sYt+lx1h4FR4T7JbUfLir3SKfHCYnFtgQS2lKDzHdMW6TB7x0zwlRZ8HaOwcmMf0ap7YE1grq3z+BjTcIgEykpCxc/yZB8fInHsUCI+Efn7L6vxx0ELKYejGRO32/XYzghN+yEzVcz21AaEtrceP6U2AR9Pp1fHj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510826; c=relaxed/simple;
	bh=KownpJjuhG1Vzre4NX9kPtuNAnHdGmVtan08w5kfTxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrLW9GToGQJuNW60+NM1yiDvo7uJsI9v58HgK+2M5Kr49+HCghgZke86SylyRfj/QPv55vlyM+kQS28a5/76tH9C03jiAMP2ZYm6xoSEEBahl5nXcmRT/NAgkwhEbSNN9HfJSPVrzTrZubmtxVpoW6p2LekKQoEGqCi7polvz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XSXqNBol; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733510812; x=1734115612; i=wahrenst@gmx.net;
	bh=XuarqVQ6ECgriRQe74xwJU1j0fNdYk9PZcUyFe4MIHk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XSXqNBol+DbQXU12yB4BR1QfygMIyV3Z2p1KZNaohniia/NXwDIcFy9tkXD7b2UJ
	 ChbbjD4TPiCgqm2AJDRffJt7M+kKmN1v9nF6BWSiQZbc/jpVlm+csyVhrHYDljrIS
	 r8NhPcj0M0cttDoKed3UAoc/cmCn6bC6llcUpY5qjGY6+GTNrmM9zrQAj4C9vuQF/
	 jLT0YBogVlhVdS0C9Daz6msoIMC+7i07XvZkrljGK5LKkyWrGFkwIA/2mlLqE5tTP
	 haoxrTRMd0jqSIda2F4IRRwKjXSLRcbTdlpeFpJpFbeStG698hDO0mVS0tGAI0/1i
	 ZRz8MTDJobnCseZOzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1tpy5f1PkR-00qgEv; Fri, 06
 Dec 2024 19:46:52 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: chf.fritz@googlemail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 net 0/2] qca_spi: Fix SPI specific issues
Date: Fri,  6 Dec 2024 19:46:41 +0100
Message-Id: <20241206184643.123399-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hib0uNNzpZ4WsqhgVQ7cqQ9iGPWOxFR9bBWHOmiIgsRBjPis/UX
 O43azoGadi0jB4kXw3+RYojCn9/k5RHjxFG5X3bKgmKrILCxfrgYKtQuXOAjrPc89crVZXB
 qmhOfRPPdgs7vpE0Zy1jP+zNBrNHZ/uxqVW/X5aNnJ67dTrFIxTwV3oeIPQI5xLjexHfIdH
 Y00GmKYNjBoizAzv4r2mA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GAFB2MpxR7g=;Kd24l2kvRNSWmRpZiHhtNDnnhz+
 lqtn2oHs6SVVcuqMhwIhYnMiI3htQCJzvNU5AHBUg/vghHNYxaJVrlUdfM/sb8d/x+FRA10+2
 ByAXn05KxIbwOcJ3/dp0TOhOQLvP42ntOYnP0S28OoZdD3DVbVW30+D6ywdFyfSL5yIBCjrlC
 zr+0TJUwP4wrTmDSirSnuirWo3PLB4EBszQ7SsG9lMzSkzq2x7Ro5FfjeWKFxJxmi97Bl6wGm
 8/BzZC95VXCB5zSvDV9HkdNn5dortVzlRdPlOfiifpXZSCE2KbQsZlVRJMbCYT7j5O8JgSsRQ
 sPfcNZjnG7ss3ZA0H5VghEYbLHy/AWYumwovjY5hZNAk9J38tqALSvKks9u+gU3xlGs7mSlc3
 D0E13uoy23yCW9sNA3e0z+r4U2HH+6+X3sBThg6PI3G2ApnlS6lmABaKqdH8zGe5nMzXPZuln
 blw79FQCXP23bdSTHhbQoWTUTaYgBl8mhD6/oYwo5Sbl2ADw31QnjeywxWQzD6hISFY3xbvS5
 ZAh0zTdxC4W4TJVc4SLG68ePWlAAXLGIHVWRzMkOP60zTnz0r1NHnSEeBgLsBVp3lMu7KTacA
 YaQbG7yfnXGnpVQCE8i0bQZJAZaMIi8edN5jwi2pFJ8q9evHme/XeYF49X0+iVomx3e6wXY7i
 YjKB4KlhhcMi4bkOPK5hF5sqYkwZvhY8d7QtilTe4Gmbusw7HXRskZLPw+61+SFiy3zdbQl5T
 v6huM84Hllykonf5B0d0FL8kYQI9BMhHjj6bhXbJcMLGl9JY4buiAHOPNbLSyQbn7pDB5MNOv
 uChCLpUGE2UDu0nWXehQ1+zJMtuMCvGZ5dsbJe0OtDLpzzUQWkU43mXF1j/IXiWdI+2R7bVAd
 YlqfQSOtdekTTdj3ghUxyOb7c14hesOXJmCKPrxYnghfSQX46ClP/jBvH0oFfIP7goqhokalM
 DFg7RHdvjIaxi5hdDXCrHI1yhauuMdya3DvlsYbI8kJCJDOQswrQ79b9eXWwq5NQORml5osLr
 /c13RcXWdPHUDQEW//eOUULel+AfYWjquB6Nf8tiYlA+V4ZIod31YSe3slPCZJRosXIfTqoby
 kCML8vGTgtre0tJVfjA7VfGm4RKm9f

This small series address two annoying SPI specific issues of
the qca_spi driver.

Changes in V2:
- drop member clkspeed from struct qcaspi as suggested by Jakub Kicinski
- add new patch "Make driver probing reliable"

Stefan Wahren (2):
  qca_spi: Fix clock speed for multiple QCA7000
  qca_spi: Make driver probing reliable

 drivers/net/ethernet/qualcomm/qca_spi.c | 26 +++++++++++--------------
 drivers/net/ethernet/qualcomm/qca_spi.h |  1 -
 2 files changed, 11 insertions(+), 16 deletions(-)

=2D-
2.34.1


