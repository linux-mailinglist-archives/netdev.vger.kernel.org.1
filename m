Return-Path: <netdev+bounces-248242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3DD059AA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2519E30617C8
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579131B107;
	Thu,  8 Jan 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hAgWGe0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F531D366
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897372; cv=none; b=j8RBlWESJdWUMzP/lQFaZvdaTgtwma32u+9ileDnR0KU9v7BijRPd+w3KyHOxxo9XTfsTDmY2YxxgGUD9NLT6oCAgkQS4fstvSv0AJu9znor4DrV7LRLy8DqL25lvZD5GmotokrHJBdSkZMfUEkZTntIkzh3Ylb/kEfvfqSvri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897372; c=relaxed/simple;
	bh=d8EMOf8Fk1Tup6le9fvotjNBnKBtzAXIIIVRTf40mno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxjlEk26iUu2IAErU9TC7M/A3VJrvkJugbamPrZkOC7R3Qmw7KMKcInfG1unSAu/lDDfCoL4DCyLSIrFlkR4ySST8JuhegEGhmFGl4qQUE1bIrIwX+cCwRbDZltgKAfaEzuPaOuJjKhvBqUirKWaRJQlutHExbPXxh7VY1FBv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hAgWGe0a; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2681001b3a.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897371; x=1768502171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBQ9TacjFBzOWlhuKZ/poG0odYuVvSSj8qpZjEFXk6g=;
        b=Dm5Tsl11FZH5v0V6/HNppslWM66xUgcsYzOtJok5poNj6qPF/Yyn1i4maawA2qN8oo
         DoJZmmNBp1tgLQ43fFiwrxmCgcmxWBqQRFlgYUATE0wVKiHjdZHF6yoE++OhOy1DMPWk
         OzrNZc1jtOj91ZsR8w35nrmjt+l3fz52CzSXkCj1sGMIEHU66p4DTBfdVC3kaZIQhT2t
         1iFYTdO6X6tHAxFfPFt1N8QWzlCk6ellIWf9wtmWCd3YCQq0AomaIUcf+faLY80tC186
         MDtk4/WPdUw5v5UmUc/ogMEL3nZ7VW7re37yy7nnn81xxt+GSVa7C67TmxtRPUjuTsc9
         SGtQ==
X-Gm-Message-State: AOJu0YxBGZFeTW9PYHfot36JYBeeJzoHYVeuCv1MC/2YBKe9H7ibEtso
	hIxsgUlyMRPnri+BEXIKVALTwKCS8TDWPCIBPm5zRddNfi2lT3ENsYWIZCKohNSudhiw07CitWB
	8fw716WRVYZIJiMA8g0JQDqW6K1XUK9kRBzS+MN2MkqvGA8dihFzyKQQeZot3MhXYNyWp21D6oh
	WB7USw9SOm55uCZYqP/zrjANoFYHOt8MuAGUoA0chRLPulDshqtOYW0hMCk3iK1XRHqJJHWMqrv
	S2GojpcYZQ=
X-Gm-Gg: AY/fxX5Huuyo3SZw1LnnJltS409HwMz2gkyf+tRhG/uiBtdKqIJGBeG3xG20nEJe/rA
	tKuVPWCA4itAXNHmOL6Z5KnH74Iv+p9SYLPgKxVH4S3KEPoIV5HvoR0chN8vX8zpk3Rk7EJiTmA
	4jexUjcfZdGowQ3nOcv+eTMGuUZVG+JRfVXmw+e+1LWv7FkZBjoP6EcZVAp9Max3DJVE8q7Lx0F
	yMLIycrIaPNmZpngaaRnoMIwCHyyW2XUyAiR0Khu1nXM543BZZKDRDvKgpU3GvdfEJFwv78v6s9
	YZ5SsB0ZqZUSnXUyYNgQjzqQj86w/r6l1EQHm4HN7hVSS9BN5ejNYcs86302Ixg704RcnjhhwxU
	ebYKm1RgC8Wz1DPjElG30kSydrktcW2JJLAJsA7Mabyt0BzmsGPaTsnPlatwYE1IBtFENVnpP2p
	tPxaRp56YDSHgd8uV3d47LRNGVEyBYXzSA2lsHVEj7Ytl5f+I=
