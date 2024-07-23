Return-Path: <netdev+bounces-112674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A793A8CA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0D9B21A37
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057E145A0F;
	Tue, 23 Jul 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jo8XyVGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6313D503;
	Tue, 23 Jul 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770890; cv=none; b=kX5FzmlO6zZTV87FE3AbOEC/DWGr3bh8kJtsCMnBhXOi5BD82O3qUHpma4+CxcEExDLYFGMTRgah8rp6nl6f+HazP0oMiqj4ajnNt7/djjGo+cmKdeDcl4W+Oj6zLQuRceZXWsYY2bpKmANwFYMBgmK06TvrpsbEpKyp/OSVp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770890; c=relaxed/simple;
	bh=/hN9dY8gBToAEJuGG77/mfI/BcxlzuM6GY0/M/fcVSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGjJjZFxcqnbJE6gSY/IsHgfHygExG4olYblAaER4vIr1ZHS27r2mniHaruFtUiRwVhDH1gZeQWdkdHX/e8leoBe2jnhUsktHafHwWBwETxY2jy0EegrHq0sSnO1Sm691p06T1MgE7qgE5VAUAz6B1dsTkrGJpPiNFlpjKZmY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jo8XyVGi; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721770888; x=1753306888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Sx8ratTZmtfbWbkluP5EAa0lzKLsLlReDFHDW0+xbo=;
  b=jo8XyVGiOeaAG50H7p8OVBqN9eGHJzThGktDucQDAccp+rl1U1X7viKu
   6wSLaF6gcMOKy5Qqg3iVw4xa3aQiO+IvOUjp2qAL2jYl0LoVdMjQ+HyME
   nZ6ONlftP+sVQ4daS7M8O611jUCzNQQ3E4xywxNs4SjJ/WPY3Is5ldSQC
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,231,1716249600"; 
   d="scan'208";a="744762145"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 21:41:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:45287]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.254:2525] with esmtp (Farcaster)
 id 8771c884-438f-407e-b1bd-f4b888333c6b; Tue, 23 Jul 2024 21:41:23 +0000 (UTC)
X-Farcaster-Flow-ID: 8771c884-438f-407e-b1bd-f4b888333c6b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 21:41:22 +0000
Received: from 88665a182662.ant.amazon.com (10.88.135.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 21:41:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matttbe@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<mptcp@lists.linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
Date: Tue, 23 Jul 2024 14:41:12 -0700
Message-ID: <20240723214112.61715-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
References: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
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

From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 21:09:40 +0200
[...]
> >>> Problem of this 'goto consume' is that we are not properly sending a
> >>> DUPACK in this case.
> >>>
> >>>  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
> >>>    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> >>>    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
> >>>    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> >>> abcd1234,nop,nop>
> >>> // Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
> >>> +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
> >>> 6,FO 87654321,nop,nop>
> >>>    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> >>>
> >>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> >>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
> >>
> >> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
> > 
> > It is normal, because the SYN was already received/processed.
> > 
> > sack 0:1 represents this SYN sequence.
> 
> Thank you for your reply!
> 
> Maybe it is just me, but does it not look strange to have the SACK
> covering a segment (0:1) that is before the ACK (1)?
> 
> 'ack 1' and 'sack 0:1' seem to cover the same block, no?
> Before Kuniyuki's patch, this 'sack 0:1' was not present.

This looks a bit strange to me too, but I guess this is also not
forbidden ?

