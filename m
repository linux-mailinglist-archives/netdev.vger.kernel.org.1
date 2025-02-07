Return-Path: <netdev+bounces-163834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247FEA2BC2C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA203A6084
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98A1A23AD;
	Fri,  7 Feb 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="doqD/b4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE871A238F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913120; cv=none; b=eec5g/zWUMRZUgSG1QxFlxZiIFoJADPunTSb3ifzVtJiRPmKtFgcsvO3gaZ1O+ytwmhnzEK5BWux52pDKH6s3J/pUx9n624jed8iLZlax549MLYu5cfovqpkQ4y83Z7B4vbOCRykFiEJHtDqLVxSIzpReuzHx3EyjBw5Xu9FUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913120; c=relaxed/simple;
	bh=h1/9nDtp1Eez7HSS8dnx13G5AnkRzoorULMT+VD8OA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NcBn//Ar9vPRgoOJzmV1hxcvAw6H8hR9bb2wSKGeRSe36J6EUVFL9LkgssF4Cj1Pd5Euxts8Dybt5Rneym1H9eajpIILdwQ2HpO3YST7wGtwQuKCYaiZ+FApkhoSSg5S6Xdcp1WQDVNjYjq6luSjbMncwd5cZIFR3tOfUH+OeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=doqD/b4D; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913120; x=1770449120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XI93yDERtggEwsO8wM3Id5yWmnapKh49i9cfexa9iFM=;
  b=doqD/b4D4kcH3oL6+7KLNzeIfRK96n52nFi9mDi/t5GSBGnWZgAwiQRC
   OeuytX1YV+AwmVUDnYvpXOI3i67h4AMvUW1rc0Rx5CWDUFYu+bEICWiFD
   SPADqF1wwJEiuyQZI2W9YEUs8ZM8WFAZhmWlcbX7d5YTfFeeHGFgLBb1i
   s=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="20517467"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:25:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:47925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 08b088d1-787c-42d8-875a-311843a8e22f; Fri, 7 Feb 2025 07:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 08b088d1-787c-42d8-875a-311843a8e22f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:25:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:25:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/8] fib: rules: Convert RTM_NEWRULE and RTM_DELRULE to per-netns RTNL.
Date: Fri, 7 Feb 2025 16:24:54 +0900
Message-ID: <20250207072502.87775-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 ~ 2 are small cleanup, and patch 3 ~ 8 make fib_nl_newrule()
and fib_nl_delrule() hold per-netns RTNL.


Changes:
  v2:
    * Add patch 4 & 5
    * Don't use !!extack to check if RTNL is held

  v1: https://lore.kernel.org/netdev/20250206084629.16602-1-kuniyu@amazon.com/


Kuniyuki Iwashima (8):
  net: fib_rules: Don't check net in rule_exists() and rule_find().
  net: fib_rules: Pass net to fib_nl2rule() instead of skb.
  net: fib_rules: Split fib_nl2rule().
  ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
  net: fib_rules: Factorise fib_newrule() and fib_delrule().
  net: fib_rules: Convert RTM_NEWRULE to per-netns RTNL.
  net: fib_rules: Add error_free label in fib_delrule().
  net: fib_rules: Convert RTM_DELRULE to per-netns RTNL.

 drivers/net/vrf.c       |   6 +-
 include/net/fib_rules.h |   8 +--
 net/core/fib_rules.c    | 151 ++++++++++++++++++++++++++--------------
 net/ipv4/fib_rules.c    |   4 +-
 net/ipv6/fib6_rules.c   |   4 +-
 5 files changed, 110 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)


