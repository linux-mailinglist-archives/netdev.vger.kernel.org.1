Return-Path: <netdev+bounces-225326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D923EB923F3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E951901F88
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0C3126B9;
	Mon, 22 Sep 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJIrtBjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8373126A5
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558946; cv=none; b=WFVDtepC/7yGTi7G+peZw+93sm/7O22+i/a4TOEZ2hiw3VnhewkQx3JBlAD1+q2S6+4CBQfUNhEHsopM/wuxZxie+ybSiQe8qKMbhKbfu9jX4eu1ZrmkhFquB2d9Dvk/FFJLTU3hvZ9ANopodldzHSJ3H7fsa3ozcvUwkOOWXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558946; c=relaxed/simple;
	bh=sHi7b3T/ZLdvyBIC+qISsiJxbsLBU33rXd0d2LElTu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edp+Z1+xUxhxJr+KgG6hcrZL4BiRq95Or7EgqG9UxsllrZYrzw/eIWaCiywmNmlyvXWXcEptWm/gjPRiH/GoGb8sj9r3GLJD4cBzCIjS4fXOQO7tqGL5hIk/BKa7iXsQG/TgRE2s/EneVij0GCKC0NcRXQ8vspzqdcun8vQ2bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJIrtBjh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3217794a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758558944; x=1759163744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zejsegc+8xqQ9kyy+zjHL2oglb/+dwjs07vbMFj+CU=;
        b=mJIrtBjhHxI1+lPckbVbbgkYZKW1YVd841D7+GyRQlyYpYOL9iSzTWT+rCulWggjdF
         1wZCOY5ocWQ6DsppK9kwpQKAnFAE/TmTl11JhuuE75KMINvJq6wp8UHfPcB1DKTgcF/9
         axN5dOjZ5O7Q/3fzAwY6zJ8vqabBYxDgsi07aMJ9r+op9tLvlMFpSk9fISOSaQWKiHpH
         5yKTURlECIpAiooRGuwqeCMOkBQ7bId+l1H5gaC1kR4N4MIpQvL9rLNnBFhmhBrtrYmx
         +P311ZmfT3XsAGGvh7zJs37L2dtnlttyQHUg0OJskhK8cqZfgUR54rxqziw+DD1hclw5
         KB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558944; x=1759163744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zejsegc+8xqQ9kyy+zjHL2oglb/+dwjs07vbMFj+CU=;
        b=MkCmq0fbmH2yRSZqyKEm4sqNXRssXu5jDDT7S4ynpKfNa6UUCbY/b37dEWnd6EHYl1
         gxxAWrsoBT61n39ResigV1ngmAY2hWBtNYK+RsV4Z473gSspwUx4jYobSVQepWdXcFq6
         4FJUZbI4l4adMX1L5lHuvNQffOl6t4XePI2oLgovk3FIEbeYY7EXcwLRb2bNSnwCN/+O
         EcESFQYsOiF/2YcYZMsW1Oupt9fcweSzKLif8sMs1PybmnpNdUCFCmOpxmS8cDWZFO3N
         pGjwoKmOjNky6Ix5+Wg6PbZhBLXZ6FrJ5idGrpyLhiqBNe8usLCXsWg7x2htbCQ2axQJ
         uWJg==
X-Gm-Message-State: AOJu0YwnK4TUC57HLSS/mnOwJGKzzWsbN1yAVDLFKYCdcK68fBF8ZKyu
	shq/nMeRiCWIuA5h1yfBHk1lhx3pyj9kljstjwHt66hP/Bonk0Sy5S8=
X-Gm-Gg: ASbGnctVo724+DqUHZ9uENulr9VWftdwi3rZxXeT82EG3AgfzgQRolzMR3V7opk8U5e
	RnioGYOdCPuRSWztrTcr4MjwLYvW/DI1vkc7IWYQNYcPOivJj0v4Nw4HNuCp8/HFCfcrMUEYIF8
	Yei7U3kYCzf5WMblfZ+2rOdn90/DJgbkLBeAW7JFZdNX9a9WBiGYXXf2+waIYTKms8KAb6N/CXq
	7NHHKkZZkrTJbwMW0djuzBJrK0HXo9iXp6eFcYU9kZjlrbJ8aYOyF0VMGgDhlQySE1qMhjjXtf7
	Y7ghm9j1IwyLUSjR3gS9gMd5URKog6RlJa0GigF7FF2E4tMqQA+zBDEUmgmtKRrcPcoLb89uwCz
	iD08qDHeofas9QKB6Z1/eFonX0W84yzs60kslQJcqbNVawgmpTwYmvop5QNHhGDpQGgkFs9ZVda
	RVpMlVLkl4e0Z6GMCT0wBzHtpO0iRUCkladFKtzDFL9YLwRCfgOv91e1akIkfxf9AS3ojU5eCQF
	mtA
X-Google-Smtp-Source: AGHT+IFSgdA/KR+aImb49Fk/fhScu517VMdwG6QqqWoN6p6yvorjbtv7g5EjG9hpo3GZPKyxvG5GkQ==
X-Received: by 2002:a17:90a:d44f:b0:330:7f80:bbd9 with SMTP id 98e67ed59e1d1-33098385c68mr14019658a91.31.1758558944102;
        Mon, 22 Sep 2025 09:35:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b552fa85110sm7698823a12.45.2025.09.22.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:35:43 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:35:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 08/20] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
Message-ID: <aNF632NGqn893xlJ@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-9-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-9-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  net/core/netdev_rx_queue.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index c7d9341b7630..238d3cd9677e 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -105,13 +105,21 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  
>  	if (!netdev_need_ops_lock(dev))
>  		return -EOPNOTSUPP;
> -
>  	if (rxq_idx >= dev->real_num_rx_queues) {
>  		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>  		return -ERANGE;
>  	}
> +
>  	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> +	rxq = __netif_get_rx_queue_peer(&dev, &rxq_idx);
>  
> +	/* Check again since dev might have changed */
> +	if (!netdev_need_ops_lock(dev))
> +		return -EOPNOTSUPP;

But if old dev != new dev, the new dev is not gonna be locked, right?
Are you not triggering netdev_assert_locked from
netdev_rx_queue_restart?

You might need to resolve the new dev+queue in the callers in order
to do proper locking.

