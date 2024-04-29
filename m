Return-Path: <netdev+bounces-92261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5788B64C5
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90D51C21C75
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2001184116;
	Mon, 29 Apr 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjwFzcWC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F318410D
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427115; cv=none; b=T4CC13BP/3BSLO06qxeQTKnuSn/J8Dg1nRJEPAxMgRiDM6ti+GleZjI5UOxPWK/0S1UPA+BWP7Xdq7miXXVDACFmxvRYVwkPCMUXEKIEv9/nd0S8FFEliAnrOSQYnyxlszerzTnoUkBI10UGs0MOJ1qogVQSXf/x1QDqGcXPi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427115; c=relaxed/simple;
	bh=Q93dw3eKrm4AOJORuAk2GQV34PUlaSTj4Mj0/loawWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bzmqfUsmTayr7ospZXB2dSpSRDOkZB4IYik037Vr9sa4a4uPl7FmqnJJ02DIjHC+gUZJARbRJZSiDK081NOmiQsTy3zfzFWDKL5RQ/y7hDCEPtzbktt9Lk23ETEY3Xv2VUUV0E2XoJuSlm+xHFWXjs6P6vq1RquvuE+loHMH1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjwFzcWC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714427113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdU3RyAhhNJtPcn7BJGK9yJoXLvf1QCQv7HYg0QISNs=;
	b=IjwFzcWCeFZXXEhVubskF/7Hl8gSXFYfH8HVjSNZRaHNssH41kdT6QIAIBpb2KeTeLdqvy
	d1b83KmiiT2aJMo4H25kbHWWcVPieMwEATQKnE+5ncgwLiXcAIzfk6Sw7A03RjiHiRu+Yg
	BERvRzGw2FZlgbEEhJ094ILbBq6UQlE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-6nNG-1uqO6S7UbKyS6ZBFw-1; Mon, 29 Apr 2024 17:45:10 -0400
X-MC-Unique: 6nNG-1uqO6S7UbKyS6ZBFw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e63ff880f5so62265525ad.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 14:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427109; x=1715031909;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdU3RyAhhNJtPcn7BJGK9yJoXLvf1QCQv7HYg0QISNs=;
        b=LkKakt+ZnBVDMJdeFSv3mGMB7e9PQm3DgltedK2XYAHWRaojwglXUhA1nu0Q36ZCnp
         gKJY/ogH5cSYEPChnYLO2tUtIs7E2YKb9ZmVGHLnf3TOHrWoiIv8epCnQTy+hdC7gvUJ
         Ofg7JZQ/62wb3YAGjsnQpY/0A76uV1oh5m0Md0iHARYMTOtmQlF4ZuqN7fxAcg6bEVdr
         G7D3JKFIdiRWsI8m83CapXOp6a0suAn1P6ixQtXcKVHaPzVg0g0IN3da3gcYWgIrN8ls
         SNgmNr8yhtMgF4uKX8ggNOWWHhLyV9MQwcx3MmagM17DE4FMTmce1wRi6tQa88WQ80jK
         8NmQ==
X-Gm-Message-State: AOJu0Yyhgup3jXzBCCzyoIo9YDI21yJIEr4gh1RrSlsU3YEQ68hfBSxV
	cyUgi4/gDXW7Mrp5CkZ5dgBhKGeZ2IQLwfR4PRXZZBc7dGkA17B1LewOXnhrRNxnG97chF2evVZ
	EAnJ5pSLwZu6AorSDAOoKK55x+Bz8dC00l8R4PC53RxMDP154o16OUg==
X-Received: by 2002:a17:902:ce87:b0:1eb:7285:d6fe with SMTP id f7-20020a170902ce8700b001eb7285d6femr9045676plg.23.1714427108689;
        Mon, 29 Apr 2024 14:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRQ9LT7NJkVOb6GUEq9lwThklv0tGP954t0tZVLJEW83PPF8uBigHzkBa6EHJUPWcRTTkqQ==
X-Received: by 2002:a17:902:ce87:b0:1eb:7285:d6fe with SMTP id f7-20020a170902ce8700b001eb7285d6femr9045663plg.23.1714427108354;
        Mon, 29 Apr 2024 14:45:08 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001db8145a1a2sm20731655pls.274.2024.04.29.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:45:07 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 29 Apr 2024 16:45:05 -0500
Subject: [PATCH RFC/RFT net-next] net: stmmac: drop the ethtool begin()
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com>
X-B4-Tracking: v=1; b=H4sIAOAUMGYC/x2MsQqDMBBAfyXc3MMYg0PXgh8g3YqD1Yse1EtJj
 iKI/27o8IY3vHdApsSU4W4OSPTjzFGK1DcD0zrKQshzcXDWeeudx6zbNk4oEUlXjfGDb1pYMDS
 2DS7UBQ+l/iYKvP/PL+i7R9V3TyOkKLQrDOd5AQ+jaCR7AAAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

This callback doesn't seem to serve much purpose, and prevents things
like:

    - systemd.link files from disabling autonegotiation
    - carrier detection in NetworkManager

prior to userspace bringing the link up.

The only fear I can think of is accessing unclocked resources due to
pm_runtime, but ethtool ioctls handle that as of commit
f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool ioctl ops")

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 542e2633a6f5..c2e2723f7c6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -438,13 +438,6 @@ static void stmmac_ethtool_setmsglevel(struct net_device *dev, u32 level)
 
 }
 
-static int stmmac_check_if_running(struct net_device *dev)
-{
-	if (!netif_running(dev))
-		return -EBUSY;
-	return 0;
-}
-
 static int stmmac_ethtool_get_regs_len(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -1273,7 +1266,6 @@ static int stmmac_set_tunable(struct net_device *dev,
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.begin = stmmac_check_if_running,
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
 	.get_msglevel = stmmac_ethtool_getmsglevel,
 	.set_msglevel = stmmac_ethtool_setmsglevel,

---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240424-stmmac-no-ethtool-begin-f306f2f1f2f4

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


