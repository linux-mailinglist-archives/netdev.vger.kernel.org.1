Return-Path: <netdev+bounces-163803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF7A2B9BF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1744167758
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAA17B418;
	Fri,  7 Feb 2025 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kt2HqqvS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85301176FB0
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898994; cv=none; b=Xe5STcdt3euaYG2GmTsd9rBc1ilZE1Wk9Kxm1/jAoAC/Jez0FzTkaGr5Fo3e4dZZ6KDWHcvMihmF01up29XayJrbIPnughAxmVU0rJGyc1gWXx3QPwlaeiXUDlhnOq3oT1U8euBpO3NIWrHXY4zHo+zwIWssY+dU+wC5HR0/KJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898994; c=relaxed/simple;
	bh=CC/lU5cBSriNbt4FVv1OO8X38BLGgU7IgaOqNuYHyKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz78e7KtBdyoLSoHZkN5ikwG1wsFlGb6YsjdYb2JTwTFpLttRfIF5wdVb3w1tkrBNYNx9UyeYLd2Bl3BYEdVCxcizNaVruJcy+abCRmI9WpjPns3aFt6qM/ZbehbvKGxgevqlUawOu8+LhazyQ3ATulY1gpkDoqb3AxFeBpHwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kt2HqqvS; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738898992; x=1770434992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0WfW4sAPRDbPL0mr74cO6djVsFck/d6n3VknRLAwUA=;
  b=kt2HqqvSh9ZFrE6A3gDp+t95uvvVnTI2/4ReSnmHxkpu7sMlts7AaI8f
   /d7+v64AtNjXW8Xjwo5pU44soeOlggVj13pRnfqlxdjzoJ1hJyHTlD5Dx
   bcCtsl2uTGod3iaObCxk5ODzxs/Clh+YZw2HdajRxsT3Zj/WUzFqqFYDc
   g=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="470101543"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:29:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:31633]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id 10bcf97f-aca7-4e9e-8adb-b2b183e6e0b1; Fri, 7 Feb 2025 03:29:42 +0000 (UTC)
X-Farcaster-Flow-ID: 10bcf97f-aca7-4e9e-8adb-b2b183e6e0b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 03:29:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 03:29:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: rename inet_csk_{delete|reset}_keepalive_timer()
Date: Fri, 7 Feb 2025 12:29:22 +0900
Message-ID: <20250207032922.45679-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206094605.2694118-1-edumazet@google.com>
References: <20250206094605.2694118-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu,  6 Feb 2025 09:46:05 +0000
> inet_csk_delete_keepalive_timer() and inet_csk_reset_keepalive_timer()
> are only used from core TCP, there is no need to export them.
> 
> Replace their prefix by tcp.
> 
> Move them to net/ipv4/tcp_timer.c and make tcp_delete_keepalive_timer()
> static.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

