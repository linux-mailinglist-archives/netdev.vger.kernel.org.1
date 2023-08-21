Return-Path: <netdev+bounces-29355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C290782CD6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A02280E79
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196DF79F7;
	Mon, 21 Aug 2023 14:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0979EA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:59:54 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DACD1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692629994; x=1724165994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5aiMbaX/4VSDejJTn/2xw0bcoOzCqmNyQGBG/O2t7i8=;
  b=g0KJm0SyUKl/LzgVjTmi08WZ/H9Mz+t3b9bsbuKZLvDofADtVkOvBC1r
   o8P6tjWGjb7wYd9AvRNGMRxYSE8pyZEZOyvbzYGpZHVy3NhQnkk6osDiC
   Gzs7pfilizFpaz6QEeXp0zSx2Xfq6WF8sis1xafztThqTf5tUqIKn27xk
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,190,1684800000"; 
   d="scan'208";a="603150875"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 14:59:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 9B71440DA2;
	Mon, 21 Aug 2023 14:59:49 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 14:59:44 +0000
Received: from 88665a182662.ant.amazon.com.com (10.135.203.70) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 21 Aug 2023 14:59:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jrife@google.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net: Avoid address overwrite in kernel_connect
Date: Mon, 21 Aug 2023 07:59:33 -0700
Message-ID: <20230821145933.98511-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821100007.559638-1-jrife@google.com>
References: <20230821100007.559638-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.135.203.70]
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jordan Rife <jrife@google.com>
Date: Mon, 21 Aug 2023 05:00:06 -0500
> BPF programs that run on connect can rewrite the connect address. For
> the connect system call this isn't a problem, because a copy of the address
> is made when it is moved into kernel space. However, kernel_connect
> simply passes through the address it is given, so the caller may observe
> its address value unexpectedly change.
> 
> A practical example where this is problematic is where NFS is combined
> with a system such as Cilium which implements BPF-based load balancing.
> A common pattern in software-defined storage systems is to have an NFS
> mount that connects to a persistent virtual IP which in turn maps to an
> ephemeral server IP. This is usually done to achieve high availability:
> if your server goes down you can quickly spin up a replacement and remap
> the virtual IP to that endpoint. With BPF-based load balancing, mounts
> will forget the virtual IP address when the address rewrite occurs
> because a pointer to the only copy of that address is passed down the
> stack. Server failover then breaks, because clients have forgotten the
> virtual IP address. Reconnects fail and mounts remain broken. This patch
> was tested by setting up a scenario like this and ensuring that NFS
> reconnects worked after applying the patch.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  net/socket.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c8..f49edb9b49185 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3519,7 +3519,11 @@ EXPORT_SYMBOL(kernel_accept);
>  int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
>  		   int flags)
>  {
> -	return sock->ops->connect(sock, addr, addrlen, flags);
> +	struct sockaddr_storage address;
> +
> +	memcpy(&address, addr, addrlen);
> +
> +	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);

Could you rebase on net-next.git ?  I think this patch conflicts with
1ded5e5a5931 ("net: annotate data-races around sock->ops").


>  }
>  EXPORT_SYMBOL(kernel_connect);
>  
> -- 
> 2.42.0.rc1.204.g551eb34607-goog

