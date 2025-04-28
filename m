Return-Path: <netdev+bounces-186586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11263A9FD56
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896A95A6E21
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1202135D7;
	Mon, 28 Apr 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YPCVDy9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EED1F872D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881182; cv=none; b=lCRsXLOI4ifsCD0L/0xzYXoAnPT1jDKfi/K1GnPyCwJtKhr1SNjOOdn+RXReT4JgCiJr1N/mgcqC9sSNKp6YYVQmx0AwGyppVyOzDPfKsLNk6gRAF3s3/oewnpM5/i+uS6zMWfJ9CwE2f6ygWKDbIvWgh3sv8MP0lXrRaFhm3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881182; c=relaxed/simple;
	bh=td+xKpw1VMkDj9tSHXr8ZJiXGmbzXrw835ydwcYIqP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1ZIrgED5ONcsF7QlP7ROhm2rWxEYokKJCoKsqUw0BsFwMQS64PglSnOcwMwXgFaAdVVt045tOAPaD3po6X+mzeeH3Dq1nPvdHh+j8w0rwa+GuEgBoan3GFOUiZOwK8A8cNkMTAy21G8G5Sy/o9o/PES0FLwHNhBZ+i9zeaGFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YPCVDy9x; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399838db7fso5523666b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881180; x=1746485980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMw2R1VGAKvJrYiGYeAbInETuYOeWRg28018dzpJl3s=;
        b=YPCVDy9xxr20I7e4Y/KQLzqhQLXRdKk4hzKdp5ZWBGT8UVxgMDuoxOK71MuyNCY3js
         9U3D7mEGxCZUm+A7Cqlva5id9FFc9iCPILokodwnTFvCB5DeJfR1bNtbkm0AWrvOahsU
         I95aw5H57XIXgbviiZk/joAYfVoHocAY2iVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881180; x=1746485980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMw2R1VGAKvJrYiGYeAbInETuYOeWRg28018dzpJl3s=;
        b=qEnRM4htIBSe0vZN/X/oTCSOyPKC/h/4d1p/VqsF65e8ApVZx1x6zkUtlv4/rd1qzX
         WLlDUyswFmFYb1E5VSFlKzlWTiDrev1I5zzgjr5x56Ch8vHm4Pnh4uToxjuF4hlPvKj7
         DRioLn2zxo+0tWfB7ut7A+hAZJi/jtgMWb9qyLgtzeqlQif3UYZn3Bkilg5m3+hcDDvt
         4jXDRCM8XiG9LWOCc09lYV2NHaHlgrBjxYCUtSEa+zRGJ6AZtHjhp6hvEgTYO7VpXiAo
         Eh2hW+yDUgdFhfUR7XWSF1W/YBvi3o0R4rMK2EA7teVxoX9orR+uDmfmBoa7ZO6vZ7gL
         Lq3Q==
X-Gm-Message-State: AOJu0YwYoFWz/y6b7lbJuuxuNcAfiz/lKc4GLxBNDdHaoxI34DtM+MVY
	tPEX8d+HD8rwICw+F/zElIkrb5wR8FSI2pDPiiZflujQHeN4lE1u2UpCtLtqgw==
X-Gm-Gg: ASbGncuSw3V1wvI1hNQSfmHLg4w74206BhGupVKOFeM3bXPZkvdamJOz06zBgv+l9Gm
	f0+4vfQfCuyIVrqWtyNIgbOrwWm0umDoDDkUIKfEyQSGf6gXxQlcvjTw62jYve0oe2V6NYMLyOt
	QZF7RKB6hvlQKh3sOzSub+IUDzlhoy0nlXuiEQdUDproNG120Th7NVM4YkwzSCL/avtiQc6xAka
	76OH+U95OizxeD8fE/O+77H41ILzQSsdDriZcqREiWXXfLyc7NizS50EXcUiT1hKDKptnQscgOE
	e09WO6zdnQ8LWcWQw89mOrrXHQYJdtOiamnVtYB57gVkpHtQ9UX0+tLp5Chxmt9j3SV6upDzSpb
	y8oLipLMFRityvzyJ
X-Google-Smtp-Source: AGHT+IFCCWpxyO7tudoxv0/nE5WkEfZ4Cos/GJ1bxA5NedftROQSJDlKg7kPDH1GlsPZXpZXnLasgA==
X-Received: by 2002:a05:6a00:2d1c:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-74028b0a63dmr1449729b3a.11.1745881180097;
        Mon, 28 Apr 2025 15:59:40 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:39 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 1/8] bnxt_en: Fix error handling path in bnxt_init_chip()
Date: Mon, 28 Apr 2025 15:58:56 -0700
Message-ID: <20250428225903.1867675-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shravya KN <shravya.k-n@broadcom.com>

WARN_ON() is triggered in __flush_work() if bnxt_init_chip() fails
because we call cancel_work_sync() on dim work that has not been
initialized.

WARNING: CPU: 37 PID: 5223 at kernel/workqueue.c:4201 __flush_work.isra.0+0x212/0x230

The driver relies on the BNXT_STATE_NAPI_DISABLED bit to check if dim
work has already been cancelled.  But in the bnxt_open() path,
BNXT_STATE_NAPI_DISABLED is not set and this causes the error
path to think that it needs to cancel the uninitalized dim work.
Fix it by setting BNXT_STATE_NAPI_DISABLED during initialization.
The bit will be cleared when we enable NAPI and initialize dim work.

Fixes: 40452969a506 ("bnxt_en: Fix DIM shutdown")
Suggested-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2c8e2c19d854..c4bccc683597 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11602,6 +11602,9 @@ static void bnxt_init_napi(struct bnxt *bp)
 		poll_fn = bnxt_poll_p5;
 	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		cp_nr_rings--;
+
+	set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
+
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
 		netif_napi_add_config_locked(bp->dev, &bnapi->napi, poll_fn,
-- 
2.30.1


