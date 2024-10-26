Return-Path: <netdev+bounces-139370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECC9B1A89
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 21:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC46B215BB
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534217BB1E;
	Sat, 26 Oct 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jX8zRcAo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105F538A;
	Sat, 26 Oct 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729969987; cv=none; b=jq1bjvT/aSrJPAjjq54xK097UAgQNUVq881LCcybtNtQtlOIZxzemLeMtegVTcwI0C21ola8K/hMLBAt55GNhjGNbAX2c6ZeU2UvyOUC+dEjL1fxxhNSZwZMiTlP+euxXrfItrRbzP+o7OaisTuSizkEdc4r4vsb8uPBEZOxsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729969987; c=relaxed/simple;
	bh=rRP+aWikoEwsIfslVZTFBuKhR+9WbH9YwvTkDr5R+PE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cy5Bv9w6hydwwe/inV1RJMLWGVOvsrllSVspjg8DEzfX6S1lRVenK+088/ouU72johBREqpNmtFaMMF/HmOb1F8WNXfe5zQa4l6AFIIgMk+qM2tWGNROtBdN76eZVAA05dAYuQmKH3jePhPvWEMWPWCE2bJXzMiB1CTJYRx31/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jX8zRcAo; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729969986; x=1761505986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTeS4S97T9i5wDRkiJ0wiTt3zliWJpfr5clxtukrDSw=;
  b=jX8zRcAodZZyloccVWU2ZYtQ1DtAYlc/PfO4BzhjObIYCnSx/V7Kn/4W
   KjOS1EYhAvtqRqNdTdH5uOwe1FfclRBz/pgQq5ayCBqs+j1LY92wXxO0F
   a+SA+JA1kWbvDwu5pH/gbJNpWsRxCXu8wPnEoyezscNAmhW9+3poaM101
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,235,1725321600"; 
   d="scan'208";a="346995913"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 19:13:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:40625]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.170:2525] with esmtp (Farcaster)
 id 426117d0-34d0-43f6-8297-2ac08ddab4c5; Sat, 26 Oct 2024 19:13:04 +0000 (UTC)
X-Farcaster-Flow-ID: 426117d0-34d0-43f6-8297-2ac08ddab4c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 26 Oct 2024 19:13:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.131.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 26 Oct 2024 19:12:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <christophe.jaillet@wanadoo.fr>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kernel-janitors@vger.kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] rtnetlink: Fix an error handling path in rtnl_newlink()
Date: Sat, 26 Oct 2024 12:12:55 -0700
Message-ID: <20241026191255.15528-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr>
References: <eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 26 Oct 2024 16:17:44 +0200
> When some code has been moved in the commit in Fixes, some "return err;"
> have correctly been changed in goto <some_where_in_the_error_handling_path>
> but this one was missed.
> 
> Should "ops->maxtype > RTNL_MAX_TYPE" happen, then some resources would
> leak.
> 
> Go through the error handling path to fix these leaks.
> 
> Fixes: 0d3008d1a9ae ("rtnetlink: Move ops->validate to rtnl_newlink().")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks for catching!

> ---
> Compile tested only
> ---
>  net/core/rtnetlink.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 194a81e5f608..e269fae2b579 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3829,8 +3829,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	}
>  
>  	if (ops) {
> -		if (ops->maxtype > RTNL_MAX_TYPE)
> -			return -EINVAL;
> +		if (ops->maxtype > RTNL_MAX_TYPE) {
> +			ret = -EINVAL;
> +			goto put_ops;
> +		}
>  
>  		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
>  			ret = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
> -- 
> 2.47.0

