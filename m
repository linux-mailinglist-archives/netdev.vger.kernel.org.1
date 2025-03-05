Return-Path: <netdev+bounces-172183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C25BA50A49
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9887A9483
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C8252907;
	Wed,  5 Mar 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YdKISRre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208241DD9AC
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200657; cv=none; b=JUJU7HuVkm6GUbYKeOOvIZ/QlmGoXu44TUvbeh5Tyl2GAf5ouD3yjjx26PT7nR8llji4nbyq4I+48LymDdM/Z2fzENP02UKCJfwLsAmVt6BYfK6tUdtUPnn5b2qjFfO5POoKQoh2SrIEQ2Qt91sQ5fEmlR/ZfQJbUaR8dKnRxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200657; c=relaxed/simple;
	bh=QbaAYVsuHtR4sFbwYlItPyeMtj1+0TldiW7il+PRxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+K3YoaBqGQHljP9Nx3QMVtzk1qILXdA+EWScPiHuywW2/wFqX2sEskuVTp7IOHbRFy/oTQ4yr/ge9f3dq6w/YwNdOMX72lp+KSQU38YAlxC6d60LGbhq9V5f7hktexCCzA1j6SwpSiL4U1uSOO/hs3oZlDcP0mJzzARgHXNws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YdKISRre; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e41e18137bso56188856d6.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741200654; x=1741805454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=YdKISRre2vQzP5L91LnjrMPLlIWIMUyv0FCKNrb8H8ZEwRFG3hWoxi3tw6UQImAN8P
         dC2T8/fDqHcn71EDd95kew5KAHCLbRwWCmexzmO8KLYbo76tEQX/rL+/kFE13HKznSXJ
         VPIvClo7wJ+3I28B+lVMxtM19Ei0Rhm8tDZojPF9tqbMc+e8OOrMiHTNSgHxNPlw5Rxr
         Vy16yI2bw8ut1ptKtqydSYdWwQSjMtnzG3m6YpR914NO6TEEAmife16dDa1QUsA40Exw
         D+fz4MvGGySafE1nvAuaB1u0tWCggL2iFCW27B0Lh86hakThRBKcKgstH3wz4mk1Bz2X
         HM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200654; x=1741805454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=WosVEdoH4qyNri4Musndp0Ixmi+EtDLSNqjH839QE2VNHQeiFjVoKHTAbDWqMaU9I7
         hwRgL0/955cYslT3CrHNsvPRkCOU9wAx2U2qQO2l7P3Q3iHuI4NAejIvz8TpOEqKCIew
         nBaC+uwMnt0fyBcjIVPtGdBnubAZnTQ+122BgrM1qEb1KpxhR4u1FXb4su8mGv52pt8U
         B1OkiVGjwPM0FSXq0IsMsmzE28kafXoTjnKM18fnekPxuI6m0r0GkP7M9VLnySPQcuUB
         TIeXa/Q4K2O3AkgHUgvMIWYw8PmNCTaEQTxoygnuYbGJgO+uKyLrcehjJL3W9IhzGw61
         y6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVfWMaCy6BVmoEEOwhbLNfvIQEZqpfoiWDmpXjG8AjWhbZC+yfvDdueKSQ7TyqKbkgYMn0ecms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuY00+oaYY1t7y94qi1qG8agYiSzZcan/Czb/CD7PuJf6vqcV
	ubvnqMvBI1WQUpykYQGPDKOOXVveqMxEoQ/VMBYV9DB2Kjn03uJn0EY8bVCBfdM=
X-Gm-Gg: ASbGncskKqT49IX43ASXJuIJcUG71Ule+HZcfxcMNVRSfhP2bQHTM7kRZzApjYhRqbe
	3DreRw9ArmQfNuQ39WWBllmemXpzP8UH2dSoVHOXRXdaUlp9BvOC+UiQdD/wNXq37jx4muH6CXE
	3dBTGQkAttQ2ceJIviQhYGgM8vKUAGyl3LnzvOlmPorfFOzO076lUl+4pIsLpc0PMT20LhVMtwy
	I+qoffsvuqrGiFRnDo5luxtAO6NVbaQ9QhB93nYYTaCpXIh5EhdqbYhJnUMfKx4xSxZOIB8H4qX
	lJUM0b1NUI8gfqblpOc5CM1W9q6YZ7LELjP2pLIgszeqDtRLWpyYc5W6H5ZsBWXy7yHHG0lCdEf
	iKMOez4nLp1RHFQMNeg==
X-Google-Smtp-Source: AGHT+IHBfk4VjAwwmewmwy7/cD04QxrX3NO7CkQZxs6uiHniAKBSHBOE/omselhSlxfJQQW6JbT7mg==
X-Received: by 2002:a05:6214:518b:b0:6e6:60f6:56cf with SMTP id 6a1803df08f44-6e8e6cfffa9mr54007756d6.5.1741200653911;
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e8f52086sm10432506d6.63.2025.03.05.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptpU-00000001UT9-2uWT;
	Wed, 05 Mar 2025 14:50:52 -0400
Date: Wed, 5 Mar 2025 14:50:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [patch rdma-next v3 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-ID: <20250305185052.GA354403@ziepe.ca>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>

On Tue, Mar 04, 2025 at 04:00:01PM -0800, longli@linuxonhyperv.com wrote:
>  
> -struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
> +struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index)
>  {
>  	struct net_device *ndev;
>  
> -	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> -			 "Taking primary netdev without holding the RCU read lock");
>  	if (port_index >= ac->num_ports)
>  		return NULL;
>  
> +	rcu_read_lock();
> +
>  	/* When mana is used in netvsc, the upper netdevice should be returned. */
>  	if (ac->ports[port_index]->flags & IFF_SLAVE)
>  		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
>  	else
>  		ndev = ac->ports[port_index];
>  
> +	dev_hold(ndev);
> +	rcu_read_unlock();

That's much better, yes

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

