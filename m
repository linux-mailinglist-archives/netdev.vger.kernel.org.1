Return-Path: <netdev+bounces-237257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA330C47CD4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4744F5235
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2994277016;
	Mon, 10 Nov 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIRmsW2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17375274B32
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790492; cv=none; b=Hoad10Jr22UUBkAhD5dyBHHQBVU2AoOBAmniv00G8dVz9o4bQ1DJgNzubMVbu3SAvLFgztNbN1JvItCTljXdMhvwR5l4Hw4LkWGFKW60v6nXB5xe+u2kgWgtXKGv8K9tfLBplH6ab+euRY2UwU3zjTt1qNr8/PX/aL8BLQOpUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790492; c=relaxed/simple;
	bh=LU9+hzoJqYXd3BJQ+ZGwkF2U4ebKGsvYPQyqO+wovNI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lF9e1Rf6AzNxnAxgRiHt2EKdGCcn++Kvz9y5Z30GcCDrEn012syaXnnrkodS9pU1sc3eKKHR/3Dc4S7dlvQss8bPSlnwJQ+5rwD6lHvdeR9Z9pAMMha8+h4tQGllBkAyMCOLkCZWNXZeydLm3iBpjKxJPP/QPPmrfqndZoHDyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIRmsW2J; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3437ea05540so1626976a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790490; x=1763395290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXDvR+ROPnTo82YIQ6XDEozK4ARl6RQeFW59s+teRhM=;
        b=eIRmsW2JsaL3p8x7952b/OcN9ydDPpH8cEF2lzxRtkxfmxwCrLwoBp5ysaMgYDgO/0
         d0iVl0L9+12lb6ggWdngpJ9fGTcwxDcPIHkYwYSyju+hX7iRAJtuZmcySTeRo+h0VvqO
         IFthw9+W8nq7m5x8of4FMq6WuRmaWVb/Bpwl9mP8NoLv1gaDUkrBHTyrkbTjw5RtzGLk
         UEsq29j76MXvCHmzcQg2qflGuWF2WrOdWFi87S2pX9991PGtNwBbqKvNFRFUM9rGvUu7
         rcTll2hn6ekJNImK8VuT5TCvTmDNYPPqaShlzJW5ZNLysveiyyQcKh7zG0pIf+Ewjyf5
         DRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790490; x=1763395290;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXDvR+ROPnTo82YIQ6XDEozK4ARl6RQeFW59s+teRhM=;
        b=miZvDDQBZwkYFt3SmVHCvMtVJ9/GMCC7jINNqo+bVwumjdAxFR3ysPxgkW2BnmQ/Js
         YfRZ1if+xowaXT4/qYSK/TRk54OnSfIv7xTDjhcC3Y/uhekGhgUePybSaSpJ66p3JOZJ
         AC0u4Z5rLj1WZIMhH/rEmDb9Lj1/idnU7sYIVQGXE8LINtVUIj55tP7fb4wMEq7FK15q
         9VYwPGQQSzmeS87aGKZMlVjhWdK8OoCZmsIm8MKgMHrzY/+8/9OrDe9TD3J0tGYJkOXw
         sPVAWwqCnBzZg0QiTdoMTq1PiANER5qfBZsqUsS+4B/Y8rk0Z+st8luE1uiTljnvPQb2
         Mf3w==
X-Gm-Message-State: AOJu0YzbFJXmCsE30wZsLMElD4sgDkby5kBTg1xzbaaSiWyQv75EMfdY
	V0w30aF495vuVIhDNn3eslIc71eFCpGblO4pRuw09MjwqxcPbYEGCaUGDRhv0w==
