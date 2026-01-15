Return-Path: <netdev+bounces-249976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7242DD21DD2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B27302DCAC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA277263B;
	Thu, 15 Jan 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6J9Bwkt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AB77F39
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437246; cv=none; b=oVwnm91m+JE2qrwAqqA9pS3r5O5hoxRvPOnaHaeb6mexQqdQEhnOB0E/WiGiblM3Ln+3GwgqtMZ2ya4x/+O576o4SePBk/RGj28dTfCcEIPjjl7SSd79Dqw+hbddX9I3iMx3065gCBeZaREOVG+O3Xsja0uaH3sngJ5XtJp/0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437246; c=relaxed/simple;
	bh=D7lUCV3aYqjGohCTy9zgZn2rkifLfGKh3rvthbmFj34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+I+AOhXx1OqCYIs4uDtpaIpF+iAtlaWouQ6p3uP31h30B1tSbqZBbwn+sMWbiMb2gFdS4BDa43yJVlWTiBZEyqN+zYMa3ZeYMXWvwQ0OAVUv7TmS1z4Qkq53+ynHK6LoPdmMmN4LkV2W/1G1ICow+2NMlcrRDPSvPQ3jD3gZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6J9Bwkt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so2516195e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437243; x=1769042043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU5X1qd/vAg9hJW8qWNjjJ0/5cPRtVeVFt9uy2Diojs=;
        b=a6J9Bwktr1Bywv9ONG1EG+gfHxLlX9CXLYV2CzmSiThPcb1nYkUgGBSjfDhl/5ZJis
         xUZPIqZW1qjxgA6gMG7ZZruThp8gZxo0zPqwny+tHvhP3oIX6sIMIh7p2Y3bsc5uF3f+
         HZd1UWsayrRfmWwdSEr3S3lJm1l7O7sGe+1Wo6RGR9gOj5+0GHod1mdZ8h2LqRv1k019
         DoK1lRTVb3alH+3Kohqlkm+iRAqMw5s3c4BJp7C5NLQeD+0jEVtYLGalTZujJyE/hY8c
         LM5vjRLU+ZRhb/lMEeKl0sojHoFrybd3SvqjwZNhHUQmPk8yg5e3e6RLAeKiw5O7Rz1u
         2wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437243; x=1769042043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TU5X1qd/vAg9hJW8qWNjjJ0/5cPRtVeVFt9uy2Diojs=;
        b=jwWmXLkv6YEp5MTnN10R4Qd5AJEvqz1RCcBiWzMHLNzHr6O+2dDFuuOyYwVWNta+ak
         YnA6Rc/SVW8xNCvSuadY/xYkOwW8xPst2lpqa5zmOFPsmvoC5xlZcFhTTIqzvmM50Xvs
         vtRv60dfyfDoz9pzWLD3MBDc4b7QvyBXafFJfFYsVxH5hC9sKN97lDfn6FSmc+YT4WID
         PMB+tfSUqCKUveSjbsImdmnxApAtiDqamDOp3AhBGxOUp+HLGf5QhHzs59zh0FeMp6Bn
         VAqNTueJks12ReRmbqLFSk4IB9S6mrsWzK63A1w7IXrlTZvvH/k6w6vXckQCSTpBh6KU
         Lulw==
X-Gm-Message-State: AOJu0Yz2kBqiFGJU5j1uL8vXpCHfoP8JREfCgzNISoncIBAViqNcSA0v
	SXOtYzpvoD/sMGfvantyphRWT+amFTnfRkFctdgD3+1F9Whrnvj0ZP6KY7teXEkA
X-Gm-Gg: AY/fxX73W9VAxXomR0ZF37WuNe0dnALEYPR/YC18lUEVxEnAyqHkPgJAyBe4I6GTybG
	Og+NzRe7g8vuTEyrIH7iN8KnFW7nPy/w9ShbaaR2oMRTEb6nK9DiEOWD8jJRi7piMa+HOMVmDVW
	0dFPwhxnqx2I/hpDVl4ybpdBrgov0cpEenhFxma3MSARIpKXoMb+3ZYXzT0ekMIeL1yYxhOZ66e
	CuhVT+7loamH04DDVKRLopl1g7H4yyBsXRglU1lri7DaRRh8TWe8n7BELivOukpkmksX+h+S3xl
	JUkvUCyTrdpKqxDQS8qyWePBNP+ANjKlORSoFqsMXHZJMj3ssUPP57N10+D0ygQ7DrLcC7y6hjw
	QbcIr1OwzI1Tx6durKOOqk+RpH7MtjuKuFh6SHPLg5w+wrYwQZCcifIYLG7dnMSySXzHdwTUjzm
	kA1pirSx4=
X-Received: by 2002:a05:600c:8b55:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47ee33a97b1mr49875245e9.35.1768437242998;
        Wed, 14 Jan 2026 16:34:02 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b1390sm2234424f8f.21.2026.01.14.16.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:34:02 -0800 (PST)
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
Subject: [PATCH net-next V2 2/5] eth: fbnic: Allocate all pages for RX mailbox
Date: Wed, 14 Jan 2026 16:33:50 -0800
Message-ID: <20260115003353.4150771-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
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


