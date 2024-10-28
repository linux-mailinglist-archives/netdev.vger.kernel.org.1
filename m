Return-Path: <netdev+bounces-139659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB519B3BFB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ED4285C27
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E41DFE12;
	Mon, 28 Oct 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="susNEU02"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A51DE4DC
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147910; cv=none; b=k36t4kQf404zWsU5enc4J1FzZj3dCqnsYKWjBdPw+5B+KJU1m29QkPB5r5oytmzSJFXMDxUYMD3rrMP3OP//1CAY2dB9/z56H0/aGdOnatdKvpmNNiR/x7/cvx5gH8tuHvAMYNaM2T6r9zTnv0RZPHSKgxvp/EC13+O5T6qsEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147910; c=relaxed/simple;
	bh=VYywl7+jDIEkSocZe7yZ9FhHl4qRHs86YTfNNDvpIrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0Yqgvy2H0pAqNh6Kwa2eEXDgZKdbiWhUAMrDK7v6SL/rt5Q/FB+afKwI/YpcgW533yraya3smDl2TtJwSHWZFyRr9sWEc8lX6scVj7ScyOElLlmJMLdvbHfVc62s2ATOdDIlKXnR+5GdeWTU+VSZyj01y9/K0iaakYygBzlupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=susNEU02; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BLVkBYLlUD6VGWPS1Os8sFBTDUFRIdtADoJqHLXLFxU=; b=susNEU02EQtFIm/hOr+YSrKTUx
	w0IQIvQzMmoAuT0bXFcizTLx776G8DiYeQjMJbVGFULorNUnXXaaDpqZD4q9kLHb1/U9Yw7eCRflZ
	XnWryWzajeSw4Rizsdb3WLQEFo9vqL2yXG9qzvTF64fQLJdpiLsGdchKEdMzbExtvqi0=;
Received: from 88-117-52-189.adsl.highway.telekom.at ([88.117.52.189] helo=hornet.engleder.at)
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t5WVM-0000000077v-3Lpw;
	Mon, 28 Oct 2024 21:38:24 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next 4/4] tsnep: Select speed for loopback
Date: Mon, 28 Oct 2024 21:38:04 +0100
Message-Id: <20241028203804.41689-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241028203804.41689-1-gerhard@engleder-embedded.com>
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Use 100 Mbps only if the PHY is configured to this speed. Otherwise use
always the maximum speed of 1000 Mbps.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 5c501e4f9e3e..7a89dc87b7a4 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -229,8 +229,18 @@ static void tsnep_phy_link_status_change(struct net_device *netdev)
 static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 {
 	int retval;
+	int speed;
 
-	retval = phy_loopback(adapter->phydev, enable, 0);
+	if (enable) {
+		if (adapter->phydev->speed == SPEED_100)
+			speed = SPEED_100;
+		else
+			speed = SPEED_1000;
+	} else {
+		speed = 0;
+	}
+
+	retval = phy_loopback(adapter->phydev, enable, speed);
 
 	/* PHY link state change is not signaled if loopback is enabled, it
 	 * would delay a working loopback anyway, let's ensure that loopback
-- 
2.39.2


