Return-Path: <netdev+bounces-184207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B000A93BBA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8988A6B7D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594492192F5;
	Fri, 18 Apr 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eN7Jk0Er"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8B211488
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996442; cv=none; b=ZtVqf7bYbe0kZneuQaTbpRhSs44JBvhLRz10L5k3Z99T9bR83ywGMLAwpM46wcKz2i1lgLzfydud50pxoMFVFnut2YpeQ+aHyXd5VWfPDdNgg/WwX0lx4r8032b0OHL7YyTu6KDXTO3lK6Up4hIN/Yr3xlyDI9rGjRarcszoX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996442; c=relaxed/simple;
	bh=zPKeyHniYNkOPB+2bH06/ED/zQHPjR8lfcY0+xttLIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJwMEG1V8/n6pmXlbqGLw2J08sSnp1cH7a9Vz6wZHplITtpBoKhgVN7GuOpSE5ZNnwByDoyLJIl/AknRI9JIgNcKouZgYKTjHkRrEu6CsAezkmPywZMVdItXMDXIMr5skdu9IrH2nz24h4GZGwAY69YZlUl85eLNRNA3NhNqa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eN7Jk0Er; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744996441; x=1776532441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=foVGha7p16WO5mIoE3jkwlTns2wstUeX1CtXhojDDck=;
  b=eN7Jk0Er5bLecVyMW0QWT7z8ZovVasui6m24CCEVWyZHXbzHjVKMWhPj
   PbDeirzXslhuAMUp2OIbY2vTddMD6AD+wAKwxbeLVTl97ZY4AM23IPdrs
   yi0UbpDyZKU59YGzEQG4EmmJqHCh7+ReGjdU0rpNKzboF+Vda3wjOkiU/
   c=;
X-IronPort-AV: E=Sophos;i="6.15,222,1739836800"; 
   d="scan'208";a="484260669"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 17:13:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:4353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.238:2525] with esmtp (Farcaster)
 id 2277e60c-a330-4de9-adbf-739b24250540; Fri, 18 Apr 2025 17:13:56 +0000 (UTC)
X-Farcaster-Flow-ID: 2277e60c-a330-4de9-adbf-739b24250540
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 17:13:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 17:13:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <oliver.sang@intel.com>
CC: <kuba@kernel.org>, <kuniyu@amazon.com>, <lkp@intel.com>,
	<netdev@vger.kernel.org>, <oe-lkp@lists.linux.dev>, <sd@queasysnail.net>
Subject: Re: [linux-next:master] [net]  fed176bf31: KASAN:maybe_wild-memory-access_in_range[#-#]
Date: Fri, 18 Apr 2025 10:13:40 -0700
Message-ID: <20250418171345.26684-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <202504181511.1c3f23e4-lkp@intel.com>
References: <202504181511.1c3f23e4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: kernel test robot <oliver.sang@intel.com>
Date: Fri, 18 Apr 2025 16:16:51 +0800
> Hello,
> 
> kernel test robot noticed "KASAN:maybe_wild-memory-access_in_range[#-#]" on:
> 
> commit: fed176bf3143362ac9935e3964949ab6a5c3286b ("net: Add ops_undo_single for module load/unload.")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 5b37f7bfff3b1582c34be8fb23968b226db71ebd]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-102-20250415
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202504181511.1c3f23e4-lkp@intel.com
> 
> 
> [   26.592836][    T1]     audit=0
> [   26.593311][    T1]     riscv_isa_fallback=1
> [   26.685729][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
> [   26.694368][    T1] systemd[1]: Failed to find module 'autofs4'
> [   26.766891][    T1] NET: Registered PF_INET6 protocol family
> [   26.767880][    T1] Oops: general protection fault, probably for non-canonical address 0xf999959999999999: 0000 [#1] KASAN
> [   26.769508][    T1] KASAN: maybe wild-memory-access in range [0xccccccccccccccc8-0xcccccccccccccccf]

It reproduced with NET_NS=n.

During boot, first_device->{prev,next} are suddenly changed to
0xcccccccccccccccc, which looks confusing but it was due to
__net_initdata added to struct pernet_operations.

I'll post a fix.

Thanks for the report!

