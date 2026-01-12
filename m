Return-Path: <netdev+bounces-249134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A3D14B5A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531A1302E07E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7105387590;
	Mon, 12 Jan 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK00d+Y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F016314A99
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241821; cv=none; b=OSu61pDf39HUXF4ZaQ9ynyWNNKsbD6bU9lX52UBrwh7jsUF6hkURIn59WWuTr/YcML1URXXnR6ydeCNSzCuc0sXfYgEL5HwTqUwyFht6REOKqG9J8L/0A9daQOefAjqyxNWIm7A/+BKV8hvuPiGHOC4o/kv/+TneD302YFa7MAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241821; c=relaxed/simple;
	bh=afHfmAvZQj+2iviHBO+ZSMwR+6N2HvPs0NvXrGSkTRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhDumG0vTAAC/r1NqZlSLoOu/CqnQnipybV8nnOg35jHXKWpvha9r0Mao8cBjGaHlY8/Q3urBIUWtMZXxPjdnYcoKWvADJUi1rWAN74ZRF+KSIzpAOVR2ntw3WWRubWkQbK0YnPUb0E5PaKme3TXndc0UNLj66E0gzbAPBSPeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK00d+Y7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81e93c5961cso2317758b3a.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241820; x=1768846620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhpaAlKW26OhYlxc15mNDWFg1nSuNxZpLWCT9AQiLQU=;
        b=PK00d+Y7RNHcwUhnnrXSwxlfwACsSNZ/pJVkXfg/Ovr4JHFLRDRm4O1wo9SCSo18yl
         v/0I2Su6AIzYnz7P/gcdnLRBeXvWYN84JO4MA3Vh77N20bCbv9FI49Ckai3WnNIEce1C
         Djchim8OlAZokPl1nSDl8ddeUE26lUMP001SNf5T/jIUQRKL7/u6D8cqCfoNY8pdxDtA
         Ofw7xpYWmDaWvw23rMXxmc02izy+/3CHEzEHrN9Lgk7f2cOcXYi+ty04Dtz3rzFrwdzR
         kiTYtO6XQf9cJ4tTMvHj0fVw4TOaVnPUfHJ9xhrB6SX0MPzelTMtsHiookdcKbZm7xIz
         71WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241820; x=1768846620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhpaAlKW26OhYlxc15mNDWFg1nSuNxZpLWCT9AQiLQU=;
        b=dBg8+o9jg2gr746TqXqeRQtMLf0AWdm00OtCQMxNZZbBM+RzvHZn72VfXxo7kwFwy0
         D11g5z2+XQBazruAEWCk2JARIYCR42r0NTh7Xi+Lhudtv2TXx/gKi9C5Yfvmg25r/fxG
         QydEt27UNV+W4tF0eemIQ1faZqOTiZL50TyN3CXm5XhCi3hkbCi3ZXldAb2J6JjCemFj
         VGDQMPL4kkLvg82j8ZpT4LXWseAqxFIjQvbmlkTFLguOo0sprZ7GUhNsC1EyW5/9VQ5R
         /za9Fz4YNna99MWlLuNFVoCPK4hK4hPJ6W8bJhZKItY20gwkq/pMNzlE/o08/m2OD872
         FOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVSGfiuMPRa5GY6F12hxeB3xCRVHg/AkWAzSA3JfchXG6QtVOrrcwgSY3R4iVZ/nL9wtmEYxl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMcb/+j8XHgp7ojRaJYsNzRnCziw9KrN1BJEBeF2RotJnQkUY
	x+OD6w0NhUAsCkqZ5Ci5k7y026wIfi0xK9KKl1W+dTgxcgE/vMyQOGya
