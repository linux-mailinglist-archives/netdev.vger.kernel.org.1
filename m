Return-Path: <netdev+bounces-235194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA32C2D56C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906E1188564D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26731BC88;
	Mon,  3 Nov 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpz7knM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA631B80A
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189222; cv=none; b=K0QLihEKm1dNUXNiw78Q9s1nlARaZEqH34AfF+JiKWczpQSd5QTW+WVMGV3Oy85sBSMYknWbr2ufv/cyroBodUl+h3KEpNGwSGT4CDaF4VKGLsb+6zozW2u0z9aYEX+DxNrwxLAHObBZsJ93AAcOgbIxkP+XYeMaWS31Wgg0blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189222; c=relaxed/simple;
	bh=H5bR8FeQWNUA6CRngE9Zg8qOV6D0gGpSoAYUJO1jqgA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrTxGfc46PfR6a86qx9bSLmoMp/IfUX+b7crCqAjNkQEjyIZMtkhH5P1GzYAKNKn3Lv46tkC85NvJw3PLcvVBJ0d28VpO6gNNK2OSB+84UiVXnvpqRbGcVajlLlVfQu5ghP19qvI9jaVuyU4+5PZW5cHU7bCBhaqNBU+3Fj1x20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpz7knM6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1270492b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189220; x=1762794020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7sZSm8PAN8NrK/k7VkLGwtk/SR8YhXYOxsJ/mEZjVCI=;
        b=Fpz7knM62M+fBUd1t7a+DzAPTIajaeb070aTuJR5yWLQI637zRgmOuqVcj0h2l2SER
         ebF2g9MzJxRdodcrwN0XlepLP5RD31zq/DACPMJlCTM4aq46lQzyKmDm1iFve8RCBCyV
         sznp69yvkg93FzQJ4UxOwMDEe6CGmH0S2mNlT5cqb9eLVV64WMhkyZeHtc17+aze2ZQL
         6mhKdfFZsfsYjzy6xUEPlH495OPFJUJlSVoJYfm2bMiagmKFZ6Ly6AFD4IfdUNHHpU4z
         e7XHAsRVQ5NFxr9Hju8jDIkK5fAeolO8wBUgUB71/uIdOwk1zuJ9zAKaG+1YtH4MUwHP
         zlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189220; x=1762794020;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sZSm8PAN8NrK/k7VkLGwtk/SR8YhXYOxsJ/mEZjVCI=;
        b=QNQDx2Wnq8dqFHOI9gBVVye9dAReUmRMXG4pjlak0uIaPWS0zD6ZPeey5BTGIgk441
         hdUmIRLXLgEpSw07sqN3YYIKYkwmlN3VoEtgNiVKaAPiFan4VSCT7tPKfgzICiib5gwL
         g3UU4S+1QjIvTRje1HYWrII/5c5wzqT/YsHBJ29zOcfsZJYEb+sUt/E2/tdoIPtbXIjJ
         pBA3GnpfshJpipwuZxNwEdYpoLMGmB5WAfKYVmj/Y5PaYB54U5PN2Ld7GIZpQPl8/ibW
         BAHaWUeOd0miaS2VoLPZP/VX0WzbIT/8AQ6WxmmMyv0flDoms6jKP6rMqbnfEw2tx+G2
         ehOw==
X-Gm-Message-State: AOJu0YyNcLJkNI1J4A77mSzbd2OlB3R+wGleKe/MO2GGqB6DGABlWPIa
	t0GpWI+2f3rtJR2gkgSmY6+TykBqm0/S1sDsduZBtzl0oEiGJFhXhKnItodzbg==
X-Gm-Gg: ASbGncvf+kaUm9bgEXyr64/9oGre5VHJMflM63mjXUzU8IKoyAwoQc2WxcpiZU2to0M
	BQxpaAde70HOnAB1jYsCIGQj+OrRfnNoLM/paQtba2pgsRH/UePsbNsYJZOAIBUzJqapFcq9Xtg
	bxQpw+MijuaLYdKeUBTBvLd8BHTHHRj5D83bblniENXvVW00GervnCLIbU+VsSHuxj8Il6MzL0Q
	MubTUNzMwAuUml8MeK7hfbocKz9S06UGTGJY0zNewAsv7JbUjf/o0oCigiJ1t7zPBnh+66Q3zEU
	NepbhJv7hF0T73mTEBooo40BHFeiL3G1T3P1+fK0rhDUPiclBndTMvQ/XLg6LW5iyvFIQmLt4ki
	sVbYI75ajVFYFmEEEXm1ea0tNh9JU5Qpto1kaGJxLzPeyrHweUFwwJ+1UW26JvSVRFA9JlrqXua
	DIQlc0uYZIgCSt+jcvkxJ3wK2Szs/I
X-Google-Smtp-Source: AGHT+IFhmNQui+H+MBWD/xk917ZR36FsU8CR+G3r+gcVvjdCodFhNnmWFUyqjGJRdJENZycVIldEiQ==
X-Received: by 2002:a05:6a00:1988:b0:7ac:acc:1da with SMTP id d2e1a72fcca58-7ac0acc0622mr2199457b3a.25.1762189219437;
        Mon, 03 Nov 2025 09:00:19 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db681f4asm11922268b3a.62.2025.11.03.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:18 -0800 (PST)
Subject: [net-next PATCH v2 03/11] net: phy: Fix PMA identifier handling in
 XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:17 -0800
Message-ID: 
 <176218921797.2759873.4522051915422366242.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
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
index f2a6fdb972e7..fde9d9299756 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1328,17 +1328,16 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
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
index eee38690ddc4..387c8b4eeb61 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -139,6 +139,11 @@
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



