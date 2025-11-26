Return-Path: <netdev+bounces-241855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B96C89663
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D753AAC9B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA931BC96;
	Wed, 26 Nov 2025 10:54:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7927248F7C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154493; cv=none; b=aAfE7uIHgeXvR0OvMtFPZy225QcD0Sj2G8NVHL3RlhKcJ1/WLNLbexFFYB6u2zCYJDLL3NyBUGS0sKw1sCBSJmvQhXD6tXvdfsgdqDIcjNlc53dSpw3Krx4DXyvEF4A8GJIarLyi4z/Pc+rPBBp4XRlpcpSUXNRpOydD51bWTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154493; c=relaxed/simple;
	bh=tEAuHtS8/XCUiYcXWYUoaNe7PaNE5xwF6AJ8POofAIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GFpfPyEUC7F1JhQ6AVTSaMBFxe7duhJW2LfvhFjPA23e6Gi+ddK5Mwvv5F9f3CDnYA5xGEAWdjt9ruX7QDTlWcXih+tCbr9DrhL+5bRndEHRz9tCPe0XvmZ6RXZJrsUTdtL+vFvxO0DWGI4meWqL55LlM5sM+km1PEJxNRDrd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3e8f418e051so3827629fac.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764154490; x=1764759290;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTTCxc4MaCFCb9ALndfPRwOpBtfwAOdIt5SutWfVfSI=;
        b=m1cpheRm2+lK1JRU3sGNh1cKhojIVUq+i5On582NZoDc9MqNh4QnSIPVoDKTKwS/3Y
         CEtX9eNewJCJ8fwqXHESeH/1u19abvSWcLED63pf9czW8l0/UzeX7Hl8ekrmiU4rEqZ8
         ujKik+TPNugrU/BY/deviuYEQ4HDv3eexurlqAPd0Xy6HBF9yGUvRcejJj52Sr96sLGQ
         4QQ+ytJ5Prg/ydEasoVYvS33fMt+uzK+iIE1Afh6A4I1TKWdSaXlreGXpUL4zV1PIEPy
         B9Vkz9ypsjJg+V9N7SOWfoxA7RT6ufkqufQcu1mqDlj42Gk39rgYFApk459YO6wbtWvD
         V6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXYhU8JTGYbmcyENVSfVtL0MXSKBxYnp3bwOVMuqTPIssn6/fLhdHHOmkqfBH9u3vlmRONUtec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQmUYILpCDbXQnvWZN2ieW5Ars2DptLt1MBSjTfKusUmiIuwO
	b6j2mRNCHx0JNDd2pWX7B7i8FudUWY1NHyAMIVIETjBof8n7ZMX48s+t/VQGSQ==
X-Gm-Gg: ASbGnctzt4Q+kyF6Hc91n2dPa5Q8vDOoPxokEppSnoaRiC3yZF8KWDfCyNgcyskHsaq
	ZmlX7+Gx/slc1HCD7FZha7z0taYOdmvlHtK3YsZt1dMzOt9MAzIW17TkslBc/QiCLIJQyFAgvk0
	8YSRJ47nf/XlWwMAiYVwuV3WlmTUMUHW1+4Qlbawy4977JHEA03QJYgmQNsszA8qJeoK1UDQffB
	+/+q35vKsPCfep8KFNsq470Jhg2bf2iwPLJfhykkls/XbwDF0nTzwQLTTizTGe8XuTAvSSqASas
	kpx94WKjF0htAoe8Ahr+aZOsJnjgryDvTM6BYiXQ9Ig9pyKsaIRz6wcAL6OfxORt7ZgvGamJcji
	4y9qYxTXTOwrW/pEucCarmMxSD+6c16ftJn8Qi1EEMtcHpeJb0czlaCniQqLeXU4BZBh6+Q+kTT
	qUMTwauNMaF1LEPg==
X-Google-Smtp-Source: AGHT+IFuKu9CL4OmitweQtj9FWFp7CoKQ0umbOJ8FTbSZuyLzYDItiE7AmncPJ0P+j0ZnTiSsNAoyA==
X-Received: by 2002:a05:6870:ac08:b0:3ec:53a8:437d with SMTP id 586e51a60fabf-3ecbe28c21emr8317882fac.6.1764154489592;
        Wed, 26 Nov 2025 02:54:49 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dc8e0e1sm8914485fac.18.2025.11.26.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:54:49 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Nov 2025 02:54:40 -0800
