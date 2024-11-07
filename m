Return-Path: <netdev+bounces-142587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071C9BFAA6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C451C2147F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBB802;
	Thu,  7 Nov 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PLJzwfQj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4404A1A;
	Thu,  7 Nov 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938905; cv=none; b=pf9Ze2p29UbjACxRDZfdxQ7tGHSHA7o0h8OkXroXXZlSMULf8UxkTSWhpn7BcNhlnrtfSep5mbw/e2No1P/cRzZ2mife+xb3uJUh7dFE6rrm5Gub62QFNZKeEgaEyZOCiOwayzZ2PbPtVqYyr+JOrHS8VV9O4NZwAa+vd327lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938905; c=relaxed/simple;
	bh=VSAZykUkzn0QfpeHn3yDWUkuKnS1I/96+PhSFxCvzwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErQqrX2rWg95isQ3HrZ28WtlQLJgdDKEY7BUZHPf81hsTUWa9hckoC2IsXIl+dG4pfVAn7s1Dd722snjf0Ei/qG6znBOkoaH6sxYe4VxQ8JYUQqhfCndlgvTrToWqBq5kERbk5HqqXa+c/PetANP9TSaijUz+4bxP2qTOGhHcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PLJzwfQj; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730938903; x=1762474903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTjeIdVulWbQu3nrI57tuZ3r0pWUY6MySRzDp7sNdb8=;
  b=PLJzwfQj7LiFJ47COnHgu0d6xgQCdoP2ySdXU9ZOarLUl3olx+ygpLLJ
   2YIQbPvZA2pTPlcqYhhFMh4P+ff/K/9242oTiYdS4OyREdOIabV23vWfe
   HsrYnxzGFVeMHpms36ouGdDcaK/T2an5O0KwZTsDT9+hhgmxn5gpZf7+Y
   o=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="350019291"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:21:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:1306]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.53:2525] with esmtp (Farcaster)
 id b1978bea-88aa-49f0-8df9-932d424d3100; Thu, 7 Nov 2024 00:21:40 +0000 (UTC)
X-Farcaster-Flow-ID: b1978bea-88aa-49f0-8df9-932d424d3100
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 00:21:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 00:21:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <devnull+0x7f454c46.gmail.com@kernel.org>
CC: <0x7f454c46@gmail.com>, <borisp@nvidia.com>, <colona@arista.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<geliang@kernel.org>, <horms@kernel.org>, <john.fastabend@gmail.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <martineau@kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 4/6] net/diag: Always pre-allocate tcp_ulp info
Date: Wed, 6 Nov 2024 16:21:33 -0800
Message-ID: <20241107002133.56595-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-4-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-4-d62debf3dded@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:17 +0000
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Currently there is a theoretical race between netlink one-socket dump
> and allocating icsk->icsk_ulp_ops.
> 
> Simplify the expectations by always allocating maximum tcp_ulp-info.
> With the previous patch the typical netlink message allocation was
> decreased for kernel replies on requests without idiag_ext flags,
> so let's use it.
>

I think Fixes tag is needed.


> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
>  include/net/tcp.h    |  1 -
>  net/ipv4/inet_diag.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_diag.c  | 13 -------------
>  net/mptcp/diag.c     | 20 --------------------
>  net/tls/tls_main.c   | 17 -----------------
>  5 files changed, 48 insertions(+), 51 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d1948d357dade0842777265d3397842919f9eee0..757711aa5337ae7e6abee62d303eb66d37082e19 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2568,7 +2568,6 @@ struct tcp_ulp_ops {
>  	void (*release)(struct sock *sk);
>  	/* diagnostic */
>  	int (*get_info)(struct sock *sk, struct sk_buff *skb);
> -	size_t (*get_info_size)(const struct sock *sk);
>  	/* clone ulp */
>  	void (*clone)(const struct request_sock *req, struct sock *newsk,
>  		      const gfp_t priority);
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 2dd173a73bd1e2657957e5e4ecb70401cc85dfda..97862971d552216e574cac3dd2a8fc8c893888d3 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -97,6 +97,53 @@ void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
>  
> +static size_t tls_get_info_size(void)
> +{
> +	size_t size = 0;
> +
> +#ifdef CONFIG_TLS
> +	size += nla_total_size(0) +             /* INET_ULP_INFO_TLS */

It seems '\t' after '+' was converted to '\s' by copy-and-paste.


> +		nla_total_size(sizeof(u16)) +   /* TLS_INFO_VERSION */
> +		nla_total_size(sizeof(u16)) +   /* TLS_INFO_CIPHER */
> +		nla_total_size(sizeof(u16)) +   /* TLS_INFO_RXCONF */
> +		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TXCONF */
> +		nla_total_size(0) +             /* TLS_INFO_ZC_RO_TX */
> +		nla_total_size(0) +             /* TLS_INFO_RX_NO_PAD */
> +		0;
> +#endif
> +
> +	return size;
> +}
> +
> +static size_t subflow_get_info_size(void)
> +{
> +	size_t size = 0;
> +
> +#ifdef CONFIG_MPTCP
> +	size += nla_total_size(0) +     /* INET_ULP_INFO_MPTCP */
> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> +		nla_total_size_64bit(8) +       /* MPTCP_SUBFLOW_ATTR_MAP_SEQ */

While at it, let's adjust tabs to match with MPTCP_SUBFLOW_ATTR_MAP_SEQ.


> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
> +		nla_total_size(2) +     /* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
> +		nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_FLAGS */
> +		nla_total_size(1) +     /* MPTCP_SUBFLOW_ATTR_ID_REM */
> +		nla_total_size(1) +     /* MPTCP_SUBFLOW_ATTR_ID_LOC */
> +		0;
> +#endif
> +
> +	return size;
> +}
> +
> +static size_t tcp_ulp_ops_size(void)
> +{
> +	size_t size = max(tls_get_info_size(), subflow_get_info_size());
> +
> +	return size + nla_total_size(0) + nla_total_size(TCP_ULP_NAME_MAX);

Is nla_total_size(0) for INET_DIAG_ULP_INFO ?

It would be better to break them down in the same format with comment
like tls_get_info_size() and subflow_get_info_size().


> +}
> +
>  static size_t inet_sk_attr_size(struct sock *sk,
>  				const struct inet_diag_req_v2 *req,
>  				bool net_admin)
> @@ -115,6 +162,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
>  	ret += nla_total_size(sizeof(struct tcp_info))
>  	     + nla_total_size(sizeof(struct inet_diag_msg))
>  	     + inet_diag_msg_attrs_size()
> +	     + tcp_ulp_ops_size()
>  	     + 64;
>  
>  	if (ext & (1 << (INET_DIAG_MEMINFO - 1)))
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index 36606a19b451f059e32c58c0d76a878dc9be5ff0..722dbfd54d247b4def1e77b1674c5b207c5a939d 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -154,7 +154,6 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
>  
>  static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
>  {
> -	struct inet_connection_sock *icsk = inet_csk(sk);
>  	size_t size = 0;
>  
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -174,18 +173,6 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
>  				       sizeof(struct tcp_diag_md5sig));
>  	}
>  #endif
> -
> -	if (net_admin && sk_fullsock(sk)) {
> -		const struct tcp_ulp_ops *ulp_ops;
> -
> -		ulp_ops = icsk->icsk_ulp_ops;
> -		if (ulp_ops) {
> -			size += nla_total_size(0) +
> -				nla_total_size(TCP_ULP_NAME_MAX);
> -			if (ulp_ops->get_info_size)
> -				size += ulp_ops->get_info_size(sk);
> -		}
> -	}
>  	return size;
>  }
>  
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 2d3efb405437d85c0bca70d7a92ca3a7363365e1..8b36867e4ddd5f45cebcf60e9093a061d5208756 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -84,27 +84,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
>  	return err;
>  }
>  
> -static size_t subflow_get_info_size(const struct sock *sk)
> -{
> -	size_t size = 0;
> -
> -	size += nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> -		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
> -		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
> -		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
> -		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
> -		0;
> -	return size;
> -}
> -
>  void mptcp_diag_subflow_init(struct tcp_ulp_ops *ops)
>  {
>  	ops->get_info = subflow_get_info;
> -	ops->get_info_size = subflow_get_info_size;
>  }
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 6b4b9f2749a6fd6de495940c5cb3f2154a5a451e..f3491c4e942e08dc882cb81eef071203384b2b37 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -1072,22 +1072,6 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb)
>  	return err;
>  }
>  
> -static size_t tls_get_info_size(const struct sock *sk)
> -{
> -	size_t size = 0;
> -
> -	size += nla_total_size(0) +		/* INET_ULP_INFO_TLS */
> -		nla_total_size(sizeof(u16)) +	/* TLS_INFO_VERSION */
> -		nla_total_size(sizeof(u16)) +	/* TLS_INFO_CIPHER */
> -		nla_total_size(sizeof(u16)) +	/* TLS_INFO_RXCONF */
> -		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
> -		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
> -		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
> -		0;
> -
> -	return size;
> -}
> -
>  static int __net_init tls_init_net(struct net *net)
>  {
>  	int err;
> @@ -1123,7 +1107,6 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
>  	.init			= tls_init,
>  	.update			= tls_update,
>  	.get_info		= tls_get_info,
> -	.get_info_size		= tls_get_info_size,
>  };
>  
>  static int __init tls_register(void)
> 
> -- 
> 2.42.2
> 

