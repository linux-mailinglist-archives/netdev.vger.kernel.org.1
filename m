Return-Path: <netdev+bounces-198035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9AADAEC7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976A33AD9D1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57D27E059;
	Mon, 16 Jun 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="r9tvtFS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C9261570
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073913; cv=none; b=dQeQtJddb7Z4C5S1pqQs0Suej+BHa8PudwamF5geH/eLNTLX4XlVaB5zxAbZmABX9j6ZRTOt31i5fgDVGOgQj6S2exghJqhSFzQQE5cnVewICkF4yBKuc4lABFFgR7Nxp+EnlUGppuOCOml5inK1P93acAtACge/9s7a6+sW1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073913; c=relaxed/simple;
	bh=QkoFrlyru+g9n/PbGtj0A9V1wfret8+u5o+LjOwYGUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmoxqN1Ycn14j7ex3lRD9gI0hf1n588avBkK3OAKDFvLPEgSkIeo0Ac2YcNCJfSPh0KtK7wEknPul9IdvHOEZh02LJHShxT0cvnvRic3/yFR5SuFWsgLuh93xl8Kr1bQT/MtSXCVivXcchYxxQV9DBh3+0PeRn5b+o1ePPW24JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=r9tvtFS2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32ae3e94e57so38912871fa.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1750073909; x=1750678709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7zZnAwLI+hKyxt1AxwHgQMzbSPV04vShS9w0c+zcCg=;
        b=r9tvtFS2bi7zgEDkdXNmTIVKdjTdjM+Hfh+WCvGiLKPvjPaI+8MRLqjupkfs69ayAk
         Js1zdvQu3Z5pEFwLrm90lg86mLbVGN5v4IW0rj1Qi6T2ToyqzyhZv4hozvZC+bJx9FaS
         RwUL1d2+4MrEy+EECnOZY7vzEH5Q+vETXYBJfyogzZu3YgvMJ/F99b9HcoyNlgIE8odr
         X5331e3i6HF9x+VyvOoLJFKTyMIGPw2zmoXju9xV02nXtMparYiQSdUOkKz0vkmvcjWM
         ONpL6Gq+AsRLE3kgciSgw9k5qvtd3UzgGdmrm+D2zPj+FLsOTuUktiWrHr8c07rPDiCu
         FBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750073909; x=1750678709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7zZnAwLI+hKyxt1AxwHgQMzbSPV04vShS9w0c+zcCg=;
        b=JvzLaN2q0kvne9h184l90If037EJPMbgpoJICH7O9krPhBIT6LDKJYXc1bFmxYCKE1
         XWtiM76Lkf7D500OzR7mspE7J8l5sXKIDZtlNXpIW3suG/H7bNV/Oe12/8KLZXEy6PZT
         qZPS8rb8soyuAaAfOMLMmFZ7VmQJlVEZ0jyCLl8vMMfx+kIVOuOaRJ9XzDEmL99GTeWM
         oggb4RoNy8jvH2QeLayupACTJfsEj9oeQZ96tM608qxmLPh0E/j18V/gPRpk+pSk9Znm
         0E/ucIDU7BpvapZa+d2+Jfp7/ttD3laTfeF+PHP3+MeeqF2xRTyNJdoFZMX1ux/ZAZnl
         wzAw==
X-Gm-Message-State: AOJu0YyWFTyz26wCB9uKYoPpP4I+Gcl+3SQnrxLuiGHjWCo6TcgSoYwr
	HnLJyZXTRNcsCuOc+TqZDOuOYN0g5Ol+T7Byoh2+wNbERMpz9CFkFu2fxdRTEVXfvD7vEgBwCx2
	yjIdqS5nk
X-Gm-Gg: ASbGncvFW2l/agA3IqtMYXQtQlnZS57Ac3oNRdPkW5pNU5/tPQDfdUfoDb05YdyFC3A
	qGDUvwqfJjAE2p/yzIUNKdi3SHmAf/fyG+YOAxgmaM2MzKOv67L52hFAraBE37qstsk5Eq5cIOL
	AlSp0K5aJAzXJ3nOA8JV3w6AhZzxA255m+cDzW76mF+frafMRLuIM1zZBU/zQ7VDxpPjp59QwM2
	XlqGTvmZuocLf8EWql5tdTBQcyB1Yt7/u8NLTAgSD8lgTgEqzxUM+yEJjYhwP7O3f2ckJ3MzUpS
	hb3QpdeOyz282z6cfSXVdnriauWAVBzN0UGZMCv1HBieR2W7sip6je0dWgGhVMAJ+11VTpQ1Fsy
	I9ZHXnA==
X-Google-Smtp-Source: AGHT+IHsboukhaSQaS5SdpCRwPx3Fj9uCfUgw7Nm1Gw32BmYsHWyKPjuOlERB9sfGnTKxBC7ihx0Hg==
X-Received: by 2002:a05:651c:1423:b0:32b:47be:e1a5 with SMTP id 38308e7fff4ca-32b4a7030d3mr16468111fa.39.1750073908479;
        Mon, 16 Jun 2025 04:38:28 -0700 (PDT)
Received: from localhost.localdomain ([185.119.2.99])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b331ca981sm15012781fa.100.2025.06.16.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:38:28 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Rengarajan.S@microchip.com,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()
Date: Mon, 16 Jun 2025 11:37:43 +0000
Message-Id: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
is checked against the maximum value of PCI11X1X_PTP_IO_MAX_CHANNELS(8).
This seems correct and aligns with the PTP interrupt status register
(PTP_INT_STS) specifications.

However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:

    lan743x_ptp_io_event_clock_get(..., u8 channel,...)
    {
        ...
        /* Update Local timestamp */
        extts = &ptp->extts[channel];
        extts->ts.tv_sec = sec;
        ...
    }

To avoid an out-of-bounds write and utilize all the supported GPIO
inputs, set LAN743X_PTP_N_EXTTS to 8.

Detected using the static analysis tool - Svace.
Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event Input External Timestamp (extts)")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

v2: Increase LAN743X_PTP_N_EXTTS to 8

 drivers/net/ethernet/microchip/lan743x_ptp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index e8d073bfa2ca..f33dc83c5700 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -18,9 +18,9 @@
  */
 #define LAN743X_PTP_N_EVENT_CHAN	2
 #define LAN743X_PTP_N_PEROUT		LAN743X_PTP_N_EVENT_CHAN
-#define LAN743X_PTP_N_EXTTS		4
-#define LAN743X_PTP_N_PPS		0
 #define PCI11X1X_PTP_IO_MAX_CHANNELS	8
+#define LAN743X_PTP_N_EXTTS		PCI11X1X_PTP_IO_MAX_CHANNELS
+#define LAN743X_PTP_N_PPS		0
 #define PTP_CMD_CTL_TIMEOUT_CNT		50
 
 struct lan743x_adapter;
-- 
2.25.1


