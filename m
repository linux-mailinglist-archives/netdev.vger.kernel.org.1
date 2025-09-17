Return-Path: <netdev+bounces-223842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E635B7D844
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26572A7D3B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140F2FAC12;
	Wed, 17 Sep 2025 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MOmAw/8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B592F4A01
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082163; cv=none; b=eilA3mhD8jpCAsnT2Agpy2lWwaihJlqxfL3tHCeya264mMMb7GP0UXDMDGP4V1wK4pio5H1QsUekUWpMaqfWflPL7ecaTbYwe/r4hyry07wcZVdqK3/gLRJIFzpaUHWm0O60z+5VJvycvi4GdWcqdpsso7kZuDxjbVmfsh2KfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082163; c=relaxed/simple;
	bh=BEJQUXklrYGqPLFItknw0+Xe7aIcdI9Me7//7r85SC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G82PJzwIKEyuzePhe77XSQf2ZklxUlRsbShkedtkHqtqSoNlGgVUcxNiombLHAs0kleyeSHVtxhtLTC9drQwjo0mh5Y691oTMjVk+Yb6uBA6oqGC/rF6JhQxh9ym4SGo/AgJqp4iBQPF8gi1xZuoJ6Xo26uDDwQnVzdTXB+PsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MOmAw/8T; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-539bf3ca92eso1520071137.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082160; x=1758686960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l12ohqJNrU4xfHlF545pSJaLylbmlbI1I/q1wV+6dXo=;
        b=WK3CnyrqUZoy3Rulzk9wJVppGdpvucM4QdXEnppRtT++v5nDqiLLV5CbLNSS1OgaXC
         v0AN7o06juiOVYTj2c02aXWAOoKBLQ2gTXkAtDiKTVAjRZk0UC43N97lTJtIMZ8yYqmg
         avZ5xbpzhb75wFW4qlgTYX6J9LslV0SuBEsXkWi5c1dCBlu7StODR+6xxx9Z4isvWBoa
         Ye6N7jTkpKJYHvy9ijNPbk4ocNvJo8XLw7O4mAS6XMxQmB9gis7+ZVBORezOZNwyXB03
         aeD7InkSHfwk+JcuEgkZkheaNhH6rZqrVwL0QcVmEqCn973N1raX03z7bFEgYFItdN4Y
         yxvA==
X-Gm-Message-State: AOJu0YynrQNJn7EKyWMEmz4eqv+TrHu4TwMZ+PeLcYt1jbtweZc2rI/Z
	7yWrtTnj/yw0C51HDu+wtrmxSSfgyrS4Aqc/h6sQ+hrSNOF9fAkxOLcXy1ThApCMAkvt8uqFkIA
	POi4ziyDlwm+E7OpjEkrrpU73C1MOqXRKoROxbhLtGATdb81e5P2pazEszjYnxQKtlgdPS/DULd
	/dYA5gy6IJKi85ajRT17LkIrBoVeh6QHVtYl8fzXvVP+r4oelbU3HQXOf1/V2yzo40vg9s1Pyip
	MQSgpDPr64=
X-Gm-Gg: ASbGncvbaq5v7j61czqg7w90Fh12dR3cdKLS5xN/KG+zs93GKDWn1GBXsENBJ0fdOjs
	p59RreKdcUjjOEcMtDT8M4t0v3Xu7c+GShnBO+TOdDL4I6a0sXW8k3up4jbT4+dFG33lU4idENq
	QvaTbY3cAd71xr5jnrdukh5Fbm85RaTssARB8Ln7D2nFWMkYQzbvT1O3uxpFnIIUax/GXeOfhYH
	BWShiy9T6J+PWXoKR54McawJFGo0x4SMLNXYhHtrVzqkntGMVZRBRo4FlAJW9UaCgvLAIPvshiR
	v1hAezzlFs8DQ6Xa6DZ5NCY25upZmdfxab842yzukFuA7ZeKquD/J5ICENij6QvZuPHlIfLfwr1
	6+zpvXKcdGb3OgR0ooKMCmb06khQTMYWM8XjeDWKttwrpjZv9xrArC8itxkwdegcR5HyeE8qWbj
	3Ehg==
X-Google-Smtp-Source: AGHT+IF7llzP2ufty2tZU0dmTGA531FAdGObdJ6yxLLT8SY3mwz/6ciQlWcH4TPgqcR0XZmpaL8wBKHLpTGv
X-Received: by 2002:a05:6102:334f:b0:4f6:25fd:7ed3 with SMTP id ada2fe7eead31-56d61f56b62mr151118137.22.1758082160299;
        Tue, 16 Sep 2025 21:09:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5609df31506sm606587137.0.2025.09.16.21.09.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso2150323a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082158; x=1758686958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l12ohqJNrU4xfHlF545pSJaLylbmlbI1I/q1wV+6dXo=;
        b=MOmAw/8TEdIR05gEYRPGtRI4v0u/oYW+lE4ICTNvEI1SK4oOSmuaLefX/PIS9C1Yv0
         LkB/0tc2WLhLtu0uxQoepuU8SbMS7xuMtfeiHxgHNqXu1SjY1NDuDSm6Tu0ZuPSJ9cci
         8hfMSxGLf+T+krnZ0DANycWIT15AvxiCydgUQ=
X-Received: by 2002:a05:6a20:7f89:b0:262:514f:16d6 with SMTP id adf61e73a8af0-27a9303ef38mr933024637.12.1758082158222;
        Tue, 16 Sep 2025 21:09:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f89:b0:262:514f:16d6 with SMTP id adf61e73a8af0-27a9303ef38mr933002637.12.1758082157871;
        Tue, 16 Sep 2025 21:09:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:17 -0700 (PDT)
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
Subject: [PATCH net-next v2 01/10] bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
Date: Tue, 16 Sep 2025 21:08:30 -0700
Message-ID: <20250917040839.1924698-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
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


