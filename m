Return-Path: <netdev+bounces-66455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665A783F500
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977EF1C20C11
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594191805E;
	Sun, 28 Jan 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HuO0w6lr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC541B286
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438277; cv=none; b=DiKPic1fGKOFkYDFaolLOmJWNYsX1SIgb6WTIW0c5O074mPJw2t0aN33iWPix76qkpHmEaT0OQM8jwn9+NbB/Jh0O7Z6nIL+dEMtiagAW3ZySdcozJ2C/z8m6wtkXB/0lykiNfFVqFDllVk1HqTfpwg9brLvdBcpAanuNFUR1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438277; c=relaxed/simple;
	bh=hPHer1PJYP15HYJzuvsC4vBuD70njz+XDMDlodksLHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nbHRjKQ/O+PKkEElrQfAjIFcqKQXRxKhHRx8xLTrUWBC7/1QFpuiJm6oq6rDXSMocOhQCEUOFX/ogY3Oq/r9CsSiIbQ7bm1s/RSv9xzdmIJO9qLXiEivUw7+hIPgEVvBNJzZwUHm7w3hwc8sm56XdV+BN/0MvgF3Nk0LhZrbm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HuO0w6lr; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706438276; x=1737974276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AQR9CDAuy+wyW2OgzVavteLe7uJqmD5VW+V40Ddw9/Y=;
  b=HuO0w6lrCTpZj62vNzcRmA04ti3rcM8Gni+7wqDMfTsFmgLsrIjDMyZG
   4sp45MNjd2eVZ0Ni+pLEVqGy/RnK+vFlTFl9sxvjzEklatI62JSmVftXQ
   ZuF6fNW3io7xtvP2r5yxiQiiXyFK19XoKWEf/6JfHjhjI7GKOp1v2rsef
   g=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="392985016"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 10:37:50 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id D4643C1665;
	Sun, 28 Jan 2024 10:37:47 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:27720]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.8:2525] with esmtp (Farcaster)
 id 07c17b67-905e-4a86-8dda-cef9aea5a418; Sun, 28 Jan 2024 10:37:47 +0000 (UTC)
X-Farcaster-Flow-ID: 07c17b67-905e-4a86-8dda-cef9aea5a418
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:37:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:37:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/2] af_unix: Clean up unnecessary spin_lock(&sk->sk_peer_lock).
Date: Sun, 28 Jan 2024 02:37:30 -0800
Message-ID: <20240128103732.18185-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Except for updating sk_peer_pid/sk_peer_cred, we do not need to hold
sk_peer_lock during initialisation.

This series removes unnecessary spin_lock() and spin_unlock() in such
places.


Kuniyuki Iwashima (2):
  af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
  af_unix: Don't hold client's sk_peer_lock in copy_peercred().

 net/unix/af_unix.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

-- 
2.30.2


