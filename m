Return-Path: <netdev+bounces-155867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8725A041D8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEC1880586
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A791F63CB;
	Tue,  7 Jan 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrNyy86F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA41F193F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258685; cv=none; b=ouuhi7jtjT58a+qVPAzuIldF9mb1BHxJLtHbWlKAFSZxIVLoxmjhgSN5u+/F1zyy3JWhTQsRmkIC1GUDzgeXB0RqXJNyA+KrrafFD5E/MConYqYV+z8mXbWDMt37fFkyorDqfEiB7fOXyFNgTJwdXGxHQVRSX1h7qVo+a/MPc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258685; c=relaxed/simple;
	bh=DIY8vao4QtAPJfwzY459P6zGPnoIjnMU3IQuu4NQVPs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PhNbHZPmSk9R+O4Bg4+49YUFnrxCiRruTzOpyM7PfqWkYu83DiuWgScu5KlwRM+yI+XXXSayShRL9nWBWdVD99FtyNwDLHYgvHK/cwppD44YWHcshOl9b2F3XifM2rBYsgEEA1/BDAWNKsoWjqS2Iy+Hn6A/M/mTGF9WIg/49so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrNyy86F; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d92e457230so149712616d6.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258683; x=1736863483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+LSgPUthhPJPOWHi9eTVM/UW9ph3Ri2nhGH2OteeSs=;
        b=OrNyy86FLSmN4NMG+Yb1bdfo1rh7JG1LlGEuY5Xs1j0Xhoy+uilrgz5JZrCIvzgqb9
         OPapV7W9mXNxp/HRIK2I1Z8N98xipeM6BeoriVOSkwLoluNAZLNhxvi1vHPsx57Ej2W7
         Yox+0Vzc/7cFd1/4RrBclZvsDx0LszZ0O9WpUurbbwCAFk2Qcp9fws+Tf/ok6RWp4sXf
         EYh+cLAbD4CaU57SVTuXf2ebEhltNqvi1ZMBsjQ6WecpEP0P/uAsEjaY7w0WJ8am//ll
         xwV53OSZVD9/yhEg6MwcCwjGXIjoEf887A6Rysu7nlqjyscCHdrEghevrVtQU0eGwk0K
         ejAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258683; x=1736863483;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+LSgPUthhPJPOWHi9eTVM/UW9ph3Ri2nhGH2OteeSs=;
        b=ojP7TFQ9bJikZLutECRqWa5+mWneBkG6bu9IoIoANSmQ995yBesop4+e4lRBhqIYSp
         7hqvOoPwdA9weHOZhniaeV5yJVIrFxofkMMSRzpw/+DgH30GY4J9QgY7QVbzGATy3nT9
         XJiZC8i9FQxZY2zIuIIdbTDk8oczkgZO8JPMcC+ysDEACHdEUfwkYJxtRoBTtx41JV1+
         HAHKq0pRMWrMNUL9p4+UstECJ1ubci2IdxVF5A7Ri3E8b7P7eZpo623nia+nm88BhEkb
         R73DpdYuptgZP83uXG7/tnVI9zlsQWhNquQF2KE5eOhbWvvHYGy7/9FqRtTHnDG5gzFW
         AlJg==
X-Gm-Message-State: AOJu0YzA3BvayNKWW5LaslHchE/L4F1aIo0JoQvszJOVItOwN6r7vq0O
	aO05PVFOGuzfeO4nyHi9+GyXRPzgmVXxQRK4tvTwkdG+4z19MQktE9e40zL6
X-Gm-Gg: ASbGncsKVdS3PZITu2MZAhjbYhGiwwyBBl/EQ+R6mEVjTi3luMM/hkumQgC8geQFjPv
	FCVxnjk1WRMsOwyhk/eSExlJQ5nL3il1GyoJ6nXC/dlrbdfNXoQcgKjHPuuv2XHbrR1KMVaa9jC
	+BJdNXppV1/0dzWYO0ucK07XNxoFXB6PhV/8AKeMEzNVNjUBO6mVGn+Y1FgnNS22rhF3hwwsDIY
	mbwVrFPa98E4h7helUWeNalhc9Ww4G65lrKKFgIRbTnGQ2BVV8v3TUam8DpUXl6d019zduzhx/F
	hUi9TdEGHkM/kbWe65B/girEVsK5
