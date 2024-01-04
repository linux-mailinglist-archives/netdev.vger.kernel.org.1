Return-Path: <netdev+bounces-61423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6423823A4A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D20287EF4
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0582E136A;
	Thu,  4 Jan 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlsPkO3V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC9A5F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5EBC433C8;
	Thu,  4 Jan 2024 01:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704332369;
	bh=2hkBI0y3z9i8ntdp7UkkjyMXku2zmzMHERBePUkgSZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KlsPkO3V2lZUm4m4Lx7GV9jePknVlyS6BNg5OoaPCAN69plqlWeUP2csbyrxCYmBV
	 gao1cG0/AKnodUSE8u5Ho3tIViErSZILmu0Ybs7EEoQLW+dlT9ZdQ53yuDHLQxZXac
	 4f8ZnQXhWpduqm/Ya71WM4gSf9rWzT+nm/+bH07iavPGMymCfutIuJ4j9S+QCc8SeX
	 duj4OE+GNDyoYA+b5o9D+8jL6VByzPQCi6ZYIc35NyNVSlM1ILgUkijrKJAjpjRKNF
	 /+pjbx1v9nytHnnL6a4vFPrHMTN4zOnj/kVjZCPalnKe/Ih5J04wchF6VfjNww/WCE
	 SsfwRP69VdJCA==
Date: Wed, 3 Jan 2024 17:39:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20240103173928.76264ebe@kernel.org>
In-Reply-To: <20231228014633.3256862-3-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
	<20231228014633.3256862-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 17:46:30 -0800 David Wei wrote:
> +static ssize_t nsim_dev_peer_write(struct file *file,
> +				   const char __user *data,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
> +	struct nsim_dev *peer_dev;
> +	unsigned int id, port;
> +	char buf[22];
> +	ssize_t ret;
> +
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;
> +
> +	ret = copy_from_user(buf, data, count);
> +	if (ret)
> +		return -EFAULT;
> +	buf[count] = '\0';
> +
> +	ret = sscanf(buf, "%u %u", &id, &port);
> +	if (ret != 2) {
> +		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");

netif_err() or dev_err() ? Granted the rest of the file seems to use
pr_err(), but I'm not sure why...

> +		return -EINVAL;
> +	}

Could you put a sleep() here and test removing the device while some
thread is stuck here? I don't recall exactly but I thought debugfs
remove waits for concurrent reads and writes which could be problematic
given we take all the locks under the sun here..

> +	ret = -EINVAL;
> +	mutex_lock(&nsim_dev_list_lock);
> +	peer_dev = nsim_dev_find_by_id(id);
> +	if (!peer_dev) {
> +		pr_err("Peer netdevsim %u does not exist\n", id);
> +		goto out_mutex;
> +	}
> +
> +	devl_lock(priv_to_devlink(peer_dev));
> +	rtnl_lock();
> +	nsim_dev_port = file->private_data;
> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
> +					       port);
> +	if (!peer_dev_port) {
> +		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
> +		goto out_devl;
> +	}
> +
> +	if (nsim_dev_port == peer_dev_port) {
> +		pr_err("Cannot link netdevsim to itself\n");
> +		goto out_devl;
> +	}
> +
> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
> +	ret = count;
> +
> +out_devl:

out_unlock_rtnl

> +	rtnl_unlock();
> +	devl_unlock(priv_to_devlink(peer_dev));
> +out_mutex:

out_unlock_dev_list

> +	mutex_unlock(&nsim_dev_list_lock);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations nsim_dev_peer_fops = {
> +	.open = simple_open,
> +	.read = nsim_dev_peer_read,
> +	.write = nsim_dev_peer_write,
> +	.llseek = generic_file_llseek,

You don't support seek, you want some form of no_seek here.

> +	.owner = THIS_MODULE,
> +};

