Return-Path: <netdev+bounces-78529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A913387592E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D5B21526
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9F13B783;
	Thu,  7 Mar 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCA+Cyhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9413AA52
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846609; cv=none; b=HPJ5u4dAy+r+L6Obx/I0dMeWZJiNIeB9eQcKI4kfcz8z6Q5gojOxdVAuQBsP37JdEZlEudA7XLaJaUrccHmI1KZRq9tMWrAii+sDQ1PjzAbLZQru+KQKklSELrkdTz8Bz4cIN5dSfuhIUCX8ZbCAweJaeKzkW5miQOwUB6fROew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846609; c=relaxed/simple;
	bh=r4hzgq2gqFUl21FMalBkfojSC7eOwnIy4YqjOkQZHqA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RG73JYc3nN10lDSTRRkLkN7hYk2BLm1qZ8Ph1CSGF3HcMsOkJDaqyrU9fuyyLZ+aBbYdzvwGA0HcyLxI0UjrSYmBMhw9l2Mu6cSvyTjD4LhIX2b4NJnULiVy4k+0EbbM8ToO1N8d7/OpCPQhtYT6GTKVYtnRd7LI2LQ5EIPLnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCA+Cyhe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-568241f40e9so165031a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709846606; x=1710451406; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KImqZa51+XSN3WJS6gBtSyo61swhpc2F/4j17rTXrvA=;
        b=QCA+CyheEPTn8Xj/iY7aIHf3SChOEkpttZtJSVHI9D0gfq4lYq1CuSUe4NDnZiClsS
         bDYQjik7YKTANKme+R/kOulgkBnU0Z+O1088pHEVd5RDY8Fo8Ck3WfgCevfvXU9S/Oeu
         6nX2Lntx2x3dmZVY/EFr2B+8PuCWXqNQ/zmLlawL+/V4WkvhugHgWXyHLhZyDFDUodm4
         CokPCV3qSZnqEH2AgaslrQTsKG6XLulROWss1erYZUvFaCqJLRtcZqbxmntYq1ylsZuj
         LIJTAUdJ6S5dT6lnnUZlM+X1+HdyNdqpniEEgLW2n5R6C7Dk7oNHXeKEu3korUIlO/cH
         FUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846606; x=1710451406;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KImqZa51+XSN3WJS6gBtSyo61swhpc2F/4j17rTXrvA=;
        b=AQD+lnCWFMqnPHhN+56/iNyI95LOjTp49+KyLzOo2x/pbCIj/4w1E7ObWEOnsPyKb8
         TRoQf3MND8dmd3AXm/eLlEa1rsih+YkPUNLJzEoDLEL8l6vphsMEvKvkLFLPrOPmqvek
         rQZ90A4iNKqXAmSuEZ2qauU8FKbTbYGWvJ3d8YJjL+UKidGwGA6lvOgfg36NaiCHM1ja
         ICe4TNeMiQ3UzsXcqeHai1ahiVtnGe8Zj1RUrWn+4wXApRT+wzLcnbpleDZwmK/n8lEK
         oJifEMPjg/H1V8jDbi5/cje9Ms/l9yEZxcciYp2j63FPh7Usx4sL/ma0V2rH3AkAVZG4
         OEfw==
X-Gm-Message-State: AOJu0Yw6+LbXbf3YPh2wZx9PhyD+K11Hbw3THN4uMristuwoGN/TFfpl
	41JhDEqkon28rCa18YuzPqS1uWaBiJYJyfNeH42asuHBKkPbRCi7
X-Google-Smtp-Source: AGHT+IF9rF2BTgwNwywy4jlTf+5rSShK60fgO+6uU7X8JQngeLJWpOL9Q9HDFSV4LCLsf/x8+3ctaA==
X-Received: by 2002:a50:c30e:0:b0:566:bf36:60d4 with SMTP id a14-20020a50c30e000000b00566bf3660d4mr665932edb.35.1709846605536;
        Thu, 07 Mar 2024 13:23:25 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ea8:7500:7cdb:1fd3:51b6:fa25? (dynamic-2a01-0c22-6ea8-7500-7cdb-1fd3-51b6-fa25.c22.pool.telefonica.de. [2a01:c22:6ea8:7500:7cdb:1fd3:51b6:fa25])
        by smtp.googlemail.com with ESMTPSA id i17-20020aa7c9d1000000b00567566227a5sm4769173edt.18.2024.03.07.13.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 13:23:25 -0800 (PST)
Message-ID: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
Date: Thu, 7 Mar 2024 22:23:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: switch to new function phy_support_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Switch to new function phy_support_eee. This allows to simplify
the code because data->tx_lpi_enabled is now populated by
phy_ethtool_get_eee().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0d2cbb32c..5c879a5c8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2079,7 +2079,6 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 		return ret;
 
 	data->tx_lpi_timer = r8169_get_tx_lpi_timer_us(tp);
-	data->tx_lpi_enabled = data->tx_lpi_timer ? data->eee_enabled : false;
 
 	return 0;
 }
@@ -5174,7 +5173,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
 	tp->phydev->mac_managed_pm = true;
 	if (rtl_supports_eee(tp))
-		phy_advertise_eee_all(tp->phydev);
+		phy_support_eee(tp->phydev);
 	phy_support_asym_pause(tp->phydev);
 
 	/* PHY will be woken up in rtl_open() */
-- 
2.44.0


