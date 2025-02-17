Return-Path: <netdev+bounces-167102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B6A38D55
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F05C1892901
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2C237180;
	Mon, 17 Feb 2025 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sBdwt6Yc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35F19048F
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824641; cv=none; b=VYnXMKchrp3R4SkUyqXsroqLlYWld3H872WwEtFbKkvJcHZFkax/ApurQnE8qNy9m6o9pOnkY+btmow5g+OMB0qdD2CRJqm9/mOSbkUSANMx+kOVDnqhMlBnxHOWSR09QHGvGB8aKPIe6wMXI76irELooZizBfqISDLTVRtH52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824641; c=relaxed/simple;
	bh=fbtrWepBvYJmYh7bI8ACw5NWoymKRiYD05/aHLZPDzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UyCbOa3cova23ZVF/ZmUzBSYxgnxoRyX6CZP33s9FY4jz9ELQXx9q5DnyqiJHoKxYI9WxqDuaNRrR0/ujBoCo8Y8yutDje0URlHOHfPetU7QzcpG6+WyQ8bQEq95C9clpoEErNpFQjOgMNQOVM2mgdyAlwj3U68GkPXCEqtfGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sBdwt6Yc; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739824640; x=1771360640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YxIc/RcBtsHpuuU1tx05UJTiTNiVcn7H+xxRk+GQNq4=;
  b=sBdwt6YcLRIUBhITCUXY/5w2Jbz74PgfPO2loLv5cKcj1YClZCpvLnpB
   NrSn++XiBSQ7Fys7qz+6Yfwo1Vg2T4HTAB+SsNxW/yXIAeY7aNqlzaRkQ
   EMF7e3wmU+t3VWNp6aMI15fGG9ei0fFzX+lrloL1P98B2E8l4n9fES05/
   o=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="170508418"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 20:37:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:22776]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.150:2525] with esmtp (Farcaster)
 id c7b469fc-3469-428e-b349-cf7c123cb2bd; Mon, 17 Feb 2025 20:37:18 +0000 (UTC)
X-Farcaster-Flow-ID: c7b469fc-3469-428e-b349-cf7c123cb2bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 20:37:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 20:37:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Brad Spengler <spender@grsecurity.net>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/2] gtp/geneve: Suppress list_del() splat during ->exit_batch_rtnl().
Date: Mon, 17 Feb 2025 12:37:03 -0800
Message-ID: <20250217203705.40342-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The common pattern in tunnel device's ->exit_batch_rtnl() is iterating
two netdev lists for each netns: (i) for_each_netdev() to clean up
devices in the netns, and (ii) the device type specific list to clean
up devices in other netns.

	list_for_each_entry(net, net_list, exit_list) {
		for_each_netdev_safe(net, dev, next) {
			/* (i)  call unregister_netdevice_queue(dev, list) */
		}

		list_for_each_entry_safe(xxx, xxx_next, &net->yyy, zzz) {
			/* (ii) call unregister_netdevice_queue(xxx->dev, list) */
		}
	}

Then, ->exit_batch_rtnl() could touch the same device twice.

Say we have two netns A & B and device B that is created in netns A and
moved to netns B.

  1. cleanup_net() processes netns A and then B.

  2. ->exit_batch_rtnl() finds the device B while iterating netns A's (ii)

  [ device B is not yet unlinked from netns B as
    unregister_netdevice_many() has not been called. ]

  3. ->exit_batch_rtnl() finds the device B while iterating netns B's (i)

gtp and geneve calls ->dellink() at 2. and 3. that calls list_del() for (ii)
and unregister_netdevice_queue().

Calling unregister_netdevice_queue() twice is fine because it uses
list_move_tail(), but the 2nd list_del() triggers a splat when
CONFIG_DEBUG_LIST is enabled.

Possible solution is either of

 (a) Use list_del_init() in ->dellink()

 (b) Iterate dev with empty ->unreg_list for (i) like

	#define for_each_netdev_alive(net, d)				\
		list_for_each_entry(d, &(net)->dev_base_head, dev_list)	\
			if (list_empty(&d->unreg_list))

 (c) Remove (i) and delegate it to default_device_exit_batch().

This series avoids the 2nd ->dellink() by (c) to suppress the splat for
gtp and geneve.

Note that IPv4/IPv6 tunnels calls just unregister_netdevice() during
->exit_batch_rtnl() and dev is unlinked from (ii) later in ->ndo_uninit(),
so they are safe.

Also, pfcp has the same pattern but is safe because
unregister_netdevice_many() is called for each netns.


Kuniyuki Iwashima (2):
  gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
  geneve: Suppress list corruption splat in geneve_destroy_tunnels().

 drivers/net/geneve.c | 7 -------
 drivers/net/gtp.c    | 5 -----
 2 files changed, 12 deletions(-)

-- 
2.39.5 (Apple Git-154)


