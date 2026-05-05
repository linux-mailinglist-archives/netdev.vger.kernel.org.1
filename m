Return-Path: <netdev+bounces-284274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFhIO7yx+Wld/AIAu9opvQ
	(envelope-from <netdev+bounces-284274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:00:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 917304C90B6
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0138E305637C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D53C6A39;
	Tue,  5 May 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPNbfl+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7D3A1A3B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971587; cv=none; b=Pue/6KS7mqNlbWcfA0nkv9eKA9JV7pastXoFo2eHl6ohR4SJWebxON77FYKEwNpHpRq3oXy/6GFVbTxJcRU1Nq7yo1Q/3DhvJT6RL1EqdM7cHxOhyRtgZJI0hGsEMN90eP46gY9pdT2gqOTF4wJxE+5B2iKotlAQVcaeawMTdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971587; c=relaxed/simple;
	bh=GtnmXgWBnlVbum8VU82XoIoP2qzEtwowPEy/lSbUNBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=petBoSw3tu3RHt8FgJE82TYtgGW+zlSyRZKW41l5m0gcgTG0RmRBHG0cObkA2o1cqI8o7KvWtLtKkyqY9jKE1vOzqf923VI/ik3ucCa2wUEQUJxizR1R2jS12kPQnnjyMt4Hhogi0e6g5tvyAnzpJFJHrqLH/XyDDZ5o7/o9e9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPNbfl+m; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365425c98c6so1383249a91.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777971585; x=1778576385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scgXwfpWRTztGmGbOBFzi2/rYTv6bkNqRVNUxAo7T3c=;
        b=dPNbfl+mQfuF5iFuA4h/oDLdV+N6e39r4NeGUMHjBrQ8VpddRgowN/3bUgf73Xz0UQ
         +EivlcGMfx2NMdJnxbGnkfZKH0oKpKd9lH1O3zEBueWHipWF2LW2vFu22kzwLD0xZXCE
         IjJnS6mzDEEZzDHqrJoW5Aj/3PYMRO+qtiuEO6ffgCbeyFGftbbfiZt/EcrajVgrdfoO
         Xp0d34QjvfonJnfdtp/ZvU6L6+bDDnUwlC+dkvCKnMlNaZ1iDDMD+53SECpP+oI8AWFH
         kGywZY4KHbkQRd4O6AQ9XPx8fmIQcmu0NCE3B5Z6VEw+wk0N+CXbSk8bskdQcO9Dc9Fd
         REnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971585; x=1778576385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scgXwfpWRTztGmGbOBFzi2/rYTv6bkNqRVNUxAo7T3c=;
        b=T6EGiiBGnu3lFpvB3Ntj5VSiKXKaIT8q0hOlHhqzKACP7BrGzsQ8WWkpdctj68X6eW
         wxs7yM/mKlfiQP7i97rf/IrvOHJSCjGXyp2xa7V3c1XFuaNWcHVcV7RDRlxMe4fFnUZX
         e4Ji3sMOcMzcsH3HYn4OHWyoF7C9iUIDmWd69n6R4aiVp14ieEQWzRgJX7RL9h1ZY+jM
         XTQSFSvH/+y6Vz5qpM2wN8epfylhy31eZuaB0Kscn3xp9suZEsBvFjxzI9aa6c5Kiyg/
         N1Pn62gFF+dGr8utoWA80hvxkeJK2wVpWrfoEqi2wMU9arMEK10u+AHfWeihMZAa7+W+
         budg==
X-Forwarded-Encrypted: i=1; AFNElJ/b9QAQuH3uffmDUgnpWaGntIhpRSkBsLcZiZ3DBpsbK8FvtBX+GDgM5pvSYGC3D923qRaqLes=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8q32F1aJSTyFnL598+ZW3RDaiBOmjllhd+Qkkh1w/25plY0v
	HO1f8EXznNgJApqmB8XYHDIWcBQXTbWj6+OEVuZGcv37Cs5XT6QDbOtn
X-Gm-Gg: AeBDietamV4f90jf8uLPMvglh1mv6pLpkpjXF4cHdRBeCWrIXL9wkFM1oz0HeF4dY72
	ucYvxJGTJMjS/4wxklFPZAmTs9BAW5LjZa0ulczhFPFXNTULMRF24ONWJpMuZqEfMxY52t+583u
	haBxZo16mMk5fx8+ey32K/rUSX6N8GPc5+l+8G9B82tQX4BPlSfQM3lbUb+PpXjXu4w3htnDpZ4
	2cEjpo5aFUKymNVoMbFRN0XeBRMKSPVQjIxcE6eF+J1wM25kAucBAS1MAMpvuBZgimgi8CzPT4A
	ENfjOGqsRqje4mHuMIV6cshJlIo9tyTqLl/lWMaD3ZbIvxNW0wkvp4dmdBtwysRX5fGSiEyfAs7
	Y3GHVDSwZ0i8ra5GuRjDUNzmR/0LdLI9PjP0qf1vLbv0qziyaJOszJdN8dkcc2rjj1qiKXpC4xz
	XTgqvwbe6rlwDEfugGdEaFmIboZVAL2hSvNrdSs4vZiz25hb3AYTPW1SsVmP6NVjR/rqP/t+Rl
X-Received: by 2002:a17:90b:17d0:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-3650ce552camr13753846a91.23.1777971585283;
        Tue, 05 May 2026 01:59:45 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364dbeb2db0sm19293267a91.10.2026.05.05.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:59:44 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v2] net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()
Date: Tue,  5 May 2026 14:28:40 +0530
Message-Id: <20260505085840.352206-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 917304C90B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284274-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

of_get_child_by_name() takes a reference. The rtsn_reset() and
rtsn_change_mode() failure paths jump to out_free_bus and leak
mdio_node.

Add out_put_node to drop it before falling through.

Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes in v2:
- Restore blank line between `return 0;` and `out_put_node:` label (Geert)
- Add Reviewed-by: Geert Uytterhoeven

Link to v1: https://lore.kernel.org/netdev/20260504200356.3529873-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ethernet/renesas/rtsn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 03a2669f0518..ee8381b60b8d 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -797,11 +797,11 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
 	/* Enter config mode before registering the MDIO bus */
 	ret = rtsn_reset(priv);
 	if (ret)
-		goto out_free_bus;
+		goto out_put_node;
 
 	ret = rtsn_change_mode(priv, OCR_OPC_CONFIG);
 	if (ret)
-		goto out_free_bus;
+		goto out_put_node;
 
 	rtsn_modify(priv, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		    MPIC_PSMCS_DEFAULT | MPIC_PSMHT_DEFAULT);
@@ -824,6 +824,8 @@ static int rtsn_mdio_alloc(struct rtsn_private *priv)
 
 	return 0;
 
+out_put_node:
+	of_node_put(mdio_node);
 out_free_bus:
 	mdiobus_free(mii);
 	return ret;
-- 
2.25.1


