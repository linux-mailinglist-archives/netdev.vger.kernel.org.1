Return-Path: <netdev+bounces-161826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8549FA24327
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E21884CE3
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B02AD11;
	Fri, 31 Jan 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="puvpr6NB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DF28373
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350920; cv=none; b=iAdftXEcNTW2K9xzMjtoSYz857DOVWcY36k9Crn6/jop30LBZjQRiTRO9gBzZtUQwdkjcp0PvEYplEZQvyPB/TLkq2CQ18Quq4ZTwrLYcNa3cZ63b64BG/N+GmX7VFMDrKXn6RndmTHvbiCyVYtCPwkQtkQQ8r+zv+2ySX3uDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350920; c=relaxed/simple;
	bh=Tv8cwqz2tLtYAkXW+zQRa0oupw5jGleg67ZHANm70Ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hphuVXklByJNXZXy8O1psFd62EhnEmC7mc9MaMlFwVHWzhRP59SyuGAInE+8FlQJsPyhjHyG6H1EWUvO21Q5xUa7ZSN/JOWCw7bMXYghx8pwzCM2cwdCXR8o1dH1vv1V+qBkWUxXBkIhcSMfcTFeoM2N0w506cASvbp2T7kGT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=puvpr6NB; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350919; x=1769886919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G57pApv28Pn00yFQdeEH1YmIzDH0gcNNI0yMSrMlVXw=;
  b=puvpr6NB9bB+TgC9SiZplQ+HJfuW6RZc2aDx7Fra3kjI6B5fLUSRxOUD
   02B/i/51ze/oh8N7c32fnLBfoI1lwEobqw+djs1yVRuBP+xW90GE6CpUV
   MOXVxwp9qEMq5KkCBJJ2CzQYaATX+/EL1RP2qCQRA1WCsMCVYHxEUIV0Z
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="168628082"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:15:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:20748]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id 1495dc65-1b96-4ebc-97af-960d1449cacd; Fri, 31 Jan 2025 19:15:17 +0000 (UTC)
X-Farcaster-Flow-ID: 1495dc65-1b96-4ebc-97af-960d1449cacd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:15:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:15:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 10/16] ipv6: icmp: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:15:02 -0800
Message-ID: <20250131191502.95709-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-11-edumazet@google.com>
References: <20250131171334.1172661-11-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:28 +0000
> ICMP uses of dev_net() are safe, change them to dev_net_rcu()
> to get LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

