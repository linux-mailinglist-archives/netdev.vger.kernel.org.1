Return-Path: <netdev+bounces-254660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F9hNSgge2lPBgIAu9opvQ
	(envelope-from <netdev+bounces-254660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:54:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA3ADCA5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978F6300A3B2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613837E2F6;
	Thu, 29 Jan 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGOxAHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944437E2E9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676806; cv=none; b=R1VvOhMBoIgBTdZojxuvgH+x90yQ7ahv3Io/4drmr9sIlfYVnx2uRQv72Ky82QRlGPuudpKa47lAIg95UZUarVndmXAgtxuzNdT3VpI/pKAZmjuObiPOOogZ2MOr+uFmmAgEDDgNFTZbiK15BC/dqVI1751mFV6Ghw5BAytH7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676806; c=relaxed/simple;
	bh=9cHg4yudx0KYot1AXmxgLTYZE6CP3WU8JWGdgL+x0d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gScjmGtoSiSB0PzphjqiT1UBukc86tJ2CupAeDaCmpXROe1O5ywQofyd6meRWGEZn53bj1mHNnCvUxEze63vx6DmRgzJdd+29ZXHdKXef0UYx2H4Oo/g2fsKBGgJKmN+wf4sCGGZ0Yaacesm0RrM3rB/4CMFxPYWi+y1ZIxZXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUGOxAHo; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d52768ccso4560575ad.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676801; x=1770281601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XpMMUS1e/vYJVAQpO8ah+VrCXSORaptOSTTscCu+vs=;
        b=BUGOxAHohipQgMilGogatL46TtzHHjTj/p0uyXylRdsUN0ybP9m12vC9hp4UVPb8md
         Ezxjj/viH4Oq6R+Jw6ClxCHJvy7SZmGNjSNsfBwjB+HzV5JxKEzGjbafbQjNAsts7hu9
         dxMd7WcMMdjRex4lstMA4RYFCKOGZySu5BI9XERjkgIUDU9bXyuGELLQUyncmg4X1AKI
         LSX0SnxOyf9hcs+TPOtKY1aEfyL3bUMb9tWrtq/V629eFYoygu1QiJm5sCwgfkKW0ui1
         VihMncM0/W1EatZ7jyYMC87p3GIiVD/12TBW/76hVeq46Pr7eF9WsHumy3Ygo7LVTOou
         BlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676801; x=1770281601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XpMMUS1e/vYJVAQpO8ah+VrCXSORaptOSTTscCu+vs=;
        b=YGXZvn38cgFaPQ2Vm0z26tq3psCW8uww/Aqz2wfW79mW8NQkmSzRxzhtLf+0K+u2pJ
         dDkZhSa1sxqPmMkbQ3eKa+fv0ck7l0ZCbxqltjyQvZviF0FNCAZ5Q/Sbrg94SCt2IzGV
         6TdPhZf5URWBumI1Tn2S6EvX/mfrs6/3Xrrkhzb1VHXhqfcnqV5WA4471bI0OnsSKdbE
         kwL+SH2EfOQM2ogo/fpUmmR6j8OVrc+3PVridjQqWlOdxrCi3bgT2G7HWP+pB9Tn9ly7
         K2Z2x7pTdNuWB5jtR7SqBHNi2tIhhOAir5XcDmmMg5tojcom4d6eBwLeiFE8eI8x1JwL
         e8GA==
X-Gm-Message-State: AOJu0YxB69vj3TaUFWQiEVPWDRzR1bGka8gb8V0gi+Jsz1l5GEPSx8VD
	ta505r1j9X+ccuTycKsWS6zxN6nOKS0dI5aT+QEWSZzu4JbUSt9N5RkdrV6QraVKpuM=
X-Gm-Gg: AZuq6aKOpagu7QdsAPiqXDeqFHzRcVuiQj2wSq1VyRaXyq2kxqfNcv23HVOVrUXUvLJ
	dsBwxphf3HvyW1H/9fNXUnIRS/kqzqExaS0WrCQX+umNrCd6nCvV3/NyoVQtQ9LOlqKFljl1/j3
	F0fFEwbV82Ihxt5SoFZC0IwMEhlsKpQ+daOABvZwQaIij6uW3iGxEuibIbpROZOpaXI1snzxqX+
	8T0GlfXvaiJUO06J0re7IJmv5MRC5FRl6Js0uIy49k2C+drrgwAGNB212u0tWv/MScDwfZU558F
	eT9mVNXTbGC9/6vi9ruozFm3Mjka7aYuToHq/+qwL4Y/690jo5jUIJUOJJSUBk0pOqr3D94i4TP
	dXyWZWHa+pfJYCSpDfiJjHCQzS85gq+CxDqvLGdFK0sUNjXF/rRF+wHnnnXkocDQVtMKtZ0VGn6
	EJocal4adsARklIsKf2605uF/nAyrrlR4XFwg=
X-Received: by 2002:a17:902:cf0d:b0:2a7:919c:34c6 with SMTP id d9443c01a7336-2a870ddea27mr77364185ad.38.1769676801431;
        Thu, 29 Jan 2026 00:53:21 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef50sm44651165ad.12.2026.01.29.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:53:21 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/4] net: dsa: yt921x: Refactor port error message
Date: Thu, 29 Jan 2026 16:51:33 +0800
Message-ID: <20260129085139.2767649-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129085139.2767649-1-mmyangfl@gmail.com>
References: <20260129085139.2767649-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254660-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5ECA3ADCA5
X-Rspamd-Action: no action

Sometimes we might get error codes from the underlying bus but the
return type of the method is void, so an error message is desired.
There're many instances of the same pattern, refactor it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 112c2a237d9c..1b66b07f45b2 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -185,6 +185,9 @@ struct yt921x_reg_mdio {
 #define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
 #define to_device(priv) ((priv)->ds.dev)
 
+#define print_port_err(dev, port, res, action) dev_err( \
+	(dev), "Failed to %s port %d: %i\n", (action), (port), (res))
+
 static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
 {
 	WARN_ON(!mutex_is_locked(&priv->reg_lock));
@@ -720,8 +723,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_jumbo;
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
+		print_port_err(dev, port, res, "read stats for");
 	return res;
 }
 
@@ -1101,8 +1103,7 @@ yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
-			port, res);
+		print_port_err(dev, port, res, "unmirror");
 }
 
 static int
@@ -1689,8 +1690,7 @@ static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "clear FDB for",
-			port, res);
+		print_port_err(dev, port, res, "clear FDB for");
 }
 
 static int
@@ -2265,8 +2265,7 @@ yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unbridge",
-			port, res);
+		print_port_err(dev, port, res, "unbridge");
 }
 
 static int
@@ -2398,8 +2397,7 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "set STP state for",
-			port, res);
+		print_port_err(dev, port, res, "set STP state for");
 }
 
 static int __maybe_unused
@@ -2737,8 +2735,7 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring down");
 }
 
 static void
@@ -2758,8 +2755,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring up");
 
 	schedule_delayed_work(&priv->ports[port].mib_read, 0);
 }
@@ -2778,8 +2774,7 @@ yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "config",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "config");
 }
 
 static void
-- 
2.51.0


