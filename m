Return-Path: <netdev+bounces-140542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE49B6DD8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D031C21B06
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C521831B;
	Wed, 30 Oct 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O20y19dt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6759217673;
	Wed, 30 Oct 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320665; cv=none; b=KFBZV7cqTpQUu6+8u0Eq9t5RXWMUa8hDqNKrvLb5xaHrKsk8z0KdzsA3cExXf8pIl30uJHeT6hPL5cFRTlRaYDsaUExl9gjmP4xJhPkwCEl//teChv8Ue6jG/iw9tx9LY8A4fkipv0/1fEh20gvKcb3x6eJd6HarsIqB+ZOvxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320665; c=relaxed/simple;
	bh=v7srOjqtlI8zBYZmnnMlS0QgbQ1Xmte4f/J97QkvqTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D82dvrZWK5Ksidbm6XjBX6brmbUJ/QHCHVYw/ZU1RpuFCrudHpZD7G2QNRLmflNIf3GwfoQRcvI1PAYnBejmhObgZTawKlUVcPLcJX2dLLvXzseqGiOv9kf5W1ZzfoTksUlDcQA5W1SWMO9XyGP6jrvIhwyDJvQBgEohd5cHYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O20y19dt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdb889222so2661405ad.3;
        Wed, 30 Oct 2024 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320663; x=1730925463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGjqz3SA0up6rh8S9ZVt9un5axwKXR+AKnW0GCRAI7Q=;
        b=O20y19dtdhDI6kglq776P/pNbLN19GXN/43JLdVHLoku4h3SGJzMRClZIy435H55zB
         DZi14uqBINJehv4dC95AAwwHaqZ2njI/adVbtqoJSTbW7pN+exLnD3/ANO3g2OgSo6ut
         nlgC+qsJVCwrBSbTvluxw8+6LNOoWXDHHm8wuqXMSdgQHSFo2GwUvm3hnCIkV4GoGPIe
         +4xiVqycApt6UJVlOEuMvD1oQ1Es4/W27BGI0VStirn/wRXo20PXam5CMoEUIcwkwYfB
         MfyRqPYy8yJxNPDs40jCg83KHHOrdZZJQnRU/QOq531mhDU3yM7E4UzGCf5zIBvINDWu
         KUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320663; x=1730925463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGjqz3SA0up6rh8S9ZVt9un5axwKXR+AKnW0GCRAI7Q=;
        b=kFlIEABlLhX/0NPbrjKzkiZjRUqh0zN2obTQTltjfo0nR+Hgn2TJ/PkKr82S2vVjz5
         1utLae/juzu4+sZYeI8Wb6A/uh/yLgNNxeToE6nVdBR6B4w3gd/+ljuZHgUpOVF163KN
         +pzQBhjP9lKau3TROUGiXux/RKMJ3P2Hj0vY9tu7cC7KdlVEmumkVJzvoB8hsH3UQsg6
         xp6DfnIV12IANptb8QxthxcZJTBI7hmcPInCSxo4zT4i0lTXaQ9FyGC6aUQGgwFgrq48
         tNmuquFLUbSDzdxRA8281i95XZqzRxVebHWDvvjZkAVyUox8CAXOZA2VQ116anDZjFOJ
         fBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVuDhudri8/xgd2CZS60SXUAN+rqhOL+NoH8zzLDCI7vo73sEYRO+16PFIzJ3Gx6XIpx93thzl5+57qGVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG12KLpl+KsQr9vKQV4NcNcpZ45UBhOziFYFTubTJ3MdRadxbt
	wTDAfy22XirnI8VXq0jSfTRZeIdfwBrPkQS3cMF485Oltu1yQ3vDXN4G3w/v
X-Google-Smtp-Source: AGHT+IHSGW6mlYFHi4beFpyKFuf1XvqIf1GRY23TFora9lQMdaXHvIU3Omdy765N7oJ8oOb05WQpAQ==
X-Received: by 2002:a17:902:cf12:b0:20b:6d47:a3b0 with SMTP id d9443c01a7336-21103acdc86mr9831685ad.21.1730320662966;
        Wed, 30 Oct 2024 13:37:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 05/12] net: ibm: emac: rgmii: use devm for mutex_init
Date: Wed, 30 Oct 2024 13:37:20 -0700
Message-ID: <20241030203727.6039-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 7bafe2edfc50..9063f0a17e25 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -219,13 +219,17 @@ static int rgmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 
 	if (of_address_to_resource(np, 0, &regs)) {
-- 
2.47.0


