Return-Path: <netdev+bounces-142039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C609BD274
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DE028458B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560EF1D9A62;
	Tue,  5 Nov 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="dwKr0WPP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607BA1D3633;
	Tue,  5 Nov 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824571; cv=none; b=ar1cRCSjnDD5JRKJZzAG/V5anqpPKFtvKR7xNAfqp/bTHulEmWGulzlcp1kGuX47KmifdVVeKQF3r7Mwlu3SA555Y8vJNe6OX+IjHCy1TVKWRkSCjcRVamugAyziLsPF3s0wfJ5R+busbb4XEB7z/UlTZRaZhFWssIEJmsWmLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824571; c=relaxed/simple;
	bh=ln3Py922KKXlKTAzPr2zWJLbwKOucazqphi9X/4MnMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AF5e/5LkzOuAKZZpG/dBn+3i7AjuoSwpvwN7DwqzA1mVI2CDQoHmEgAKpehY6bZBtNLZTmVPat4WMUzF01l8iv0XDt+BFvzhORG0+UkIuhcqTBbf1lG/kPgizKxl5PnBYE5PBOsgdgFySUqfH9oa76GU1WpJfXPF4gNqeNuxVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=dwKr0WPP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730824552; x=1731429352; i=wahrenst@gmx.net;
	bh=X53iOWm4QEn1aREm3FCJPOyfeAIpG4KfdRABRr/Pn+E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dwKr0WPPTQlE8x2TOTjKPTcAN9lclBp0kUzYNq20+0DHF6ka3Du9iBa/dfegbYdz
	 7ir+w2seX4Dm0urpfJMQR6ePneqQOlTG1mRdYup684YiNA8GD9HsORW5KRx9bZMU/
	 ZBwBqNvMc0OX7Kqlvj5CHVQ+GLQJkHZLyCXpr2C7cQSTL9kkSsFOtvll4NwiNzL1O
	 iPVzDUO4GRnnJSW8/QnvwI30ix/F0vjalHBzi9acxI5L2GTeyYn9DAknSY1o1GtLp
	 jUrEGDFAVehhrlMbuPRTmuWFgP3DDIoHhE5aFbKySyQZJfJw1vyl5TY3rsP3NuQwY
	 xI+GHFTwKc1eOyRYEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1tFBzt1Jft-00KQ75; Tue, 05
 Nov 2024 17:35:52 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/2 net V2] net: vertexcom: mse102x: Fix mse102x_tx_work
Date: Tue,  5 Nov 2024 17:35:44 +0100
Message-Id: <20241105163545.33585-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105163101.33216-1-wahrenst@gmx.net>
References: <20241105163101.33216-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kn82oTp3sNok+1ndgs3Th/u/X+gd2hKnTLrf0j9lrprH+uurnxH
 cgRGkCk5elDIcM7wcBbkHqwFISen6nvqQygyzqWPr0HnXwMpmVGtV++B3zuwWhOy25FHBXv
 s/3htImUOv59AwheTgW65R2+rGTeob8zG3uU4wTAKBH/sqdvV+QoC2m5v5A1F5S7wR3dom6
 oHlkuadyu3o0GIDG87nLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mm9yMFZN84E=;1rUlmGDVspTJeuzREDpcvJjLLTI
 r+JPVR9RaDobVoL1W/n2u05uyi6A2mkWZa40HL8eOYEANB+O6zGlAk9KN1K4a01s2CzsqA282
 kF3Awoo84/viif01skp1ZllQSAUVanLYbWIPtO0vZmhU9NImWJqLU9vCmmu8wuXQi6qdoEGnS
 Xaf6s6NB6RZwmKzFBBB3e9JfZWxNzkhRZ2d4OCVudZAXYm00AEGr9d9NB49ogf9DUHPOaaYDp
 AUE2O+RvdrwacT7xdV8F11eqwzgMmrzZC0R2Qf0hDyzad6w03pWt5vCJe+gpG5S0cnU+wTQH0
 cEBKEosMX9w+1JrkwGwnAQJy256AkJ06Zdif9srYwqhGhr/WK8RIArkevEtf5PjPALBrXjYt1
 tJ62qSq1EkK20B9wGIGBdY0IMFuiKkK2dVF/J4fpK6p41kKbHTJJcVvMxBwJExuu38/GiJpkR
 mkzqo5lwUq1moPgEJELGnEsZydWClE1sOnmyBYeSd4pxRZAIO4Qb/NqAQYIO+yKPEpnKj+Yj0
 gjpbbed252X4xoqUMuJEUYCaGlx56n0IDmX8uMG7TZpB02eiI38c+4FzUZIcecnduUPB8BB2s
 lxODK9WTBMapiOpzA2XIaZb19plVGh6MLUHH/yQnmUSboWdaUjR6TqYd4JNjwJ8DmysoTMcqv
 bGXQP7aZJJYvBbW+nglK/V7R2hxLkLEAkZZV8TvsWz903cwPHA9FuaV9EMRVRr+XpuduQyvu5
 RBh7+9C4fzBxVR6YqZ5Zs3miEglGMYNZKtqZ/ZgpqeMkxm0aGhYn6IUZCwkZDdDurQRE7bOPo
 Q7o9vaMTcBiOzSUrmKDFsjuQ==

This fixes two issue in the TX path of the Vertexcom MSE102x driver.

Initial version:
https://lore.kernel.org/netdev/20241022155242.33729-1-wahrenst@gmx.net/

Changes in V2:
- free the temporary skb in patch 1 in order to minimize changes
  as suggested by Jakub Kicinski
- add patch 2 to also fix the tx_bytes calculation

Stefan Wahren (2):
  net: vertexcom: mse102x: Fix possible double free of TX skb
  net: vertexcom: mse102x: Fix tx_bytes calculation

 drivers/net/ethernet/vertexcom/mse102x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

=2D-
2.34.1


