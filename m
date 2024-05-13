Return-Path: <netdev+bounces-96057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04518C4217
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2841C21305
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0C15358E;
	Mon, 13 May 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeiBiBC9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D841534EA
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607538; cv=none; b=odU6RRoh2vxCZnXAlX0tYXva9KZcvBc0vrq27zHxL2NCKgmjWEvnyAulNO5lhzik6RzWu4hurwSWrE246CFkAkt8hRoKNhVYPTgJonixi3zeb8LzMmtipcMEZlmUYr6ps409uSlbT8jyFLzn3ZRKoCySRFA9RxlHdElco5JPomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607538; c=relaxed/simple;
	bh=jb1/MaJZw2PExn+I5dp1zFCVxZbYhwoneuqOK36NXuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u451aZ7PfP4szFaPRWG9Hn2ByT4co1FEZn8TSIjNxARFo+qUC/snxWri/ivZPDF7HbvdsIJGEumuUJxoA9pmCScH0xVE+2FEZX3xSLnBXKzxzqokdafTn6etnPaOfxqKcxqtjlCzMfldNYdn5NBK7JiaCNW5OyokarknIBtYtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZeiBiBC9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f60817e34so4852072e87.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607535; x=1716212335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvv8jW/5ZpQcYJcwiGFSQaqAnBMqq8ilk2/LlqIis8M=;
        b=ZeiBiBC9kiCpoDr/GaQ2inlAzm8ud9N1cemfByAfmUW+eb56JujG0QXVt5kR02mo3O
         YrrluNmBlBXLNjmRlSYJqDwgui4arXY8+UZZIriIt9XpzDT1xGu4+Tv0yZyvh2o0isW+
         0ZNQRjO4Z7+Ert2phdRhZdhtetTs74FmUK2y3uqlXXaDqrUkGeO8f2IUncssoM9F8BQJ
         IBL0XUOci1Wyxl9hyc/Tgdc/f9PylxS3cvIar5ojd4Btu4eNtWcGgVpOg7GViktD24I5
         56CKvubQA4sg4uAfmKMmvB/kUTvksvppy4lOBVKUTeHlKGaroyHJ6SYY6YxI/0u3KdW0
         PaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607535; x=1716212335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cvv8jW/5ZpQcYJcwiGFSQaqAnBMqq8ilk2/LlqIis8M=;
        b=ZoLTQFFt9xbK5Z4E2mIUrr2wJVxfhwW9841iDUYQ6AMRG+xz0HHfSAY31wpVvNwMT/
         tEdpJTataikFqHbQB4ytJr2htPlvW9Qd8DrQaPi60oYKzN4szy4drBtSV7QLFZVud2S1
         +79C6pu3Yyo9YPLMxluHBO88McwQEfiBR6fTOizGnvxWmIJTznanlfQX9cCdDrIPcTNj
         0ixb1ciMaRQcp01DHfxuGx5j78iI6RKiJZIA+ebFhnN08UPSfPxBpoSKr7r5BqnQGf0W
         chbKRuYPj47EUhUcSU/ftRlL3QxnrQ9kWNHvEyCGT+4cdzLLxM28dtsmJ9OHLqE2MOX+
         6SBg==
X-Gm-Message-State: AOJu0YyEGO9ogmkSM427wn5jyahw92bg5RzQz/nLpiKNW11xT84Dcli4
	XGryRyLKO+5TPsiNnscC3i59bvI5U8H3OT6k5Xt6tTwQrGplDCc+40SNOXNXeMM=
X-Google-Smtp-Source: AGHT+IFbie0SZ8wFLuRLYlhkzS8scX2ItSNrnc3DkGdm/gJTADkLzVAUmWSwW0fRthx73LqFh9UW0g==
X-Received: by 2002:ac2:46e7:0:b0:51e:f68b:d266 with SMTP id 2adb3069b0e04-5220fe78ceamr5687249e87.50.1715607535002;
        Mon, 13 May 2024 06:38:55 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 15:38:51 +0200
Subject: [PATCH net-next v3 4/5] net: ethernet: cortina: Use negotiated
 TX/RX pause
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-4-b442540cc140@linaro.org>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

Instead of directly poking into registers of the PHY, use
the existing function to query phylib about this directly.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e9b4946ec45f..85a9777083ba 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -293,8 +293,8 @@ static void gmac_adjust_link(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
 	union gmac_status status, old_status;
-	int pause_tx = 0;
-	int pause_rx = 0;
+	bool pause_tx = false;
+	bool pause_rx = false;
 
 	status.bits32 = readl(port->gmac_base + GMAC_STATUS);
 	old_status.bits32 = status.bits32;
@@ -329,14 +329,9 @@ static void gmac_adjust_link(struct net_device *netdev)
 	}
 
 	if (phydev->duplex == DUPLEX_FULL) {
-		u16 lcladv = phy_read(phydev, MII_ADVERTISE);
-		u16 rmtadv = phy_read(phydev, MII_LPA);
-		u8 cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
-
-		if (cap & FLOW_CTRL_RX)
-			pause_rx = 1;
-		if (cap & FLOW_CTRL_TX)
-			pause_tx = 1;
+		phy_get_pause(phydev, &pause_tx, &pause_rx);
+		netdev_dbg(netdev, "set negotiated pause params pause TX = %s, pause RX = %s\n",
+			   pause_tx ? "ON" : "OFF", pause_rx ? "ON" : "OFF");
 	}
 
 	gmac_set_flow_control(netdev, pause_tx, pause_rx);

-- 
2.45.0


