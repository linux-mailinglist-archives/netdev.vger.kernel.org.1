Return-Path: <netdev+bounces-168386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6CFA3EBCE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D8D19C4A39
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8521F9AB6;
	Fri, 21 Feb 2025 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lyfEMEbk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA517C9F1
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111844; cv=none; b=K+3/c0vJIxf5omp/cL6WmdVBnfYDVD1vdkOhh/1Iu1YEGVzLYNJV5DJUPSHKzhxQt+ZAyfpZCoCOmfxvdFZeICldd1B7Of+YL8R9E9O5JHULIRrXMz0/9OZCpHeVHROFoXoakb0NePvrJvAKIqCKf+Y/pfU+Qa6tMszaNmT9KJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111844; c=relaxed/simple;
	bh=5tHdgEVZupusYc+Y0gKLz3gJWRg5kVz0aCmH3VAhJ+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWEZdrKsCN4EngpE97wVCcsASrkSuLi1JbJmee5C/UT8ZMpmITUdsY5pAHVzLR7S5KxPFPvg7tXKnKsRZlf4I14eSevR7kc3fQOUQKk+vTgZJrysqSHN3+cphDgyUlwbkWztD/q8exHrRy4Bdp1FX0Ux0M1GmyRje0kdtxCZS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lyfEMEbk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740111843; x=1771647843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJJtQiUwOq1HtQXwnvVfRlDj5LFPPGUb+RC11Cz6Sqo=;
  b=lyfEMEbkkwatBmWQH1L5TqGpA/LlpdYZp//+2UewjW1y0b92+iplEPIZ
   j70bio7Z56XD7Obj63R1U1dh23s/MUEi1LsADVpJbKPSkwSbrAlM9YJtL
   S1uSEfutxXI7sfgUrtD5vB5oPgU2F1PS8jgI4TYNlmHXc3dJcpkPKLSXY
   E=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="67975484"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:23:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:17164]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id 2e98a75c-2305-41aa-ba9f-12c6c2e36e29; Fri, 21 Feb 2025 04:23:58 +0000 (UTC)
X-Farcaster-Flow-ID: 2e98a75c-2305-41aa-ba9f-12c6c2e36e29
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:23:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:23:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <aleksander.lobakin@intel.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <idosch@idosch.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v3 1/2] net: advertise 'netns local' property via netlink
Date: Thu, 20 Feb 2025 20:23:45 -0800
Message-ID: <20250221042345.80515-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
References: <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 20 Feb 2025 14:02:35 +0100
> Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
> dev->netns_local"), there is no way to see if the netns_local property is
> set on a device. Let's add a netlink attribute to advertise it.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

