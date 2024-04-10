Return-Path: <netdev+bounces-86678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855D89FE4C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323AFB2BDCC
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8317B513;
	Wed, 10 Apr 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YlZzHPRp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629017B4EB
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769033; cv=none; b=rfIYmXXgIBmwTps3F629WhbqB2gmRrZRhZoZPDp5NdjBpSJAiBguc/CHEDPP/1Weny36IB34qdQOyWgrTUBRmNw7PMI+RihIMWRbH8+xjEJbW52jz2mMn9KpMmI8VB4BEDj4XjWiaUH6IWLlDr8S8jOy+IYZBMsGCO/fSXnQKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769033; c=relaxed/simple;
	bh=QqC3pncW+2cZJbsoZPmbLGXmrNbp/poZdLCrKHzp5fA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Agr9eBvLY4kFiiqnkhZGBkxfUuZfk1iezhaJSVwj8ykwW6wNaSF1CcFE7JzGkGLD1vEWwItHK1Jnjf8HJqq1+H7UoSd4fx/MGfTFIJ2CrzNf+J51qpmYOvj7UX0knSFgESzgjwHIaxr/wueXNeO09ZUrbbUApKjPgkUp6d0LuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YlZzHPRp; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712769032; x=1744305032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WvEAz8sS2gP8K1CnYpCDdm+tLWFuuf0Vs8Pr3uazDY=;
  b=YlZzHPRpbNLLLsMw394xg4h27KdruXn/AkphEMHIl07sZ7A4bLmFcaa5
   8XZwise0S+40uPaXfR+Xrs2wloQ3KcuIXWOozHMhNDwjcLRn7lLbgQo0m
   mRp4xXUMtY9mMHl9KnS1CP3qDakZ7fDwE2sfy1rTbjfZu7wKEiAxvFLfr
   8=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="287678562"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 17:10:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60687]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.10:2525] with esmtp (Farcaster)
 id f47224b6-a575-40c4-abc1-92ec4dc820ec; Wed, 10 Apr 2024 17:10:29 +0000 (UTC)
X-Farcaster-Flow-ID: f47224b6-a575-40c4-abc1-92ec4dc820ec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 17:10:28 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 10 Apr 2024 17:10:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/2] af_unix: Fix MSG_OOB bugs with MSG_PEEK.
Date: Wed, 10 Apr 2024 10:10:14 -0700
Message-ID: <20240410171016.7621-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, OOB data can be read without MSG_OOB accidentally
in two cases, and this seris fixes the bugs.


Changes:
  v2:
    Drop patch 3

  v1: https://lore.kernel.org/netdev/20240409225209.58102-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  af_unix: Call manage_oob() for every skb in
    unix_stream_read_generic().
  af_unix: Don't peek OOB data without MSG_OOB.

 net/unix/af_unix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.30.2


