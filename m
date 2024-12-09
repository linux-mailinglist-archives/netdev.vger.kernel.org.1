Return-Path: <netdev+bounces-150034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE49E8B29
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD4D163FBD
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0420FA99;
	Mon,  9 Dec 2024 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MpcL8u1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A315AD9C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723337; cv=none; b=qqRV6mQKHQ8KVRRdyAxERhti21i4+GHC1BZIWmdHSBdJD7n73B6Q6KvxLd/p+LpqeXbhE+CZ8bHha07eZf0GEX3Cw3OelUX8IIW1xIQvZbAKLdu+7xvSWvhl8mjfkZrg9NvaL9TQ32AkFNBda+mD0C/Oj08P8Z87konGDrNd+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723337; c=relaxed/simple;
	bh=ibm+zCj3CxaclwxSSP4hTnyRIYoDdsbRST1tKNR9Siw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/rzfJ0qzzbSBurDnqZ6PKpfyv50lAlukjDRjgdX1r4eU3GJEdnV5umd5x9KNgJBmAZkb49fG2hv2/BWeUZ1Bujo2ca9lwOQ0wPgaTeS7BXC80njPZDrRlybqo2fgU4N0eO+UzcEAwPqsW4lapU4c5ZNAU+w+z8E9KG6A2KyQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MpcL8u1X; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733723336; x=1765259336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ImLp4sLKC4SVahc3i9bhaXgWkp+CV1Oh20kdO+Z3new=;
  b=MpcL8u1XqgGwZLSxyFrnF+ki4DCtnhJYw5SWQLPbbFvE2kQlQW/hNmAd
   BGKsC/gClTtqyxEmv66I2oOcfulRuJ8TZOhXrjF5JZjMKdIUuoPKMI8EA
   vDrEDN0pwQWDMgzWueMpUEdVB/X38Dxtb9rT9Z5+CTqftGzSRBmmq3mWw
   8=;
X-IronPort-AV: E=Sophos;i="6.12,218,1728950400"; 
   d="scan'208";a="449154379"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:48:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:52875]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.223:2525] with esmtp (Farcaster)
 id 7d04721f-1da5-46d7-b5ca-f7221573595f; Mon, 9 Dec 2024 05:48:51 +0000 (UTC)
X-Farcaster-Flow-ID: 7d04721f-1da5-46d7-b5ca-f7221573595f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 05:48:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.254.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 05:48:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <roopa@nvidia.com>
Subject: Re: [PATCH net-next 1/3] rtnetlink: add ndo_fdb_dump_context
Date: Mon, 9 Dec 2024 14:48:41 +0900
Message-ID: <20241209054841.14302-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241207162248.18536-2-edumazet@google.com>
References: <20241207162248.18536-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  7 Dec 2024 16:22:46 +0000
> rtnl_fdb_dump() and various ndo_fdb_dump() helpers share
> a hidden layout of cb->ctx.
> 
> Before switching rtnl_fdb_dump() to for_each_netdev_dump()
> in the following patch, make this more explicit.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

