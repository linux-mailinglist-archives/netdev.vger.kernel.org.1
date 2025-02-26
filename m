Return-Path: <netdev+bounces-170029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF7A46EBC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560561889D89
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633D25E81A;
	Wed, 26 Feb 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a69NN89C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDF25E812
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610096; cv=none; b=KwOa92q+HykzjwD4U0rlcH8W31FnPhW5EZDFn/DSsUySY1PzjJAX58HR9LhixwwrJlCk0DhiIwbe+NwE0SbhwGhNvAhDVd/DYQRRtoMozDdCGf2fprWYgXJSysxRWtJ78xBGxI6b48touKPBUIrbmEsc3LiCkgrpbyCVLWwez/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610096; c=relaxed/simple;
	bh=yasjO7UB0NVrYfYkCjgAxl7+bVeg1Tuv4du9O1hj5JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUwsREj5mXy+ul/C580bbY6UXio2Jxk/LwGofH6GS5iIdQxcvRKkHWf0CF5iv5xHyHJvnY3ywxcXTxyN4/ywbriSIubCDSqBTB8Rug9AEwV7LEBrwiuw2vDU+cqdgYM9Yzzuu4NrdeTP6kF/Vlr/v9gGYRQUo38Lso8GOKk/DTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a69NN89C; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740610094; x=1772146094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gF/xaKEPkK+nWmqUVAWVIhuIIdRyUZoqLz0kzNkoTtY=;
  b=a69NN89Cokvu0M8Kq8pkHK+r1nUyHJqF5+mtR1tdn7a3b5iyZxdFqL/3
   PWWMQms2pmuFL/CHOX/KM4xNKQQlSxc0YaBnHWwt0vSD8mFmNjU63jtO8
   i0jywBqRdiPaHPePdkLklT8ioYMGNgvKejoLJYvE2+McpuE3EvZk6AE1e
   4=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="173539497"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:48:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:20517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id da105f19-3c00-4b4b-8924-412f34961914; Wed, 26 Feb 2025 22:48:11 +0000 (UTC)
X-Farcaster-Flow-ID: da105f19-3c00-4b4b-8924-412f34961914
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 22:48:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 22:48:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <matttbe@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<yonghaoz1994@gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: be less liberal in TSEcr received while in SYN_RECV state
Date: Wed, 26 Feb 2025 14:47:53 -0800
Message-ID: <20250226224753.48208-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225171048.3105061-1-edumazet@google.com>
References: <20250225171048.3105061-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 17:10:48 +0000
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
> 
> As hinted by an old comment in tcp_check_req(),
> we can check the TSEcr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
> 
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
> 
> Send a challenge ACK if we receive a TSEcr outside
> of this range, and increase a new SNMP counter.
> 
> nstat -az | grep TSEcrRejected
> TcpExtTSEcrRejected            0                  0.0
> 
> Due to TCP fastopen implementation, do not apply yet these checks
> for fastopen flows.
> 
> v2: No longer use req->num_timeout, but treq->snt_tsval_first
>     to detect when first SYNACK is prepared. This means
>     we make sure to not send an initial zero TSval.
>     Make sure MPTCP and TCP selftests are passing.
>     Change MIB name to TcpExtTSEcrRejected
> 
> v1: https://lore.kernel.org/netdev/CADVnQykD8i4ArpSZaPKaoNxLJ2if2ts9m4As+=Jvdkrgx1qMHw@mail.gmail.com/T/
> 
> Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