Subject: [PATCH net-next] net: thunder: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-gxring_cavium-v1-1-a066c0c9e0c6@debian.org>
X-B4-Tracking: v=1; b=H4sIAG/cJmkC/x3MQQrCMBAF0KsMf92ASTHQXEVESvpNZ+EoSS2B0
 rsLvgO8A41V2ZDkQOWuTd+GJH4Q5HW2QqcLkiBcwtX7EF3pVa088rzr9+UWjhNz9GMkMQg+lU/
 t/+8G4+aMfcP9PH8m9xnXaQAAAA==
X-Change-ID: 20251126-gxring_cavium-de39ec6136ee
To: Sunil Goutham <sgoutham@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=leitao@debian.org;
 h=from:subject:message-id; bh=tEAuHtS8/XCUiYcXWYUoaNe7PaNE5xwF6AJ8POofAIg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJtx4y8QFI1JwZMblGTo8qDkuZF4qybDcdBql5
 h0VQ5pCeuuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSbceAAKCRA1o5Of/Hh3
 bXeDEACBZgnKRto4wtRjoIQIlcSdnIQi3vbv5myNO6X0tvt4WG/399mJXEQO/w7BVFdDhSBWe+L
 Ewl50esS85iqi/nBJXAuIwKWWMx+ObIEsu//gm5NvHLQA6Yb2Vtk0zKP42Zid6ZJi/8Zxkm65Fo
 rkpRDzQs7DIhbkSBDngxHFI3WFHVMVteAt2/bTXEDJ3N4wBvdeMiGrzvaSvjiUQ+cFpoAm06Sy2
 t6A2N0V2pMba7+xLl8QHJ3cUcQsumW2ukspZoqR0yUCj0pncEr63nkZasALZZ6eK+ma34CzsR8W
 u6WijiHofTTvLkTGkAy+HGanOhQIT2FtVXtcVSQDwOREqQuploy4coJJO/7XLdzPSKDZ9ZSsvUx
 l7ieqs1i5vpB9cLyat0Bqneqx7tyEm76zQNiOF3ouOoUKID8sTVPbsM/6svfxJ3aUX0KXfEfkAw
 m9pwMBrUSnT0QrWfJ3KqOJxikgBki5dkpwau4yTB5p2M0NfG/UKBPeaZ6naOu5CqzPeQKONhrDk
 9gXlAyd/BGrjAkqYt1ugWHiYtmlEgbI67u3OWsl41fLYhevyUTNohGl38Luw54cCcR7msjjqbYq
 +sscrornSqZFRod3ZYzr8w61/+RuN6uuVcK8kSMDgzSjvl+7R/UePxD3Qlp28k/uQov7jRpXd1M
 oX/nzKHO/SPJODg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the Cavium Thunder NIC VF driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc solely for handling
ETHTOOL_GRXRINGS command. This simplifies the code by removing the
switch statement and replacing it with a direct return of the queue
count.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index fc6053414b7d..413028bdcacb 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -541,21 +541,11 @@ static int nicvf_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
-static int nicvf_get_rxnfc(struct net_device *dev,
-			   struct ethtool_rxnfc *info, u32 *rules)
+static u32 nicvf_get_rx_ring_count(struct net_device *dev)
 {
 	struct nicvf *nic = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = nic->rx_queues;
-		ret = 0;
-		break;
-	default:
-		break;
-	}
-	return ret;
+	return nic->rx_queues;
 }
 
 static int nicvf_set_rxfh_fields(struct net_device *dev,
@@ -861,7 +851,7 @@ static const struct ethtool_ops nicvf_ethtool_ops = {
 	.get_coalesce		= nicvf_get_coalesce,
 	.get_ringparam		= nicvf_get_ringparam,
 	.set_ringparam		= nicvf_set_ringparam,
-	.get_rxnfc		= nicvf_get_rxnfc,
+	.get_rx_ring_count	= nicvf_get_rx_ring_count,
 	.get_rxfh_key_size	= nicvf_get_rxfh_key_size,
 	.get_rxfh_indir_size	= nicvf_get_rxfh_indir_size,
 	.get_rxfh		= nicvf_get_rxfh,

---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251126-gxring_cavium-de39ec6136ee

Best regards,
--  
Breno Leitao <leitao@debian.org>


