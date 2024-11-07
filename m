Return-Path: <netdev+bounces-142648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD59BFD5C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AD81C212EB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFC839E4;
	Thu,  7 Nov 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TUmTqy7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05811BA2D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953312; cv=none; b=TVovsL12VlnOmV3UEKoktr7gk8utkBEGNwUchfvy0Q+WNSbDxUZJYZFqOMs2eOi94x2Ktd76iOezZFYzqU27khGDO64imgPgyW2v3JzzpNerAZoHb6i3yqW3ouzckp0GZYOCCRJvywWc1BDX+JqYIclq410s1BGAdVR66swR3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953312; c=relaxed/simple;
	bh=zJzGTkN3LnURpuCSAH8RXP+L6Go+d3kX3DmP0HolOQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nq+BtXI6UmV+XG4uG5HewuAQEGIJlwFCU6lHb91MC8MgcmNmw81CvnCGyICV4IwCPnVpImrfLjj6mDrmvgpHp7X2LIRbRoN6/3ruNJ06U9WUl+cnUaZN6/XXuphyKPJq+gMUNg1AXCkycmKy9y53Ha6lUMQsppbMki+9X74c788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TUmTqy7E; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730953311; x=1762489311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MpfwTezcDM5FOQTm6l5RqXBBG5j2rmUXWLzUooXloY=;
  b=TUmTqy7EqLdk+bfHHkaQs4S7uF23QxrvbNTrVcvF2cNjMuDUKh8Pa/Wl
   ine0iwTlbWXRbLKZKWOscBtUjoJ9baWE1OKmZeZF2bVViwDX+S+fkHDRF
   4QdR0yqoPugY8xH0SoTviBMotJzlwzus/OraNgzttgw84klBijNqMRE4P
   4=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="383076185"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:21:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:30121]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.15:2525] with esmtp (Farcaster)
 id 74d9263c-f39c-44f0-9bb1-b6f3e1498dc8; Thu, 7 Nov 2024 04:21:43 +0000 (UTC)
X-Farcaster-Flow-ID: 74d9263c-f39c-44f0-9bb1-b6f3e1498dc8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 04:21:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 04:21:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>, <kernelxing@tencent.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to failure in tcp_timewait_state_process
Date: Wed, 6 Nov 2024 20:21:37 -0800
Message-ID: <20241107042137.83415-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107041506.81695-1-kuniyu@amazon.com>
References: <20241107041506.81695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 6 Nov 2024 20:15:06 -0800
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 7 Nov 2024 11:16:04 +0800
> > > Here is how things happen in production:
> > > Time        Client(A)        Server(B)
> > > 0s          SYN-->
> > > ...
> > > 132s                         <-- FIN
> > > ...
> > > 169s        FIN-->
> > > 169s                         <-- ACK
> > > 169s        SYN-->
> > > 169s                         <-- ACK
> > 
> > I noticed the above ACK doesn't adhere to RFC 6191. It says:
> > "If the previous incarnation of the connection used Timestamps, then:
> >      if ...
> >      ...
> >      * Otherwise, silently drop the incoming SYN segment, thus leaving
> >          the previous incarnation of the connection in the TIME-WAIT
> >          state.
> > "
> > But the timewait socket sends an ACK because of this code snippet:
> > tcp_timewait_state_process()
> >     -> // the checks of SYN packet failed.
> >     -> if (!th->rst) {
> >         -> return TCP_TW_ACK; // this line can be traced back to 2005
> 
> This is a challenge ACK following RFC 5961.
> 
> If SYN is returned here, the client may lose the chance to RST the
> previous connection in TIME_WAIT.

s/returned/silently dropped/ :/

