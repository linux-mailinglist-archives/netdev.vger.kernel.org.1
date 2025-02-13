Return-Path: <netdev+bounces-165790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2CA3366B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176BF167D58
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A1158524;
	Thu, 13 Feb 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AAAitAAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45A537E5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418826; cv=none; b=AUxb+hGw0n0N2r4LkuxYQIzE69CzgU9sYGTMDcWGM4NMd8a/s2JnjlqOE6BaBi2NWRV3oouIacFRdANyQUbd2Tpu73C8gYG18wv2QZnt5JrixfO2/k+l3gdYsgu3Dfad4zaM8GJFhYLf+0aY2LLdPRq5Agd/JDpOhtDy7GkOFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418826; c=relaxed/simple;
	bh=J4uFgwWvDx/OIx+HURNTpqkmivmbp35Ey5m5UcLmX8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbnDf3SLX/pKBDMWm59FRxiHWEvK77T67bKJOwXY8akDCRDPW91TtwQVzQxH6vCGB/wTU1KiY/OECbL1OXYc8j9IPGa1M6XvvX9zH4/5mYt7imlzs9lbx2x0zJ8RnWbfLyV+vB8fjdC75VaX+gPpIOOuoKFCkOeViCFcEqKSw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AAAitAAl; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739418825; x=1770954825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8BjVvabDWvRJ4Svrk7KS2Vwsz6FiT0ISCZD1tRCwRU=;
  b=AAAitAAl+wmp5y2YxkTPvNo/QVTbBFGusZ2VV5DKxFi8fE6bzG8ktjR+
   0jZf1Hl/B1DXQiKtla7enz2UsGk4mW0OeXgSK1LmJ10JPIl2FClbss7D6
   5uGq8LgY2bl1kMmh/IMj5v+DPgr/WQaq05lsK2eZlGMKk7JQKSk581VG8
   A=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="798384652"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 03:53:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:16075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id fe98330e-c787-450d-b24f-7adf958243bb; Thu, 13 Feb 2025 03:53:38 +0000 (UTC)
X-Farcaster-Flow-ID: fe98330e-c787-450d-b24f-7adf958243bb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 03:53:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 03:53:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mateusz.polchlopek@intel.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sd@queasysnail.net>, <willemb@google.com>
Subject: Re: [PATCH v2 net-next 2/4] inetpeer: use EXPORT_IPV6_MOD[_GPL]()
Date: Thu, 13 Feb 2025 12:53:20 +0900
Message-ID: <20250213035320.85876-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212132418.1524422-3-edumazet@google.com>
References: <20250212132418.1524422-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 13:24:16 +0000
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that do not need to
> to be exported unless CONFIG_IPV6=m
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

