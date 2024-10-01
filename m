Return-Path: <netdev+bounces-131002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FF98C5A4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A81B233C7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3421CCEDA;
	Tue,  1 Oct 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLHtlsF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40F1CF5E7;
	Tue,  1 Oct 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808385; cv=none; b=DC9bFrldvY0Vn4KECMWG3cFLl7ailW6ZVXeCcMIZA5QirW0n//CXukqlmRngGLX8Jwq1OvV6gd8TDHIPvCojnS2S1f+VLSJUVIeh+/huHnIVFLZ5l4mptaz2XXfE6B2Xct4iIA+IIMOq+e2eBo9NqM6Hg+vyso73Ihwfwynpvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808385; c=relaxed/simple;
	bh=oBwbWw/9CxaXZnlAYvzrzDct5UB25PbolHF7gOCbSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIxd3g652EhsSVPAuNggNhHa2dZmjcEmAF+Tm63R02Bi/cVZhav7xYOAXZnuqCzO+0fDcaPGOt9/9+NA9rL3mYFXZGCc1R+pVpoANdkM6fkZMdvktFfqm8u6Ys1G/MdgFEcm7eTJENAgN5SScc/Zt2PgiRPG9nHxgrCWB0hUAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLHtlsF1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b0b2528d8so64572125ad.2;
        Tue, 01 Oct 2024 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808383; x=1728413183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOzq+Xn81iHwv1RE/9XVccEM8Hiiq18ZuIc0MA8ZuFE=;
        b=MLHtlsF1o77EX5AtS8PhHFprbFGI3S+g0Ef2CEkv9sZLlh9KdoMbrmj7tchbMZM8VM
         nXktM256orH/FfjWGKczBmYfz/reOuZ7749NeSyBHPhgauv0rjFuj3gtMPIScBZD723m
         QuON0c7/TGYHzfxEHltmqtjcwVYbUZfFPQ3qHjC1d/KhdKCLGXjfVPLbfiswTvbFH2pJ
         jzc6HcJw6CtvItf0vXLprv5LWnhz5fThzhLlnBxpALbv0ecw0d2LNbF9r8s70BXDdOiU
         o4buOBzm1yasgY8UaMMctCgwgWVZDlgTL33SuTciz0mgKpVKGS829gMX6ZYSa/LNlJhu
         zIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808383; x=1728413183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOzq+Xn81iHwv1RE/9XVccEM8Hiiq18ZuIc0MA8ZuFE=;
        b=N4cRG3EwSE0TWlfWZdYNxYK2w7RjDLaaQBNpH6itPf0xplEs29Vq4IP8Tax9w1/OTk
         dbjZz89mShSBmTxdq4AlFWBAv9vzK5B++sdbaXg3YQMIDbMJQG5S2JNMDtHOqYvDLvxb
         F+EcEosGAd6mCEN0khyl0p9vgbDfoA2O/SybO7E6b5vbEX0vt2Nw77nfULM1mpu3g8Il
         q0AZCLbQpU3RSPn8gvLheZG+ks9xKBjJwGp3HCqvZyJNAPLVOo1c6wefLfkiTAiMQ+bT
         DbLU0nWEnNPHOXvcOH6VLnQfkhHq78RLq0ZmU2VtaO0w1YhlBfFsYFdmTU1EfpvO4VZh
         WHWw==
X-Forwarded-Encrypted: i=1; AJvYcCVq9/jtyxZa4wLc88PdYn9O16nF2B4TyW2P7QqRssMszBkjYONVQgILk3bcgbe3FgeCccoTRZgtgvmioZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGmVRlwqKE8gCaxxUnCqIC0cLnX/Bvv/Hbtwxu5FeuA0g3Ugn
	N0hpJNrbO71f9eA2EkvzUm837JFoRm8hH8Y4guR1WGwD21JMd99hacdYdDiR
X-Google-Smtp-Source: AGHT+IGQWNV35HtYSd7MU2z+cP53LTfzA+A+khGoh5hl2bmmBj23E9jKsfe2LtLI52db8lk4uak+aA==
X-Received: by 2002:a17:902:ea02:b0:203:a030:d0a1 with SMTP id d9443c01a7336-20bc5ae2a1cmr7022275ad.58.1727808383452;
        Tue, 01 Oct 2024 11:46:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 10/10] net: lantiq_etop: return by register_netdev
Date: Tue,  1 Oct 2024 11:46:07 -0700
Message-ID: <20241001184607.193461-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler to do so. The error is not handled anyways.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 355b96ecc5ec..cc5b94bc30b9 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -661,12 +661,8 @@ ltq_etop_probe(struct platform_device *pdev)
 		priv->ch[i].netdev = dev;
 	}
 
-	err = devm_register_netdev(&pdev->dev, dev);
-	if (err)
-		return err;
-
 	platform_set_drvdata(pdev, dev);
-	return 0;
+	return devm_register_netdev(&pdev->dev, dev);
 }
 
 static void ltq_etop_remove(struct platform_device *pdev)
-- 
2.46.2


