Return-Path: <netdev+bounces-260470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMEyEbKLnWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-260470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:29:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E3186493
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AC530FD37A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFF37C114;
	Tue, 24 Feb 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3KIvU2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7437C10E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932313; cv=none; b=S4bKpG3zk9c3JCKeo4Gcv9s6Nni33byhhNyQppTczTSeSuylnkJ+Zo9EvBXBrm/Cq2lA3TkyOKmgnIkfqfQhZx1iMhnGAt0gKpa26tbZIYRr2r7dG+8zMt9mg5OPveyBLL2zhYK2gFnHsT7MLYjdrwXVMrinLmGq+wWiDuVz/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932313; c=relaxed/simple;
	bh=AkHZPDs6rJZL/T5tRNU/xswESXxvBJny1xv8Fd9B9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgtnxo5xI3eJ7W7mUXW8sDsXuyXmn6ePBmfFgaA/P1ER3iaggh4TjXeU6PeWjRz1hVjag7kFUfkCyJ859nMvsvq0gAfPewRpwEwJLy75EKFJ67JT+CkUAkpFUOzKaLrwfiMZCpBxmGTD2J46Iq4vtk4Vt/4e+bQi4WRNXdKSUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3KIvU2o; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-824a3509a12so2877541b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771932311; x=1772537111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wGVfhGIFbdZYOY8RusNA+8qDyP+5sQzDVbWcUdCdH8=;
        b=e3KIvU2ospnLLMp2v9DSG7aJVj1p2HfRNA3P/yza2fTKod0qaiF+UJNHw1Blp7Qwy9
         yoLtUpwu/BfmfGkf3Oz13AzEsEsYskaB4md6i/vtVog1UVG+cHNHA032PKOcBUXj/0hD
         FFNt7t2R0GQbwkLssS4Q8JTRVz0v6oX7aUjMSzJvwTGtxAPrsUFSXds8FYZs+pwaP1ox
         O5z2ZHW2+yGIBg6A81LpqoRz1Pq49Rg6ezbr9+8bz78v4YPZfbbySGszevyn6atAU8Le
         7MhWHOXJt39ap2VrjjCI7gaHAzv+YmRPJV4VzQ7kkwCIxDD7/UY3C8FjrCGbl0gJ72cG
         eyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932311; x=1772537111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wGVfhGIFbdZYOY8RusNA+8qDyP+5sQzDVbWcUdCdH8=;
        b=vjqZGHv9YSJSW8VqAd7h61dFbTp66CFVjWG1EauGuD+8O3vylrw3x1r3CMRez7kNnF
         9v4qQLyXQJD0avOxwxeT1bzNMeGb6hZzhCPnUCMp8bYQpVPthuCkWfUrkL034ElD9op8
         Wmy2Cvlz3JzrMmTjKopTCCt46bDh035HMEncirgy71I2YtT5SmMBFQj3ldbsJdbuAXOI
         i34mMrmq0VVvQwIH2mhO0AcIEPLtS2tq9l3qF0BaJi1I/54sqjhNeWDUJxd0XwrbLkm0
         w5m9P/WW40oMxBz/hWTExjbCh21b1VX02ykXy5vKnbycVE1lC6jc6g7oT1inByW5dCuT
         JdNQ==
X-Gm-Message-State: AOJu0Yw6P3vhJq40SSk6nt1juG56q2H0WfKwMhwbEC/kbxP1WD7XEhqH
	nrtHy0GwdElMei0VzE3PLi1c9JvRvXPI/khMZniOGGRLK3HDzFEB1TXVnVIFjGGqHVk=
X-Gm-Gg: AZuq6aIT41rvGrf11RZn+HnKBlaCdNPMbM9SZbSuglIMmi0i55Ld7a4VlREygbjcgrF
	iKBB9psY5JQoF+3lUeLTQoMgWBBcQdmxbQcnyP6DAVVEtB9nldQMlor/p5k2lDAdnmepOg08PsZ
	v2W84KObXxSjD0p0IUFyM0mlyCUS+kRXSZoNwtKxuoIG698mIWbC4bYTZG55jDYOHZNN7k57Vgh
	H7E09ZykX/EEkcEPM27RzKijY/ImgWylK/P9HCkQ3EIG5Fx/YywrpltB7kNDBMUj0r/VLckJj4H
	ah8imgIs0rtiuYY027+8H+f7fjf9OMSIkV7ogepoh9xI/dWUszNOd91pZkiH/P4VF+3YVpAknaD
	1lEepvIOGeU6AGDDNXoY6oEUIOu21t9hNJgVgeBCRW9sCnrXWLQC0SeNcD1dHqHKONWp1TE3reT
	+74giYtzOwPlY7Accav3yRaCaYQ/sJ3ohHphhlLHBjRNs9
X-Received: by 2002:a05:6a00:8d2:b0:7b8:8bfa:5e1e with SMTP id d2e1a72fcca58-826da8d7b40mr10388552b3a.4.1771932311255;
        Tue, 24 Feb 2026 03:25:11 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd694eecsm10262316b3a.25.2026.02.24.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:25:10 -0800 (PST)
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
Subject: [PATCH net-next v2 1/3] net: dsa: yt921x: Refactor port error message
Date: Tue, 24 Feb 2026 19:24:05 +0800
Message-ID: <20260224112411.1561917-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224112411.1561917-1-mmyangfl@gmail.com>
References: <20260224112411.1561917-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260470-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B36E3186493
X-Rspamd-Action: no action

Sometimes we might get error from the underlying bus, but the return
type of the function is void, so an error message is desired here. There
are many instances of the same pattern, refactor it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 98e8915dd6c2..77864dcbb6c5 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -185,6 +185,12 @@ struct yt921x_reg_mdio {
 #define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
 #define to_device(priv) ((priv)->ds.dev)
 
+static void
+print_port_err(const struct device *dev, int port, int res, const char *action)
+{
+	dev_err(dev, "Failed to %s port %d: %i\n", action, port, res);
+}
+
 static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
 {
 	WARN_ON(!mutex_is_locked(&priv->reg_lock));
@@ -721,8 +727,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_jumbo;
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
+		print_port_err(dev, port, res, "read stats for");
 	return res;
 }
 
@@ -1102,8 +1107,7 @@ yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unmirror",
-			port, res);
+		print_port_err(dev, port, res, "unmirror");
 }
 
 static int
@@ -1690,8 +1694,7 @@ static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "clear FDB for",
-			port, res);
+		print_port_err(dev, port, res, "clear FDB for");
 }
 
 static int
@@ -2266,8 +2269,7 @@ yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "unbridge",
-			port, res);
+		print_port_err(dev, port, res, "unbridge");
 }
 
 static int
@@ -2399,8 +2401,7 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "set STP state for",
-			port, res);
+		print_port_err(dev, port, res, "set STP state for");
 }
 
 static int __maybe_unused
@@ -2738,8 +2739,7 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring down");
 }
 
 static void
@@ -2759,8 +2759,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "bring up");
 
 	schedule_delayed_work(&priv->ports[port].mib_read, 0);
 }
@@ -2779,8 +2778,7 @@ yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 	mutex_unlock(&priv->reg_lock);
 
 	if (res)
-		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "config",
-			port, res);
+		print_port_err(dp->ds->dev, port, res, "config");
 }
 
 static void
-- 
2.51.0


