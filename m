Return-Path: <netdev+bounces-249052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C4D1328A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4E81301E143
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F322BE033;
	Mon, 12 Jan 2026 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3niQiM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4ED2882B6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227865; cv=none; b=Dda/niaW3jgADjRoM51YNo2dpuYVIMedDATgJNepug1r9AzQ2bvjLlgiIIQoz+Z4W1T43dfvlzbTEoGBKUn/+cvbL9f58XoLfLKAQEEdSTJ0VbKjQWNQRwLjPDWJ84gEiqm3TpuHYCwEUK95dunmKju0OJgHqsN65Jno/6YtT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227865; c=relaxed/simple;
	bh=WX3med7k64DGbuKknKDTleYzM4EVPBaQEYaFPUVaWMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=madd559Qd5T8W2/Ks8Wbbpg3HtWwEQgSjzeRYFbkBhY5qVO163V8riSqdfLCf66fsyDy6QbL9eTUcH9yaFjl2oVrz04vHog6tQWXLA9lmEfmJlS7APTVguxyAGnmkUAQQ199CaloGhMWlo2dnfLoAKrnxHIfrLymxJ7KvikzOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3niQiM5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b679cff1fso5177561e87.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768227861; x=1768832661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IcHD7YAme7YBXxBYxi+EUDAU5Xpbmz6Ultra/Na13Q=;
        b=k3niQiM5qdgurRWr4FMS3gbMHyuhpPKDMnsnq7h01ZRpnIs+HEmn1oXwwsdhOxjbVZ
         xnNdn5c51/9IvB6D8BnZ9OGjeZBrbHpJ5FraYgY1XjGR33RtvZvYBtvrf+Z/zpx+Me7B
         bBYNxZjK21dKVf/125kZrsDdjxsyT4bWqOd2CROX7kY3lg90Ixz2kCxyRNRHx1EfgXww
         4BLToB5aTI3uqg58p1ezUSIFk5bMxyVikI6ZVYyh7gB0vgfAlZLm2E8R0biNX1O32fBK
         +7Hd2B8/atinWbpJS10ChssJgv5BGEd7Oo86ZkRqAFCzd1hOajneeSYcZ6p0exw4beog
         I3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227861; x=1768832661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IcHD7YAme7YBXxBYxi+EUDAU5Xpbmz6Ultra/Na13Q=;
        b=oZnZmkHPpljYRJ0JMXIBsZxBGqAnH3BNoI7fgNT57Yhd2kxceFW+EOpN5cnU4rlS3i
         lyzGx7e7n6Xv67RG4FQRvT6Dicw6/c1rMRq7ryWUQk8I4NSKEnr8I2vdGReipx0JUohh
         ewhF3oM5ffZwhxuZHlNKsyoEVMdQfonHPIgdpMa/NQCMFfDopGsUlMf4Zj24SHDqHYll
         p4BUt5cXEIA3R3U/wZ6RDL+936VEGdo8yj/cWBdYFbZMHzyqV4EPMwBh3QGDGHZbIS91
         B/A3yZKHXb08WAfIwxhRNe+bXTIZBz6koaIOdFjphcAEt4RcDpGFSR++JNugGhuKv8HK
         TH2g==
X-Gm-Message-State: AOJu0YxVNpfaZjjzdcQgZFbLOtQsI53Ds2cGu3pDyTl8CpT8q8k3hTb5
	mCjaazWZei6GXCwWd0drBGEgEwU2Yqca5SM86Qim280+JoyvKLfTQsaaxJsZrws016E=
X-Gm-Gg: AY/fxX5DRhf4UHywuzoonwCWtPVO12Zr4Mf+m6skqIV8RhpXGTgFI/K557ZtQaG0mlE
	I+3jl+HakAnowW41wky2z938KtlVv6Z0woV9RSyjK4KnxomK9IZ748vYRl9uvidpH6Udw+tQNXr
	LxuCMAjXlwp/WDQXNmMo+rFMRWCrWArHiy3PnU+DEJ5O8ghv6k7+l4zaP11wVbAWR1fqfh303v8
	1ZPdbVRdwaE/aFDoTt8RnFcExj/k1lVGt2KjgEN5ADmIWvIE2MkquXHxps8+RBKKagpYNodT2NR
	WJZlJaXXy20OErXq6OPEEKdB6g/EDt6alppR7G2ud4DdJUjQE90eMnpkrFzKFqi36b7rZkmHHCt
	Y0XZah/5Lc0r5cN1ddbZwifPLbdYyWhMfkTO0r81xPx4Rm/kuvnm0lSKWa7sSyrrFEVWysFhosZ
	z2Lt+phtwnc6GgGKAap9TVVya4Wkf3jQtFvUdQ3+bKHPVEUw==
X-Google-Smtp-Source: AGHT+IFKxp0i1wHlcdRKIIJefZt2iNS9Fzu+8SdEG7m+IBC2mDxtSvJ2yyEuAn3mOoRNCjAYu/kSrw==
X-Received: by 2002:a05:6512:3b91:b0:59b:794b:6d6f with SMTP id 2adb3069b0e04-59b794b6e03mr4326158e87.42.1768227860951;
        Mon, 12 Jan 2026 06:24:20 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0d86bsm4821886e87.23.2026.01.12.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:24:20 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: [PATCH v5 net 0/2] ipvlan: addrs_lock made per port
Date: Mon, 12 Jan 2026 17:24:05 +0300
Message-ID: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch fixes a rather minor issues that sometimes
ipvlan-addrs are modified without lock (because
for IPv6 addr can be sometimes added without RTNL)

diff from v4:
  - Patch 2 (selftests): execution time of sub-script is limited with 1 minute.

diff from v3:
Main patch is not changed
Patch 2 (selftest) changed:
  - Remove unneeded modprobe
  - Number of threads is 8, if KSFT_MACHINE_SLOW==yes.
    It is needed, since on debug-build test may take more than 15 minutes.
  - Now veth is created in own namespace
  - Added comment about why test adds/removes random ip

diff from v2:
- Added a small self-test
- added early return in ipvlan_find_addr()
- the iterations over ipvlans in ipvlan_addr_busy()
must be protected by RCU
- Added simple self-test. I haven't invented anything
more sophisticated that this.

Dmitry Skorodumov (2):
  ipvlan: Make the addrs_lock be per port
  selftests: net: simple selftest for ipvtap

 drivers/net/ipvlan/ipvlan.h                |   2 +-
 drivers/net/ipvlan/ipvlan_core.c           |  16 +-
 drivers/net/ipvlan/ipvlan_main.c           |  49 +++---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 168 +++++++++++++++++++++
 6 files changed, 208 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

-- 
2.43.0


