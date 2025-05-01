Return-Path: <netdev+bounces-187339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD04AA6770
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0730D1762CE
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21966264A90;
	Thu,  1 May 2025 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig2O87mx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD263C73
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142221; cv=none; b=sJCdr1zK6AIptp7ZYcW2I8eNfnxcol8uXLdXKPWZbpl6LWVkheFTy8iEP8/X07YImJBEZvziftxHeY2IfmEuA+VWgAZ3UngflBwDt/h3YqpZWWg/WII+nEfnJQwNns6Ky379If6VV//QlUfjx1FyMUa0pIOEy/9ZLSPrS6keRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142221; c=relaxed/simple;
	bh=K14Jya/EGtN2e07y7p89wQ27qIZlcB0KUnaQi8pmHds=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB7QN6Aym33nQAAu3JCoEXej7OOGjT29V4bpvBYhjUm+RuBnljwkV3iipDe6NXEQorZj5DG2n0ffsFk31z2WQSTr5ruQpOFZIQ3YqAnWZu7PVq8W4MJ5bSpnoRC+jW6G6ATxgjpYv9+Ff3QBl7gT4ju4Vfun7BIdhU/ztYee4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig2O87mx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso23937665ad.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142218; x=1746747018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ms66UOh7iH7kPOuDiToqrOZeL+OqWuRptzhQAYtugUM=;
        b=Ig2O87mxCvAb/CrRg/X2BW6rkYij/B1XxwmyG7yHtiPRiIT+/L9heEis6ejfCs6/rX
         LLZOY19y6SGlsbG20EMaCbxst9GuFVaoA25xWZTTrUu8OPh8dZMk+WadFid+AWWXIi7D
         nhOf5+WsKJ+Lf+UYIGLOltlljyADuFM+BN1GVkwUu0kIofW3kn8vDgdda2+TFfdbYF28
         BxUNSC4V08BdqypgcvLhcJBF5df2dolPhcwiZJTJ/6IOsiNzkg73CsMED5Xv4wqkYki0
         D/z4in6JEwivi+INuC7ZwrQkMbKkfw8AEdBycDrxUO9IOkWuGMERjsypR3X2dGhSaat8
         XQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142218; x=1746747018;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms66UOh7iH7kPOuDiToqrOZeL+OqWuRptzhQAYtugUM=;
        b=psjj84JXh8jRmFk5U+5XQ4zFvFjQeQAgsbkuzN7Qi+16iqdiw85y6dn1F6u7pECiOW
         A1x7bAznkWhSdBW59xNaxq7AL9mWPDMQgPOfM9Je7Ybpcpk+hjlK9G2l6hg8ioEiEGnW
         lN4emmhNbE6f2Y86iKfqfvSRGRwq21rALnhylVDChdoUbpCRi7KY0450KTSoruo/aijH
         Vyin3vDIza00rnsFt6fgYFUSMWdD64HEHMR9eYR3EfJQjQIDvVs4swT2nZ8lsM94Im47
         9SW2So0stm1PNI/B5tblt5qnQykkHQfXdIOsRmwPUr+KWziXGyY0LlpRSYRFOXyknCCe
         VhbQ==
X-Gm-Message-State: AOJu0YzZy2KLUhZyrKsuwhHFjDQYB9x94Rcr7F2HPlSMo5UWMscp3VyY
	8C3Xih5u7hGR4FMsCeIYTwKg/u/FYnQDIoDJMV9LpcujLHEXzeEA
X-Gm-Gg: ASbGncvO3XJdbgsz64N1yL0tjKGngTgE4ezmRZuYKCCou0Q9M0Rc1M5/diOX5Ab58c9
	x9IKvhVRQMcTIJOQUHyZSrpWHhPe8/VRgPwV2Klcu4Buc6zimCjZP8TnHAQLBLx/RrGBsc4Hpc1
	aLmFyAuhnehhE2lx3wrQNGZbPcGxb/lppQYsDxx44YBdJ0Iz2Ts57qPB/8o8sxITs8BpFW2mx3a
	BCmM10LaTfFb6OfXn5CNljx8Pltali3zRHONs2MmRkYR4OdzE2x7+Qp7qdWjQlPdWo0kM4q+RfN
	OU4jOzhmEBsPdvRFat8Kub7oE4nRD+jDBypr/RGPsW5I4pQCLEbOs+fMJeFTQKwHhntoz6l4oAU
	=
