Return-Path: <netdev+bounces-292827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVUAnWZGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 962EA5F737A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3602F30464BC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229440313F;
	Thu, 28 May 2026 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQjGXdiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D634D3B9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996960; cv=none; b=K4ZcAH8kcKOnTSctSu+eurpfX+nnl3snduo1EO/e2Jo+zr1GZqjs2pPSUD6o/7jPLhnpHBWLl9BPCUqGI2IiVipGXUaqHxhp33YEMSsQN45Yvl7qQGtzUcVe99FxETw6X3aWoa9xQsWidsVRc5UPyh3FCP0IQ+HMGMiFOtPIFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996960; c=relaxed/simple;
	bh=oAkF4IXnjMiosmEc9YycpmWPvCaagq8LW8Ceu8nAr60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYJZjUBLHh/L4g8iqo/dNC8arnX2MbWZmfRYJHmDfbkvDYwb0LXgnFdpasPUOIJfOejDln0CGWGVqQ0lC4YhSX4aA0ftfyxltBBzqaos2Tn7608uSEkbs155LovLHtJtBpqtIBfAaDo8OkTD+DDcAbENM4Q5Tci3vMk5pwXC/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQjGXdiL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903974854dso65581845e9.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996958; x=1780601758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dozMnH/MzCaOgkZHqZM5eTN7b80tupvfNNp/Xk7R7M=;
        b=ZQjGXdiLMNR7QN0LIDlsET1lT5N7xzgfS46k5cPQV23SIsfmiJX06u6oV2SL466U1z
         f3INUtU6Br27tlMWh1GmfPdPGukLPrgtOd/z0kqTcOMBrQP1uLy0ORHYeM/kyaR36/0O
         bL3kdu9xfDjoVmJ5xIGz1RkYKvVp3NcnXrbjDW5t6513jfFcfvPng146JVZOJhSyTAt0
         7ZXpMmT0nb8RvRxZW8FObkBLOhHtjsMav5QblnKjW2r0j1nCvYDAfy6qcAmXoH/5Tofk
         yCvtygYQSL+Li7xa4pLLhNW1JvYBBy8rcTWDVOpNQ9jj3+7uXwIwPk4dgGYvXtaWJHha
         IkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996958; x=1780601758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dozMnH/MzCaOgkZHqZM5eTN7b80tupvfNNp/Xk7R7M=;
        b=fz6WgzFsoVp/iL+QQD5Jio+UAbX7L7A5IfK8ttqgfo35OHjTPcUxJOI8N7G5qdfKAs
         SphGtRXY+eTmMMBFnNutJclrylB2VNfmqSV4j75t047xUfyPTlXZTOGNwvxZrUVsbgap
         M8ruee8h1CBDcfsv1DM4TRA8P7Sbg+wtUnaFMLUOsuO9ImldD8pDiPfQA/HhcKt43WW6
         Agw+6JEd/jKsO3FAIq1uQdk8x4prtJVFaov/LaJLolmt//ai7UVpKfzHdfwBrDJQlzkQ
         /bNB5z/MuadsBg39DBeCMhCuEef3QUOUPCTsIsDlXePT5KQfOGheFCyWCqCiV2tksTxd
         nzdg==
X-Forwarded-Encrypted: i=1; AFNElJ9f0fla1sUvAdXumvIM3DsDUijZV8wwpGTHB+vhBAH1fr7ti2FxBoE1t0KDZNKUETbxOE3AhUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyV4oO6XePwpUcahN8NzvshYmGiXzTmLyooZBmSq5o7VRTsyDD
	ZM6Qhs6GrAQuJ5Ji4pPwFUiimRbLuAv6enJcckMOxOgCRzX/JT8YcCmO
X-Gm-Gg: Acq92OFX8AEivFBBgqTJenPBLjh+A1UBgSF4G17dMTcvq1Y1TKMDkrr9+hLU8NSoLCd
	FTQSTh/SM8Q3KKChbQHcnm8uYh4+CFhdNDtGKDdRtnWZckHvrtCfj5j07fGmfQ1k5XW1FwGLNI9
	3JL6pBHvygUEuaLgfLKY5RBWKQoWOsNrLN/xOKAMFgX6zcXAhmjH17MSAm28T1LX5Tgyc1f4y17
	pb+XQ2jN37I2Nn8uOvoE/wfa/q5rxeZ+ed577QMolqNpTCCtI0F5rfiFlMt37Z0I9bTeAkATrGs
	7pDGmLNNw9BCnSxx7aPn/tH0pSQvjTV+jbRFEf5ytA3qCKg2drvLaNZwUlD2w9SxYf4RuFH55Y5
	WQDuNwFK2ioLtaAjtLr1QiQDR3H6nR2JDHhUZex+NEc0B1rEuT4vogxiCUu1LmvTR9QTryVGG/U
	XN42rIe1ZRjf+PGOeL+GjeWMd9UTVh0C7NEspgmryNwHMacztmqn4E9pf6Eg9Y66oB4XIADaczh
	OEqRRw=
X-Received: by 2002:a05:6000:2d12:b0:45e:93b2:37bb with SMTP id ffacd0b85a97d-45ef029bf0cmr573830f8f.6.1779996957682;
        Thu, 28 May 2026 12:35:57 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eec5eba06sm4220471f8f.22.2026.05.28.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:35:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: phy: as21xxx: force C45 OPs for AUTONEG
Date: Thu, 28 May 2026 21:35:43 +0200
Message-ID: <20260528193545.11160-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528193545.11160-1-ansuelsmth@gmail.com>
References: <20260528193545.11160-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292827-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 962EA5F737A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With further testing with 2.5G NIC, it was discovered that the PHY
require the C45 OPs to configure and restart ANEG or speed higher than
1G doesn't function correctly.

To force C45 OPs with generic PHY function, clear the C22 bit from
devices_in_package bitmask.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 97ca37c6929f..a6686b4908c6 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Even if PHY declare support for Clause 22 register,
+	 * Clause 45 register should be used for ANEG configuration
+	 * and restart. Clear the C22 bit for devices_in_package to
+	 * force C45 generic OPs in generic PHY ANGE OPs.
+	 */
+	phydev->c45_ids.devices_in_package &= ~BIT(0);
+
 	ret = aeon_ipc_sync_parity(phydev, priv);
 	if (ret)
 		return ret;
-- 
2.53.0


