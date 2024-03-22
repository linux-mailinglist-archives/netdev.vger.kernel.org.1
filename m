Return-Path: <netdev+bounces-81163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053138865A0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 04:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52167285B49
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F24C85;
	Fri, 22 Mar 2024 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OdagzdBO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734254C69
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711079195; cv=none; b=tGFIBXUR2eSXLIif+ATNyFVdCFNjqTxh8/iDyn9hdr+mTkDpZ17RNXX5vfdwQ35gkbEFUN6Yx+DDYDSFZB1I9vlGeY3wOZnds7BIJYWgnlHZW/dcPuVCMEjGXJvNj5Th/XBQl7NHL+W5lfXhKw+7Kgq5S1KywdMxi9k+aj0RMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711079195; c=relaxed/simple;
	bh=D6D/YKZ8lKq/qeOybZAxvi72UomleCDBG0qGgLxt8Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1h8MTHpCDA4quvW7WnhXpav5FG9E7AKP18ykvM7SvQZgYsOPfjp6a5/bBPEroKISTuROnNeykYQKM3OIH+ux6WS7R+wKPFpAoEzwodJQvaEg38zuUXNP0oPtNbtWx5X+zy2sQzfO7IFnnZcIkmkrTpGkjXaTj5V4U6UPmH15oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OdagzdBO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE43D3FB77
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 03:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711079190;
	bh=MQfEt7Rz7pbKpQIJ+8SGxblA/e8Ap1fIm20A7zLn/BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=OdagzdBODHdzmwNhbumMywkDLrAEmEQ4ITa/pSDPYEUs3BYqk5lpoOY5v/KPGta52
	 MZi8iGkwJuxH5YgmHAcy4TiBLbNafR9BD6NbzCluXAaAYm54Fafl6g3KjrYs+4OH93
	 pb9y+gpSNuS4eHx2azNbsR8IrsFbrRoeonBnwBdtCc2GprryqVygJxwnB/aQ8LXafC
	 fTETHExRvrcloUiEylzNKRXKi2VPegqyXDKJKhYLzSjKGXLCQmHDlL3JXFghaY25lV
	 7OIWYOe8kO5jllN4p7cSfVr0inDjZ9mfU1aOz8G2tI/0eNMw2JQ4vejTIafYn2Ba7Y
	 qPeLkH8a14qlw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e004445facso13017725ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 20:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711079189; x=1711683989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQfEt7Rz7pbKpQIJ+8SGxblA/e8Ap1fIm20A7zLn/BE=;
        b=eZri5pw/Pgab/F2uocX9VtKdQh1aJuC+atSrAHZq1+7+awlgPc+ACDZxJGgCUJe8fT
         0rpvNSim5aKDqaHeMSjZhpHGnt2R8ll0QjMCMUppRwM8Oz/hVlU6eD9ZbA7TvOLDoq3L
         P8EnoYTj1pnz5S8DFWrSriqd1kgQSrnMj+bWYpqHf1dc3J3VYuJIP8OerT/XWSwiEx3G
         uTKX4W7QMjN7VtVQGZN6GcnlGP8tUI4Cy+5ZfS7TZhbe3yvkTsmDq/PNqzW0PT84EL9M
         aGihWgYwEHYi6oxBJxCyChnGM9ZR+heaxViAKWAyZMZYh9PHk/MYUAzBcs5w/lshrnyS
         GTrA==
X-Gm-Message-State: AOJu0YwVRR3NDzowrFsou3wQnV4I8GIoOh8QU53cIwMRvRBhyqlpCVti
	Tku6idBw+XwUZmtjAV27/0wnPaw/j7qIK+asGsonKMx1C+gnIoZNHYrYJ7URcvCMi98ULqS5XxF
	lDmGu5wwtBwSSsr/VxA5KAoTvRYWF0se1O3e5ZweujzZMaFCLRsaas+qUkgyVToCjjX4o5g==
X-Received: by 2002:a17:902:e751:b0:1dd:8ed:997d with SMTP id p17-20020a170902e75100b001dd08ed997dmr1426434plf.3.1711079188895;
        Thu, 21 Mar 2024 20:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH0S1MLI89w1NgCkuEeoXUqqB/11iMjBq8l33GpGgKfIxr40RAVSlys93bkZfsCDqIarfItQ==
X-Received: by 2002:a17:902:e751:b0:1dd:8ed:997d with SMTP id p17-20020a170902e75100b001dd08ed997dmr1426424plf.3.1711079188580;
        Thu, 21 Mar 2024 20:46:28 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c02c])
        by smtp.gmail.com with UTF8SMTPSA id lw8-20020a1709032ac800b001dccaafe249sm693352plb.220.2024.03.21.20.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 20:46:28 -0700 (PDT)
From: pseudoc <atlas.yu@canonical.com>
To: nic_swsd@realtek.com,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH] r8169: skip DASH fw status checks when DASH is disabled
Date: Fri, 22 Mar 2024 11:46:17 +0800
Message-Id: <20240322034617.23742-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
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