X-Gm-Gg: AY/fxX4eYM0u0m9I2U9QdMPISENeqEbSbaoM0sDrHUUbo/ZOSHSDcDZCBzz4/CPgVg1
	IxZz2fMckXw+sfDVWWZ63pAyChNnzLCCVZ380B5Hl37piyjrefl1lqgvrr96LgweNopwDnrRLL+
	mCuRWee3YWYZN04XHXl56q26OBaT91dtwUL077Dq4KkYC8/kLTTTSf8TWVTPzsNbQYdy9vdClzO
	wIgHr3RD2ukcTIIZKH/95RnVZAtUT98mnrPCbwB9/Lc5TVq5prIIFWv8wCm7kSEPMVD2auPLA7u
	siqikRMXeFD3iPVL0FwyPxqTQ7mXNa/h5RFj6D7fnKrtTIfHMDmBhOuIgCAjFSLKSUVmI3HUqrk
	yDgIu2ggZWT77So9sJfV9xR0LKKebtpkLmPKP9e9gGV5SbdTfKxs5+xG3kbA7o15Y3Hx5vJBb8q
	ncCihD/d7uIip8F9+XowvKp9kCI82gMhh/vq2SkTRK2OnJslw4n1KHQZ+1EYT3QMGSHw==
X-Google-Smtp-Source: AGHT+IHCbvxDzVKglJnQ5DCOnCgrWdajUJ3xC4WJMbnpDbcyewmJC9+3bPGSnBu1mkm93FTZAHDPBA==
X-Received: by 2002:a05:6a21:6da4:b0:375:4426:e78b with SMTP id adf61e73a8af0-3898f9f0e9dmr17726103637.71.1768241819635;
        Mon, 12 Jan 2026 10:16:59 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:16:58 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 0/6] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Mon, 12 Jan 2026 23:46:20 +0530
Message-ID: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep. 

To address this, this series proposes dividing the concept of setting
rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
change the semantics of set_rx_mode and add a new ndo write_rx_mode.

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

This refactor has the secondary benefit of stopping set rx_mode
requests from building up as only the most recent request (before the
work has gotten a chance to run) will be confirmed/executed.

In brief, the new flow will look something like:

set_rx_mode():
    ndo_set_rx_mode();
    prepare_rx_mode();

write_rx_mode():
    use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock spin lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode() before its execution.

2. If a make_snapshot_ready call happens during execution of write_rx_mode,
    write_rx_mode() should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
	schedule write_rx_mode() execution flow. netif_schedule_rx_mode_work()
    has been implemented in core for this purpose.

1 and 2 are implemented in core

Drivers need to ensure 3 using netif_schedule_rx_mode_work()

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_schedule_rx_mode_work()

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag
Link: https://lore.kernel.org/netdev/20251120141354.355059-1-viswanathiyyappan@gmail.com/

v6:
- Added struct netif_deferred_work_cleanup and members needs_deferred_cleanup and deferred_work_cleanup in net_device
- Moved out ctrl bits from netif_rx_mode_config to netif_rx_mode_work_ctx
Link: https://lore.kernel.org/netdev/20251227174225.699975-1-viswanathiyyappan@gmail.com/

v7:
- Improved function, enum and struct names
Link: https://lore.kernel.org/netdev/20260102180530.1559514-1-viswanathiyyappan@gmail.com/

v8:
- Implemented the callback for drivers e1000, 8139cp, vmxnet3 and pcnet32
- Moved the rx_mode config set calls (for prom and allmulti) in prepare_rx_mode to the ndo_set_rx_mode callback for consistency
- Improved commit messages 

I Viswanath (6):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback
  e1000: Implement ndo_write_rx_mode callback
  8139cp: Implement ndo_write_rx_mode callback
  vmxnet3: Implement ndo_write_rx_mode callback
  pcnet32: Implement ndo_write_rx_mode callback

 drivers/net/ethernet/amd/pcnet32.c            |  57 +++-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  59 ++--
 drivers/net/ethernet/realtek/8139cp.c         |  33 ++-
 drivers/net/virtio_net.c                      |  61 ++--
 drivers/net/vmxnet3/vmxnet3_drv.c             |  38 ++-
 include/linux/netdevice.h                     | 112 +++++++-
 net/core/dev.c                                | 265 +++++++++++++++++-
 7 files changed, 522 insertions(+), 103 deletions(-)

-- 
2.47.3


