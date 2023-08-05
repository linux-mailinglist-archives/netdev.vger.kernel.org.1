Return-Path: <netdev+bounces-24660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F81E770F71
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF21C20ACC
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D7A956;
	Sat,  5 Aug 2023 11:27:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694E5238
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13A2C433C8;
	Sat,  5 Aug 2023 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691234820;
	bh=MPFDaEPMaDAQrnaY+HCii+Xg819lddX2AnQYfGV07TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYSXrBrq7Xoo6/iJErFdYr9xTYjzFaqi/v8Q48WblzTYKBUqzSlFuAZyPAIsyKG6W
	 QxP3+Wa0EgWR6sdpcQcnKESpt+veuf9W6dRojFTCX5yj1XqxNc4Y4p3KNC5COHsPFL
	 7rqSXnSv1XE5tnTwlijQSM5LDcSsvEg8K4bBHQswL3J1s9t6sjjE4YkjypoAHUB9hY
	 XAGvJPTvyR7jkAJvYPty7JUvP2hqLqO4jXLqfMc+vaglCbiFmCctjrKdp6VoK/qGuk
	 AyyyYvfsDd5u5iFKSz5LBgYDjlfR26elajy0LrXA1tBPo03+j7Tnbj+duNHbdQKg7m
	 bhjt4XZM4ubAQ==
Date: Sat, 5 Aug 2023 13:26:56 +0200
From: Simon Horman <horms@kernel.org>
To: yang.yang29@zte.com.cn
Cc: jmaloy@redhat.com, davem@davemloft.net, ying.xue@windriver.com,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tipc: add net device refcount tracker for bearer
Message-ID: <ZM4yAOKtdcTBXQQY@vergenet.net>
References: <202308041653414100323@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308041653414100323@zte.com.cn>

On Fri, Aug 04, 2023 at 04:53:41PM +0800, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add net device refcount tracker to the struct tipc_bearer.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>

...

> @@ -479,7 +479,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
>  	dev_remove_pack(&b->pt);
>  	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
>  	synchronize_net();
> -	dev_put(dev);
> +	netdev_put(dev, &b->devtracker);
>  }
> 
>  /**
> diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
> index 41eac1ee0c09..1adeaf94aa62 100644
> --- a/net/tipc/bearer.h
> +++ b/net/tipc/bearer.h
> @@ -174,6 +174,7 @@ struct tipc_bearer {
>  	u16 encap_hlen;
>  	unsigned long up;
>  	refcount_t refcnt;
> +	netdevice_tracker	devtracker;

Hi Xu Xin and Yang Yang,

Please add netdevice_tracker to the kernel doc for struct tipc_bearer,
which appears just above the definition of the structure.

>  };
> 
>  struct tipc_bearer_names {

With that fixed, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested


