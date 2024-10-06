Return-Path: <netdev+bounces-132458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494B991C20
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295D028154A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8BE17C9A0;
	Sun,  6 Oct 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRKBgVuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECC17BECC;
	Sun,  6 Oct 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181748; cv=none; b=JPFX/rpWf8SvdiTOFis1eommtpzR72V7ZTNzwKHhT2OqiU8GtPQuh8/Z/1TqVbfdEvj3nNdS5o80I0eDbTU3LxZtNpcyMwbEb6dsC/0lqMcR5Qn2Ywi7NqS0pgTVjecC8jp7PM+dAqIGFiQVIXoo/Yp7K4Jrz0bpych4fovcces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181748; c=relaxed/simple;
	bh=3znYEdrKrSJmBz47ry+O584EposhcMqI2RWTfyP9gqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZzq8NdGiutoDUx9I8cuPTtjQBCTtY1znLOXgQtodOSGX8RnqXI0mQaQd7tKJX3s3KdfwZ4eT7Yt/2jB+YvEkMAhMYsc5nsdlUPxenVq+ocWTHLWGv9SuZeqIP/r5rg7x0n03/XK+d7C7g/IT4/GfZ8l42xMcIqPiqL5WX0pFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRKBgVuT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7179069d029so2540873b3a.2;
        Sat, 05 Oct 2024 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181746; x=1728786546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i5ri64hrjVdmz3tZTzX5i7c0GV7hJBF3q4OdGMq8f8=;
        b=bRKBgVuTnRdlpgrsJ45AyCP9ZAqjGtSEmo73t7X0Z75sILxBd1nmTfG8FEslAFBZIs
         kSVywBhvWnc8ruTq3u1QOtByDkD7xBr/4nTSiESlQysj4lDju4r1F4PKEqBLLF009/Dj
         UjPykaViApdyHRL/JbpbqNflL2yjrUAEdmPJh/bEjGqbkpfAX3XjM1tqJMMu8dsDKIJM
         6nFA8fz5npekQyeTqyW0XfBuyFbuQE1WvGZrhYcHKOjriJTK0v+WnI09nSLH8G8v25HG
         JJbkLBSinTa2IVrYOzLVwZpjiVyerCSUY2fcBLSmPHdlP8vAipYoz/cgHYA+JT4dNC2g
         51hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181746; x=1728786546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4i5ri64hrjVdmz3tZTzX5i7c0GV7hJBF3q4OdGMq8f8=;
        b=BHz6W/JfE5v8j9u8xX/VXrep9mNobuXSzfjxyjVEQ2cEJl9CbBeTbV9BW8OwdDBleE
         Mg73433RNlTWvc/p+CYlODoV52gFltuY8OBz9U3yOaBsRtaDoWNO8Cwx3/seEKAUfXjT
         uyxTwu/BCZ90+JotDa6RxJKkGMT8NBS7OL/MyZd8HgBmsPoIBDnPIMuAxJW0N/GBU9+o
         vNag7/wXbXQ6Yne7mxC8hoH8QlT2zMkVLGAyZTmrLTbqkFQGNxq1BJTheP5tAZeYAX2K
         bkshtxsLzKB8prCzjSySnKEB/5P+fx+12DeEBSC5LbluBZ0VR+NOPDFLCSBxGoAKroON
         iBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXSYD/tYevHyowj4C09qYmkNirvXeLOtVj5Z9qbIwdDL/RDYzEK2Y1+3LOZPpz8dpRBdc9qf4mOeZLEI+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQ6YkmuCT+cC6hYF+asn5FOnqLP+7Np/ME+JXHPa70cCVjAzk
	lgIWCI6sM5qMsBbwhPhCPSs9bAmpj2KUGcHBlwB6Jca30eGr6Aa36nrHLA==
X-Google-Smtp-Source: AGHT+IFzm88Fa94rK6hTif0Vk6/kRiFoep8XMF9N5/+XAueLMSgYWskYCtoPaNxR/tfr9rjeTXx5zQ==
X-Received: by 2002:a05:6a21:2d8a:b0:1d4:becc:6ef1 with SMTP id adf61e73a8af0-1d6dfac9a42mr11214247637.31.1728181745928;
        Sat, 05 Oct 2024 19:29:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:29:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 13/14] net: ibm: emac: mal: add dcr_unmap to _remove
Date: Sat,  5 Oct 2024 19:28:43 -0700
Message-ID: <20241006022844.1041039-14-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's done in probe so it should be done here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 3fae1f0ec020..4f58a38f4b32 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -714,6 +714,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	free_netdev(mal->dummy_dev);
 
+	dcr_unmap(mal->dcr_host, 0x100);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 				  (NUM_TX_BUFF * mal->num_tx_chans +
-- 
2.46.2


