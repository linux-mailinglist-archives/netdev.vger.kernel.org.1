Return-Path: <netdev+bounces-142043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE79BD321
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53301F232B8
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FC91DF25F;
	Tue,  5 Nov 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="USTvjIOd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD61DD86F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826707; cv=none; b=YgEFeWYeT/P/8kCf4uaAPJxDxvk5Ji59MiyfqZUcCOqwcfso8zAPuk6yNbvxKTNMyDekeMqTayfhExWl7gapSyab3ZZ4k27zp26FlVG+QYWNLPOPRMx66w0vA6nLx/SCSbaHq0O6XxaY8RlC6Mmh4S1IqtH4qiK56bjRLmr6loU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826707; c=relaxed/simple;
	bh=xStPE9cAbGNMgvEitsZocVXWtN5jBSPMoTgJZjhA8+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyvvI9HS1/TB2mhZkUhxK/UXnFBXsHEEZUGAsJorfXo5dIA677VoTpgiMr6k86Ab79t8AxAE4DI6RtNJxTMQzejoWTh5t8k62SizR3rOYDtFozDafQyD9gKeM/xOepwhslPckFW0YsJdnP6b8PkaNunNg0H7nidxHtaOytRlzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=USTvjIOd; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730826705; x=1762362705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zhd9znDS72CmDGAp9x3PUyJGT5SrzywblKBrtATZ1pw=;
  b=USTvjIOdonTTwigRoplXAl2vNCL0GX23x8YuavuGYJKA1cW4Qrg6amY5
   pNCQRPTC9Kn5egEA1WIg9by/HU4ib6hIMDykodLW7arpZRSZpMgjIJr9C
   EXmqspWw95QyWOFDLqFd5Hw3VvWh/0Ayhj5Sxxj56xNU96lzBlf/b9yc3
   E=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; 
   d="scan'208";a="671820085"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:11:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:41703]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.170:2525] with esmtp (Farcaster)
 id 6f8c8367-189c-4839-95bb-aedd53b9c2de; Tue, 5 Nov 2024 17:11:41 +0000 (UTC)
X-Farcaster-Flow-ID: 6f8c8367-189c-4839-95bb-aedd53b9c2de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 17:11:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 17:11:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>,
	<mkl@pengutronix.de>, <netdev@vger.kernel.org>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 7/8] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
Date: Tue, 5 Nov 2024 09:11:35 -0800
Message-ID: <20241105171135.41014-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <36a5e3a0-258e-4771-905b-227b74fbe5fe@redhat.com>
References: <36a5e3a0-258e-4771-905b-227b74fbe5fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 5 Nov 2024 17:22:54 +0100
> On 11/5/24 03:05, Kuniyuki Iwashima wrote:
> > @@ -6995,7 +7017,8 @@ static struct pernet_operations rtnetlink_net_ops = {
> >  };
> >  
> >  static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
> > -	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
> > +	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
> > +	 .flags = RTNL_FLAG_DOIT_PERNET},
> 
> The above causes a lockdep splat in many selftests:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/846801/12-bareudp-sh/stderr
> 
> the problem is in rtnl_newlink():
> 
> #ifdef CONFIG_MODULES
>                 if (!ops) {
>                         __rtnl_unlock();
> // we no more under the rtnlock
>                         request_module("rtnl-link-%s", kind);
>                         rtnl_lock();
>                         ops = rtnl_link_ops_get(kind, &ops_srcu_index);
>                 }
> #endif

Oh, somehow I dropped this part of change while rebasing the RFC version...
https://github.com/q2ven/linux/commit/fea4b46993e8802e6dd7341d6e7dd49396e378d1

Will remove the unlock dance in v2.

Thanks!

