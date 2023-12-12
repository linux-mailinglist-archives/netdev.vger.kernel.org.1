Return-Path: <netdev+bounces-56581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D631C80F7D1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FDB1C20D20
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C363C0A;
	Tue, 12 Dec 2023 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNDfBZtm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9163BFE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D5C433C8;
	Tue, 12 Dec 2023 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702412682;
	bh=5QKrP33RNHUW+AVJ4mhyRwPnIxe50o8avPSyIXC3aQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iNDfBZtm5g6+XvyQ0FTWD/I+f4bH7ww+Bdfi/X7QrxY9GHyERHmPRLLg9K+pUHtNx
	 ZpS2Mon8105fm63DpCAIGQsJMjvEfGL/RJmrgWNPEJaIH6vV8B62cR0M8xIijIs8BV
	 //Kn9g34wS4XXCMZwarEbe5AoH4aHznbxasMeqkKMJbQ0OwiY+JBxxtsnnibgpoBqI
	 piksAhn7J/zAhGogKvv7uYxMLR+NxYPAT9aiGsnXwRJR4wlnHhIIWpoyCutJ0IBwpV
	 1f21l9AigFhdftFWxxi6QrT1Rn8meEP3VA+h4dIKaoe2oIpsKr9uc8pUOKxtwzYWCU
	 p6HqZFQ22cIbg==
Date: Tue, 12 Dec 2023 12:24:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20231212122441.7c936a28@kernel.org>
In-Reply-To: <20231210010448.816126-2-dw@davidwei.uk>
References: <20231210010448.816126-1-dw@davidwei.uk>
	<20231210010448.816126-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Dec 2023 17:04:46 -0800 David Wei wrote:
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index bcbc1e19edde..3e4378e9dbee 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -364,3 +364,13 @@ void nsim_bus_exit(void)
>  	driver_unregister(&nsim_driver);
>  	bus_unregister(&nsim_bus);
>  }
> +
> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)

nit: s/get/find/ get sometimes implied taking a reference 

> +{
> +	struct nsim_bus_dev *nsim_bus_dev;

new line here, please checkpatch --strict

> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
> +		if (nsim_bus_dev->dev.id == id)
> +			return nsim_bus_dev;

You must assume some lock is being held so that you can walk the list
and return a meaningful value? :) Please figure out what caller has to
hold and add an appropriate lockdep assert here.

> +	}
> +	return NULL;
> +}

> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct nsim_dev_port *nsim_dev_port;
> +	struct netdevsim *peer;
> +	unsigned int id, port;
> +	char buf[23];
> +	ssize_t len;
> +
> +	nsim_dev_port = file->private_data;
> +	rcu_read_lock();
> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
> +	if (!peer) {
> +		len = scnprintf(buf, sizeof(buf), "\n");

Why not return 0?

> +		goto out;
> +	}
> +
> +	id = peer->nsim_bus_dev->dev.id;
> +	port = peer->nsim_dev_port->port_index;
> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
> +
> +out:
> +	rcu_read_unlock();
> +	return simple_read_from_buffer(data, count, ppos, buf, len);
> +}

> @@ -417,3 +418,5 @@ struct nsim_bus_dev {
>  
>  int nsim_bus_init(void);
>  void nsim_bus_exit(void);
> +
> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);

nit: let this go before the module init/exit funcs, 3 lines up

