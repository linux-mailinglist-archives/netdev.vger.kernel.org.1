Return-Path: <netdev+bounces-152825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C237B9F5D9C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19516168FB7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670113C83D;
	Wed, 18 Dec 2024 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="GXveqE2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0594A0F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493876; cv=none; b=W1rg6WdNSyhbn9fGoBoTo54lZGt/nDdOp1y/s4a0UFs3k4LgiLovE+q7FqE4JPOLYVRnvchEX0HqJOy28Pxq1uR+4kngCbS6XyuRmVg5Eiaizt2LXMKCDD2eXK52HPSi7OSVFmlrrvEOlNrkjY8l5j0i/jtInLAA9Uce9texB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493876; c=relaxed/simple;
	bh=bNWFeF/rn4iiPx65ANs8yZiUf0KqdDWjoezM8G//e+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h58+cwuLJYBmTEtCZuguAIhA9kcQCauj4byfzzOsh0sfCEmh3lpb5fRCyW3kpIl6/SdOwb284oZiWL7QXi3ootYTk8Nx97zfYurERQ+JizoX7tJKnMAkLKeDCQRCVB4/K3SNIFYhUAhGwnrBjsKhqbnBHu5aBAe1Fl5xmGp0+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=GXveqE2e; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ee27e905so7656345b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734493873; x=1735098673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNtryae5J0F0EGqM33XucNe8bv8NXw5KBQlyc8K1XF0=;
        b=GXveqE2emLymKOQuRw4PoKzQusnupP4uMIsBfE4/zHlYK4fvHk15+RzmaZHnE+NW7P
         YbOqc2WgJg/SEvYl1Qv9BH/kAIejQSJbEtbgn/3VBZ/hwLGYADiFGQlmmV/rAoS6NuSL
         BybQaFrhjDMWs2K7yMYxS++2mtGMReaKofLE5q/AdXtWIwPNoVTTlEAa+jIKXqG9GUh+
         uKeE4LCnHHgGFSKTTjNldLtk7AxgLRZgm8MytQJegQJvlVM+yKlqNg7k4J5DlFtbGKm5
         QR9CZ3+Zm9yMcdDXZRatiicWJluceS+9bMAHSRlv3i0bRa6yMHppkz9funxbyBSAJ6Hb
         ZA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734493873; x=1735098673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNtryae5J0F0EGqM33XucNe8bv8NXw5KBQlyc8K1XF0=;
        b=aZHINCQ5frEp+9uq035cxKwrnow3f/aW8d4xCQ7szaEItCtKOIx0/wtxKsYmVLQ6Z8
         QBsuIsatHxr9xH4IwklQAxNNL0gqjyRJK2GEvvH6H4l6hEVieQ0VNfZhAnT2rkQ0NFha
         e0yegum8EODJ6ENvaOjVSl/dCcRLkO606k3iz+tOwOwWRDNg5WHejO1nv1XaIWQ497q8
         7TxMgR+vibgtSkIfcVAX6MUr//SOoVgid5uQaOCia8o4EMBb5KnJuGnQbf9RbYGhzOvQ
         3yN4mC3HqXwF86e6k5Lb3YU9FmX7fya8ktWdjmO1r8QVUdIAyWwop4YHc2CmqPclqkxW
         sgag==
X-Gm-Message-State: AOJu0YwbRY1UZg8nFMSztMBnmptlM0kHfBRrv3n66fv3sTsZEA+INa9L
	fIfnjsFT0a1JxCTUFpsGq8Yl+temRHclgTtuxr/7f3THhbTME/Q0Fwa48Q3jqQcmo+sf/eyrZH0
	gEb4dMg==
X-Gm-Gg: ASbGnctFTMMfZHmyF83StTfT8ROcRJ5CmUj3XXCnsNgd5+nkIIpdZDCJMlzaLi5KlwB
	ZIsOt+d3WN5ce04ALpUj6ylmhwKmgZQhUeKjryFV8LaciiHO0RNGWXSDr3fhaw9AO7jcX8rX7HO
	Y69i4yOtP3iaVKo0XrLR9vxQHL424prJSaZfMTuWuVCLBLa5k5XYhGzYDgqor6qAkBFIcuBmZYv
	qqJNWoybUcCQCs0HKPKCKsnOzNnNLSCcU+d/7x3e+oWem9VFalJAg9hIzl788i+HHFgrZGdBveP
	11JgypYghPJN/HpnK+F9scwe7Vdmmpw1rW6k5gCMBXA=
X-Google-Smtp-Source: AGHT+IF5mPaJ8wuX+Kte1XOtYBvEbVyExojpxnxmZwmpn1LUvsKUbiKlpwF9HzY9YQsQGCxMWpb9mQ==
X-Received: by 2002:a05:6a21:1796:b0:1e1:bf3d:a18a with SMTP id adf61e73a8af0-1e5b488011cmr2742909637.32.1734493873203;
        Tue, 17 Dec 2024 19:51:13 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf3e6sm6480268a12.23.2024.12.17.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:51:12 -0800 (PST)
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
Subject: [PATCH v4] net: mdiobus: fix an OF node reference leak
Date: Wed, 18 Dec 2024 12:51:06 +0900
Message-Id: <20241218035106.1436405-1-joe@pf.is.s.u-tokyo.ac.jp>
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
Changes in v4:
- Reorder the variables.
- Add and use put_node label for cleanup.

Changes in v3:
- Call of_node_put() when arg.args_count != 1 holds.

Changes in v2:
- Call of_node_put() after calling register_mii_timestamper() to avoid
  UAF.
---
 drivers/net/mdio/fwnode_mdio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b156493d7084..aea0f0357568 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -40,6 +40,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
 static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
+	struct mii_timestamper *mii_ts;
 	struct of_phandle_args arg;
 	int err;
 
@@ -53,10 +54,16 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	else if (err)
 		return ERR_PTR(err);
 
-	if (arg.args_count != 1)
-		return ERR_PTR(-EINVAL);
+	if (arg.args_count != 1) {
+		mii_ts = ERR_PTR(-EINVAL);
+		goto put_node;
+	}
+
+	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
 
-	return register_mii_timestamper(arg.np, arg.args[0]);
+put_node:
+	of_node_put(arg.np);
+	return mii_ts;
 }
 
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
-- 
2.34.1


