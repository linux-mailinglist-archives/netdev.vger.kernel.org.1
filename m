Return-Path: <netdev+bounces-86304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4689E5C2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B71F223C7
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E641158A3D;
	Tue,  9 Apr 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kBj9uhBw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F01DFE8
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703153; cv=none; b=SJhMKS2DjM57Q+WgnN9BI8NGS0aLrWGpb33Rd9JYWwGmEkCoXe7TFg/Jqhg9aJXPFveso71/DMKZj1YO9u1jeICrWfopN5ZtrYv++Oy78UuU//BIO5bAIZIjk6BXt08S1x6S+P+bil/3G7dXVk1kmNb7ED2XZ8kBvOmFPyiBRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703153; c=relaxed/simple;
	bh=H4ijJJeR9/rnaurUD41WzpL+W1HVrV0u6YUhacZ6JwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TI16/jqw/LO8pDmRRPWGJK3w36twGEr1PrG7anaeZTi2TefAknzLzSATuQSFfdUAGZcXpSUO21WFXJHm1h3WOMU5jdVk/Kv5yeI1oYvqHuyUCTu8KQluO60mS6+3c6IRaVoUO4VpEzd8O8H7jbD9uCZRFZ8b+ak7fpuAehE7KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kBj9uhBw; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712703151; x=1744239151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jrTgijiqesFOo5HkKEoWx10LSZ4Say9tDfDMY11UlZI=;
  b=kBj9uhBw6rxIcbLHP1lsFT2cYb8QUufYHzGsQZtkZwf9HW9L2ArBpc4p
   QhARNg6pTIUe3x8/tHXVup53rderwkP7cT/FidGkL+xfOCpRLEvCK3vHG
   pkP9jqX1c+3hd1ExuDTrHPL3uYZYGwdxMe7TgWKMiFPcfGkyJWmVmPdrT
   E=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="646711326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:52:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:53240]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.255:2525] with esmtp (Farcaster)
 id f6de8125-e6d9-45b7-b556-7ec28b84ab4c; Tue, 9 Apr 2024 22:52:28 +0000 (UTC)
X-Farcaster-Flow-ID: f6de8125-e6d9-45b7-b556-7ec28b84ab4c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:52:27 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:52:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/3] af_unix: Fix MSG_OOB bugs and prepare deprecation.
Date: Tue, 9 Apr 2024 15:52:06 -0700
Message-ID: <20240409225209.58102-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, OOB data can be read without MSG_OOB accidentally in two cases.

This series fixes 2 bugs, switch the default of CONFIG_AF_UNIX_OOB to n,
and add warning to deprecate MSG_OOB support in the near future.

The last patch can be dropped if not needed.


Kuniyuki Iwashima (3):
  af_unix: Call manage_oob() for every skb in
    unix_stream_read_generic().
  af_unix: Don't peek OOB data without MSG_OOB.
  af_unix: Prepare MSG_OOB deprecation.

 net/unix/Kconfig   |  4 ++--
 net/unix/af_unix.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.30.2


