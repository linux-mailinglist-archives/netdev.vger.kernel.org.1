Return-Path: <netdev+bounces-149590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEFB9E66CD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41169169B41
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA78194C62;
	Fri,  6 Dec 2024 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UuPOLkiv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF87193426
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462787; cv=none; b=QYy3s9ZDdU0myL9LRL2ERlwyy0/e3SxXdBN+cLnS6qqwdK4cDY40WKBa7o5UNfaO3pQouIRFePGgTQqdAJFiu1ETef1reCK/FDvRMSK2wsnsh2rIdJknKwDKM/T5K6RfBeW1Ji6B+LAhD3lKk5T0D/36wcJW9FVY/swQ0fiUcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462787; c=relaxed/simple;
	bh=8ox0tXVNRl3/YV8GQWdPJ06cPXEYG5we1GSuacLnzIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBZc0Nut20J1gGNLKO+AXpiXjphHHPzWfjpP50rjClEOsubW2Nw6H6iScU7zmEpyTzqmyV6NL1/YN1nHi91UrePaL6ohR+gcYcXEXBpnWONsF2zu8+YOVw0bwxowyKxJMePOBswR2sGq2oytx5tXMQ0Fd6s4kYK84meP+E3ZYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UuPOLkiv; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462786; x=1764998786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rE3kJ/WsYODd6MMoQjPE0TRuq3Xf0+zGQzqyo+Plnf8=;
  b=UuPOLkivlHI2zkmMmfATzmTF6Mo7ZqACSmee/KAfNN9y7gFfe1RMCDzZ
   XUMKWl0EwQGpvyoVeIXBxE6hQPDhejLISq5Pyx7ndt+p4qXnOdElIAh+y
   juD+ErRMkdVOdtXWDa0ABP5AcIcZaIcVrpyGo3NCvdI8c+b9EFVBuYGfz
   U=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="475956077"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:26:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:9599]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.147:2525] with esmtp (Farcaster)
 id 254fd5ad-0481-4531-acbd-316a6a3d63fa; Fri, 6 Dec 2024 05:26:19 +0000 (UTC)
X-Farcaster-Flow-ID: 254fd5ad-0481-4531-acbd-316a6a3d63fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:26:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:26:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/15] af_unix: Prepare for skb drop reason.
Date: Fri, 6 Dec 2024 14:25:52 +0900
Message-ID: <20241206052607.1197-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is a prep series and cleans up error paths in the following
functions

  * unix_stream_connect()
  * unix_stream_sendmsg()
  * unix_dgram_sendmsg()

to make it easy to add skb drop reason for AF_UNIX, which seems to
have a potential user.

https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/


Kuniyuki Iwashima (15):
  af_unix: Set error only when needed in unix_stream_connect().
  af_unix: Clean up error paths in unix_stream_connect().
  af_unix: Set error only when needed in unix_stream_sendmsg().
  af_unix: Remove redundant SEND_SHUTDOWN check in
    unix_stream_sendmsg().
  af_unix: Clean up error paths in unix_stream_sendmsg().
  af_unix: Set error only when needed in unix_dgram_sendmsg().
  af_unix: Call unix_autobind() only when msg_namelen is specified in
    unix_dgram_sendmsg().
  af_unix: Move !sunaddr case in unix_dgram_sendmsg().
  af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
  af_unix: Split restart label in unix_dgram_sendmsg().
  af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
  af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
  af_unix: Clean up error path in unix_dgram_sendmsg().
  af_unix: Remove sk_locked logic in unix_dgram_sendmsg().
  af_unix: Remove unix_our_peer().

 net/unix/af_unix.c | 229 ++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 126 deletions(-)

-- 
2.39.5 (Apple Git-154)


