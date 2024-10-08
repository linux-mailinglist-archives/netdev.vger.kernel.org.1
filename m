Return-Path: <netdev+bounces-133011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CB9943F7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196ED1F23269
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9F1422A8;
	Tue,  8 Oct 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkIhiFEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4B13CF9C;
	Tue,  8 Oct 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379105; cv=none; b=i2eRs6NERZnrOSE7s3RxpNDiCHS10Ao75/FlwWzQ1FX0lD+FVfgrLd1yg3opx5RqC1pYZpqWjBKJG/FOaKQu4Dpby4oVd4GofBuHDMhTJIlUBFQnxJT3fYzlSN9/SginAXvkAeHrVHK42IsRVt9uIoDJjc/Tbxl7j1rVv8OIdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379105; c=relaxed/simple;
	bh=FFSmJTrZxaEZsrKRSxDrHHmajd43IHsne926dkQZNkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fl27qajBGVaVyT8f7Z8pDvhAvxGEyI0qYU8EVDDqDHeW0+MOq2E3pkEBdXJrXsKnEfHY1H5BZ1LeEP5Ureocl83eB+2zU5XVpzdbkRYNTS8ph+X4DIwrFOhSfDCUWUvuluZsE+ZXC1hMj/3VWRvrYWSTR6ihDT26YcfFxtUmVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkIhiFEK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bcae5e482so46855195ad.0;
        Tue, 08 Oct 2024 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728379103; x=1728983903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JseytBMAk+BNjewRYeAnqHl6La7Hn+BdxweOiGs0iCY=;
        b=XkIhiFEKogito5SOTlXVmsHe7Q8llnbq45hKz95nlXBOld+/lyQts66tyj7Z1LuRJN
         0K9W6gzeLijCRIvsME1f/o81udMelE7amc4FxOvf1wmR2UeQUYAhDrPE7ijnmgw8d9Yi
         mUfa4oNQkvp+LJK9OpZYwQzoaCarv0tJ98sC3sXahIs/o+5f7laEg6gPVHhbzAK4a57Y
         nwue8QyGnfOL2Mh8O5NQdFuxgt3CzUTAKwnALrOURHmS0mA5poBLVYuwzmuIEbraXENN
         YWJADmDkdF3Ti2Z4UPHCZbvcQb6qrayUqjQkxPSiVuqUJz/Uq8Hgx0o3XIgNPC5no+H3
         Tv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728379103; x=1728983903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JseytBMAk+BNjewRYeAnqHl6La7Hn+BdxweOiGs0iCY=;
        b=iGV1XBzi6BI40EfuvIPEU8TJWSoX+JMmPS/uHLuo7Jvdmv/5TCjJI7oXdbgtpPw2Bp
         rk1ll6IIKcDxs32Dw8lxb8hj8lezMTIa2QKPtowIUdu8Z52Xm8LosXcj0JQ1r2lWgnFQ
         R/+35m17y3qq0hyIjy1iB3iC3rfvt9IdXKw5hniKrFtC7adV2XxxOpNdf37o1dN1rBLv
         kpw9e0BbNyTmfGWw8lDfQwl0d/A2PS6VFKUEW/7CfjMuLTVSTvP8ZRUYK8HR8dpMGse8
         D0S3DiHq0w3zye0jtX1x0iXdXBptpe+yQ+FpaxMJbDO3hrDjiiEDcd5Yk3sReTDT3QDk
         SQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXHCIN65/ft5WoWQNz9w46k8ffAHO2WNURwH7m72ZoNaiDFWEZBSDveu+drkZwFH1p2emJ7pVjQ@vger.kernel.org, AJvYcCXOqZwDaR2/k75iL/8yig5QMlE6PqtpSajxNMIvfsMovYXFBoDwt7NlvlTGaAXEp+SvGq11wlG+Rm/tPG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyquMcaq/eDPWnwH4ViNYyY69mTP5WVNgR1/F01QJZ1mCHCiuNw
	cARVDi9/KMV7RNZ3qnAXBePC1zjyYbqp4c8jpyB+WZFGEc0+RAda
