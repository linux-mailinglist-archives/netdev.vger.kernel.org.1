Return-Path: <netdev+bounces-85161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F13899A56
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92650B21463
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB716132A;
	Fri,  5 Apr 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjSnUDup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979F15FD15
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311747; cv=none; b=WxJQjCfhK9PM7IgG0BlgzchSw7RPE7KTd7qY4l/SBt6xc/2W2AyPs76xw/83bTACwhoAXTxaN359PgsoEYsVlXpHhQhQ8mjQZdruzfv5qSzJ3ENSHiD5Or0iujoeFe2qQkiOyPVNPI4toM/TUzRKhqeALFhrpGd5SR143SeiQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311747; c=relaxed/simple;
	bh=8ImoAIEI0ugK8rC2IFmLmrAs2sbpTrlBbGo+o8vj+No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elSa91Qmu7xagQ1z+SL+zhz/v3CkusN8Rkjfif0t/2IEZuAOCGP2AG2JnWvn1ZYvjODp7IW9DTBoLyt5Tm8DhXRg9B53jNmCYYZJ0C9O84kXeU9s1NqzCwRkp849jTJZGTH6TkAVwlGANyz4feHWB72Rv1Vdh5HQBs8bNPwcJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hjSnUDup; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a47385a4379so561859166b.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712311744; x=1712916544; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJJyKfshi1mkCaS5tt0HZulFROWfnXGZiaDgMO8R3Nk=;
        b=hjSnUDupcvxj7zneyHBiU1R2EpvBrhstswDO7W6OLMw1llTc7JtBrFIcQrNK0o1ss3
         7GYrLfw3eVgtcnqW4GB7loxHOUEcgdSsbMKbsb9Gn0MglOizT4N4eHxCARAQWcx/4r5W
         mG1Rg0eRwJkBggrqrGy0r9X3MH4zRl90bjfMaT3JgEvObncUeIYwq0u2aPFSuW8raKtt
         OevqRXINmAx+ASQq4/5C8xp1BL6X2WcPOnTSJp6LT0BVkmVnC6uRXsHCjpI8yNPwxZPQ
         rVeg1Cjo5yomH/dyA4UvCDZCA6MHe1b5pvdtB6/cNvR2pBkpDq+GI4+NLdXVEmYHBoha
         vi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712311744; x=1712916544;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJJyKfshi1mkCaS5tt0HZulFROWfnXGZiaDgMO8R3Nk=;
        b=bB+fVYkbU9XA3iUV3FRiRuIjZaK67SGffoLTRRRa6O+gFbRiq2xh6S4+YurjG1iN9E
         P2dEGM3u6JOlJDa9Y2FpvIJuEUBVap0i8SsA0W/I9JHw8abd/bosVzJuoBfBYGSfXaDH
         5903xgYuf5b1lxLRFTlmtrUKDe9xcVpdqt5wRth9O+udOMDZSK9m3Y6bNBumWA2vmF2W
         8bUCLBvhEVrYWU4gwcGkZcB1zZ6hjvHwQPkURmW/5BIkY2klGhm+vdG3AXSNA1C06bmi
         ECBievzzMMxrwkW6ErjrO3pjbr/IREtSHAuHaYCmCTnq+Fna3fBMlf5DZTbuSum5+A7E
         Fr8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9edaMY/pUUzQ52AuIdWQtrQCIBlD0FC9aYSLMMhhE7bycleZoBeus7+F2R9xr4arUoIFqeJwDi1vd0B1xhNyOE9V8kWjK
X-Gm-Message-State: AOJu0YxCDB5phrWVxgSMW06C6CYrAyTjOIiY7dYp4DBwaVFrgyGh1Noo
	3eQtCjedeM19u6RTO1rEDCtbLExL4aTlbdhPFcPYQHpZySqT1+mm6wu3OMD8f6k=
X-Google-Smtp-Source: AGHT+IHSByE+q9VpdHRF4fCIC0/s5XcORINNOZr0+G4TGptAdJjbM1kdurv9GRJWoBAdanDW5rSG6Q==
X-Received: by 2002:a17:906:a856:b0:a51:9304:1a01 with SMTP id dx22-20020a170906a85600b00a5193041a01mr1067995ejb.26.1712311743540;
        Fri, 05 Apr 2024 03:09:03 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170906ae4b00b00a51a691cd23sm503559ejb.190.2024.04.05.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:09:03 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:08:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: phy: air_en8811h: fix some error codes
Message-ID: <7ef2e230-dfb7-4a77-8973-9e5be1a99fc2@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These error paths accidentally return "ret" which is zero/success
instead of the correct error code.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/phy/air_en8811h.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 720542a4fd82..4c9a1c9c805e 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -272,11 +272,11 @@ static int __air_buckpbus_reg_read(struct phy_device *phydev,
 
 	pbus_data_high = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
 	if (pbus_data_high < 0)
-		return ret;
+		return pbus_data_high;
 
 	pbus_data_low = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
 	if (pbus_data_low < 0)
-		return ret;
+		return pbus_data_low;
 
 	*pbus_data = pbus_data_low | (pbus_data_high << 16);
 	return 0;
@@ -323,11 +323,11 @@ static int __air_buckpbus_reg_modify(struct phy_device *phydev,
 
 	pbus_data_high = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
 	if (pbus_data_high < 0)
-		return ret;
+		return pbus_data_high;
 
 	pbus_data_low = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
 	if (pbus_data_low < 0)
-		return ret;
+		return pbus_data_low;
 
 	pbus_data_old = pbus_data_low | (pbus_data_high << 16);
 	pbus_data_new = (pbus_data_old & ~mask) | set;
-- 
2.43.0


