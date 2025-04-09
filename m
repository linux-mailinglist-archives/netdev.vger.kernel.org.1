Return-Path: <netdev+bounces-180558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015DA81ABA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C80423C19
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C314F104;
	Wed,  9 Apr 2025 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYf/odCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F871DA3D;
	Wed,  9 Apr 2025 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163702; cv=none; b=EGldtvdAvIXQS204KqX5oaFgN3uFnVDqVoq5x9FAX1Dqxz2B3jmv3F440H1YOL6K8U/9Luv08d+m1ptRpie/qwkbrt9MAA846L6PiOChAVKkGG3TqnqnAGcEdxdLYcZ1qg7T/ajUVdAqtWP98XhTvNvoZwn/tBGdRXZc4QIK/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163702; c=relaxed/simple;
	bh=okOXYao6DCXheqkK/pSNdPPi4Vs2eLrOY8xjPJnxzUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BohjUwEeb4D3GymN0b6O6+sCstEcAumkO7hz9g0RsgIy4vwrNgiB1TCIrKKJH/ljwdLoDyYDryXBnhg5Bqv0XQekZG4c9UDSjzusLRtN5JuC/U/F3PP6UD7GvHujjrVN01AIno49tWYjzU+Arbe7S1GObDK6c34TbhszIUHXb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYf/odCK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2295d78b433so62073035ad.2;
        Tue, 08 Apr 2025 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744163699; x=1744768499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecfk7A1VuHZvFw9X5kyaP5/sRS/P8UAD+FOYHdFb4UA=;
        b=XYf/odCKCk4vgYEOyzYkeviWLkUn9CfxFLX8PIbKeRbWycMNBKoNtHyiYJkeOjq1I8
         34v7tVD+JU43jkEl5EUZJg2g4j+SWmQ6yLO10yL3+hdTGLDmkEbriDyzyce5NosXlY1g
         DWEgyen+Tyie5vXQacoClBOZ7Wy5ktlh7VXZGZ4rkx0lFFGP0swnJdFeRYMG4F9m8no9
         O5PmPVhW/68LB7/jvSWR40oQZZqCLIxDhATGJQqJLZcAyYFkgK8tkmSVcy/Skl0jCVn7
         1038SnRppVESKkyzHj1ri2KUDToCCZmSk4pX9ljQH3xo1BJK5zkhITt7+37FpNh/oaLj
         D7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744163699; x=1744768499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecfk7A1VuHZvFw9X5kyaP5/sRS/P8UAD+FOYHdFb4UA=;
        b=Nc06bKnUguGgii1ScvaPj5WQny6q9TSB0u9ZX7vk4IcqHsV1mhChUyMASsyjJZQEoN
         aSgb/2MWtfIdSx/3/+HJhH0LbQ3r+54D+omOFhQUaHZYdeJzA64RpUkQapLFbhhS89bE
         bzpTXtXNk0ELRDr4j3SLz0lOM/eRan8kCxL7jctK76shGt2P4PvDlAjwD9hKqwFQs6EL
         dvMBpZ3mXupoX08Fuh/JhtPOW3DMaJkqhKFKWQYCWGc7QSTmgctx4SKhAdQUNKFirOKO
         iiJDelvDYwjA6Wzd3GUENktEm8PXE6JoAF5YOmgbP19WVJ/eTzXPj/BO4b1cMdz9uqAD
         tRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBS07L2vbNtANgZFeXSxFDyKsFPjKqAS3jMwXVpR+QWOrBR0W8EKGZhZLW7+NAM6CRXJ48gsiqojFAIsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffUoFugn2I2yBqSX1s5XSBcTmbV6pfqqxZpZFi9O3d4QoembA
	E+bkFq1TBJ48lX/uFqPOgJwaGoNBx/0Z3c2LkNFm7xq1cLb7Js1D
X-Gm-Gg: ASbGncuxPwBDsDNqS/oZgE1xJE/V8uA8h14k/drPHOimB+nsjNOOTAsYg4/h38BqGRC
	qneFitwVjbZk99fDE4TJUxczoLjaDp2d6Vqvbzs0aumEY9ab8/W9cabpzK4qtz1YuzKUU51J1Xj
	9EUjyfL5VqB/FjgAeoPRLs+k3r3ZCXGL8OetAHhNrTuyFwIjO3jhjj7vRSZgKmZnK898OAE5KVZ
	fI6/67XWDJ9/s4Xz+kCfwK9gJRkxbAKycTjJN6/mWglp8tUqfZAsd2Lp9Vmu7beG/f8WemMWRck
	A8mPDSn391FU6dGgsAmUSNoq7xUVZ2+/iICkp1wLxwa6fIHxtQ==
X-Google-Smtp-Source: AGHT+IFGsjE3PgWhLx5PrZvVTa6fEbaz7ne//qmQHKzSVbrqs2RdMuI4dgE0IFncJJwWLIXSyXMH7g==
X-Received: by 2002:a17:903:2a83:b0:21f:7880:8472 with SMTP id d9443c01a7336-22ac3fee49amr14239395ad.35.1744163698992;
        Tue, 08 Apr 2025 18:54:58 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62ba5sm273515ad.14.2025.04.08.18.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:54:58 -0700 (PDT)
Date: Wed, 9 Apr 2025 01:54:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jv@jvosburgh.net,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net] bonding: hold ops lock around get_link
Message-ID: <Z_XTbBJFjXMCcyrH@fedora>
References: <20250408171451.2278366-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171451.2278366-1-sdf@fomichev.me>

On Tue, Apr 08, 2025 at 10:14:51AM -0700, Stanislav Fomichev wrote:
> syzbot reports a case of ethtool_ops->get_link being called without
> ops lock:
> 
>  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
>  bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> Commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> changed to lockless __linkwatch_sync_dev in ethtool_op_get_link.
> All paths except bonding are coming via locked ioctl. Add necessary
> locking to bonding.
> 
> Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/bonding/bond_main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 950d8e4d86f8..d1ec5ec6f7e5 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -850,8 +850,9 @@ static int bond_check_dev_link(struct bonding *bond,
>  			       struct net_device *slave_dev, int reporting)
>  {
>  	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
> -	struct ifreq ifr;
>  	struct mii_ioctl_data *mii;
> +	struct ifreq ifr;
> +	int ret;
>  
>  	if (!reporting && !netif_running(slave_dev))
>  		return 0;
> @@ -860,9 +861,14 @@ static int bond_check_dev_link(struct bonding *bond,
>  		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
>  
>  	/* Try to get link status using Ethtool first. */
> -	if (slave_dev->ethtool_ops->get_link)
> -		return slave_dev->ethtool_ops->get_link(slave_dev) ?
> +	if (slave_dev->ethtool_ops->get_link) {
> +		netdev_lock_ops(slave_dev);
> +		ret = slave_dev->ethtool_ops->get_link(slave_dev) ?
>  			BMSR_LSTATUS : 0;
> +		netdev_unlock_ops(slave_dev);
> +
> +		return ret;
> +	}
>  
>  	/* Ethtool can't be used, fallback to MII ioctls. */
>  	if (slave_ops->ndo_eth_ioctl) {
> -- 
> 2.49.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

