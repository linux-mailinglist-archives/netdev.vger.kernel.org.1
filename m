Return-Path: <netdev+bounces-134689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB699AD34
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC01C20F1F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E751E6338;
	Fri, 11 Oct 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7FxsFGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E641E1A11;
	Fri, 11 Oct 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676595; cv=none; b=Rjg9uWPkcfgQHXw70fwBHwhHaAlPX8sOXc0EdZPLQ+a/62ytQCoTfMjbrekSnlcKXzBUwkxy/wAj0EeTP4psKVLxFkLPpnp98QFTbN3ThYnp75Ge9twOq7MDGPZHLLGcM+jSajefXf1zn1u07vf/oQX6jPKuLK/dHBVqpKtzbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676595; c=relaxed/simple;
	bh=6LNSwhGbgx5mQWB9kCqZHHpn/5KiBcN4BZyRtBum/7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRQBKkuPGbw99ar2WnVseAURBAf86huIqNFkFMQlb98eHKjI95p3hAKkspupc9YyWN3lGvBKvjvlNdSagQUkYDKR85sZfvUaEJU7SId1yLUtDiChMGebfWGZuw8ojF+QdHVOndg1aXCxJihMZOjd/XwiXjye51RJMVrIsau/dPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7FxsFGq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1432885a12.2;
        Fri, 11 Oct 2024 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676592; x=1729281392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+1Ht4o02/NZ1TbMESeBGJqpwRvjVzZmcVshE1Z8vJc=;
        b=K7FxsFGqOIeBT49V/5oEpgPIaROvd1lESczAAVQyhRzLcQ0tF/SScsc51mAicATEin
         9yw9lq6CKYF7+QQHM/Io6eQCy1vG5gq+ySj3gAzx5+GDALaRCUoBpOBFgBE2DNS7/EEy
         qQa0rh4G43aGiJQhP3Blk9iaxiFeWbE8zKdR77ACpfTbLEkbqvq9zzYrf0ZXT4BrUHdq
         /u1q+mV+efEZ4Xvj640I5MSi/aORO4WERu4uC6sPzZBpIsMhWJ2lKBQd6a+gStKjfDc8
         yxKLJ5txk6Uoyfacmfq7H80R2ZCmJ8W/VVY8hl5aWqQF10Oph9hCKV9QhxqtY/lCBtAb
         IwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676592; x=1729281392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+1Ht4o02/NZ1TbMESeBGJqpwRvjVzZmcVshE1Z8vJc=;
        b=RkmTZRXHUSd8jHJxZf2OMEety3aovXfqubxn1k/NFegUZI20qpa43l/+xZ5W+hlBYm
         b0edO0fv+oskd4VlwLF7ouTrPEGLp3cZU9+BU/vG50pnYuoyMitAzB2QErksCvYfNqeY
         r8nf3i18Huj3MkPSdjicO08tGk4B6dHgVZZSMaLsfkaa6lJyKIkQab5h4rr6mmkv765V
         /y9PVNySnoia3x5uMamjbWYkdIvk6zO7WhW0uZvhZary+oqE00GAlkQLkoFHrYZdEtU/
         Q8hSrbux9FspZSzI2ZiGR4erVlZj22G1ALfmhm+eYJvopR/GOPSaq0Hm1b+UemVzdeuB
         CzWA==
X-Forwarded-Encrypted: i=1; AJvYcCVADoyUFfc1wj0HM6y1yXtisGnsboChuswvesCpoos3B2R7qFqX8m59SUG9cG2xCe5/emEJyDm//wVpbnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJYA1glcCFO+juWe7tVMJsVx/wY+XEfgIMta4BvelzSFbq7wE
	/CFzioODnMHmxYT94EBSt6TDcQpU+v/Izhhqm+BsexuOXzLu4HdNg0ZyzGOB
X-Google-Smtp-Source: AGHT+IFo4d079lERGmChQFTVVbReeF/5alvj5f5eC6e5n6mmMO+wSZJBgruYFCMtJ6vjQcrp/XOZkg==
X-Received: by 2002:a05:6a21:1813:b0:1d2:ba9c:6d9f with SMTP id adf61e73a8af0-1d8c9595bf2mr784149637.17.1728676592544;
        Fri, 11 Oct 2024 12:56:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 5/7] net: ibm: emac: use devm for mutex_init
Date: Fri, 11 Oct 2024 12:56:20 -0700
Message-ID: <20241011195622.6349-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems since inception that mutex_destroy was never called for these
in _remove. Instead of handling this manually, just use devm for
simplicity.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index f8478f0026af..b9ccaae61c48 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3021,8 +3021,14 @@ static int emac_probe(struct platform_device *ofdev)
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
 
 	/* Initialize some embedded data structures */
-	mutex_init(&dev->mdio_lock);
-	mutex_init(&dev->link_lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->mdio_lock);
+	if (err)
+		return err;
+
+	err = devm_mutex_init(&ofdev->dev, &dev->link_lock);
+	if (err)
+		return err;
+
 	spin_lock_init(&dev->lock);
 	INIT_WORK(&dev->reset_work, emac_reset_work);
 
-- 
2.47.0


