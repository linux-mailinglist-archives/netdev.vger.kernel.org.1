Return-Path: <netdev+bounces-238942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701BC617E7
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B95B36306F
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6330CDB7;
	Sun, 16 Nov 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq80fUw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008430CD8F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308632; cv=none; b=qOYj36t8yTBQ4GXhBVSQBcSrWBCuRVkok4gieyNFyQ77ksokELe+HCwrEyXD8b11RRxHESN7g5Sf+TnLabNNla4RoCMsoSQ1whGGNtmwDqAbwGODS2uDVh8MskwLxziPoLNE22GlZByctYaGg3pKbAom/nNgbEcVObog8o0zl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308632; c=relaxed/simple;
	bh=Usqx83ivKY4w0KNMbSY7X0Z+d+La037+pNfmug8W6AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ok+OO5YTDOsXfwFbJNuzxxwuKlqMgszE2zc51GGUuhBdKhiydCDV2bhttOYKbz1YrGJGeSvSn5Ac2BR/AuNqndO9aHSB9zErzc/oTcOndJf6/wN9fWDOKLp+nYgOw/R843slDWA3yT0s0VxNKk7nrrUJh1PN+5XnfVRozCGWOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq80fUw8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ba55660769so1936378b3a.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763308630; x=1763913430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1gxk1DsHCEeyciyJk4Gm3Xoh1TUbmw4WS4h5BWbH44=;
        b=hq80fUw8PfSCSFLH+N69BcSS1hnZGek4jZrmWdC+bn3I6SbeWuPCsAX21TPNC0pgRU
         zqQ5VS4kQXS/jWrPVSjBYWPWz47msMHazcsWud+vQcVWVxgYPDSniihp4EwZOPuIKzkI
         u3XfxfHGBNroVYBb3RQTkzAaK3+Onjf1PpwkE1MiiuuwLOSG/hzSVmi6peVy0G2wAi5M
         rx5uLuyeCg7CciwQi66YFBe2xtvaVWKsdMCrymMnBJ8zp4g1Wy8fQ50Et+h+Jsc4esHF
         JUvlQhQ4gDIyuuxCuwZAg/xsCNIxpjY37tdPnlHq7ZooGB05WoWVRXZTXFZEAgjAdSGR
         z/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763308630; x=1763913430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1gxk1DsHCEeyciyJk4Gm3Xoh1TUbmw4WS4h5BWbH44=;
        b=EtL4k5/aZtnFAdaqoZkFYDWZFU2h/sR1xs3qQv1ESQ2DmNxBbo4nneVR6/Dc6m7BLs
         jzSHo7pXBH0chHk2jDehU53X3aNIvz0bRB9To7HJ8ZTkvwknzsnhN6bTDRVT26swOJ2F
         8jWvVPZVKtUfJd49lQB4JbjRr1xwYPRa53TVC0u515Af1+Zjjltv4SB8ewABAb5/LQvA
         TcNWwQPE1pVz83NowoRvv/5/AnCK/r3MmKaes8oTEAgQXC4EIOZcnipcSGwLdMLJ2deX
         jD5YqGo7M18ux821PxkIKq9wXomgsBXcYvD34yekmWoM4CauQhaCeScjVkQmhH3qt0B4
         ak7A==
X-Forwarded-Encrypted: i=1; AJvYcCV11tHemaVL4Xq51DKCA0y4H0r6MczTd9QTtBEpNEranZlHAcDeZmW9xHNbclpfFmBbS2TSwHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3clwQXjj0ucnMj5Rakr+CySPkdXQI6R2xg+5M0m2aZQpfUfR
	aK10ZbsaSNS9KdifpDMkUpkJx+aeD4p5c4aRoco0EfahXbfJzoxZV5aerLxOrA==
