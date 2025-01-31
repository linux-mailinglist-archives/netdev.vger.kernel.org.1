Return-Path: <netdev+bounces-161824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B599A24324
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8262F7A1980
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E41F1907;
	Fri, 31 Jan 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bwY4Dl+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402425760
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350626; cv=none; b=tB3lQHdetOUPfwUQnJhYybeEC2NzlJapwOS8YupwesHwiCQPrMjPXtHmgEx6UtC6GV18TMDJY3DHnGnj7B+gruThmPl+sQMTwLI3HVszeipPbutp1MTxeMSc2XkBMHAiXfnDpMB+zeDcCsRncT8cUbhOetTL29tXCxY7vlXfJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350626; c=relaxed/simple;
	bh=slKGq9p+BbdZRikYA82ylBCFhVpCYkZMUIfG96qGMEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2DUmLooHXd0Xyf7U0DW2HTF7B220uoG7ZgUTL6I4QG9NG/A8xbrETtK8hruQKzldrqg0hUbKf0ZC2I2oxedvxuUQCbc3FBMKtgqfudCLhnyuJJ2kn1qqMutxXoEb8XNX98qzqBDYBnZe6YqQdcJU3by73bZTF5gqTvtLBjxOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bwY4Dl+I; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350624; x=1769886624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSINtYhSuDxnlPbjWuV5gd2kqxOXvDbIApsAyzzgTTw=;
  b=bwY4Dl+II+gtF1pvnIZtKVLgRiMR+zhH587PWdOpgYB9Xm+3V0l1clSd
   MRLHEPjhocdiXq/d7HNXznQeLQejuSV4CZGgCFVyEoCL8VqWaI8OjWfn9
   +QEGXrogD8HDd90YKIUXQ6sz0j0JLhMCI9mqwrompo+oGzW+baMl45kKr
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="62160238"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:10:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:44205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 90f0cebf-037b-44be-901c-f16d4d3fd979; Fri, 31 Jan 2025 19:10:20 +0000 (UTC)
X-Farcaster-Flow-ID: 90f0cebf-037b-44be-901c-f16d4d3fd979
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:10:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:10:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 08/16] udp: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:10:04 -0800
Message-ID: <20250131191004.95188-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-9-edumazet@google.com>
References: <20250131171334.1172661-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:26 +0000
> TCP uses of dev_net() are safe, change them to dev_net_rcu()

s/TCP/UDP/

> to get LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


[...]
> @@ -1072,7 +1072,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  {
>  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	const struct in6_addr *saddr, *daddr;
> -	struct net *net = dev_net(skb->dev);
> +	struct net *net = dev_net_rcu(skb->dev);

if v2 is needed for chagelog, this line is longer than saddr/daddr one.


>  	struct sock *sk = NULL;
>  	struct udphdr *uh;
>  	bool refcounted;

