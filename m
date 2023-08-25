Return-Path: <netdev+bounces-30757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81949788EC4
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E391C20E72
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6F174F7;
	Fri, 25 Aug 2023 18:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398C256A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:35:39 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E95210A;
	Fri, 25 Aug 2023 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692988538; x=1724524538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4IJ9fWGWId9jFHSjrSDACenhV8KSDVmN2rshsCIasA=;
  b=UqEmpnlAQqmJNydUb3T5sNtGQeOyHkbHREWa8N4EQbfYoMRgihyZ1U7t
   9GJv8uR7hAIFGgpWA1u8aPLQsCCOYZHqiSDZ7lTXRapRLhcLh1nQo7qPo
   TjH3HcbWoF9KttzDznKX6Cl6WzTPKJF7x28+IWHpRRGYY6iDF+ED6V8Jk
   A=;
X-IronPort-AV: E=Sophos;i="6.02,201,1688428800"; 
   d="scan'208";a="1150822194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 18:35:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id CD0A880926;
	Fri, 25 Aug 2023 18:35:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 25 Aug 2023 18:35:25 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Fri, 25 Aug 2023 18:35:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jannh@google.com>
CC: <davem@davemloft.net>, <dccp@vger.kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>
Subject: Re: [PATCH net] dccp: Fix out of bounds access in DCCP error handler
Date: Fri, 25 Aug 2023 11:35:08 -0700
Message-ID: <20230825183508.8687-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230825133241.3635236-1-jannh@google.com>
References: <20230825133241.3635236-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.44]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jann Horn <jannh@google.com>
Date: Fri, 25 Aug 2023 15:32:41 +0200
> There was a previous attempt to fix an out-of-bounds access in the DCCP
> error handlers, but that fix assumed that the error handlers only want
> to access the first 8 bytes of the DCCP header. Actually, they also look
> at the DCCP sequence number, which is stored beyond 8 bytes, so an
> explicit pskb_may_pull() is required.
> 
> Fixes: 6706a97fec96 ("dccp: fix out of bound access in dccp_v4_err()")
> Fixes: 1aa9d1a0e7ee ("ipv6: dccp: fix out of bound access in dccp_v6_err()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/dccp/ipv4.c | 13 +++++++++----
>  net/dccp/ipv6.c | 15 ++++++++++-----
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index fa8079303cb0..dcd2fb774d82 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -255,12 +255,17 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
>  	int err;
>  	struct net *net = dev_net(skb->dev);
>  
> -	/* Only need dccph_dport & dccph_sport which are the first
> -	 * 4 bytes in dccp header.
> +	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
> +	 * which is in byte 7 of the dccp header.
>  	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
> +	 *
> +	 * Later on, we want to access the sequence number fields, which are
> +	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
>  	 */
> -	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
> -	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
> +	dh = (struct dccp_hdr *)(skb->data + offset);
> +	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
> +		return -EINVAL;
> +	iph = (struct iphdr *)skb->data;
>  	dh = (struct dccp_hdr *)(skb->data + offset);
>  
>  	sk = __inet_lookup_established(net, &dccp_hashinfo,
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index d29d1163203d..25816e790527 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -74,7 +74,7 @@ static inline __u64 dccp_v6_init_sequence(struct sk_buff *skb)
>  static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
>  			u8 type, u8 code, int offset, __be32 info)
>  {
> -	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
> +	const struct ipv6hdr *hdr;
>  	const struct dccp_hdr *dh;
>  	struct dccp_sock *dp;
>  	struct ipv6_pinfo *np;
> @@ -83,12 +83,17 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
>  	__u64 seq;
>  	struct net *net = dev_net(skb->dev);
>  
> -	/* Only need dccph_dport & dccph_sport which are the first
> -	 * 4 bytes in dccp header.
> +	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
> +	 * which is in byte 7 of the dccp header.
>  	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
> +	 *
> +	 * Later on, we want to access the sequence number fields, which are
> +	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
>  	 */
> -	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
> -	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
> +	dh = (struct dccp_hdr *)(skb->data + offset);
> +	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
> +		return -EINVAL;
> +	hdr = (const struct ipv6hdr *)skb->data;
>  	dh = (struct dccp_hdr *)(skb->data + offset);
>  
>  	sk = __inet6_lookup_established(net, &dccp_hashinfo,
> 
> base-commit: 93f5de5f648d2b1ce3540a4ac71756d4a852dc23
> -- 
> 2.42.0.rc1.204.g551eb34607-goog