X-Gm-Gg: ASbGncv+3M2owYPHguaKZJ8ELetleov1slde/lbil9ObtTnoRlDPGxDPlRyM4ZjaSMk
	Sca2sQn1a4U8YV5j7XaT8ysZ4lkyQ8xDQw5atA2dF9AjKh4X8EodLpHPZ8xIbjqlr8kZottshpp
	lhr+z/zIG2LCYk1in1pBd65v9hrFx2k6TnxWdaPwASOw3l4nGcpEupi1jpPq7EJ/VcbxunJl+YC
	VazOyrCXgPjU1oUUICuWG+cAnYAO+NfkX6e5ibq2eVmQ+arxoIzPWt8xbOqUGVqfEx681CzqKXR
	bIUgOMZZ2tlJgFvEJ+CHx8Jna2m4/BwX4X+hvafiXkqur7h03zdNghEASGS+ImAiFgvkY8H1lfE
	V85f6f4oAg1RqZS0YwLy4tIJgFVAi7t0tOG1/EYEZkqUr3yM1aBF+o1R2/gcdxxuacnWpWDzlMD
	WwCpj+U+72
X-Google-Smtp-Source: AGHT+IFqBdx4R6YTOp0JDgvcZZT5ZiiWX5oMnR2HQmFdpl5m0+SbCTbe9kbJBhTtWt3ynBIXX091MQ==
X-Received: by 2002:a05:6a00:a95:b0:7b9:df65:93a9 with SMTP id d2e1a72fcca58-7ba3ce6b3a7mr11792143b3a.32.1763308630509;
        Sun, 16 Nov 2025 07:57:10 -0800 (PST)
Received: from aheev.home ([106.215.173.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924ae6943sm10677038b3a.6.2025.11.16.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:57:10 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Sun, 16 Nov 2025 21:26:49 +0530
Subject: [PATCH RFT net-next 2/2] idpf: remove __free usage in
 idpf_virtchnl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
In-Reply-To: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ally Heev <allyheev@gmail.com>, 
 Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=Usqx83ivKY4w0KNMbSY7X0Z+d+La037+pNfmug8W6AY=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDIlv7jmnYv3fraqfI7mvJ7YxevY13mlb7vk3NBbuq3tv
 cqLjFO5HaUsDGJcDLJiiiyMolJ+epukJsQdTvoGM4eVCWQIAxenAEyk7SXDH44Jk9c4TXmmyRQY
 2fS1qcYz4M4bR/t5J77N2vFm8n3GuAyGv9JqC4K+3/BbHjM1+scGjinaW0XXVbn+WteXqrXTMev
 9Jm4A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

usage of cleanup attributes is discouraged in net [1], achieve cleanup
using goto. In this patch though, only uninitialized pointers with __free
attribute are cleaned as they can cause undefined behavior when they
go out of scope

Suggested-by: Simon Horman <horms@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 28 +++++++++++++++++--------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..5b2bf8c3205bc1ea0746f78afa2a24f3f8ad2a8c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1012,7 +1012,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
  */
 static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
+	struct virtchnl2_get_lan_memory_regions *rcvd_regions = NULL;
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
 		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
@@ -1029,21 +1029,29 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 
 	xn_params.recv_buf.iov_base = rcvd_regions;
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
-	if (reply_sz < 0)
-		return reply_sz;
+	if (reply_sz < 0) {
+		err = reply_sz;
+		goto out;
+	}
 
 	num_regions = le16_to_cpu(rcvd_regions->num_memory_regions);
 	size = struct_size(rcvd_regions, mem_reg, num_regions);
-	if (reply_sz < size)
-		return -EIO;
+	if (reply_sz < size) {
+		err = -EIO;
+		goto out;
+	}
 
-	if (size > IDPF_CTLQ_MAX_BUF_LEN)
-		return -EINVAL;
+	if (size > IDPF_CTLQ_MAX_BUF_LEN) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	hw = &adapter->hw;
 	hw->lan_regs = kcalloc(num_regions, sizeof(*hw->lan_regs), GFP_KERNEL);
-	if (!hw->lan_regs)
-		return -ENOMEM;
+	if (!hw->lan_regs) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	for (int i = 0; i < num_regions; i++) {
 		hw->lan_regs[i].addr_len =
@@ -1053,6 +1061,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 	}
 	hw->num_lan_regs = num_regions;
 
+out:
+	kfree(rcvd_regions);
 	return err;
 }
 

-- 
2.47.3