X-Google-Smtp-Source: AGHT+IFQgER4pADO3YOOrjY24jQCq9n7ipmRkzSgaZ0vroAahSs8AbjTVvAeWY1V4K140lEr3v2AFl0yJ5+b
X-Received: by 2002:a17:90a:d40d:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-34f68b4c624mr6905740a91.4.1767897370850;
        Thu, 08 Jan 2026 10:36:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f6367c7c5sm928497a91.3.2026.01.08.10.36.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a2cff375bso81611816d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897369; x=1768502169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBQ9TacjFBzOWlhuKZ/poG0odYuVvSSj8qpZjEFXk6g=;
        b=hAgWGe0a1NMEXXW4kGqyg+KHbOoXvWSessdmWgWbulxawLDrYULLsEp7NGb29RfTcp
         smg3uJwt+hAq+nGJ/C19ia81Xxituf3zNYC9gyk3ZTgb+51DObC2Z2xvi/46qssSkNh1
         QcKj2nkZT1lcw97252wXdzNe38bQ0zWsO2o84=
X-Received: by 2002:ad4:5fcf:0:b0:888:4939:c29 with SMTP id 6a1803df08f44-89084337fa3mr90203076d6.71.1767897369438;
        Thu, 08 Jan 2026 10:36:09 -0800 (PST)
X-Received: by 2002:ad4:5fcf:0:b0:888:4939:c29 with SMTP id 6a1803df08f44-89084337fa3mr90202746d6.71.1767897369005;
        Thu, 08 Jan 2026 10:36:09 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:08 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 4/6] bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails
Date: Thu,  8 Jan 2026 10:35:19 -0800
Message-ID: <20260108183521.215610-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
References: <20260108183521.215610-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

When updating to a new firmware pkg, the driver checks if the UPDATE
region is big enough for the pkg and if it's not big enough, it
issues an NVM_WRITE cmd to update with the requested size.

This NVM_WRITE cmd can fail indicating fragmented region. Currently
the driver fails the fw update when this happens. We can improve the
situation by defragmenting the region and try the NVM_WRITE cmd
again. This will make firmware update more reliable.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Simplify the do-while loop.

v1: https://lore.kernel.org/netdev/20260105215833.46125-5-michael.chan@broadcom.com/
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index af4ceb6d2158..4dfae7b61c76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3848,9 +3848,25 @@ static int nvm_update_err_to_stderr(struct net_device *dev, u8 result,
 #define BNXT_NVM_MORE_FLAG	(cpu_to_le16(NVM_MODIFY_REQ_FLAGS_BATCH_MODE))
 #define BNXT_NVM_LAST_FLAG	(cpu_to_le16(NVM_MODIFY_REQ_FLAGS_BATCH_LAST))
 
+static int bnxt_hwrm_nvm_defrag(struct bnxt *bp)
+{
+	struct hwrm_nvm_defrag_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_NVM_DEFRAG);
+	if (rc)
+		return rc;
+	req->flags = cpu_to_le32(NVM_DEFRAG_REQ_FLAGS_DEFRAG);
+	hwrm_req_timeout(bp, req, bp->hwrm_cmd_max_timeout);
+
+	return hwrm_req_send(bp, req);
+}
+
 static int bnxt_resize_update_entry(struct net_device *dev, size_t fw_size,
 				    struct netlink_ext_ack *extack)
 {
+	struct bnxt *bp = netdev_priv(dev);
+	bool retry = false;
 	u32 item_len;
 	int rc;
 
@@ -3863,9 +3879,19 @@ static int bnxt_resize_update_entry(struct net_device *dev, size_t fw_size,
 	}
 
 	if (fw_size > item_len) {
-		rc = bnxt_flash_nvram(dev, BNX_DIR_TYPE_UPDATE,
-				      BNX_DIR_ORDINAL_FIRST, 0, 1,
-				      round_up(fw_size, 4096), NULL, 0);
+		do {
+			rc = bnxt_flash_nvram(dev, BNX_DIR_TYPE_UPDATE,
+					      BNX_DIR_ORDINAL_FIRST, 0, 1,
+					      round_up(fw_size, 4096), NULL,
+					      0);
+
+			if (rc == -ENOSPC) {
+				if (retry || bnxt_hwrm_nvm_defrag(bp))
+					break;
+				retry = true;
+			}
+		} while (rc == -ENOSPC);
+
 		if (rc) {
 			BNXT_NVM_ERR_MSG(dev, extack, MSG_RESIZE_UPDATE_ERR);
 			return rc;
-- 
2.51.0


