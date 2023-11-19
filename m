Return-Path: <netdev+bounces-49026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C87F06FA
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A181C203A7
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA712B75;
	Sun, 19 Nov 2023 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isHlqJcv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5991118B
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 14:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D0C433C8;
	Sun, 19 Nov 2023 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700405940;
	bh=v+bvGDCc4H/R+9epB47olgye+C8PmWk6XJjP7gmBq9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isHlqJcvMuPPA4IL50CSAYqCXWHK73zv5/pYMAN1OYhz6Q3EBOI4pwifUzGQMpvDY
	 IntzhlSDCs3P0ULl0nQKrsriakmQXkBwqKVoVvq6kgedGTbUH2eY5YlOoyqz4OjrgN
	 3oQdL4xG6PZbFl2mKNrCYXT+P3CEpf5KOFS9DEERZwvqIIGd3ef3R+xZvmhVW6Bqee
	 5C4lqceib9OoeqgOJHD7wdHigKQKyeZ/IZUrnFKvEco2bM1mmeNN35bkwj5WVTvAVD
	 gebQ42Trj0O4hRzjkIK9GDav2ddHfvpYG7asoiNDvuFhICuQCoaYo+ncYhqvCQ+bzB
	 agfTqgEqqy1jA==
Date: Sun, 19 Nov 2023 14:58:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
	sdf@google.com
Subject: Re: [patch net-next v2 6/9] netlink: introduce typedef for filter
 function
Message-ID: <20231119145855.GA186930@vergenet.net>
References: <20231116164822.427485-1-jiri@resnulli.us>
 <20231116164822.427485-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116164822.427485-7-jiri@resnulli.us>

On Thu, Nov 16, 2023 at 05:48:18PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Make the code using filter function a bit nicer by consolidating the
> filter function arguments using typedef.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - new patch
> ---
>  drivers/connector/connector.c | 5 ++---
>  include/linux/connector.h     | 6 ++----
>  include/linux/netlink.h       | 6 ++++--
>  net/netlink/af_netlink.c      | 6 ++----
>  4 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 7f7b94f616a6..4028e8eeba82 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -59,9 +59,8 @@ static int cn_already_initialized;
>   * both, or if both are zero then the group is looked up and sent there.
>   */
>  int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
> -	gfp_t gfp_mask,
> -	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
> -	void *filter_data)
> +			 gfp_t gfp_mask, netlink_filter_fn filter,
> +			 void *filter_data)
>  {
>  	struct cn_callback_entry *__cbq;
>  	unsigned int size;
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index cec2d99ae902..cb18d70d623f 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -98,10 +98,8 @@ void cn_del_callback(const struct cb_id *id);
>   *
>   * If there are no listeners for given group %-ESRCH can be returned.
>   */
> -int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
> -			 u32 group, gfp_t gfp_mask,
> -			 int (*filter)(struct sock *dsk, struct sk_buff *skb,
> -				       void *data),
> +int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
> +			 gfp_t gfp_mask, netlink_filter_fn filter,
>  			 void *filter_data);

nit: It might be good to update the kernel doc to account for
     group => group.
     Curiously the kernel doc already documents filter_data rather
     than data.

...

