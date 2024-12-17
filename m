Return-Path: <netdev+bounces-152713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E849F5870
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F152B1889FCD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0CC1FA8E4;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzS7Fot1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C391FA14A
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=Aoe2oUA6N4Gl77U/FkFtV2XnS8sMUqFZ8cI+yI5j59Ja/113TRYXe62jzsh3OZP7N0qKisKc9vXGM7NMTP60kJfXlZfC9tn+R469k3OIB3qsuA5zJM+38oV+t5NUiBfnx/hnryAzrR82h8CXPtPeIvbq1pCN/4Eo/0E5wW3Q+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=cUcGPtCzFichnrOkpOruH+m9VGQDdpbUd4lkMhluDUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/Hh4IOO33LJuCI2wxgNmU2IyCDSari/wMIDza7uYcajwvO8fDWBGyCTT3fRJvb1tbXKtPmTvFMhBvxTIrj85RPM5PzXtZDDDa9YOAd5vffUVa7XBMGgJoMVzEDzaBWzZ/FtjQbg1mFRNFbzJpsRPw7LVriSP2sguTxHrC0XQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzS7Fot1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3BE7C4CED7;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469658;
	bh=cUcGPtCzFichnrOkpOruH+m9VGQDdpbUd4lkMhluDUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uzS7Fot1yiGPyssnn95RYe7JbkyRlpb0PDOpNPGqkU6qi9DobjwWvLfJOhDoNM6RC
	 RNQvegweyGbEo+FkjygwHOtwkheurvr+iKB1/AMOw1OIrjdvYw+lnZStU+X9fjUMqY
	 5ah6vQXjuB6QAxo/Esg3Atz7M/IdeZPedk80CEu/8LU6ourM6DZdWkDlRAfQvymtjA
	 P+13OD/h5HXq3BeI+Dg0vbJK9eBRvaPvQtAZbDCW3EOnPG4c63i2u516XHlGMR4oOy
	 pJHJBQkgLrUdgq7WrkxVPIJlJq84Am9KzBr+89+ip3h+S/tFZ2DNh9TMpo54Xazthv
	 gzCUVkEWkNlBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B91E77188;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:33 +0100
Subject: [PATCH net-next v3 2/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-2-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=857;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=O5mlrVhtjAYbCCzI+ndsrKr3J5xvxej0+u1cLQwUG08=;
 b=NIUZiVfs8wwgDLkPxzZzdL/0qmz2uL9oWi6fZrjCH3Az8lkI41JKlfq4E/d+H0/1+sT/m1szY
 xV4e/tFK8w2DWm2z7N/SCVL+OQ9hDyFJdFWByGFZTctMxumzCEiysm4
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Re-use the AQR107 probe function to load the firmware on the AQR105 (and
to probe the HWMON).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/phy/aquantia/aquantia_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index bb56a66d2a48fab35eac87f75ad030a3ca6d9ec0..81eeee29ba3e6fb11a476a5b51a8a8be061ca8c3 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -912,6 +912,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
 	.name		= "Aquantia AQR105",
 	.config_aneg    = aqr_config_aneg,
+	.probe		= aqr107_probe,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,

-- 
2.45.2



