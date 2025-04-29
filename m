Return-Path: <netdev+bounces-186625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB0A9FEF4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0917B5F3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D855153836;
	Tue, 29 Apr 2025 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BVVpLy3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADD433C4
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889671; cv=none; b=cWDgCItE87Ky2Cv79RaW5KiD+kyErl0x4elDHuwJbwgGn6AP/UCooyYKYKrodN+vaIQTJEtypPevfiaz0FjYVUxiX9iHb75jR7j9aj7oav2rsYdkUffZVeFUAscZiZkHlUsKtaordK2/fGnxrbAox7f3z2GyS6mnmxPDFRv7oxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889671; c=relaxed/simple;
	bh=sT6k8d9O83uMHGT9GCAnavue927D2pB5YuDu1taIrwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7nv2VMBkMH1gFHRYdHT99GVbJbrFvuiXVXesy7PbAdvtWSd183CJLSNO72ZVtg67j7qWgwD/Vzc0fdjwx29J3GO4XOvc85w+zDa38YMIlwYo3vVEPP73UOosoCecnRFp7V/Z8L9Kt/9D32ddRdpJGpEpPR41hnSTvZ1qIDCCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BVVpLy3R; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745889670; x=1777425670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXI5eyFnc4eBm3PGUpKmquGMwMt35sR9NVwpmEPXQn0=;
  b=BVVpLy3RwXOEIy6AaafG81bAQFqc4o4crsh5mdTFmGVbSAwlbPP6lwVd
   Xsyjgv+mGOdOme+iGUDDkw0aLbWboth1xoEcoOqTN6czej5EZnSoFZrvN
   AAmJDz7yZWWpIjJT/yNpoIeOopq02OEelIWB3c2LdUDN0muxQaMoJ/udV
   s=;
X-IronPort-AV: E=Sophos;i="6.15,247,1739836800"; 
   d="scan'208";a="14492000"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 01:21:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:26008]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id d49f810d-507d-44aa-8b15-f206d11125a2; Tue, 29 Apr 2025 01:21:03 +0000 (UTC)
X-Farcaster-Flow-ID: d49f810d-507d-44aa-8b15-f206d11125a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 01:21:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.170.247) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 01:20:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yi1.lai@linux.intel.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <yi1.lai@intel.com>
Subject: Re: [PATCH v3 net-next 03/15] ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
Date: Mon, 28 Apr 2025 18:20:36 -0700
Message-ID: <20250429012052.58601-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aBAcKDEFoN/LntBF@ly-workstation>
References: <aBAcKDEFoN/LntBF@ly-workstation>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Lai, Yi" <yi1.lai@linux.intel.com>
Date: Tue, 29 Apr 2025 08:24:08 +0800
> Hi Kuniyuki Iwashima,
> 
> Greetings!
> 
> I used Syzkaller and found that there is KASAN: use-after-free Read in ip6_route_info_create in linux-next tag - next-20250428.
> 
> After bisection and the first bad commit is:
> "
> fa76c1674f2e ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250429_005622_ip6_route_info_create/bzImage_33035b665157558254b3c21c3f049fd728e72368
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250429_005622_ip6_route_info_create/33035b665157558254b3c21c3f049fd728e72368_dmesg.log
> 
> "
> [   17.307248] ==================================================================
> [   17.307611] BUG: KASAN: slab-use-after-free in ip6_route_info_create+0xb84/0xc30
> [   17.307993] Read of size 1 at addr ffff8880100b8a94 by task repro/727
> [   17.308291] 
> [   17.308389] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.15.0-rc4-next-20250428-33035b665157 #1 PREEMPT(voluntary) 
> [   17.308397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   17.308405] Call Trace:
> [   17.308412]  <TASK>
> [   17.308414]  dump_stack_lvl+0xea/0x150
> [   17.308439]  print_report+0xce/0x660
> [   17.308469]  ? ip6_route_info_create+0xb84/0xc30
> [   17.308475]  ? kasan_complete_mode_report_info+0x80/0x200
> [   17.308482]  ? ip6_route_info_create+0xb84/0xc30
> [   17.308489]  kasan_report+0xd6/0x110
> [   17.308496]  ? ip6_route_info_create+0xb84/0xc30
> [   17.308504]  __asan_report_load1_noabort+0x18/0x20
> [   17.308509]  ip6_route_info_create+0xb84/0xc30
> [   17.308516]  ip6_route_add+0x32/0x320
> [   17.308524]  ipv6_route_ioctl+0x414/0x5a0

Thanks for the report.

It seems I accidentally removed validation from the ioctl path,
not sure why I missed the path...

Will post a fix soon.