X-Google-Smtp-Source: AGHT+IFznzl/ZvZingajuyd8iZp0F0JsKNui1LKU2kvRyJd3Y54/NeHsFZNWweWdCekcNBJkNIQvzg==
X-Received: by 2002:a17:903:2f04:b0:224:1781:a947 with SMTP id d9443c01a7336-22e102dc240mr12771455ad.21.1746142217711;
        Thu, 01 May 2025 16:30:17 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fbbbfsm1943025ad.136.2025.05.01.16.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:30:17 -0700 (PDT)
Subject: [net PATCH 4/6] fbnic: Actually flush_tx instead of stalling out
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:30:16 -0700
Message-ID: 
 <174614221649.126317.7015369906157925744.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic_mbx_flush_tx function had a number of issues.

First, we were waiting 200ms for the firmware to process the packets. We
can drop this to 20ms and in almost all cases this should be more than
enough time. So by changing this we can significantly reduce shutdown time.

Second, we were not making sure that the Tx path was actually shut off. As
such we could still have packets added while we were flushing the mailbox.
To prevent that we can now clear the ready flag for the Tx side and it
should stay down since the interrupt is disabled.

Third, we kept re-reading the tail due to the second issue. The tail should
not move after we have started the flush so we can just read it once while
we are holding the mailbox Tx lock. By doing that we are guaranteed that
the value should be consistent.

Fourth, we were keeping a count of descriptors cleaned due to the second
and third issues called out. That count is not a valid reason to be exiting
the cleanup, and with the tail only being read once we shouldn't see any
cases where the tail moves after the disable so the tracking of count can
be dropped.

Fifth, we were using attempts * sleep time to determine how long we would
wait in our polling loop to flush out the Tx. This can be very imprecise.
In order to tighten up the timing we are shifting over to using a jiffies
value of jiffies + 10 * HZ + 1 to determine the jiffies value we should
stop polling at as this should be accurate within once sleep cycle for the
total amount of time spent polling.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   31 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index f4749bfd840c..d019191d6ae9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -930,35 +930,36 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 {
+	unsigned long timeout = jiffies + 10 * HZ + 1;
 	struct fbnic_fw_mbx *tx_mbx;
-	int attempts = 50;
-	u8 count = 0;
-
-	/* Nothing to do if there is no mailbox */
-	if (!fbnic_fw_present(fbd))
-		return;
+	u8 tail;
 
 	/* Record current Rx stats */
 	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 
-	/* Nothing to do if mailbox never got to ready */
-	if (!tx_mbx->ready)
-		return;
+	spin_lock_irq(&fbd->fw_tx_lock);
+
+	/* Clear ready to prevent any further attempts to transmit */
+	tx_mbx->ready = false;
+
+	/* Read tail to determine the last tail state for the ring */
+	tail = tx_mbx->tail;
+
+	spin_unlock_irq(&fbd->fw_tx_lock);
 
 	/* Give firmware time to process packet,
-	 * we will wait up to 10 seconds which is 50 waits of 200ms.
+	 * we will wait up to 10 seconds which is 500 waits of 20ms.
 	 */
 	do {
 		u8 head = tx_mbx->head;
 
-		if (head == tx_mbx->tail)
+		/* Tx ring is empty once head == tail */
+		if (head == tail)
 			break;
 
-		msleep(200);
+		msleep(20);
 		fbnic_mbx_process_tx_msgs(fbd);
-
-		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
-	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
+	} while (time_is_after_jiffies(timeout));
 }
 
 void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,



