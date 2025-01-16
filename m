Return-Path: <netdev+bounces-158892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B723DA13A85
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF5D1881BDB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11121E5716;
	Thu, 16 Jan 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1D87wyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF801DE4C8;
	Thu, 16 Jan 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032974; cv=none; b=gRdWTFumDpgOCRTM6C9LIuiFCf9sW7SD5r8oWfeNtwcBjs08YNXr7stTwLBwAu0DIVawZUfitvmwyLDZizkq9aiwi01e7a2aR3AwSRNzbyREcorJUh5e3ow5D2+HauqFKPhDgOXr3md4xWX7rklDMRjrnlDRMGoBJzaNTk22I40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032974; c=relaxed/simple;
	bh=cIAqiPzlev6Stxgd/seSBG5lcv2RnLx9IgIT7Mx0JD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gd6SxeatEWAmw7j6kBhqTPN4zyTU+7tWW7g75ZZz2jE/7UNiX8IdTobr9EUvT706XqgpjNf+RDGs4zr8a4SX3euBroNFUmC19Fho7SciZd54NNXvK621S3VaWygYPqJZ6M5EVSjAkAUsUA8Jp+BE2AW+LFRU/MEWuLMjEC3UjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1D87wyC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644aca3a0so18843425ad.3;
        Thu, 16 Jan 2025 05:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737032973; x=1737637773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snptrSjCp/WTiLu8I8u0XSZwNccoh5U/0syc3p+zW30=;
        b=X1D87wyCY/qCu/wnjT4xReIxQcbrlyX/gAxKmaYCbOofVvMWG9RKAL1Ls0ZgdAyR8X
         pBap5IXiRO4+utQ5VZhxKUUMmXAgpcqiAcifh9AEt73u36nOLlt7TPg1maH8Lmy5vDWK
         c7+1p4ASmcIHKvrIQXAWL99FWL0pPqph7ONrNado1EEV1m2maoqYllUYfx9TIGnics2T
         AofeUq+kdpsNuqCsJEXJJthw5a+GgPXJgupejG/sGAH1SDBLB2BtHpFl0Hf3BrV4Or0p
         dFs0oVsDb5unK8EuyJwxCbHU3e7szAJAmedP+M4SXSkmE/sfUaNBhHs9mpcPRDc8uWVc
         T67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032973; x=1737637773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snptrSjCp/WTiLu8I8u0XSZwNccoh5U/0syc3p+zW30=;
        b=p0Euc7Nc6IsNaTWt84RY+TOeRsBcPDUJh/meza0FZeClttmfCP9H/SbXI26o5IeMuR
         6rgmq0C3wKdwfAPQoxaW825AG9s5oSL/93MbjKrIcnYIuYMjyZjE4wyzucm+NnmVg+Dj
         fjDwQgrUbF9wxla4Zn2udSsk1PcAcLlBMAj8xfigJwJIOPQj0zYSIfKq2ZBA2OR9RKOy
         jw8np/xSwnuBxbDLFuibSDz3S3rrPmIQzXy3P/DT3zHXI3P1w06VLQgG1s/BI8lv4wlz
         VuLp45JlJV95KT3N6lnzlOAvGagIprtIAGYdk1J+fhIxF1xFy80NIUGQmCY05Xap6+xj
         qTuA==
X-Forwarded-Encrypted: i=1; AJvYcCU9PWIjZSsmY7mIEQoIR/dFZs3bPSL3HctKbN0VdxjEr5jMoHWvSD7KhSrtz7qTFO8szI2GY1XH@vger.kernel.org, AJvYcCVbzGaaQ2DnDxrt7LIUDshmfw3CjHh9WIRdT5xHlPoZ5CUhEjEHyktNFSJkG9xoiLycEO6Pl6VCmwts/9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIGhaZtf28RzrEolJ/otxGcO5b4V61Tm8zvFMQeDxlxtXxRWT
	0Y/BHfilvDAmDBKwMy2of6mbDagZkAAL8QYrX0JtTgxV2trmxoGO
X-Gm-Gg: ASbGnculxLQpvkd1fvb0m+cQLam5LkXCQJTuH7c5ARzeXND+4QWFyVntCJTO2RX2KCw
	7GEiC/eCC3G/fzWUZG9yzlMM6Qq1byBATV7xvyUA/R5BDJPXaCFygO8QfJkvvBHYHyCeyDvDzfs
	8n6slx5tElmq491Nde06L0cYxiHFZfsr6CyfH1u6FwV5TpR4Z5bXWvSMj00dWhUsNhsU5egs0pA
	BAc7wUyMLXDe6PNblSGv2pbO0iR+Iazm/krgQbCwSntIHLw+BGqHbm9UV7q
X-Google-Smtp-Source: AGHT+IFwvxoH6j5w/7H364LI1PDnz4GWvdvRTrSBQCw/AugbZy6zJhUICULr6Udxk4KcvLdJYHGJmw==
X-Received: by 2002:a17:902:ea0a:b0:216:6769:9ee7 with SMTP id d9443c01a7336-21a83ffbab5mr535838205ad.41.1737032972572;
        Thu, 16 Jan 2025 05:09:32 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d0d7sm98728015ad.163.2025.01.16.05.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:09:32 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Date: Thu, 16 Jan 2025 18:39:20 +0530
Message-Id: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the TODO in fec_enet_txq_submit_tso() error path to properly
release buffer descriptors that were allocated during a failed TSO
operation. This prevents descriptor leaks when TSO operations fail
partway through.

The cleanup iterates from the starting descriptor to where the error
occurred, resetting the status and buffer address fields of each
descriptor.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b2daed55bf6c..eff065010c9e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -913,7 +913,18 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	return 0;
 
 err_release:
-	/* TODO: Release all used data descriptors for TSO */
+	/* Release all used data descriptors for TSO */
+	struct bufdesc *tmp_bdp = txq->bd.cur;
+
+	while (tmp_bdp != bdp) {
+		tmp_bdp->cbd_sc = 0;
+		tmp_bdp->cbd_bufaddr = 0;
+		tmp_bdp->cbd_datlen = 0;
+		tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
+	}
+
+	dev_kfree_skb_any(skb);
+
 	return ret;
 }
 
-- 
2.34.1


