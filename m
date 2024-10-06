Return-Path: <netdev+bounces-132442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFF991BFD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856BE28324E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904E1741D0;
	Sun,  6 Oct 2024 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBQCm1qD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAA1714D7;
	Sun,  6 Oct 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180390; cv=none; b=n2pMgOmvnZGAb5UsRalhbKFqk5Qk8SJE3imFwH0aQ8m0qpm7NOszwfQHyQKOmNt41yvvBlixNHWhSx1nZr9XE+Hf49S93L2w67eLB4ugzzCUaZcVD556PtVLUR2H0npqtctrery+4VbqRLGKDjOTgiCxbgZTv2AgaUOidxAITw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180390; c=relaxed/simple;
	bh=P8sJeGgHwVnEkli6RKvIJ7QED4Rvrpgj9uc7txlQ+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgA19RU209BpqMwTjNfhmhX7OFxlf4VIITBBRuB+4/YVMpv2EY3b79S0seuU1neOzAs+m+6UDacwaa80eLFd6SC7UPBHPBblwK0vpHr2SOtLV1DO4yUDDY29Z3Y7Q0rvNHgjg86cPJfEoII8L9UDPLPo1sKSp82pWn2QJFm2mYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBQCm1qD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so71117a12.0;
        Sat, 05 Oct 2024 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180388; x=1728785188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLrUlrlOioienJvbmM0BeIVC5LeCN6f3Qnt3aoZJr6A=;
        b=nBQCm1qD84a1gTklkmstDWkLc1OvBSX08jl99NpZgXqD5NwHrWjlhNgXLZx8KJuaJ6
         3WOMOmiN2SJ2AoOevdMsvkM/gP8NT/WLwC3z3oE6i8LfizsZUcAGGn+1g5HMH0vJLpXh
         Bwp3I05jyuQtVxXDavTj4CadgxfYoRs7Dl06WhsQp31VoTP4SI0451G05MfbeAFpOJwN
         K6adjofNydhipJpe05HwK/kFEPJqJ4x6OYn1xA3LdGVjdi++ZR+2RuJV/c06g5Bbft0b
         o1fbeUEfOrdWLJHXRL7/ockkQ3ja+YIvPqCjSNZcZ6f4Byc//2KdgRhP3Qkoja8GI0CA
         UqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180388; x=1728785188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLrUlrlOioienJvbmM0BeIVC5LeCN6f3Qnt3aoZJr6A=;
        b=bf68aQsRpRvr1Hj4pcbkmzs+TrBeEfUJBVxEXT2kej3vaZ23wTwUX/RPV4nXc7o/Q8
         bg8THb7kq4ygg0z2tKnvMD4v0NK2YgRV45kqUH/LGO7ZdxqrPWwXUiAXU1iiuQ9qMAUt
         5IPuH1YFb8WK2vOyRjuXBKhU5DmI4PPawiFnpBVeX0LSJCErob4gBaJJhdD2no54uMVU
         JQzp6I20R77RaUhuf06nMoCJVSerQLRhDBpTVceDhty0yXedW7/l0c2RIOgzJFOW9hPf
         WC2To+dqX2JgycYyIBRcLq9Jf8opaTC0Z6UGYaq8o70kaqWOlT3Lo8ZC/e8dSRtKK2gM
         Xpfw==
X-Forwarded-Encrypted: i=1; AJvYcCUtxl8HhhGm2NgmMki0s8wQcPJEo8OVn1Oix8C0XtZ24IeAK1Sjz9oDuiOXNbArsD0n/Hs0rvSI7MvyK38=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwure0iXwVR+QUkLmco/YuNBkit1f+JyZf1nu3u4h/xJfxWhrW
	kJfALiLt0JH9QIPOQsk0UYv9rK58WhzcdO+x7vfPMU3mBlksC2A83bbqGg==
X-Google-Smtp-Source: AGHT+IFP2hTXUcd1Xzdbvyrki0o0tSktDU4uoIimL5wmKvt8MrCCMVY/pq0SSJ+4ObXYArKpMxQ6qw==
X-Received: by 2002:a05:6a21:9cca:b0:1cf:6c64:ee72 with SMTP id adf61e73a8af0-1d6dfacaf8amr11032607637.34.1728180388156;
        Sat, 05 Oct 2024 19:06:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 6/8] net: ibm: emac: use devm for mutex_init
Date: Sat,  5 Oct 2024 19:06:14 -0700
Message-ID: <20241006020616.951543-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
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
index a55e84eb1d4d..872cdd88bc61 100644
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
2.46.2


