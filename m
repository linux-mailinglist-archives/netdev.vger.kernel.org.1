Return-Path: <netdev+bounces-235317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51684C2EAA5
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C791899DE2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CB1FF1B4;
	Tue,  4 Nov 2025 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PtO545S9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E42116E9
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217880; cv=none; b=WXA6+ERRQv8/L9LBM6zqakD4vHPwZVPw76xzZGa/vyhaxBjlt6aCe7Rl1/90xoOAllHP8qGZe3AMi4OfFLO3q1GWpEFCWKlqWUHLaq9egKUmoBWHHcFcP2PMO2zZKYcfDmfyJKcu5EdS59yHclriGZu9h7rnl1WDL10GGNjuIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217880; c=relaxed/simple;
	bh=8xaBscVDpFt+sAQOtKwD2Apdl4OBANbmuAnF2BsGJuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt7zXoHvRHZ/0RKgl89dcoK25FwpCf1sygPVuKjaZYqORumxmi9ajdmMXm5svEK4m7AMPwp0y9WSK0mDhO3Eyp3FY2b3VOyPXNPrO/mPbkEog48b1v0uCYqi4QMbIH9Avz82QB0VTL04akRMQCcMz3wjvsZJQEm1XLuVKGyDY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PtO545S9; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8802b66c811so47503456d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217878; x=1762822678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kji/k/ToSECiBeKuaoy8RCKaIjevC0gsTv8EdQc77UM=;
        b=Fm/EtgN26T/OEU5FG2xb/HX1OOK9ixI9+muGQTX5oQyi+gD1taIdgXkDxRBIxX2L7L
         YUKq/2olNgDUNA2nj/uBax1wwAW873I4jzJ53D3GCqrStljJF9W/ab0U1qS1QkRTjwxL
         obFzCXzjZw4D/fw99x8NMyU4wQb+zc5XOdRg47JKSve7oGvketZEkoB+4US21rJS1/HB
         YfUOXhuZFNe7+i5CKoAwb75VifXnpc7WZAR+XIc5cAezf1im202tiHinHxt/sVewmDv2
         8FmWC0DfKsR9diCEHcIrtjjGHBWRdxw41P332ymeUD1idV5bU/kx2t8h7IvLM5Om0XDr
         jwOA==
X-Gm-Message-State: AOJu0Yz9HSiO1xMBEG4lzEBmRaLxP+BHr+t/zr3qajteSMBczgwUa3xm
	RM6aT+9peVj2AfwD1tj4cDcP4E5A9j+ilUldNa4qJQbUJyp06hP0X+KyGpXOcdJcPBxcxGYvqLd
	ISd9zBWXrjF2Knq8dIibBZ3AfEPx/pyQN8a8D1g91IARm9QfivoVs5iQoOcrddwrZFcGWe3Rqa9
	U9BDJI9yVuh4CStrI/yIHsnaHhdokL3vVLy5vPVdkfUlfwVyDW68d7hAr+Lrc9BMEdhODDIomD3
	0YVkarNLWc=
X-Gm-Gg: ASbGnctqj8ldHbZPKBQxicfr2i1pFpx94yrXVy83Q6Pqo4XJ4F/lHxHt0N8c5jlTHuj
	XUTiMNewSHD8ICVUoQdXxRbETTslggrxnzYFTbtNWxnnyH8KAeFvdJvaTp0v9l7WPwsR8pAgx7f
	pvY5PLP2Wx44QPTdFySGoboA1dy2qti1Sn2nEoUyKQVc5bsADWgBRsHGX+2AolayyyBLQzVtgAo
	mKrayS59jNmUaZOEuF2yYuRzmSXdIlOyKi8XWH7AsZXT3YL4uH0BtTUOZuKIGDLumZA2sSBnLYH
	KMzl9LC5JepNCDaseSF9gZrus9rjkQMZUYrOsldk4Zp/PTugJ4k2E0cc7RnyQs4FPZE05BVH6rV
	zY1wgrppGeOWgJAOH0cfeiOWeKgTcaVyVGSSJTm7xz7DZNNr/VF/3gEGolTIlZBKBcpq9858Z65
	1dflGL/kYxZrYOzPc47uPRyJm85MOz9Y0YJQ==
X-Google-Smtp-Source: AGHT+IG5bX8Gv4lq9mdwv9k8mmbgJGYeGuzQ01aDfgoLMavVRtpNpaLGn3eM+RjbR4OhaH0AK6YDfyTP2POk
X-Received: by 2002:ad4:4ea8:0:b0:880:5714:cd2d with SMTP id 6a1803df08f44-8805714cf58mr75130536d6.60.1762217877867;
        Mon, 03 Nov 2025 16:57:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88060da8b68sm1580506d6.4.2025.11.03.16.57.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:57:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5535902495so3754646a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217871; x=1762822671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kji/k/ToSECiBeKuaoy8RCKaIjevC0gsTv8EdQc77UM=;
        b=PtO545S9/aObyludQ09bDCgog4zpbs5/N9to+BeZS2G86QOWoq2RCmk0FYjo+X6DNK
         qMnqInskqAEWm/DbDxdHDYptpqFcBe/W+5w6apPUAD4+aprSuLlfJd7pgfnXFstKZgGk
         2mXtisF4hVJ7Txh66FjU5GxXi3WwhKTuJX/R8=
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr20160234637.23.1762217870923;
        Mon, 03 Nov 2025 16:57:50 -0800 (PST)
X-Received: by 2002:a05:6a21:6da7:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-348cb08f3c9mr20160207637.23.1762217870526;
        Mon, 03 Nov 2025 16:57:50 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:49 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/5] bnxt_en: Fix a possible memory leak in bnxt_ptp_init
Date: Mon,  3 Nov 2025 16:56:56 -0800
Message-ID: <20251104005700.542174-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251104005700.542174-1-michael.chan@broadcom.com>
References: <20251104005700.542174-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In bnxt_ptp_init(), when ptp_clock_register() fails, the driver is
not freeing the memory allocated for ptp_info->pin_config.  Fix it
to unconditionally free ptp_info->pin_config in bnxt_ptp_free().

Fixes: caf3eedbcd8d ("bnxt_en: 1PPS support for 5750X family chips")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index db81cf6d5289..0abaa2bbe357 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -1051,9 +1051,9 @@ static void bnxt_ptp_free(struct bnxt *bp)
 	if (ptp->ptp_clock) {
 		ptp_clock_unregister(ptp->ptp_clock);
 		ptp->ptp_clock = NULL;
-		kfree(ptp->ptp_info.pin_config);
-		ptp->ptp_info.pin_config = NULL;
 	}
+	kfree(ptp->ptp_info.pin_config);
+	ptp->ptp_info.pin_config = NULL;
 }
 
 int bnxt_ptp_init(struct bnxt *bp)
-- 
2.51.0


