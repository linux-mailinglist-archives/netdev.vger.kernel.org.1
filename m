Return-Path: <netdev+bounces-152049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE539F27CF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9737A16A8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25BEAD5;
	Mon, 16 Dec 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="uNwv+mgX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082098BE8
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313265; cv=none; b=CdLQfp4DEPpn2mWIt1Zk4M3/Hi/ec1+3nKp0mxvtC08si/FFfqUl+nxSZZP2Ha3Bnee8Ico+48DV8TxwT+fo4dFfzrgdA3juUzUPiSje5WnQ2nYqNOGvWfPaTWWXME/shcg21alIpbKDUCUU2WwgX+EgZcQiIvGRjSzpJMJ6I04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313265; c=relaxed/simple;
	bh=wUliPX4UlX2ZUqtIxuHH8TcXKLmNei9GsU33CSFCuVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPSpZc9QJEsxKe1UhxeySdR3eBu/mz45CQRRnb3UXw1oVuQQQ1wceMhFRr0eSk3xNDm/onp/r+/sxTy7D7So3fNXyHhIpUMO1B1s+fC1j4jHMioLbjN7vpfVGGc4KUeaHCAvxQAqXebGbzj+ucynj9mP1y7IGxT2vJUWt1Ncf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=uNwv+mgX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso2759980a12.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734313261; x=1734918061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnySJAKFj/JwpTwQP305gbmior4RPsDpYmg2PiuMdZg=;
        b=uNwv+mgX65PXnTqe21I1TRuiqoKlXXEaK2TwP6eT/9pD142SzOefdNmzzJqO509NA6
         DU0b+teMAIdPS/vfulcdRcu2zbzgR2erpCdhZ36ImOFIcxLw0RMt8mF8iyKU3qCwZ2xe
         PV0qtmepEy0EAra3WnZ2N6fvAuTnsTymllO9oKeuPgSTDCyCB9cxmGByEfZgApJDHKX2
         /zFVPqj6FVt2+G/4DOP0EuFDpuWwwWxbcavBIaw4QYYz5RmZ1GApNptESXR29oFqzo4M
         FRLQaYFYEEMI+gE6xIDYz07/ZSk9SWgUI7XztUtRvttUuTrWRS6Mns6muop72y9oClw5
         74XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313261; x=1734918061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnySJAKFj/JwpTwQP305gbmior4RPsDpYmg2PiuMdZg=;
        b=sbiWd6Mw7XLbB8J8jKR4fxSTs1nBHZDD4ZE/0PYPolPfl1ZEcJxpA1rbc/qL17k23c
         7sMf4J/K4Wb9P48vmib86GPupQK6qotZUwNjjO6SOZ6Dq36HY7urDP4ucgU5cNiT4kYr
         f6ZMkU7qa/zf+WRlo15vkXh+p2Y7WnWq5vEFpE58J5UxFTKuNdjfqRaMsilwFC5I8JP9
         Atq/kl/bCbmNhZ6SLQb5EkZkpUe34rT6eXi6lckKDfbwflJQQSkxvDiZi9ORAMjdK6ZC
         G1HJmrR/7I7PZBkRSoRDJ49xmyMoXTFF8fDQTGtyMx/Z/CGfLoTpi/RTSYiRlxzbK4eu
         4dew==
X-Gm-Message-State: AOJu0YwwiMLk1IpultnHQSpDm98c0QTW3tbqHHxpkZhIladZgtpdbPCF
	Gh5N/NRLRRM+Xi6vf23Yw69E1g0ZbFL8l86uQ7IJxff20Zu+FL2wWaZBgEOzr4RzQuiSt2LbPpG
	T7Ncshg==
X-Gm-Gg: ASbGnctQzSw9dTfyhTllavqygceUg9hnmi1DoM3xrgG5LNfvMcBYMSHHNgz2tOQjonx
	xIMuC+MPlJNXXlqmh5xdk7Ifr47CYolx07tzU7vljGQ5xv8aYY7NOUYv19SMEF7bU+1EvavySn3
	PuQo/XmdpwJCpI3t7vYvU+qYieGvbJTbTjtUoD/OLstIOKtzdql5v0HhHV51zHc+/pHcpTf7QjW
	AQoni74hG/DnwdGO/rzRoCsNy1SeiCRt8jsLfHoAwjfND7SDJ6z8/2tCsJAHJyNBjZZW6jwefNP
	NOZSAap1u4Uj0M/GobUcn/TezLrsG9AWowsYkWszSy4=
X-Google-Smtp-Source: AGHT+IHtExrkSzMyQ85Vnm/VEn2NjGJWL/raMtR86n9WHWPIdNR210QzlO22+DJ0Lvl2/odQ9Bqs1A==
X-Received: by 2002:a17:90b:4c43:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2f28fb50349mr15089627a91.6.1734313261205;
        Sun, 15 Dec 2024 17:41:01 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e705f0sm31829785ad.265.2024.12.15.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 17:41:00 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v3] net: mdiobus: fix an OF node reference leak
Date: Mon, 16 Dec 2024 10:40:55 +0900
Message-Id: <20241216014055.324461-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
but does not decrement the refcount of the obtained OF node. Add an
of_node_put() call before returning from the function.

This bug was detected by an experimental static analysis tool that I am
developing.

Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v3:
- Call of_node_put() when arg.args_count != 1 holds.

Changes in v2:
- Call of_node_put() after calling register_mii_timestamper() to avoid
  UAF.
---
 drivers/net/mdio/fwnode_mdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b156493d7084..b18a1934018e 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -41,6 +41,7 @@ static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
 	struct of_phandle_args arg;
+	struct mii_timestamper *mii_ts;
 	int err;
 
 	if (is_acpi_node(fwnode))
@@ -53,10 +54,14 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	else if (err)
 		return ERR_PTR(err);
 
-	if (arg.args_count != 1)
+	if (arg.args_count != 1) {
+		of_node_put(arg.np);
 		return ERR_PTR(-EINVAL);
+	}
 
-	return register_mii_timestamper(arg.np, arg.args[0]);
+	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
+	of_node_put(arg.np);
+	return mii_ts;
 }
 
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
-- 
2.34.1


