Return-Path: <netdev+bounces-175094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304BA63366
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 03:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BC03A46E9
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3AC383A5;
	Sun, 16 Mar 2025 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNbQXHtx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8081CD1F
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742093929; cv=none; b=KNRRa1MU4ZHjvAjPhbMLyMhkk90o91Eu17ozSQmt8wv2kSZZZJLfrfII7DHsgZHWn8QwlizktS0wiLoZVAn9mZ7Ntx1POj7QQ7JvSlTtV3rjPBuQQ68u/LQzEdaGQ7wEKMBaiFGn+umca0+QSgykh54X3PGj6fJeHcasGbTeAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742093929; c=relaxed/simple;
	bh=IYM19E4jHKYMAlkUBAKn988TsHRXbTbWmGtepbFiYfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bh3pEKCVKrTtFmoNXgFxHAUfxOA88rj6R/YFO3J9v7lAn4WcIYIeaBk+2UJIp8JE3kOOvHgSKmMfT1s/LLQ01xzQEFUh/ZCkydPUu9w0LrGu2ZZFUlzN222upEhSxIcoDuZCw6bIqe/DrkjZ3J4VmaIBvHg7t+iccKahxj7rhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNbQXHtx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22548a28d0cso92160955ad.3
        for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 19:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742093927; x=1742698727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLXLhmOiyJG8LW5YEhZSnK51vBheIvTjAeUDnWGzyaM=;
        b=dNbQXHtxbsYL0M2wndKv6Z1jg/tBKBkACIkt2dlp7yvSBt9FFVRd/km1iYRA6lcJSG
         etdhTlz2G7wDlqgIFHNXfrn7PvPlrmXX9zwHcVMWdclhlRdlS3UrsfxIxVMRZsQjDxAR
         2q8UFCPH8LysHpkI63BFpdmvgnf19FYIsueJ8Sc/CXc5d+A1pmq8H5JfHGLSl2p3EOQz
         /5Fr+HNGRPrRAygKvSWTe7IBF9IW5tv5EVHp+MI9qsNO8sA4mOJmPTLskxVYlmcpDpGf
         OK8cs47AG33Ebm2exIbePuRHhDf3rhynSPNVoITvdhCj0NUnBkk8tNRqU7Edi3gUX+kz
         mE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742093927; x=1742698727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLXLhmOiyJG8LW5YEhZSnK51vBheIvTjAeUDnWGzyaM=;
        b=XrGdLrD9uJSDE8retd+VI92P644srnnn2DiR35X4wXc+ZpUvm+croceITVv/515BJK
         Os3pJYqL4tAc7ee9uQ0paqqIFzGsEurzGDXdL8maHTrGhKY798nvPWazcH3UDFQ0jaiE
         hozlKyzuznGVcNHgzpzGsqcUeIRcWb0XRJ4tbPRjW0IBLEIxrY6OOqY3D/vnheK055YK
         PvGeBGBfIMHjBnN5i3/pKQC73/+QWswdLxeeWhKVlvExOIHcEYTwOP38a5u+hRH5KMI5
         aSBloacZb5Uqyu6Tom81pQPsS758lwJxWqhOieNw54RU/ALnk/oIrKXjni+lE7NnYYwW
         SxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOzH7WMeG+T/D9CHJSKU3jpAJRA90aQMU5DcdvAxmNK+xNeIvKEmmsRTMWQ1XXFfYd/7tGWNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0WlCx0jdQWqFzAwBTgwhpXxGQ0VrWNy1X2PEmsSL/THVlDxh
	suUlxFhM8maUsEDOC11ppzFwYxuFDv17DPGV3dxjX0mnR5AEv8kB
X-Gm-Gg: ASbGncvO2ln8tbVLZs804aAEPJ6ptPm8NVVPDiKMNlv260i7dWHOQkRaXly4YIstVB6
	i5Mn3TEnrFJVaVVrzauQwoZT/6ydbKcWclfsRC1qOvtMXiJdST5VqAxj8Wyfr/8gTH4j0ijMNlm
	ujQ3jqEEEOCgU9XUbGM5NBs1em/NuJeLs7ZWwDWx/H0m26NezALNB/GS3fzgOAX/QkTr/PKkvez
	dNGYT5y4l4eVtnN+qSs+srVMtC2fYmXCK//E1JefaufFYfEGCEy8SkKoMFyHZOspzvLBx3PhrqG
	/mhQLWD3C3UisWE9jBAeKxA2NemaymQaoBDKrUdR9B+L
X-Google-Smtp-Source: AGHT+IH2HaSeSN/ggxUk29N39s4gUmALE0M+Zy0STRBVZrZBy87ILI1GloNlit5PzJkpw4VPfxJkMQ==
X-Received: by 2002:a17:902:d50b:b0:224:76f:9e45 with SMTP id d9443c01a7336-225e0a5bdb1mr98131925ad.21.1742093927227;
        Sat, 15 Mar 2025 19:58:47 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm50784385ad.70.2025.03.15.19.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 19:58:46 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: ap420073@gmail.com,
	somnath.kotur@broadcom.com
Subject: [PATCH net] eth: bnxt: fix out-of-range access of vnic_info array
Date: Sun, 16 Mar 2025 02:58:37 +0000
Message-Id: <20250316025837.939527-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_queue_{start | stop}() access vnic_info as much as allocated,
which indicates bp->nr_vnics.
So, it should not reach bp->vnic_info[bp->nr_vnics].

Fixes: 661958552eda ("eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 55f553debd3b..0ddc3d41e2d8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15651,7 +15651,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
-	for (i = 0; i <= bp->nr_vnics; i++) {
+	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 
 		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
@@ -15679,7 +15679,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_vnic_info *vnic;
 	int i;
 
-	for (i = 0; i <= bp->nr_vnics; i++) {
+	for (i = 0; i < bp->nr_vnics; i++) {
 		vnic = &bp->vnic_info[i];
 		vnic->mru = 0;
 		bnxt_hwrm_vnic_update(bp, vnic,
-- 
2.34.1


