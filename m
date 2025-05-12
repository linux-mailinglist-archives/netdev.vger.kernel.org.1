Return-Path: <netdev+bounces-189781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB2AB3AC0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD14E1888DE3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E692185B8;
	Mon, 12 May 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="jAsPt2ph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2051DE8A6
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060509; cv=none; b=fKfWdW0x+wNyxBsjKUBvA8RAJnO2eSon/ZkJjWhI2HF3BvPzXPjSLDHTEFBrKwElVn7ENdYKDQXACTBOdZnYTyniQwrJfEuywdD07j1XdxdfLXPVG5ugGK01m5mAHYiyxZkt3g9oCN1hP2TU/cf4TzvyKNvbwAO+bh1Zu+6ZnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060509; c=relaxed/simple;
	bh=Of7ka9hMXGo16Owrab9b8hlZNOg2CKSZZ/6dxQLWwYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0g//fDrwnaD63pEtdRA2e9Dl6Uicyv1+S13FfJNMsrkIbv55pleU0R3n3b6pAN9syfmlkOaSf4kADoPuuHM4WdYvuDcm+J6TVFOOnXCdDmbfqifjTcuF3/NbGRjCM6gMHLReE0V/4GVVK8tyh+cOa50QttjwvWI229M1lSpENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=jAsPt2ph; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-707d3c12574so36531517b3.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1747060506; x=1747665306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R97yIxV0uT7GwLkeFinXJPFtVVZBVzQD6JSs+qYgRtA=;
        b=jAsPt2phxoTxOivw5vKCveJitapS7PQPH01Zz+6TZuU5l5nxdYkK8dGPFJhFr8yQ94
         ATdanrN9+oW8qg3gaS4ShKsE+7dD4evQLzDWu2jmANRSd65qHp9M2TMPLJdfXf6YaIj7
         UwgZY/1H+AzqbaeNiDPToY7CcIgQ8uDSKEnN5ikYL4cd5QRMo6D2DNWULwYyBLsl5+Bx
         rt7Hdo06cxBaQEoN3WcRnysASsmexPmpOI/jYjuMHQl3m84t7l9Bcbkp/cGXNgPjawuf
         D22u+bi7WGPHNpPCw9xLxjEyrkBUV9Ct8mYGPPPIdvmu5H5C+GEn6TZBTrNrHzCS5RBg
         AXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060506; x=1747665306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R97yIxV0uT7GwLkeFinXJPFtVVZBVzQD6JSs+qYgRtA=;
        b=Yd5Mv5G3LRw4wk1UGKDGXno3FwgKOuwJZflMJJbiMZujAtFlZ94YK4VfX30iRd3ry9
         LlXR4u6tHnh1r8poSgtEnkcjbP52B1gmXdM8GrisEHB0kWusF8Av9nughSksdqhenCLx
         zfX+flMo1SMYW8synbnW9pUlBzfaETC6YvTO0obQbgCVi6TE4lmvvwGzJm5l65CPP1qL
         0paY4/e+Soo0PsSv0YZ5QkNUwavInI+VXZ/gyLuahamEInqtpQ6SrEANNnM149V3vJgB
         X8FgQxDyHO4WMJd2b2dDl45n3MJkJqPKuLx5ejiF+AGgFWxYueFQpFNVYuvdxYKcwPmg
         9DfA==
X-Gm-Message-State: AOJu0YwluhGlRB6U0y4aLLrUeJ5Gzv5w2C7drKx5wpqta/He5+T3n0oC
	FSeFO+77mVhLSd4iTz7bHk+PDU9RpJSL4qZW+zJQPNZmQRTcfRLpiCdkVUMTW2hrOBbh0vVYa+Q
	=
X-Gm-Gg: ASbGnctNwOrAZ4tqp84EjClj76DvogoKh+lCfJazebdBZnuYlWkAFlsuFjiEtFmKkqI
	eB7M8rsrqLFqqjuBwttLpE5Ty8zv98tQ5uMtLLSMO0PE8BtvbY/gl/qiiUZylywzi27RISBCq+F
	k3hRpji+3kDwebMrtZ7FkVD5ip+sxla6aN6hguwA9rVBI0oQIfZCPu2FeRGmbUkLoMzf5e1xSKH
	AAzKfJ/d4GO2qVyiOZZaZBmehGohsaxcGdDl4y02dI1wehPed/Mky7YA+FXFHGVAYSib0IkZ8on
	eJsWjWrDHU40J3VCELliPjYh+WNjbCXSilTUArStbmhUvsDCfO+iGA5r1HmIW4kUy2dumtA=
X-Google-Smtp-Source: AGHT+IGE2LN1p7qpCZfamnkZ0PsFnvtQNvYY7UOf7e0PlcjYwjwD4fqs4hNHekAP0v3CdFC1Gp1jRw==
X-Received: by 2002:a05:690c:6a86:b0:706:afbf:50cc with SMTP id 00721157ae682-70a3fe87c32mr174422477b3.11.1747060505874;
        Mon, 12 May 2025 07:35:05 -0700 (PDT)
Received: from localhost.localdomain ([185.119.2.99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d8da29dsm19655157b3.54.2025.05.12.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:35:05 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Yan-Hsuan Chuang <yhchuang@realtek.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH] wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
Date: Mon, 12 May 2025 14:33:37 +0000
Message-Id: <20250512143337.54199-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the size to 6 instead of 2, since 'para' array is passed to
'rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1])', which reads
5 bytes:

void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
{
    ...
    SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
    SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
    ...
    SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));

Detected using the static analysis tool - Svace.
Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index c929db1e53ca..347807801270 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -309,7 +309,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	u8 para[2] = {0};
+	u8 para[6] = {0};
 	u8 times;
 	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
-- 
2.25.1


