Return-Path: <netdev+bounces-124836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1496B1FE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43AD1C20A04
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6C13A25F;
	Wed,  4 Sep 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nnOHXpH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082B126BE6
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432080; cv=none; b=mpWZEV1cz3auA22Hsm7nncJr6cqakANTc640A8mC5U6JzHRWY8HTOufuU/GfJ2ZgzBz4bG+QNoRqw+dAGs73923IsEV5OjJdbs/ezYkMqfZD+b2ewW6AtndvV+b5yYj/xqmgYHN1fQEN3rqc4cGWlHsgOSxI17DjavJBVjUBDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432080; c=relaxed/simple;
	bh=INeGw5maKhB1p7IuRwGauxcaasPw1eFB87oVd60jFD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxWcdMxCDa/9n0xV93x4W6gBsyxxbnziyzenGDu4WhqCPygzPLRnwbbVCoXkJ0tza9ALgwJoomdKX22okyhf6hQFYfiHPlxWDsBJzPrvQP0EyGitrYYsJCKjKuzfX83yjVNgdXD/9kq295aHazT6oFOwAsP4+OTyCicG4DvOFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nnOHXpH/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725432079; x=1756968079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=668GR7K85eKGutSjk9hdhyby0WaauuFbm4jSRy4Js+Q=;
  b=nnOHXpH/mnVoxAuFUe3r96BQ1Uf7mGBYaAYjvKZ5mGdz9GuVMSyTYagF
   FEwtX3fw7IOup4ddRkWHAnDD0A5dOKEEoqgYtSvO5IQkz3d7NMH0BZjfJ
   yXIuYblyhliNovEQHPbV+dHIbg+QNpf04FvbIY80TIZwjrImVOxM5Br3U
   M=;
X-IronPort-AV: E=Sophos;i="6.10,201,1719878400"; 
   d="scan'208";a="327404631"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:41:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:45773]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.128:2525] with esmtp (Farcaster)
 id fa2646ae-c483-4dd3-a0cc-92f2c91c3a0d; Wed, 4 Sep 2024 06:41:16 +0000 (UTC)
X-Farcaster-Flow-ID: fa2646ae-c483-4dd3-a0cc-92f2c91c3a0d
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Sep 2024 06:41:14 +0000
Received: from b0be8375a521.amazon.com (10.143.69.20) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Sep 2024 06:41:11 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <takamitz@amazon.co.jp>
CC: <andrew@lunn.ch>, <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Wed, 4 Sep 2024 15:41:01 +0900
Message-ID: <20240904064101.8548-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240904055646.58588-1-takamitz@amazon.co.jp>
References: <20240904055646.58588-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

> My colleague, Kohei, tested the patch with a real hardware and will provide his
> Tested-by shortly.

I have tested the patch using my physical hardware, an Intel Ethernet controller I219-V. The device was properly attached by the e1000e driver and functioned correctly. The test was performed on a custom kernel based on kernel-core-6.10.6-200.fc40.x86_64.

The PCI device is identified as an Intel Corporation Ethernet Connection (17) I219-V (rev 11), with vendor ID 0x8086 and device ID 0x1a1d. This device ID matches the E1000_DEV_ID_PCH_ADP_I219_V17 definition in the e1000e driver code.
```
$ lspci | grep -i ethernet
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (17) I219-V (rev 11)

$ cat /sys/bus/pci/devices/0000:00:1f.6/{vendor,device}
0x8086
0x1a1d

$ grep -ri 0x1a1d ~/ghq/github.com/torvalds/linux/drivers/net/ethernet/intel/e1000e
/home/kohei/ghq/github.com/torvalds/linux/drivers/net/ethernet/intel/e1000e/hw.h:#define E1000_DEV_ID_PCH_ADP_I219_V17          0x1A1D
```

So this testing confirms that the patch does not introduce any regressions for this specific hardware configuration.

Tested-by: Kohei Enju <enjuk@amazon.com>
Thanks!

