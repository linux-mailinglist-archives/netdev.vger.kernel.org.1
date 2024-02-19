Return-Path: <netdev+bounces-72815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3D859B72
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37B7281EF9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7269539C;
	Mon, 19 Feb 2024 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bEuGLCPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D45257D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318080; cv=none; b=GWqxKlqfvtuUSvE63gkpkXEGMmIvx3mQo4l0/kiUspqNxQ9+V4y1G++47l72r2PZ1Si5SxD1Iw237o6KF3aQlxOpvk6pAGZs1StzkwLKR/0YBONQgE1Ba/GdYbup+WDgAxU/JV20p0MfFFQGwsGvKUUmWGNx1ppF2e4xMRkMl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318080; c=relaxed/simple;
	bh=/Ot9177PhWghSrcMlLWWI/gJE0RJfE8MCivWKs0eYB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1sfwSHfGGakySNnNiR2+HIlJES+anRGTkk7vMueP3Dc7u6xRAspCQ2EJ19WLhLnilJX8eOTP3xaK7wAgARbcyD5ynRKgwl99ARVkInq5orQ9/0dFe2sGUMJmRZDt3ngjHfQcB8LHFTiLHOmn+ILcRUPQjITd4ikjTUT0szHFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bEuGLCPf; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708318080; x=1739854080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lko42rTI19jO4s6QjDWdEVqDForyAbtKlBUjtgRrsDA=;
  b=bEuGLCPfjp8g+dpHaPVl0FY2BPa7VgZWMbRAo5C2CXP48BIw+zm5pIVi
   9if8Ff5kJkPPpGG/X6chkMlBozju828A6r4+cNf7aQp+0EqvOCXpROvCB
   fzbHPz12X1+8Yt9J5FMKUCsVji0KLmYBeY8JuHkye4wiRKj9tMFEqjybu
   U=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="274111319"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:47:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15947]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id f4a05e9c-2fdd-4b22-89f6-58ee882932f4; Mon, 19 Feb 2024 04:47:56 +0000 (UTC)
X-Farcaster-Flow-ID: f4a05e9c-2fdd-4b22-89f6-58ee882932f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:47:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:47:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 06/11] tcp: introduce dropreasons in receive path
Date: Sun, 18 Feb 2024 20:47:44 -0800
Message-ID: <20240219044744.99367-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219032838.91723-7-kerneljasonxing@gmail.com>
References: <20240219032838.91723-7-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 11:28:33 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Soon later patches can use these relatively more accurate
> reasons to recognise and find out the cause.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v5:
> Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
> 1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> 2. change the title of this patch
> ---
>  include/net/dropreason-core.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 3c867384dead..402367bfa56f 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -30,6 +30,7 @@
>  	FN(TCP_AOFAILURE)		\
>  	FN(SOCKET_BACKLOG)		\
>  	FN(TCP_FLAGS)			\
> +	FN(TCP_ABORT_ON_DATA)	\
>  	FN(TCP_ZEROWINDOW)		\
>  	FN(TCP_OLD_DATA)		\
>  	FN(TCP_OVERWINDOW)		\
> @@ -37,6 +38,7 @@
>  	FN(TCP_RFC7323_PAWS)		\
>  	FN(TCP_OLD_SEQUENCE)		\
>  	FN(TCP_INVALID_SEQUENCE)	\
> +	FN(TCP_INVALID_ACK_SEQUENCE)	\
>  	FN(TCP_RESET)			\
>  	FN(TCP_INVALID_SYN)		\
>  	FN(TCP_CLOSE)			\
> @@ -204,6 +206,11 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_SOCKET_BACKLOG,
>  	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
>  	SKB_DROP_REASON_TCP_FLAGS,
> +	/**
> +	 * @SKB_DROP_REASON_TCP_ABORT_ON_DATA: abort on data, corresponding to
> +	 * LINUX_MIB_TCPABORTONDATA
> +	 */
> +	SKB_DROP_REASON_TCP_ABORT_ON_DATA,
>  	/**
>  	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
>  	 * see LINUX_MIB_TCPZEROWINDOWDROP
> @@ -228,13 +235,19 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_TCP_OFOMERGE,
>  	/**
>  	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
> -	 * LINUX_MIB_PAWSESTABREJECTED
> +	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
>  	 */
>  	SKB_DROP_REASON_TCP_RFC7323_PAWS,
>  	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
>  	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
>  	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
>  	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
> +	/**
> +	 * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
> +	 * field. because of ack sequence is not in the window between snd_una

nit: s/. because of/ because/


> +	 * and snd_nxt
> +	 */
> +	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
>  	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
>  	SKB_DROP_REASON_TCP_RESET,
>  	/**
> -- 
> 2.37.3
> 

