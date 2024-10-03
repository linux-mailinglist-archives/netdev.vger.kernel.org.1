Return-Path: <netdev+bounces-131439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3B98E83C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B7B217E1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13956171AA;
	Thu,  3 Oct 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY0A9Edh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E711CA0;
	Thu,  3 Oct 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921500; cv=none; b=ujeVrqlA5rRtoF1lkVV853jWBs06uANP+j6CIYz8q5vJHLIcUt4m7KbpWSdc8AeXR5g6Y88wisbEsdljayEIchzejkwQ+l0sH5OMZTmbwHAJ7z56YhXCLUAmTXo2cpxpgMW5/El8VEiGDZXQxWKHiMoLWRVjJkq4101aPp1dz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921500; c=relaxed/simple;
	bh=8H5nlGtRHgyGzDguTSFldW8ra244t3LM+dcJbwRToLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ib1whbT16wdRs0GnBAdayuAX2srkZENbepufQdbsxPphA+9+hhWqNt0PDjNRFiuPIRIW8hgxwDGbfoiWbZZ9O5LbMVA7k359OorTK6GrBsNToP52Sx3OfUKuejlSaNStCkYdxSEk0QM4RxgdInUauWbhozknxC0D453+rLRs8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY0A9Edh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1153497b3a.0;
        Wed, 02 Oct 2024 19:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921498; x=1728526298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVYHifgU2P3fMVHw2YWOkh8mW5ikEvaKNrPwGDOsBWI=;
        b=cY0A9EdhR0lLFff2mpgfW2BlixuUh7i04Q3YrfQ48u62NhWfSQ+jNaUh6dBrEEPiuZ
         1op3u33wgXvtMwNF3Gmzj1741pn/13X8hRiHATdY3fQvD7ZAouh030jav5C3ycjb34Wk
         2f7Dl5uA1l4A5rhKDFpfp4J04S9Wj36SrMdh5MaTSWkSQPFEMDzsj63/rAHpfofNU5ar
         FtrjyqlVTsVaqywK5vNrVMTGTQYiC4XtgnKgYFzyhU1hrQT1Yrk9eRz25HFPIV6J5hYi
         yUturmXgtQvCUxtrB6PitT7PANaZgaAWH1gmGNEeUjnn4XCcwelY8xSinfDcAGSpuD9O
         Bz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921498; x=1728526298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVYHifgU2P3fMVHw2YWOkh8mW5ikEvaKNrPwGDOsBWI=;
        b=JjyGNeBf6NgSDxTiu36HSPOMkUD3GVbRl0iN22CGgA8QysC9q6YQK8ds21dqszJEC9
         +Myg6uA10v7i0/56MPmmFdLTK+QWSHFnJCWeOdPwRSU1zm/Cjk6TspWiZH5WWjklRvBa
         9J2md/hZ3EKSr0i/231mBU2nWY6PpslFbi9ODS6L6gjg8f7DvnA7wk2BevWcXsqwEVV7
         kxIAbHz0ZfPZ2e3BOB9hu8nwcI8CcMaiVkfk7Vago7YklSDVTEmOxzy3lljKGhZLcVXm
         tkg8NYhoqc9ElSuHkUMmv+kYFuvD44Cj6wQ5mh/ugto1Qht0ziaCiOyUd1IJbJqDwKUK
         QZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw5c3EMfAhaiPZENBcm5143vW1zyoO1Sl1q+m6vPT7PIuaocreqGMdwx5lt7zSlYfIB0czz2b59i6o8R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry9R2u0AvIp/N/jXivtc7bpAmOKNVi7DP1SOu3Kq0ud5ptIcP
	STOTnJgm9yFqMBUOTMG2fLRsUXs0aK0V8g04ltySnXOWUglec3ec66Zw8S0o
X-Google-Smtp-Source: AGHT+IF2riypaArS1ZES8c0mBeA3EnCCzAXMgknfSEDW7c4vlFqe5OyFz3KVy39uNihhZuOTTzO+VQ==
X-Received: by 2002:a05:6a00:918d:b0:714:2336:fa91 with SMTP id d2e1a72fcca58-71dd5b7ec0amr2483203b3a.14.1727921497726;
        Wed, 02 Oct 2024 19:11:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next v3 00/17] ibm: emac: more cleanups
Date: Wed,  2 Oct 2024 19:11:18 -0700
Message-ID: <20241003021135.1952928-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on Cisco MX60W.

Added devm for the submodules and removed custom init/exit functions as
EPROBE_DEFER is handled now.

v2: fixed build errors. Also added extra commits to clean the driver up
further.
v3: Added tested message. Removed bad alloc_netdev_dummy commit.

Rosen Penev (17):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use module_platform_driver for modules
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: remove bootlist support
  net: ibm: emac: tah: use devm for kzalloc
  net: ibm: emac: tah: devm_platform_get_resources
  net: ibm: emac: rgmii: use devm for kzalloc
  net: ibm: emac: rgmii: devm_platform_get_resource
  net: ibm: emac: zmii: use devm for kzalloc
  net: ibm: emac: zmii: devm_platform_get_resource
  net: ibm: emac: mal: use devm for kzalloc
  net: ibm: emac: mal: use devm for request_irq
  net: ibm: emac: mal: move irq maps down
  net: ibm: emac: mal: add dcr_unmap to _remove
  net: ibm: emac: mal: move dcr map down

 drivers/net/ethernet/ibm/emac/core.c  | 175 +++-----------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 117 ++++++-----------
 drivers/net/ethernet/ibm/emac/mal.h   |   4 -
 drivers/net/ethernet/ibm/emac/rgmii.c |  53 ++------
 drivers/net/ethernet/ibm/emac/rgmii.h |   4 -
 drivers/net/ethernet/ibm/emac/tah.c   |  53 ++------
 drivers/net/ethernet/ibm/emac/tah.h   |   4 -
 drivers/net/ethernet/ibm/emac/zmii.c  |  53 ++------
 drivers/net/ethernet/ibm/emac/zmii.h  |   4 -
 9 files changed, 84 insertions(+), 383 deletions(-)

-- 
2.46.2


