Return-Path: <netdev+bounces-161579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B3A22752
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F6A16439F
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7928E8;
	Thu, 30 Jan 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ut/QGMNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3AA93D
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198207; cv=none; b=YY1cDdvwr0S+9RpdYjjLTB5kJqkS4Ni6zSbEqY8FUW6n2iYHMVEUo84d52hgqucXc/lGY1/4KuNE81ORZcoKHZsxqH2LVVzPp9pTvhP0Fto/Z9vVgdDmXQdAuIPUKq/e05TqaZ9KWWT5qKm0p/NQIcWpgwuArYFVEm4lITHZW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198207; c=relaxed/simple;
	bh=q87FzivC7LzamAPEhkzNxZrwGt4LKWzrCo7Go0OqhK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWOlIBsISeebnCW5et1G+AyGXlLXoAzIoQymeZrAzd5GUyoL0eYjri2bJ9PrpF0mo415QX32qDNOUrv42dYX7XgcxtW3Ske5/cN8+og1jxYj07DJHOK1IdIgczPYTM0DwIkFkF6F4Zj6SwtdrTicQdJgmVmmtN0ipYdKPrkzHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ut/QGMNg; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738198205; x=1769734205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=17dl+EgAAZh+adCj61fZavYYac0XzhtYjvPLC3pIpnY=;
  b=ut/QGMNgLIO6JlJGbJzp2FBKcIUjGlDC4hYt9x9XL2ZQL85wdZbilTID
   OvQmOjy4R3mya0rUj3exS1ut19OCurWBeBy0DoqwqQvHWMjIhMb0e98sT
   rupzNlkrsL3GkyITKvVdleH0zvd/qVhRSA0bKTjeLdkc6gJT1BWcRTX8F
   w=;
X-IronPort-AV: E=Sophos;i="6.13,244,1732579200"; 
   d="scan'208";a="714607670"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:50:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:16563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id e5ea04d2-4c01-4b4a-a711-a7f066665134; Thu, 30 Jan 2025 00:50:01 +0000 (UTC)
X-Farcaster-Flow-ID: e5ea04d2-4c01-4b4a-a711-a7f066665134
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 00:49:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.76) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 00:49:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net] net: revert RTNL changes in unregister_netdevice_many_notify()
Date: Wed, 29 Jan 2025 16:49:41 -0800
Message-ID: <20250130004941.71433-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250129142726.747726-1-edumazet@google.com>
References: <20250129142726.747726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 14:27:26 +0000
> This patch reverts following changes:
> 
> 83419b61d187 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)
> ae646f1a0bb9 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)
> cfa579f66656 net: no longer hold RTNL while calling flush_all_backlogs()
> 
> This caused issues in layers holding a private mutex:
> 
> cleanup_net()
>   rtnl_lock();
> 	mutex_lock(subsystem_mutex);
> 
> 	unregister_netdevice();
> 
> 	   rtnl_unlock();		// LOCKDEP violation
> 	   rtnl_lock();
> 
> I will revisit this in next cycle, opt-in for the new behavior
> from safe contexts only.
> 
> Fixes: cfa579f66656 ("net: no longer hold RTNL while calling flush_all_backlogs()")
> Fixes: ae646f1a0bb9 ("net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)")
> Fixes: 83419b61d187 ("net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)")
> Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6789d55f.050a0220.20d369.004e.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

