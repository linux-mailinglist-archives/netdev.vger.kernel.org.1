Return-Path: <netdev+bounces-114299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC22E94212D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6574FB2436F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648DE169397;
	Tue, 30 Jul 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qYWCawi1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6B1AA3E2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369637; cv=none; b=VJEAhB2uH2L8x05TzIfgK7uMVncGgJM9SblXfMBr1rRFqLNacZbGNtDDyDFxpcpZ7bFQejve/4Z7Xh9avhVMejt2HuDehsBvCPfIhc1bNldEIavyWBKLpN4I0RGjQAWrR0UW1muQzZryJ1Aot4XZvPDTvG9F/E5vh9tQKTcZ0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369637; c=relaxed/simple;
	bh=7Hw/9wDuC8fGujY7BUyTSwcEf+pqE5bZrSW8Eh0rlqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOA7Ct07FEuGFQEFbFzv3AEkjYUHmjs7X+j4g1FvviJiBH9xijScLaVkGoWCUlpeazlUefjagj/m6r3xDzlXb1o+a8lgVcTGW56NMmBSt/1Ypd2Nq0vs0iG/2+dgwFqkda1721HTprE8zHjj3PejkOrtO7uUz9t/WcO0PYfEebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qYWCawi1; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722369636; x=1753905636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=einGD7QUDrPZ5tp3l30mIWtz6yYEjjWUyCYe3D7/fI8=;
  b=qYWCawi1xq973oJYZUYce/3s3AnhJ8Co1WyicIOSY39FidS7UwwSi+zs
   bgJUqI0Hv89kVgBh3XfzRPimIOrovjrMFeK8fbWcnzMVfFN8zENutc42s
   kL9hx1OBSkwkFDwCEPsU1/Jwb+N4s3/k2Gec4xV9lViq+ge6pIQ5tZDVC
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="15902643"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 20:00:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:26506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.45:2525] with esmtp (Farcaster)
 id c48f3776-6ac9-4197-afba-0e8d53e7512d; Tue, 30 Jul 2024 20:00:32 +0000 (UTC)
X-Farcaster-Flow-ID: c48f3776-6ac9-4197-afba-0e8d53e7512d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 20:00:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 20:00:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next 5/6] tcp: rstreason: introduce SK_RST_REASON_TCP_TIMEOUT for active reset
Date: Tue, 30 Jul 2024 13:00:19 -0700
Message-ID: <20240730200019.93474-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730133513.99986-6-kerneljasonxing@gmail.com>
References: <20240730133513.99986-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jul 2024 21:35:12 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only when user sets TCP_USER_TIMEOUT option and there is no left
> chance to proceed, we will send an RST to the other side.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/rstreason.h | 7 +++++++
>  net/ipv4/tcp_timer.c    | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> index fecaa57f1634..ca10aaebd768 100644
> --- a/include/net/rstreason.h
> +++ b/include/net/rstreason.h
> @@ -21,6 +21,7 @@
>  	FN(TCP_ABORT_ON_LINGER)		\
>  	FN(TCP_ABORT_ON_MEMORY)		\
>  	FN(TCP_STATE)			\
> +	FN(TCP_TIMEOUT)			\
>  	FN(MPTCP_RST_EUNSPEC)		\
>  	FN(MPTCP_RST_EMPTCP)		\
>  	FN(MPTCP_RST_ERESOURCE)		\
> @@ -108,6 +109,12 @@ enum sk_rst_reason {
>  	 * Please see RFC 793 for all possible reset conditions
>  	 */
>  	SK_RST_REASON_TCP_STATE,
> +	/**
> +	 * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
> +	 * When user sets TCP_USER_TIMEOUT options and run out of all the
> +	 * chance, we have to reset the connection
> +	 */
> +	SK_RST_REASON_TCP_TIMEOUT,

nit: Maybe SK_RST_REASON_TCP_USER_TIMEOUT ?

It's more user-friendly.

