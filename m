Return-Path: <netdev+bounces-238443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D6C58DBB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0593A60BF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935F35BDC9;
	Thu, 13 Nov 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDemp0hQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85F35BDB4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051606; cv=none; b=VBf6Ow8yTHTQpOLicBVfc0CyFHIeC00hw9IEZT/y5ot4yMk8+lbVkHuZ83leyUJDoEKUWSZ8EQhNjgC0SPQHqKBnib3zadGKxfIdsu+ikRkmHGkyJ0mJfxI2xjAjFX1Xt7SilmTbJeGfSj4XyTlJ+a88sYlUK3aeTig/dThb83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051606; c=relaxed/simple;
	bh=921OwUDvAOz81X0pF9GX8uUfL5xhnoraqI0MKrGZmOA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7byLYhuWV6xMovdYf2ZfmefO17vo+CEqwAM7THQvrcyYxTAO+33gh8N7rhMMjWcZbr1RwkYrHk6GcHmVna9UvqNYAwTj5n4A8VLc8Cb6p6xivHfq0ha3RUFpTQ7Xks8hDLsSAXdR0Knot99lH/7X1etJJ3ILAtW28RjMdtYilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDemp0hQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so1238165a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051604; x=1763656404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fi9UM3WYsTAPVFTKvEaKOsUY1j9t/jx6K8rM2VBjZcQ=;
        b=MDemp0hQ+zFNOvYE2spwv9ePhkTug52F/t2ZE0H4A+rHNYPX/ALTihx/0UyejBBDIt
         PrfVU9w2h/UfeIhtExxkl6lp4F7hFkTODjzYzfSi9VFopuNUSCpts4gUeyIwMqR3qbdT
         V4HYs5Z/rsNEGwbQG4l/tdZKzecwTXigkJZO61AiRu+bsRKCCxHyRujPXzshkRami4uU
         vNkds9bbUYMYP/k+rB/F7WKxMFZboGCp/bAPsEb1YD5kTE3MjaSgmhIqUcWLA5IBBfHB
         gwNx9BqOyxJWzlNoSNYddjUOjzOzlBQywtfzLd3y7X1pxOci0EaL48JjQoeha7IiciI+
         Ud6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051604; x=1763656404;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi9UM3WYsTAPVFTKvEaKOsUY1j9t/jx6K8rM2VBjZcQ=;
        b=EhxzzoavJWSR1l0hskZHfrktT6cBPKwvnnsZQ/tEmlTqH0iqeQZxyYq8Nd0nNpDuPs
         cdOjhgFDM+5LJN9KIirZPLl/SqJexQ22N56Rk72Z7/txIm0f9zyatTvgcImKISPTuprk
         P/IV7Gjny8OUN5sZEdYtgXe8zsgIu33M0vQngsfaM0SoY7M4bDHlnr77NLGXduaApCfv
         UBttFqtll+OWw9NJ+BPbR/NEsVuJKkz9lA0lCtE05vLOm1giG4HiExe4u3adsxqV0nPe
         37nv+tGBpJYlVrZMDoPDFPK4IrEw4NmERnKSjid5y32MF5/BlBySqHqFMdsyTjZb6VDp
         L2LA==
X-Gm-Message-State: AOJu0YwWxxXcvyjqMV//fz4ZT2j5nQSVjX7xe+hIRb4mn9Xk4BwgDMDD
	k4/yoMMs6iY1brGN/SuhcxCi3xis7mkj7sUUXPNo/iUh2YUIua2G97EfG7/25A==
X-Gm-Gg: ASbGncvMwW+pMvdA1EYUtH9o+tEnjP+pomxSDmJ+hgeQ8TdKUMvzqYD0H+aD1ljrTDg
	OafCWSOv4Voo8DLt8U72VCXEyTBdKsarOfTZE/062qZOBq9aElqMLic9m8OaLcvZnkUNPsXWxMp
	Huv0IQnE82L+GOGTHCNfLnNwDY5nB/5Ymxri51XcrkSsIdvKJ3EoiRJfuqoF7g5YMFKmnVw2U4w
	fON86yXE3PJAfYmQ98zukeLnwRgEC0rZBBqT+ba/fqaeIdhDy+g0fMAcQlmOJNp9YszCUOQUftM
	d89P68Cjww9FWGkq/pVib9vP0Ybh82a0x2zk8tcptsSwerkf5mrzRjKtqugJOENpCwv65ihraEE
	TvpV5ZewBlmiGn2DawoVYupWR+TKlj9fXeXi/7shq71U2DEj+pF8hSzxp44INkO3zrC9qHgVi8m
	G9CQ5dAXo7qFf1OtKzbW2vbODrSq2/7DP7rCA3dUp8j+wa
X-Google-Smtp-Source: AGHT+IG6ZdUVfzaRWJyZ43foiMtboLLttfUdJ+KQVOq7bwu0ivAe9Fizg7b5UWWtsfCFpEsbdKp4ig==
X-Received: by 2002:a17:90b:4c50:b0:343:5f43:9359 with SMTP id 98e67ed59e1d1-343ddeaf708mr8776466a91.31.1763051604069;
        Thu, 13 Nov 2025 08:33:24 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4adbc0sm3057651a91.3.2025.11.13.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:23 -0800 (PST)
Subject: [net-next PATCH v4 04/10] net: pcs: xpcs: Fix PMA identifier handling
 in XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:22 -0800
Message-ID: 
 <176305160266.3573217.16499947846090111802.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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
index 2367b4f5ddd9..7b6b51a4ff29 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -150,6 +150,11 @@
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