X-Google-Smtp-Source: AGHT+IEPNdKw+huZchOjqLjvDKpBL6RvQBzIejuEN99MXyokYuymgV3Qfj63+njqU7Eg5nD0L/vYVA==
X-Received: by 2002:a05:6214:449f:b0:6d8:7a7d:1e6b with SMTP id 6a1803df08f44-6dd2331efc0mr1128356286d6.10.1736258682949;
        Tue, 07 Jan 2025 06:04:42 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm181521396d6.61.2025.01.07.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:04:42 -0800 (PST)
Date: Tue, 07 Jan 2025 09:04:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dw@davidwei.uk, 
 almasrymina@google.com, 
 jdamato@fastly.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <677d347a2c5d8_25382b29488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250103185954.1236510-8-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-8-kuba@kernel.org>
Subject: Re: [PATCH net-next 7/8] netdevsim: add debugfs-triggered queue reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Support triggering queue reset via debugfs for an upcoming test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 55 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 86614292314a..65605d2eb943 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -20,6 +20,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/netlink.h>
>  #include <net/net_shaper.h>
> @@ -29,6 +30,8 @@
>  
>  #include "netdevsim.h"
>  
> +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> +
>  #define NSIM_RING_SIZE		256
>  
>  static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> @@ -723,6 +726,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
>  	.ndo_queue_stop		= nsim_queue_stop,
>  };
>  
> +static ssize_t
> +nsim_qreset_write(struct file *file, const char __user *data,
> +		  size_t count, loff_t *ppos)
> +{
> +	struct netdevsim *ns = file->private_data;
> +	unsigned int queue, mode;
> +	char buf[32];
> +	ssize_t ret;
> +
> +	if (count >= sizeof(buf))
> +		return -EINVAL;
> +	if (copy_from_user(buf, data, count))
> +                return -EFAULT;
> +        buf[count] = '\0';
> +
> +	ret = sscanf(buf, "%u %u", &queue, &mode);
> +	if (ret != 2)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	if (!netif_running(ns->netdev)) {
> +		ret = -ENETDOWN;
> +		goto exit_unlock;
> +	}
> +
> +	if (queue >= ns->netdev->real_num_rx_queues) {
> +		ret = -EINVAL;
> +		goto exit_unlock;
> +	}
> +
> +	ns->rq_reset_mode = mode;
> +	ret = netdev_rx_queue_restart(ns->netdev, queue);
> +	ns->rq_reset_mode = 0;
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = count;
> +exit_unlock:
> +	rtnl_unlock();
> +	return ret;
> +}
> +
> +static const struct file_operations nsim_qreset_fops = {
> +	.open = simple_open,
> +	.write = nsim_qreset_write,
> +	.owner = THIS_MODULE,
> +};
> +
>  static ssize_t
>  nsim_pp_hold_read(struct file *file, char __user *data,
>  		  size_t count, loff_t *ppos)
> @@ -935,6 +986,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>  
>  	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
>  					 ns, &nsim_pp_hold_fops);
> +	ns->qr_dfs = debugfs_create_file("queue_reset", 0600,
> +					 nsim_dev_port->ddir, ns,
> +					 &nsim_qreset_fops);
>  
>  	return ns;
>  
> @@ -949,6 +1003,7 @@ void nsim_destroy(struct netdevsim *ns)
>  	struct netdevsim *peer;
>  
>  	debugfs_remove(ns->pp_dfs);
> +	debugfs_remove(ns->qr_dfs);

Only since being respun: perhaps free in inverse order of alloc