X-Google-Smtp-Source: AGHT+IE/oXI7NUbn5NTYL9lnG38C8HcbWMOd+C/QzMixlWkvnUW3Vu0lc6mgjUwPecfTcDmcnwjs7w==
X-Received: by 2002:a17:902:ccc6:b0:20b:9088:6541 with SMTP id d9443c01a7336-20bff1eac22mr250910495ad.55.1728379103165;
        Tue, 08 Oct 2024 02:18:23 -0700 (PDT)
Received: from localhost.localdomain ([220.194.45.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d068bsm52309285ad.96.2024.10.08.02.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:18:22 -0700 (PDT)
From: dillon.minfei@gmail.com
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	csokas.bence@prolan.hu
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v1] net: ethernet: fix NULL pointer dereference at fec_ptp_save_state()
Date: Tue,  8 Oct 2024 17:18:16 +0800
Message-Id: <20241008091817.977999-1-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dillon Min <dillon.minfei@gmail.com>

fec_ptp_init() called at probe stage when 'bufdesc_ex' is true.
so, need add 'bufdesc_ex' check before call fec_ptp_save_state(),
else 'tmreg_lock' will not be init by spin_lock_init().

run into kernel panic:
[    5.735628] Hardware name: Freescale MXS (Device Tree)
[    5.740816] Call trace:
[    5.740853]  unwind_backtrace from show_stack+0x10/0x14
[    5.748788]  show_stack from dump_stack_lvl+0x44/0x60
[    5.753970]  dump_stack_lvl from register_lock_class+0x80c/0x888
[    5.760098]  register_lock_class from __lock_acquire+0x94/0x2b84
[    5.766213]  __lock_acquire from lock_acquire+0xe0/0x2e0
[    5.771630]  lock_acquire from _raw_spin_lock_irqsave+0x5c/0x78
[    5.777666]  _raw_spin_lock_irqsave from fec_ptp_save_state+0x14/0x68
[    5.784226]  fec_ptp_save_state from fec_restart+0x2c/0x778
[    5.789910]  fec_restart from fec_probe+0xc68/0x15e0
[    5.794977]  fec_probe from platform_probe+0x58/0xb0
[    5.800059]  platform_probe from really_probe+0xc4/0x2cc
[    5.805473]  really_probe from __driver_probe_device+0x84/0x19c
[    5.811482]  __driver_probe_device from driver_probe_device+0x30/0x110
[    5.818103]  driver_probe_device from __driver_attach+0x94/0x18c
[    5.824200]  __driver_attach from bus_for_each_dev+0x70/0xc4
[    5.829979]  bus_for_each_dev from bus_add_driver+0xc4/0x1ec
[    5.835762]  bus_add_driver from driver_register+0x7c/0x114
[    5.841444]  driver_register from do_one_initcall+0x4c/0x224
[    5.847205]  do_one_initcall from kernel_init_freeable+0x198/0x224
[    5.853502]  kernel_init_freeable from kernel_init+0x10/0x108
[    5.859370]  kernel_init from ret_from_fork+0x14/0x38
[    5.864524] Exception stack(0xc4819fb0 to 0xc4819ff8)
[    5.869650] 9fa0:                                     00000000 00000000 00000000 00000000
[    5.877901] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.886148] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.892838] 8<--- cut here ---
[    5.895948] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read

Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 60fb54231ead..1b55047c0237 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
-	fec_ptp_save_state(fep);
+	if (fep->bufdesc_ex)
+		fec_ptp_save_state(fep);
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1340,7 +1341,8 @@ fec_stop(struct net_device *ndev)
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
-	fec_ptp_save_state(fep);
+	if (fep->bufdesc_ex)
+		fec_ptp_save_state(fep);
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-- 
2.25.1


