Return-Path: <netdev+bounces-233014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D2C0AF98
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B6C4E1A1E
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE92586E8;
	Sun, 26 Oct 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+/kNwB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE538FA6
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501307; cv=none; b=HTseT6zkF34++dvqEQgCu1kQ54u5j8n709grxVskIa0lLl1WQyEXQGufVJEe9/KkIct0LHuno+hvzcqvKBMO6nhz/aLSBV6WR8l47yzCM9nl0hlX9xipTdroM/4Akbj59flSCn6Gr4MzOgKH3nl9vBSKnMjAWFPL1xuRqWVEH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501307; c=relaxed/simple;
	bh=wcVNI3+a/OZkRVcbPqxgDwyPv6jxzEQnw/ZSPShSkvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6GkwNpMimq0riuWTve5k7KR+rmi4UK1K44y7sbh+s3apJAUO17tB3HrgL5r6DLeyo3cv2RRVHrcToYM4RbwbPyZhLnGyvMg9FMnSqJShwOPb5f2KHVkcHzm4c+I+ahztG6MPLDPpYKS8WSmpK6GUwtx2BC4GZ4jtjKgIfnEH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+/kNwB+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso2929380a91.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761501305; x=1762106105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XW+6TLqRRcphYWjvidG8sptD1TC75wuXLwHskXrfas8=;
        b=G+/kNwB+6xTngBnnOvUVhxY2IYlIv/wFyhb7qZHgscwstn6dUKW4upd+tnM++3fvao
         eZWaaTopHIn/wkAbIIH0HKAovmFzCTqpHZsx5ET+Gp/D4Z5CEAue+S4rLgcJBYbWPyfd
         hbHrHTk68kwy3nbEGpNXFQJT1Qitb+mQfoQqS6oeD69aw7okF3/JKxTqSFt9bIV+tA/G
         F/S42z2U4BZcW37GpbLntfonHobtycOBhqn3Q/4yxr0EyIHi2IMX6If5Lt6U66CAMJ48
         Wizy+O4XryYpwwNXvDVPBs/va2DlyQTvfD+COrI/dH8tgqMzuLyJzVrQh3Jy9ulou1bS
         lNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501305; x=1762106105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XW+6TLqRRcphYWjvidG8sptD1TC75wuXLwHskXrfas8=;
        b=DT3RAcYZNI7TpqyjL/hq2Jkx5FkigqGccEFKCKqz0MBXRascC322ZNcY6n7Yt7DloY
         IL6IxaJF3lqMie2FfDqK4DUQGC1oFa0kBaVYpojiYuoX8IsWEihSWpscTq2JYDAFtdGM
         uiwqCfyQrsvfNNuMrYiePXaT4bKgmxA6ZVKfCJZ7lg/8A+r6h3yoByd+jRGJtxrCKc+u
         TsyX0fSlUTZQA4E4GO8GsAM816MRMFi4eXUOTG3Fq7BOyAaBydLUy96brokwz/bJDVDD
         4JLuEB+PwJKhramcgeehEp4nezTFOs5aZnuY3wWIwyKgZ+51mQOgLKhFglqN+VNladi3
         +eKA==
X-Gm-Message-State: AOJu0YyOjVwyhR7emH2PjOhBbNC9W1kmI1W5F/joE2I7T5xw01VzhyDb
	acq0A0peHw/WKKTtYZ9hhsqi4lZOFzz/bxJh6aF2ER8MpPze0pQ5sofx
X-Gm-Gg: ASbGncsweuMh6fCtRU0X9CiZIuss8hK9QbTIoSOnAOIWUpzaBOhm7ggqyXZNuVEXbN7
	pDyAIjIzIoXD+zMF9o0D0f2ugFjZmK7mGqmmcO7/IrUcJCZVAspe3OuZN2vuH5NWJe7Wj7ioVHc
	tdcVBio14iJJ6mz6IRuuToOwrtwdwJoEVFji2WqfShQdUZREk8BUWO3GWKDFtISV7y1AEywlFhj
	ADq3zrisT9irJfnauPD+oTA32Tf7kXuHFAKStn2OkLUguOp/DzA4cxP60TURWSM90k20hJSpEpZ
	P9KYl8skdCNRAV+wNUq40AphMbLgwY2c6MQLIVoP2VwA7mUXFzPawPjMA++qvrJK1r6gq4g/wDa
	wzuWSQKTuUmvkj5EUocJOdPvgXT9tbv9CabXPnolyOtxZ1v9D7aUxzqvlFahXrBv5OPomvmN+B0
	1zTRupVGFUu9zHnQeYY6V1dUs0x4gLkuPGm3sFYCLPFDGYTWlAc0xhTHgvtm38HFe/LjeEh43z5
	Ck38Q==
X-Google-Smtp-Source: AGHT+IFr6d0VRylVsQquJ/FhyU5BSy8+T51ENiIhdQPVdDI89GUzWkH6pWfficRysWgAQfUU6r2+eA==
X-Received: by 2002:a17:902:da8f:b0:290:af0e:1183 with SMTP id d9443c01a7336-2948ba3ef7emr100193725ad.51.1761501304768;
        Sun, 26 Oct 2025 10:55:04 -0700 (PDT)
Received: from debian.domain.name ([223.181.110.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm54813845ad.107.2025.10.26.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:55:04 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC PATCH net-next v2 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Sun, 26 Oct 2025 23:24:43 +0530
Message-ID: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
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

To address this, this series proposes dividing existing set_rx_mode 
implementations into set_rx_mode and write_rx_config

The new set_rx_mode will be responsible for updating the rx_config
snapshot which will be used by ndo_write_rx_config to update the hardware

In brief, The callback implementations should look something like:

set_rx_mode():
    prepare_rx_config();
    update_snapshot();

write_rx_config():
    read_snapshot();
    do_io();

write_rx_config() is called from a work item making it sleepable 
during the do_io() section.

This model should work correctly if the following conditions hold:

1. write_rx_config should use the rx_config set by the most recent 
    call to set_rx_mode before its execution.

2. If a set_rx_mode call happens during execution of write_rx_config, 
    write_rx_config should be rescheduled.

3. All calls to modify rx_mode should pass through the set_rx_mode +
    schedule write_rx_config execution flow.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

ndo_write_rx_config has been implemented for 8139cp driver as proof of 
concept

To use this model, a driver needs to implement the 
ndo_write_rx_config callback, have a member rx_config in 
the priv struct and replace all calls to set rx mode with 
schedule_and_set_rx_mode();

I Viswanath (2):
  net: Add ndo_write_rx_config and helper structs and functions:
  net: ethernet: Implement ndo_write_rx_config callback for the 8139cp
    driver

 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 include/linux/netdevice.h             | 38 ++++++++++++-
 net/core/dev.c                        | 54 +++++++++++++++++--
 3 files changed, 132 insertions(+), 38 deletions(-)
---

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
-- 
2.47.3


