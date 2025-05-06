Return-Path: <netdev+bounces-188392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3BAACA48
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54D91C289B0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF989283FF6;
	Tue,  6 May 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0QnW8/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1F283FEF
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547202; cv=none; b=RZqMqKWM5agtHi0wm67x54WTD5EcyxVEk5m3dVY8lAIpS9nxZ1p+Zv36Dlaah+Yrni+HU2mCuigeSLXMBj3fynjz0dLQbymKfvmwUj111oynRDdd6MFYH0BJbDLm0xi1HwixT0W6+oliXqi1qUycY9bhaN3ow7iKLprMfBNcxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547202; c=relaxed/simple;
	bh=fw96i4io7OwICzxznieEe/yvLohHLfyXY8J+bjNXxeA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTl8c2VMas/RIXeiYTrWVm/px2eVWZpHbnT6cZ7x6TCu+kk+QgKwa5A261qYY+xaNtoKZTU/xz7uUmqg60vPqSLoeNl+o/pmV4gksXZcy0mNZXWdV/oH9/AMJsHc7vb5uPBtE4AwQioUNorp12+BynY2F3nL6Bu4vBBPVwARsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0QnW8/U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227a8cdd241so72590325ad.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547200; x=1747152000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o5aoRtMdY6j71HDPUu45kW87U7JGDHG5yFlTsUAHS2I=;
        b=j0QnW8/Uo2x0k2gfEzyqyL7237Ayop3PwYQq6ldRt6t193lZXTr2o4Shmz4ZMGeeQ/
         J9iPhpvTlEuU78Fr7IH693dc2i8UN+w0l0yoeFN0Yvp9G5HeNBPb2ZfoJjU3K/qusztU
         Yht/EvOa3UaeXmS+VF9iKkzHtPDZDeC4R5RQVTRb6WcLcTBwvNEr4H/u0WLRIVU1/jdo
         T7ni7rpzUGvG19xOnHdk+pPb+Yp+NXXlyxPfW3/aWiq26C7l/WRnTXmzZxQve/MRTcH7
         Mswulz5GnMlbyiGpMzXGty/asTMzBtBrD2UjspnLFpxJMERvxtI1jhW0cXnhtU1/W+4N
         ApeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547200; x=1747152000;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5aoRtMdY6j71HDPUu45kW87U7JGDHG5yFlTsUAHS2I=;
        b=ZIeFAzVJZoeRIr69lv1GAiOwqPiB4YxPGu83Z/JDgg+04cB8o0+GiiEw0AVCkv4SnU
         gOS2NlqWmio5JATg99RhBQpRrxxtWK+q6qc5wh91xLWONyZLBURVVat06X8YbiYDqe99
         2tr8y9t47tKGZbhEjxmBk0QcLwxXGbpaRp1ezue+KWV9gtfZpcTbffruyXfmvfl1rTgK
         LPPg2K60lwkApTvfnAVGDklagA9JLC889qZEAB/6gqYsYGbAwIiLOLNtquZhahifk0sd
         M0ictRm6jcr7ZoLUimp36Y1T8V7cYpfJuEuMLRgp53wnB0kBHXl9obpUbNmI5IpJpivM
         n3+Q==
X-Gm-Message-State: AOJu0Yzy7faFtL1AGvsmtHUOQnFr7u2pJaq4gx4V/YyNBFkrDfQMr8QG
	apqkw3EcVtiNG1YDcXl+yHVqoe+vTxH3ATJ6sou1ouAdzn3oPPzH
X-Gm-Gg: ASbGncuTk8KBeP/wPCeHykEfIFCONQAHNvuDU+ajut9xgX9TvwIco/jLpSpHNFB7gZ5
	6tpINBNf9HGa0bg6SGcN7XXsyBEZimE2ksvdXdU9lKSsVKHkVvuaeNGLSK06goKd+6GjvzBKqgP
	q72iinRDH74W/40LXR8+tA0Pu7+piWoCm6DK4JfUfFczQZexgzyZ4JRsd71DDLvVGqpgRLOx0yr
	Ng5uov8D55esdPMqPDG9ENL2e09kY5EohdP2sKSuqzI8Vj+tEnSyCJrpazOjbIjnwUCnvKlrvS5
	wzk5uKFu59JH2BFavs9q7EHvUpQtlHGphyNOXSBVh1Sxr5ME3sj6IVxDv98fBNe3wqmm2s9BiAg
	=
X-Google-Smtp-Source: AGHT+IHu1bKS/3zvvosTPYZhgBxRDJ+L+Xd3rFzdtNRKWMnNHBkzyLF/A7/IEW+Rbml2A78crvMNIA==
X-Received: by 2002:a17:902:fc8e:b0:224:7a4:b2a with SMTP id d9443c01a7336-22e35fa48e2mr47920595ad.11.1746547200575;
        Tue, 06 May 2025 09:00:00 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228cf4sm75580135ad.176.2025.05.06.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:00:00 -0700 (PDT)
Subject: [net PATCH v2 4/8] fbnic: Actually flush_tx instead of stalling out
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 08:59:59 -0700
Message-ID: 
 <174654719929.499179.16406653096197423749.stgit@ahduyck-xeon-server.home.arpa>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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



