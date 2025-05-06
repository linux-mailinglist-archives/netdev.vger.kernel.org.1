Return-Path: <netdev+bounces-188398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEFAACA5C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7963D526255
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D0283FF3;
	Tue,  6 May 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu48fuB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB74284680
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547230; cv=none; b=Vu6VP015rzkPRd00WwTkkosrrzW9I9vsN3JU+vepbun0AmAu7VP7PWt1/C57ZmNo86eNhnR4jJE/sJ3muxyp/a3xD7nZsCsaUVFA6cuw/3B/Om0vzkIxSrKhxS6l0N7ZFZ9gEwVB69ZUjyAcoZ2q739CRH+FKFrqvU0ZNvr5WPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547230; c=relaxed/simple;
	bh=SmUa9MtU+6nDOGQc6r3WPaEIpjFORsT9OBNkLV+2fNM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSYYFXokmJZj18o5KHmJJL+CUpAu+kMm4flMVvvsrtD6oyQ2ackpuLccmoE3p+izsVnFemXj+AsXZeLJXAL+Ret74FlbY59qn/RhrE8AWvPJWVXXc4mt9tqe4+QERBrm9F2ZdAd06R+S5JvSvlhIoqqI+JqtBc7KnlrYTYwL+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu48fuB8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e15aea506so52570935ad.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547228; x=1747152028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NW6Tn6nahsz/hZQDHZ24xS3SM/KlmTN3E3KJkuprw+o=;
        b=Nu48fuB81vdqKfCHCA8R0AswpayUGrinHiH4XCO3LndyQpue4JMzZswlSSq6DS/fve
         EO73iqtcLcf8wYs4et1OgCH/yiqbI93AL4PkdtW1e4GwOAptfXVkoDEZItbDsyLDZfQ9
         /v5O92cbp7qe6zm0HSXp1Xu2MebEROSk4cjpBalTtCOACUBnjP8z6upfx7qfO8BHy05Z
         loDPf1w9ZMFBPLjtDCmsUOxH94sjEw41Fz/4ecSujLTiVzW6SOz3YuIaQLWBWq43UkAZ
         rFG9Syh5ZFDq898E5S8iPDts6m9laWmxwH2GeIe32GJounOScjYefU3GPUsdyh33UD0H
         FIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547228; x=1747152028;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW6Tn6nahsz/hZQDHZ24xS3SM/KlmTN3E3KJkuprw+o=;
        b=qqiNIwH4w3/Cay+FbU5+k6d/odDZNM3ABcZesVeiVKb8c6OODm8wzKjwmUu5+sNVBU
         Itmh64xfvLgQKYIH4pGwIVL/Zm7uwCR2tFooRdLhQ00ZRjjEV2G7fFirWt5ZDiaVKgqr
         m/H9g4qJ74jtWaByFlnOoK6lmwkRKy7sMNcPD6BazMEmphd59SFMARS8A3GwdSpX4ApF
         rEMaw0Ey3/v1lKrRuI6cqbagEXbGg4DdeQOg11v/1PYjO+scUmdsap2/+UrKowRxqnqA
         vJgBK5xiR4pi5QoITshJyhEYAbPmHSVceQqKzHx0N8qmRq25N9L7vHDzDvYIRfFqe5Fe
         g7aQ==
X-Gm-Message-State: AOJu0YxODY43S1C+JfGbf+wcgMniWYNnyPSGf+G95l/1nka7pIVljk5m
	HedUBSoaS4mLb2QcYU0W4d5w2eRFbktNNg8WDr+6sRyRvwKh3M+0
