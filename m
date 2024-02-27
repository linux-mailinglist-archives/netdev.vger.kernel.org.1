Return-Path: <netdev+bounces-75426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE1869E4F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69231C23018
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4324E1D9;
	Tue, 27 Feb 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd9+Qyxb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C814E1CB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056366; cv=none; b=txq74gTVRCDqj226Zs96AYdGFBBjj5P9w1Up4iDB0bmcrffCBdf3z0rMX7iVpYmPqUHckE/1DyTbm211tWmFK4TfDYUNULxvoBxS+qH15LAc5L695/bYCksdtHCvUxvsnhHcCXNTRph1O6FVKRrHXPExbd0/d5+JjSM8VaW7SnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056366; c=relaxed/simple;
	bh=HgmXVV3YwiFT2yGyjd27jeBTpRE40AUN1MX0HOXfzvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eccOZgUMNvqrePcEx5c/+l8amPuQVOav00FTlKfQYMmbz3EWA9/D4eICxjEmWGxLqN4jJPEzaWHEHtoZE06uBDO+Do9ujy8n4lWDv+hOR22F1jHIubzwDL5M6Knm5iOFwqztu5XPCMAYudk3HGbxp5H+ExzJdOq8W1OGIv29tYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd9+Qyxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90953C433F1;
	Tue, 27 Feb 2024 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056365;
	bh=HgmXVV3YwiFT2yGyjd27jeBTpRE40AUN1MX0HOXfzvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sd9+Qyxbhd5MNXpcuoaqQHmuCkaSOcaXYFc3txYdtByyNb3Uah7nDZrSjcIfZh6CE
	 QQvvSryeoPKtr79kDOUjS82cUlN39MkdI1oubzQuNy0XB1INfH8GhCbabrW/0UQ8B1
	 waCBVzN8/rQyZFr1naFsgupbFSfbclxH+4YJlgMdIPfQrpauyZ6kz/JP+cT1N6xuv7
	 +eInq3ofiGTfgRZ5PjPlw9GTTvxtjxlXiO2x4HUdiGB+Euil1kI0uFqWeBo5Ow+vRF
	 keeVylPs7DH7NTb9DhkjtKjTe58dDQYYRiNhu/khSrnUojiJSwLud9e1ymXGOLiIVM
	 17cVA1lwIk1NA==
Date: Tue, 27 Feb 2024 09:52:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Zhengchao Shao <shaozhengchao@huawei.com>
Subject: Re: [PATCH net-next] netlink: use kvmalloc() in
 netlink_alloc_large_skb()
Message-ID: <20240227095244.23e5a740@kernel.org>
In-Reply-To: <20240224090630.605917-1-edumazet@google.com>
References: <20240224090630.605917-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 09:06:30 +0000 Eric Dumazet wrote:
>  struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
>  {
> +	size_t head_size = SKB_HEAD_ALIGN(size);
>  	struct sk_buff *skb;
>  	void *data;
>  
> -	if (size <= NLMSG_GOODSIZE || broadcast)
> +	if (head_size <= PAGE_SIZE || broadcast)
>  		return alloc_skb(size, GFP_KERNEL);
>  
> -	size = SKB_DATA_ALIGN(size) +
> -	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -
> -	data = vmalloc(size);
> -	if (data == NULL)
> +	data = kvmalloc(head_size, GFP_KERNEL);
> +	if (!data)
>  		return NULL;
>  
> -	skb = __build_skb(data, size);
> -	if (skb == NULL)
> -		vfree(data);
> -	else
> +	skb = __build_skb(data, head_size);

Is this going to work with KFENCE? Don't we need similar size
adjustment logic as we have in __slab_build_skb() ?

> +	if (!skb)
> +		kvfree(data);
> +	else if (is_vmalloc_addr(data))
>  		skb->destructor = netlink_skb_destructor;

