Return-Path: <netdev+bounces-232682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519CAC08155
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17F01A6757C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED72E0B74;
	Fri, 24 Oct 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVfS0eGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411A2F656B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338451; cv=none; b=aZ9XOS4gG6SljqKkcW0S7vW18awYIXO3umQ7QRtICNsfGScpF9LZcoUAKQx48RwnCU7PpwzWcZE4U3SyRaRdJoE6Lt8pf8uwLfAh92gVVoOV5JmikODQnah47W1q/ihHPVyhIT0AGhVCdYSrpvQreZUhLLADxhWia9mTuxf4B8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338451; c=relaxed/simple;
	bh=B2YuFEUCCLzkNU5ykIGSLPxzWKTyVxBWoWhDD1myHo4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6mq5VE7uPyQ8zwpDV63Jx70vNjKitHPm9zj8kkUu1i6wHyA6jH3/5vHUbUs20KYV3aDdyXWstCDB1j5bhihbCNC6Jp5Om/ck1Z+FB9a8pTxyX/qaO+CCFDiI2vosAMLHsYlktcrOHLBv+zB3mgcdKZ+Vnoe3xIgsIxKQGhnMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVfS0eGZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1687510a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338449; x=1761943249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=In/K4Y8kFvYJOI3fnSYt7uh67mF9YGPmx9763zIPCHg=;
        b=FVfS0eGZ8wVQow9mm9q3qhdkqVo9GadNueUqVq7aI47Qs3bQatHfoOoB7Xnbj5X9vI
         b7J6dcxpzFDiIXzRMFUCfMa454C73mb8iy3XF5ZcDHt6ba1h6X3un9Fz57gm8vlWz/O/
         X4947rB9FsruZzpLeQxVl5V6RXayXlHhnOAosjtNFXjJM6gGF2jy1yAfk7Go5P0kwlQJ
         9Mz5KHeko8CbibKCPmZmTK8pRDjd4Dt5VI9qsja0wrS/JtSVhzuP3A3YdQ2F34OV9ikx
         NYBU1CL0unU3qhurEFoxNmyGxAxJmdecJsbyAjvDpBrKWoZ4ZK+SFTkWq/cQzRfPZySp
         lt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338449; x=1761943249;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=In/K4Y8kFvYJOI3fnSYt7uh67mF9YGPmx9763zIPCHg=;
        b=K4++Alupqw3pss1vhU0wJba7aOiSY5cvGbnU58zTxyeJv9EqAWxvPIxpVwKE6rTUIJ
         EZBhWaPTWhaGgEzfYkBsvDlS3wdwwT7ExEAE+WJ1SgtdFTr6+71OSQ9lQVJuVe8/9un4
         FFe/qtHRg6g6PPHSBTVPySJF5HwADiMbCJu3ExioiN8HL+j34dACPtDpuMN32eRwJ8DW
         YDmxBcYamPywxcnXObaNKzOPzRZyb6/1W35zcC6Yfo2BPmPu3le2Q3m4+Sj0t2E1SET+
         ZyhSiFebYCeSEh6bq/mGKGLXE1QKfP0MXaQmJg8o37YlGwTce6zWLVXm2OS3Q30BXi4v
         myuQ==
X-Gm-Message-State: AOJu0YwSawVyqNKUOU1LeV6SaoG1dNKV2Dqs35YyEXxPAd+Gt1+GzZ8l
	ezlIz7sCPjUhzBGTO3HrkKZmz9Mfgzyt1xDYjCkjH5EtHycqSQgd49R4
X-Gm-Gg: ASbGncuWpLRCAlQ4qNGlUWtvzha004OhnWteGMhNdfMHQADOAXIUVDL8RS+rFbt37gx
	EdAZBMgdyfOHMhzlLlPfRNlEYi/QQ6Wl5qpUOmFe3mILnvBe/XS7TNUR5Ioc40V1KMW+YHW9c1C
	+MFC8IsSHhTSJujIDc2ctr9kSFmI1Z8Y6DuGAEHYqmi139MVsqeWFtRe1hsfwsFITRKlhifrLL4
	H89Us+2utAntvjTsS00VhI4eViEHPB8GA5T+iJnEvXvwpUD+3ro/wgGdM599I6TZ1kR7oEN++Dp
	oLNtoBnj836lJxRgqmfBkpQzPqRNoIWqnGyLQjBi3QTd/bNoyPbMy99f4qnmVcAOyfP0ubQpXSB
	CM/JyOtn2u4XKqdm/B2KFLmXhh1vqWBgK9YfceFFDx6BBmX76lKhoS8sgNMFbFJgfOnPdCsvUZs
	+C9T6LeQMTnvhFBsqxq5Twx0t4NcfnlTV8XnhUpNcCtAay
X-Google-Smtp-Source: AGHT+IG6JWk0b87M8zmTTh6OdB+7M/f85y4j6xC1N4gkaTq7kXCNBlE4TRZJaw048QNVBlA9HcDSnA==
X-Received: by 2002:a17:902:ce8c:b0:269:7840:de24 with SMTP id d9443c01a7336-29489e33ccamr51220805ad.21.1761338448724;
        Fri, 24 Oct 2025 13:40:48 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414083a7fsm109379b3a.56.2025.10.24.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:48 -0700 (PDT)
Subject: [net-next PATCH 2/8] net: phy: Avoid reusing val in
 genphy_c45_pma_read_ext_abilities
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:40:47 -0700
Message-ID: 
 <176133844705.2245037.8720565860938363849.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

In planning to add support for additional capabilities I realized we have a
bit of an issue in the way that genphy_c45_pma_read_ext_abilities is setup.
It is reusing val for both an error return and the tracking of the PMA
extended abilities register. As such if any one ability is enabled it will
end up overwriting it with 0 and block the checks for other abilities.

Rather than do that I am updating the code to contain the individual
ability register checks into separate functions and adding an err value to
handle the returns of those calls.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 2b178a789941..4210863c1b6e 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -958,6 +958,26 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_an_config_eee_aneg);
 
+static int genphy_c45_pma_ng_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+			   MDIO_PMA_NG_EXTABLE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_NG_EXTABLE_5GBT);
+
+	return 0;
+}
+
 /**
  * genphy_c45_pma_baset1_read_abilities - read supported baset1 link modes from PMA
  * @phydev: target phy_device struct
@@ -1005,7 +1025,7 @@ EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_read_abilities);
  */
 int genphy_c45_pma_read_ext_abilities(struct phy_device *phydev)
 {
-	int val;
+	int val, err;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
 	if (val < 0)
@@ -1045,24 +1065,15 @@ int genphy_c45_pma_read_ext_abilities(struct phy_device *phydev)
 			 val & MDIO_PMA_EXTABLE_10BT);
 
 	if (val & MDIO_PMA_EXTABLE_NBT) {
-		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
-				   MDIO_PMA_NG_EXTABLE);
-		if (val < 0)
-			return val;
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-				 phydev->supported,
-				 val & MDIO_PMA_NG_EXTABLE_5GBT);
+		err = genphy_c45_pma_ng_read_abilities(phydev);
+		if (err < 0)
+			return err;
 	}
 
 	if (val & MDIO_PMA_EXTABLE_BT1) {
-		val = genphy_c45_pma_baset1_read_abilities(phydev);
-		if (val < 0)
-			return val;
+		err = genphy_c45_pma_baset1_read_abilities(phydev);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;



