Return-Path: <netdev+bounces-249201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A421D1568C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F17301F8EC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F831986C;
	Mon, 12 Jan 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKcNcThW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712C33065C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252784; cv=none; b=IZKh0HN79GT1kbQnbMuhCnGw9yLo4YswHXSE9PfhUGh/zakkwP5H9DbkTI+R+ASuzbda3orZECEUgBY8863eLPBSAn5jySJOr4OZz7TVKNNYWFzRnTKOwR9an6owSOHaQ+4idJZmvlLvCAwPn8FuGdKQXMSWgTO9NkTD4hxnqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252784; c=relaxed/simple;
	bh=D7lUCV3aYqjGohCTy9zgZn2rkifLfGKh3rvthbmFj34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5naZvgKAtgsVPn1vbLoPrgkeUHb+vzG2Z4jJ0GQqV6nbphw6lpFzml6rDhyywmLdE9eQTY2YQ+wTdSLkcbOsFhIZMO6SeWibpHqzGxfMcd6pOJc5kOc3I+uPGaL9HEOgWii/bQsQVwRhWlcczjejcgdbXmOi/DFKBMVX04nfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKcNcThW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso62798065e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252781; x=1768857581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU5X1qd/vAg9hJW8qWNjjJ0/5cPRtVeVFt9uy2Diojs=;
        b=AKcNcThWj7V9rzWK9cGzcJdRctR+IqApiqlcCi+x2cG7eGklAFA5Fo+8YcK733gDuV
         slwa/jrXyO/fhCvZ+fg/3GM2Zwgalh8q4u9FY4mVou2elTaK6RXY7CnECfZIDRs+A10H
         D3Shyn1iHzVJeMLnd3mmKLuXUWR4EaugcX11IIiPNhEqFja1/KvVocrH4wriVsg7Urf2
         jXxf6hOscVbRvoKJuBTE1SL9lv9l4TwjEWBuaDBYVMwkTnVj9C+tLutg+1Q41Pg+zvIK
         gmm3HLSIwvZe0Cs/xpE5jDl62iMUSvRQPyIKQDJRmh8tqcymtUtoSxXAqM24QKA1bkct
         8NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252781; x=1768857581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TU5X1qd/vAg9hJW8qWNjjJ0/5cPRtVeVFt9uy2Diojs=;
        b=XKZVZYk/J2HdrkBCvrYW6aqMU/A7lHKWT1rJsyHt7ffP4vg45J7/Yt2LwTSDIuAi7z
         0TOOoedP39rKjVfm8Yxyv3hvxf3izEibY7JrjU9gszK6jC1vLQyNtRU5XxYYvMoyTnQJ
         egEumGOEcUTpQ5RDjp64K6+lN6PfoD21P4NFPHg5ZfVJ02M9mlqZsQ3OpPMZWvlwAXJM
         /832hG1/A3oUJXanaRXOWP+7uVd7JgOhPUK/lN7WMbbHhxGrws9mactxUwOgh8HtjBlY
         JXSV9eQuRlZxL26ip2yTcMauiv5Thv69L0EdwUCEO6fKJw7W9VmTToa0TbNzuEkYjrqQ
         AtZw==
X-Gm-Message-State: AOJu0YzSoPu8fqC08Lhm6BFpTs5JY910bvLN8FQTI/dozUMBsrnZJTBX
	m4C+0wsTRrClKOcYY35z0y0u/545kS+XZFfvwOv6JRLSiQ2CpZBH7ASDyVSKK++F
X-Gm-Gg: AY/fxX6BpseBoov7YxJeNIBf4e2wPsOHWYusK/gdI9bL2H5aIWVDo43kozpLrd64opf
	4Zfr4r4Q+ue+tezaZrCmMvaElyrW+TtWJfjMpa35JjiCL626GhftQu0qkKh7viipxoTob2LauO7
	qe6wCPh/6sd3iBeiGSUDyk0qhPea3SmgG1NsJOlg5isZK5byH7YPmncnC92zzREoGEDPhl9vy3z
	O+dOO/xA3giyyGMZT4C8uTzt2m4Ilo+UamjLpc2uJfULgIZwpcc4HebinNfCyx9tmtGeqLni944
	wEzCwmBxAStZvK5INVw+4g5hfByCnGb4qPHzMebQh52ZnfcuO3l++RCpZY4IwqaTv0A/cVks4lU
	Ex80SM0gMLLNJBrAw5GRQHuJrvW9QQGncftkXdgD6UI1xDxeQtviNab9FUcJvZ5I/CdcMMm/VpN
	lhz+UHGK3n
X-Google-Smtp-Source: AGHT+IHcUKI/1SZAMIWv50HBpY72bt/ip51n393gNC/ZBDIuiCiSmWuWCsm/NQEACCOs4MChaYhuTw==
X-Received: by 2002:a05:600c:4fd0:b0:47b:da85:b9f3 with SMTP id 5b1f17b1804b1-47d84b34a73mr228015495e9.23.1768252780379;
        Mon, 12 Jan 2026 13:19:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed9444831sm1063475e9.12.2026.01.12.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:39 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V0.5 2/5] eth: fbnic: Allocate all pages for RX mailbox
Date: Mon, 12 Jan 2026 13:19:22 -0800
Message-ID: <20260112211925.2551576-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that memory is allocated with GFP_KERNEL, allocation failures
should be extremely rare. Ensure the FW communication ring is
always fully populated with free pages, and hard fail initialization
otherwise. This enables simplifications in next patches.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 3dfd3f2442ff..09252b3e03ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -415,7 +415,7 @@ static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
 	return err;
 }
 
-static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static int fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
@@ -428,14 +428,15 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
 
 		/* Make sure we have a page for the FW to write to */
-		fbnic_mbx_alloc_rx_msgs(fbd);
-		break;
+		return fbnic_mbx_alloc_rx_msgs(fbd);
 	case FBNIC_IPC_MBX_TX_IDX:
 		/* Enable DMA reads from the device */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
 		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
 		break;
 	}
+
+	return 0;
 }
 
 static bool fbnic_mbx_event(struct fbnic_dev *fbd)
@@ -1683,8 +1684,11 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 	} while (!fbnic_mbx_event(fbd));
 
 	/* FW has shown signs of life. Enable DMA and start Tx/Rx */
-	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_init_desc_ring(fbd, i);
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++) {
+		err = fbnic_mbx_init_desc_ring(fbd, i);
+		if (err)
+			goto clean_mbx;
+	}
 
 	/* Request an update from the firmware. This should overwrite
 	 * mgmt.version once we get the actual version from the firmware
-- 
2.47.3


