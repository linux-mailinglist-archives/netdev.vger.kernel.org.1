Return-Path: <netdev+bounces-222901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987EFB56EA8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31FD16EDD2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46111222585;
	Mon, 15 Sep 2025 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MZQT4LRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF45223715
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905554; cv=none; b=DSBHEaAkPdC8B64Y7hj/htpAvhX9/g3YOJb+G7OaFCuggKNIWHyR9lxVoFnSU/TNlo3UFokp/K1U6jyaJElAGFNQiQDNCO1cCIBVYvavBIpPJ5yQ3e3F5/4v+13p6d0W9hsyW3g25U1XUrnLCOujAMO2TC8JU4wbh3mzm6lSG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905554; c=relaxed/simple;
	bh=BEJQUXklrYGqPLFItknw0+Xe7aIcdI9Me7//7r85SC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFUu/3FVkJHHy+7ioFW2YpNJSBQtI7L75vMid8KCvgHrUA8YPNUJqPpVC+YSCIUyxQR1RjwFzXq7X4zEux9Mt3SdyHXv3VoiEn5hFBmzzZhyzmUEaAtdOXKwdrFGnwuIdnEgwpDBywmoqcd4UgSVip2OgdNo7O9ofdlDhqpy7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MZQT4LRv; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42406e56820so1639095ab.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905552; x=1758510352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l12ohqJNrU4xfHlF545pSJaLylbmlbI1I/q1wV+6dXo=;
        b=rW0LzVTDVRQ9/rEDmZWlRsEt77ABNhMKMvcLZ0aEmmqyckYKUHEkhRSkR3VImumxPe
         cEHXHdJG0FE8wve4vO61mOv2G2XQcXKGp0OJn80ktJC1DYsrgSYeVqYS4v8QZHU2nW98
         zkbvd6IVTrIYcGgOhmAqBHUir5ECFTf0j00CYuR+oqhPVXKbAPYHesw6vKtDD/FfyPTP
         GOrt7QLh5S5AgTONr0LcE2uOlVvXoQap3DN5K0PIU4lLURXgoCMhrA5Fl3pYwa4x9v33
         p7ZUx1ugU5NEUeW/rgn3lpNAL3Jxjg3cJ4qV3FywRSJIZMZ7rVel4C01u724zh1zunI0
         Gbng==
X-Gm-Message-State: AOJu0YzsOioOENLog2cTqi2P/5wBEj7fFtWzdEcoizup8wfMHKpCjR83
	/tYqmA4ZsERlKtNNaya0zIoyXQm787gIC2rzxBEvLKtf6OtxzJo6bQMTmBwhYVRc7OurcasfEI+
	4kFsNJejDrF3yBBLjeuePFHN0LqMBo6q/CaGzPOfV646vSc7lY5cZEQMPUfaqg95oDaxHdNb925
	WtjbOcj5vwEPzyW3wqz8cE4tOUC06RxXb4mxaHtM6FHtQnSGomlONx3g1v8FG/SxZXhtx6KG8LP
	1rLAlB1iRA=
X-Gm-Gg: ASbGnctDQpJW17xqpY7QzPJRqzUZHqETGDXtPiDkWtszc+ZTTkYrKw2h/q5aD0pDo3m
	fNX0Mi+SUXPykawIycgI5eFebXBv5rKH4hUNdp611/kk9eDi1b0xQsfhphBlXUD+IYR2+P6l9yr
	GS6Qst6wbbM1QPDggsSDbsddGLMVcH5pZElVurEeJ4LsqXkiNEvxnMH0eF3IFUqehZUUm4/3oJC
	aZtEe3xXr/OfQbsdcmS4hl+kPUxoctIaR/hWWSapwyaqrmMCCcvvzqeJUWwiMqirMTaMjTuOt2i
	3BFLDKLRLVeoAb0QUT74mmkERBRqPrmkGLdsD1HEijNd76TPUDawpXDzuv4jxKWxOGhMiB5h7cS
	ZXW3jh4qD91mIlTtie2QiE+FPuBuC+KW7xXrCOlMAOJ6GyAw1jyVH0yW9k0Lz5w9BB0jyk5TXw6
	NNwg==
X-Google-Smtp-Source: AGHT+IFwKNUKeADN4rqIvc8mi+eOAR07U2dxK6u3isCfopUZy2/gDkstGnQFDVTA894vbFeIA+U4sb1mxo2p
X-Received: by 2002:a05:6e02:1fee:b0:413:233f:9dda with SMTP id e9e14a558f8ab-4209e64b54bmr125425415ab.11.1757905551598;
        Sun, 14 Sep 2025 20:05:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-51210ed7491sm483097173.6.2025.09.14.20.05.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2659a7488a2so12903815ad.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905549; x=1758510349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l12ohqJNrU4xfHlF545pSJaLylbmlbI1I/q1wV+6dXo=;
        b=MZQT4LRvrA9CSgjYvlh6Ehs+B9MMiXSsnepOXgFcankniLNhmMcT9rfgYtpAfLtsMr
         8WcuFyKPMOPmgXH1Qx5tHHckFBUMeeNQulmxRCxXPXdMzRcnjBER8YH3EYukABFo1C0A
         mp2yue1ko176URwFGRE4fZB9Y4b+q4Iqkn+8Y=
X-Received: by 2002:a17:902:ef46:b0:246:bce2:e837 with SMTP id d9443c01a7336-25d271485a2mr144981085ad.49.1757905548936;
        Sun, 14 Sep 2025 20:05:48 -0700 (PDT)
X-Received: by 2002:a17:902:ef46:b0:246:bce2:e837 with SMTP id d9443c01a7336-25d271485a2mr144980815ad.49.1757905548474;
        Sun, 14 Sep 2025 20:05:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:47 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 01/11] bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
Date: Sun, 14 Sep 2025 20:04:55 -0700
Message-ID: <20250915030505.1803478-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The devlink stack has sanity checks and it invokes flash_update()
only if it is supported by the driver.  The VF driver does not
advertise the support for flash_update in struct devlink_ops.
This makes if condition inside bnxt_dl_flash_update() redundant.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 43fb75806cd6..d0f5507e85aa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -40,12 +40,6 @@ bnxt_dl_flash_update(struct devlink *dl,
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	int rc;
 
-	if (!BNXT_PF(bp)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "flash update not supported from a VF");
-		return -EPERM;
-	}
-
 	devlink_flash_update_status_notify(dl, "Preparing to flash", NULL, 0, 0);
 	rc = bnxt_flash_package_from_fw_obj(bp->dev, params->fw, 0, extack);
 	if (!rc)
-- 
2.51.0


