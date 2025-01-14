Return-Path: <netdev+bounces-157951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53324A0FEF5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1790A3A6F67
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68E2309BA;
	Tue, 14 Jan 2025 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If/gV0r9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15E2309AD;
	Tue, 14 Jan 2025 02:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736823246; cv=none; b=ni6AAaBszKWSSPjA+Kwxjx7Ul3g6XsqOjSRRr7h7rVJWgN5G/YgqA2vvkkIRdHBd78DpHyC62xdr3Ic9hsObTda1qVJ0k5O8NmMun5/L9kfesiQKV51Ss8rz8nDmq7nJ9VIj9N6JGrBpsZhTOHiqczxt33yKCUunX8WiLsT+Tbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736823246; c=relaxed/simple;
	bh=ElFUXp9q6iljQmtBw+whzCi2DF/JKgqDdFuOpjmLPlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=luWfrC8P5YRD7rE4DbKm6btkk2cVkFQmNaR4Oi5Yo199qWj3ZOEZEA4vt0RMIBJguxtOXMdLV+ksFQXYwh6mc/9EdufwG6ImGcAV1l1GAoJD+OPlwRgowfx18++2lCEE4FKV+eIFec7tElxCMNGmJ3BtogBQaK0WA2w3iXGRKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If/gV0r9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso84556615ad.1;
        Mon, 13 Jan 2025 18:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736823244; x=1737428044; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok/IQOa62Tbl3GwEmS+ObXXdpQRIUD7e0K9z851aND4=;
        b=If/gV0r9hnmFVZmn8zo41I1+TwtLfTHdet4BpeYJfWgnbvL/AaWkI3SLk1RiUL5t1g
         lY9jaErj2/PJZh4yk96tRZ6BkqMkCxELs4x9efX33ryT00/XeK1dQY6FnMRXYiWHUqr0
         hTHbXiGpOMUmD5Tg5gSZEhuu7TwRbewdWsyhTVnmORLpFLWc3eERNZwwQQjm1LL90ISo
         bTpQWEhVkGUjoCk1R7v1gYmZEGaaQLvuH3QIqu8GOmkpZpT9n7l4BeXriErkuzwZruua
         opeQaWEJoTKQb4s2UNfDP2pSKswCuUfURUbrIco419BEmNqwloD5qrRQRkbauNjGhNRw
         yBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736823244; x=1737428044;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok/IQOa62Tbl3GwEmS+ObXXdpQRIUD7e0K9z851aND4=;
        b=jsRsn/3xbtVnMQ7qR6Mo+BPpc4GzocAOI9Mv1AEIULi8d1LpRIOiUYa4NdcOe/hrTW
         uNv2soZROc1hH9rBK//rI88GyWN/9oNxHGpV3qverN0LhXoVXdKsonggvv4uc/i7wwoP
         G44h9zPWwCiyBBIDDLcg1Rlkg+bUnO2rDneAQRt4KNXIZGrJzxwUoIufdb+iLPcuURDF
         ac7ugj1wFoZJllJDuQacDA5HE0Qmi0ndbLXI27ozs4UwgscnkQnVamWJZ7oOXhWXwNBt
         Q6IiP3NTYSoczUvFbr42VmIigOfpuodGz2SmaB7Pdp3SVibZ91fIZzW8JCuVGM/goRAb
         VGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLic8ZFTyHIXUAViOLG/4tTBFujgBY38/yr6p7JDXx2zrdrMvWXoWik9N94gNPdE4tlPE8jr/CxGPH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0A48sD16ChBB02TBUdQCbmnHELKpU+Zx2aHondTou09q5C9bJ
	1W2g/UZLl8XsDh5AoXHUOsN8sKPyBPQ4NZsnzbpbNUJOngnvYbsp/u4ssg==
