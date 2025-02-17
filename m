Return-Path: <netdev+bounces-166877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FCA37B20
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1652A3ACDC9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061418FDA9;
	Mon, 17 Feb 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HpTYJ+B2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48A1862BB
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772022; cv=none; b=cP/j5AN8nP4CfgsddwwIFXUkHRs/k/rcv+xvYevR/6slUGP5BJtFO8jfZ08xBW6z/0chd3Y9gu8ROCfhTXmLghu0k79mJZDdSs6KVEhYn32tZLdzHssnNaWVM3qsJWHqjxKxrDMBaTqGOgeH3+WuME9jjUOuDmNtmoNwo/vub5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772022; c=relaxed/simple;
	bh=QfJsyVg0VP0z/iFwR8gySbOpR88WHfuxjwMBTCbk9dE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=do28Yq/TVnfdobglxVAPa9Sri7sk24UVucETzIYJt97frPG0BYhLoPtiR1QsYIJEubdD7qgaCMFFojbaxnmyTYsrCCblCIq25+lGFb0GvyYJVefllbDauOvxkPz15RLCnhLwZIq3kUZQGKxz9njnm4A+M8ZFIzLARHEvUKvA+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HpTYJ+B2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471f7261f65so574131cf.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739772019; x=1740376819; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNLaZYweysNghkTQQ5vEunIOEfjB7A4eivqMKKKSU0k=;
        b=HpTYJ+B2RYexiJRyXZ7LNvpkYlq05nAbW0kOWe1tX7hpRIy5uJz1mVbaudsOEis3w9
         TgRtWEJaY+B9UvzxnHQ+WImsEas/cvZW/umloO4eLn/ai36SXmlZPGt0ZYj4DuKSdtAX
         bFj91dYPT9Rjh+VCNb7M05KNyDWIEddRYI+wgemDPVwoIw9SgbP3jlmC+aqQ4NHTBicO
         wcGqHywE1WtWB7gmNPo8EF7WOFPrMg9oTeKQ/WkwRj5Kt5UQjNGVuJNfimWEYg4bTszY
         xkMQqRMb65vImrV9FOKm3JeMHRcM7sUwt86IeV+ArFqkfooVkFXypg9E7KnKA8IAlv+Y
         mI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739772019; x=1740376819;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNLaZYweysNghkTQQ5vEunIOEfjB7A4eivqMKKKSU0k=;
        b=mhdse4os2or01fewOUSantZP+OLDyZSM2JWYMRI4OUovnnczYBy2HBmYjLqcVlfxpu
         d1ZYtracDMKRFmuiA7cRId44LWrituBuIm6llVsIX7Mi2t1Q9lGFg4zWtKy5jASZKWLF
         DGyuW7V6C+G7gmLtkgrY0K5Sbrl9RwT3s2RIlCdhVumh95Yemqh0kh6JS/d4W/WqfEz5
         8ILb1JxXaWVZVJ/Zd0Oo2UXtzT30B5xr0RRMaq2nvpGzQcOhzN+8QbLT6tF/6JhqMhZ3
         SXjDT0cqdh6fM+f1NW2vACtCSJ1/fgncKZPEdNo+r55e9wsAetKM1L2fTx+y9kLEowfE
         FCOw==
X-Forwarded-Encrypted: i=1; AJvYcCXYC54zUshHKkqRWNjYtmmclFWJpadaxQtEg/QmIEJZv5s6Yvv3ooFSMb6ZjNrcDxIusMYdFgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQpxGDU/o6YzmYbOv4DZmojbsVm1FhzZpWoBE4RlwWWpHuIWS
	8IwtSF7FabNtgwx9dL7FZ+emLcQuJM5XfS8Z9eow+HJ15nK4VNpthx0YROQUvt4=
X-Gm-Gg: ASbGncuvvzsgH2UTKA/T1LZQhCG/dBwTIr07iDScyddU9J1lo2w9e1WwR7N2r3471oy
	4vKl3435IWbDTyZH2t8UpwAcghTc8dpn5GJy2MrQi4NgCFLLcAkYlfwgtUN7xaWDIE4hp1auGr2
	jWQs0J6vk9BOUHrG+hBfyt2XHePwXckujTFyDhB6pTAw5c0i/JC0i4w4HNnZqPij/PXmZUsO1/a
	AJWZlZlgm48Kqm2bwcLnA+tyjohVSpiC3EB9TubTtulbJkTchSenbNfQ30kNIkY6zJBQYjE3194
	YbINFi/YXGZIuQNXmhhPrbAVRigMSiC7lu2JfQ==
X-Google-Smtp-Source: AGHT+IEa/Pzs7CbSJS6B4jiAkbAvdqUHWHU03XvpyMfamqGiwX7MVgYWBqRl7K2/oJni/7AC6EA7iA==
X-Received: by 2002:a05:622a:8b:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-471c015077bmr226327871cf.11.1739772019591;
        Sun, 16 Feb 2025 22:00:19 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f6674aafsm1396881cf.76.2025.02.16.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:00:19 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Russell King <linux@armlinux.org.uk>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Praneeth Bajjuri <praneeth@ti.com>
Cc: Nick Hu <nick.hu@sifive.com>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: axienet: Set mac_managed_pm
Date: Mon, 17 Feb 2025 13:58:42 +0800
Message-Id: <20250217055843.19799-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The external PHY will undergo a soft reset twice during the resume process
when it wake up from suspend. The first reset occurs when the axienet
driver calls phylink_of_phy_connect(), and the second occurs when
mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
external PHY does not reinitialize the internal PHY, which causes issues
with the internal PHY, resulting in the PHY link being down. To prevent
this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
function.

Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and retain established link"")
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2ffaad0b0477..2deeb982bf6b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
+	lp->phylink_config.mac_managed_pm = true;
 	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD;
 
-- 
2.17.1


