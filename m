Return-Path: <netdev+bounces-169135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA55A42AAF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD9619C1417
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4026657C;
	Mon, 24 Feb 2025 18:04:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86B266EFA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420270; cv=none; b=FuCWP/tORyye2DHtuY9LLGit1Q12J0CqjuQfbzLj8ILGgWhbxBrOsEo4yGSau+jxhd7S/1ONq3KtprEMyQFYWZx6v8I8lYKQv5SFUQH4IipNwn7Y1RHBNs2Z7Kghx4bwCmcCSwb+Z3wCm1DR7aMw5zZDjqAx/ZOcWUlgUtZggRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420270; c=relaxed/simple;
	bh=pbwFOWAx44ZuIowPYsyGw/oNC4EXkaQ2XpeAYz8XphI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lAt6A/+JnMB/KFnWpZNks540/bAgiO+qz/h6S9fzBGd79wWOfJROv26JhTwuh4dXqIYAYguEZLa7wFXpY8xBxSWhzLOB1K62p20SnFltvF5ccLHf1sN4tD8tsAP6MOy1lBObOel4Dn7hqIzVzdWFPgBXxmpA6jKJZ3IkfZwtPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so7781599a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420267; x=1741025067;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GzJPzQD1XcJJX9GQX78LxhdOx/+5Rtax9/YFivM/Rk=;
        b=LGGPXZ0CEeJsW/oYGTK5RFurUYOQtTXAs3GMJ8VPUR+aJDmcUcJEEk5Y3OxWfDRDue
         rjiZJqxksAN93Z0rAaBDWMZBzIsGRxWboabZSg3g6ur/K08VXrPaCWekDNk5+Z2NIOu1
         +7oqC6U392wkdP4XqEclZbBP1uJ0SVGwHxkI7lbXoEOmHtiqjNhzE5G3Qu/K63765oHY
         ehJ46NcYhHkXsKVrbpumA0XEob22STaPjHlropPaMZDX7KP3ohZvKSG//zX7X+E3jBPU
         PxScni56eqVh1ejTsOLoO/TJANHOXOoiFtmKu2XQbrN8Giiw9yX4CZcC2FAkd/ecJaA7
         neYw==
X-Gm-Message-State: AOJu0YyNs/Ww8pb75NT8XXwRsJshYcIEa+KvL2hHqnFPbU8cuVSns77B
	BtMXm71uN2+xBL1Xhwl0TFaQrz13ZoJo+U76gM7sdC552pgET6mgPrR33w==
X-Gm-Gg: ASbGncvxG8wQV3S91D5BDrihhmnsUmXGv6D6G3KSlh6h3YP1KYeDxW0aZAIgXqDYVz9
	mI+/YqZCYOUQmUtvhyPF2aEAHHL6XYlOt8Qy7kAf3A4EFAzjqsoO/HdyChiauP3lLCozIK7KuDL
	5wb5qWF+Rz6EiA3sUqr8wF1cPuDLTeyxkGbd1RKkEdavagr/x/Ba/QNWDq2Cxe7g9NWRpmrc8Fo
	XdEMptlPjM3/nKDJEOkw9+KNezKbUE2WqoFKPyIXGxsysRkdqa3y+VhcVFRSwDLLdzSzfWO/mpE
	QkdzpY/ccDAeGv0o3A==
X-Google-Smtp-Source: AGHT+IHZRR1hLw9fgZvhG/xp+0qrq6f9n6wILNagrkwszZvOkx2qs0dNSGzziS6WYxZ70wWshqTrwg==
X-Received: by 2002:a05:6402:5251:b0:5dc:74f1:8a31 with SMTP id 4fb4d7f45d1cf-5e0b721e084mr13977328a12.26.1740420266897;
        Mon, 24 Feb 2025 10:04:26 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e02sm18565145a12.3.2025.02.24.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:04:26 -0800 (PST)
Date: Mon, 24 Feb 2025 10:04:23 -0800
From: Breno Leitao <leitao@debian.org>
To: saeedm@nvidia.com, tariqt@nvidia.com
Cc: netdev@vger.kernel.org, kernel-team@meta.com, thevlad@meta.com
Subject: mlx5: WARNING: register_netdevice_notifier_dev_net
Message-ID: <20250224-noisy-cordial-roadrunner-fad40c@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I've begun noticing these messages in version 6.14, and they persist in
6.14-rc4 as in 082ecbc71e9 (“Linux 6.14-rc4"). As I haven't found any
reports about this issue, I'm bringing it to your attention.

	WARNING: CPU: 25 PID: 849 at net/core/dev.c:2150 register_netdevice_notifier_dev_net (net/core/dev.c:2150)
	
	<TASK>
	? __warn (kernel/panic.c:242 kernel/panic.c:748)
	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
	? report_bug (lib/bug.c:? lib/bug.c:219)
	? handle_bug (arch/x86/kernel/traps.c:285)
	? exc_invalid_op (arch/x86/kernel/traps.c:309)
	? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
	19:02:13 ? register_netdevice_notifier_dev_net (./include/net/net_namespace.h:406 ./include/linux/netdevice.h:2663 net/core/dev.c:2144)
	mlx5e_mdev_notifier_event+0x9f/0xf0 mlx5_ib
	notifier_call_chain.llvm.12241336988804114627 (kernel/notifier.c:85)
	blocking_notifier_call_chain (kernel/notifier.c:380)
	mlx5_core_uplink_netdev_event_replay (drivers/net/ethernet/mellanox/mlx5/core/main.c:352)
	mlx5_ib_roce_init.llvm.12447516292400117075+0x1c6/0x550 mlx5_ib
	mlx5r_probe+0x375/0x6a0 mlx5_ib
	? kernfs_put (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/kernfs/dir.c:557)
	? auxiliary_match_id (drivers/base/auxiliary.c:174)
	? mlx5r_mp_remove+0x160/0x160 mlx5_ib
	really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
	driver_probe_device (drivers/base/dd.c:830)
	__driver_attach (drivers/base/dd.c:1217)
	bus_for_each_dev (drivers/base/bus.c:369)
	? driver_attach (drivers/base/dd.c:1157)
	bus_add_driver (drivers/base/bus.c:679)
	driver_register (drivers/base/driver.c:249)
	__auxiliary_driver_register (drivers/ba

Let me know if you need further information about the problem,
--breno

