Return-Path: <netdev+bounces-175097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE02A63469
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 08:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F297A6814
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA417D346;
	Sun, 16 Mar 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNEwFglE"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9815C140;
	Sun, 16 Mar 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109367; cv=none; b=nDUJKUxVeXhg17WgBn/6qx/lO9UEw2InJcBgdLTf21XK5GK7/vNigv4l0XIH0scZo+mQ6MaFoKSwM1g1izzE5olVVCwZMdpyuIofVLZ0Ch0OGJFhNeZcr+86HiTE1PTk3SN94+FitJctHDgqz+CFZO6W3ydHItlir26s+9XufDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109367; c=relaxed/simple;
	bh=PHwVaRheoLoSbjinjvF+C7SnPjiDVB2V0F7hecJelgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i7S6lI/ESTUSvsL8DHSIIfDlT/nxecC5fW5PiaufcA/zgAL7LSBYZ/+/IpFgpTHTIqUKAqcTOaGKPxC2Am0wx0MeZMRsgN00u9metlW89sJ7PStwJe3LyN1Sa86CfCtHvQNfLcYgA7Exx9kwJvSFw2sE5TkFkV6Wunf/YuBjLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foobox.net; spf=pass smtp.mailfrom=foobox.net; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNEwFglE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foobox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foobox.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 72D7C11400EA;
	Sun, 16 Mar 2025 03:16:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 16 Mar 2025 03:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742109362; x=1742195762; bh=qEeLZisQ2/NPXnYSVWV7BojLBzWbfNb0S7K
	bRDPop8Y=; b=CNEwFglEeF5kssYs+VAK6VzlUTqEa3imIVaLjM6wkweuAKJljvk
	6gnkTzWwESyNZ6QfMXOK/7/MdoV6Eb33kv92W0taRLDL7Yxqx6IkGHEHNCqPdJa5
	9kr77TgDFPnUclUo5SGqVqBuZlWoHkN9dCaTrg6NoWPiG/ngTBdw2dwTkD49Z+hj
	hU4YE8YvdHZs2A1hIcg79RfvXxwNAF5eIPgqkSZkvZLXszN+zdPgS9y9qbma+mTT
	aagsEP7b79pPP8iEqpkfI9gqZ3k0KFt+YRG1Dxf0RhdXoAyFLIUtPbVXQMZL6zkN
	qa0CKMymqmoXvO9U5mxK2pvCgViBqC+aTKw==
X-ME-Sender: <xms:sXrWZ8lEtVVQ5F349NEI9OaHhmilDl-x2wCTUsya2aqUHjDwrbf5HQ>
    <xme:sXrWZ737PFl3ey2_kWsVh5GZC9S5v7HDH8YD5KZoR0Hs0Jz2fMM6MOZz-9vUHjbDO
    p1pa5Ja3oL0l1GQwGM>
X-ME-Received: <xmr:sXrWZ6pVv7gh6h1_MhrY6TWwTAXgD3epSuHOcjF_9EkmS4ZcYhGrTq7fpCW2inK4n-TYWUWHl91gLQ6o0MCO8xIipwy2Mxn8xORYBrRXQuQi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeehleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtjeertdertddtnecuhfhrohhmpefkhhhorhcuofgrthhushhhtghh
    rghkuceoihhhohhrrdhmrghtuhhshhgthhgrkhesfhhoohgsohigrdhnvghtqeenucggtf
    frrghtthgvrhhnpeethfdtueeggfffieeuledufffgtdeiveelgfevueekkedtheevffei
    feeiueefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehihhhorhdrmhgrthhushhhtghhrghksehfohhosghogidrnhgvthdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsehluh
    hnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehihhhorh
    drmhgrthhushhhtghhrghksehfohhosghogidrnhgvth
X-ME-Proxy: <xmx:sXrWZ4mhCTrFc7EXRWbB9-6O8O4MFi_hxOqlm2JCmXsAz3m3EkRoJg>
    <xmx:sXrWZ62hylHMo8hH27PjpXt8_CQBjC4FmQ2Nsh_tdf1s3lGFvBoiuA>
    <xmx:sXrWZ_vg6nJAib7WmMvXp7SOUlbiCw5gDUA9V6xN3mbT2BOkvxB8aw>
    <xmx:sXrWZ2XeJHjYckGuA5ef-jCQLmEHRzwbH7cCXoBu9YHc4gmFlVf6lA>
    <xmx:snrWZ0puEWQxaBjoSf5ZVLfquIrwXzn80bLBE1VsjKMMcyYcQuDc28Ng>
Feedback-ID: i7f494978:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 03:16:00 -0400 (EDT)
From: Ihor Matushchak <ihor.matushchak@foobox.net>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ihor Matushchak <ihor.matushchak@foobox.net>
Subject: [PATCH] net: phy: phy_interface_t: Fix RGMII_TXID code comment
Date: Sun, 16 Mar 2025 08:15:51 +0100
Message-Id: <20250316071551.9794-1-ihor.matushchak@foobox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Fix copy-paste error in the code comment for Interface Mode definitions.
The code refers to Internal TX delay, not Internal RX delay. It was likely
copied from the line above this one.

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..6fd4a1f2d4b0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -89,7 +89,7 @@ extern const int phy_10gbit_features_array[1];
  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit media-independent interface
  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal RX+TX delay
  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal RX delay
- * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal RX delay
+ * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal TX delay
  * @PHY_INTERFACE_MODE_RTBI: Reduced TBI
  * @PHY_INTERFACE_MODE_SMII: Serial MII
  * @PHY_INTERFACE_MODE_XGMII: 10 gigabit media-independent interface
-- 
2.34.1


