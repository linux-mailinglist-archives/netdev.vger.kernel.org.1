Return-Path: <netdev+bounces-39789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D097C47C5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F3B281CE7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035B4693;
	Wed, 11 Oct 2023 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUlYpObE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39994689
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CCAC433C8;
	Wed, 11 Oct 2023 02:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696991367;
	bh=hm4+topgV2OxqsYmkniSaMi1BBpkXc3jv5Sat8WdBe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUlYpObEjl5pfZC7GGmoG5XqqOkXzrgDCnk2yzNw7EiEno83UdwcyR9sy7prl1+EJ
	 P2JXri4vimTQK5HExYrEKh1YXD8ZrtUaGiyVBJkcoE40vSza1Z6UwJyDBsKRvrkpTx
	 V1ER8EYayJjDZ2ibfEWmwQ2qALfNzHmGXF7xa43ps5Jt3zSj5qJkngrIpienIPyfKe
	 dMSAOtF0HRoox8gslO5Jj+Vh+q2sfBoXr3u+kqb1O/WGyueT6d2SVQPt34IsygB/ev
	 PyiklIgMfUYfL2LOJiR9Ipo0IiDPJGvqZub/JMIwzA4LEFkamekjomCyObvUps2RX6
	 tLgDyIo/DAbqA==
Date: Tue, 10 Oct 2023 19:29:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v4 06/10] netdev-genl: Add netlink framework
 functions for napi
Message-ID: <20231010192926.6d938d4e@kernel.org>
In-Reply-To: <169658371009.3683.2263972635869263084.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658371009.3683.2263972635869263084.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Oct 2023 02:15:10 -0700 Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for
> napi support. The netdev structure tracks all the napi
> instances and napi fields. The napi instances and associated
> parameters can be retrieved this way.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  include/linux/netdevice.h |    2 +
>  net/core/dev.c            |    4 +-
>  net/core/netdev-genl.c    |  117 ++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 264ae0bdabe8..da211f4d81db 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -536,6 +536,8 @@ static inline bool napi_complete(struct napi_struct *n)
>  	return napi_complete_done(n, 0);
>  }
>  
> +struct napi_struct *napi_by_id(unsigned int napi_id);

this can go into net/core/dev.h ?

>  int dev_set_threaded(struct net_device *dev, bool threaded);
>  
>  /**

> @@ -6144,6 +6143,7 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
>  
>  	return NULL;
>  }
> +EXPORT_SYMBOL(napi_by_id);

Why is it exported? Exports are for use in modules.

>  int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct napi_struct *napi;
> +	struct sk_buff *rsp;
> +	u32 napi_id;
> +	int err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_NAPI_ID))
> +		return -EINVAL;
> +
> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_NAPI_ID]);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +
> +	napi = napi_by_id(napi_id);
> +	if (napi)
> +		err  = netdev_nl_napi_fill_one(rsp, napi, info);

double space

> +	else
> +		err = -EINVAL;


