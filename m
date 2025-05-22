Return-Path: <netdev+bounces-192707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F07AC0DDA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA993B9898
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74841AAC;
	Thu, 22 May 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="LnVdY6fd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411951EA84
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923318; cv=none; b=B4lyv0WOg8HiqQDEs/0x/XFt1MtBQX6R83mZsTu3hF5BD6bunyC/TMi6kKFJWnHEdwR2UYvkxK6CF2gmBggjQF9RyUbwstEx7kXPn3Kefhn6Qcn1qTJNrEFaUL+WYVFEDxE+T4ZHueREIEF2Bvy7IqjIKKTi+QvUnQZsnxcrvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923318; c=relaxed/simple;
	bh=FhTEJzH5qJKz5eR8METBHki9ovQ83nVZ3o418Oo4oHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9y0RctD1bUsLVmpI9/1qO0T50K4Yw14APrJtqoDzbjJanVk4QoEOYIVtmtiSM6QfkmO4vnFneyg2EtFR4BSGHAgruVQmqgGaNFJa0McwwaL2/ZOr1yx/6QPMxYex+OxAHL7qpRGxQGv5rbxkeDRJfmtOeHMdD2F03tbnSrL6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=LnVdY6fd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-327ff195303so67274831fa.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1747923314; x=1748528114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0XlOtgFwR1yix19sU10/1UUbW3Q0PrOgfhz3kTtSz8=;
        b=LnVdY6fd6fjSkhtKc4mt/saT17Pakk0H6zHaxRjfu59mOIu2vU6zVLl57zvdDZqQ1f
         YtCmuunBZwT4ig/346J1cDMrXgNwQqvMY8G9onboo+jauFr6oz5wp1PmQC5DpzwOvE6c
         AHl0RNWEfIpo4hTO2DcWyLlUJverPQZXb86dt2TzSOGRiFA7NDp1Hm2g60hYyP/89Cjx
         OjCtlHpg4o3OMl19AQq4+889551LkMYe1ptFAvsoHf7KMmkQH5+AMkvIv8tujiQAfLzA
         6j3RfWnVehzZjIgnVdOStl5JQORITuXNT6LMVizK7FBPepNy1HAS34dKxNe+HJtZthOU
         73xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923314; x=1748528114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0XlOtgFwR1yix19sU10/1UUbW3Q0PrOgfhz3kTtSz8=;
        b=O32olLma5xnjnGLK9bnKeeUP/g3ZHpB5yTmtPk8h1qohj/g1AHGct/ceGd45Up9S7I
         SN70MF9URq9b/VKxUr5XtJyEH5I7d8XF9flOGmSVR4cly7yuYcvu3dFeszWqXFu/yHU9
         XEy0vJxCVNVyukcwKOMBcsF39M7ODrgKrWx3I54ES3UAh706lu6Hh/WB0aH4APDh05tj
         bEfzHxkul4APSO6V2jeEXpLFbscsMWFrLaVu2zdnsnbE8N4Qsrt2FK/A7fjPEXZNd70f
         acSx/Uk5SJERhdWkLz0xOEzIWnKUl0O2hgyBQZxHMBrzKBEfdVmxg4hXIQ7lMMUwXK+j
         y73w==
X-Gm-Message-State: AOJu0YyFHR2kX8XLwc3Ow2ou/kRh/MkwvzOD/57Uzv+a4WMqmm8w0wIZ
	s66DLWxSOHppVR5qT/vo7J6YaO/MEa0Zp4cAUvKjK9MABXEgny943b4cGRILtPi0LNO8nAfav8y
	z4LxYl8Q5
X-Gm-Gg: ASbGncvtuHr8+OK7jpxq7cil/hqjZcWerJBGuo+OLZm1rxgQ9EtIUX4nU09AF9l4x8e
	foe7qC2o4u3uB3SS02KC1q5MVPASczMhcUELKiEXxNJhC8aAEHKTaJX1M16jDljn9Zi2JzpLyWo
	RiC1seT2p0rTQ+LsRMB7tOuABkRGpN6YAZXXA5ilOXUN9l25ge9HTZHq6TWFmYQe3ZuOVy09Tz9
	G6y1si0GBsaugliysX6TikHeXjigaliu20Tc12ZB/upz62i/u+fmJ8+N934UmQUVdCoM4JbKdHe
	CduQsXd761hp/4VKDECGiKo5uS2b65JgB6pY5SFNimSkkgdIKSkGIVzdCvxa2X7r1aQ4
X-Google-Smtp-Source: AGHT+IEfx3DEKVsRaYLAqnGEYC3zbwTGePwrlJ79rRYfXXvPl4V/i878jnloS6LByZKlBMTBFb+BWw==
X-Received: by 2002:a2e:8a9c:0:b0:30c:460f:f56 with SMTP id 38308e7fff4ca-3280772ec9amr75766421fa.20.1747923313812;
        Thu, 22 May 2025 07:15:13 -0700 (PDT)
Received: from localhost.localdomain ([5.8.39.118])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328085ce2f9sm31869931fa.98.2025.05.22.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:15:13 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next] net: lan743x: fix 'channel' index check before writing ptp->extts[]
Date: Thu, 22 May 2025 14:13:57 +0000
Message-Id: <20250522141357.295240-1-aleksei.kodanev@bell-sw.com>
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
This seems correct at first and aligns with the PTP interrupt status
register (PTP_INT_STS) specifications.

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

To avoid a potential out-of-bounds write, let's use the maximum
value actually defined for the timestamp array to ensure valid
access to ptp->extts[channel] within its actual bounds.

Detected using the static analysis tool - Svace.
Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event Input External Timestamp (extts)")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---

Note that PCI11X1X_PTP_IO_MAX_CHANNELS will be unused after this patch.
Could it perhaps be used to define LAN743X_PTP_N_EXTTS to support size 8?

 drivers/net/ethernet/microchip/lan743x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 0be44dcb3393..1ef7978e768b 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1121,7 +1121,7 @@ static long lan743x_ptpci_do_aux_work(struct ptp_clock_info *ptpci)
 							PTP_INT_IO_FE_MASK_) >>
 							PTP_INT_IO_FE_SHIFT_);
 				if (channel >= 0 &&
-				    channel < PCI11X1X_PTP_IO_MAX_CHANNELS) {
+				    channel < LAN743X_PTP_N_EXTTS) {
 					lan743x_ptp_io_event_clock_get(adapter,
 								       true,
 								       channel,
@@ -1154,7 +1154,7 @@ static long lan743x_ptpci_do_aux_work(struct ptp_clock_info *ptpci)
 						       PTP_INT_IO_RE_MASK_) >>
 						       PTP_INT_IO_RE_SHIFT_);
 				if (channel >= 0 &&
-				    channel < PCI11X1X_PTP_IO_MAX_CHANNELS) {
+				    channel < LAN743X_PTP_N_EXTTS) {
 					lan743x_ptp_io_event_clock_get(adapter,
 								       false,
 								       channel,
-- 
2.25.1


