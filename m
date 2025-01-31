Return-Path: <netdev+bounces-161814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F25A242CC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465663A8855
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81A1EF097;
	Fri, 31 Jan 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m2VBE9kU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D331E9B15
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348521; cv=none; b=U62PqWFdMAGqrotiFZLMHBgc+hh0UfAUMEwfvMqnhTUOUPP4KyUAEldaJiFTz7V6MxzcHevdj0i5COwUba4jWZ+uayJY9O45zISMUw2bydNjWsYVtuoW6ns72hBTC9ArGVuvWgPyHly/Xux5gRQ1OISFtUwBwwq8pLiOSqNqw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348521; c=relaxed/simple;
	bh=s3o+N5FPK8g72iZM+1XpBXNpe8KEwJhq7kYJS926YDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9rfL0U1KpoXrBXc3rWDe5T5bDQ2jjVOXfeZea3+OezJ3GMp5kz9VwcvG56rRaEFxddH/0l17fE85TNo90Ntvwc5Ye8uRR7Unk4xbjz1RMLSu246OPtosRLiYH8B3A3lYtBwZIJnXY5vqK6WG8IdWG7OQr97FiGyIe39hfl4GKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m2VBE9kU; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738348519; x=1769884519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oT92v0yb25TobeleTw7kSv04oRh+3jH72bm16CjBQBA=;
  b=m2VBE9kUU+SHDX6c6G46s/xKgxUSQcNpQTh3V5UOYDvLrZYemsMwERDW
   ZZiNn/CMXk5mDuLlFBfFFehFXg4ygv3FVDyaX28kfKUTvY8fOyDzG7N+d
   rLJOtJBIbFJuGR6YQh4DasanQnt9nbLQINV2ytRZ/2CtTX+fByFnqco2d
   c=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="168618224"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 18:35:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:18469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 6cd62432-0624-433a-80f0-c9eb5fde1e2b; Fri, 31 Jan 2025 18:35:16 +0000 (UTC)
X-Farcaster-Flow-ID: 6cd62432-0624-433a-80f0-c9eb5fde1e2b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:35:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:35:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 02/16] ipv4: add RCU protection to ip4_dst_hoplimit()
Date: Fri, 31 Jan 2025 10:34:59 -0800
Message-ID: <20250131183459.90966-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-3-edumazet@google.com>
References: <20250131171334.1172661-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:20 +0000
> ip4_dst_hoplimit() must use RCU protection to make
> sure the net structure it reads does not disappear.
> 
> Fixes: fa50d974d104 ("ipv4: Namespaceify ip_default_ttl sysctl knob")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

