Return-Path: <netdev+bounces-110683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879E92DBD8
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0061C23884
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745291482EE;
	Wed, 10 Jul 2024 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s9YsrxYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EB3BBD8
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649933; cv=none; b=WY4IsqO3s0DmRW8/WGWpzIGhm8tRidcjdzZmc4pF26ybTUYKPXjcanCQW/8LeQxTPDsEk4RpWepNFa0hgZDny4NjB79uhxlJCndGyYvmuQ8BnGbPs5f2yuHY47aFN+ElX2lZ/Hd+3mO6sckuqZ5dGEGDIrpd3m/9SxaCci+eojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649933; c=relaxed/simple;
	bh=JTNkgp0SUmMrVzGKRqFjCn1YAkCfApe1TFBtOShoiA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQ0Ap9WSufEzkIn97f55uHzm1q0qe6sWAH5Rdu4JaAdy4DvnWvXSAORRBgCfvlTLv7KOFdYz18LsKYeS4bMq6M1vxuKIS3mFz1X/Sj7fagmPfsYXRm2jEJQnYwZAdgu7OIl05VM8/J5zBY94PpMo2qq+rNC1aL+WT4nlxCdsobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s9YsrxYn; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720649932; x=1752185932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEDlnxZ6u0vgMXZRhm5EDtrilBd0vrNQSzt0+YUhdSw=;
  b=s9YsrxYn3AIJE1iC6DtQ1yx4+dGIkPy46rZYvQlsD0bFTKCWs6f6+Ce2
   R+Wz017vvxkpzTn2ajCeZCSZckq6cX2gEIRUIjbUqIXrURm915nZbqy0b
   wKy1NTiP9DIVXZXHwQd90KWSP4htfKxvSHNNlCxqdodR2kwltNDZzUX3A
   g=;
X-IronPort-AV: E=Sophos;i="6.09,198,1716249600"; 
   d="scan'208";a="740065573"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 22:18:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:1076]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.122:2525] with esmtp (Farcaster)
 id e274319a-cfbc-4836-a1c0-e18144e98b23; Wed, 10 Jul 2024 22:18:45 +0000 (UTC)
X-Farcaster-Flow-ID: e274319a-cfbc-4836-a1c0-e18144e98b23
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 22:18:45 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 22:18:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <jmaxwell37@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: [PATCH net] tcp: avoid too many retransmit packets
Date: Wed, 10 Jul 2024 15:18:26 -0700
Message-ID: <20240710221826.32571-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240710001402.2758273-1-edumazet@google.com>
References: <20240710001402.2758273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 00:14:01 +0000
> If a TCP socket is using TCP_USER_TIMEOUT, and the other peer
> retracted its window to zero, tcp_retransmit_timer() can
> retransmit a packet every two jiffies (2 ms for HZ=1000),
> for about 4 minutes after TCP_USER_TIMEOUT has 'expired'.
> 
> The fix is to make sure tcp_rtx_probe0_timed_out() takes
> icsk->icsk_user_timeout into account.
> 
> Before blamed commit, the socket would not timeout after
> icsk->icsk_user_timeout, but would use standard exponential
> backoff for the retransmits.
> 
> Also worth noting that before commit e89688e3e978 ("net: tcp:
> fix unexcepted socket die when snd_wnd is 0"), the issue
> would last 2 minutes instead of 4.
> 
> Fixes: b701a99e431d ("tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

