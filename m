Return-Path: <netdev+bounces-160738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F59A1B064
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1585F3A324E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7C1D79B4;
	Fri, 24 Jan 2025 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCSdesCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB403282F5;
	Fri, 24 Jan 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699867; cv=none; b=DWyKyIyKLFfuj9MHJs0j2To5sjJOKJOIg7SmPEUt9AX7JgQyzzVrEe+0N6/b3NSMQSQraGDbdJwHMraKeaPHduZ2ZvQ1EsgMP9CJUBwP2eZfz/PexrFU+WwOisaPxy7DKrl5I2mAjHZVsX7SpkOurxVRtw5ZM+dSaH49GKVUD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699867; c=relaxed/simple;
	bh=oPp9UbFQAbqgtqdRJT2DfnyLfhkA6CJr24HKiInVTQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjgyDxiyZ8kyAJ0E4zbL2uGa8O3SY3mWV34q3K7HiDv/0Me8wPGhUwk+tf/TJ6KSkZ/nPAGq45C3Y6G0GnoC43qLlEDDSM3UFbd5BncmwrRYPkTdQq6MOF3K/ik9IE0G1iyPBNj+2gpmzWhEZUPGOQDKb17cmooR6g+KcTkjnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCSdesCJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so3148309a91.2;
        Thu, 23 Jan 2025 22:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737699865; x=1738304665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=px7SZLocOJvGSlrv4q3JvkNehES3/sZ0gR2ceXl8pNg=;
        b=kCSdesCJVdkT62lKBBLIELkYb/MsUGCxIOW4+i1O2l1Yj4yJG1V4BOGurso940mFVW
         LoGDx3d4qLmcJFKZ1c+Gd2ys2K0kMHdPgeeWGpxAEhGPX4aVPh8SWe/3XCbSexO1s4E7
         XATR0LSN+zR4vBKjR0q49OrYXnZAgfW9ELeBbW8+TivxuGp/2KMGdAErwApzm3KQOz0S
         P8PbsUn45Sg3rDhu6dPkzOXpmfhLhIhJ0VDb3jSc3Lkht+q4DOLXFwOndW2bos+NsNBY
         A77zAy6Gy8mapEFPkP7IIV0DDrdTs+SCJFt8XxUK10gorzgy3mW+CDN6z6Yx3RsSm701
         kMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737699865; x=1738304665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px7SZLocOJvGSlrv4q3JvkNehES3/sZ0gR2ceXl8pNg=;
        b=OJ7zIdL2RZgwHfian56SX36ug0kukT/jRX2Ru/DpjOdw4COarDJrUOd0gyZW0CQSPQ
         bY5l8pEHf+1TGY/pWTGW9hnCOcgDFQMbqYJzqFdrrXX+hj+gHj8BiaXHjp2y9dutFFQZ
         CSLYPNf6Euoqv6cK5MT7banhGEHkIpoqRPsy/z0bqDM2FWu2CZw5HGUTAwSRqGEyiCvY
         Oty52Dz0o+JvOsC9rd2Nl6h6fuvKW/damecyniOluMK9d0wVOr/SL3bfRqh6TtLvIuNB
         +sERyxpWnCimceESVSPw2n1IpNrOPq5ai3Lc7T+Bn3uJAJPr6Kell7CDZCeVvCSIfDtx
         rt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUQgX9t3PGPZMWoIrC9OeeVKrO6DnIYNaUl89RhMgM7U1++u7pGj/YWsT1kbA6jg5oimlwqNVDvzNm7HYE=@vger.kernel.org, AJvYcCXD9Bp7n+uxxwGFIImjCgIvjkSxHmlqfJOnhu1af7ou5lD0Jw640UFSpcqcrewcZWFxCxjBWABp@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZxf0Fx0Am2FlX+lxt2dKKhaBn7mnbe4Ik0GUz84/zhVkqIok
	Q+b4XIW1k/RXkWjl5lLlj5WrBUYEHa4TIaeGKSjSo2+YStqp/3W5
X-Gm-Gg: ASbGncsrz16pujHyOT2HoabsfsrdNFFkQkR6JvmRYKjC06jZH+OxbGAt5+izOUeXYwO
	S5uLeosRPzOYcCAMQ0d1Zgo/Py9zo0iGrVjU+DskyZBL9f7G4PAQq3KfSBP3+cbBeO3ETh3Kd3o
	UgYDhjdD7TF3Mytp/xXOfFHxkElUolbY3mx5JKjpn+uAUiPxGx+Zwc1mOzH0n6Lf3v97pUKRSjj
	XOozLtn7Yr7j4xClKv7ovrOKADNO8rGreuNJjN7q004ZV0JF5Lq6LQhfentY0Bon/UP7lrm6CHu
	nMdbm3yE
X-Google-Smtp-Source: AGHT+IEXxtI/HWBu1a9kzZhi6nKINvBdHEMY4tCSzQsjAcK6Og6ryCmWBoLIw7uvQjmPCk9wFWi8sw==
X-Received: by 2002:a05:6a00:b8b:b0:72a:9ddf:55ab with SMTP id d2e1a72fcca58-72dafa0310cmr31554685b3a.10.1737699864964;
        Thu, 23 Jan 2025 22:24:24 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78df41sm1009284b3a.160.2025.01.23.22.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:24:24 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: sebastian.hesselbarth@gmail.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH net] net: mv643xx_eth: implement descriptor cleanup in txq_submit_tso
Date: Fri, 24 Jan 2025 11:54:14 +0530
Message-Id: <20250124062414.195101-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cleanup of used descriptors in the error path of txq_submit_tso.

Fixes: 3ae8f4e0b98b ("net: mv643xx_eth: Implement software TSO")
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 67a6ff07c83d..8d217f8d451e 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -881,10 +881,20 @@ static int txq_submit_tso(struct tx_queue *txq, struct sk_buff *skb,
 	txq_enable(txq);
 	txq->tx_desc_count += desc_count;
 	return 0;
+
 err_release:
-	/* TODO: Release all used data descriptors; header descriptors must not
+	/* Release all used data descriptors; header descriptors must not
 	 * be DMA-unmapped.
 	 */
+	for (int i = 0; i < desc_count; i++) {
+		int desc_index = (txq->tx_curr_desc + i) % txq->tx_ring_size;
+		struct tx_desc *desc = &txq->tx_desc_area[desc_index];
+		desc->cmd_sts = 0; /* Reset the descriptor */
+	}
+
+	/* Adjust the descriptor count */
+	txq->tx_desc_count -= desc_count;
+
 	return ret;
 }
 
-- 
2.34.1


