Return-Path: <netdev+bounces-83793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3259894457
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33191C21590
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12C3EA68;
	Mon,  1 Apr 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rL1VM2Kr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2D47A6B
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992713; cv=none; b=RmmjygSwdmXOhaG6ZbMWRxXCUXNzJEDou/9WtgI5Z60D1vVvVn5ehs38CvLUqpaajqCxCqsZaqPl/xQYfeOs01eXuLXhlg/Ju4FNK/C64byCuSz4bT27Jo65707TV+SOdNhrqtYr2VzuqpwNc22JNo5lj1HitS+h02rqjNEmgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992713; c=relaxed/simple;
	bh=TODKZseTx4tA7UKweTipoO1YhYAHRcr2qdgc1pgUkvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+pkMoxRZLuKwkt5K2eaj3thwpyvDe/yHa9H/VOF3S/8yYTqECQY3pEzMsBtzv9BKfuRZaNwW1hZobuFVkiG22xfW8Z2s1UxpSjbKVNwOCba1TGqzgjZudWwl71iXH7SjnzH/SqqDV7P81ZS3tyyMxzIHlcR3+dUFj+/PRAdXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rL1VM2Kr; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711992711; x=1743528711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WWGXIlleIETs1na34+zTRzgNvlrXA92/u82wZWGS04=;
  b=rL1VM2KrBdnPg+xqJwVMZ37H2ZGarHU5Mu5xp4e2UAh1yDYOix/F6tqj
   sOKPcUehGdpe0yb2+7JiHJkHyfnBm8k2xl9NvO3pKcOUeroZxd7Gtx/U8
   loYuoxV8ElXd7kKhlAlr4P//oSanFRdvSkDrPUyJviiBemuVMYG5k6nBX
   A=;
X-IronPort-AV: E=Sophos;i="6.07,172,1708387200"; 
   d="scan'208";a="715236273"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 17:31:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:40760]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.248:2525] with esmtp (Farcaster)
 id 5791a23f-1ec4-4617-aea1-d784dedf42ea; Mon, 1 Apr 2024 17:31:43 +0000 (UTC)
X-Farcaster-Flow-ID: 5791a23f-1ec4-4617-aea1-d784dedf42ea
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 17:31:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 1 Apr 2024 17:31:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/2] af_unix: Remove old GC leftovers.
Date: Mon, 1 Apr 2024 10:31:23 -0700
Message-ID: <20240401173125.92184-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a follow-up series for commit 4090fa373f0e ("af_unix: Replace
garbage collection algorithm.") which introduced the new GC for AF_UNIX.

Now we no longer need two ugly tricks for the old GC, let's remove them.


Kuniyuki Iwashima (2):
  af_unix: Remove scm_fp_dup() in unix_attach_fds().
  af_unix: Remove lock dance in unix_peek_fds().

 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 51 ++-----------------------------------------
 net/unix/garbage.c    |  2 +-
 3 files changed, 3 insertions(+), 51 deletions(-)

-- 
2.30.2


