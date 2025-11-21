Return-Path: <netdev+bounces-240815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09255C7AE4A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226803A3609
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE5A2EF646;
	Fri, 21 Nov 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGKsdAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200812DFA31
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743217; cv=none; b=c7PDvL1KD7cTNLKKN6mtT/xJXzC4nWri4X4RyaHYSpQvATZjf5eXmg1P7GLRQkHHE2Au4Ud21//MezcOFhaQnWqRKnvw6oM+a60RFBiEo+1yKtabYdbI3wP30aqa1YOkwPWJXZXBQ4yDXxv/GiQUFC5lD7vbxGv+xRzNPAPlufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743217; c=relaxed/simple;
	bh=R7A0M3wenjD6tNVpvDkjXqRmGWVTJQEA57KTYZCFHxg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX93FH88ef9zQ4TjohLDCw46Q43tBNGtoXRpsfEcWBBqeunKQgfyUxRZJTZFmti/2mqu7h7HCqh3kYb9Vklp6bj74x5bYIRoCekqk2hAUb3Qnf5QbbWg/EEhOUyULUp8d2foSSVVyUDNqsHrINdCzkHwzSKJ0ri3sJRSdbNW3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGKsdAj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-298039e00c2so29526345ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743212; x=1764348012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJ4EM8pojs7AbOw/I6gu37kPc/HNWYWJWxSfapp4Xmc=;
        b=ltGKsdAjB4fgEd1UcVJsGOI9e8vs9dOu5UNxO5u2gZImMMy48GWpLw0b7LOcvgnJKY
         WHXFm4+zN88lsh+EIv52FfqO6l2uBdttPKzCW3wZDK9LUgVG6AJwvDm42/cdZUY+LCXt
         WrjSt7I4UHExWGIJZpP0VBhOVjrEayYEAze32nnYFAuhvYiAcUks8q8j05RVhBUNGhIL
         5JeMIs3NI2vdIvJfLKcuoLA4u6HY1wFxk1m4OyyxGHMGJcihqCoP/kTvFYsGYYbSF53K
         qSCaFFcfc+tiFl/eLUEvlSXbOHSlxXX/h6WDADtTImwD6g5Du7lKuKi5nO2+eNJi1oWp
         ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743212; x=1764348012;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ4EM8pojs7AbOw/I6gu37kPc/HNWYWJWxSfapp4Xmc=;
        b=XIqgbyTg9uUbRe7oWo4j7RQ8p9yjMPum0S9K1bzd8vQ98wS2fd7Kwl2KKfb+p3nfjN
         YGhwmBF21OR42DIAxUhYDKhrG62fiYQiuVvQ2vpCVc1soTgeBv/y/1jmehZOirk30CdS
         YydsM2rVNcGMvCa1yGxVtFY3IsKI9WLC9VWwVc3cJW/N6c//G2BT8/lguvaG8LpkocV8
         iBE1LCH1T4xrxungR3+PV5+Bh6XH4ffTZfikXbH5husjyjIWedLBP966RNvhxP4tgxI/
         zcnkwWsC+tHYu/zSbA0IPatspioKlpD7NSU+jGBvHo8MLv0HUMiR6ZKa/OQy7Hx8Eh2U
         eImQ==
X-Gm-Message-State: AOJu0YyPg1Ze8J2mzTCtezNSIH6RPhgQ54RiPCq/Q1rPjK7b4S3Zk3Ho
	5r/xtA9zn494+lztVxH9fG5/7GkrBQVptpFiwaU03sMureRbqs9GO1Y5
X-Gm-Gg: ASbGncsN13G52f86oOpCmRUx0S0lu9siK0GgoKe3V+amt0t73yheRnCHftefkG+ZHco
	U/9DtIkYXG4gGoApWKfKk3K7wzoBl8XPE3HrIr2nLZyjpZ51QxewbCRO9ujwm2QYLkM+qWonF9c
	bowsFFmUm+tbpoRF1emm/we6IHxsB3JpbEenqzIAiA4Jo9sif1WC/QesxGDFu8sXIi9kJ/AuVdt
	ZqltKEHGCr00lXyij1pAWa/0rpJYW29DmJ+58zRHGJ688dp2dKcc83mAJwp2DgRD4bk+HHSeofX
	f3HW7fOVHTPbdQyK/DjCe2TzcOztajysJKhFXfrnRhh4rxJRD8YHBt+QAH9sdp+f0r4/5qoMK87
	r0AhFtrLNaMjJbT6TF57o8glRAeDKzhCyKe0Uf/yq1sDWgsNe7DGNnzr83XFLerLFr8kFcibdFs
	5ngiA48w6ob/We6amwBC0scui9MNliq6bP6WimSwCI/1UP
X-Google-Smtp-Source: AGHT+IGYkdEZC+r6mWG2gMErirwgWy6RywmWOuotYOvCDMRPcxw4Wz9jYQJJLdRwifuM1lQfUWFU6w==
X-Received: by 2002:a17:902:f641:b0:295:395c:ebf9 with SMTP id d9443c01a7336-29b6bf80942mr43319905ad.55.1763743211800;
        Fri, 21 Nov 2025 08:40:11 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bb7c1sm61591405ad.99.2025.11.21.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:11 -0800 (PST)
Subject: [net-next PATCH v5 3/9] net: pcs: xpcs: Fix PMA identifier handling
 in XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:09 -0800
Message-ID: 
 <176374320920.959489.17267159479370601070.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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
index 9fb9d4fd2a5b..a94a7cb93664 100644
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
index f23cab33e586..8d769f100de6 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -147,6 +147,11 @@
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



