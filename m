Return-Path: <netdev+bounces-231782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84325BFD6AD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B022580971
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC426E6E8;
	Wed, 22 Oct 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="V/GnAKqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F42153ED
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150967; cv=none; b=uBIEa9ypzeJfnavxhaBTCCw+GmilkhYoWF77DqWNWXvqUbn/jqUCUoFcVFBTYyWqhiqWWrzcNTkG4vOHwPJVD1dPdbQr1AJG4mc2TgZ8BwRjKGb1aByCJ+T5TFs1x/emkhcuVWBGP3CrVmcKiKHwOxIWMgyV6YAfd409PznUp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150967; c=relaxed/simple;
	bh=WEp0i6nUj24r4fdAM3/hWH3sfjwDIwL6W+mOF4+TX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSRHgK3kWgEJgXhHO/+NGBfMQOhnRUngpy/k29Q7go8Ig/JY8Ff2sI7/5fMuPPYkhfKsS24x4oyMitNq6yhQRTy6uo8YJgRBExEO5cDS3jPqecvjCo8Avo/MZnYqmnCfCR4fGCCV6IFOz5Sv/WN1qFneSOgop3E8Po7GWJhPuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=V/GnAKqd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d14e5c9aso68136575ad.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761150963; x=1761755763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwecGbA01jSIHkfKfeaE5nVwSDYL/I3dch9VA9Sw4zQ=;
        b=V/GnAKqd09UMtPp+9EzPD5HC0pp7ipYvG6hCFHtyWbz9FZtBFNpPRnK20X6koGTtx2
         vNmKgh8hUX+bKwkNGXUwXzkavB8YOYGLMYx8VsltgKZeZcRdJF4SMqaT9Cul64sozQJH
         qIFJQlIdRt5bHkSJNCoAmxz0UE/xr6eFoxpzjZWOF9gtK9M56FiJvNyty3cukFu/+l3o
         LNDSkavmWi4mp1TesQcWy3Z7mth7+9HHAm2L/qJSPBOYGR/9lUqk7xhTR/a8Ih+mLutK
         EwicAcPGnxIokAZOBZ7aNv5wdwvSs5x8C/rLPrA3sb0pm2CQvVHextEG0gtunDQQxRMu
         XuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150963; x=1761755763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwecGbA01jSIHkfKfeaE5nVwSDYL/I3dch9VA9Sw4zQ=;
        b=M2YJBkkIWMPMRJcLf7OFJfJwPyFk/GZv08vB99cmWZ/SAH7nrDeTGoUPXn+GDWzbjp
         TRtH/PjZgrNnJFHPMVJJyloM+GssARYb6zoS+qv6EiHkCDcG1rYy/6yEuYAxpsM9VS1/
         n9AndurCHsZgx3Oo8TzkBJapfeIZ7KxwYn8NcekuJ/Aq8PlNgA65zYgNXartfr+wWSZt
         Wfz0gSIq0ba3YuO5+coBdfZdJTxmLG0J7FZReFC8KqLy8ZhJO8ySbvjOqFd7cv9iJ2GR
         wDMp4p4TqPI5sdp2Sub+aivQkD59z3MzHeHdMt81xQEm/abQEM3evQC9rF10DfDK/d+l
         1cAg==
X-Forwarded-Encrypted: i=1; AJvYcCUay1aI72RedUcFgiMIVC+PyQEnXHFsu986g4I7w0l9cWnfq+W5peoewFNBKm1Lkzd9VTKslAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLxOMV7KjcovA2OYWL6LP1bbK6Jcjrz2uApQ+kTPolMcM2uew
	8WFGIV7yfokn51KXLzQUxsbG7Xj8+cPJvhAxLgI1/htc1hAZTZGBXu02LPbiVMmyX6s=
X-Gm-Gg: ASbGncsGksc3mkBe+FFZD1/1OT0pHTBLjwMQyjYA07dX7oEZlDpjv/euXGQ31TuRpXL
	kbZRttSumcesRzqk85SqIVV6q32ZiyKkUm9u1nz/Hr1VxxS00pVoVZKXIdnWanpnfRDQ05l/L53
	aocMoW+ViF0wspTISqZECVhd+gTD3/csLWma6BTbB/UJPCvtmpXnFEkgBZeR8NzlP6747p5QcXv
	C+YXSP4soaVnxvO026XN2FI65SWbiZQVdcraEcUsz7nKsr6TIfAXexJ7KVbYhf/+YiVbu6Ae6kX
	0pFp/E0KcvZS+8W9MV+0gMjDXZA9ReagMW2nqaSrc2F59xlBAvKqwHJvSuSym3o3Fddciv+Wgk3
	xAyYUXl0eyiH7f4mfA2hV5Yr8SuK1JkZViiTv19W1rPdc/fqDvr+I0opvu84wd/x+GLteLxm3x+
	Fm3BKTqoY3qCU=
X-Google-Smtp-Source: AGHT+IHaeP9A14zUB0muZVyyLtWP3umHacbDkVX9TJrKOLE0ui4bf8Z/gLJxD4LKOyyJ/NbyITHklA==
X-Received: by 2002:a17:902:e88e:b0:290:a3b9:d4be with SMTP id d9443c01a7336-290c9ce63cbmr245700855ad.24.1761150963198;
        Wed, 22 Oct 2025 09:36:03 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm143398945ad.7.2025.10.22.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:36:02 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ecree.xilinx@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alejandro.lucero-palau@amd.com,
	habetsm.xilinx@gmail.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sfc: fix potential memory leak in efx_mae_process_mport()
Date: Wed, 22 Oct 2025 22:05:22 +0530
Message-ID: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
passed as a argument to efx_mae_process_mport(), but when the error path
in efx_mae_process_mport() gets executed, the memory allocated for desc
gets leaked.

Fix that by freeing the memory allocation before returning error.

Fixes: a6a15aca4207 ("sfc: enumerate mports in ef100")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/net/ethernet/sfc/mae.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 50f097487b14..15d4af6c1bb9 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1100,6 +1100,7 @@ static int efx_mae_process_mport(struct efx_nic *efx,
 	if (!IS_ERR_OR_NULL(mport)) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mport with id %u does exist!!!\n", desc->mport_id);
+		kfree(desc);
 		return -EEXIST;
 	}
 
-- 
2.43.0


