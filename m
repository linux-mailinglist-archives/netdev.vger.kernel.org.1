Return-Path: <netdev+bounces-151274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66839EDDB2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F39D18848CC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178245027;
	Thu, 12 Dec 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="bU7wRfH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01518643
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970788; cv=none; b=G7FsMw/+l+BjpJeCS5HnTF6iX0JFesQSHHw4mnogmfGaXSRwiQ7grkyEZ2RRLEpp0VWzWOG6X0T4PC0GGGeW2yrVQ7itTGFTDbtXO4AnIf5zcOpjJZxWVAFRWp9PwYj4J7JHvnzJ0Jcnkh2JK4xhozy2YzDOGdz0H6yc9kSA2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970788; c=relaxed/simple;
	bh=D4GKQEcZ0/I2A+Qs62rc+bBhXvDD2Oj8V8CFi+LmAs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbGswPtMGhUeSsyPEXu+D+vZ3cj15CF3Cll424ZYgi85OemgAa3o9nsO1amVeeY5xCeMW4F5YRmdDbrHLKgT/axptElbKYzFWLBFKhXBH24ibne6Cnd3E0WWQGm0AUE0c3gRIEon/r1eM+bSA8DEgd4qhtxpC5h5FN+mLeHm+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=bU7wRfH1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f4025e25so92048b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 18:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733970786; x=1734575586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=culLUjXgQf1PCKdDSJG3rk51jdWiWQDjWoRpzLsnb3Q=;
        b=bU7wRfH1vJbHMd4GnUJqAm65ozIo0ID/AcVY+gvEyQjUmlfxvnZ3vCp6r4ZxtdihbZ
         hwRYeLPBh6S142KUJyXWukfeZglkhQ1cWiAhu7M2ygMXyBZ7rxSORTAuwsoeiCpx9/lW
         ++muV95eSxrgj/d7L2CjTZeNshcMO6FQuXmFKKT8CIj7HWJHU5aCNOdMJKF1VoAwWTgK
         t3R9TPXegkZZmAbLYH4WFTRnYR1rg2AYu90hxl68tfhEQNHOn0CuO+MO6KhKS6CL5m33
         kNSgpJd4gkvTQgdvYULumKD4Yy7trr7yYf2MbBHaGcS2LlLahX3nLgC1/KRXwTcQsIvE
         N/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970786; x=1734575586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=culLUjXgQf1PCKdDSJG3rk51jdWiWQDjWoRpzLsnb3Q=;
        b=RYXJah83u5emQs70geQpCRaVVK2BP9EMYwqzGZibGuZMr03eHrmK2BDZFALVLm05TN
         pXW/2VLrubf9dDWddomgTheAm62II4ANaVgfuWfwYaKZAXamZuxSFDSFCwV0xG5AWnI7
         YqXOD527jS2szV5qNI0kW0S7fmoUwjsCHk/3s4HhhPfZznL47UMAmbjTpA783xa6lpjX
         rH/lEBJPJhu4ji4lXzRsodtAT9J3bdS3NKY2sK4z8Y5Vdv5zbS/OHmQEiIZZNn0Mln0L
         FavFo9848Wx+mohwCjwoV3UXNYDVS9N2R8d5Fy7/LpDYntjKTdhzwE7cXGyaGskx5Cxv
         MrmA==
X-Gm-Message-State: AOJu0Yz2RDaArfSPaVki4DeG9oat5D04qHueAlXOt1nyylponIxNm6Zo
	FmBic6RQZ/IanaBEkCBbhMARi8mticiFVJIWxd5EQlpjC/SQbLLBpN2QC1rnfHM=
X-Gm-Gg: ASbGnctTo1HWRREVRgFDUncF5MUS9WVy+d93zKBUNpdhtwSXCuC1Ja8/oy5US0fgOfo
	d3nhs+qPYoAed3saEx3+3SBGAYlmw0DdWRe3deDIJBck0ytX9apD8D7WAapT6h7dmT+EFcbWVd8
	RpxbThT15jw6OFow3mGXKhGACmKHBk0opoc6vAJzmVIOLklB9aCDjOrRqUbvSA+szHtmpNobZRG
	BDJMf4uPHAUMLvKiHBm5zQJ5wFO10NazAceP3QoOIVj62MJi44jcBGeYuRQDqunIIZnCq1fSMfh
	7uK4VaVzVukQvG1cFvlKoDJubpazU9NItJMzdgfXgWw=
X-Google-Smtp-Source: AGHT+IF3v9FE2nfnShP56v8x0zeB1I4jIbscDq/zAC08Jjg5QCd0BhxXfFJ+AVySwy1L/xe2E0H4/Q==
X-Received: by 2002:a05:6a21:3985:b0:1e1:a6a6:848 with SMTP id adf61e73a8af0-1e1ceb0a07dmr2786451637.25.1733970785959;
        Wed, 11 Dec 2024 18:33:05 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd50fe6a58sm4598360a12.11.2024.12.11.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:33:05 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafal@milecki.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] net: ethernet: bgmac-platform: fix an OF node reference leak
Date: Thu, 12 Dec 2024 11:32:56 +0900
Message-Id: <20241212023256.3453396-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OF node obtained by of_parse_phandle() is not freed. Define a
device node with __free(device_node) to fix the leak.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 1676aba5ef7e ("net: ethernet: bgmac: device tree phy enablement")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/net/ethernet/broadcom/bgmac-platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index ecce23cecbea..ca07a6d26590 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -236,7 +236,10 @@ static int bgmac_probe(struct platform_device *pdev)
 	bgmac->cco_ctl_maskset = platform_bgmac_cco_ctl_maskset;
 	bgmac->get_bus_clock = platform_bgmac_get_bus_clock;
 	bgmac->cmn_maskset32 = platform_bgmac_cmn_maskset32;
-	if (of_parse_phandle(np, "phy-handle", 0)) {
+
+	struct device_node *phy_node __free(device_node) =
+		of_parse_phandle(np, "phy-handle", 0);
+	if (phy_node) {
 		bgmac->phy_connect = platform_phy_connect;
 	} else {
 		bgmac->phy_connect = bgmac_phy_connect_direct;
-- 
2.34.1


