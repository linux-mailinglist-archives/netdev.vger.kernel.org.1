Return-Path: <netdev+bounces-122485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040889617CD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1721C2368B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA631D31B1;
	Tue, 27 Aug 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="YF0TuHm/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C51D279D;
	Tue, 27 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785846; cv=none; b=rr0mKAt5E8TFDiZI+bEHPNGOn850rDkZNPg9iGXYph4dDri/ePsQe7pnFWBCwDBK7EzLrBm1OJWWBpn2Xie9keoHjgsRhlj5FGxU/gSPY93An69CNrBWr8qgKe01OyRRMtzH6Ac+rHfxFkYAXwEyli9fLg6BtTA5j0krX2yJAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785846; c=relaxed/simple;
	bh=hOJ8P1eDdJPh/P5tV+GHSuEcFo9uesg+AnwGIYG6ywg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKXFnrCzTjr7qWd8jD7clkszeg+DSS5cmQQv40K+d6jGXPM7drlDpggFp8SpD1Ak8zwem/1wkog4n+ZRnYIjS6L+6VtFc/2rO0CARaCRTAM/GxztwnDuRX20v5JRAa3UYJv1S+eM6Itj8Zj22RYqUi7+GaA2kij+6c7+a/GT7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=YF0TuHm/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785830; x=1725390630; i=wahrenst@gmx.net;
	bh=x+XCBOGbZtklKS/6Dl5mPMQvwFou/sc9R6ngeOYiRcM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YF0TuHm/J0zp7cFMraANYxQkyzgRmFDnnjhRBU/+EScaqNYjqLMWrRTIBebAAifq
	 CCpK41OO5efZ0bMGm/npfARVH6ucikOrAzkSpo1Tjvo5/jTRLdfKUXBKeDpGwPbkR
	 UX/r2zqGRulOpX5b+5iSmoK4mzuoDOMdVorbk0Leq2Tp04AAlXTwgutjD7fgFieRR
	 neyWE/jKE2c8K4kR6JVpgCbvGtj7HnQ02KZ0i8NASrnAxp4SrnNm2NXsIrB4zs06z
	 dfYQnGTEyDen9112RqRWoXerICEXoixku1oiy3BoyG0T5oPZkG3Un8CN8vKMRhio1
	 SRaX6mhMi9Z9KB6BhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1rt0X53xT4-00wsfA; Tue, 27
 Aug 2024 21:10:30 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 3/5 next] net: vertexcom: mse102x: Fix random MAC address log
Date: Tue, 27 Aug 2024 21:09:58 +0200
Message-Id: <20240827191000.3244-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:9xtNyaDLTmFAd8qi+xZgWTLMFnq4pH3eEwSo4y/Srcz3c3g7Vfo
 /aNAwNQs19fMXFsmktB4BlfyZxGknshFDhax6N99GfsMFIh47x2udbb52zU5hCDhA9CrzKQ
 B/LFRLSXcnEzW/qZKTqawZzpZ7dlv2U6/F4RlfXP9/EQF0EJYh/mnUY1EYG/JAbslKv6RZO
 3KK0bJmSP8rGfcbHqL5Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BCgp+o7LsLs=;TalLNIhDgCMrfrtlNU0+tPOVO04
 kmJRDvSDenWFxpGgINcqnKZKiOiBj134oXWgcDMNy0cyYt+LxbEb3oQC3vqP/naa5QHIMAeXY
 2m9lGMwfcFUmCAfAk5AZTv0TvXOyL+CXomm9gtl0tkecNqwPxAh4pQy6NDf0IfbjHeJ/5B4ZU
 I0huE72dIqGenHHt+vSAEZYGt4QnJU86YsVQp5PxTgR0SgvABKdP+UWyHRRQ/eYF9KeGmWHAS
 9dGDd22LmWHBWpw8PZBaRViB5Rcfo98sCCpKRqq/tMrCLLVsWk1BsQuzquN1Bq+qLYUXD+95T
 LrCCU5W3fIZoNU8bfn8ZDQlZQrFMiTPAdaVqakZWzgjK2A1C8BNSm99XaDqtpg4F00inSBZMR
 MkuOAvhEVrl7HipDUPZ4FbD6/0RdpB8PiHgURAHf2tsVNAXAgtIETZIZTzvEmS8CJiVCINXwW
 GYagwQ12O73evPqQUnMXrmxI6t/DAX1UyIYLWbDbzcrEv9NFyK68UYQt4lAhh7IeFxXTrpNTx
 1Dt/H6UuaaqRDaVjhqPf/cd9UaEjq/yqgsoTF3/suK0DP3ZD93j5def6CYnAKPhbP7doFn68a
 n97uOLXKHZl/ew9GTapLTYhdaotcz0AVAV4KPvJr3xK/8Sy+xAa5MOSOLjGCLShIFwX8x/41t
 yMS7HSYuVXDXfUfccA/v1IY3DA8d2mw+dLBAfSZ1+mV5Zif1kyTuWhnW7cpuqCF2giKUn1Zfa
 XALT9JiBEFUbUnBSQabQsqg93wIavYhoT5akwQlLScWiLpSP9nRAxDcl4MSJZe0Z62BkQdDLR
 FtMjKf9Rap4d+fCuO+M6Tm0g==

At the time of MAC address assignment the netdev is not registered yet,
so netdev log functions won't work as expected. While we are at this
downgrade the log level to a warning, because a random MAC address is
not a real error.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 336435fe8241..4ce027f8e376 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -485,8 +485,8 @@ static void mse102x_init_mac(struct mse102x_net *mse, =
struct device_node *np)

 	if (ret) {
 		eth_hw_addr_random(ndev);
-		netdev_err(ndev, "Using random MAC address: %pM\n",
-			   ndev->dev_addr);
+		dev_warn(ndev->dev.parent, "Using random MAC address: %pM\n",
+			 ndev->dev_addr);
 	}
 }

=2D-
2.34.1


