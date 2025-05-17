Return-Path: <netdev+bounces-191314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD1ABAC48
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574DF7AB806
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C9215F52;
	Sat, 17 May 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liqWWzmH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD3215198;
	Sat, 17 May 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512872; cv=none; b=UmNPkA/4AKguu4eM8jG5jHjK7F0zshriCbAFyQguFSVDo5s1lU7PaPADJ8SKTpt9ObFQrj/rRAJ2t/g1QlEAMDWO7k4MtJOvr9HU5pphjwEwUa5blifjk1cJ4XFWkdaqRhzqYE+iI0sMQXz+wSY9l7zut4R+1FA0udg+a4p8TPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512872; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgvHD9pUlkBdrA0Nv6ptYHkkrk9G+MUrJM1XLGxIb+RdBOW9By37ANyGVe/YQ2R+Ma8U8hdsx2Mg56G7X5+YVUThaZfILdyQwWYvIGi2dyD4e0IdKPKL1oW4ixRHUA1usDFy14c42bWK3/dytCN/NjVMGf4mYPC3K5UKvcI5lB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liqWWzmH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a363d15c64so847369f8f.3;
        Sat, 17 May 2025 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512869; x=1748117669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=liqWWzmHg1ee4VFoip3O053X+AesVBVWJtyVi0mk6G7JNBKEMLoHelPHfxx8izvadB
         6jzt3uXwSYo49akToyame61Qzhd1WgLa3PihuMgolvnfGU+/UEEY6t2nHpQnrHKHb1qH
         NpaOgbSENZx1gangmxwI+979WvK+j16Rvz9xxBXifw8a/G2SCZL+EInn/mg4+IplOfoU
         fmATVlmM3u3TLt0QN4wrJ2CIzb3hLcR7AlU8gW6IX/g/Xh1gI9ESqT7GA07CqKYsPjfV
         HR7WGJPpPZpm+oeOL5qkB3dpYNiTUFnzWsmWYRjlzOeZa7YiEmUCmhmIQUAgjQ/AhIG/
         lXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512869; x=1748117669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=SBcKVfkF/1YjQxZhLeDovM0SBRDyh4OGETo9UuRJbAi4ereoNQIrKPTH5odhqdnSmG
         tGl2uPA+4su3JAyuA+3demXSRGde8HVW4SsM9M1Knn93OApfHujZhPbHFJWry7QBJ28H
         4/7TNISX364iNGGi29GrNnucMZaWsXqiPoV3SUbMmD4oeuSws/np+nSWhW7J1LNcH7jb
         1KSFtnmlNfobNQQaBpoV5g8vfekzH1Ge+QMP7f+xOJTuGgKEsYp6THxvbbhIlwCAl9eX
         y47vbkBdgDh21MyXqx8eCujDOg0yMsLKRxgfkjn0ivmnzTaxWf3vxR47wB966yIOkX5z
         UEmw==
X-Forwarded-Encrypted: i=1; AJvYcCUHZioR+Ge3z12KovxVy6coK2Svfll0sGkicwsMTJNg+4YICY973WWj+R33euM70AKQzfcp0/V1@vger.kernel.org, AJvYcCVc5pZi806UtHjvlMnfHe40Z7uKd1xmctgtnzt2D+WLq+SwvWK/6oszc+JenrRofSkhXHsfpJZxLs4EH1vcydQ=@vger.kernel.org, AJvYcCWsqILzJEzINNlDmhs0Aq3MhzVeWLH5rWYxnk0KGF/JyChx96jnGxq/Yii9DVjWkjP8eHHwiIqTC24SiIfn@vger.kernel.org, AJvYcCXXo92uxsTgjcdnFemtXsfxH7j+7mkqxztH70OsojV069D87V24ucp1vGxnpz6lRhXIzu0vca2OEE64@vger.kernel.org
X-Gm-Message-State: AOJu0YwxiHAUK3xS22ULg7/E9lkrTTa2vV298iTsLLcofSWD8iuHlMd5
	8F8lQlg6t8YpSkCqps/OkUPUl+4xfg4jEkePdTegkvI9nkHNO1GcoGaN
X-Gm-Gg: ASbGncscUwvewok3o9QBoUm6bgvMF6TZAJXQ2b6AsUKBP64s9uZtAi8VW45HbUI4NS7
	tGFS9rl7kdO8Acl+ScUXJWDFNzuxtDMAC56FcuBb8WULIkjWYSu4l2mXX8WnVZ9DQBSgOLACsMx
	035ar2sAVjH19aekKFr93GlMTpsij5AbQcMqm696wh0bd5fz+cTVDODHM8d6AErnXiCsMrbNDMT
	TV/FQVfrijXADVMSxn8SYyAdNufDqC0Qc4LoQ/JOsmOlpcKZSSS44meoUcp//pD9ImcLaQHgUZf
	YC4XvUfCHZrvx9+n+ILTt71evwvV4d9ycOBaNPqq1M9PL1UfWivRGXhZKp8B+4da9r09fWGr+M2
	Bdw6jQGBVgacZ8frDi2gx
X-Google-Smtp-Source: AGHT+IH0ZGWnW1K3Jp3p4o3BJE8BsjzlmsMNkZXGB5yNqvSvLbdgA7SMzMBdF7N3MFqmjTATY5rLmg==
X-Received: by 2002:a05:6000:2210:b0:3a1:fc91:2819 with SMTP id ffacd0b85a97d-3a35c825f62mr6793668f8f.32.1747512869146;
        Sat, 17 May 2025 13:14:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v12 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Sat, 17 May 2025 22:13:46 +0200
Message-ID: <20250517201353.5137-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250517201353.5137-1-ansuelsmth@gmail.com>
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify .match_phy_device OP by using a generic function and using the
new phy_id PHY driver info instead of hardcoding the matching PHY ID.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm87xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index 1e1e2259fc2b..299f9a8f30f4 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -185,16 +185,10 @@ static irqreturn_t bcm87xx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int bcm8706_match_phy_device(struct phy_device *phydev,
+static int bcm87xx_match_phy_device(struct phy_device *phydev,
 				    const struct phy_driver *phydrv)
 {
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
-}
-
-static int bcm8727_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
+	return phydev->c45_ids.device_ids[4] == phydrv->phy_id;
 }
 
 static struct phy_driver bcm87xx_driver[] = {
@@ -208,7 +202,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8706_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 }, {
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
@@ -219,7 +213,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8727_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 } };
 
 module_phy_driver(bcm87xx_driver);
-- 
2.48.1


