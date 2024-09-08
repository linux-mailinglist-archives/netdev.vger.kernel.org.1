Return-Path: <netdev+bounces-126314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1F5970A25
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 23:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E3BB20A8F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756617AE0C;
	Sun,  8 Sep 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtpiqaVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD917A58F;
	Sun,  8 Sep 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831358; cv=none; b=BpuY/a88YUdylf2Te45YokUl7jghN0sL6pTjD//AdKMiK2wTOHEp2EdgFS/E6pyn7Qoc/vCQUSp8VXwGUOarDNuF5GxpKxLiFKMfh6nWeYnwSlE14yjD/sbuYGMnPsp88pvABYk9M2L76INTDph51S14gdTaqhkEG9oTOv2tjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831358; c=relaxed/simple;
	bh=fubqHbkHH4SF5tYIPWwsKVb2qi6cZSP4EmzHAKL2A2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZKtWC9Y/+aMbZ3C+2UQJU9YiPAijlmODrSlX2RKMZZ5eIi9b4iQH32beco16n4H+9Ywt5uvuYNaf3ruCbBKJfDbqsO7itTUSgzdvO5hV6BRe2H1KSRcgiZIFo1Ee0d1kjUsNvhnYEXdeXY33riRunSc3lUvUl4Iuzym9WNZtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtpiqaVj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e1ce7e71so1226786b3a.3;
        Sun, 08 Sep 2024 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725831356; x=1726436156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boc/hrUVj2BcleHfAR4XpgnsXco5z7XH6lSAfMq7toA=;
        b=PtpiqaVjFfXmPBQAt0vTTV3Zc8Vl7Bc9WXikRxLFfP2ACkfZAVdtpoqRYllmkHH/ar
         OtDNGHcRn1B+h94CiZKA3KRCsptEyJfkwJVTxeculQePh9/BIk93FsmK2CkhcTsJxE7e
         jU6LvRGRqYeDneC8S8jQKg0rvH7eaVj0m+SPW64l9yEy/m8NWh9g9PAuKkg6F8ds9B0i
         v7AdAt/apeSpcLzITsqAymSCjrFkuwSRqb5HgPaANGMj1yumZ3m0neXLwgWzZxUdfra5
         as2VyP8oPkik94AYGhnMmgz//TP/bCAFpA2q2Cs5/MbsRMC5FSjUHUih8j3KvCD9Q806
         wVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725831356; x=1726436156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boc/hrUVj2BcleHfAR4XpgnsXco5z7XH6lSAfMq7toA=;
        b=nLa1l61n84ecnwYupMve8MKp2S9iCesVGJtT16bZQJB33sg/Ym8pOjYlEQ8yCqnn2f
         LE+FguXO7p8sXGv1SWVtEg6Aytes23TcqtS/8SDJEPf8HMpZVy1NfMCgrVqj4RbQipJg
         razEb4Vqb7ec6cp6q53lftgHNVXyrPNVKdNDCQToqLqx/wkJX21qy53amhEa0l1U+Kr9
         nXxchfen4nF4komYosOUKy6qtVEjLYfeO1WetjNNt1QpODB9VTV/EvN1+F9ncYYvrxdB
         tOGuI5eu9aJDwj1XL3ZW41jRko9Uk2MfSKnGo5e0Efp/b59jbUhPz9V355a5NE/87YJ+
         SAhA==
X-Forwarded-Encrypted: i=1; AJvYcCVFsKPIf1nJYoBGcmwLDGoQEtjc6VUOGvf7BvEZ7F5ejIHH29g4Y05nwuii603IKSO9YBX14yDNGYl9N2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl06P8T3+xslVFLcbOl0wbiXlqxAcZ6743rloNu1DrbBZvR8TS
	4bovXRGhCglFNzKP3RFt0YGm6oC1qf/AeacD3yuaSUHKKaLorgkNUokufHM/
X-Google-Smtp-Source: AGHT+IHUyDHPNXlKTm78Q7ds40dBKEWFrRXE5j5/uzuCN1NYggxLCssa09n01jEIywSx8R+Eh8I/aA==
X-Received: by 2002:a05:6a20:4389:b0:1ce:ce51:4405 with SMTP id adf61e73a8af0-1cf1d1ddf8emr7600631637.42.1725831356475;
        Sun, 08 Sep 2024 14:35:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982fa2sm2398187b3a.153.2024.09.08.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 14:35:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com,
	mail@david-bauer.net
Subject: [PATCH net-next] net: gianfar: fix NVMEM mac address
Date: Sun,  8 Sep 2024 14:35:54 -0700
Message-ID: <20240908213554.11979-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If nvmem loads after the ethernet driver, mac address assignments will
not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
case so we need to handle that to avoid eth_hw_addr_random.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 634049c83ebe..9755ec947029 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
 
 	err = of_get_ethdev_address(np, dev);
+	if (err == -EPROBE_DEFER)
+		return err;
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
-- 
2.46.0


