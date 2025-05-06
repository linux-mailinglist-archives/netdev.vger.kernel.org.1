Return-Path: <netdev+bounces-188396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF0AACA53
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AB03B7055
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F128466C;
	Tue,  6 May 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7/faSBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD3284695
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547223; cv=none; b=kDyOKp4S3f7eKkGeC4NbNtyXZ8DSKv9u8BiNAnYQcyOgFtFeWAQY9fDijYkQNBpesskO1dBUiLKko3XtvKAGSUDEiNd1/zzUlHWg2OBWKjDhTYAutJjthvmybwqZ1xaHrx4+dbbEYcvnIU2VYVC/ZN/PGbAGA05nN7dLy3WrKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547223; c=relaxed/simple;
	bh=jpLNYXMPobSI6JqEU0T9RlA6cuUFXQHYyLMkobNsoVY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2CJBuxdYhsq8cBliw2HRmKFH6XuMmT/rCRs4pWRYxR7lgqNn1wYarGgYFgjITHQ5nPHOxlPmxv6/025xsIcfL/CqZwwNd/+C+pW8EOjLvFW+1DN2vHkw6jkO5JVUpL2Aya9zjB22fm+McHiciQrg0Q67Hm7jCtjcsfgxG+jzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7/faSBr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so8291773b3a.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547220; x=1747152020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HTFdgwrvcUmaAv0D7tyYnAQNuP6oW1vnmSxslnbhHaY=;
        b=e7/faSBrNSSvNkNG5JMT7OiwRY9zzjCjERZMPO6/A6CescPrjFGBCrOuv+oaXC2b4N
         zuFCAAAQO3v6Y+q1qazksOT6fYSiS2Forpjt+HfSXzJ5kduMR5Uwl977knNof/n5GyLB
         A32C5AJEEFzomCYX3VxwPW2EIeq9edUXZBC+AjUOTFHShVUDLzOuBRucPCexvVy5BOkJ
         oiSa+nc/qPKQwp61qigGycs44Ajds3BNBTIVsGk7vCydwRmjCmzK2/c43aQpdmlJxos/
         v1B7wxPSM33NuQ5ttAaYg//N5AgwAaST3OYAy9m/UDxjkGqgVPNV8UmmRD+lnbNt+msb
         eMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547220; x=1747152020;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTFdgwrvcUmaAv0D7tyYnAQNuP6oW1vnmSxslnbhHaY=;
        b=nrpIIizi5oUFUy3053tFjR4sb6Shz78foWILYPc2MgkkZG9l+SM5JTJqWi6jstkSif
         n2Hm0EsJNoN8WjPHrIPstXBPK4pYY9QYN9Gy7ykiPiCIru5aySPWcCt81NkRJufWTRqV
         fXo74VVgytTNnJXAdAYY3d7WKDEQv8AzM201A5BYNCQx1RDNHglSXRmrwxLEvw/CSWDa
         f7Qm1zJogI4u7g/gwnKRtiYEDFixMij/P7xgnop4PSbbb8J8SlAXOtxi0QshrTJatBcK
         3+7nMrbs2iGaV/APqO8p71IwQfNjBs5jy83XvERzzdE9XmZzPVj/9qwsxFcmkA1b4jDj
         /RHw==
X-Gm-Message-State: AOJu0YzE53sxYcm1zzcguSqBYVkipVxa/5116ykgCFOuWomzGoO1Zr8U
	IgYZ/gX4Adc9Hd5uEWVFSfXYTWMZ7IlkVM/Uyhn/ygOIyCqyhotB7R3kIw==
X-Gm-Gg: ASbGncu+PQq9Yiv1njYOUedvhOzTfLDKO+cDOUayCpa9fJosArL2uCqrKeXqtkTPiB8
	U40qcdYU6OC0p02i67pdgMTzWr3VgZiqRDD5eUzyK+NOwSOvf0VQwa0yD+W/wwp0Aa0cG1lslkm
	do0RnJo1YrvWvcPJ5iCuhD1m5eS5lrMNM4ZW6FPdX0jCmeCd3h9XHrrsAJpVk78A1/8sptcxKXS
	QEbLS8B6sMFOJlPPh07hiJJyrk7hkI6WAAHvotgkR59Ty1UCvXiUljP+rEtgTY6IRPCoT5cpwsq
	/MaPx8iPLH15CWov9It7NMiCYX5vVZ+5nbierpHd7me3IMQpJl8CTxHDcJgqvrjMRGvO+KhDpRE
	=
X-Google-Smtp-Source: AGHT+IHzuWuCMbeDyMqHNgTvd1UVWaqZFZyMGsofd9bER9wLyQzpdJKPBvOd/73tsYYegHXGHCHHXg==
X-Received: by 2002:a05:6a00:2b4c:b0:740:6fa3:e429 with SMTP id d2e1a72fcca58-7406fa3ea17mr11576935b3a.11.1746547220006;
        Tue, 06 May 2025 09:00:20 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dd4sm9097708b3a.117.2025.05.06.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:00:19 -0700 (PDT)
Subject: [net PATCH v2 7/8] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 09:00:18 -0700
Message-ID: 
 <174654721876.499179.9839651602256668493.stgit@ahduyck-xeon-server.home.arpa>
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

This change pulls the call to fbnic_fw_xmit_cap_msg out of
fbnic_mbx_init_desc_ring and instead places it in the polling function for
getting the Tx ready. Doing that we can avoid the potential issue with an
interrupt coming in later from the firmware that causes it to get fired in
interrupt context.

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   43 ++++++++++------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d344b454f28b..90a45c701543 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -352,24 +352,6 @@ static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
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
@@ -393,15 +375,6 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
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
@@ -907,6 +880,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
 	unsigned long timeout = jiffies + 10 * HZ + 1;
 	struct fbnic_fw_mbx *tx_mbx;
+	int err;
 
 	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 	while (!tx_mbx->ready) {
@@ -928,7 +902,22 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 		fbnic_mbx_poll(fbd);
 	}
 
+	/* Request an update from the firmware. This should overwrite
+	 * mgmt.version once we get the actual version from the firmware
+	 * in the capabilities request message.
+	 */
+	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
+	if (err)
+		goto clean_mbx;
+
+	/* Use "1" to indicate we entered the state waiting for a response */
+	fbd->fw_cap.running.mgmt.version = 1;
+
 	return 0;
+clean_mbx:
+	/* Cleanup Rx buffers and disable mailbox */
+	fbnic_mbx_clean(fbd);
+	return err;
 }
 
 static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)



