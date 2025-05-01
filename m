Return-Path: <netdev+bounces-187341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FDAA6776
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C9C7A8A6B
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212622690C4;
	Thu,  1 May 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfC/0Eut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B200192B96
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142234; cv=none; b=mkC4Iy2xQ+FzHpZDEP705CH5q0QDfjUB/TTxThaCBCs4HCQk5bXCv1VFIAkd92ZDL3C0mPavF7GcLvO8FARmguQGyNGf4hZ/wnVENEpddQuS/N9J9PqhBGGHRe6XZ/3ht+r16ZI2yCw7B5RElFpd0ynB5FtA5Gs1DvH95oI6iFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142234; c=relaxed/simple;
	bh=A2tv6JzpO+VCqktJgnfUFRBwVLLl6vKVBpxzhwDq7co=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZl/aSq7x+y4lG8KQhU9sS3SdvTk1Uz+nzg94RUCMCUcABB0xiN6tx6HZSvje24XZf2tVf1uoa00Z0oGTw8ZXYREVGDQCYAb3n0PaVfASiBUuAN0sbYXWdJPo40urSsHHGLHfVOT8B6ZDaVVNeoU5qgQnM/ldC4XszXzaXjuQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfC/0Eut; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-aee773df955so2362462a12.1
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142231; x=1746747031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZLHif9hpYvIrr6W9YXm4Jwo8OqNRbEZgA8q7d7CJc8=;
        b=NfC/0EutVre4Nhzu3L/ajNuAzIJkIP6iIuVmS36RBomMgsLjCEjCNEHfb75Hp/jCoF
         BtD3ZghQw+RFXzcmgnA4pcb/FCbcUXfilOu5MIYUeNAucFAEZ5l0t44N3/oCoMAKrCbb
         ih46RpJAtdwq3nxpUDB5NiktktXW3ky0VaL9YmoEho3QN2kr3mt6lUJ+vFHISfrogjao
         odvkEfeSkO52/vWzo34DroRxmqJuX5WVtOhqHtrBSYKmhuwVauNYhtBEt9BHpePaHlbz
         hKkSCSzAQ5qcNHA1wfqUY0OA1LL4jYomqLYEcJjzRRGoil/WWSJ39RgRD253sBcsBKUi
         6Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142231; x=1746747031;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZLHif9hpYvIrr6W9YXm4Jwo8OqNRbEZgA8q7d7CJc8=;
        b=rKlPAL+aH29cuinmFCQwK2FH8S+s5CVGhrkq7ZkWMa4YGpKcRNkGRmoGmZzXN9jvEJ
         PajmwtMvue6z/iVIpyyKufMNkL9q15fwjJVEP5MdwpJFFcBq/kkrJZocGrxAM5SCGSg6
         sHVHKpDlUkbSsJoBlWi5Mxv5k/BU9amYa8ToaFtdo/D4nEzOEdNiLEWifo0v1SQWQU0I
         Yfr2TVnWBCXjHT9tjKfYWMFAq7JUxbyXb/q0fpFaoZzhcTxkxwowPYTpm89tuDfx5+e9
         a4sGH7VergxcOz495emyf9iiVesAy6BoVfJCVO+jqGmXH1DlWUz0vVcX83QNEdXJp8w5
         hy0Q==
X-Gm-Message-State: AOJu0YylPylxZX9fncRVz/1GSG8Nr3vHKg+4yQLY9qJvTH/PC1YET5EZ
	XnYdQS9csD3DQIu9CNUSpR2SKznLZ3ovslE8F8ZUblkCPA5FBGU5
X-Gm-Gg: ASbGnctXuJz6Vk9g6R9TqSCsUDRKX42t2NWBpA90uu4XlACLsLYhTy9rocovBrSJIQY
	zaDHuFINBYjd2z3kluT/4q/vZRZcMMa2dUC65C2eExBZXa4EOhoQ2doJFLks644J8xejB7yEIOB
	RfigaQSZ60ugmQ6gf+me/QhCtjdIUtD/BwUtpjWf0bVYcD3Axw+IKGCouMueeYdoI1C4l0AMAAX
	+Gjbm4xbMkOm3hkj+2XAaGSjXlKn+tJN4lT1RToFGKVETbrTuOPiEcGojhZDejSgWcom4XArEJu
	N5VuRe52RgYyZjmARAqM0QX0mXlIoA6A5pyS1Wp/lfXueJb/Iew53g1jDs6JcfpZ6dI0OkZVFTU
	=
X-Google-Smtp-Source: AGHT+IEj21/zSNqaFpDFqEFxPikdfyDf6HOHUE4lkUUji96eDiykEDQzwGsOH+pMiB2zPRB4c2eKtA==
X-Received: by 2002:a17:903:3d07:b0:21f:2e:4e4e with SMTP id d9443c01a7336-22e1001e505mr15137765ad.5.1746142231509;
        Thu, 01 May 2025 16:30:31 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094060dsm1934245ad.250.2025.05.01.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:30:31 -0700 (PDT)
Subject: [net PATCH 6/6] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:30:30 -0700
Message-ID: 
 <174614223013.126317.7840111449576616512.stgit@ahduyck-xeon-server.home.arpa>
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

