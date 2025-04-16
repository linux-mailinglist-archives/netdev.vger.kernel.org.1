Return-Path: <netdev+bounces-183249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E480A8B772
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695C01899264
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4223BCE6;
	Wed, 16 Apr 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bC+46JZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFA2356DC
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801791; cv=none; b=IHSPwknZgNAW63I7ZZfNNRrU/zjNf2ZfdrvxnU2cq3DNBiNV5vt52cC0nq1OVXCDCSA8w5jh2JGVsiA9BJ2+DgHRdIwE22yIYHR5cSBINqSMOEeAXsvg9FRLIgGVHWdphMU1Kw3ZTG4CmCYM+Tv1E1CRe6P5L50fFE9ukiUA7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801791; c=relaxed/simple;
	bh=TKOYFxjWwdCMK9F618dWQqPueP3yQbahpnhw3EqEsys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CuT6QQjaXgKwi3U8pPTA09YBhXT0F1brAoOhB1gp+ReA7Hmy+35R8jGfzRFdyp7katSxOu+YUYoBZsD/CFWKF1Lh2isse7rMxt0V34vh6TYuhvVC/QehZKBlUp7SysfQ1ze928DM9urTuU+d0ybO1Pnee2gjchQRAsc+9OiKDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bC+46JZ7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso381787f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744801788; x=1745406588; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sGBx/7Vpt85bGQXkOcKMWCGaBdunxMD0SLk88jGe2Y=;
        b=bC+46JZ7gZGxqHnezSMote2TakLpvWox255m02UP3lbRc2ZPzKFJTrifzseQS9XLUV
         HCPOdNPFPY4kRYScg1GTXhMGOwGB7RRxd8XU/5lAvUQH5VwPk3FXk5HarzCuOFd8lMQ1
         pkABHCCXgGrQhm5bTICgKl70UD6R8Zd1DrNEhkzKEz5iuDlKORsa4jrNtECCJ+bxzw0Y
         T1v0pyPl43hQQKkIqkXJEXyUl5RYCSL+nStPrT0Y44pVFGd2xKd3BUII55K5Ky+RaiKO
         /wSyEWQ62w1D7kSPggLVH9kN8hDKwIK523mQSVi4irPeb6Q5KHiRbeKg32Sy6+RZ6yLz
         Ewwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801788; x=1745406588;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sGBx/7Vpt85bGQXkOcKMWCGaBdunxMD0SLk88jGe2Y=;
        b=b/khDfsesvBm/6kJSsqThuouLEEI8gDBApTp00ixB2h+id2yfo5mhuuLrBzIXBeO9D
         hnihXp+t5tS5EcIQu6hbrgQcgtSqiiNwCTYaBoI6R5iyGRIlZF4pKC+c9B3FKKGJJ4i0
         B+dXvQRznuPcPDIadn0+8f17lIOeWDKXvRpGzGB9sA8I/YcJ3lOYjQmzNtQQGS0vYmKZ
         QAoHXdXncNHKhOckx4UkvERfWP4YyLy4rJQkunKwK+gQs/S25Ar8ubn4d3L1a7hLMRQn
         96Fd19AgRu8bKH3CFrlHKbwX1IuIv4PjWgHgxJR4G1oBNVPXwbIy4GeiLiRkX1APK3S2
         2KqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFlV5ECHM7qOIDb71gT5XW8o9mWIDG22TzuZcEQWtoy+Nk4rMlwF4s7KPZ3XEqzjKtAMJq9FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FaYrC81cbziuPkxcVAFEGOTBdImzEcaBrByKt381p/5JkzQe
	oOPTxHMz8qkoj03b8wK1k10HGHFAz+rQFY2jnM0GGO0PGnRf96yGjpyTbybwPYE=
X-Gm-Gg: ASbGncuCWpZnK8XMatSL+CtQvfcPAM4CWeFxMzUJxpv2G4ip3/tNMZLRYvaNVLrJKK5
	X+0xKaq/SHwG1leenS+oVLi8sgWtD8xtAa7FTsH6PpBBvTfZggr+C35r9oEgjqsmFD3aygxYt1S
	AbHhywdQ51/KOoBdc+0Nsnyj+HNIdTuJbTRQfk+fNfZtmWFbr9HJ9bO0Y060kOQab/8+l3dXD5m
	y/bJGl2Z8mndMLGOGMMBitxHyDw3P4B7qu5YRMBL+iRP0zy3LbIcFg7mx6ZKT3pyXa+0aPTLz0K
	NOJxxn2bBGwcKdh5S1pUoQLgVWace8O9QLCwZno5+t1LNA==
