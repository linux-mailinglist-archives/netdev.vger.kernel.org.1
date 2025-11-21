Return-Path: <netdev+bounces-240816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C758C7AE8C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530CA4EA230
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1632EE5F4;
	Fri, 21 Nov 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBWodlS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79F2EFDA2
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743221; cv=none; b=GSBqy+qqKGUkqOwqRb2Wei2a/detkWYue2YUZG2JIkGVP+0g/rgPfTaWdSkUNVZpZRzrHJHv7XSGFuD2tkNitAvhhfs+LzkUMBNBUnT/8RmAQqktOuix4yh4QX/RIZcZDwASIH2/H6XcyVkGH1lRafL8MOjRVxzyWbKCRmlKXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743221; c=relaxed/simple;
	bh=kzboeNl+rBRbsyCUOnVjTxZFz2Wo00r7uK+BawEccx8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Chu1Hv7VH427KR/DHM9CNDwoC+LiYKlQ3NFo7DVU03AAacr8yeFRKa+Nk4nSSJOk9eIRzPMCxUpOs9lNjIc4otRYIocxtiWKVEFNXdlTBbFsHr5cjSFbP9FcgOX2YWq4nQFYzdE59ALDV0iFgem7htC3QQMTghg6vPD8kMFvC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBWodlS+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ec50477aso9501325ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743219; x=1764348019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qHqI9InLLOOMiFtJSeDdov1AtoPP/wtVT8RUvwmF/w=;
        b=gBWodlS+1w7JgDJ+O+DnK9JCJjph9IGHqTfExR/WuHbFgAgxeVOFQSM1gFcSbBTam+
         zosz7ZzoR6VMtfXp6uPc7lWL402YiCgh16L27rXWPgYAu4mdOoexC8ieSuus22MfAwri
         JjJQRm0ny4arqkyQvSQ9DxwDaGo4UnUvbn/C3gdL7WDZ6iCxlnZPhmD1dynEdqkz8U94
         /wfYQucsvsYepm7UF5sFerKInegfUYYgQorkc8QWoR7Brjea8k9LkKlvnD1aG2T1ShIG
         VDjeOvjOjyVZ/m0ILUBfNOdZAT+cFvEgye3Key/NcOiK0v1Zi3mvLpq7DapjfZhLLt54
         yTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743219; x=1764348019;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qHqI9InLLOOMiFtJSeDdov1AtoPP/wtVT8RUvwmF/w=;
        b=AWof4bocRWLM0gfArvu4LtjfQNJJYzA1VmeLh1MwZIHLtk6KG95HJr4Ey2oZ15YYNU
         K8IUtm8RRit7T2sMyHK+ZRNFrwCTU6BZ7JzIfQhflYHPQPRTJXqdaLEovQg6l8SrB/RF
         yZ06zFTsugM9aXx+r+bphnOfGyTPg2gUQAFu1sGzkh+r+f9iYQi4FIrn7pGE3/llLtoO
         yxYHeDqt5CxxOKYqiulz2hdoOfD4p/g3r6uRY3/OnZu7emReHors4pQaAFVs7R+GzWux
         XQzTUSdtLDElTYmllZ95XkVSqqpDqhYWBcD7PvhH6kuNB+WUBSXl+5agc/O2UvKeYcmv
         IqWg==
X-Gm-Message-State: AOJu0YwiuIt1Xhy9WydUl6+YT4BVOqgevSJdhhyBkgzcuobe6NDXxUvG
	BlA2EN61Kh+Lvd0pBPdkPL4dI5Q5qdAUuD71lGk9ZkOlew/Bt7kWswV5
X-Gm-Gg: ASbGncsbYFpyO0Rf3O3mD9LWhm+RIySSdD/jZI4P8Se8hezTGmTQ4tpOq65nUR675Fa
	DgQMhT2nk7g/GLOSPXk5grATM6U0cA6JnFZnZbt4P5fQ1GLOeZ4zYm6At5636BjdYqDrXsOmFNh
	+B3fXXS4ZG68RsnferifMwmUge0vIH/cFDsn8gLoYVhokXkU3qOHNzg7ztZ0Hr+VFKpw6/JXF/S
	BBigEeQoTAa3UrzAQi6giRcZEixftyOuOvGGZepx3D3tcTKq3AdzoO/SEbIywGDTKFckOP9Vwzm
	hwdCuzneCusdQGnHs9no8aFt9QNJfMdd8qYZV8xjsK4JaO99Rx1HSF6ObiSMJDuOE3//NDKniFN
	tjKO2siPnbaguvL1lpRwlKPzKeukbGQihnfNIygMYONzxhIfMRYxTgVwVFIfvlFLSEbJtUlAKoi
	uzGxypNurVKdxGdOcXiGnOtF3u2tL6VUzlA7hiS56TZXWL
