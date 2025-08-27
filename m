Return-Path: <netdev+bounces-217301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C62B38414
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01DAD4E1324
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503852FDC49;
	Wed, 27 Aug 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UizGlXP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D73568E4;
	Wed, 27 Aug 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302675; cv=none; b=A6G2wzIFOqWC8R3XXqUPBVtolFaZra6jpxRBrQPm/BmyFvlKYhtXlaaz5+d5BKK/9zik+zsUyhmSyR7Gu5td3snjYHmKwzaMTL8ZvFQF8CH//t+3V6aZNgVggaFCuTPFRGihdR+fuHbCXN53h/f/5SPIQcNZStYZef8tNpdHJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302675; c=relaxed/simple;
	bh=FDp6JCd4VmqsLTMSNBr3ve+PytzAcHAJUe6Z6k/jtyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gp+ZuZxUEZHn5129MJSfKImbAeaDnjfqiQFsoqXbsAIe5cYHsPHsLwxH2sBheFWGHQQR+audlDonFJLHqV54gHNlWVVOSZAi9x3tGKXc9RX4GzbYe5/hgfRprWd25Qh0XcnJORnX4RP3BxYVyVsfyudgodxavRz3+EVtsgLEXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UizGlXP+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f581aeso52467075ad.0;
        Wed, 27 Aug 2025 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302673; x=1756907473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUcA4fP8xyhB0lHPFGrUj/zamcTTqzoLH7svjxY0tDo=;
        b=UizGlXP+GQ6lNXIrA8dj4HVOabSiZ8Y8BgKbVz1GVzy/qrVsw8vl74sMGzuuwiJ03v
         T/KLnyBuQ44LZ/NuwPhvu65nFq9bhW2wSdaKo11lgzli8YGa9DmgeqZMr0VuKTzjeSYp
         Upjqf2a+MmTh4TnajyxgLGm+aK8araDjOBnclLrG7zUwP6aaZGic+YlrwKPZwGnQ3k+y
         Jk5YWB4sDsstbjxAA1uUE+ac2ErLo6CVG7YZ8Jika31/006KXGaYv/+09EngvnXS/7zw
         MxEm151InrWsGXo8nuSsFmXT68MNl+y9EGGrBbpfh7fk9Z4B7pf/MPfwn3eMijR77N7s
         yA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302673; x=1756907473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUcA4fP8xyhB0lHPFGrUj/zamcTTqzoLH7svjxY0tDo=;
        b=QAv6QSwnTIR2KtbpPYbNakpPadiNBEI0YE78mSCpg+jEQI5mQW5M+QDUCq5VvwjKcL
         F2UTdLY2xNYxFN0GnX3dh/ThAQKPx4Awk2J6zJEkQGVWUNar1dzQYzBDMB3ot5E7/50i
         nBgcK8k4kqCzKgDPXveMfMc/wiHVhfQOH8Tt8pckxWRsq3eVVisT0A4Bhp1kGoP+HhRS
         lwAf6u0bPC0vUW4vAIxFbxbM0s/fn2dKra3A9+drkcl89LvUAE+hKqPMCLxg3cdymlOK
         gNrTSuEOs6/LAS8M9nJ6jouj2K/4aPWUDQPFkfohECFWirN8J3zh7io9BDAe9yG4g+oH
         P3uA==
X-Forwarded-Encrypted: i=1; AJvYcCVe0YMPeHFxPwylXYd/2fqevNLhJl1nG8TRoRJ46PhNQJsb3m3oervWOKPHp0Ht0zBfK7qx2TS1imMJoBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfcC73kCPVkK+vIefoGEFoktPM9AIkiDU4jjalROZGT8CM0yR
	X4rBOmpeguy2UYN969skP/QZTotEmS6czGge1NTRg4N8rS72P977SjGV
X-Gm-Gg: ASbGncsGTwSjNqT0bilkClaw6ADpzG1AEB2I8jMkchidsVid51c57WoG4qlOhlxd6VJ
	qzabR6FoVmL91fB3KsnK2B3gMXz7rfMdmcm7EhpN/A7k4bjrpzUlcMDnEG2/7PYl/hv3gejgzqp
	sLqhy3heNHOmf420HNp25kIiIGIaaxPhsludhz9Z2hcBCUgeZ7caFvjRgYiM2nyUL5BxE3ylr03
	+Sb4HXlXUSg9pOHvohvJebq59/dVFlKEzbERscgKuUlZkCqz8sVvVBAGmbOPTYZW64qudyX8s4x
	vFM91JETUajbt4A6Mz278FzG3Zln3OZiTMcNuvHADhw4rCkWwZ32EEtCixCc33hlGkH8sUxlSPS
	k2faudM/6BKrQAuS+cKOInwJQ7GFNGx6QeX3v/TI1tQduva1FjGja/1C3s8EC752clo6uSPYBmp
	+/5w==
X-Google-Smtp-Source: AGHT+IFif84okb0gHpv6GdHn52xMYcER6a6kVWJvZ+CKvHUoQnE4m3DSbnxjrlJZOUjr3pzzGluEmg==
X-Received: by 2002:a17:902:d488:b0:246:a4ec:c3a5 with SMTP id d9443c01a7336-246a4ecc618mr185637735ad.25.1756302672907;
        Wed, 27 Aug 2025 06:51:12 -0700 (PDT)
Received: from localhost.localdomain ([222.95.34.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0b04sm122790455ad.44.2025.08.27.06.51.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 06:51:12 -0700 (PDT)
From: qianjiaru77@gmail.com
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qianjiaru <qianjiaru77@gmail.com>
Subject: [PATCH v2 1/1] VF Resource State Inconsistency Vulnerability in Linux bnxt_en Driver
Date: Wed, 27 Aug 2025 21:51:02 +0800
Message-ID: <20250827135102.5923-1-qianjiaru77@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianjiaru <qianjiaru77@gmail.com>

A state management vulnerability exists in the 
`bnxt_hwrm_reserve_vf_rings()` function of the Linux kernel's
bnxt_en network driver. The vulnerability causes incomplete 
resource state updates in SR-IOV Virtual Function (VF) environments,
potentially leading to system instability and resource allocation
 failures in virtualized deployments.


Signed-off-by: qianjiaru <qianjiaru77@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36..2d06b0ddc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7801,7 +7801,13 @@ bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	int rc;
 
 	if (!BNXT_NEW_RM(bp)) {
+		// Update all relevant resource state, not just TX rings
 		bp->hw_resc.resv_tx_rings = hwr->tx;
+		bp->hw_resc.resv_rx_rings = hwr->rx;
+		bp->hw_resc.resv_vnics = hwr->vnic;
+		bp->hw_resc.resv_rsscos_ctxs = hwr->rss_ctx;
+		bp->hw_resc.resv_cp_rings = hwr->cp;
+		bp->hw_resc.resv_hw_ring_grps = hwr->grp;
 		return 0;
 	}
 
-- 
2.34.1


