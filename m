Return-Path: <netdev+bounces-81198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE988682A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED81E1C22515
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A168883D;
	Fri, 22 Mar 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mJOEjCOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C80171BA
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095999; cv=none; b=IIwoiuHf4O+mtsMaQKAwU5HGNxtcEhU1e7vsj+/v8dwG+OoN0QaJfoWa1BrH894usHv6chEfDJTH0pX6w9o6C2lHaKmk6OIHG6aFc0pStlvppLtuRNepwFR/L0Yv6uOFDsxKb/6qYZKlW3Tt95dU91rUhXHzqm1s2lssb0kYCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095999; c=relaxed/simple;
	bh=opm2Mncft6nh6R/0AL3mFs6rJscuUqlTfRpEiXtm2fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgIw8qk2/ETbvS9v+/NAAtC1LECeNpieE4PP6m7/jVmB3vrnnS+xTBxX3O4JjBTwy2gt3BUyGVFtuGvfYhFs7jxZh/5cUarfItlvF5Y+2HZTB7xtxnz+i+zU9Gblai7Dp9HRK7eeA7l1ps2p30C8tj4Qbjw7Le1AcJrkpnXyFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mJOEjCOa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 70A314081C
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711095995;
	bh=xigLUBpUl7CqhZLv7Xx0VhnrrGoF7BXXSH3+Lf/M2hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=mJOEjCOaTFo7MLJ24hqD8g7hTdMYtAc0MIvVwy4WWsO/SJuLvDh/GuOT6J34tqh06
	 BkT8/JOCMNRwAwCTPP2ky7UhZBsDc/T4tfWw8vi5cm9Fst4i3QA03LAMIjFGv8vVKi
	 1Fj3pgvRQkiOBULkj+ONiUTuk3P7RlJicViJ9FDD1D3Aq6bXLKsr6be+I13FCZTu9e
	 MAoP8TDkpCd1ZiVCOdUFH69NJzCsB6eKp89lmY0QzC0mUrkt3kj28HRNsrj0lvzQ7Y
	 jWUVD9nF75WRmowvR+bvTYYcTv8gj1j5ZAO+600hWu1IfGYDW/G6XFjRsRRcDVKijo
	 wxMa2o0+nQZTg==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dc1548ac56so989097a12.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095994; x=1711700794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xigLUBpUl7CqhZLv7Xx0VhnrrGoF7BXXSH3+Lf/M2hs=;
        b=ZjeRoGf2TxGflbXhSYYKNuENc0y8PfQff/ukegJODSxr7DNa8HGVnFa41EtYw4rz47
         +Wtxw/C0aq1OIQZnGFtl3uWbokf7Uzmxi7jXuiWJqDnkANi//Ej8eDQfpgmZR5gbsCW5
         b7+/RqX6yAGYVLq0UfYaWlkt9WOBVTWtx6bBfWsa45Xc7VxsMKG5CMx9Ap6iKpFX0tix
         sdRF+Sag+keCDBpE/GyLlnfYv9sFLNG5XckGKsoX/07H2J3qgTXLaxaRCFdQUeWIJqt2
         WGyV1EGjLmTKE+/5PXAV4FiWouh4vC6nfIzG1mhqft/cur5Uezxnfh68B18V254eDL3q
         nstA==
X-Forwarded-Encrypted: i=1; AJvYcCVdXAYjgLjm6WiY59kQmldLV9mC/VWYWpva4ftlDFZaM3tH2OFdOG5HCMqjWd51K0tRIYdls4RASr52MLVgH/FjDHmLFpli
X-Gm-Message-State: AOJu0YzHvLGR0PTofBuRn+lDXeYLiic19+GQx64PSAJdyLzDxyXnnVDR
	+mJjJHvjBnwLjXjljUJBiWj4+zryBVuldVoEO8Gmafm/pQIU5dZR4tDIuS8fY3rTUY6JIBOycL3
	aNSeqVhhjzVecgl7fTpmEBraNhBR9PKJjTajIfcCe1/PBQTf3nreAGzhslpTjeQbL5ACTRg==
X-Received: by 2002:a17:903:2783:b0:1e0:2335:8f68 with SMTP id jw3-20020a170903278300b001e023358f68mr1732789plb.26.1711095993762;
        Fri, 22 Mar 2024 01:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8FZYsbjLIPlfQJz36gEAjwD2GOSdhgq+JPlHG6nMaiEJacC0FClWcOLRudF1FlcebAOpxg==
X-Received: by 2002:a17:903:2783:b0:1e0:2335:8f68 with SMTP id jw3-20020a170903278300b001e023358f68mr1732774plb.26.1711095993373;
        Fri, 22 Mar 2024 01:26:33 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id kk13-20020a170903070d00b001dddeb10d83sm1294492plb.223.2024.03.22.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:26:33 -0700 (PDT)
From: pseudoc <atlas.yu@canonical.com>
To: hkallweit1@gmail.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: [PATCH v2] r8169: skip DASH fw status checks when DASH is disabled
Date: Fri, 22 Mar 2024 16:26:28 +0800
Message-Id: <20240322082628.46272-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <Zf0-cXhouMkgebDR@nanopsycho>
References: <Zf0-cXhouMkgebDR@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On devices that support DASH, the current code in the "rtl_loop_wait" function
raises false alarms when DASH is disabled. This occurs because the function
attempts to wait for the DASH firmware to be ready, even though it's not
relevant in this case.

r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
r8169 0000:0c:00.0 eth0: DASH disabled
...
r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).

This patch modifies the driver start/stop functions to skip checking the DASH
firmware status when DASH is explicitly disabled. This prevents unnecessary
delays and false alarms.

The patch has been tested on several ThinkStation P8/PX workstations.

Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
Signed-off-by: pseudoc <atlas.yu@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c86d7..a39520a3f41d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 static void rtl8168dp_driver_start(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
+	if (!tp->dash_enabled)
+		return;
 	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
@@ -1324,6 +1326,8 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
+	if (!tp->dash_enabled)
+		return;
 	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
@@ -1338,6 +1342,8 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
 static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
+	if (!tp->dash_enabled)
+		return;
 	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
@@ -1346,6 +1352,8 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
 	rtl8168ep_stop_cmac(tp);
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
+	if (!tp->dash_enabled)
+		return;
 	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
 }
 
-- 
2.40.1


