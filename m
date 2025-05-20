Return-Path: <netdev+bounces-191725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5655ABCE5C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BD88A2218
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FED25B66E;
	Tue, 20 May 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K9HdEcq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7E25A65C;
	Tue, 20 May 2025 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717180; cv=none; b=PDE8RJB3oDgI6nYAhnwbcAh8cz22k8FcB8BtQ7O+U9iIw99/NKGkAb2NQcMlt9VM1M3ivRmIEA+6jEMTH7UDI5Xqz+SStxSvEkHRwrogM+ZwuLQAEMmWtl0ns0PwfG5Qrhm6y9vzAfokrKG2ScxYrtACjHmWQsPIhPTs01qcMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717180; c=relaxed/simple;
	bh=DptRutwWA6KxqxdlcBqZhKp/gcI1ZF1zcNFYSZFJB0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrhdElBoYIMCuPUgGZKL90rsaHvYBy6k67RCPHI68pVAbfC7i21zkl87BzVOORjdgswqWteYo0CB6/tgUlcUNfc219d0qa5wa0orOjONs9qBIo+NuUe/rlDzKFrud4+HyxExBVPWyLUZkrjuFPA4ZkK4InZl4YkPGUFfUGwqhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K9HdEcq+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747717179; x=1779253179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7EzC6fpwrFJPpkzxIXD6suNFs9l44QJ7ZK5ERClQV8=;
  b=K9HdEcq+nyMSx0aVrXBPGBkLwDvWvEmdWnwnoJX+Zdb15kTRjdJr9b3S
   94/6EHE5h4/sm7+YJd0logsEdkSF3wWF0kS46MFCjgyVYikIpkLgy1YC7
   kD104VMxh4zalakgRIYvgqS/IhE78cEqovyfxJS5fcJCh2c/B3mStWmiu
   B65J6qoGr6kG0KGMXPTtTsnQSSP9s0nygLPFC0uwOZazHUJJ/5+njRsx0
   kKvh9na/oJXVvjYJgQwhTnjQRQR6PjCYsmpxdKBwAgzt3T6mGGe+vka/a
   2TRJk1WP0ks6GLTSa+bGnMVYCkKWm4KTCJcuxdX7ANqY//hmITIxRqsHH
   g==;
X-IronPort-AV: E=Sophos;i="6.15,302,1739836800"; 
   d="scan'208";a="724523668"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:59:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:7547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.193:2525] with esmtp (Farcaster)
 id b5978a69-a66c-4db0-92a5-3a1a7bb9aa64; Tue, 20 May 2025 04:59:34 +0000 (UTC)
X-Farcaster-Flow-ID: b5978a69-a66c-4db0-92a5-3a1a7bb9aa64
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 04:59:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 04:59:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jiang.kun2@zte.com.cn>
CC: <davem@davemloft.net>, <edumazet@google.com>, <fan.yu9@zte.com.cn>,
	<gnaaman@drivenets.com>, <he.peilin@zte.com.cn>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <leitao@debian.org>,
	<linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qiu.yutan@zte.com.cn>,
	<tu.qiang35@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
	<yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH linux next] net: neigh: use kfree_skb_reason() in neigh_resolve_output()
Date: Mon, 19 May 2025 21:58:58 -0700
Message-ID: <20250520045922.34528-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520104413538Q88ZB2XVWu1BthfQkFSuW@zte.com.cn>
References: <20250520104413538Q88ZB2XVWu1BthfQkFSuW@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: <jiang.kun2@zte.com.cn>
Date: Tue, 20 May 2025 10:44:13 +0800 (CST)
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() used in neigh_resolve_output() with kfree_skb_reason().
> 
> Following new skb drop reason is added:
> /* failed to fill the device hard header */
> SKB_DROP_REASON_NEIGH_HH_FILLFAIL
> 
> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> ---
>  include/net/dropreason-core.h | 3 +++
>  net/core/neighbour.c          | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index bea77934a235..bcf9d7467e1a 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -62,6 +62,7 @@
>  	FN(NEIGH_FAILED)		\
>  	FN(NEIGH_QUEUEFULL)		\
>  	FN(NEIGH_DEAD)			\
> +	FN(NEIGH_HH_FILLFAIL)		\
>  	FN(TC_EGRESS)			\
>  	FN(SECURITY_HOOK)		\
>  	FN(QDISC_DROP)			\
> @@ -348,6 +349,8 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_NEIGH_QUEUEFULL,
>  	/** @SKB_DROP_REASON_NEIGH_DEAD: neigh entry is dead */
>  	SKB_DROP_REASON_NEIGH_DEAD,
> +	/** @SKB_DROP_REASON_NEIGH_HH_FILLFAIL: failed to fill the device hard header */
> +	SKB_DROP_REASON_NEIGH_HH_FILLFAIL,
>  	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
>  	SKB_DROP_REASON_TC_EGRESS,
>  	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 254067b719da..f297296c1a43 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1517,7 +1517,7 @@ int neigh_resolve_output(struct neighbour *neigh, struct sk_buff *skb)
>  	return rc;
>  out_kfree_skb:
>  	rc = -EINVAL;
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_HH_FILLFAIL);

Is there any reason you don't change neigh_connected_output() ?


If you respin, please specify net-next and the patch version in

Subject: [PATCH v2 net-next] net: neighbour: ...


>  	goto out;
>  }
>  EXPORT_SYMBOL(neigh_resolve_output);
> -- 

