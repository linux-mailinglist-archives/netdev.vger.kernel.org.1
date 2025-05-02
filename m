Return-Path: <netdev+bounces-187361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E59AA684E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77E817FEC3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54611CD3F;
	Fri,  2 May 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k46JRcTa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E871EEE6;
	Fri,  2 May 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148568; cv=none; b=lL08RwSeE13pXRNie92xo/1T4caOH5LoErqfFodQZTHuPoBZOKHVODXNn8CTAJHpnX7O4LVMj1EFRea7Qek3YCczGtr/WstSqUMpiL6t52zNQMUc4eWcLNlMOlYMhFfZO1W9zytqSApCf89GDvtxhCPfw/eW75blfLlJSeIo5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148568; c=relaxed/simple;
	bh=KKUucRsq7J/KTfh1cyQk5FctIMDkTamHhSf2mp3C8lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOXHSlctSasV1pgcb9bBDC5MTdLuQN6/Jvk+dBrpKAitdteoJA+Z0iG5lKTKN5y/X7ekW/8/3dPT477S/n771XzK2MhZAcTFI4g/tFxWq8rRJMqOJPFj2xP0i0xSFT3HKvwweitfsu3CfyEV+sO5x0q1B5VLTuDqHiEh0qSjDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k46JRcTa; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746148567; x=1777684567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8qrr7k4O1a2fqkvBoS4P4GlOV9v1wWvQtczvCq40s8=;
  b=k46JRcTa5YnjouKg40amKiINGZQgw2/qJ/8Jw/NAno+2SOdQtx2a+9CP
   QxK4+kBAgwNmuuzAncbN78cuv3sirNzBgiwqBMyQrBfqeHIWYPo6/K6Sw
   XUrToRw0xiIo/TMJNbCEKzGfWD5T/pPd9LrbOmx/y8SomxheqYhNEaJCK
   8=;
X-IronPort-AV: E=Sophos;i="6.15,255,1739836800"; 
   d="scan'208";a="740689088"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 01:16:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:34805]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.6:2525] with esmtp (Farcaster)
 id 9238b5d2-9583-4e05-8620-1900c65421ad; Fri, 2 May 2025 01:16:01 +0000 (UTC)
X-Farcaster-Flow-ID: 9238b5d2-9583-4e05-8620-1900c65421ad
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 01:16:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 01:15:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <elver@google.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <kees@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8f8024317adff163ec5a@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in ip6_rt_copy_init
Date: Thu, 1 May 2025 18:15:28 -0700
Message-ID: <20250502011550.66510-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <e1e1fa75-e9c2-4ae7-befb-f3910a349a9f@kernel.org>
References: <e1e1fa75-e9c2-4ae7-befb-f3910a349a9f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Ahern <dsahern@kernel.org>
Date: Thu, 1 May 2025 14:44:03 -0600
> On 5/1/25 2:12 PM, Kees Cook wrote:
> > static int ip6_rt_type_to_error(u8 fib6_type)
> > {
> >         return fib6_prop[fib6_type];
> > }
> > 
> > Perhaps some kind of type confusion, as this is being generated through
> > ip6_rt_init_dst_reject(). Is the fib6_type not "valid" on a reject?
> 
> fib6_result is initialized to 0 in ip6_pol_route and no setting of
> fib6_type should be > RTN_MAX.
> 
> > 
> > The reproducer appears to be just absolutely spamming netlink with
> > requests -- it's not at all obvious to me where the fib6_type is even
> > coming from. I think this is already only reachable on the error path
> > (i.e. it's during a "reject", it looks like), so the rt->dst.error is
> > just being set weird.
> > 
> > This feels like it's papering over the actual problem:
> 
> yes, if fib6_type is > than RTN_MAX we need to understand where that is
> happening.

Sorry, I think this was my mistake,
https://lore.kernel.org/netdev/20250502002616.60759-1-kuniyu@amazon.com/T/#t

and this will fix it.
https://lore.kernel.org/netdev/20250501005335.53683-1-kuniyu@amazon.com/

Thanks!


#syz dup: [syzbot] [net?] WARNING in ipv6_addr_prefix

