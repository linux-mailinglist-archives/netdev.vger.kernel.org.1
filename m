Return-Path: <netdev+bounces-174065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033AA5D45D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 03:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115753B8704
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0A1553A3;
	Wed, 12 Mar 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uSOMn6ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234679C2;
	Wed, 12 Mar 2025 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746502; cv=none; b=O2lcBY9Qte8w7qJTY0tBVNq0kJO2g2/5jiUqSzwzTHlmmbO+d4E3ahO7j/8uZSQwYGFlp3UigKC8Evl8L85RMzXiBH66vCt6kBDtvJpnkw+kBrK6yrd+R407BLyUT88XYlclTdqda2dxNwSFQSeWtwXo416K+KgG5LAb80TPg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746502; c=relaxed/simple;
	bh=HCzKMRF/kzdNtLsDlubIo3DW/JwVFd/sCmu8zJB0m1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdDeYFCxbdqYBh3iqNkhiYv0KJwukVd8QUlHXXQ3bSf8mSG81UEI/UJinSm9dUpRCciLqJMDz/3DJdNUkMTyPSlW9yrbha5dL1mCmPEfgh/bTvUQspwhg/JVHeH83H5afKn1CWPpRn6S2n2E7glkqgfhsX+fnx0K/u02HHz7INw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uSOMn6ht; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741746501; x=1773282501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0bbz1JbskYpxOapd18ifGSGP+k3vrJAgNrt1pmbLAo=;
  b=uSOMn6htwNRmiR/Bg7/XbyMjtIb2NJuRcduog/Fs+K5CVL01EBX+HLKk
   50e7AQTNQjvRbvzJIKiIybS4kR2FhHh9+TIhqthfmOkDsPbCxTtTgcFCm
   kAAV2EHc94climw43T+5UYoeZ9eTr7M6M53+UPjsnpJ81Yqsul0rdUr+8
   0=;
X-IronPort-AV: E=Sophos;i="6.14,240,1736812800"; 
   d="scan'208";a="463790"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:28:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:40385]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id 3538b84c-d1fa-4113-a8d1-8ad6aca77024; Wed, 12 Mar 2025 02:28:20 +0000 (UTC)
X-Farcaster-Flow-ID: 3538b84c-d1fa-4113-a8d1-8ad6aca77024
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 02:28:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.160.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 02:28:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sdf@fomichev.me>
CC: <andrew+netdev@lunn.ch>, <atenart@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <enjuk@amazon.com>, <horms@kernel.org>,
	<jasowang@redhat.com>, <jdamato@fastly.com>, <kory.maincent@bootlin.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: reorder dev_addr_sem lock
Date: Tue, 11 Mar 2025 19:27:53 -0700
Message-ID: <20250312022757.69200-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311084507.3978048-3-sdf@fomichev.me>
References: <20250311084507.3978048-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <sdf@fomichev.me>
Date: Tue, 11 Mar 2025 01:45:07 -0700
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 9355058bf996..c9d44dad203d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3080,21 +3080,32 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  		struct sockaddr *sa;
>  		int len;
>  
> +		netdev_unlock_ops(dev);
> +
> +		/* dev_addr_sem is an outer lock, enforce proper ordering */
> +		down_write(&dev_addr_sem);
> +		netdev_lock_ops(dev);
> +
>  		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
>  						  sizeof(*sa));
>  		sa = kmalloc(len, GFP_KERNEL);
>  		if (!sa) {
> +			up_write(&dev_addr_sem);
>  			err = -ENOMEM;
>  			goto errout;
>  		}
>  		sa->sa_family = dev->type;
>  		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
>  		       dev->addr_len);

Can we move down_write() and netdev_lock_ops() here ?


> -		err = netif_set_mac_address_user(dev, sa, extack);
> +		err = netif_set_mac_address(dev, sa, extack);
>  		kfree(sa);
> -		if (err)
> +		if (err) {
> +			up_write(&dev_addr_sem);
>  			goto errout;
> +		}
>  		status |= DO_SETLINK_MODIFIED;
> +
> +		up_write(&dev_addr_sem);
>  	}
>  
>  	if (tb[IFLA_MTU]) {
> -- 
> 2.48.1

