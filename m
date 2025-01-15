Return-Path: <netdev+bounces-158421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E3DA11CA0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B09188B7EB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AC1E7C34;
	Wed, 15 Jan 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SXll84yS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5881EEA23
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931449; cv=none; b=FKpUYGU8HC0C7omDnvIe3TaNnnjJfCFMhVzsiqaKi6AVV3939azHtsNOypTZ3tzhbFUEaTN6JikfH7HxnBYSZL1q0P85qetFq8YsCwxfvoiNGCIO5aHkNNONIOs+RiLEsAbvjCafLq9a9EmR8Nmj6SIjzYVa9lTfI2fJefmEUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931449; c=relaxed/simple;
	bh=t51leM6A63Gc1e2+cz3/qCdC96aXqxNmaaT423B49M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MupTh3eUH5WqF+z3DLe1C8IE77SeB+xsTD9RJOZ2qNE+5rLBH7V8KYpjZo9Fy5+Ga1FMwd7va0UsI/Oqq1rMGUzbi5kUFVz2XSDcHcYD5S1b21BC7q+IdsSVla7jek+qE0hryQOV49GsIZ1n0dA4MtjV1PrFzPzYnUNR5zJLel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SXll84yS; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736931448; x=1768467448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNXSFbUwBZTsGU8N9hb9kceJdUGcdDk9a9OWfbgtunE=;
  b=SXll84yS3WD8gsYIjUBfAAiV+RcYVig1G5rWspqU+6DroH2znw0N46Wh
   S8tSR2UFsBYYb9+GtLfbLVSnWLnwk1DszHoH2mT+rE0dkg8gAVlzXZMVl
   uwOtNmDM74B3Ooqy1/1hHkHqUKIzh8WeP11gTU36sSpJrjgBOh2KY08WP
   c=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="164311357"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:57:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:9965]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.219:2525] with esmtp (Farcaster)
 id 2fb121ea-c2b4-4664-850f-e52859a00133; Wed, 15 Jan 2025 08:57:26 +0000 (UTC)
X-Farcaster-Flow-ID: 2fb121ea-c2b4-4664-850f-e52859a00133
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:57:25 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:57:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 05/11] net: protect netdev->napi_list with netdev_lock()
Date: Wed, 15 Jan 2025 17:57:11 +0900
Message-ID: <20250115085711.42898-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-6-kuba@kernel.org>
References: <20250115035319.559603-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:13 -0800
> Hold netdev->lock when NAPIs are getting added or removed.
> This will allow safe access to NAPI instances of a net_device
> without rtnl_lock.
> 
> Create a family of helpers which assume the lock is already taken.
> Switch iavf to them, as it makes extensive use of netdev->lock,
> already.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

