Return-Path: <netdev+bounces-18404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E6756C71
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC61C20B64
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C72BA52;
	Mon, 17 Jul 2023 18:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570828FA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:48:37 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BB194;
	Mon, 17 Jul 2023 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689619716; x=1721155716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0PUlNaNv9O3xvuqwtDHQn2YDFm0ynnYJhGHxpAdRM6s=;
  b=iDPGJIqVtvWeSRkwTTGggSGP2v8HrG+cg03jARh4iAnqktzDllTQjHgs
   GsFd4FMx7Glq7KA2lcfRSqYT2KfP6WOWbf9oX5tYslWXyNkEXka79IFfM
   3tBdhqXYYN1pDYKv4QXiu3wjnmWxwvFFwtsHMtvCQCEVYQI5r1NgYuXXV
   E=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="661052970"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:48:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id 9783D8049A;
	Mon, 17 Jul 2023 18:48:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 18:48:25 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 17 Jul 2023 18:48:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <machel@vivo.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<herbert@gondor.apana.org.au>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<opensource.kernel@vivo.com>, <pabeni@redhat.com>,
	<steffen.klassert@secunet.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net v1] net: ipv4: Use kfree_sensitive instead of kfree
Date: Mon, 17 Jul 2023 11:48:03 -0700
Message-ID: <20230717184803.92104-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717095932.18677-1-machel@vivo.com>
References: <20230717095932.18677-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wang Ming <machel@vivo.com>
Date: Mon, 17 Jul 2023 17:59:19 +0800
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
> Signed-off-by: Wang Ming <machel@vivo.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/esp4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index ba06ed42e428..2be2d4922557 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -1132,7 +1132,7 @@ static int esp_init_authenc(struct xfrm_state *x,
>  	err = crypto_aead_setkey(aead, key, keylen);
>  
>  free_key:
> -	kfree(key);
> +	kfree_sensitive(key);
>  
>  error:
>  	return err;
> -- 
> 2.25.1

