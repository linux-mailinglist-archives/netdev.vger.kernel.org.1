Return-Path: <netdev+bounces-170027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061ACA46EB0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1926D3AFB30
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5E25D1E9;
	Wed, 26 Feb 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KubfNVUg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BC25D1E1
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609693; cv=none; b=gyOma7T8kc4eRsgsRyQGnbxuG5x4bz/pdV9KPAWMKP0ipZv+UEjKa5PtgnG2nvX55cYl/tQ6GSZKkQjJI0+63MaZRvIn6sPIbi/OUxVCWvUUNmrtbdyyqhbkvFzwEQn2LWb8zInlSq3UnIw7UqmoWVq1dBqpAmGWud3zeE1gnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609693; c=relaxed/simple;
	bh=b7oehTb6Uqr7qjk9gbXXdKOr4ljbII2fjU1773wpE64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXcHUhW+HKN5Y29NnI2GV1zGN2LraiysRihrZBk5615neRVXy/rFmXXNPk6kaIJ6axgo63HXkmK27VvHwfCIBdFCoA82pkcS0NOmwfkvp5XB9uoqwp88NJeBQC4aCwpGzRS09dDpd8iz8wdzHlZZoxA+P7U83tTC+edlokBWYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KubfNVUg; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740609692; x=1772145692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYteKJJ5E81wsBWUjg1/6clIsCswfXa62bKgg4xbX18=;
  b=KubfNVUgq9B3Ek2VPy12uLjmheUYbEIEgOOqBxmgKx7bo743qve2jHiP
   rOsi7hsaFCbI1HfMVWhpoLW3nwaSplwyIs7Sv1N8VDhs1AOKoKxu1iOaH
   lJcsnoqS7+qMo+BzboymxdoJa2TpNyGWCO5MXzWzVShvgfSlWxsANw00g
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="475623433"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:41:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:31431]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id e7293760-82a3-4f76-ba88-30cfdf4e49a1; Wed, 26 Feb 2025 22:41:28 +0000 (UTC)
X-Farcaster-Flow-ID: e7293760-82a3-4f76-ba88-30cfdf4e49a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 22:41:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 22:41:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <aleksander.lobakin@intel.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <idosch@idosch.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 3/3] net: plumb extack in __dev_change_net_namespace()
Date: Wed, 26 Feb 2025 14:41:17 -0800
Message-ID: <20250226224117.47418-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226093232.644814-4-nicolas.dichtel@6wind.com>
References: <20250226093232.644814-4-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 26 Feb 2025 10:31:58 +0100
> It could be hard to understand why the netlink command fails. For example,
> if dev->netns_immutable is set, the error is "Invalid argument".
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I left two small comments but am not sure if it's worth respin.


> @@ -12041,30 +12047,48 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	err = -EEXIST;
>  	if (netdev_name_in_use(net, dev->name)) {
>  		/* We get here if we can't use the current device name */
> -		if (!pat)
> +		if (!pat) {
> +			NL_SET_ERR_MSG(extack,
> +				       "An interface with the same name exists in the target netns");
>  			goto out;
> +		}
>  		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
> -		if (err < 0)
> +		if (err < 0) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "Unable to use '%s' for the new interface name",

Only this message does not have "in the target netns".


> +					   pat);
>  			goto out;
> +		}
>  	}
>  	/* Check that none of the altnames conflicts. */
>  	err = -EEXIST;
>  	netdev_for_each_altname(dev, name_node)

I'd add { here

> -		if (netdev_name_in_use(net, name_node->name))
> +		if (netdev_name_in_use(net, name_node->name)) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "An interface with the altname %s exists in the target netns",
> +					   name_node->name);
>  			goto out;
> +		}

and } here.

