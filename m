Return-Path: <netdev+bounces-253659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGToDm0eeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A788EE58
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AE65300D986
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A52D94BF;
	Tue, 27 Jan 2026 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOYJxOhF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DE2D7DD2
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479758; cv=none; b=UDCHGGbgW1IATXjyQmG8WgIzKTAi+nuQyJAumSyudJS8UHxUJNVAat7y92KA1Wz+9NE1ntH+zLCVbIrDS6JVTlZ9rkaJRk9FzJleOJRW45zz3i5c8nn2L4rfyWqiMeJfDEx8zShMCfyAlt4nGr4eB6eZMF7c0gWtJFReVd0phzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479758; c=relaxed/simple;
	bh=MBs1LMoPjEjYdhkq4Ew/Rs+s+0tFbyUFwqgDEo7mlcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNqd19GR0Vw7MIpkMuTkdd9VL7AWcXYsZ/JP7LUf/YepG/RCCGIgIiZtdQ+SBJh6GAnvK7zYwZLHwvfP5ohfZBSFCwIE1T5wzFUQemHIHuD59ooPUad29ELnf+89iSEQCGrNKxYIUKmMh0kiAAdv1FfGgCgZn0hXl/1KR0xPpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOYJxOhF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso1778330a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479756; x=1770084556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB/9v+5HeIAl6n8QhVl8YEDoGPmeGe9LLib+gDQtwSk=;
        b=mOYJxOhFQukMIfQCtHXRUZzvjtCVg3mTjLxOVwu07sdwNhKeTQZiCfI4qVCYeSQt7P
         FRduQLHceAshXZRuxy/MmgJGI2zkiwjUBm1uGU2U6Pdcsee8y3sn2KuRcdRD5DbgizvE
         3gs1wPRfxHAmfbYHaa3ScoMV5DNDQX0L1+6oSfiiZo8jsCISvlOhMts5TRsHu/3yZtCB
         oLClP3tconKyB7tf7RZxcnafwdMa8KPJ6TKOuWzqj4cYmzgGg8GOQk4rqEDdxIQbapmg
         meD1zQ+/dmZQO8XMHx/M27KRIte5xDsspDfiCkS8b8CbloL9hB44piL0nDLCvBKdh2w8
         YibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479756; x=1770084556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AB/9v+5HeIAl6n8QhVl8YEDoGPmeGe9LLib+gDQtwSk=;
        b=D4RitIBNZVfejVG85Pbl00UG73bnbvNoNm5i/ixiN2KpYmPY572ks3pZaQeWySKM3g
         +HQG+MvJdNyDm3txLlgr7zMWT7yE5m/PlZcjA0KroNzqCgoLVc6VJOTWUNFSKD1pObMD
         AKNc1cGc7OqbGFUTwK+lkb2UKw/fdU7yIZf1GGBh2WxSxNAsd3ZnCws6Eq1Nh8fHDRiR
         cGcc6PrmvofcQ8qb5e+hFnDCqqUWfoJ8N4U3AjcHm+F+k00YpexMbqKReRmvDGuq13Ta
         9ByikHe5KeYDOkKtHS1Nrm3fr3fSfk8UsmMAitnlXinVIxekqbRUui7p6phFMv/Aoi3S
         Q8/Q==
X-Gm-Message-State: AOJu0YxQGhNIPQwcF7AyftrucCe1tY/51N0z2xmFVfeOfUL4vVCPKSXf
	FNstQN2WRhXvaYTXMSts2YtNiQXteydtkiKnnXFEAw8EgyaK1SENkuVNXAyI6A==
X-Gm-Gg: AZuq6aJ8bvBwa/0+A+o9URT7BO2aPQRX5jHzQ/QSeUPtGaEIrkDkxNbq4l8fWFjVyX2
	xGXJk7+cJB8/OV1bReqVm1TFaatCnuMvZ3XYZwtx2aIGLS7i8931XiVPunLl3/wISVATwhWdhio
	oXlTnZiieNYuUoQ4CEHH2A1auGbs5dhWYX7paRfHoh8NWOZsIvcaUr0qEJGyPCwi04vxhboPFHu
	T+phqD0yY7faNEXkwp6xl6B9UyGORa1lKvBy46LtH3eB646109dBghr6/Np4NAyhmHFZzoVOhRL
	2xlKZmQMX3ds9GH6Ln98bRqXNPI6GQ+JaBKqTxQMf//62NEvAtHQ+JIU+4GuzJTpxucKYTkAe+H
	lpJQIAbwH9PT8UEHuTMtNRG4768z88leAM8R7aKmZ0V6knwCTXRDbYyvxpoPREQi/VIgQrC2vvi
	5HXCdyikYj1LDBcox17C877BeP8EowznpsiayGEheOeyq5eFyjk//9wA==
X-Received: by 2002:a17:90a:d448:b0:341:134:a962 with SMTP id 98e67ed59e1d1-353fed88d1bmr221870a91.28.1769479755915;
        Mon, 26 Jan 2026 18:09:15 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f613fc36sm693540a91.10.2026.01.26.18.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:09:15 -0800 (PST)
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
Subject: [PATCH net-next v4 3/4] net: dsa: yt921x: Refactor yt921x_chip_setup()
Date: Tue, 27 Jan 2026 10:08:00 +0800
Message-ID: <20260127020847.1482724-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127020847.1482724-1-mmyangfl@gmail.com>
References: <20260127020847.1482724-1-mmyangfl@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253659-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3A788EE58
X-Rspamd-Action: no action

yt921x_chip_setup() is already pretty long, and is going to become
longer. Split it into parts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 880e3b5966f8..9ac0e4e236c6 100644
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