X-Google-Smtp-Source: AGHT+IHx7MYQN4B8vZhw3h6d0Xyzb/YDJ0VgXDSFIkh0nx2d4MfQsJUNDMvihMSE7oLeCoFPsNBDwg==
X-Received: by 2002:a5d:6485:0:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-39ee5ee4ab8mr1258006f8f.19.1744801788124;
        Wed, 16 Apr 2025 04:09:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eaf43ce30sm17232725f8f.62.2025.04.16.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:09:47 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:09:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [bug report] igc: add lock preventing multiple simultaneous PTM
 transactions
Message-ID: <Z_-P-Hc1yxcw0lTB@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christopher S M Hall,

Commit 1a931c4f5e68 ("igc: add lock preventing multiple simultaneous
PTM transactions") from Apr 1, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/ethernet/intel/igc/igc_ptp.c:1311 igc_ptp_reset()
	warn: sleeping in atomic context

drivers/net/ethernet/intel/igc/igc_ptp.c
    1280 void igc_ptp_reset(struct igc_adapter *adapter)
    1281 {
    1282         struct igc_hw *hw = &adapter->hw;
    1283         u32 cycle_ctrl, ctrl, stat;
    1284         unsigned long flags;
    1285         u32 timadj;
    1286 
    1287         if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
    1288                 return;
    1289 
    1290         /* reset the tstamp_config */
    1291         igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
    1292 
    1293         spin_lock_irqsave(&adapter->tmreg_lock, flags);
                 ^^^^^^^^^^^^^^^^^
Holding a spin_lock

    1294 
    1295         switch (adapter->hw.mac.type) {
    1296         case igc_i225:
    1297                 timadj = rd32(IGC_TIMADJ);
    1298                 timadj |= IGC_TIMADJ_ADJUST_METH;
    1299                 wr32(IGC_TIMADJ, timadj);
    1300 
    1301                 wr32(IGC_TSAUXC, 0x0);
    1302                 wr32(IGC_TSSDP, 0x0);
    1303                 wr32(IGC_TSIM,
    1304                      IGC_TSICR_INTERRUPTS |
    1305                      (adapter->pps_sys_wrap_on ? IGC_TSICR_SYS_WRAP : 0));
    1306                 wr32(IGC_IMS, IGC_IMS_TS);
    1307 
    1308                 if (!igc_is_crosststamp_supported(adapter))
    1309                         break;
    1310 
--> 1311                 mutex_lock(&adapter->ptm_lock);
                         ^^^^^^^^^^
So we can't take a mutex.

    1312                 wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
    1313                 wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
    1314 
    1315                 cycle_ctrl = IGC_PTM_CYCLE_CTRL_CYC_TIME(IGC_PTM_CYC_TIME_DEFAULT);
    1316 
    1317                 wr32(IGC_PTM_CYCLE_CTRL, cycle_ctrl);
    1318 
    1319                 ctrl = IGC_PTM_CTRL_EN |
    1320                         IGC_PTM_CTRL_START_NOW |
    1321                         IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
    1322                         IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
    1323 
    1324                 wr32(IGC_PTM_CTRL, ctrl);
    1325 
    1326                 /* Force the first cycle to run. */
    1327                 igc_ptm_trigger(hw);
    1328 
    1329                 if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
    1330                                               stat, IGC_PTM_STAT_SLEEP,
    1331                                               IGC_PTM_STAT_TIMEOUT))
    1332                         netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
    1333 
    1334                 igc_ptm_reset(hw);
    1335                 mutex_unlock(&adapter->ptm_lock);
    1336                 break;
    1337         default:
    1338                 /* No work to do. */
    1339                 goto out;
    1340         }
    1341 
    1342         /* Re-initialize the timer. */
    1343         if (hw->mac.type == igc_i225) {
    1344                 igc_ptp_time_restore(adapter);
    1345         } else {
    1346                 timecounter_init(&adapter->tc, &adapter->cc,
    1347                                  ktime_to_ns(ktime_get_real()));
    1348         }
    1349 out:
    1350         spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
    1351 
    1352         wrfl();
    1353 }

regards,
dan carpenter

