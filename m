Return-Path: <netdev+bounces-255324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQhLb9mfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D909EC040A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07C57300F6A9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA02DB7AD;
	Sat, 31 Jan 2026 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6aWqjbP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF51EBFF7
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825964; cv=none; b=ADFriEp6yg8q1Oo32zhpaqU4vU+gm125V3SzUr+9SMECatun9fOBekou86zXxhJjsfKfSvcRaNBbcC4Pj2L8zzUIVHArJGwDn6mK8UR9dspEv8RbRL5+/qzhKbD3bJbpbWJg6pfWT2kcKvUZflQqFuLOm6YCnJGfAQhV7+1snZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825964; c=relaxed/simple;
	bh=JNfZjVJy3Gbq22U1MyVQxdU67pv8yfXpNgGIJG63XRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8T97eG9OqLujU0JWJCCxMAHI7dR66d/p3TVxtI9+Jt09IZ95flLP4AWC1v3KolXbv7YHLrJoMAB2GIDNFAXdjqaNVWKlzRz9G4uFuH0aPH7jMaOBXyfbEc7MLM1vva2CSRL/G0T42Kz9kEZc8uY2hC+/dbye5kD60M0DtS3zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6aWqjbP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7786d7895so19641465ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825963; x=1770430763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pMp86pItBZRraa325LpN+qOAaq2YtbzQhkPFaWHWDc=;
        b=m6aWqjbPVASqzq2K4e0eO7hOPVUs7bwA5S37T7VXJ5gHJp3FvCaGqC4DJ3Q2KMTPWD
         kuw3Ixqu7WmcQC9/8b+aQv8jEB+pqSTBOJeb83WHYxx6rLfLHkwIuhdcIM9SjUju2gCP
         EvxOAuK/G7V6tYf2lgMbjl7vdHbPROgtt10udZqjqyhUvr9/jj8o2zaWHJNlN0f69vmi
         31g7hCQiHlVky63lbghf8hANiEN5ypL2QC++hiYK6srXiSwvico5DiECkcLYHr9C3JBA
         ha3Ii2iaglgV+zjWoPsMnp5gvf7rv+zwiwu8uyGYnJdAVd7/r5pmgVk7KGzXyMDJ1E1I
         IlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825963; x=1770430763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pMp86pItBZRraa325LpN+qOAaq2YtbzQhkPFaWHWDc=;
        b=H2UhFqI15kbxZWKog95k7AIWUT7EY3M6Kx8W9uGWQAE9hnE1k0qso3MDh+qq2Otvwr
         HCWcK4ITD5dvSM1mPlQQQEQPVe3KT6+bNkvB4JZHr+VixqbIzvBIc9drZZdjz9AkNZcW
         Hic63w0X+7qd1gNqTZlGW7e31BUPfL5uIyGIcZfJVXcmaOOKmHBN3Eh/DeECMeyfEpfb
         oE3FOuOsc+OPPM9f0Lm/S8Bt0TEHZwsPVNM7Ytg4i9Dy9JswqzAeI5enQpvh9h/1Ms8b
         eTe5a5PHPxBHlw3YROjXQgYL9oIiku9Z9P+PcasPacmZMjszrfR7UhW+hP7RxVSdgWn0
         1DsQ==
X-Gm-Message-State: AOJu0YwP1nWffk19Ze9aeAyjFxhibyfZKz+imn2EqbobYO9eDraRxEOQ
	eaCsmRUOBFvpPmGLflo9LVHLPzXNWM3MGBDtnh5J79hEkBXWzr4AkWSue66NTw==
X-Gm-Gg: AZuq6aIozl0MhH9JqEPz48nSUcX4+T+/SjZEo8BZPtMrv3wBFqYUW6WORAHkCYpnA4T
	2fxggHdDAu2cDX/85TRwJtoQqu1Iqiot0q85LeiVNnVIKVByNNDYDMU/eTfVS7aYwgvngKqIMOE
	FgHBVDgY4EpEwR/Jpa7k3pdd9+pgk9pAdmoA9rpF7q/8MGv94p+7cqTZk5Caas3C4JOHO+FenkU
	HnkGNghAu58lT2Tr6l0KSdZ3QPn/7W2zMB1qdJ8PxaMCB/ePVCHggc3vJPwzAetqXn08ctHOrjO
	LU1+2YEKhKheHeJfz4AjClsr5LYXxrCUcr10d2eDZqNd2CPKjmGIuz7IVu7pWLDeFZAP4PzTiqY
	KJLdZ75GHfMGmaXJZ6Me96qb2MehkgmH07z1lbt7HXemPWlryM/HQzVbDcxMLZNNxwn4VnmrUy/
	CgCZCIDYKm9eSm5L9WJKEjIaBnCfdVi/K/b60=
X-Received: by 2002:a17:903:38c8:b0:2a7:b039:4b52 with SMTP id d9443c01a7336-2a8d9591c81mr45042115ad.1.1769825962631;
        Fri, 30 Jan 2026 18:19:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 4/5] net: dsa: yt921x: Refactor yt921x_chip_setup()
Date: Sat, 31 Jan 2026 10:18:50 +0800
Message-ID: <20260131021854.3405036-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255324-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D909EC040A
X-Rspamd-Action: no action

yt921x_chip_setup() is already pretty long, and is going to become
longer. Split it into parts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index c2998b6ae535..3128fe97b50f 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2903,7 +2903,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 	return 0;
 }
 
-static int yt921x_chip_setup(struct yt921x_priv *priv)
+static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
@@ -2921,16 +2921,6 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	/* Enable and clear MIB */
-	res = yt921x_reg_set_bits(priv, YT921X_FUNC, YT921X_FUNC_MIB);
-	if (res)
-		return res;
-
-	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
-	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
-	if (res)
-		return res;
-
 	/* Setup software switch */
 	ctrl = YT921X_CPU_COPY_TO_EXT_CPU;
 	res = yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
@@ -2983,6 +2973,29 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	return 0;
+}
+
+static int yt921x_chip_setup(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT921X_FUNC_MIB;
+	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_chip_setup_dsa(priv);
+	if (res)
+		return res;
+
+	/* Clear MIB */
+	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
+	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
+	if (res)
+		return res;
+
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
-- 
2.51.0


