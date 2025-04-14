Return-Path: <netdev+bounces-182508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF052A88F1D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC85216705C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339A1F460F;
	Mon, 14 Apr 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JN3DTeIO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68A1B0F3C;
	Mon, 14 Apr 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669781; cv=none; b=TiwEGZVoR/q7VAjKH2E3Um7+bHPXDrUJ5k5HhfFtkvUBG5jJKvrUEbqzqop1i7E0CFlrNST+M9IuPKK/bCY0bzh98A4UEGqOXcYwLBKzGFfFNSHIw8H+FCo8XKIeeOwpdyfduLUsId9crYX5gZjCkGEc045w2Ach1oDowkDCXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669781; c=relaxed/simple;
	bh=aWzFmrByEiQpHeFqUMLJWrw0YrAKBEXSIOzTMhlEszA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA8gN4MeI10ExILi9BDlVU1zYMN1qFl55CDVyzeBNilt/GwFITrsdQ5yz6TP5+KXt6ub0YQ9DU/zSa1/UKpUX3HAuCkmvea2WB3eZWuyJ7R60yP0Qs3q+xaC5VwdOLDLWOtbnKQ6I42zwk6HNOhzC0YX3x3RqyFBONECpRXcTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JN3DTeIO; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744669780; x=1776205780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aHHd5cv1PbgrN2FsZ3Kqs5/AxC5vUjD32/KdY+9chrU=;
  b=JN3DTeIOmY0BiGysd/I3pF84jgl0x593hegB5x/P8n2wkjOuOofBGnIP
   htf4KICA8AxQWFbXWxg70OBNXqxLzEOzTo8AUTzYE57MucUMzZouL/ki8
   0wbDa6Fb/ud5Qaz/1rgDki8Qhb/PPs6eiSBNuBGG+YYtufMCfuyfNaXq1
   A=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="40586871"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 22:29:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:35975]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id ce2f6dde-b6dc-4e42-a497-b74667ee2332; Mon, 14 Apr 2025 22:29:37 +0000 (UTC)
X-Farcaster-Flow-ID: ce2f6dde-b6dc-4e42-a497-b74667ee2332
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 22:29:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 22:29:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qasdev00@gmail.com>
Subject: Re: [PATCH 4/4] net: register debugfs file for net_device refcnt tracker
Date: Mon, 14 Apr 2025 15:27:36 -0700
Message-ID: <20250414222926.72911-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414-reftrack-dbgfs-v1-4-f03585832203@kernel.org>
References: <20250414-reftrack-dbgfs-v1-4-f03585832203@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Apr 2025 10:45:49 -0400
> As a nearly-final step in register_netdevice(), finalize the name in the
> refcount tracker, and register a debugfs file for it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..db9cac702bb2230ca2bbc2c04ac0a77482c65fc3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10994,6 +10994,8 @@ int register_netdevice(struct net_device *dev)
>  	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
>  		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
>  
> +	/* Register debugfs file for the refcount tracker */
> +	ref_tracker_dir_debugfs(&dev->refcnt_tracker, dev->name);

dev->name is not unique across network namespaces, so we should specify
a netns-specific parent dir here.

For example, syzkaller creates a bunch of devices with the same name in
different network namespaces.

Then, we also need to move the file when dev is moved to another netns
in __dev_change_net_namespace().