X-Gm-Gg: ASbGncvGyhtE7/eOWvOS7OIb3pan2wrVt/5/gGI+cTg7NX+DQz9iUTF5k1q0LzUwbU4
	oGVqE53YFrtHNT5+G0m16sDeJocqR/ZoBE2guJA2Uo6/3vVTe8LB1fSGH8NPRuCUbDO0Os/GN+4
	c6YRKvJwMom1/jKOmKX2J5EEccdeYVcilyjXjY+lIphvOnAtaUpQqRUiOlNxVKKEcj9143DVg1s
	Nhvy16YeSl1q0vHBoBSGceDN4R9dOlBdBb0vbCs6xVrj5doQXWPRWUrs/VvA9JiVKc9wqIIgImq
	7zAMkOGbStfeW2dZzezqd4hDc/PR8shkTxZhkprtr5h2tQ6Rkg6UK3695iTlovRv19Dx/Uk67vH
	a4P8OHGq8K9YjlqUyKsb2SW3mhck0Ea+2LeQC+NfGaVCt3hEJRSc6ORurp+GOTmB77j0lREiqUq
	u41fcp12lBHC1aK10AJkHbJpyfJ1lwzogB9xIzgLhBXN5W
X-Google-Smtp-Source: AGHT+IE5ZndMRmR1j8WMspXAGJ73fHdG6Kli8Hp6bMgjfcZTtcDAG+PIYamYyqyAgLlxrREgoud13A==
X-Received: by 2002:a17:90b:3503:b0:341:2141:df76 with SMTP id 98e67ed59e1d1-3436cb22cc4mr10650627a91.13.1762790488429;
        Mon, 10 Nov 2025 08:01:28 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9295377a91.10.2025.11.10.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:27 -0800 (PST)
Subject: [net-next PATCH v3 04/10] net: pcs: xpcs: Fix PMA identifier handling
 in XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:01:26 -0800
Message-ID: 
 <176279048605.2130772.11372032499477099170.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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

The XPCS driver was mangling the PMA identifier as the original code
appears to have been focused on just capturing the OUI. Rather than store a
mangled ID it is better to work with the actual PMA ID and instead just
mask out the values that don't apply rather than shifting them and
reordering them as you still don't get the original OUI for the NIC without
having to bitswap the values as per the definition of the layout in IEEE
802.3-2022 22.2.4.3.1.

By laying it out as it was in the hardware it is also less likely for us to
have an unintentional collision as the enum values will occupy the revision
number area while the OUI occupies the upper 22 bits.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c   |    9 ++++-----
 include/linux/pcs/pcs-xpcs.h |    2 +-
 include/uapi/linux/mdio.h    |    5 +++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index b33767c7b45c..8b5b5b63b74b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1365,17 +1365,16 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
 	if (ret < 0)
 		return ret;
 
-	id = ret;
+	id = ret << 16;
 
 	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID2);
 	if (ret < 0)
 		return ret;
 
-	/* Note the inverted dword order and masked out Model/Revision numbers
-	 * with respect to what is done with the PCS ID...
+	/* For now we only record the OUI for the PMAPMD, we may want to
+	 * add the model number at some point in the future.
 	 */
-	ret = (ret >> 10) & 0x3F;
-	id |= ret << 16;
+	id |= ret & MDIO_DEVID2_OUI;
 
 	/* Set the PMA ID if it hasn't been pre-initialized */
 	if (xpcs->info.pma == DW_XPCS_PMA_ID_NATIVE)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index e40f554ff717..4cf6bd611e5a 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -38,7 +38,7 @@ enum dw_xpcs_pma_id {
 	DW_XPCS_PMA_GEN4_6G_ID,
 	DW_XPCS_PMA_GEN5_10G_ID,
 	DW_XPCS_PMA_GEN5_12G_ID,
-	WX_TXGBE_XPCS_PMA_10G_ID = 0x0018fc80,
+	WX_TXGBE_XPCS_PMA_10G_ID = 0xfc806000,
 };
 
 struct dw_xpcs_info {
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 2da509c9c0a5..b287f84036a5 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -142,6 +142,11 @@
 #define MDIO_AN_STAT1_PAGE		0x0040	/* Page received */
 #define MDIO_AN_STAT1_XNP		0x0080	/* Extended next page status */
 
+/* Device Identifier 2 */
+#define MDIO_DEVID2_OUI			0xfc00	/* OUI Portion of PHY ID */
+#define MDIO_DEVID2_MODEL_NUM		0x03f0	/* Manufacturer's Model Number */
+#define MDIO_DEVID2_REV_NUM		0x000f	/* Revision Number */
+
 /* Speed register. */
 #define MDIO_SPEED_10G			0x0001	/* 10G capable */
 #define MDIO_PMA_SPEED_2B		0x0002	/* 2BASE-TL capable */



