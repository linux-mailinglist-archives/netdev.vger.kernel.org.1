Return-Path: <netdev+bounces-158428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF58A11CF1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687B77A32D3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D847246A30;
	Wed, 15 Jan 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E2S5p1fr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E5246A1F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932083; cv=none; b=dIKlwXXyEIXwJehlglkpV2LmgOQm7U4rBZRn3Sne/2TNk35JTbPwEZhNoCy1gScjFXa23JReLXyE7B7f4tyhjpsnTxotl3gbAJkqBKKZMzO2Vf8nNFzQsTuqNFJ+qsrgndvd0nmXUuWuuceHAsnajM4f1Vr1l3ir/ZS0Lqs4OFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932083; c=relaxed/simple;
	bh=rtaRlScB/P8koCm9XduK/Xe+acqf51u98DeCuR+iZ2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0B71shNQ+eWx5h3zmtzx5sAIz520tNqvxcJGyMFNQviHljzeOJD++turi/AhWDREeoBQyuGnCKr9m7tAC00TaeHrsYPr/62b12/7uTCodClzpyYr0DgJzeouhkbAr8TvBYiCXrdP8q4vDJw0+uoc66Kj383KPXpjxIpJo+nJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E2S5p1fr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736932082; x=1768468082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5piIGM8yKwS1sTitnf4Azv5X5IzPKHgBi56YsKVvU8=;
  b=E2S5p1frkkm9oL6O/bRy84d2ihVZVJVjlydOjhkYr+EPP5XESJBewRSr
   cT0LPmJ5IpaCARt3i/g4dTDTaGzbW3RCm3sf+c5bC1xRWlBffXllXkkwf
   SzCjjC0C5c6AH/U4B1bjaZ6aSh3B/LDOHxhp69uLnzQlpErRiKz8fT5aX
   8=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="164314576"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:08:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:4380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.28:2525] with esmtp (Farcaster)
 id f7c49c48-e732-4ab4-b051-af0e4c3cfac6; Wed, 15 Jan 2025 09:08:01 +0000 (UTC)
X-Farcaster-Flow-ID: f7c49c48-e732-4ab4-b051-af0e4c3cfac6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:07:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:07:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 07/11] net: make netdev netlink ops hold netdev_lock()
Date: Wed, 15 Jan 2025 18:07:31 +0900
Message-ID: <20250115090731.45263-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-8-kuba@kernel.org>
References: <20250115035319.559603-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:15 -0800
> In prep for dropping rtnl_lock, start locking netdev->lock in netlink
> genl ops. We need to be using netdev->up instead of flags & IFF_UP.
> 
> We can remove the RCU lock protection for the NAPI since NAPI list
> is protected by netdev->lock already.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

