Return-Path: <netdev+bounces-178050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A5A7423F
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 03:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0C01895344
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F1D20DD49;
	Fri, 28 Mar 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YEVEFI7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C713D89D;
	Fri, 28 Mar 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743128545; cv=none; b=EkqmNOhE09kH5DRifMbH9USERfTKRKU/d6GrscFlf7vdQ5mXTOq5shFxLxYmaq9KFsLxmDC/Tvn1wBkJHP9m63vX6+9mbRdRwW6JPy8m7C0kTHMXd/2U4sahJXk4jaoFVPK6e379y2s/Bvd6OSh6Obb9QwzTGLCAx8qFYHBv7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743128545; c=relaxed/simple;
	bh=rzOiPlsw0Ze9Jrg8kR08chKDFfn1EOEud685m8doOZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIhBE9ku9OZ+QTOb+LTN5BTBBp0w68n2cQNK/CKPC0F1vOvs48VqDLYMxU86xdVsYDtUoAbt7ZLCN32bK2QPMDmH2ao7ah27B7abqTEQk1P7sHSz8pUvtO9lKsPotFmstSXO20ncUFIgHJ7fX/4eZOgBs4H9iVjmIhDsTdyaODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YEVEFI7I; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743128544; x=1774664544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwI/xbbicptm+UYjp+Km1RDmkr0i6xne+jGkYZTwAPQ=;
  b=YEVEFI7IfLp+PFwSMUmKng+QLDIVB3DQ6vzAFPldklm++CDaGhXg27m8
   ijvyUCE4Ar50iPP2Nijte2nTi7Z+ePi9KeDJJ7mgOe4BVe4YTevie0ytY
   vLKsrWAFjPBavAay2gBnl1dJm33JwLLvRq4cZK+ywdzyMZyHx9oX5vLdL
   4=;
X-IronPort-AV: E=Sophos;i="6.14,282,1736812800"; 
   d="scan'208";a="5251929"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 02:22:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:56542]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id 0304003b-c2ed-4bc2-ab57-3e91635583f7; Fri, 28 Mar 2025 02:22:18 +0000 (UTC)
X-Farcaster-Flow-ID: 0304003b-c2ed-4bc2-ab57-3e91635583f7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:22:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:22:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <i.abramov@mt-integration.ru>
CC: <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
	<ebiederm@xmission.com>, <edumazet@google.com>, <horms@kernel.org>,
	<jdamato@fastly.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<leitao@debian.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
Subject: Re: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in __dev_change_net_namespace()
Date: Thu, 27 Mar 2025 19:15:00 -0700
Message-ID: <20250328022204.12804-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328011302.743860-1-i.abramov@mt-integration.ru>
References: <20250328011302.743860-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)


> Subject: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in __dev_change_net_namespace()

s/__dev_change_net_namespace/netif_change_net_namespace/

Also, please specify the target tree: [PATCH v2 net]


From: Ivan Abramov <i.abramov@mt-integration.ru>
Date: Fri, 28 Mar 2025 04:12:57 +0300
> It's pointless to call WARN_ON() in case of an allocation failure in
> device_rename(), since it only leads to useless splats caused by deliberate
> fault injections, so avoid it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 8b41d1887db7 ("[NET]: Fix running without sysfs")

Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000a45a92061ce6cc7d@google.com/


> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2f7f5fd9ffec..14726cc8796b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12102,7 +12102,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,

It applies cleanly but please make sure to use the latest tree.



>  	dev_set_uevent_suppress(&dev->dev, 1);
>  	err = device_rename(&dev->dev, dev->name);
>  	dev_set_uevent_suppress(&dev->dev, 0);
> -	WARN_ON(err);
> +	WARN_ON(err && err != -ENOMEM);
>  
>  	/* Send a netdev-add uevent to the new namespace */
>  	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> -- 
> 2.39.5

