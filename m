Return-Path: <netdev+bounces-147990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F19DFBDD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38379281B50
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75C21F9EDA;
	Mon,  2 Dec 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DIs+Woqq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA01F9409
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128077; cv=none; b=oIDkyLhwy3LKdiQ4NAfIaTh4Ng7xuvefJ+iuICmmDoK+VAEZklv8iKbfhsWNQsYosoXTq/sZwS/E+oFhZf+MbPmosfzYyY+KGP/AVp24GBmJ/tibCzwNvzGpknyThrNlLs7B4mmtyekdDdo1txtLDhkr07aKr8Pz6/WfaASgoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128077; c=relaxed/simple;
	bh=fviCnmdIUFTOMUOJ5oaDsl0vCRpjRkdfvT2zH4mYEOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avF5Dgm5hp/en4yH/GYbEg23b3NotlxS1l94I3yLBP1mWF0C1KD9yVdrdOuge7FNUcFfGh4dNQFFju/XIO4vrb6eGSFFaxsVJztC+9Ojpgk/QLZB7B/NUxQU+TguTWWcRqz/9FLEdsdN5H0qjAffxsYC2PYmRqh0CKJWg7tUBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DIs+Woqq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=tPgzHOjQWrK1Ou
	Ac0tNb88us1ab3NJWe2Xbq9uzEE50=; b=DIs+Woqq1OoGm///fdUWwDjZwh4AzS
	xxksGIi107pvOiUH9O64udy+UKvsDDjUv7OogGQ7idkr3R1rx6RgCRw+6FdYgqu1
	sWM8SKabX9iG7oBNK3aoLxMjkTTU58zBhu2sWNfreQTfHrdqHZb3gQ4h7D6O7Pm2
	FuKhLPw7NZSaTlbbdxeDbHBafVo4VGw6PWlA7Q+8P1lkhRL0FSjBWmxdanL1CbQN
	K07sSZvTyK9sbRhge9uzhpg30+gbSexvWvLDTbBAUrq51/DJOzJ6E1DihYs7oM1/
	M3ZnBz/5D8+X91kx5Lj0uB3xNhjLn717ZPAE5gjepQJismb1FKh3fSmA==
Received: (qmail 2440099 invoked from network); 2 Dec 2024 09:27:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Dec 2024 09:27:48 +0100
X-UD-Smtp-Session: l3s3148p1@YL7fUkUofuYujnum
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] mctp i2c: drop check because i2c_unregister_device() is NULL safe
Date: Mon,  2 Dec 2024 09:27:13 +0100
Message-Id: <20241202082713.9719-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only. Please apply to your tree.

 drivers/net/mctp/mctp-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index d2b3f5a59141..e3dcdeacc12c 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -177,8 +177,7 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
 	return mcli;
 err:
 	if (mcli) {
-		if (mcli->client)
-			i2c_unregister_device(mcli->client);
+		i2c_unregister_device(mcli->client);
 		kfree(mcli);
 	}
 	return ERR_PTR(rc);
-- 
2.39.2


