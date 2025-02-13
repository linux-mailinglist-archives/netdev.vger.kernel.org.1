Return-Path: <netdev+bounces-165783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA859A33610
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CB18868A3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5F204C19;
	Thu, 13 Feb 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PHoQ669Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71038F83
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417181; cv=none; b=YUP20ePr/LTIbrzHwtpZ7Og0rgAI73JRwpSI4BT9HWdO18S5uSCiFtj9XPbOkqWcMpn85+i6gClQfGjzxzn39b2WXSNyBb8MPyqbwyVpNGN3LQqzSQ+MJmPmmRHd7vAcR82Q5PolFEBi+rfHkN3OE9cZQ8seMj3QB1FD+jfhGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417181; c=relaxed/simple;
	bh=uopnS+g6jNyTHOVCgsy28PYDZHzAnKfp7mljzI1aols=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcsj34Bl5yHsubwrY5FlipnS7eqRvX/jM06lioCMgZuf1BvLXFLwvNeNjjnWUpw71mxECWwsY7KccGzizRDvjxNO/ydB+E3p96dITljPPZPrmid1S+rRT/0Gf4IFke1rVu9UYS0zmUb0FRYKUetOITagZJYRSPNeH6YQh74oMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PHoQ669Q; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739417180; x=1770953180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guon2+lC6H/KyeZq42JjZ/jp1VPn8rYYGuNtsl/fg8o=;
  b=PHoQ669Q8KBCeyLG0Xs7ETykVooIuu/AVdP3aOaNFnJ8Z86J/2u7qB5r
   uzrGOugzPKNU7RFUCW2FDI/cZlEvZQqCNRDGFq56avaeNU6AdQUo8Rtnh
   kUlW+6WEIacnHp7qKuGng9yporBPPcaCgA3Fgg6IOQWLvNNoOXXo/sS2Z
   c=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="22139104"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:26:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:1833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id 64f1ea86-6d93-4509-9604-1e9b43b67ee3; Thu, 13 Feb 2025 03:26:17 +0000 (UTC)
X-Farcaster-Flow-ID: 64f1ea86-6d93-4509-9604-1e9b43b67ee3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 03:26:17 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 03:26:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] inet: consolidate inet_csk_clone_lock()
Date: Thu, 13 Feb 2025 12:26:03 +0900
Message-ID: <20250213032604.83141-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212131328.1514243-3-edumazet@google.com>
References: <20250212131328.1514243-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 13:13:28 +0000
> Current inet_sock_set_state trace from inet_csk_clone_lock() is missing
> many details :
> 
> ... sock:inet_sock_set_state: family=AF_INET6 protocol=IPPROTO_TCP \
>     sport=4901 dport=0 \
>     saddr=127.0.0.6 daddr=0.0.0.0 \
>     saddrv6=:: daddrv6=:: \
>     oldstate=TCP_LISTEN newstate=TCP_SYN_RECV
> 
> Only the sport gives the listener port, no other parts of the n-tuple are correct.
> 
> In this patch, I initialize relevant fields of the new socket before
> calling inet_sk_set_state(newsk, TCP_SYN_RECV).
> 
> We now have a trace including all the source/destination bits.
> 
> ... sock:inet_sock_set_state: family=AF_INET6 protocol=IPPROTO_TCP \
>     sport=4901 dport=47648 \
>     saddr=127.0.0.6 daddr=127.0.0.6 \
>     saddrv6=2002:a05:6830:1f85:: daddrv6=2001:4860:f803:65::3 \
>     oldstate=TCP_LISTEN newstate=TCP_SYN_RECV
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

