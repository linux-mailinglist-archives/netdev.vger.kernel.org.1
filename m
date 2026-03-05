Return-Path: <netdev+bounces-264279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC1qI2teqWlc6QAAu9opvQ
	(envelope-from <netdev+bounces-264279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:43:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69720FE75
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E148303E4BF
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4037D121;
	Thu,  5 Mar 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCbUk/MZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FE313545
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707304; cv=none; b=Y+QtsZv5hcE0/hwjFTUfeOAA7C2g+0usc3lgGpRU+bkcJHj+RAeRsweY+oeNdFGx45XP5gtv2pqo6aEqgtfP3DEva6pvZTDCBSJ+r2tMppcyUMvAVY9hHjWlnKEuG9Cob6py/jcG6bsQ0ySLYD/oHOu13TrONsGw9C31kv0r4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707304; c=relaxed/simple;
	bh=BiD0vSs1uRo+SuuIvS70kuwMhR7WLva1VsuKsB/4qSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q/BtJUFuy9BhnpM+OOAm3cV8PenXAal0arbP2CfCnTz3wIMeVCyX036Lfai6EHcrMuw4JR2OClse4fr8ldXSchz7hi6H6fik2bH52ss/htMMvUGEnsN6tvEU4qqUR/ohXgYaJ/CjDx39IUPppXwtlLYbZUp04H8Xa3Ey5iV2oLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCbUk/MZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f454be5bso81315165e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772707301; x=1773312101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy5K6i+BQ/ZCb+F1ScR3BTCuEFkunym54py6/4zT4Xk=;
        b=NCbUk/MZmmRaF8mVgQmXzixLdQBR4za+ml6fKEDGr9kkgjeJnVLnba59H+j92/vQZB
         OQ2CKeamnceNMz+CZotZ3kEaa7RzoWQrF1mcmAQML0mjrza1WdABwWeLl2VIR5p6KCa1
         AwCVaY5qDOEBxw0AjvbRIPlJ8JWN3AfZ2ZOFBLcnEiXW15Yg+c/nJ7eaBvpXg1gOXvfg
         XIhWbkfeVlyaCESMAIENewbx1EgfqdXOp61i47WPCfbJvYUMZuSv8ExxPVUm2YXvjdUu
         jeP6IgCaOL7iwMmAq8sCOc7DLJSUmUx7LvGrY0cflIhPbftcXbLTy+zvaLb85Er91BYY
         UFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707301; x=1773312101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy5K6i+BQ/ZCb+F1ScR3BTCuEFkunym54py6/4zT4Xk=;
        b=lGSbhMsJu6IEA8QN1m0kQ0VE7nYe1yqKdSb3Dx8raP0foKMP3lRtoRPKj2iOs5csET
         HhhhKN6K7N9TgjOF1mxMkeYabpM/cS+D9NRAb0/g6qzIiv1mjbZqLF9wVmspvSj5b43q
         gllkXmxl0IxNfK96fKVFvVuwqNYL+EBQ1cBBddGxkumbrzr7BMdyitYHwDLcCmw+YFDL
         +iYWppfj9EO4jBLECqR6yXvo2yWPAUIJYdwUxnSXa6i/oQZcD6kBqfozDwhfvL511OPR
         LswChikPBy7P4LXAL3rwKYUutwgvkyuTYKuP6sF+2gkSTcglfOcahMz6kixGDfofq4f0
         nI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE6cmjjZea4NfwEnPsbS/t6ghbs9bmGmcahUib9snlsgVhNw9Lbqk9vZjEmqOAUBzFpnR3SJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcNrsDwDK80l+z1meATTaj9RwYzAo69Gpcd2vcmNJkdxswYbA
	QJteoP77qVSV0ebw7qh8IFbUX4TuWtbVe04DlYUudmrJAW6A3DIRcRHS
X-Gm-Gg: ATEYQzxxyeCHmHNZEPu3u25D3Ki/0yNl8vKVS5KVSV5tzkDv23tszBwicKBg8vqOECn
	nBYrsNW66pHUdB0NPCU9cNlepe2XwoI89M9BCoYRFNS3rHTAdzpN60m+HlBTDgFqTuKrEzUDpis
	EcnYBHqhbUr1Ro8JaQFYBa3gqR+90DRdQNYMWNXD3Rtv5BYdCV4EXGPHf/ZRTxmDXGAS1Zq/paI
	VUxcdjKyknepO5vue3EHB0MKBhhoyMSVk4PYIcyyhgyMov/IoYJ6u1X8XCYhPChgqdb+4wNbhyM
	NMeO2NUGO4RNVfC4YElnuNKycrcnStjvo6l0IhKRea0oyQSXhjqkULRtAii3nESLQgdXZHBpkXJ
	Gcm6yr01fwvmW7Xg/QWvwwVKwWWfQlXBTtKW8Gt5dLEjf80KFO/Dl4RioiY0pCP8VUOU0GmIRzJ
	oUVmPI4VkoIAZ/sWZk9kOFYDf2scvLvmT6RJpJvLE9Ki8EFqV7ykr4ZAeFNikPi0pYBqGjeUjEA
	FJ1kkhqMTSD
X-Received: by 2002:a05:600c:1d21:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4851ee7b570mr29539135e9.4.1772707300639;
        Thu, 05 Mar 2026 02:41:40 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm34322545f8f.18.2026.03.05.02.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:41:40 -0800 (PST)
From: david.laight.linux@gmail.com
To: Johannes Zink <j.zink@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next 1/1] net: stmac: actually error requests to change the auxiliary snapshot capture channel
Date: Thu,  5 Mar 2026 10:41:33 +0000
Message-Id: <20260305104133.3101-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E69720FE75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264279-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,foss.st.com,bootlin.com,lunn.ch,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

Commit 2ddd05d1d5ed ("net: stmmac: do not silently change auxiliary snapshot capture channel")
added code that attempted to return -EBUSY to a PTP_CLK_REQ_EXTTS
request whan a snapshot was already enabled.
However it tested bits in 'acr_value' after they had been masked off
so the check would never return an error.

Change the code so that the test actually works.
Note that when the commit message says:
    Previously in case of a PTP_CLK_REQ_EXTTS request, previously active
    auxiliary snapshot capture channels were silently dropped and the new
    channel was activated.
this only refers to two commits earlier (a few minutes earlier).
Prior to that only a single fixed snapshot channel could be enabled.

Note that the check will reject requests to re-enable the currently
enabled channel.
Plausibly the best fix is just to delete the check completely.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Found by a test for FIELD_GET() returning 'constant zero' from a
non-constant 'reg' value.

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3e30172fa129..aa17335a2031 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -222,19 +222,16 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
 	}
-	case PTP_CLK_REQ_EXTTS: {
-		u8 channel;
-
+	case PTP_CLK_REQ_EXTTS:
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
-		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
-		acr_value &= ~PTP_ACR_MASK;
 
 		if (on) {
-			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
+			u32 enabled_snapshots = FIELD_GET(PTP_ACR_MASK, acr_value);
+			if (enabled_snapshots) {
 				netdev_err(priv->dev,
 					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
-					rq->extts.index, channel);
+					rq->extts.index, ilog2(enabled_snapshots));
 				mutex_unlock(&priv->aux_ts_lock);
 				return -EBUSY;
 			}
@@ -245,6 +242,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
 		} else {
+			acr_value &= ~PTP_ACR_MASK;
 			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
@@ -256,7 +254,6 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
 		break;
-	}
 
 	default:
 		break;
-- 
2.39.5


