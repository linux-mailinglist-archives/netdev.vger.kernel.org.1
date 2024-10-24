Return-Path: <netdev+bounces-138871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B169AF429
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0341C20EA3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67518A6CF;
	Thu, 24 Oct 2024 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XYYG/7FW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC3170A27
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803798; cv=none; b=JFy39xeyjkU5nDtKB+ZyXD8op9Q2+bas9x1RuzsF9zc6nBjtS/RXHAEryKEemr1sXeP4MQSzjL6ryW3AdY+vHvCj+eM9946Gfgd8z5jjr8F4On0K4HozL49viWCnAugirtzMRW9RioYX6eXNeJL3/x36LJ9QBvx4IpcLFawxkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803798; c=relaxed/simple;
	bh=XZsHXC/iUKQ1KjZ8N2raBOyVlO05b/CTYEo3vrIW7Js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVqqr6JEUvVqhNezht9bnuoZG+jTcQwhMsHJb+vaKC2OmiYjysZZT/Czm5lRV/S7IFz3JCtoWr5HJ5duXWVePKiVP+2JLHUsx3O7U6H+Ayhzla06qRODsmeTXCxRDL/BqpMAAZ90tvKZUTXfgkX9pKqZVFe+nJPz1cqMQJ5UE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XYYG/7FW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729803796; x=1761339796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSXDHrhxtoP171NHg3ldfjmV84mKsGbYOElebNFe6dk=;
  b=XYYG/7FW4LKqXcDMMsHMi/ucYMn5O/CyUC12wf/y5Q36B0ccyYzHRADL
   /DbwrCIePxj6SsLlrZqwb22bykbbh4VSIQD64w/UQke4C9zk2ASMSZIvp
   6HQJgqt9otA+4ctmg6nSPuvxZNEELiOl0X7JJTgcUZy7ge19PFuKf3Kjs
   I=;
X-IronPort-AV: E=Sophos;i="6.11,230,1725321600"; 
   d="scan'208";a="141487058"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 21:03:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:57884]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.37:2525] with esmtp (Farcaster)
 id 783f3e7c-0d09-4f50-ae0c-1a676b769358; Thu, 24 Oct 2024 21:03:14 +0000 (UTC)
X-Farcaster-Flow-ID: 783f3e7c-0d09-4f50-ae0c-1a676b769358
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 21:03:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 24 Oct 2024 21:03:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dxu@dxuuu.xyz>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <laoar.shao@gmail.com>,
	<menglong8.dong@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
Date: Thu, 24 Oct 2024 14:03:06 -0700
Message-ID: <20241024210306.55559-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <b2e2b3e0-7190-43e5-963d-fc291bba6f81@app.fastmail.com>
References: <b2e2b3e0-7190-43e5-963d-fc291bba6f81@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Daniel Xu" <dxu@dxuuu.xyz>
Date: Thu, 24 Oct 2024 13:52:06 -0700
> Hi Kuniyuki,
> 
> On Thu, Oct 24, 2024, at 12:13 PM, Kuniyuki Iwashima wrote:
> > From: Yafang Shao <laoar.shao@gmail.com>
> > Date: Thu, 24 Oct 2024 17:37:42 +0800
> >> We previously hooked the tcp_drop_reason() function using BPF to monitor
> >> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> >> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> >> To address this, it would be beneficial to make noinline explicitly for
> >> tracing.
> >> 
> >> Link: https://lore.kernel.org/netdev/CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com/
> >> Suggested-by: Eric Dumazet <edumazet@google.com>
> >> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >> Cc: Menglong Dong <menglong8.dong@gmail.com>
> >
> > I saw a somewhat related post yesterday.
> > https://x.com/__dxu/status/1849271647989068107
> 
> Glad to hear you're interested!
> 
> >
> > Daniel, could we apply your approach to this issue in the near future ?
> >
> 
> I suppose that depends on how you define "near". I'm being vague
> in that thread b/c we're still experimenting and have a couple things
> to look at still. But eventually, hopefully yes. Perhaps some time
> within a year if you had to press me.

Sorry, I didn't intend to rush you.  I was just curious if we would
need to revert the patch soon after being merged, so please take your
time :)

Thanks!

