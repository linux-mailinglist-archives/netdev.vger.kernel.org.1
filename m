Return-Path: <netdev+bounces-125674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06D96E384
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CEFB217A4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18431B1D58;
	Thu,  5 Sep 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyoGwzVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C401AE846;
	Thu,  5 Sep 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565790; cv=none; b=K3gh2Zz+P2Kd52qqXZqi9PqP/bEiLYa6eY22wTycHri4EhNg62VkF0ndwXv7BF9RXFxk9AMaSuEOvIy3zFlKk6qsfyL2uDHP7CYwnv/CODRS8yGt3vSNqiHdzm5xHQrq/yifJfowTlz6BSf3T0OmajC9B9AmggUnAr2mv6ScHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565790; c=relaxed/simple;
	bh=1MXbig0Gfe11O9LAOpeyyY7fZHq5G8pcekT9BHoBb0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et+FIqYriEdOi4g1kQaeY9v9Mud1qsmZ4Nmg1V0LadGFgA5xkyBBftHiFmpiJLpL5ehxVEusAwMZGQDXZyD81FmEV0qt1ECGOs3kYDMXGD6qPvbBOs7ydFNw369EQ39B0jnSSznoHoT44O5zg0PkLC/BEGKz5YwADiaKqW4kXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyoGwzVH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71798a15ce5so468810b3a.0;
        Thu, 05 Sep 2024 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565788; x=1726170588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qpO2KwJrMxcAODh5GIPUFfJla71GHWnB9AbZMPCT2w=;
        b=JyoGwzVHShWnsqrYbffgpXbYGTDXPmAsCD+TxwwB7RcuJd9orQ8jAYVrlh9l7+qmV/
         WY+CiR3VwhbfOzYpps73+koVPBHbsrJXOZVXzPhKDPRuHHKlL/ZyJIFBNeS1KR1tUeGX
         D6Q7PZAvue5jf0Ss5UQQSMh1oD2agfAwg2ZXfxxQxeiOyer9aTqPXnsPOHCpYlD6ZIkF
         3acDYJPiXKXTr/85cla4ZZ0Qz+YPhtlJaQVJrMfMuUYuiG2Gg/WylHrt9vQbBUdDtROi
         ZTaBjXU/VyhcTMEfXBAvQcbKd9Jz1hGx+qT5swpyNHmXw7HaWqmXK7t3hjtjXMNNQxNO
         jqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565788; x=1726170588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qpO2KwJrMxcAODh5GIPUFfJla71GHWnB9AbZMPCT2w=;
        b=w+PVXipGKmwjgP0ZAe/ZhM/tOnE2+GVfVWXUfyEgUEXa1e9DpGhKCQ+qeg1zoUBJay
         GiZc7dDk1WZ9F/XXkCTNsagfkVHGM6v+fU9Vf5/yxUFG4Zj3DaIPAgQEJQU7i1B2bbK4
         Jl2Z52Yj02BXu3TxsQAkXArKXsVxANSmECRC5XEYo/OmuJC9m4rC6/EW/t9yVQ+WVM+x
         1Q6twIOUosLziXczePbr8A/qh+a+QtIpmOYC2HJQT/03NpI68QQdhG92DGQmoUXusGKj
         zZgnUCS2gUsOHq3Wi9ZytUM4+t6FPYkty2q7AljqaT4TRLbWhrz8hqe8yVIOh0ukFDVG
         uTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ff8QD4m6XCsQjvZ24bThe/LNCn42d7Iq48LqyYYiOY6RTRC/aSW1R04nNZWG8NdQYm/XzH/yA3iIW90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxyUnbJijAiuCnEpaGhsljNkOUKnBsom1jRmhNoJnY8VjFWnH
	lbV33vmOK81cCtBcxmf3OtY2WjN2vhysLfH0wOkFKPFSQNdvn+QLR/9uFYja
X-Google-Smtp-Source: AGHT+IGd3iBb2hSC2lC2rLH6iy2MhdshYaZK9aSgm80rWUG4phhr4LZYWKDj/Sg8z0tTeoMOVUkCNg==
X-Received: by 2002:a05:6a20:ce48:b0:1cc:d5d1:fe64 with SMTP id adf61e73a8af0-1cf1c0b9498mr606154637.14.1725565788282;
        Thu, 05 Sep 2024 12:49:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next 6/7] net: ag71xx: remove always true branch
Date: Thu,  5 Sep 2024 12:49:37 -0700
Message-ID: <20240905194938.8453-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opposite of this condition is checked above and if true, function
returns. Which means this can never be false.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/atheros/ag71xx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index a32a72fa4179..e28a4b018b11 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -719,12 +719,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mii_bus->parent = dev;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
-	if (!IS_ERR(mdio_reset)) {
-		reset_control_assert(mdio_reset);
-		msleep(100);
-		reset_control_deassert(mdio_reset);
-		msleep(200);
-	}
+	reset_control_assert(mdio_reset);
+	msleep(100);
+	reset_control_deassert(mdio_reset);
+	msleep(200);
 
 	mnp = of_get_child_by_name(np, "mdio");
 	err = devm_of_mdiobus_register(dev, mii_bus, mnp);
-- 
2.46.0


