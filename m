Return-Path: <netdev+bounces-48789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172667EF940
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C551C20AA3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA446452;
	Fri, 17 Nov 2023 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIyHVlKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CF21BF2
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:09:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c320a821c4so2240987b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700255399; x=1700860199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL5piRnOOgGpwdkxQbi83S5rjEjfPe4DjTzZgACvY58=;
        b=EIyHVlKiSNhvyjB29Mm9SC2Cksbkw8cRh8ped9kyLt/tn60jK6yxzAb2qdMZtQdb1G
         51IIH5TP0BVhDyAqHpBM6rPpMeXP3vUF8fDSc1FaRS9BnrfWDm95Rvvqu9qbD7y3X/+o
         hKacmxm77F7aStYWW/MvaHgM6GYgYNZbIt2Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255399; x=1700860199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL5piRnOOgGpwdkxQbi83S5rjEjfPe4DjTzZgACvY58=;
        b=tXCsBom71GkUFuYwnwcOTyIq9id4drVr8KDerBmoyR25tdXtriHIEVOwZawBCfq1A+
         +jIbHwKHAKhwdpYPvi0IzlGIIOESuM2IgfCX2rBRt9SW1j+Szty/HrWsjWpJZBQOWMBZ
         9NAudF31f0gH/nOWLPSq16M2GTR/szuI8CaTuewazHsNVk85HT5Vr8fUz5J+/rx7vcDj
         UizRnHZueiBOKmWw3wzCT6bGvHwckXwM0vQMAgaKGbDDuqvvCkCiXpooUAB0WxMKpRDZ
         DUvaUDLKNYkd5ATvz7t8DFaFQx3O8EvG1nuSY2n8mmbv9xDt57SbDUvH65IB/OuRqhjg
         pPRg==
X-Gm-Message-State: AOJu0YxEfh/T1FZub+YcYr3CGo7TcBYxadYIFJz6UCQJSW+0thTwNk4a
	eiYIaNZOdNDVTFcSdaBSb+cd4A==
X-Google-Smtp-Source: AGHT+IGHWMC8lpH06rvyXJMANK059TL4Qd9yND7/duFlglKPEMZcUlex5YYsClh3kZ/YlBoNHES+4A==
X-Received: by 2002:a05:6a20:bea5:b0:187:652d:95b5 with SMTP id gf37-20020a056a20bea500b00187652d95b5mr289192pzb.62.1700255398792;
        Fri, 17 Nov 2023 13:09:58 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b953:95f4:4240:7018])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00219400b006c624e8e7e8sm1780587pfi.83.2023.11.17.13.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:09:58 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Grant Grundler <grundler@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Edward Hill <ecgh@chromium.org>,
	linux-usb@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Date: Fri, 17 Nov 2023 13:08:42 -0800
Message-ID: <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d6edf0254599..aca7dd7b4090 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
 
 		for (i = 0; i < 1000; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) & CR_RST))
 				break;
 			usleep_range(100, 400);
@@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if ((ocp_data & FIFO_EMPTY) == FIFO_EMPTY)
 			break;
@@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
 	}
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0) & TCR0_TX_EMPTY)
 			break;
 		usleep_range(1000, 2000);
@@ -5499,6 +5505,8 @@ static void wait_oob_link_list_ready(struct r8152 *tp)
 	int i;
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if (ocp_data & LINK_LIST_READY)
 			break;
@@ -5513,6 +5521,8 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 		int i;
 
 		for (i = 0; i < 100; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			if (ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL) & GPHY_PATCH_DONE)
 				break;
 			usleep_range(1000, 2000);
@@ -5635,6 +5645,8 @@ static int r8153_pre_firmware_1(struct r8152 *tp)
 	for (i = 0; i < 104; i++) {
 		u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_WDT1_CTRL);
 
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 		if (!(ocp_data & WTD1_EN))
 			break;
 		usleep_range(1000, 2000);
@@ -5791,6 +5803,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
-- 
2.43.0.rc0.421.g78406f8d94-goog


