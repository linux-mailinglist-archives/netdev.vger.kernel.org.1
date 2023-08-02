Return-Path: <netdev+bounces-23724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725B76D535
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D14281E39
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F9100C8;
	Wed,  2 Aug 2023 17:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150F100AF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:27:28 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED03C15
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690997228; x=1722533228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UajZUZytyvHERwaG0SQM8QioXMeg/pinO87itKE00b8=;
  b=lNG85xmdZPZ8f8ITtHi4b+/3upxObcwTcXMb7iPNwN3NSCKq4gUVTcRw
   vJIVH9YfrAxCp1SjT+wGudvw5fC/Dk3tJIYkGokkJ8U+rNUI/7sd/SHXr
   YxE/+9PE4FV/B0RpvJhaci2DhOj+Wl6LGfJHQW898JQqPXvvD/qBxg1dI
   E=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="20148809"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:27:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 0F54E6734B;
	Wed,  2 Aug 2023 17:27:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:26:57 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:26:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 1/6] tcp_metrics: fix addr_same() helper
Date: Wed, 2 Aug 2023 10:26:45 -0700
Message-ID: <20230802172645.50191-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-2-edumazet@google.com>
References: <20230802131500.1478140-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  2 Aug 2023 13:14:55 +0000
> Because v4 and v6 families use separate inetpeer trees (respectively
> net->ipv4.peers and net->ipv6.peers), inetpeer_addr_cmp(a, b) assumes
> a & b share the same family.
> 
> tcp_metrics use a common hash table, where entries can have different
> families.
> 
> We must therefore make sure to not call inetpeer_addr_cmp()
> if the families do not match.
> 
> Fixes: d39d14ffa24c ("net: Add helper function to compare inetpeer addresses")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 82f4575f9cd90049a5ad4c7329ad1ddc28fc1aa0..c4daf0aa2d4d9695e128b67df571d91d647a254d 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -78,7 +78,7 @@ static void tcp_metric_set(struct tcp_metrics_block *tm,
>  static bool addr_same(const struct inetpeer_addr *a,
>  		      const struct inetpeer_addr *b)
>  {
> -	return inetpeer_addr_cmp(a, b) == 0;
> +	return (a->family == b->family) && !inetpeer_addr_cmp(a, b);
>  }
>  
>  struct tcpm_hash_bucket {
> -- 
> 2.41.0.640.ga95def55d0-goog

