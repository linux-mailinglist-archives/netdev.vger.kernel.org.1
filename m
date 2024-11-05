Return-Path: <netdev+bounces-141807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B339BC4B9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B9B2140E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C31802AB;
	Tue,  5 Nov 2024 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B0UgE1e/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EE1172A
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784695; cv=none; b=iB5mIOC2FU6NHrAz1BysccQj4Eh8KQjbepefMdlprz0tYW8Y6UMTAFb8r63NqBk4WRoUrPDjsk6NaSjVaOGlbDl5qFV20LgUeVWUc7f6CJROascbnVsXOylPDyvNAp+FEcel7A+pEa+YnNGStCJIugb/HnzLqtaX9tDajgz5HJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784695; c=relaxed/simple;
	bh=rkdEMVIk/T2r1mnaoJ8zjFa7YrN1QuxAPW6f9NnP6X8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PY1YNjINXRGGiX6unvshv29APMJPVFF33XmHu3HFEEz7f6WWXG0Kj/4Turt0ISW1CkxIg85g4vGmVZGOgCNkFBfapKcQJzDOoZBrUbSX15Bqjbaatyb1OKnnBO4Pm2pgk+0Mp7l7YM41eScP3gtkqg644wmeJbHpXuBCqRHe5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B0UgE1e/; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730784694; x=1762320694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kqyE3v67BtJ2rU8tNAxwePI0JoQmPiMzDBdgBHDevQ=;
  b=B0UgE1e/yrCgq4aE/01aFotrwzJB5GbZarcmoZezivpcWofaef3CVM7a
   KfJA5keEpDUl29aMVBZo5bbhUc5kj0AJzo/uqo0ErVMPka4xZpuNow/4A
   LeFEFSIhukMmk8RnjFzbTeyBG3zbBs5k3VcqIzAZykjOOvCi6cisoTWdQ
   s=;
X-IronPort-AV: E=Sophos;i="6.11,259,1725321600"; 
   d="scan'208";a="437240984"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 05:31:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:7761]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.16:2525] with esmtp (Farcaster)
 id 203112fc-e3e0-443f-95be-9f6e8a6d3a63; Tue, 5 Nov 2024 05:31:29 +0000 (UTC)
X-Farcaster-Flow-ID: 203112fc-e3e0-443f-95be-9f6e8a6d3a63
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 05:31:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 05:31:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <johannes@sipsolutions.net>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pablo@netfilter.org>,
	<syzkaller@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net 1/2] netlink: terminate outstanding dump on socket close
Date: Mon, 4 Nov 2024 21:31:15 -0800
Message-ID: <20241105053115.59273-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105010347.2079981-1-kuba@kernel.org>
References: <20241105010347.2079981-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon,  4 Nov 2024 17:03:46 -0800
> Netlink supports iterative dumping of data. It provides the families
> the following ops:
>  - start - (optional) kicks off the dumping process
>  - dump  - actual dump helper, keeps getting called until it returns 0
>  - done  - (optional) pairs with .start, can be used for cleanup
> The whole process is asynchronous and the repeated calls to .dump
> don't actually happen in a tight loop, but rather are triggered
> in response to recvmsg() on the socket.
> 
> This gives the user full control over the dump, but also means that
> the user can close the socket without getting to the end of the dump.
> To make sure .start is always paired with .done we check if there
> is an ongoing dump before freeing the socket, and if so call .done.
> 
> The complication is that sockets can get freed from BH and .done
> is allowed to sleep. So we use a workqueue to defer the call, when
> needed.
> 
> Unfortunately this does not work correctly. What we defer is not
> the cleanup but rather releasing a reference on the socket.
> We have no guarantee that we own the last reference, if someone
> else holds the socket they may release it in BH and we're back
> to square one.
> 
> The whole dance, however, appears to be unnecessary. Only the user
> can interact with dumps, so we can clean up when socket is closed.
> And close always happens in process context. Some async code may
> still access the socket after close, queue notification skbs to it etc.
> but no dumps can start, end or otherwise make progress.
> 
> Delete the workqueue and flush the dump state directly from the release
> handler. Note that further cleanup is possible in -next, for instance
> we now always call .done before releasing the main module reference,
> so dump doesn't have to take a reference of its own.

and we can remove netns & reftracker switching for kernel socket


> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: ed5d7788a934 ("netlink: Do not schedule work from sk_destruct")

Do you have a link to a public report ?

Previously syzkaller's author asked me to use a different name for
Reported-by not to confuse their internal metrics if the report is
generated by local syzkaller.

  Reported-by: syzkaller <syzkaller@googlegroups.com>


> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Change itself looks good to me

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

