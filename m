Return-Path: <netdev+bounces-165868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4AA3391F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299E73A5140
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE82063F9;
	Thu, 13 Feb 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XBvW1UTo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F3BA2D;
	Thu, 13 Feb 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432775; cv=none; b=l6VDpwTTxk4eA3K0ZGqAIofPw1x6p6JZUGnvsatcK2wvVbVKHYdS/Dy4+Nq8AWPfAfKFZW9WCVEqddbyn6Lbo2YBDBSWSoV+pcUgXybSXDMXMuHudv7KEzd776g8POdGfpeXAJP0NRX3y+v89gXA5gjvCpLsC7Esm3NU4O7HzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432775; c=relaxed/simple;
	bh=CyxknvaOEiYikBdtLM4EukNbG0aZA3Bdf2y1lR0exbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue8tgQ1zD5lTsp4jbhHNbvjgCgYvqElJ84lziaQYpKv20l5mMb0V2gTQeS5j8VVhGAHrSKeWUShuS3U5fqsFvyg5NpEAm3G9uebzHehSy1WdQKWlcJ83/fv3vXU/GQ5QXHwMHFQJsPUFe3Xk76RIFz0MlaCn6BY1+WLNT7X+P+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XBvW1UTo; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739432772; x=1770968772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0cHoAmJCFDzyca0BXBQoIJ2zkSks/18FUWOioWw6J8=;
  b=XBvW1UTohz/FytYaKzBC2XGkfJyRuj4jvVMGCYtoCVoELvbGa7jQjmmZ
   53SO0aso//tu87Zj92A/mkGZdptYs7EzCZLZdlGWfsQ7r3ZCrdCsYabJz
   YBgfA7HyzvSfeWBU5ayhwWsv4FDuYXj8e2QyAsMaOQI2rA+7azA3TyyXW
   k=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="22181104"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:46:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:54910]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id eea6667e-3084-43a4-adc2-eeb014de29d1; Thu, 13 Feb 2025 07:46:09 +0000 (UTC)
X-Farcaster-Flow-ID: eea6667e-3084-43a4-adc2-eeb014de29d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:46:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:45:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 3/3] arp: switch to dev_getbyhwaddr() in arp_req_set_public()
Date: Thu, 13 Feb 2025 16:45:46 +0900
Message-ID: <20250213074546.15468-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212-arm_fix_selftest-v3-3-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-3-72596cb77e44@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:26 -0800
> The arp_req_set_public() function is called with the RTNL lock held,
> which provides enough synchronization protection. This makes the RCU
> variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
> dev_getbyhwaddr() function since we already have the required rtnl
> locking.
> 
> This change helps maintain consistency in the networking code by using
> the appropriate helper function for the existing locking context.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Fixes: 941666c2e3e0 ("net: RCU conversion of dev_getbyhwaddr() and arp_ioctl()")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I still think patch 2 & 3 should be posted to net separately.

Documentation/process/maintainer-netdev.rst

---8<---
the ``net`` tree is for fixes to existing code already in the
mainline tree from Linus
---8<---

