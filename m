Return-Path: <netdev+bounces-174688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937AA5FEAD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EB719C449F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CC1E51EE;
	Thu, 13 Mar 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eI9yPqdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668F15DBC1;
	Thu, 13 Mar 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888582; cv=none; b=QSlkbepSohYXPLVWUf8td/i8cf7n8v/NO8ib83v/BhQTva/goIZ+qlzpospAPbzCBEO/7LIQXEAk8O6R95byeNbnvNsXqY/+5rj3UrWI5ijpHheNqQJEd1rKurm3qRlWTbP7rVe9y/vanBz/wR04vA5CWLZESdHiV+gVngzZCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888582; c=relaxed/simple;
	bh=eKGeJ/7PkvBa4gfMByuavEkwT81cYgPP5CC5AR6prxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su9ynNtZm75rqRSiA+3IVkn7JFwFy0XpIuNxlCCHcHBTQmS3COxJ/I+ugDs6TS3bZQE64IpRcm0kkNdz2OVPhbpyKkQbbIEZ+c/6tVLBkMNARLHHon0/hMVTXitUHtbHlGLzw1HeW7pUDaFIQ2uSA4gmDGwKDgEYiOqaMzDKo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eI9yPqdT; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741888581; x=1773424581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7PC9O0Oe+JtOuUKRMpYKPaCohfXryNIVIN9579z+1U=;
  b=eI9yPqdTOaw45c7llHzzvA3vd5shN2nhlZqmr+eMLTA0gpOGB7lHzMVR
   VkRN7sJmAxgTWd/VnaUbasJ19rxI0xJ2+uTLRebhB+5UWeDl76plg2aT+
   NYEAJ/OFHDf4UPEcGEjlj74R8HqHsgQRMDcCgdCyh8KyJzdsAKbQ3NVJu
   o=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="470861813"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:56:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:45090]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.243:2525] with esmtp (Farcaster)
 id 4e61084a-f171-486c-b205-4f509d0bffc1; Thu, 13 Mar 2025 17:56:16 +0000 (UTC)
X-Farcaster-Flow-ID: 4e61084a-f171-486c-b205-4f509d0bffc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 17:56:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.242.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 17:56:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sdf@fomichev.me>
CC: <andrew+netdev@lunn.ch>, <atenart@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jasowang@redhat.com>, <jdamato@fastly.com>, <kory.maincent@bootlin.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: reorder dev_addr_sem lock
Date: Thu, 13 Mar 2025 10:56:00 -0700
Message-ID: <20250313175603.17045-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312190513.1252045-3-sdf@fomichev.me>
References: <20250312190513.1252045-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <sdf@fomichev.me>
Date: Wed, 12 Mar 2025 12:05:13 -0700
> Lockdep complains about circular lock in 1 -> 2 -> 3 (see below).
> 
> Change the lock ordering to be:
> - rtnl_lock
> - dev_addr_sem
> - netdev_ops (only for lower devices!)
> - team_lock (or other per-upper device lock)
> 
> 1. rtnl_lock -> netdev_ops -> dev_addr_sem
> 
> rtnl_setlink
>   rtnl_lock
>     do_setlink IFLA_ADDRESS on lower
>       netdev_ops
>         dev_addr_sem
> 
> 2. rtnl_lock -> team_lock -> netdev_ops
> 
> rtnl_newlink
>   rtnl_lock
>     do_setlink IFLA_MASTER on lower
>       do_set_master
>         team_add_slave
>           team_lock
>             team_port_add
> 	      dev_set_mtu
> 	        netdev_ops
> 
> 3. rtnl_lock -> dev_addr_sem -> team_lock
> 
> rtnl_newlink
>   rtnl_lock
>     do_setlink IFLA_ADDRESS on upper
>       dev_addr_sem
>         netif_set_mac_address
>           team_set_mac_address
>             team_lock
> 
> 4. rtnl_lock -> netdev_ops -> dev_addr_sem
> 
> rtnl_lock
>   dev_ifsioc
>     dev_set_mac_address_user
> 
> __tun_chr_ioctl
>   rtnl_lock
>     dev_set_mac_address_user
> 
> tap_ioctl
>   rtnl_lock
>     dev_set_mac_address_user
> 
> dev_set_mac_address_user
>   netdev_lock_ops
>     netif_set_mac_address_user
>       dev_addr_sem
> 
> v2:
> - move lock reorder to happen after kmalloc (Kuniyuki)

My intention was move kmalloc() and memcpy() out of both
netdev_lock and dev_addr_sem like

  netdev_ops_unlock()
  kmalloc()
  memcpy()
  down_write()

, but not a big deal :)

> 
> Cc: Kohei Enju <enjuk@amazon.com>
> Fixes: df43d8bf1031 ("net: replace dev_addr_sem with netdev instance lock")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

