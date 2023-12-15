Return-Path: <netdev+bounces-58093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C781500B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 20:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C79D1F24C0C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6D3FB30;
	Fri, 15 Dec 2023 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Zjx8vriQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834F3FE2C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5913b73b53eso736578eaf.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702667627; x=1703272427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4jZOOTED3fISjUmCLVaEsjs7SardkFmYTmlGlijSa0=;
        b=Zjx8vriQsi16IhzwHM5Wr+JrkA6R1sY6gpaQuvPsCAI8EMowL/R3DgSVSYOpJwKRio
         a1DO+frLNEBkLWSUrPZTEB1qO/eRaG6A47IDtHb73g0zDSWARwIgGvFPM9CfdqjOVydJ
         s71sPITxikatTKhFF+EVm98QM55fBTeM7nYAXWfZKYcwq1zzaogFdVMeDRFr8SPtz0eU
         S76VzJ8YK99SNFFqhvrXddI7WScLnn9ehr/OJzKJS+wMbBNRe0HmXhJnK/HBCjvSZlQU
         ZXiux42prfn+pM9K+pb2JWISdtoYbr2iQrCH2p+I+TVFy7NV3R5Y5PU6c2ZzSBOP1Suh
         KLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667627; x=1703272427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4jZOOTED3fISjUmCLVaEsjs7SardkFmYTmlGlijSa0=;
        b=dZkz4Bdn8JhUaDKn/IMToV9lz4H2kxITf93jUUgeQ2jtGOah/uv7+R+5m5dIIyKYRA
         WJiKVlwCEzCqLHalQA/i5MIq3zNiy8U5KGEq7IYnv0z72o4McWnEzmfOepZyKAnLazbn
         IY2gXE5P36vxCL1rGVBWhUWPxqGb6/wgvqxhgay4tRQ9JwB1OwGH6Vsy4v+cmVili4nu
         9GqfuP9pF9quXXd/Dv60SxB2A/vwplIvNq/wurzXm6JCOikA0y88RDCPu4+zRq9i60p9
         awU0wDGKkSBEC/I/r1f6joniQcs3EqBYHMcmeB3iYV1CwjtVHIALHnWDLBDcfGyqg7k4
         c5Og==
X-Gm-Message-State: AOJu0Yy7leEiHSiVYsAF8XmXq+LyDVW9WrEsj76yYyou82rk09gegIJ4
	iUH1IAoQ/KOSXgiGMYVL4pmTdyksne0aZn+1hfUs9RUm
X-Google-Smtp-Source: AGHT+IFwtLz69CSqHdIxrqxrSe9O9BZk7/jWfnP8QwAk3c1yRXyDz4pDTI38mgq0cf1WeiS0u0BMcA==
X-Received: by 2002:a05:6358:2c93:b0:170:c41c:8107 with SMTP id l19-20020a0563582c9300b00170c41c8107mr13205580rwm.6.1702667627528;
        Fri, 15 Dec 2023 11:13:47 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:b356])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006cde7dd80cbsm13868657pfb.191.2023.12.15.11.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 11:13:47 -0800 (PST)
Message-ID: <1cbbc046-3b41-4518-95f3-9a4d2315ff92@davidwei.uk>
Date: Fri, 15 Dec 2023 11:13:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] netdevsim: allow two netdevsim ports to
 be connected
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-2-dw@davidwei.uk> <ZXw0dWbPKs1e_2eJ@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZXw0dWbPKs1e_2eJ@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-15 03:11, Jiri Pirko wrote:
> Thu, Dec 14, 2023 at 10:24:40PM CET, dw@davidwei.uk wrote:
>> Add a debugfs file in
>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>
>> Writing "M B" to this file will link port A of netdevsim N with port B of
>> netdevsim M.
>>
>> Reading this file will return the linked netdevsim id and port, if any.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/bus.c       | 17 ++++++
>> drivers/net/netdevsim/dev.c       | 88 +++++++++++++++++++++++++++++++
>> drivers/net/netdevsim/netdev.c    |  6 +++
>> drivers/net/netdevsim/netdevsim.h |  3 ++
>> 4 files changed, 114 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>> index bcbc1e19edde..1ef95661a3f5 100644
>> --- a/drivers/net/netdevsim/bus.c
>> +++ b/drivers/net/netdevsim/bus.c
>> @@ -323,6 +323,23 @@ static struct device_driver nsim_driver = {
>> 	.owner		= THIS_MODULE,
>> };
>>
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
> 
> This sounds definitelly incorrect. You should not need to touch bus.c
> code. It arranges the bus and devices on it. The fact that a device is
> probed or not is parallel to this.
> 
> I think you need to maintain a separate list/xarray of netdevsim devices
> probed by nsim_drv_probe()

There is a 1:1 relationship between bus devices (nsim_bus_dev) and nsim devices
(nsim_dev). Adding a separate list for nsim devices seemed redundant to me when
there is already a list for bus devices.

