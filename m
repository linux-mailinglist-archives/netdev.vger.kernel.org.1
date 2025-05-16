Return-Path: <netdev+bounces-190926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D0AB9438
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C974B1B683A3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D313022DA06;
	Fri, 16 May 2025 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="h6UrwwN3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869915530C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747364423; cv=none; b=DJzkAmFjTlHetNwMQAgeQSJUy9ZyH8B0cS8L5l5SirBRnoQwbX19SN0Wc2CH4FmkVb+Fiz3D9GM/kS7hY8iRsVXzSxNnkDbVD75fWE8JutZGzURfLgrVZa2Wm6GLAZM6IjNdnkKj362iBhAD66x65ZTdaOcThcEOlMsHkNglYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747364423; c=relaxed/simple;
	bh=/YmCyjYWpyZ7QGddkSz9RO0FyYpkF/vHpMSBs3pkCXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQORt5m/Xd8ZaDFjJ7CIyOsUlgLzReleZizz0Ak1rcXPVH8MdcVZFz6b8GO27wZLcCdwOJarDhrRVqYIEXThEMQG+J3jM/d3EHL2q/F0tvRELWheufkkEacJWWuy11fEZsqjL000DGBet2daKF84j0I+08N3bozdKZ2koPeg1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=h6UrwwN3; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747364422; x=1778900422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lSD0fXgYLvX/Th5DdMUsnxmpRY8a/IsE+pN0G0I5ID8=;
  b=h6UrwwN3LQdmoZfnmJ7b728Gn0ARtqby+YCccChglTzNDEpTN9WXvSXR
   I4h4mbFoVofpQ6JW6DV3vnEARGurKtSek/atZlhf5Onv7xJnsj4k0nARc
   rTH6VHl10HsyWQV/0wkk7iopoRIXeH+HeI481e2cxQ/ZDiDbyFLlIARdN
   E/cHXjhBBOrmwreB+Kv8p5Q/sJfdwPiGx9Dtu0XG1B7Ymr5el45nUOZwD
   XcygCYo6FIxNtJ1czd7u4KrLwZEalT3yFN3WtLIUs8QqguUAQYYELITpU
   HivPGbGfOBL287NFa3BwlB8Rg6RTB38NYYPLuBjZxBsxzMIl5Ov0D21G4
   g==;
X-IronPort-AV: E=Sophos;i="6.15,293,1739836800"; 
   d="scan'208";a="50481360"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 03:00:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:50116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id f9169bd9-b1b5-4f33-a14d-3de9b41fdcc0; Fri, 16 May 2025 03:00:10 +0000 (UTC)
X-Farcaster-Flow-ID: f9169bd9-b1b5-4f33-a14d-3de9b41fdcc0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 03:00:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 03:00:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Date: Thu, 15 May 2025 19:59:41 -0700
Message-ID: <20250516030000.48858-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515193609.3da84ac3@kernel.org>
References: <20250515193609.3da84ac3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 15 May 2025 19:36:09 -0700
> On Thu, 15 May 2025 18:49:07 -0700 Kuniyuki Iwashima wrote:
> > > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > > +	/* It's okay to use per-netns rtnl_lock if devices share netns */
> > > +	if (net_eq(dev_net(dev_a), dev_net(dev_b)) &&
> > > +	    lockdep_rtnl_net_is_held(dev_net(dev_a)))  
> > 
> > Do we need
> > 
> >   !from_cleanup_net()
> > 
> > before lockdep_rtnl_net_is_held() ?
> > 
> > __rtnl_net_lock() is not held in ops_exit_rtnl_list() and
> > default_device_exit_batch() when calling unregister_netdevice_many().
> 
> Or do we need
> 
>   if (from_cleanup_net())
>   	return -1;
> 
> ?

Ah right, otherwise we'll return 1 for cleanup_net() :)


> Is the thinking that once the big rtnl lock disappears in cleanup_net
> the devices are safe to destroy without any locking because there can't
> be any live users trying to access them?

I hope yes, but removing VF via sysfs and removing netns might
race and need some locking ?

