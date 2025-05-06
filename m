Return-Path: <netdev+bounces-188395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C081FAACA51
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8A53B2691
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8BE284663;
	Tue,  6 May 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjlty4XY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2442853E9
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547215; cv=none; b=cqJjBIRf+eAgrFiOs8ZaV+0rSdSiPPKPjrqKx0dhtkKUDI0F2+URT7SyycaJukHSsZCr3xsPZHIsAluKcqXIRlshvuvoTrjMCVEzeokQsFKbTT6aUQGF9HP1UvtHpYWwc13wgNIyJASSqExPC7x1hJgI3oPNpRXCChs+erpXAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547215; c=relaxed/simple;
	bh=LyNwkIDQ3FP3x4oTM0KdTogiB9bba2a812giZuvokN4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0tvFla45VmKWod0rgvVDcV8mVHnxwje97LTsVYRB4WLrmJO7c4/In4jPK4lUykTW1oBSpuu0RCagY2b9uAfeakIWwial4MLKbxnSlrEHNOB3y/PkiGAsiD1EYTp2u+f2cTMr9nKr20ekKG9ZpEcDKIkYO8MhNpjCdbn0RgobrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjlty4XY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227a8cdd241so72595115ad.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547213; x=1747152013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pYtc1HXtRbkrUnnGizhejzSAHPNpem228sPC163njKY=;
        b=Qjlty4XY4PijRl5FIeg4GH0j0LSHcon8W03PhmuOHgZMmd0YLgvqXTXU+y5ts1EDdP
         eESMfZ/kCXbdpb7W7hupxgG/C6t/1wv8Y+4fMZ1gOShfKttKBvkhotKovYjxg63X8ADZ
         ZpKQRWeqQoxbKWYTgbsrFtDHIRlWmMclll/gybKGEFEdCIib6MsS36trJMaac/faksE1
         L9AgIpYkmndtAsh+IWr6c0cqv9rXZfYrzlMI+9QB2g52yynI9UEF6Km+96CFyZ6gFk1n
         MYy4A+4uttfV+3nnNhQ+pNew0F6jZpbNYDahJQi+LrtI4IwYSv5Y+Ws44YwWayQx6R+Z
         OGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547213; x=1747152013;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYtc1HXtRbkrUnnGizhejzSAHPNpem228sPC163njKY=;
        b=ioJr6J7Ui14YCG3c6+CNvSyI487zTOsUkKCsUASct/MpizVnCjIZipn2db7xi+MPFe
         qO5lYEqZEnNd7c2MTkpJebxSw012BCoWMbqp68XCypTu1dsPkNa0PjhVT8F8z2d0N61e
         YBgREaXbor8btSfBuhDdEu9p1aBEzNqUTXzbTS1XAxzHQOnMIsLswubGOJxj3+qE7inM
         tyZkrvEP4NdteMxGkaarRCkIHySPIHJUB8N6X7vGWKNJGXwIArhHJpke3oddgTiPVKQ5
         a0fO44XudbrGXTd50ywTa+vzl+j5pFsEIoEQTYldjDHP1luvrs5BxoHB2dG+RPZEUGnp
         obVw==
X-Gm-Message-State: AOJu0Yzp1mPkqELtGtamclJQFXmvZ0VnesAzApn2jwM/AbPKBWr0hNFx
	FP3JsV/H2ppK3s3jfkABPnfSfEEIUp3mgDfsEWrWLmPcJ7vB/2Mr
X-Gm-Gg: ASbGncu3ID65rThF/osp75oU3ahygjFjl9aHDfxGfY0iTH8wqrZ9xeW9ta8VKwXWEpf
	07IJOVL3sLLYxBaDLBzTpCMj1O50WD9J8RQe5kXMzXrhKswAlHctmBU2QNxmEBjKMU6kGo9DQHa
	uXJ8zxWLogK0yMrD+srPIkR3kFaYDsUlBGXzpy+9sLwMe807XjRF/8la//3bgVt1l248trzIWMs
	GZ4zt9N4DE8WnvloOtxM8suQ2pc3Yh24n0mkn3H8dd9E8El1c+nkD2Y0Q/DbV3+U+5wHdW5zg6n
	E78e+k/SGeyTyJQyLjV95VnCk6715ioa5HIXZR+mf52kVWMEXgSwrRaPXVRsHbQ/Sp+oh/LBYN0
	=
X-Google-Smtp-Source: AGHT+IHh/zcSV/64RxRrp1Q0fn4OaMke0RMjmrbiCuqawPLjA+c00MMtr7s4J5NrV518Azp81MrOnw==
X-Received: by 2002:a17:902:fc8e:b0:224:7a4:b2a with SMTP id d9443c01a7336-22e35fa48e2mr47930985ad.11.1746547213514;
        Tue, 06 May 2025 09:00:13 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522a7e0sm75160415ad.208.2025.05.06.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:00:13 -0700 (PDT)
Subject: [net PATCH v2 6/8] fbnic: Improve responsiveness of
 fbnic_mbx_poll_tx_ready
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 09:00:12 -0700
Message-ID: 
 <174654721224.499179.2698616208976624755.stgit@ahduyck-xeon-server.home.arpa>
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

There were a couple different issues found in fbnic_mbx_poll_tx_ready.
Among them were the fact that we were sleeping much longer than we actually
needed to as the actual FW could respond in under 20ms. The other issue was
that we would just keep polling the mailbox even if the device itself had
gone away.

To address the responsiveness issues we can decrease the sleeps to 20ms and
use a jiffies based timeout value rather than just counting the number of
times we slept and then polled.

To address the hardware going away we can move the check for the firmware
BAR being present from where it was and place it inside the loop after the
mailbox descriptor ring is initialized and before we sleep so that we just
abort and return an error if the device went away during initialization.

With these two changes we see a significant improvement in boot times for
the driver.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 732875aae46c..d344b454f28b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -905,27 +905,30 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
+	unsigned long timeout = jiffies + 10 * HZ + 1;
 	struct fbnic_fw_mbx *tx_mbx;
-	int attempts = 50;
-
-	/* Immediate fail if BAR4 isn't there */
-	if (!fbnic_fw_present(fbd))
-		return -ENODEV;
 
 	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
-	while (!tx_mbx->ready && --attempts) {
+	while (!tx_mbx->ready) {
+		if (!time_is_after_jiffies(timeout))
+			return -ETIMEDOUT;
+
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
 
 		fbnic_mbx_poll(fbd);
 	}
 
-	return attempts ? 0 : -ETIMEDOUT;
+	return 0;
 }
 
 static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)



