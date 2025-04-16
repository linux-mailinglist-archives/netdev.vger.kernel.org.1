Return-Path: <netdev+bounces-183095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB0A8ADBE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F187A3A88
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1580839F4;
	Wed, 16 Apr 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AEIfOrvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649A2F4A;
	Wed, 16 Apr 2025 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768870; cv=none; b=N50FSYZ4uju0yM+8jiz7MisqJ033OZcrqHfg9XSB2it6ZX0kcn7i5tRR2iYNWH9BjfyJaxwa8LwFeSKQrBB3GOKgqr+fxR8rB7UrMiq7EmiPy+srzvihcMQpjz7CYQS4Bh42Og00E2Ei7OpBFTtcJ7ZKtVZFm8BHG5hxN2ODYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768870; c=relaxed/simple;
	bh=Pf2LKi0jUPQSsag6B/3tXrNvfH1savDCKntsBm2CJnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My4RwrpozNrC7hkWpJPCCj5iN4KKQj8QTBqsmxl3ibRnh29WCu2BreOV+QkaUYbi4nIC2sfhWUN5GqxVtFMUkAiqSSd0rbZKGBdTSolZLh8h/z0Xin7aej3NIsIdX/Ks1vQ+UAdnIpLT2X+xai97g5OyYMLdlS0NfHNbkjkf27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AEIfOrvK; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744768870; x=1776304870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SWh0jclUiH92rVpdBu9Ng4+uW+N+QTKR3xZcsyP1IOY=;
  b=AEIfOrvKOnP6+9CCdVlv2Z5uz6YWBtPJzDEYvMEwYQpY801JBqRWBjki
   06R4uiiYvqDBMqS6xBMGq2F9NVM4Tbw2UxuXi7luEt0iDRFhOTsQwRUL8
   uKBejovl4Dtu4i1bGEaspr7mBHJ6lFkNiVdOmdubetGBCGd75SGLbc3lJ
   w=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="84030321"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:01:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:61493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id a3f0f012-9c8c-4f2b-8476-0e7e2fbd22f5; Wed, 16 Apr 2025 02:01:04 +0000 (UTC)
X-Farcaster-Flow-ID: a3f0f012-9c8c-4f2b-8476-0e7e2fbd22f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:01:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:00:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qasdev00@gmail.com>
Subject: Re: [PATCH v2 8/8] net: register debugfs file for net_device refcnt tracker
Date: Tue, 15 Apr 2025 19:00:36 -0700
Message-ID: <20250416020052.37588-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-reftrack-dbgfs-v2-8-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-8-b18c4abd122f@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:46 -0400
> As a nearly-final step in register_netdevice(), finalize the name in the
> refcount tracker, and register a debugfs file for it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/core/dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..a87488e127ed13fded156023de676851826a1a8f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10834,8 +10834,9 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
>   */
>  int register_netdevice(struct net_device *dev)
>  {
> -	int ret;
>  	struct net *net = dev_net(dev);
> +	char name[64];
> +	int ret;
>  
>  	BUILD_BUG_ON(sizeof(netdev_features_t) * BITS_PER_BYTE <
>  		     NETDEV_FEATURE_COUNT);
> @@ -10994,6 +10995,9 @@ int register_netdevice(struct net_device *dev)
>  	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
>  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
>  
> +	/* Register debugfs file for the refcount tracker */
> +	if (snprintf(name, sizeof(name), "netdev-%s@%p", dev->name, dev) < sizeof(name))

Given IFNAMSIZ is 16, using WARN_ON_ONCE() and calling
ref_tracker_dir_debugfs() unconditionally would be better
to catch future regression with syzbot.

Also, this hunk conflicts with

commit 097f171f98289cf737437599c40b0d1e81266e9e
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Wed Apr 9 18:42:46 2025 -0700

    net: convert dev->rtnl_link_state to a bool


> +		ref_tracker_dir_debugfs(&dev->refcnt_tracker, name);
>  out:
>  	return ret;
>  
> 
> -- 
> 2.49.0

