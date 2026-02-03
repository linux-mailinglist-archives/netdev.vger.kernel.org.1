Return-Path: <netdev+bounces-256368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDUeL0MtgmlFQAMAu9opvQ
	(envelope-from <netdev+bounces-256368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:15:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D39DDC9BF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0953304A07A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE662798ED;
	Tue,  3 Feb 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYb3jnGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC13D646F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138912; cv=none; b=ChZffAFw5ZdbCjA9lSPv/cm+U1YxoPKZTx0EddB2Tl0STMba7HQqlAVbDfmaAOxht261gvQg8w5EiAHyQqlzWo7f4xnHzrfVQygR+LK6Oq4zZdEE2L1EATvT8nmRqXyOPwIxI/xtMqK5P/4iNmacCh7T6crGzl/ZkFs7fJofAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138912; c=relaxed/simple;
	bh=wY5gLEBdKCu10zTPiFjklZ3sRYW/DJSl0/z4N13a/iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozA9CKabT4FBlMViAeXq67Px9N/m2QsoDH169zJObMHYRYHixp19lKJNCcn1eOBPHovk7cFZToodVG49O+2PDTz6QQ6rc5ryY1dXqlK+4Y+pwR2Gd4kmb6IuRQ8yhqp9zdWuzsxj48RugIhcMohZmuHXXZ0fIV8/C6VdCFstvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYb3jnGy; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81e93c5961cso4875210b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138911; x=1770743711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGUSc9pyB8YlMmUCPEWlPuLgiaZvDHITFMXzeMkPLPU=;
        b=iYb3jnGy/7DV1+tKmaKjTY/Vz5E2Mg+2sAr+ZxHGrn4UcnnVs8tfQ7jwMyWy99GIUa
         FovFlZgh3iZ5I4lVRxOIjnXEl0JD3ds9dnfJTvYBh12J++9pgIaaeu8g9jqmwM1LXrDy
         vcI2JkHJ7myqn90fdoz9kavMdiqUkJfrUUL9lqdCHqThhf0d2I2yC9JtEzJzG8Xjx2h9
         bootczBaJY2S9QnPvhaLub/HTspJxEUMNcajnrCfBG/KgCctFgaluO/tNJEOEAQbfD32
         m77L4V5oqTXgBhBC8w5mCIL76yho2ylE8a0WBgeSthR9tqpyWsZXSN5YINzA/bxELCQF
         zUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138911; x=1770743711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGUSc9pyB8YlMmUCPEWlPuLgiaZvDHITFMXzeMkPLPU=;
        b=clP+PXObOItTIZd9r+fZThZtFtV4EEabG/YTmyex20j28Yvh/H7uGPzNrKL1jBEjBR
         gpHfKRgAvfjgWQ6sjUnrMRX9MDDu74C+FYd3EQxdA9t6iaii8LIJRQwPpgnjdqerGqtk
         4TCT9to6rA4hmBVQDrdVNu557etHEr3pSq2alVmp/UI7OlauPqUPkN+9C1c314bDIvk0
         95kuA/tb2rAPYby5ePrWOAPwk/0KGsVHaPjgIWJf7yGJn3eu6xqCy5YK8IQqB3KmyjTM
         LUPrIqNrhgqQQBqmAhnab0ekWKKUGr6CZKQTkeO0VJARwKIiNg1R+dJ6XnigdfyFKT06
         hgCg==
X-Gm-Message-State: AOJu0YwT+3xbDRSQiwVQtwQZ1ZE4xVwEuuSvWScYaeujc2wK5EavPiMh
	NHP4GQtaK1oL1+k7cyW/P08faIsCUXETA8tS2XODr9JllbW58ZiaNIAwZQzCOpmMEQw=
X-Gm-Gg: AZuq6aLZ5sslZaxBYFzIuVisoIp+MskGUDshUugJNI4OHfi/Fu5lIOPqPoKdKvvKq5X
	qZY57Typa1DQJwzLNkG236+MyQnqv52bPpHL2zFOGzGBOd/nHP3+6w9O3T5ZHz5LDXaHnVTpeUA
	0dmVWuu3AE1i2QHMQD4yKUCRgdmF1NDDbvNHQhmGdK+2oDKIvM05ZHgdmKaNNjvzLZBf4+xtWxz
	QIi3b4v35FYnAfxAyJdneTSFAN1TxqIV/NCdFmEWbGgX6yar7y+NfF5BS+M43iiu0GkMVqDTmb+
	HVHgFZtmiDZ+LvcG5DzR4PtQcfikZYpJEUNv3HBhvmyM2Qu4JC8heTtFos1VwCLSXo9FlTy7ybe
	DQR2Ru2GKssSMBghq4LFer85uuiCAG63tSO5jvU0S7qpGT+fafMrumw78uonTUNLGqINUmDPbrC
	UGZYYRejbpciSveIIFg8XqDnW3+YXve/occ5WvSgwaaiHIMrx/CYVNB6sintoFGXNPfTt1YQrVq
	L498RgQY7rl
X-Received: by 2002:a05:6a00:1143:b0:7ff:d378:98f with SMTP id d2e1a72fcca58-8241c4c4a57mr118370b3a.37.1770138910953;
        Tue, 03 Feb 2026 09:15:10 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-823cdf6fa26sm11075817b3a.58.2026.02.03.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:15:10 -0800 (PST)
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
Subject: [PATCH net-next 1/3] net: dsa: yt921x: Refactor port error message
Date: Wed,  4 Feb 2026 01:12:41 +0800
Message-ID: <20260203171305.95085-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203171305.95085-1-mmyangfl@gmail.com>
References: <20260203171305.95085-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256368-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 3D39DDC9BF
X-Rspamd-Action: no action

Sometimes we might get error from the underlying bus, but the return
type of the function is void, so an error message is desired. There are
many instances of the same pattern, refactor it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 98e8915dd6c2..ce2878ef9b24 100644
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
@@ -721,8 +724,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_jumbo;
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
+		print_port_err(dev, port, res, "read stats for");
 	return res;
 }
 
@@ -1102,8 +1104,7 @@ yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
-			port, res);
+		print_port_err(dev, port, res, "unmirror");
 }
 
 static int
@@ -1690,8 +1691,7 @@ static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "clear FDB for",
-			port, res);
+		print_port_err(dev, port, res, "clear FDB for");
 }
 
 static int
@@ -2266,8 +2266,7 @@ yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unbridge",
-			port, res);
+		print_port_err(dev, port, res, "unbridge");
 }
 
 static int
@@ -2399,8 +2398,7 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "set STP state for",
-			port, res);
+		print_port_err(dev, port, res, "set STP state for");
 }
 
 static int __maybe_unused
@@ -2738,8 +2736,7 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring down");
 }
 
 static void
@@ -2759,8 +2756,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring up");
 
 	schedule_delayed_work(&priv->ports[port].mib_read, 0);
 }
@@ -2779,8 +2775,7 @@ yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "config",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "config");
 }
 
 static void
-- 
2.51.0


