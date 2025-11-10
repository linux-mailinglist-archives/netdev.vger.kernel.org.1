Return-Path: <netdev+bounces-237258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08EDC47F65
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F034A59BD
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B02749CE;
	Mon, 10 Nov 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/giH2UQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA60266584
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790501; cv=none; b=uPddLVDR5MX9llDhLoVV5FF4T8/cZ9XfWkkuNb6MEGiILlopsigCtvJUjowRlE+pzk1B5nJgMyIV1XfyY+u8oFAx7tiK2HAbHWm7I3lCMSsFg0MYd4INWQ/VDwf12M8iOCxw1DmQGhtLhX2DxxPXxpbFsTHkG6eQz+I0MRryjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790501; c=relaxed/simple;
	bh=jg86UAZlbo0kva6wH/gdGGi5OzEg2qpxgD1ZU1Q6wS4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4t1BqqDJavsy9/a5zuyzQpAXTZInjoGShkR3Wnnjo8jiHdGXtUrc+/6RLROHO9ADOzKXQV7ZyGjoaOY3uSb2ZISCgn02MirMVt19MDz6hPYuavRab7nUf5INAebJ7hZ8oEh9GSzGxO0KdMB/6k9kg7nKcIt9p3JDANSTmYO9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/giH2UQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298144fb9bcso11113865ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790496; x=1763395296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKHAc934kvSRFqWHGkEjU76SDQjUz1tgAFmDQdrl0ZY=;
        b=U/giH2UQCNiSVwMXKuXtCAlQXcsVakJV+lVXBKnInvKpOA+OIGh4a3zPVH4Xd5rhA2
         NWgOpKCDNiyoua/xrLgdXeUeNL+tsqFXuOKaFbJn6Vj6n+Gab1JjoCdavGViE1xfINdU
         mP27iueXUjdgII99EC3ekZCxxrRm1Xo4KXcb9pmoWLtBWMOoEeFJ15qXq+lxcic/II7F
         vvRbpnE8EvJVDgNZjfH+gnfi+QKKT78Oj82/sl+fzZe1urSuI2yxVdQVKLGGFlZr3ICE
         i2m78UqvYITBxFdQ7JuwkY8yAPAK2AWWjNWYU3BX24sS5D4+3KX/chYKamak0nmJh9SF
         g25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790496; x=1763395296;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKHAc934kvSRFqWHGkEjU76SDQjUz1tgAFmDQdrl0ZY=;
        b=EBLdeBA1uvZyBrH8xSuvzt2OwkPJ/8JzKaBg61MGyxhsROGzE6IEaGMsOrwj6QqnJj
         CntWnVcQMOY22Hb8cfCNP9XwIYY6Y8bDffHLA6fWqnSHoPNGxIrqdGIgUA+Ll7rHF+kb
         JTYHNaQRTYkkiYOz1arKh+hFGf8fHzQGNjJlreTMM2qRIMQrAI8ZxtR02Pyg2nx5c+wm
         9v01algyDzYR2ahKseQrjU5vfKyMe86Pde0Wvwnlm+onYMIUqL75D4NDmu/rMQ4ZAONQ
         VLjmafsBd8VUmCYDi4KlZEpCn13AJnJD9oTZQX7JGxr9B1e2g+DJYhGFKKC8dLwtWUum
         lV5g==
X-Gm-Message-State: AOJu0YxXaUQO9eKvJDb28UR2hoK9tSmYege2QMDW1/iKR/DPMIuQ1VsW
	6UPYxt5Uc2nlCdDtf2RTu3qrsiW+t4glQbP45qgXGKX6PripADvjvZxLSV5EFg==
X-Gm-Gg: ASbGncvuPikn2zu+rzDWk4jGabescumlRMnabNgQq2zwzZfFcnDLSKIBNk0A6FEB1TS
	qE9J+hHjVbA8/TbdkNbmy79aE7/sq5NR/GRMmhoSGYYDOiyYG5mq1sWxwVy7wzcUFLGdAck6EGZ
	lcutcWX2EsZ4XjOKSAwjyf8sqiVGxKvDKziJYlMNyltozqM9/C0ROU9rVR+4p1U6x63kg4FbKdj
	fpPQYmJ4FdqRdr3614AoDvYZl+tddmM/gKs3yghKyW9/J2sCjv0CRCWx59iXQ5onj54AEVEaqY0
	DXj5EJFhz7RFJ+lGrTsR2JzCaZMFep71SUyY8sqmpMsvJIchr9c+LdRPCjIY3lQI2MGuxPOLQq6
	uiiLAW8xT9Mah2PlTNXMdrcVth0Es8UvvBTG0/KS0swZxlXYRNiog0R7cbrPm2cyTvT/u47odwU
	1+MR4cd0CU9nmbIwSk8+KVyOD6PK5YL/XApw==
X-Google-Smtp-Source: AGHT+IGndO4UJbAL8FPXEYgdHHhMilHqRnp8wwVPyjpue3tM9khiYrsUYP2hcKc2/d4S6tlOJX48nA==
X-Received: by 2002:a17:903:1ac6:b0:272:c95c:866 with SMTP id d9443c01a7336-297e565d953mr100089485ad.20.1762790495373;
        Mon, 10 Nov 2025 08:01:35 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ffsm150111705ad.21.2025.11.10.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:34 -0800 (PST)
Subject: [net-next PATCH v3 05/10] net: pcs: xpcs: Add support for FBNIC 25G,
 50G, 100G PMA
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:01:33 -0800
Message-ID: 
 <176279049361.2130772.7535770079337105870.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic driver is planning to make use of the XPCS driver to enable
support for PCS and better integration with phylink. To do this though we
will need to enable several workarounds since the PMA/PMD interface for
fbnic is likely to be unique since it is a mix of two different vendor
products with a unique wrapper around the IP.

As such I have generated a PHY identifier based on IEEE 802.3-2022
22.2.4.3.1 using the OUI belonging to Meta Platforms and used with our
NICs. Using this we will provide it as the PHY ID via the SW based MDIO
interface so that the fbnic device can be identified and necessary
workarounds enabled in the XPCS driver.

As an initial workaround this change adds an exception so that soft_reset
is not set when the driver is initially bound to the PCS.

In addition I have added logic to integrate the PMA link state into the
link state for the PCS. With this we can avoid the link coming up too soon
on the FBNIC PHY and as a result we can avoid link flaps.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c   |   23 +++++++++++++++++++++--
 include/linux/pcs/pcs-xpcs.h |    2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8b5b5b63b74b..69a6c03fd9e7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -597,7 +597,25 @@ static int xpcs_c45_read_pcs_speed(struct dw_xpcs *xpcs,
 static int xpcs_resolve_pma(struct dw_xpcs *xpcs,
 			    struct phylink_link_state *state)
 {
-	int err = 0;
+	int pma_stat1, err = 0;
+
+	/* The Meta Platforms FBNIC PMD will go into a training state for
+	 * about 4 seconds when the link first comes up. During this time the
+	 * PCS link will bounce. To avoid reporting link up too soon we include
+	 * the PMA/PMD state provided by the driver.
+	 */
+	if (xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID) {
+		pma_stat1 = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_STAT1);
+		if (pma_stat1 < 0) {
+			state->link = false;
+			return pma_stat1;
+		}
+
+		if (!(pma_stat1 & MDIO_STAT1_LSTATUS)) {
+			state->link = false;
+			return 0;
+		}
+	}
 
 	state->pause = MLO_PAUSE_TX | MLO_PAUSE_RX;
 	state->duplex = DUPLEX_FULL;
@@ -1591,7 +1609,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 
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



