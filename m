Return-Path: <netdev+bounces-177636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB428A70C7D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 23:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2233B9C89
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C361A83E7;
	Tue, 25 Mar 2025 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fx3KTu7t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676AD530;
	Tue, 25 Mar 2025 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940090; cv=none; b=al3EtaxuJWDoY/qrvfs4xPO8R/RmtqH65AYJQLSsZTzcWku8Bs+Dns7AqBtrTk3ABVlbvrc9PgUnc2hvEVcdEHWCwQVebTw+JVzw6tD7fXf3X4682ijjcG/pGlp+fVAzoxu+fE2MABiNRDLbmsxuyKQxryWoJJN/8E0Y53bT8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940090; c=relaxed/simple;
	bh=BQLtxhJ85Tld/lC/ncVMNKJQuS4VQZX8eMuRf6WuLvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXXWO58cdXZvaz+v/FNLvTNgMcesCP6rOjpuYtsKzzJXxFMELit7BEZw1YLG7dUPFJJRHj+SUIpPkmgV91AS1zECZDEliokCYJRKU8QxmXJsdPVMc8tUrQc5tSJvwOW0Jbj9DdCN3En5D/PRh0wXrukDXc9JiFd6LlcG+3O8tzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fx3KTu7t; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742940088; x=1774476088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYi90DVAyrf6sk195M81TGjvn40aKO20224itqCURZI=;
  b=Fx3KTu7tLGE+39jsFbO/deQRY1GBAA+g0aatswhffhhAXpaJT7btzKte
   bSfnaKsPfFPJl+DH5zo4YDSxtQcVZZHUJoE7FF33aKMTnMh2ebPS2eJmk
   pbLMVYAcgkK2a7RDLHdVx5EdBDOChA2p5XcUvv67LzGIox4gRgLM1Gafh
   k=;
X-IronPort-AV: E=Sophos;i="6.14,276,1736812800"; 
   d="scan'208";a="35114054"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 22:01:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:42592]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.51:2525] with esmtp (Farcaster)
 id 73e7438d-f8c3-4d69-9ccd-068c33d4b0ca; Tue, 25 Mar 2025 22:01:26 +0000 (UTC)
X-Farcaster-Flow-ID: 73e7438d-f8c3-4d69-9ccd-068c33d4b0ca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 22:01:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 22:01:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <i.abramov@mt-integration.ru>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net 1/4] ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
Date: Tue, 25 Mar 2025 15:00:47 -0700
Message-ID: <20250325220115.67524-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325141723.499850-2-i.abramov@mt-integration.ru>
References: <20250325141723.499850-2-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ivan Abramov <i.abramov@mt-integration.ru>
Date: Tue, 25 Mar 2025 17:17:20 +0300
> Currently, the return value of device_rename() is not checked or acted
> upon. There is also a pointless WARN_ON() call in case of an allocation
> failure, since it only leads to useless splats caused by deliberate fault
> injections.
> 
> Since it's possible to roll back the changes made before the
> device_rename() call in case of failure, do it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
>  net/ieee802154/core.c | 44 +++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index 88adb04e4072..f9865eb2c7cf 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -233,31 +233,35 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
>  		wpan_dev->netdev->netns_local = true;
>  	}
>  
> -	if (err) {
> -		/* failed -- clean up to old netns */
> -		net = wpan_phy_net(&rdev->wpan_phy);
> -
> -		list_for_each_entry_continue_reverse(wpan_dev,
> -						     &rdev->wpan_dev_list,
> -						     list) {
> -			if (!wpan_dev->netdev)
> -				continue;
> -			wpan_dev->netdev->netns_local = false;
> -			err = dev_change_net_namespace(wpan_dev->netdev, net,
> -						       "wpan%d");
> -			WARN_ON(err);
> -			wpan_dev->netdev->netns_local = true;
> -		}
> +	if (err)
> +		goto errout;
>  
> -		return err;
> -	}
> +	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
>  
> -	wpan_phy_net_set(&rdev->wpan_phy, net);
> +	if (err)
> +		goto errout;
>  
> -	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
> -	WARN_ON(err);
> +	wpan_phy_net_set(&rdev->wpan_phy, net);
>  
>  	return 0;
> +
> +errout:
> +	/* failed -- clean up to old netns */
> +	net = wpan_phy_net(&rdev->wpan_phy);
> +
> +	list_for_each_entry_continue_reverse(wpan_dev,
> +					     &rdev->wpan_dev_list,
> +					     list) {
> +		if (!wpan_dev->netdev)
> +			continue;
> +		wpan_dev->netdev->netns_local = false;
> +		err = dev_change_net_namespace(wpan_dev->netdev, net,
> +					       "wpan%d");
> +		WARN_ON(err);

It's still possible to trigger this with -ENOMEM.

For example, see bitmap_zalloc() in __dev_alloc_name().

Perhaps simply use pr_warn() or net_warn_ratelimited() as do_setlink().

I guess the stack trace from here is not so interesting as it doens't
show where it actually failed.


> +		wpan_dev->netdev->netns_local = true;
> +	}
> +
> +	return err;
>  }
>  
>  void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
> -- 
> 2.39.5