X-Gm-Gg: ASbGncuAxrt4kIkrgxviagxWEhCaiBNZ/N4V0P9AX97q48W7yh0ZRNonf+4ehsdnPk2
	KcN+cIOyrrU2z8svnZlQMb7XBIHwwDpZYtoDesuUtn84ph+3BIVIPIdb9C0fHa0jnzAcJQ/LEd6
	BRHXnccY07Ey8ucizSUHJ7irfpAEgeoWZw4ypn7L/OdcT0N0RPu81mEEWZQwFR9MMF0ggAB+tzo
	x8VWrs68wa2iK4sGXO/zZSj8Fb8FIYeRkZo9ucMjcUHLBOwseURQlSJTuFxJk/b4Q8l05nh0DVf
	IuRTyAf/+lQF8h+d7Sq2yf4xj6lk3Pv4sw==
X-Google-Smtp-Source: AGHT+IGmL9Dd5TUeCazV5GKwdIsgzKGZZGJ9BA38deHTplGttA8ARLAWXTjE0QTXgue/f7Zool4QCg==
X-Received: by 2002:a05:6a00:9294:b0:72a:a7a4:9b21 with SMTP id d2e1a72fcca58-72d21f16046mr29342692b3a.5.1736823244130;
        Mon, 13 Jan 2025 18:54:04 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405484bbsm6584671b3a.31.2025.01.13.18.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 18:54:03 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 14 Jan 2025 10:51:39 +0800
Subject: [PATCH v4] net/ncsi: fix state race during channel probe
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-fix-ncsi-mac-v4-1-4f058b7f8a99@gmail.com>
X-B4-Tracking: v=1; b=H4sIADrRhWcC/3WMQQ6CMBBFr2JmbU2nU4S48h7GRSkDTCJgWtNoC
 He3sCImLt//eW+GyEE4wuUwQ+AkUaYxgz0ewPdu7FhJkxmMNoVGRNXKW40+ihqcV8i2pqa1hC1
 CVp6B87/lbvfMvcTXFD5bPZl1/RNKRmlVUcXaoTNE7toNTh4nPw2whhLtZfqRKcvF2frKlCXX2
 OzlZVm+SLLcluUAAAA=
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Cosmo Chou <chou.cosmo@gmail.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736823241; l=1830;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=N2jwPUsQAaCf0uIqCMxFZmX+1mFiNUqK3aMSPOy7nUU=;
 b=0TqDIto+QJaR5Z/Zs0toELo28tbLSKThV+MM/xGCGAiyDmrNmvCzcAyumFlhEjq+ac8+YuGI2
 ZlHbK3gqPt8Co5Fm9Es59AA25f01FuBVSZkMYxavWmO7ibU+Ion2w19
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Cosmo Chou <chou.cosmo@gmail.com>

During channel probing, the last NCSI_PKT_CMD_DP command can trigger
an unnecessary schedule_work() via ncsi_free_request(). We observed
that subsequent config states were triggered before the scheduled
work completed, causing potential state handling issues.

Fix this by clearing req_flags when processing the last package.

Fixes: 8e13f70be05e ("net/ncsi: Probe single packages to avoid conflict")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
Fix state race during channel probe completion.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v4:
- Remove Paul's patch due to two patches are solving different issues.
- Link to v3: https://lore.kernel.org/r/20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com

Changes in v3:
- Fix compile error by removing non-exist variable.
- Link to v2: https://lore.kernel.org/r/20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com

Changes in v2:
- Add second patch for fixing state handling issue.
- Link to v1: https://lore.kernel.org/all/20250109145054.30925-1-fercerpav@gmail.com/
---
 net/ncsi/ncsi-manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d..2feff885eeff 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1479,7 +1479,10 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		}
 		break;
 	case ncsi_dev_state_probe_dp:
-		ndp->pending_req_num = 1;
+		if (ndp->package_probe_id + 1 < 8)
+			ndp->pending_req_num = 1;
+		else
+			nca.req_flags = 0;
 
 		/* Deselect the current package */
 		nca.type = NCSI_PKT_CMD_DP;

---
base-commit: 56e6a3499e14716b9a28a307bb6d18c10e95301e
change-id: 20250111-fix-ncsi-mac-1e4b3df431f1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


