Return-Path: <netdev+bounces-243497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14ACA266A
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 06:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438823034A05
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC523D7DD;
	Thu,  4 Dec 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXODxq9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF818AFD
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764825779; cv=none; b=UMbVO0G5HPNogdEeewpxfeeXO1vadwABVtLzsw9OlhTlGWydJX1XkS0MAqiwGkNOf4hrWlSzGXAZLWqYKIQvAgB6R2bBBVFt+fRE8o9fgDXrQ4euwHhUpce2IgYVs1LZP4CV7pfh1cmd9nbfR+p9llq+E/qo+iCdGg68EmeCm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764825779; c=relaxed/simple;
	bh=jpCd0OHBUEzCSY1ml7HUrOeU5mgCQ8eJQx72dE+bCVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEC0w5vuF2THJdZ9sQcwifXCTvfosAb3gWByX4ayM7hbUeXrqEXXoqqacuAqIVpymxw2MxJ6k3jaZh5h4QTzYBOgZhC32C27zoSmm0ZCA3X2UxCD8bIkFo2qshSWltQExAafSDeszxHE/VdJa6uBICf0Q90CmenzXAfJy6MRgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXODxq9N; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59584301f0cso551083e87.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 21:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764825776; x=1765430576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SQv1SiIIssZ012oxMaXo7fT2SF8X3Lengkaz4PLfkc=;
        b=aXODxq9NbGQQzujLq7p6spbL+18sz8dJzrDI4zX2wsYgg1hbARSUQo5xSsaUulPSAe
         LdHBLHhNEYEdbVyiu5xKIgxSp/+NW/ZJqyWX2Xmlfj78fFcRWh89oGiWD9p9p6CADu7Q
         ibP1HDRy8+j1N3sEYr9LN5PL7eYOkN3pfipautBcyTAAhAqD5bUur0fsQpJT5RSjbVXi
         /MFQt2TREnNIrGMmKf43bNYeZmv5GAC2Xh+lJ8RxYbCJBXnCAmR86OZtdVz6T7XId8GV
         4dFKoqwZJEA3fyWyBcqXkOeUYN+xKcdCW5u9D10WAXFxGa/OTb/oNCKizN0MdMQVA9V2
         UAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764825776; x=1765430576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SQv1SiIIssZ012oxMaXo7fT2SF8X3Lengkaz4PLfkc=;
        b=BVAm1pkDgKAEMRVZ76nMkyozbyq+qBLfAON4wUAGv6F0r+b2rT2K58OXAafJW5TXej
         pD77zltC1CXwwcXtS+ae8ZoaSZVeMH73jrsKW/mvO0oopfE6Z5Ws9y5ckat2vCKvQDc9
         L5YLswXhsYOorh07smJbOD5WOGmd1WHMJ3S6u6y+wguloSewRJkaD6fIxykCPSv6kwHc
         G4E9//Whli5/Bg6jMUJgwU8uCoxhXtmOw0A+KADTvN5mYD4igWS6WVj5bPV9GWsbvUvl
         Cbym/9vs9cSm5JUzYkkLN+Xmt2aUsEn7lf0NLOFzDHvbmqNdYm13ZLgcncbKTxTOj8Ay
         NerQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/WefxNh2Z20Dh5mLKuWi1pJLYGZ9UKG587En8kYPwLQPgtKrnOPrtCMnUTtU2eEkRiG71TU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7bMoYC2fFbgMU1o5BBFc/P5jzUkzOcLS5exfGxB5aKgATmBG
	4Hfg9QFYWVx0sJIblZ0N7ZNuHmAzPfxHIHseoXpkIhM3KDBeQbVIDPoNc1VNk4hKZvo=
X-Gm-Gg: ASbGncuHJs34B3gDoM+//ZRx7DAcrPOWFvtryMio9sxPiQ7gVDHpAzIJCp9LmKbbxHY
	ruZRLJUwmYLuQOAP9uKkjHQH7t1xkMiiEqE2K/4p/fvuvVYvzMTGeRNQHE5cptsRD/Pnw+1Rtz3
	7rH1M8kXi49qYz7TzwKJuIV2cWVaV/U3OQRb3LhKG7OFJc/1yed3BB55btnz5YqnKcfpBOH0SPv
	YEevXgjuiF6aJe3m1688SCbTIXotOGTtrpjuh9zmY97n8U2OwnqRUZMBpCkGyhj1k3MYYv1p0ae
	0MIKbYESbj+bhahlKhKmEhXeNhw6aaIrX8PqlH/dGwWfCXxS+jT/oLZyrgxtlVJsooFXRqDB7JQ
	ZxeYDdVy6rC7FaVgY5uOjXoiBl3MIBkcqoQMwv++bebE75Fjr9eG9mjrsnUq1vztP7hIwZfURyO
	7+sBr22smOoqeklxOdEQZsYaTwQ0VJWsXAFxDGNxX8nzLmI/P6
X-Google-Smtp-Source: AGHT+IFwSLqkgHS+SZtUf7B8kZwkS4UQ5FyGPpaYdKBViOr7E5L4BTTmWpLiHu5Mh93G5lsuy/i/MA==
X-Received: by 2002:a05:6512:23aa:b0:595:82ed:ff28 with SMTP id 2adb3069b0e04-597d66cdb3dmr518386e87.32.1764825775443;
        Wed, 03 Dec 2025 21:22:55 -0800 (PST)
Received: from home-server.lan (89-109-48-215.dynamic.mts-nn.ru. [89.109.48.215])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e3fasm117445e87.65.2025.12.03.21.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 21:22:55 -0800 (PST)
From: Alexey Simakov <bigalex934@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Buesch <mb@bu3sch.de>,
	"John W. Linville" <linville@tuxdriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] broadcom: b44: prevent uninitialized value usage
Date: Thu,  4 Dec 2025 08:22:43 +0300
Message-Id: <20251204052243.5824-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On execution path with raised B44_FLAG_EXTERNAL_PHY, b44_readphy()
leaves bmcr value uninitialized and it is used later in the code.

Add check of this flag at the beginning of the b44_nway_reset() and
exit early of the function if an external PHY is used, that would
also correspond to other b44_readphy() call sites.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 753f492093da ("[B44]: port to native ssb support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/net/ethernet/broadcom/b44.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 0353359c3fe9..cbfd65881326 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1789,6 +1789,9 @@ static int b44_nway_reset(struct net_device *dev)
 	u32 bmcr;
 	int r;
 
+	if (bp->flags & B44_FLAG_EXTERNAL_PHY)
+		return 0;
+
 	spin_lock_irq(&bp->lock);
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	b44_readphy(bp, MII_BMCR, &bmcr);
-- 
2.34.1


