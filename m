Return-Path: <netdev+bounces-88964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403DE8A918F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D891F2187E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C54F8A3;
	Thu, 18 Apr 2024 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AGE9RpZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311C79D0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411124; cv=none; b=Ylku2D+5JbDFMh9aJg2Srrs3kTL/UcnR5oMXQlqq/xZRDomqIYOLkW6DguCc8OU4yEZRPVuLDFI9I8gPicF1kH7VdawqTmxINsPrHCsDGx1zGBoiWbypy5lvGK3f0IBsjbHHXxHc85MqP3+F+4tK8Pin+ssuh18VbWgbPTmCECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411124; c=relaxed/simple;
	bh=fv0A1QFwtZgiX6Qj86hm0W1ffO85rLFVTzJdxB/b774=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9JCnjLkpkusvmgUJb91nlP+F0QjJkWEoU/97ec/ujnu4X7cGVLD1T6/FgrKwjIbvEmgERSrV8aLPsIROu8tYxYLR2LQkoX1hVnZoXfDREdTThrFlVyUPDXH/Ag6+t4PTXg7Yn/myNdK7uK/3/gCzXI6hpLXCArcSCPbItemCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AGE9RpZ7; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713411122; x=1744947122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1dwQWc9/PtrVsAyZhr78RzUacI+vgrU4bFKprVzqyc=;
  b=AGE9RpZ7ijLsONTJ/NRLeqTENbcThOSU68USZpbJPUTtHG48Rcsdj/WU
   j5NDuB+knv81sA/z2Eb37Ez6eU/N9qxuMXb48AXTugS09kHqJVzc+PZ4D
   9A/DwPGO9DeRJd0m4uzN3VImVsgUyXrCUvL2KwvRRE+S5Yb+PaYoOR83k
   k=;
X-IronPort-AV: E=Sophos;i="6.07,211,1708387200"; 
   d="scan'208";a="401046998"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:31:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:61145]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.130:2525] with esmtp (Farcaster)
 id 76656e3e-04e5-42ea-ba16-1b7d477c0ecb; Thu, 18 Apr 2024 03:31:59 +0000 (UTC)
X-Farcaster-Flow-ID: 76656e3e-04e5-42ea-ba16-1b7d477c0ecb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 03:31:59 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 18 Apr 2024 03:31:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<herbert@gondor.apana.org.au>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<steffen.klassert@secunet.com>, <syzkaller@googlegroups.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking skb->protocol in sit_tunnel_xmit().
Date: Wed, 17 Apr 2024 20:31:45 -0700
Message-ID: <20240418033145.35894-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417190432.5d9dc732@kernel.org>
References: <20240417190432.5d9dc732@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 17 Apr 2024 19:04:32 -0700
> On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> > syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent it
> > over sit0.
> > 
> > After nsh_gso_segment(), skb->data - skb->head was 138, on the other
> > hand, skb->network_header was 128.
> 
> is data offset > skb->network_header valid at this stage?
> Can't we drop these packets instead?

I think that needs another fix on the NSH side.

But even with that, we can still pass valid L2 skb to sit_tunnel_xmit()
and friends, and then we should just drop it there without calling
pskb_inet_may_pull() that should not be called for non-IP skb.

