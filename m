Return-Path: <netdev+bounces-220107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E493EB4477A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4247BEDA8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88938283CAA;
	Thu,  4 Sep 2025 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELsQZBly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642C280312;
	Thu,  4 Sep 2025 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018326; cv=none; b=OMIhOW8wT7FbOqJA8/L2YYrUL6Ts4n/DcWFjzQUgrsF3BemXclHpvEbqy3k2Tku2F078lLXE30EalN5hHlgG2LXkqYrzrtIPV1yBScPHQokZI5CagJKMm33D3NhHRC2vQsqUJrGQuZCmvlUNxU9sEE4ByBoVQfQsifpBKFjfLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018326; c=relaxed/simple;
	bh=n7R812JNjxmkCbDBafEh9IUpvnenagpjqBGOy6LdQng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2LO8KmSxg+7cgGnr3kVoPoi0LXvrWyCgXU43JSsiXKGPohQVLv9Bl0qC1HK2qOiIdnw47bflUJc8Xlq70Mrh7APmBpmz4/1L53FAfkAhOyDbW/KzVgsXB6USTjs+HKDg2cHj6VKHIr3sPRh9D1ja4O6nb2XDWUFmgkXguo6oLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELsQZBly; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b164146baso10604225ad.2;
        Thu, 04 Sep 2025 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757018324; x=1757623124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXr6rVZOfVYAxW1cxhs3Tq01CyI0GIgDsUYj6M1hDKA=;
        b=ELsQZBlyje/4faV0wDj1WSq8YzTH49u2byujbqDdqpRVZrpx6jxxCt9agYP90K/45w
         8VXS9frK9xXIDv4xkSIAVY2o+GzbfsYqJ/QzJHuH2pe5yqJhomuPsP9hyygnLS9Mc+Pf
         Kt+qsJZ65tOd9wz+DuiCr9jOB/v+svreHLFWfAc41EwNYnUU64+HNrtbhi0LnIL97ItC
         7Q76g2VriltcKloNeRRX4DsBKRnPIhLdOwOKM/lnd48nxDnDPES0UtSE2svQK6uAurPe
         pCtdwvVjO1QiSejl0sWurhu7ZB5/jDq3iUgNISTL0EGFRNhI7B0QI5JqgIIp4wk0RhoX
         8wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757018324; x=1757623124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXr6rVZOfVYAxW1cxhs3Tq01CyI0GIgDsUYj6M1hDKA=;
        b=S+pjcGPmVb/JorwHl2wPA0Zyi1y/OtsKOlRxthx2RRI7rPzxwS+otM8yh8uZj33XKU
         0M5H9pWvsxdMw48sFXWO2r3Kwofsk567vKB1jpEKsfMtkppq7dfkmOMgSWHlrRw7+cNC
         e47WNxyTLrDhNJK4hIeig2L7/Z3bu3hiYte++dkunfQRfv2qwoIBAlt6AlcksuTSdqZF
         fmaCcPnbXpj2qdyPZbusAdMkKEtVLEF419jXRVexG1lIQ2k9nsxB9ZqRlccxSJmrPyEn
         tpuE/6iqkSKNfomvXdIS5iHHY/EI8HL2ITEAbPKYuAYsmcDnUbau9WUQYa+vwtUTXItF
         SPhA==
X-Forwarded-Encrypted: i=1; AJvYcCWvhA8bQYGoFuBz0UdVPt1587g/43Ry+yaEW3P62MKPZSCEW6DIGociInEOZlEBWmwA0pOK3DpQdkgaXv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCbJoRTsr+6cHOnm/No4kpralRUZw131UL491sp2wqoPe6rdL
	M5w2OuVyuf2E5GCPEuetk7FaNyKsNF6vtmP3dOqaPLTKvdNgjN5bFYusLkHD6Q==
X-Gm-Gg: ASbGncvN8yHlTbp9UQNln8Jwfom+ERemUD9PbyKHdU4Xzbydp0woVQkio+KiD1Sh3o5
	m6qo4NFWoli7mywpbfNHnWLKpo8dUo/Dtz0vCn/WGvDvDrwte3nZGV8Vozhtq5wqeLnbg7txDaH
	yX2glDgxgp9S3soezsoKIJzD37Aj+TWt8Ksg+wbzL6otpcgjsGtKqxuCxZA1ls1oHZkb8KjaiWC
	Mw90izV+PaurUz0iaoRGsuDophvd+9qgWHvIdbI7Mg8OT2nIDOx/qt1zyN8IStQNuXCFGq0lhXF
	w4ES7IujrukQHaJ2K/yHoXQ+JbgTyu0Tj41+W5/ME0EsSCanM3yiLKuohzBmXIP0bNQFoaQ/q6A
	VgdSj4mOyUEYp03z28QshYIAJPwU5EJb+3ljKDfn9/r3nfFeTXXjTcDesrersaHcWKhsKzBk=
X-Google-Smtp-Source: AGHT+IGtUGzmrZBJJadJEljEF0Lq0HorrKUEY1QVit8Yx48upxH3MWTHKwRoipi4o1X4NhwTxrj5vA==
X-Received: by 2002:a17:902:ce8d:b0:24c:d33d:4176 with SMTP id d9443c01a7336-24cd33d4fa9mr36838555ad.15.1757018324059;
        Thu, 04 Sep 2025 13:38:44 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeeca1csm20805652a91.25.2025.09.04.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:38:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: lan966x: enforce phy-mode presence
Date: Thu,  4 Sep 2025 13:38:34 -0700
Message-ID: <20250904203834.3660-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for lan966x states that phy-mode is a required
property but the code does not enforce this. Add an error check.

Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 7001584f1b7a..5d28710f4fd2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *pdev)
 			continue;
 
 		phy_mode = fwnode_get_phy_mode(portnp);
+		if (phy_mode)
+			goto cleanup_ports;
+
 		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
 		if (err)
 			goto cleanup_ports;
-- 
2.51.0