> 
> 
>> +{
>> +	struct nsim_bus_dev *nsim_bus_dev;
>> +
>> +	mutex_lock(&nsim_bus_dev_list_lock);
>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>> +		if (nsim_bus_dev->dev.id == id) {
>> +			get_device(&nsim_bus_dev->dev);
>> +			mutex_unlock(&nsim_bus_dev_list_lock);
>> +			return nsim_bus_dev;
>> +		}
>> +	}
>> +	mutex_unlock(&nsim_bus_dev_list_lock);
>> +
>> +	return NULL;
>> +}
>> +
>> int nsim_bus_init(void)
>> {
>> 	int err;
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..034145ba1861 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -388,6 +388,91 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>> 	.owner = THIS_MODULE,
>> };
>>
>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +	struct netdevsim *peer;
>> +	unsigned int id, port;
>> +	char buf[23];
>> +	ssize_t len;
>> +
>> +	nsim_dev_port = file->private_data;
>> +	rcu_read_lock();
>> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
>> +	if (!peer) {
>> +		rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +	id = peer->nsim_bus_dev->dev.id;
>> +	port = peer->nsim_dev_port->port_index;
>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>> +
>> +	rcu_read_unlock();
>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>> +}
>> +
>> +static ssize_t nsim_dev_peer_write(struct file *file,
>> +				   const char __user *data,
>> +				   size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>> +	struct nsim_bus_dev *peer_bus_dev;
>> +	struct nsim_dev *peer_dev;
>> +	unsigned int id, port;
>> +	char buf[22];
>> +	ssize_t ret;
>> +
>> +	if (count >= sizeof(buf))
>> +		return -ENOSPC;
>> +
>> +	ret = copy_from_user(buf, data, count);
>> +	if (ret)
>> +		return -EFAULT;
>> +	buf[count] = '\0';
>> +
>> +	ret = sscanf(buf, "%u %u", &id, &port);
>> +	if (ret != 2) {
>> +		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* invalid netdevsim id */
>> +	peer_bus_dev = nsim_bus_dev_get(id);
>> +	if (!peer_bus_dev)
>> +		return -EINVAL;
>> +
>> +	ret = -EINVAL;
>> +	/* cannot link to self */
>> +	nsim_dev_port = file->private_data;
>> +	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
>> +	    nsim_dev_port->port_index == port)
>> +		goto out;
>> +
>> +	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
> 
> Again, no bus touching should be needed. (btw, this could be null is dev
> is not probed)

That's fair, I can do a null check.

> 
> 
>> +	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>> +		if (peer_dev_port->port_index != port)
>> +			continue;
>> +		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>> +		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
> 
> What is stopping another cpu from setting different peer for the same
> port here, making a mess?

Looking into RCU a bit more, you're right that it does not protect from
multiple writers. Would adding a lock (spinlock?) to nsim_dev and taking that
be sufficient here?

Or what if I took rtnl_lock()?

> 
> 
>> +		ret = count;
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	put_device(&peer_bus_dev->dev);
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations nsim_dev_peer_fops = {
>> +	.open = simple_open,
>> +	.read = nsim_dev_peer_read,
>> +	.write = nsim_dev_peer_write,
>> +	.llseek = generic_file_llseek,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 				      struct nsim_dev_port *nsim_dev_port)
>> {
>> @@ -418,6 +503,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 	}
>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>
>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>> +
>> 	return 0;
>> }
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index aecaf5f44374..e290c54b0e70 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> 	ns->nsim_dev = nsim_dev;
>> 	ns->nsim_dev_port = nsim_dev_port;
>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>> 	nsim_ethtool_init(ns);
>> @@ -407,9 +408,14 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> void nsim_destroy(struct netdevsim *ns)
>> {
>> 	struct net_device *dev = ns->netdev;
>> +	struct netdevsim *peer;
>>
>> 	rtnl_lock();
>> +	peer = rtnl_dereference(ns->peer);
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	unregister_netdevice(dev);
>> +	if (peer)
>> +		RCU_INIT_POINTER(peer->peer, NULL);
> 
> What is stopping the another CPU from setting this back to this "ns"?
> Or what is stopping another netdevsim port from setting this ns while
> going away?
> 
> Do you rely on RTNL_LOCK in any way (other then synchronize_net() in
> unlock())? If yes, looks wrong.
> 
> This ns->peer update locking looks very broken to me :/

As above, would a spinlock on nsim_dev or taking rtnl_lock() in
nsim_dev_peer_write() resolve this?

> 
> 
> 
> 
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>> 		nsim_macsec_teardown(ns);
>> 		nsim_ipsec_teardown(ns);
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 028c825b86db..61ac3a80cf9a 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -125,6 +125,7 @@ struct netdevsim {
>> 	} udp_ports;
>>
>> 	struct nsim_ethtool ethtool;
>> +	struct netdevsim __rcu *peer;
>> };
>>
>> struct netdevsim *
>> @@ -415,5 +416,7 @@ struct nsim_bus_dev {
>> 	bool init;
>> };
>>
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>> +
>> int nsim_bus_init(void);
>> void nsim_bus_exit(void);
>> -- 
>> 2.39.3
>>