X-Google-Smtp-Source: AGHT+IGL3yUrv7C97r6tuIRv3HfRMjan/GZ5P/+vXrA2Feih1cWOx2n/H6WKcELCJOzgcbAntwd4dg==
X-Received: by 2002:a17:902:e550:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-29b5e2cdb70mr90951435ad.6.1763743218554;
        Fri, 21 Nov 2025 08:40:18 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm6027061a12.0.2025.11.21.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:18 -0800 (PST)
Subject: [net-next PATCH v5 4/9] net: pcs: xpcs: Add support for FBNIC 25G,
 50G, 100G PMD
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:16 -0800
Message-ID: 
 <176374321695.959489.6648161125012056619.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic driver is planning to make use of the XPCS driver to enable
support for PCS and better integration with phylink. To do this though we
will need to enable several workarounds since the PMD interface for fbnic
is likely to be unique since it is a mix of two different vendor products
with a unique wrapper around the IP.

I have generated a PHY identifier based on IEEE 802.3-2022 22.2.4.3.1 using
an OUI belonging to Meta Platforms and used with our NICs. Using this we
will provide it as the PMD ID via the SW based MDIO interface so that
the fbnic device can be identified and necessary workarounds enabled in the
XPCS driver.

As an initial workaround this change adds an exception so that soft_reset
is not set when the driver is initially bound to the PCS.

In addition I have added logic to integrate the PMD Rx signal detect state
into the link state for the PCS. With this we can avoid the link coming up
too soon on the FBNIC PMD and as a result of it being in the training state
so we can avoid link flaps.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c   |   24 ++++++++++++++++++++++--
 include/linux/pcs/pcs-xpcs.h |    2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index a94a7cb93664..9679f2b35a44 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -597,7 +597,26 @@ static int xpcs_c45_read_pcs_speed(struct dw_xpcs *xpcs,
 static int xpcs_resolve_pma(struct dw_xpcs *xpcs,
 			    struct phylink_link_state *state)
 {
-	int err = 0;
+	int pmd_rxdet, err = 0;
+
+	/* The Meta Platforms FBNIC PMD will go into a training state for
+	 * about 4 seconds when the link first comes up. During this time the
+	 * PCS link will bounce. To avoid reporting link up too soon we include
+	 * the PMD state provided by the driver.
+	 */
+	if (xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID) {
+		pmd_rxdet = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_PMA_RXDET);
+		if (pmd_rxdet < 0) {
+			state->link = false;
+			return pmd_rxdet;
+		}
+
+		/* Verify Rx lanes are trained before reporting link up */
+		if (!(pmd_rxdet & MDIO_PMD_RXDET_GLOBAL)) {
+			state->link = false;
+			return 0;
+		}
+	}
 
 	state->pause = MLO_PAUSE_TX | MLO_PAUSE_RX;
 	state->duplex = DUPLEX_FULL;
@@ -1591,7 +1610,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
 	xpcs_get_interfaces(xpcs, xpcs->pcs.supported_interfaces);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID ||
+	    xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID)
 		xpcs->pcs.poll = false;
 	else
 		xpcs->need_reset = true;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 4cf6bd611e5a..36073f7b6bb4 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -39,6 +39,8 @@ enum dw_xpcs_pma_id {
 	DW_XPCS_PMA_GEN5_10G_ID,
 	DW_XPCS_PMA_GEN5_12G_ID,
 	WX_TXGBE_XPCS_PMA_10G_ID = 0xfc806000,
+	/* Meta Platforms OUI 88:25:08, model 0, revision 0 */
+	MP_FBNIC_XPCS_PMA_100G_ID = 0x46904000,
 };
 
 struct dw_xpcs_info {



