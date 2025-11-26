Return-Path: <netdev+bounces-242084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC58C8C221
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AFE54E7B95
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03333F395;
	Wed, 26 Nov 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y+3J6Qu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60655125A9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194268; cv=none; b=O/stI7on8It445+Rmxa/Uh/ZM1zwVKzaLpKU4StzUa8d3akHssxifddEUX31Y8L7mUkOsloN9EeYsXSL1eg6Sg72xlPI9ZvPBJAlzKn1Zu/+8KoI2ClDaMdQyRo/hIfdUxtNCXVXg676wDE58EDppxA9f2Smo+ek6VoCjCRk280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194268; c=relaxed/simple;
	bh=9dXstfDYdD072ouRMzUJsXARoltEV0tR3V1QxNyNIyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbvfxIrTOZywAsHm71uR1Cc0NjOcCLOiQLXhFJG2MjYI+eoOr1YNYPhyF+9TZGB/NoNLaE2R1gk3WCzpJDmv+3DxRId2vEQlrsufiUWPbsogh7Rmdju4stwpNJetem/CUo0x9Res26cuVq1cgi8iO0nHM1k4NWXaloHMSLSs2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y+3J6Qu8; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-298039e00c2so3153115ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194267; x=1764799067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRryVhXDT9ZPyPH15R5E/UnWjQ10+ZAET2ksDbTkfTU=;
        b=FwSnDkOgYwOEbQJjvxXWSjQPYYDz3Wj/pTLve4rVkylvu144Dt0NlzjX6m+BXZbbAz
         iUlL5VvQLcoBnMmkWHXoJ09w4FIk/ir1YlhhmshssQAsrqbDrQXX75/HqoJKpigwk7CE
         mPvhFmz4qnrZi1rkvLIbEXjMTtHZzN5NRjCJRG7wGrpMHXXQMm2KgqQ6zKcZlZ3fuIT1
         ggLfGaN3h/Dlbom4Z9sbdLhS1ooFf8x1ArNwIeUv8aWbK7pHk/039Gn9N5Xu0IsTi5Do
         rRb8ZscYzqMpaKVRbrxhh95Z5KN9PvF6cZs6SVN+VoWnI3WO2E2X5iPc13vjeX6I0tVx
         xY7w==
X-Gm-Message-State: AOJu0YzqfEvEE09/5FdLBDKiw+io1eTQU8I5mVG+w4t09FxEuqlmeWmw
	6xrzR09oj+kiG41jHzyqX3WFZwhGpCXVVOrKzmj48HHBYTOvpb5ZzZoQKSBfV6IqZStMXE75ClL
	EnOOXw9MIyJLN4w4klAfOYKS/E8rNRKucqMZXvLPaiG7BPP7pkx0XzZz8vr3EelXfN6LJ0TASP2
	20YmOebDQ+u7Gh2jfW522TspQAmXUB26cMUVTyEmlnzvVwsVFhpeDuGOIiSXziOFoVZD2etLngL
	S4qMfS3yUg=
X-Gm-Gg: ASbGncvnzo1hFk2oGnfM2vjxV2CauKk3RvytsjNwzo6j9OCmuK6u+JsDWDSF5ijcusN
	bh9esliO2iC826AlzA2NMOaJaMDZfu3JnzRQrSOOiJuMk/n68OKbaHOapebt8D3DWZvs+1csgjS
	YuJotGNwKlVgpe6KqG9FRAn6bgmLKYHk/WvLPkHUgS5jshLZOGRGbHMk7YMNPgZewshBjn52/5d
	8//xM16lMY+lgM6nyy7lJ4GjI+kDOejbXrCX6vT+33ys/Sne66gpAQbKg/OdfRe3CX0/aeaWnlK
	9ghvtj8AmraufcCTXg+/PQKD/qbBW1y9ZpLyNMpYuYr5qkfORJvKcOAg8UTVH6YCipjsqtZiGSa
	CqwuR+gzB2vgZKpl/ytYc28594UM+YTvUnA7lfFsNVcd/DTuJRiNHDNuZEWF8eYd2rtJ/FSkKbG
	IzGoRXSVYYswZuz43YHjXnjplPA7w6mh8NpSAtdU99T9IA
X-Google-Smtp-Source: AGHT+IF+tgWakXGjXzfMdmr+PK+DFT+tB9t+wvTQgZO5Yk1bo6mbXEllYYzHx0mo1ldqMoe0nni7iWpsAnJm
X-Received: by 2002:a17:903:1aaf:b0:296:4d61:6cdb with SMTP id d9443c01a7336-29b6bee38f7mr254250575ad.27.1764194266675;
        Wed, 26 Nov 2025 13:57:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29b5b1f4fa7sm23538195ad.32.2025.11.26.13.57.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2e19c8558so33416685a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194265; x=1764799065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRryVhXDT9ZPyPH15R5E/UnWjQ10+ZAET2ksDbTkfTU=;
        b=Y+3J6Qu8jO/yxssgIgZmoEZm/3sdIfo8pi17QancI2+mxHZA/Npji85qraro7NRXha
         iHLpKSvaIvVrvqSsBRqIIiIsQjn1fD8e6uI+kqeQTsk5a8kjA6PofVWnFnhQRsC20HPD
         HrLGnMObYL5uCXpge6+EGi0PoL8PFxZ92faTM=
X-Received: by 2002:a05:620a:31a6:b0:8b2:dd5b:fe80 with SMTP id af79cd13be357-8b33d48706amr2888543085a.79.1764194265361;
        Wed, 26 Nov 2025 13:57:45 -0800 (PST)
X-Received: by 2002:a05:620a:31a6:b0:8b2:dd5b:fe80 with SMTP id af79cd13be357-8b33d48706amr2888540385a.79.1764194264856;
        Wed, 26 Nov 2025 13:57:44 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:43 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 4/7] bnxt_en: Add CQ ring dump to bnxt_dump_cp_sw_state()
Date: Wed, 26 Nov 2025 13:56:45 -0800
Message-ID: <20251126215648.1885936-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On newer chips that use NQs and CQs, add the CQ ring dump to
bnxt_dump_cp_sw_state() to make it more complete.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 148db3fe8fc2..7df30019c5b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14025,11 +14025,19 @@ static void bnxt_dump_rx_sw_state(struct bnxt_napi *bnapi)
 
 static void bnxt_dump_cp_sw_state(struct bnxt_napi *bnapi)
 {
-	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
-	int i = bnapi->index;
+	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring, *cpr2;
+	int i = bnapi->index, j;
 
 	netdev_info(bnapi->bp->dev, "[%d]: cp{fw_ring: %d raw_cons: %x}\n",
 		    i, cpr->cp_ring_struct.fw_ring_id, cpr->cp_raw_cons);
+	for (j = 0; j < cpr->cp_ring_count; j++) {
+		cpr2 = &cpr->cp_ring_arr[j];
+		if (!cpr2->bnapi)
+			continue;
+		netdev_info(bnapi->bp->dev, "[%d.%d]: cp{fw_ring: %d raw_cons: %x}\n",
+			    i, j, cpr2->cp_ring_struct.fw_ring_id,
+			    cpr2->cp_raw_cons);
+	}
 }
 
 static void bnxt_dbg_dump_states(struct bnxt *bp)
-- 
2.51.0