X-Gm-Gg: ASbGncti7eHLziKVqBLWr2VbpeBa0Uax2dIwFo0zuKJWGEBldhMzVOZNcpc7qpEAt4f
	ts2pJDCqYBHmvzlyQJ1vU3dNAAHXHHVLWKHsg/jYg0vunBq6A52NoGgiTtuuu3vEJjC9wbFKqAz
	nm0T5OsuH2V0IVYF0kn9fMJgELSXWQqYS9XNnzWz3a7a38Vh46JyJyvzLjJjWgUu+SXXHn7kkID
	cm3RvmT81cBEhPS2CU/5Jip3gjRbnxAzV9XK79sURx/JrxvGNTE3L6ab0uOKj9eustHwehXi/ow
	84UtJeFy50Ud2saMs2UTiEqYVZHw3J3vQnTIOCC5gjOcfin9/M9s4sqM1M1BuC9phdCXypv+UaF
	F5Q4kEwhRxw==
X-Google-Smtp-Source: AGHT+IHw1Y7Xj+u8JyOmMq0ictFKpkWhlKRIo16o1UV7WIilxj4s67gMK/zjyREHGaJwmFmVmWn6hw==
X-Received: by 2002:a17:902:cf0e:b0:224:23be:c569 with SMTP id d9443c01a7336-22e1ea57354mr190972665ad.22.1746547226708;
        Tue, 06 May 2025 09:00:26 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e459e176csm13599915ad.241.2025.05.06.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:00:26 -0700 (PDT)
Subject: [net PATCH v2 8/8] fbnic: Do not allow mailbox to toggle to ready
 outside fbnic_mbx_poll_tx_ready
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 09:00:25 -0700
Message-ID: 
 <174654722518.499179.11612865740376848478.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

We had originally thought to have the mailbox go to ready in the background
while we were doing other things. One issue with this though is that we
can't disable it by clearing the ready state without also blocking
interrupts or calls to mbx_poll as it will just pop back to life during an
interrupt.

In order to prevent that from happening we can pull the code for toggling
to ready out of the interrupt path and instead place it in the
fbnic_mbx_poll_tx_ready path so that it becomes the only spot where the
Rx/Tx can toggle to the ready state. By doing this we can prevent races
where we disable the DMA and/or free buffers only to have an interrupt fire
and undo what we have done.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 90a45c701543..3d9636a6c968 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -356,10 +356,6 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
-	/* This is a one time init, so just exit if it is completed */
-	if (mbx->ready)
-		return;
-
 	mbx->ready = true;
 
 	switch (mbx_idx) {
@@ -379,21 +375,18 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	}
 }
 
-static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
+static bool fbnic_mbx_event(struct fbnic_dev *fbd)
 {
-	int i;
-
 	/* We only need to do this on the first interrupt following reset.
 	 * this primes the mailbox so that we will have cleared all the
 	 * skip descriptors.
 	 */
 	if (!(rd32(fbd, FBNIC_INTR_STATUS(0)) & (1u << FBNIC_FW_MSIX_ENTRY)))
-		return;
+		return false;
 
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
-	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_init_desc_ring(fbd, i);
+	return true;
 }
 
 /**
@@ -870,7 +863,7 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 
 void fbnic_mbx_poll(struct fbnic_dev *fbd)
 {
-	fbnic_mbx_postinit(fbd);
+	fbnic_mbx_event(fbd);
 
 	fbnic_mbx_process_tx_msgs(fbd);
 	fbnic_mbx_process_rx_msgs(fbd);
@@ -879,11 +872,9 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
 	unsigned long timeout = jiffies + 10 * HZ + 1;
-	struct fbnic_fw_mbx *tx_mbx;
-	int err;
+	int err, i;
 
-	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
-	while (!tx_mbx->ready) {
+	do {
 		if (!time_is_after_jiffies(timeout))
 			return -ETIMEDOUT;
 
@@ -898,9 +889,11 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 			return -ENODEV;
 
 		msleep(20);
+	} while (!fbnic_mbx_event(fbd));
 
-		fbnic_mbx_poll(fbd);
-	}
+	/* FW has shown signs of life. Enable DMA and start Tx/Rx */
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_init_desc_ring(fbd, i);
 
 	/* Request an update from the firmware. This should overwrite
 	 * mgmt.version once we get the actual version from the firmware



