Return-Path: <netdev+bounces-52274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279447FE1C5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC2281D12
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2E6168F;
	Wed, 29 Nov 2023 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVKQ8Mix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391C10C4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:26:24 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso247744b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293183; x=1701897983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sCyYkRoGgiDRrKxcp8ji3Yt467zSBtV+G7Y08/1tlE=;
        b=dVKQ8MixDcLZ2oSabxC+7x6RrFJL047Gu8zum68hWW+AzR+BD2+QpqUDXLj1t1lzi+
         6nO4NRw2Uimzsl6KnyJue0QEKfJPTgWIhPXeGwgBWpjm1ccBT3edLWDkMjq/63+t8A4c
         Mfb2WNVDVoHz+YiVDdMjKxStJxLMVQFTl7B5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293183; x=1701897983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sCyYkRoGgiDRrKxcp8ji3Yt467zSBtV+G7Y08/1tlE=;
        b=OaCTW0wfG2XoE2Ztm2wEgfbeHbMA539FbkZqAzk9zIx05Mq0hH8GLoDs8CyACx81Kw
         fyNjNC14JS0wWhIc6oS8leecPbsK8euCVGt4ULTL/fm7x9c+vxK6Wg366R+chssLkRgv
         6PhtLDdEWTZAG4MncDHZzrQdifzpTz69gmhTdRFe9mvqUymCJ7RN/xHJKT+jB4E6uEs4
         v30OuRCjgPvQ+398PzXMQpUe6o9wb3SdVH/ItykkojawY35iLT4G/NBncfkRmHHQBP03
         BUB1vgK5U2ukGPX0zBWkQMq+Og2meEkwBKRsF2Lr+Cf0Iaaj/+LytnjDoQB97RWyofGa
         3nJA==
X-Gm-Message-State: AOJu0Yz9+szWEN+6XKTe6gnea9yD09XScUTkvtCYkUNi5IQ0jNsfVT1x
	NBOu2Sr1Bb/0wOQfY8/gEr7DJQ==
X-Google-Smtp-Source: AGHT+IHuJr/thflyNs5KBDR3MnZ/ZjMRWa/3xsno1k1cW6LIH0sssFnjJRvfIj02P0P07giWDmy72Q==
X-Received: by 2002:a05:6a20:3d0b:b0:18c:90f9:5084 with SMTP id y11-20020a056a203d0b00b0018c90f95084mr14166441pzi.27.1701293183515;
        Wed, 29 Nov 2023 13:26:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:dcf:15e4:5f50:e692])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm11816336pga.70.2023.11.29.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:26:23 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	Edward Hill <ecgh@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Simon Horman <horms@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v3 2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Date: Wed, 29 Nov 2023 13:25:21 -0800
Message-ID: <20231129132521.net.v3.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
the driver. There are still a few more that keep tripping the driver
up in error cases and make things take longer than they should. Add
those in.

All the loops that are part of this commit existed in some form or
another since the r8152 driver was first introduced, though
RTL8152_INACCESSIBLE was known as RTL8152_UNPLUG before commit
715f67f33af4 ("r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE")

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use `break` when we see RTL8152_INACCESSIBLE, not `return`.

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d6edf0254599..e9955701f455 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
 
 		for (i = 0; i < 1000; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				break;
 			if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) & CR_RST))
 				break;
 			usleep_range(100, 400);
@@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if ((ocp_data & FIFO_EMPTY) == FIFO_EMPTY)
 			break;
@@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
 	}
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0) & TCR0_TX_EMPTY)
 			break;
 		usleep_range(1000, 2000);
@@ -5499,6 +5505,8 @@ static void wait_oob_link_list_ready(struct r8152 *tp)
 	int i;
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if (ocp_data & LINK_LIST_READY)
 			break;
-- 
2.43.0.rc1.413.gea7ed67945-goog


