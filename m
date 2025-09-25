Return-Path: <netdev+bounces-226516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3DBA1642
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA11C01A3E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AB31BC9E;
	Thu, 25 Sep 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt5DGaZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018223B63E
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832973; cv=none; b=Cpw+2RKUlqiwgr0pJtRXJNqyHDledfj0qQXqRvL/yH5sfQxy2oAwHuMdYF95d4UmTuobBX99MLqd3I+oph4doa465gpyXV/mARgUXF/UrMUmYHee5YjP4GyKPvIvjeGq55ZELe78r/4+wrbgBETYR+foHACzR7EsO5O1S4SWy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832973; c=relaxed/simple;
	bh=8V7qNMYmqmW763GV+RmYh7nchonJ2A54SiLgvLE3h+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsC2ztI8UI2lp1emdw4ixHZP6WLpZrSTBY9aznseWImaOEH4hnvq2XFy93aFLVuvGC2Z6p0j2IqaRQ2SpSGsOC/c95xJGCb0sVIBZWdt9VY8mW1SS1oFUHhfxRsa8uFppyRG290ppPv1r1PivC1FlhrKk8QjqL1oEm+Vr0L6VjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt5DGaZX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1379514b3a.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832972; x=1759437772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=Qt5DGaZX1F6BcVfbDeh2pgYWbxoiB66CixaTCMS1X0qJgFJ7sv9zF4P8YUbusrCkZn
         Thv1155lhm8WMqcY00/IfaUF7KErMHYwTifVuAz8O9tf4gH1zTuY4Tncl7SydHFU5nmb
         QjreD15UthJ+EsSSTEndTu8Zobpn+8R7n2ho37j6TjAp7Zu+Stwkdp71DX1ZKA8ZFzJM
         52d/eKyXP7MWiCg2/fcq0bS2XsD0NmQBxyE5chwrvlPLretPVq67UxFAtBnvAcaSSD9z
         8q1jcnFPhpdBP8V1JMqmbmeVGu59A1ZjM77q8njJh/tieoOI0JCotccjAIibQEv9vamm
         P1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832972; x=1759437772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=xKG57obyR+1qZLlF/gvnZ4J8mj8g4NCjtm/GGQCp7aeAkgGV85waYC+92YklXl0V/N
         5CeNcY7f6UkBy0NEVSVBlOA6gYGDrIE4+x06pXDUJRBLlvuVvllkCOVKqUnIFll41GWd
         g+RwyZokHIxnfWsDh8B3mdyG5uRvIJSpdeNzPbMyRfduTSyZ95o4tVoRJ/ec4gB/rPBs
         T92Z2+k6qhXVCQlnbE2KS6Sd4viGPfpWvTCIzddj6bCbFzeEXmqW48EUqklWdr7wk2k/
         LhpY+Z+NQRTIEncH2kE+8F6f3YDp6ZercXof+jnHKpl3XMaINgWZIMPaXVguVB022mk4
         ot3Q==
X-Gm-Message-State: AOJu0YzipDZz4XVLZPnHCRZ2l0+dIrFXOKyZboY5ZC8/CjXhE4GqXpSj
	GzVMV3BKmXYlWzOrDK+HoEUk5govO4TblsEe4XLQ6omD9G+1g3dhRVOu
X-Gm-Gg: ASbGncsVvcjeXuBoP/3xgACP2Hpk3wy1D3e8XONho+K64URG63PHoTVy2SGPaty941X
	WNGSpyHJfHylfniZgMN8xAL1RijiihxNyinJ8+acxm8MzFJcAPrXY9cArtcdC77XaXZlkP9csTF
	bUFXVFTbYpnMT5QQ4JdlXGIGKdTkHHSM1+wrmOay9+TXv1o9BYzCppNVCw6jr42TNkDSoRnpniL
	Wh6zu3alPuizvBVPRHK7TbRI9oN8KZZECJyoiRX33wHs0O5G9QPfvKAuAI8Jz6MjvE8IYUPY2EQ
	i+urLTevEO3Q3JQfdM23krf4hcXsommuZCVLjUPG/lP8NqXL+3vLDkJRoJw4s08rnkNp/JagZQN
	5Z2kItm3Z6R+PbgkCKIhLEsBI8z5pmHJuqL7R1889/jGj3Slvng==
X-Google-Smtp-Source: AGHT+IHo+8YH1s6Kn9VIM6VMYyZ/zlt5SgSlU/3nbxh+7PNrXmK56rGw/QyVJYd5VmMl+Z4GFCp5WA==
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr3840217b3a.10.1758832971587;
        Thu, 25 Sep 2025 13:42:51 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06b0dsm2618843b3a.82.2025.09.25.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:42:51 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH] Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Fri, 26 Sep 2025 02:10:28 +0530
Message-ID: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for this warning is that in the allocation failure by `alloc_mpc`,
there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
called on to again, it will lead to the attempt of starting an already 
started timer from the previous ioctl call

Do a `timer_delete` before returning from the `alloc_mpc` failure

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 net/atm/mpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..cd3295c3c480 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
 		if (mpc == NULL)
+		{
+			timer_delete(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0


