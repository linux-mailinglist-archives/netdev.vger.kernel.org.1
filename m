Return-Path: <netdev+bounces-246029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE49CDD076
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18088302034E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525B2C030E;
	Wed, 24 Dec 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cukYXBVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E1296BC2
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766603517; cv=none; b=LSMCjkhW6TF+OmpBj3w+REWWSl++bYUEeZIgO2vvNSn2rl7fIXUzq/pJ0f1jeZCrlOmxVDRGSJCB0vwl9tPit1beDGXwjFZhB5oYraQ+uUcLJgIndX5qENOKHqu81r/yd8rsa18uS40Poy02lag5kiCGioHvpY/160Rk5sw8okA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766603517; c=relaxed/simple;
	bh=2BSiEw1ralWUVM5G5qwgNDbThdDXhA8AZ01SnFYbsnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdN+X0kXamC8soGpMHYMgfnJxLC7lxM5qRIBmu2okOKe4ZaP7rCg+Ubg5+je9I2g+l12CB47SSdLh+KFfOvogasAtDFPuNwVr6NtaVPmDcoOg01tdL4l3ti6baTlEgoAFVRd8/IEb4RuushOoaGTWTtFXLhHnUnNH6bQkvdu8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cukYXBVV; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88a34450f19so68990806d6.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 11:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766603515; x=1767208315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwZxeEygJOhPXHTv8N39MsQtbUPLmm9QKziUOzy1N+A=;
        b=dlVGOurPTpcOCQv2QTN2hTCMUsPJlgwim5DL1+lnLEpCDRMjgSuJSPZBlFKirzW5ml
         7jtLf7q5m/MM9R0XwWCNeEVNBqsGVrbepfnbCqkDQPZCTFYzEZ0tDEn6tdVuOZAmA+Cv
         d4WLhQaOTPq5c/a7+0MizafMD3gIZ3iRaZWtS7YNKH2DjtZBJ8atus3u/om6Tic3BR/A
         aM87Q+xebC7Pj4/9fzKZhOeqckiz6REVTqT+HItn9PPsG+476f1Lm2R/umtzROwfxawN
         KuBYwTS/GVZoSteu2XeIORgakAyBga2kvFsENGIimonmrjbjuQrXUP6Q3CEz2t7uMU0G
         Giew==
X-Gm-Message-State: AOJu0YwbCV8uoo908ruDWK74nq00k8yLvvRQZ9deBESMRBmSLV9H+224
	6eNL9wUuLVF2Prd58bmlDCCX97Q+9elh6q9jjFpEHSZUrmFogtCWfb4Vt53DvMCidc81KfRyFMG
	XzFQkPlO1KmehMkzMtJL2CRxKcwXT/N+E0HE+RsKa7dNq3zqOPnTvuHfThYC7XPA89XjZ0hs3BY
	0HudpGGuqeEjS0hQy/OjqjB0P54OIiHZQP0p7e7AuQLhGAaCfXqVhGdRQOYEz1DjFkA1UluZ6MF
	1+6BGvOwt0=
X-Gm-Gg: AY/fxX4ROrZW7h6x7qtBza0S5cBvdVwGwP8E3zGVxmXLTLBlITp7+xVFUHmVBalOVDs
	FGXG41cE/E3dF+qXpj2vLOLuv35DkQVFOmijnv8qBHFdoAcnuFS76CWtfmUI0i+a7PubkNF4pCJ
	ekYweUS4l7wl0DaNU/Wc2fwERZNiTCVy8jRySbIuLZvcF8UDk1PnSTC9GkpHgpeTIxYZNdw1UNm
	sUD1eigkGMDaRR6YFPvGR8kAy0pKXTfAYLR6G4dDli5icA7Jp49BUT0WInUje+NucBM1eMBuPCp
	k6Krn1rihE4SRiuv7hSKc5L0NS6K6roOgBtbjyiBCGtMH37FqBdOfXHB5BfFwD3ZkXQ6RgYL2hX
	ErL417xGQcebZ2GTrTMjF25GcQ+sS9gz1YHN+Ig6UyDI4y/t7Q/8yZy3gaZQDNTSRSzf0jeQcFO
	qbF09NVTSqPmN7yPVJ+i94jxPt1CT8KNxTRfrW0MW8kIp/
X-Google-Smtp-Source: AGHT+IE5TsGeQOuslgv5niWBvRIKAeE5m5QYs/DGMgkkhQAu48CHs41GKJ6dFNJ/UMllkG00Ton7DSNrOADZ
X-Received: by 2002:a0c:e705:0:b0:880:5d59:fddf with SMTP id 6a1803df08f44-88d82234459mr214751186d6.28.1766603514708;
        Wed, 24 Dec 2025 11:11:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d980505aesm22204286d6.23.2025.12.24.11.11.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Dec 2025 11:11:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso8787961a91.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766603513; x=1767208313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwZxeEygJOhPXHTv8N39MsQtbUPLmm9QKziUOzy1N+A=;
        b=cukYXBVVn2uKRlsOJC/0ijWeVMjRWIKaRI3c46p8zwUuWxmNQxN/1Bhz1r8HW/6F9J
         NDsnzLEY/4Dsvaw/KPzj1yeLcMEwoW3mbxys8+37UdFoFJtDuUgdTnX8xid8kLA0n3yF
         a89xqX3TCsj5D5fgpW83Nl52pDPH0RmBO5CJQ=
X-Received: by 2002:a05:7022:989:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-12172300173mr23106319c88.49.1766603512770;
        Wed, 24 Dec 2025 11:11:52 -0800 (PST)
X-Received: by 2002:a05:7022:989:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-12172300173mr23106301c88.49.1766603512209;
        Wed, 24 Dec 2025 11:11:52 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm79252054c88.12.2025.12.24.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 11:11:51 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Srijit Bose <srijit.bose@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH net] bnxt_en: Fix potential data corruption with HW GRO/LRO
Date: Wed, 24 Dec 2025 11:11:16 -0800
Message-ID: <20251224191116.3526999-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Srijit Bose <srijit.bose@broadcom.com>

Fix the max number of bits passed to find_first_zero_bit() in
bnxt_alloc_agg_idx().  We were incorrectly passing the number of
long words.  find_first_zero_bit() may fail to find a zero bit and
cause a wrong ID to be used.  If the wrong ID is already in use, this
can cause data corruption.  Sometimes an error like this can also be
seen:

bnxt_en 0000:83:00.0 enp131s0np0: TPA end agg_buf 2 != expected agg_bufs 1

Fix it by passing the correct number of bits MAX_TPA_P5.  Add a sanity
BUG_ON() check if find_first_zero_bit() fails.  It should never happen.

Fixes: ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for 57500 chips.")
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srijit Bose <srijit.bose@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..6704cbbc1b24 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1482,9 +1482,10 @@ static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
 	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
 	u16 idx = agg_id & MAX_TPA_P5_MASK;
 
-	if (test_bit(idx, map->agg_idx_bmap))
-		idx = find_first_zero_bit(map->agg_idx_bmap,
-					  BNXT_AGG_IDX_BMAP_SIZE);
+	if (test_bit(idx, map->agg_idx_bmap)) {
+		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
+		BUG_ON(idx >= MAX_TPA_P5);
+	}
 	__set_bit(idx, map->agg_idx_bmap);
 	map->agg_id_tbl[agg_id] = idx;
 	return idx;
-- 
2.51.0


