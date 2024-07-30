Return-Path: <netdev+bounces-114304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F6794214E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E1B203AA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36CC18C909;
	Tue, 30 Jul 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HuaPJYsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DE18A6CB
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370015; cv=none; b=bUEp+Buslx4UT/k/8PFOEG37ewMf8IaMarTjiQw45BU9eto+cVBNeXHchhxP4z1FTJR/NgtVJDZ1+akYk/jGP64x0ZkiENDm6wgiKt6NTODtf96+BBxQh1b0b8k9ilObRKxnm5z/r8eMVPNoGkkpvDfz9U/Bi6j7xfSojgUDQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370015; c=relaxed/simple;
	bh=djTNXWSXJ59SGch4xHKZXSPO+/1mb3fR+2F8X1y5czQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVA4ST2yX4v4Z+QZTMujMA3W9QKlk2k/5Nt4y0Xk4p6uC9yhS9awQXbocN74ayd2qitZ/S4skKj/e/FzGCjSfKdb8sR726O8bpTlQy3gRYNCRNyhceReKJu+bm3ydlMc0CSShG3YScZlskonfzni4wE0Lz5aOOWIHGgqCf5dMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HuaPJYsk; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722370014; x=1753906014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=orbKmBP0eXSKgyb0kXEe4j3vXFdge5+/DamkMbNoT5Q=;
  b=HuaPJYskw1ckXZMtrxUbD0rySmJE/5BcgJTFf7gdh91Vm91vAFsg/z0A
   Loj1mBdEV9xhc+IsXtG1VU9Glfx2KhcszuitHUwrhcDSfWRH9AoBPA7GP
   LTCSdCAoQAJ8JL2p6QcVr0nf1SxoP3SkEF/PUdWemX16JztpdZFJRkAKi
   k=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="359635005"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 20:06:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21320]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id 3ebf5f9e-558d-4d60-8df2-54fda8d710de; Tue, 30 Jul 2024 20:06:45 +0000 (UTC)
X-Farcaster-Flow-ID: 3ebf5f9e-558d-4d60-8df2-54fda8d710de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 20:06:45 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 20:06:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next 4/6] tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
Date: Tue, 30 Jul 2024 13:06:33 -0700
Message-ID: <20240730200633.93761-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730133513.99986-5-kerneljasonxing@gmail.com>
References: <20240730133513.99986-5-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jul 2024 21:35:11 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introducing a new type TCP_STATE to handle some reset conditions
> appearing in RFC 793 due to its socket state.

Why not RFC 9293 ?
Was there any discrepancy ?


> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/rstreason.h | 6 ++++++
>  net/ipv4/tcp.c          | 4 ++--
>  net/ipv4/tcp_timer.c    | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> index eef658da8952..fecaa57f1634 100644
> --- a/include/net/rstreason.h
> +++ b/include/net/rstreason.h
> @@ -20,6 +20,7 @@
>  	FN(TCP_ABORT_ON_CLOSE)		\
>  	FN(TCP_ABORT_ON_LINGER)		\
>  	FN(TCP_ABORT_ON_MEMORY)		\
> +	FN(TCP_STATE)			\
>  	FN(MPTCP_RST_EUNSPEC)		\
>  	FN(MPTCP_RST_EMPTCP)		\
>  	FN(MPTCP_RST_ERESOURCE)		\
> @@ -102,6 +103,11 @@ enum sk_rst_reason {
>  	 * corresponding to LINUX_MIB_TCPABORTONMEMORY
>  	 */
>  	SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> +	/**
> +	 * @SK_RST_REASON_TCP_STATE: abort on tcp state
> +	 * Please see RFC 793 for all possible reset conditions
> +	 */
> +	SK_RST_REASON_TCP_STATE,

Same here.

