Return-Path: <netdev+bounces-122484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066C9617CC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09651F221DD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9A1D31A2;
	Tue, 27 Aug 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HxPbJ4GI"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA381D2787;
	Tue, 27 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785846; cv=none; b=pPSA+NitYGtl5+EfOCpSgwfbvyjDrkS2LntULksldoXZmlRjZtOvLyYU/MPscHJwzh3Sa5qruFZ1T5b8ZbuERobcS19EvZT72H9Xq1Iz3X2m0PGqbRf4Qq7gJ2GZj43jxyG8YAsVZPnTHFtHsZoElmw6/gfX/yFjxjinkZ7wQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785846; c=relaxed/simple;
	bh=VCg1E/yUOyYkbm2QnGpBTYpLqUv5Ug/iEYQzqGHhiiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CskL423rQSfN8yyaEkGxmaLTvsV7gAHC/lLpsO5AimbQ+1IXPoVV/stf7qA7Y2xe1CpqC3KrhkHNaY2IQyApnFrSirf/9S974sDwV7qDzlppYnWAGuSvTtW93DFeC87ibg5Nru8VaOsvaLD+eq5PUXHiE+NRqkHcnNdRBqhgcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HxPbJ4GI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785830; x=1725390630; i=wahrenst@gmx.net;
	bh=iBp3pbEaZp9GAgIqRXdBVERs/VyykwuEMnkHZgKqzIo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HxPbJ4GIcYvXjUG1dEc8F0IdqNtEAT8ivSQY+dYbUccZV6xVu3Fo7CsLSYBMoBg0
	 qI4OvVTOatFKsJbR20+s4BU9s8nTmrv1djIDggKggC9p3zGmVC5aPKRcAwkK83EUy
	 Kvn6G4pUiGby+2ZbcMAAGrVyou4TFVMWTXDcXTVwaLzTHiN6JRx2KBSdPkBFiLc21
	 pv9RbJyF8vXsN71HrvIS7Z4xYRNc0VJ/5brjKO2aSEY0RrsdbqDfLbEkWGAEkfNO8
	 XKuguTjgX2ROJpdLDQM80ofLJ5fKEtHJI3zEN66WRClYuUTLqucxodU3HCc5xZshX
	 lboI63pb1BWyPZ2TiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1sV5Ep2uMn-00PkuB; Tue, 27
 Aug 2024 21:10:30 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 5/5 next] net: vertexcom: mse102x: Use ETH_ZLEN
Date: Tue, 27 Aug 2024 21:10:00 +0200
Message-Id: <20240827191000.3244-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:qus8KVBOsgQLvHN5h5ZsNS/fUFaROBPvHcN2AKzitTBClmsBM2Y
 raxPb6aihzMYj7qNWiFX8jIUCXVT4KkOmqTf1A6wj+jyi9WuzWow1XiykrqT1t59nZYZC8y
 zJbbD1LsiXiH5QHY7sIWgQWybEbTClelTN8GOChYCvTva6ezrVAEkCxVecekYnOZTBZt2jG
 6yUMvfvqINORfUrJd7z4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ZyvCe+VkmU=;aNPZiYxC4WG8jxNLbuHjflvxqpY
 68SHXhXX0yUIsn8F+nrytDuSuQQp3ntgY5oQGiiOdKAzH2Y/Y/EY5bH7gx38YXmNdviMvpzmB
 P4zooljpsR/mCVV6q3YHjEAhIxflZdlDq5BWr+f8HydtBiuo6s7JyA+MlGbyqUvsf291ncvVo
 /fU5KhaMbskzPr9FzguGNlHdFPixejoSVoFWliMgY+qUFfc7ltwj+krgAeT/QoWIiTwVOABEq
 zeidB1UWe7LPMiE0RSVLcx3A/40ZMXNLRy3f3YGWdxHP+caCPqD6cutga2pTnW4gtqoPt5JEa
 JjzWbIuUrErRa8H+kPti64NezQA6pXOKXOkOtPysOKFxiMlcWKDOUXYje/o/RvF9Lh0aykZW6
 LQMv7SVysk+XgudJtP3Z8mBRuIZCGZZouMp5qUBAZfn2mJq8W8+ZcC18D0iI1qWXgzdncjxY4
 /pTyf1iSqdknHBy89EXPROYJkO/8mnJFjXaEtbmI4Atu6iM8pIVFHQk25S+NfGrx1k1hAi4qm
 XAe09hTl7qP43mCCLJxQRSre11MUF38ICStX0BSbSKlb4pZR/UxBZfiolzNgcLyf/+BcISZoI
 w9C0W3Aw3NNqhnUtYoOiw+X3XFgkTvlRrEtetkHh3iaK05/5LPZwC0vkpli0dbZhlOVBaeLpP
 ccQE51QBQLLtrOSBxAjxpAPJeyobQ/p60ASCavG6loeUrtCVeReL2xt7msR1c1LUqAYz32dg/
 e8W8CNcWh3JzDmFvJUq4RoUCVqPsWlEN9a6DKpKNUN3Nd+cENAy6n+save3QmPVXx/qDDcLsA
 pHyaNCKk8VoeyCqW0jCvRzfg==

There is already a define for minimum Ethernet frame length without FCS.
So used this instead of the magic number.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 8a72d8699b84..a04d4073def9 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -377,8 +377,8 @@ static int mse102x_tx_pkt_spi(struct mse102x_net *mse,=
 struct sk_buff *txb,
 	int ret;
 	bool first =3D true;

-	if (txb->len < 60)
-		pad =3D 60 - txb->len;
+	if (txb->len < ETH_ZLEN)
+		pad =3D ETH_ZLEN - txb->len;

 	while (1) {
 		mse102x_tx_cmd_spi(mse, CMD_RTS | (txb->len + pad));
=2D-
2.34.1


