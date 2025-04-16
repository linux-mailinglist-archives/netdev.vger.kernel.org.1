Return-Path: <netdev+bounces-183471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFACA90C4C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F81895228
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1316224250;
	Wed, 16 Apr 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rx1jAsyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3917A304
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831643; cv=none; b=S0+5JCX2PTvivk36wrU0w7+ZRpfQYTMf/4pJefDtMP+eaDFmFGrPv1YSvqKvA6bwJK2cE4qOebDCsXxCjUFHlVhq3eJbwB3ApYBwiDEBBQ3Uy7gukGVSC2kz1Z8di7y++ekr42FE+cZAXBJRGkvSViauOCQ0uSVAvXICrkZG3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831643; c=relaxed/simple;
	bh=wsjH8lVJdSPzNsh90iExkt1cm3Rz7GwPqhNMWOo1aPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl8EX+L+vC7Hdayj3MaMLZba1fqvCFs/tPvaADvClm/OCK/hUv31VDNRQYTfTz10UeTKh9aHshadqsacVaImpPIz7WfqxasTzeXYW8SD7ZylS8rSw8WwS8nhnCMwz8A8Oj/KENpAyTTKEeN96MsLr3PLwSOUAluHREbFfPQTX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rx1jAsyI; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744831642; x=1776367642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jkfTj/TKfWp285M3cFi57DAKYPv69XlPOFEwzykgwHE=;
  b=rx1jAsyIV90EVq+EinA4SFcMmhEnRlSpDiDqeIh40tny8jwaYIdWWaNw
   cq4CtFDf3zO+TfkgYV2UfWcD1y2KSxa1eBjsWqe2t3EKQeYK/sODEgxC+
   t04KCErrj/RfewehLiIXKOlrkukgbgJTgQMo9s7sNaYuxBpkxB2Io2/wW
   o=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="481024052"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:27:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:43691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.154:2525] with esmtp (Farcaster)
 id c15f4c71-9de3-49dd-b0e9-2164e4803af4; Wed, 16 Apr 2025 19:27:17 +0000 (UTC)
X-Farcaster-Flow-ID: c15f4c71-9de3-49dd-b0e9-2164e4803af4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:27:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:27:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jgh@exim.org>
CC: <edumazet@google.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through getsockopt
Date: Wed, 16 Apr 2025 12:26:54 -0700
Message-ID: <20250416192705.16673-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416091538.7902-1-jgh@exim.org>
References: <20250416091538.7902-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeremy Harris <jgh@exim.org>
Date: Wed, 16 Apr 2025 10:15:38 +0100
> Signed-off-by: Jeremy Harris <jgh@exim.org>
> ---
>  include/uapi/linux/tcp.h | 1 +
>  net/ipv4/tcp.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index dc8fdc80e16b..ae8c5a8af0e5 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
>  #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
>  #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
>  #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
> +#define TCPI_OPT_TFO_SEEN	128 /* we accepted a Fast Open option on SYN */

This is the last bit of tcpi_options.

We can add another field at the end of the struct if necessary in
the future, but from the cover letter and commit message, I didn't
get why this info is needed at per-socket granurality.

Also, This can be retrieved with BPF.


>  
>  /*
>   * Sender's congestion state indicating normal or abnormal situations
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e0e96f8fd47c..b45eb7cb2909 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4164,6 +4164,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
>  		info->tcpi_options |= TCPI_OPT_SYN_DATA;
>  	if (tp->tcp_usec_ts)
>  		info->tcpi_options |= TCPI_OPT_USEC_TS;
> +	if (tp->syn_fastopen_in)
> +		info->tcpi_options |= TCPI_OPT_TFO_SEEN;
>  
>  	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
>  	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
> -- 
> 2.49.0

