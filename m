Return-Path: <netdev+bounces-153106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ACF9F6CB3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E81D1653D4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8CF1F37D8;
	Wed, 18 Dec 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WrlzXytN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E4142624
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544479; cv=none; b=Maz6DLlWZycoiTZi5X6GwF8/Iv0MWigDtt4M1nafykQriUoMEhblb9+2WluSeASinyKUxjliOtMEXQs6kyAbuKynYOfHGa+AT0lQxAHiL2TWhreUaaqLQT/T24b4Nx/Jlvvx1Rjdutk3GZmKPPiCnwqM1eghNc4sEEyCUS8C4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544479; c=relaxed/simple;
	bh=LKJ3ew+UL8bdbsFTg6otZabKISaX3+wXfHECYksSXLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAwdqG9fVEZg5vG2fsVnWLD/8xiOi4+BtHG/7/BeVWIj16/9hqjR++xcm5c4pLCjlH3FwDzIaWPEprOh8kxmRsKahfhevImf6Gc1CZ/UXbXX6clcNlK/5KLudM2EgxfF4sBsNVnWeU6vz/4Ot1UKOx3U2vrUYpHAVQiNE5Aa7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WrlzXytN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso5295161a91.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734544477; x=1735149277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dwpmHD/hmiiul/J6dkVbk6tK1qeXotwCjTUGXOKR5I=;
        b=WrlzXytN+f8/1Jq8Vu9RoToTmMRQy9yv8ZasdJXxRFv5jo0RRixFmCyN/6gql18lHk
         kISRFDlcWRVocvR6rIkoPw3CwMzFaKEx337bC9i5l1+ZkSHm7Y+NVbjX8uNcD2DMFktP
         d+gnwlTlIuZ83O0/9TwpqzEWgmgrS/zbMXsF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544477; x=1735149277;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dwpmHD/hmiiul/J6dkVbk6tK1qeXotwCjTUGXOKR5I=;
        b=DrUlzlftQxz0r6NEIYNVzE6ODgE7jCrs1T997ctbNJ/5gRFZGqM2pHjlCa9wcAP1Hh
         fawd9ESgcNS+DueTSNXv5s8weWJQpsqZlQ85EM4O3tBiVIYRyWxlb6O5tj70ThEnM1xV
         76mpT04YgzfJSBruIcC6RvZtAZ8pEs+bpTiqdhu8CRwfZxIBo9q7hL9sEplYaLstAKv4
         w9YGbkyOPASxoY5w+c586lEfqpAbLdO8lLTg/kr0+QKh+yJB1bU4jTaNpRiy0t4mXMM+
         SQwYliOv9uKq4TEgeGwxjoadMdwwnxeIGQqKEe9UL0rw62szxBJGH10JISqZ/KY4Of24
         T+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXjxbQsig13KI4fpjzU4+XDvCbg0a4JSSr+VFrReUhnTs8UBIJAjcpwn6zDQJoUGQrD4nqYL8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlhjh8Zga+FBranCctxcfpInfuDxhWvSt2coozXS0iutrUWgh
	mEuyH9GyDLgC8iZIyDfpo5WAT5TeSwE6XcJ7vsG+ltEqpPLBk4HnLbD7JcnVkXU=
X-Gm-Gg: ASbGncvNa7lDBNtWlrZQS2j8VQ3ptd7PJw4dO1r54DZ+tQh9KrI9QL4gOq0m2xMcVXx
	9wjZvGo1xrFtD6wbS59FFnhMI8mM6Orp4vi9TVqgSe7KK5HicoR4/4zo65FCrqlFoXp8G/ZMG8M
	5AxzHHbTBxgXxJBl9JetVR2CogBrcKe14UImqndqeGMN0aqUFo9Pl/Z5abC55WFPS/jgLBDtiHf
	IyLcGF1RDl/GmKo+gs5vaV3HP/C16kLDLoRXYSCsjXTlkpS2qmw3M2YH6u0FnnbkaoI0Xu4fjf+
	gKhYd7kmPFSDg3VFoybqFBY=
X-Google-Smtp-Source: AGHT+IGugBmpGHmA2Fpg9fCAH0JYcUdpkHjZFbsgBaehn0Jg6/YNjHR2KcXRy1Pb2nFtKzWM4t3ODQ==
X-Received: by 2002:a17:90b:274c:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2f2e91d92e0mr6156047a91.15.1734544476802;
        Wed, 18 Dec 2024 09:54:36 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5cec5sm79079745ad.172.2024.12.18.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:54:36 -0800 (PST)
Date: Wed, 18 Dec 2024 09:54:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com,
	almasrymina@google.com, sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: Re: [PATCH net] netdev-genl: avoid empty messages in queue dump
Message-ID: <Z2MMWeVefydph52d@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com,
	almasrymina@google.com, sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
References: <20241218022508.815344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218022508.815344-1-kuba@kernel.org>

On Tue, Dec 17, 2024 at 06:25:08PM -0800, Jakub Kicinski wrote:
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down it has no queues.
> 
> Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
> Reported-by: syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: sridhar.samudrala@intel.com
> CC: amritha.nambiar@intel.com
> ---
>  net/core/netdev-genl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 9527dd46e4dc..b4becd4065d9 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -430,10 +430,10 @@ static int
>  netdev_nl_queue_fill(struct sk_buff *rsp, struct net_device *netdev, u32 q_idx,
>  		     u32 q_type, const struct genl_info *info)
>  {
> -	int err = 0;
> +	int err;
>  
>  	if (!(netdev->flags & IFF_UP))
> -		return err;
> +		return -ENOENT;
>  
>  	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
>  	if (err)

Reviewed-by: Joe Damato <jdamato@fastly.com>