This change pulls the call to fbnic_fw_xmit_cap_msg out of
fbnic_mbx_init_desc_ring and instead places it in the polling function for
getting the Tx ready. Doing that we can avoid the potential issue with an
interrupt coming in later from the firmware that causes it to get fired in
interrupt context.

In addition we can add additional verification to the poll_tx_ready
function to make sure that the mailbox is actually ready by verifying that
it has populated the capabilities from the firmware. This is important as
the link config relies on this and we were currently delaying this until
the open call was made which would force the capbabilities message to be
processed then. This resolves potential issues with the link state being
inconsistent between the netdev being registered and the open call being
made.

Lastly we can make the overall mailbox poll-to-ready more
reliable/responsive by reducing the overall sleep time and using a jiffies
based timeout method instead of relying on X number of sleeps/"attempts".

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   98 +++++++++++++++-------------
 1 file changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index efc0176f1a9a..0452ea573d4a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -95,6 +95,9 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 	/* Initialize lock to protect Tx ring */
 	spin_lock_init(&fbd->fw_tx_lock);
 
+	/* Reset FW Capabilities */
+	memset(&fbd->fw_cap, 0, sizeof(fbd->fw_cap));
+
 	/* Reinitialize mailbox memory */
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
 		memset(&fbd->mbx[i], 0, sizeof(struct fbnic_fw_mbx));
@@ -352,32 +355,10 @@ static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
 	return err;
 }
 
-/**
- * fbnic_fw_xmit_cap_msg - Allocate and populate a FW capabilities message
- * @fbd: FBNIC device structure
- *
- * Return: NULL on failure to allocate, error pointer on error, or pointer
- * to new TLV test message.
- *
- * Sends a single TLV header indicating the host wants the firmware to
- * confirm the capabilities and version.
- **/
-static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
-{
-	int err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
-
-	/* Return 0 if we are not calling this on ASIC */
-	return (err == -EOPNOTSUPP) ? 0 : err;
-}
-
 static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
-	/* This is a one time init, so just exit if it is completed */
-	if (mbx->ready)
-		return;
-
 	mbx->ready = true;
 
 	switch (mbx_idx) {
@@ -393,34 +374,22 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 		/* Enable DMA reads from the device */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
 		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
-
-		/* Force version to 1 if we successfully requested an update
-		 * from the firmware. This should be overwritten once we get
-		 * the actual version from the firmware in the capabilities
-		 * request message.
-		 */
-		if (!fbnic_fw_xmit_cap_msg(fbd) &&
-		    !fbd->fw_cap.running.mgmt.version)
-			fbd->fw_cap.running.mgmt.version = 1;
 		break;
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
@@ -897,7 +866,7 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 
 void fbnic_mbx_poll(struct fbnic_dev *fbd)
 {
-	fbnic_mbx_postinit(fbd);
+	fbnic_mbx_event(fbd);
 
 	fbnic_mbx_process_tx_msgs(fbd);
 	fbnic_mbx_process_rx_msgs(fbd);
@@ -905,27 +874,62 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
-	struct fbnic_fw_mbx *tx_mbx;
-	int attempts = 50;
+	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+	unsigned long timeout = jiffies + 10 * HZ + 1;
+	int err, i;
 
-	/* Immediate fail if BAR4 isn't there */
-	if (!fbnic_fw_present(fbd))
-		return -ENODEV;
+	do {
+		if (!time_is_after_jiffies(timeout))
+			return -ETIMEDOUT;
 
-	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
-	while (!tx_mbx->ready && --attempts) {
 		/* Force the firmware to trigger an interrupt response to
 		 * avoid the mailbox getting stuck closed if the interrupt
 		 * is reset.
 		 */
 		fbnic_mbx_reset_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
 
-		msleep(200);
+		/* Immediate fail if BAR4 went away */
+		if (!fbnic_fw_present(fbd))
+			return -ENODEV;
+
+		msleep(20);
+	} while (!fbnic_mbx_event(fbd));
+
+	/* FW has shown signs of life. Enable DMA and start Tx/Rx */
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_init_desc_ring(fbd, i);
 
+	/* Request an update from the firmware. This should overwrite
+	 * mgmt.version once we get the actual version from the firmware
+	 * in the capabilities request message.
+	 */
+	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
+	if (err)
+		goto clean_mbx;
+
+	/* Poll until we get a current management firmware version, use "1"
+	 * to indicate we entered the polling state waiting for a response
+	 */
+	for (fbd->fw_cap.running.mgmt.version = 1;
+	     fbd->fw_cap.running.mgmt.version < MIN_FW_VERSION_CODE;) {
+		if (!tx_mbx->ready)
+			err = -ENODEV;
+		if (err)
+			goto clean_mbx;
+
+		msleep(20);
 		fbnic_mbx_poll(fbd);
+
+		/* set err, but wait till mgmt.version check to report it */
+		if (!time_is_after_jiffies(timeout))
+			err = -ETIMEDOUT;
 	}
 
-	return attempts ? 0 : -ETIMEDOUT;
+	return 0;
+clean_mbx:
+	/* Cleanup Rx buffers and disable mailbox */
+	fbnic_mbx_clean(fbd);
+	return err;
 }
 
 static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)



