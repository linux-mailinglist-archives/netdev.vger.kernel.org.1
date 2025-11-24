Return-Path: <netdev+bounces-241102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C5C7F3A5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 068F0343D7F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECD2E9749;
	Mon, 24 Nov 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVE8HIYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FB2E9730
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970062; cv=none; b=aoedo7iTSKbNk16gyCNMl8HG6gadgKeNGX5D5XtnJVeS/A6fowsUKBJbSPLw8j7G1EF2cgl6qdfmbJeZV9++O1mLJ7/8vieojCdGssKX9YLFi1zU+CHbF4eR2rUtbmDdgKIoX3gTYAdAWA0hrgC7kaTvJ3fnZQzlDOaoNKC2Eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970062; c=relaxed/simple;
	bh=Usqx83ivKY4w0KNMbSY7X0Z+d+La037+pNfmug8W6AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWWNH1p6h1o0lce8EgVBYD4x4pG2aubcak+ufWd+yzpy9Dq96yNVRPvcWHIYOw3o7SkQ2hZbAkT/cMW1ThMgWycrzt74Hs6RGng8Ge7ZagnF4ElvBId62WR9Zi9hpdevzn+1U8t6+iaSz5IC8pibruM+fv/xyHOjoJafDJfnQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVE8HIYO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso4664261b3a.1
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970060; x=1764574860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1gxk1DsHCEeyciyJk4Gm3Xoh1TUbmw4WS4h5BWbH44=;
        b=dVE8HIYOWxYwU7fsMbzdoWvka2acM2IzeSjadWIrBOCaX9q6dvMzocxxtmD2yUfPzJ
         JLEIdVHEKTxcVxTiTapZbsMzuYpj04LJXa1hIGXnbonDhets1nO1SpNp3H8j0fuAVhw5
         3XTPVrfoTVqKmoQuMXkWzCRMmYHwRZlTygoAIa3+YMI3Q2kNPgmc5qqT4LVcBRQkIR4r
         8q7dcMZ68Gy4WRIpegMh4h1aeecMrPGHxLUkPti5VYt+5H77lKLgpk94j3zzVSxPmF51
         pI82hQhrRiKX3589CyK6zrjXslamN8At2+8KZZY/49n/4cvLsu1A1X5MyydCExtSvj1D
         wreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970060; x=1764574860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1gxk1DsHCEeyciyJk4Gm3Xoh1TUbmw4WS4h5BWbH44=;
        b=eQgO/73eg7lTvfRezxNpWgBTDuSOfxGzH8nGtBVScBUFVxRhwG4xDd1+zvtvzoyOex
         /zQeFf1GOleW6sIpSwkJApA+JwSy5bHT6C/8lhg7qvg2jbyg3PBcKS7Q78wlEedckoZQ
         BLTywNQ6tcBDEyTizM0PT5PNn6pxOhzt+I7Zx4lCx9M5D/G09EdS+kVSwRTUsxCukC3x
         s2jlPUHjRe8+EvwOuB/a0xeOQMpBEIAfWEf27lF189WqYnJL19K+p/9mP2bgDX3AlvDR
         m/xEJZW2Jpc3QNJAM8d7xyJg53bhYzdNNwafx6C7BEojztyh54JsLE7hirG6anyXHlU3
         DIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXiiUOTm6cbWV6ga7Z1rtlF3G7JqwHjdgIIwgzneVWpLyzFcx9Y5W7kb5SbW/ju2F8xLHlOBvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCO0l0BrZYg4SZM0f2Dpo8UvgJQ2vaM+dtR853lw2Eb8NpExqi
	Xc8Wupc6W3rZfLmTngNoYIItRFEDNiTHn14di2WtOGUEnZ38JEFMGZyM
X-Gm-Gg: ASbGnct0Y6SH42VOhl/L+F4qirK0U7Ds6Oi7i4Q4KDGL9Ce3bbXsag1mj0Wts5SLCQ3
	p88/l8qMVVggxkCEZh9GPmnZfN1PVQ0VwGFDlM8HBUc7gZWSEEDExyeV4cxhIgVNwQyvi6jolFY
	kfAH4SOoXn2CJnaGHSOetZJ2MerTQgX9tRcFJ0cRphHkG33ZKRB9VmMLzTxbEtnc5HA+nffpnz2
	sSzXJLekUsGWzbwTOrFv+Jl2qTVytiA/4G/WPGOqKKrOw0M9ul3z+dMH+ADLrXSXOy+brEw8Hgl
	241tgwFAntsi+7yig8qv+BkFGjFOO134RKRuLpo7bg7dbNYf90+gf4tmQJSI2kz8/YoRRxupUUC
	93UPKuokWLRjKOEZXufwTFtnhJKkXlUKKeIMvbT9e4+AdnX7xWX1GtEXXajXOt5m0Mv8d7XpLRv
	RR8lQ6s3Zl
X-Google-Smtp-Source: AGHT+IHfmjaPhmxevuKoc2EwOR5VBTWwkzOxUx7y1W2AyW7Z2BnA/hIC6PVmsv9rbVMC2nmz9/O3bg==
X-Received: by 2002:a05:6a00:9286:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7c58e112b18mr11801430b3a.21.1763970059740;
        Sun, 23 Nov 2025 23:40:59 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024b4aesm13410818b3a.33.2025.11.23.23.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:40:59 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 24 Nov 2025 13:10:42 +0530
Subject: [PATCH RESEND RFT net-next 2/2] idpf: remove __free usage in
 idpf_virtchnl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-a03fcd1937c0@gmail.com>
References: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
In-Reply-To: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
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
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJVuP9Y31rts6Yue0fpcp8Xt5s52FwP73Fh43N8EaW1s
 dWgyFyto5SFQYyLQVZMkYVRVMpPb5PUhLjDSd9g5rAygQxh4OIUgIlo5zMy/FEUvO7e3Pxs86K9
 RfaGpfPvTAqO+MZd3tn72qxlLY/MB4b/SX+vKAcsEPTaNJ2H95DAts1Nuleqr6c0XA2vXWmrlbq
 XCQA=
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


