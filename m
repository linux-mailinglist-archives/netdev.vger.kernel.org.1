Return-Path: <netdev+bounces-172703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB33A55C1E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C165188D047
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00A8BFF;
	Fri,  7 Mar 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vxXh7ZkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4D748D;
	Fri,  7 Mar 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308189; cv=none; b=IID1f84WwTHX4QEKfkDEMMZ5FWt0ruHa+3wy60g8Ioke7b5xDnztqOLNTorfxa2juRM83uJ8/zUnUbymRGpkTuuHK/qscKyO4o6nVgm9VeEdSir3GBm4UgIcIsCaumSZcrWSLCepIf9wHsQy446jZ6T/KoP7S+/olFEQgzE/cf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308189; c=relaxed/simple;
	bh=YnM9xW+vVhuf9Yqt0rbNuyAYC11CGxiWbH8jc51gCVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/6ck8/FMSdIEL9C0tg4hSqALF3oILLGXHJ527CDJ0GSPqDyK9MzfjY2de106xfJaIsarbqrKrRr1L3PaCVTnwbvOgFFJmLgMiMW3xKoh1z7+bOQz0pExg6ET8XQF/f2UC86lKxlUUCyzxNpJU4+2aRmOK3QIyj/gb+GP3v5kyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vxXh7ZkI; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741308187; x=1772844187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ht85O26+YIFgXcgvETTRankb0ZIrczTlRdtMn2Kdoy8=;
  b=vxXh7ZkIixcODnfUD4eMX9dgcqCGJmtZOJOvP/RJphgyt7ahGH2Jq6KG
   Dbc48QRJs/M3+IO7k4NqCnyE0kgrN2oFoOTjqaSYvcHXGqL4ZFISYH2an
   Ec+F13shtAI2WwoR6X5ejrPYT7wKWKxF7qihiOytfWxBraJRx0hl916CU
   I=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="179250745"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:43:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:37676]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id 940c6036-4fc4-42e2-bcdc-6793e212f550; Fri, 7 Mar 2025 00:43:05 +0000 (UTC)
X-Farcaster-Flow-ID: 940c6036-4fc4-42e2-bcdc-6793e212f550
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:43:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:42:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
Date: Thu, 6 Mar 2025 16:41:41 -0800
Message-ID: <20250307004251.55786-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306180533.1864075-1-kuba@kernel.org>
References: <20250306180533.1864075-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu,  6 Mar 2025 10:05:33 -0800
> We haven't had much discussion on the list about this, but
> a handful of people have been confused about rules on
> posting selftests for fixes, lately. I tend to post fixes
> with their respective selftests in the same series.
> There are tradeoffs around size of the net tree and conflicts
> but so far it hasn't been a major issue.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index e497729525d5..1ac62dc3a66f 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -311,6 +311,14 @@ user space patches should form separate series (threads) when posted
>  Posting as one thread is discouraged because it confuses patchwork
>  (as of patchwork 2.2.2).
>  
> +Co-posting selftests
> +--------------------
> +
> +Selftests should be part of the same series as the code changes.
> +Specifically for fixes both code change and related test should go into
> +the same tree (the tests may lack a Fixes tag, which is expected).
> +Mixing code changes and test changes in a single commit is discouraged.

I guess an exception for the mixing is when a code change breaks a
selftest, or is it fine for NIPA ?  (still other CI may complain though)

