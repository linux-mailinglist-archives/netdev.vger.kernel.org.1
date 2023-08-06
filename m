Return-Path: <netdev+bounces-24722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F57716A7
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3873281183
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB406A949;
	Sun,  6 Aug 2023 19:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C97F0
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A88C433C7;
	Sun,  6 Aug 2023 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691351493;
	bh=wv7mtAHZJr2vZeWnUM1Beb+dSs/Qq2Vp36EkkPj9g1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0Vh9B6yDi1z2HfT80A6yDd/ZUhnPq6Ot51QorbDetx2LDATIK3EsklcgbkVwR00l
	 8lF2dN10cfGjkxZZ9YKJ7aLJt1427MjFmYxmK8sRhunSKyFdOWh/0h7p742Z8WB0hx
	 MGpT634+O6jGo6GHn0EwX5sWeGSOTRD4jk/LHqX64I/syC4ki6+UnXha5hMNBYX9m0
	 UvORuvoEhQsts/Ml0+XtqtaL9Azo4yRfYxP5MPArAN1A5FfnC1q528oqbotIB4Woia
	 dViongoUvqmhykZnW/SN8hxmUrHaCKB4QFWoLkK23l0zuP5hUgXJUx/07BqT83ux4i
	 EILWDbQlSVKBA==
Date: Sun, 6 Aug 2023 21:51:28 +0200
From: Simon Horman <horms@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: yang.yang29@zte.com.cn, jmaloy@redhat.com, davem@davemloft.net,
	ying.xue@windriver.com, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tipc: add net device refcount tracker for bearer
Message-ID: <ZM/5wD5hZqgDNg3i@vergenet.net>
References: <202308041653414100323@zte.com.cn>
 <ZM4yAOKtdcTBXQQY@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM4yAOKtdcTBXQQY@vergenet.net>

On Sat, Aug 05, 2023 at 01:26:56PM +0200, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 04:53:41PM +0800, yang.yang29@zte.com.cn wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > Add net device refcount tracker to the struct tipc_bearer.
> > 
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> > Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> 
> ...
> 
> > @@ -479,7 +479,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
> >  	dev_remove_pack(&b->pt);
> >  	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
> >  	synchronize_net();
> > -	dev_put(dev);
> > +	netdev_put(dev, &b->devtracker);
> >  }
> > 
> >  /**
> > diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
> > index 41eac1ee0c09..1adeaf94aa62 100644
> > --- a/net/tipc/bearer.h
> > +++ b/net/tipc/bearer.h
> > @@ -174,6 +174,7 @@ struct tipc_bearer {
> >  	u16 encap_hlen;
> >  	unsigned long up;
> >  	refcount_t refcnt;
> > +	netdevice_tracker	devtracker;
> 
> Hi Xu Xin and Yang Yang,
> 
> Please add netdevice_tracker to the kernel doc for struct tipc_bearer,
> which appears just above the definition of the structure.
> 
> >  };
> > 
> >  struct tipc_bearer_names {
> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Given review of other, similar patches, by Eric.
I think it would be best to confirm that this patch
has been tested.

