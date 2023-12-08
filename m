Return-Path: <netdev+bounces-55460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB880AF37
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B472812E7
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128B58AC2;
	Fri,  8 Dec 2023 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uBEOG9xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73418211B
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 13:57:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso2108685a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702072627; x=1702677427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4K0YXMfUBgdzoJZ1u6s5TSjDhSTbPXlpbYpJmk4yJgE=;
        b=uBEOG9xj0pLdxBYzqX/DdGJMxUF8/rlIzh7E/UGP8KTlcqJMUfHweSrrkkY0K7yl8N
         aew78vZVMU6EV9HSB/tIEugKMioPyuY4C+9OgIjsUVCsbeBifanAW3y2WPTo2+dEfRgq
         NzrPo3CPQpRy2ayfpVQ9JPQq3dFAUTz8MpodjAYe97n3AHIPhMdL0O9ZX3JsveTL3ehu
         RNY/8pLVL3xXAzPjpUdV3V4OCC93hqTbWxFpnbf7KGhgg70jyaJhS6+skMUQfYpOpXnD
         zFX2hZQWIfCiiaGbgIHtpqNA+v7AR9+tZm1ri3QfBs0NTrNrxTMtSR26mH2aPEcc6k0u
         m1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072627; x=1702677427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4K0YXMfUBgdzoJZ1u6s5TSjDhSTbPXlpbYpJmk4yJgE=;
        b=Wn2gRChstax2xKTgHZ01JmZVgbxq0gWZdP4VUOP/xXPOLIRPDC7a+7VKAahaIfiUWQ
         IPSFZABXuiBJli5bc6Uyz58wvmgqZm8BzuXeG0aqZvux7Q7drKbPu5aDG+1xWa/ai5mg
         vcUxEiYfuJNTf2ttFV4FM9RjQmj8ji/T94WN+Jn8Z6U0Kh6Fljk7vJ5UculgUpj5D+pV
         7Rtaqtcq8bD2DTTDBn0OtiF0wgCitrI172mWCPjL53He6UJbQCjaORFhobWjUg5uzxBm
         6vUXArEOLQFiT2OzAQg4R8yv94NbdvUg1PjyAq9M6zJg7qcinWjRTK6iWCLhB2tOkakk
         hhiA==
X-Gm-Message-State: AOJu0YzohGhi9UgCe4PasNHIwZP0CblXrCi22tw1WKQSdIQvdyNlcYW3
	rXZTXRN0Crmwt0gxd23rudAd8w==
X-Google-Smtp-Source: AGHT+IFrNUjV9BoL6uOpdidBaGRnAu37LKlF42yW/mv6utv+SS6lhfeCHYtMbWoBDD66Kr3q+23edQ==
X-Received: by 2002:a05:6a20:1445:b0:18b:5b7e:6b9 with SMTP id a5-20020a056a20144500b0018b5b7e06b9mr689584pzi.2.1702072626760;
        Fri, 08 Dec 2023 13:57:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:34a6])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b00690c0cf97c9sm2145195pfl.73.2023.12.08.13.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 13:57:06 -0800 (PST)
Message-ID: <0fc35c10-e35b-4bdc-9b9f-22b256921637@davidwei.uk>
Date: Fri, 8 Dec 2023 13:57:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netdevsim: allow two netdevsim ports to be
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <20231207172117.3671183-2-dw@davidwei.uk> <ZXL3L38i8RIFo+nh@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZXL3L38i8RIFo+nh@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-08 02:59, Jiri Pirko wrote:
> Thu, Dec 07, 2023 at 06:21:15PM CET, dw@davidwei.uk wrote:
>> Add a debugfs file in
>> /sys/kernel/debug/netdevsim/netdevsimN/ports/B/link
> 
> "peer" perhaps?

Sounds good.

> 
>>
>> Writing "M B" to this file will link port A of netdevsim N with port B of
>> netdevsim M.
>>
>> Reading this file will return the linked netdevsim id and port, if any.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/bus.c       | 10 ++++
>> drivers/net/netdevsim/dev.c       | 97 +++++++++++++++++++++++++++++++
>> drivers/net/netdevsim/netdev.c    |  5 ++
>> drivers/net/netdevsim/netdevsim.h |  3 +
>> 4 files changed, 115 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>> index bcbc1e19edde..3e4378e9dbee 100644
>> --- a/drivers/net/netdevsim/bus.c
>> +++ b/drivers/net/netdevsim/bus.c
>> @@ -364,3 +364,13 @@ void nsim_bus_exit(void)
>> 	driver_unregister(&nsim_driver);
>> 	bus_unregister(&nsim_bus);
>> }
>> +
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
>> +{
>> +	struct nsim_bus_dev *nsim_bus_dev;
>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>> +		if (nsim_bus_dev->dev.id == id)
>> +			return nsim_bus_dev;
>> +	}
>> +	return NULL;
>> +}
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..72ad61f141a2 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -25,6 +25,7 @@
>> #include <linux/mutex.h>
>> #include <linux/random.h>
>> #include <linux/rtnetlink.h>
>> +#include <linux/string.h>
>> #include <linux/workqueue.h>
>> #include <net/devlink.h>
>> #include <net/ip.h>
>> @@ -388,6 +389,99 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>> 	.owner = THIS_MODULE,
>> };
>>
>> +static ssize_t nsim_dev_link_read(struct file *file, char __user *data,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +	struct netdevsim *peer;
>> +	unsigned int id, port;
>> +	char buf[11];
> 
> See below.
> 
> 
>> +	ssize_t len;
>> +
>> +	nsim_dev_port = file->private_data;
>> +	peer = nsim_dev_port->ns->peer;
>> +	if (!peer) {
>> +		len = scnprintf(buf, sizeof(buf), "\n");
>> +		goto out;
>> +	}
>> +
>> +	id = peer->nsim_bus_dev->dev.id;
>> +	port = peer->nsim_dev_port->port_index;
>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>> +
>> +out:
>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>> +}
>> +
>> +static ssize_t nsim_dev_link_write(struct file *file,
>> +					  const char __user *data,
>> +					  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>> +	struct nsim_bus_dev *peer_bus_dev;
>> +	struct nsim_dev *peer_dev;
>> +	unsigned int id, port;
>> +	char *token, *cur;
>> +	char buf[10];
> 
> # echo "889879797" >/sys/bus/netdevsim/new_device
> # devlink dev
> netdevsim/netdevsim889879797
> 
> I don't think that 10/11 is enough.

I took char[10] from nsim_bus_dev_max_vfs_write() which seemed like a
reasonable amount for 4 digit id and ports. How much space is okay to
allocate on the stack for this? Can you please point me to where
new_device_store() is called from? I couldn't find it so I don't know
how big its char *buf arg is.

> 
> 
> 
> 
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
>> +	cur = buf;
>> +	token = strsep(&cur, " ");
> 
> Why you implement this differently, comparing to new_device_store()?
> Just use sscanf(), no?

I went with strstep() instead of sscanf() because sscanf("%u %u", ...)
does not fail with echo "1 2 3 4". I'm happy to use sscanf() though if
this is not an issue.

> 
> 
>> +	if (!token)
>> +		return -EINVAL;
> 
> In general, in case of user putting in invalid input, please hint him
> the correct format. Again, see new_device_store().

Got it, I'll add an error message.

> 
> 
>> +	ret = kstrtouint(token, 10, &id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	token = strsep(&cur, " ");
>> +	if (!token)
>> +		return -EINVAL;
>> +	ret = kstrtouint(token, 10, &port);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* too many args */
>> +	if (strsep(&cur, " "))
>> +		return -E2BIG;
>> +
>> +	/* cannot link to self */
>> +	nsim_dev_port = file->private_data;
>> +	if (nsim_dev_port->ns->nsim_bus_dev->dev.id == id)
> 
> Why not? Loopback between 2 ports of same device seems like completely
> valid scenario.

I'm imagining physical ports which cannot be connected back to itself. When
would this physical loopback be valid?

> 
> 
>> +		return -EINVAL;
>> +
>> +	/* invalid netdevsim id */
>> +	peer_bus_dev = nsim_bus_dev_get(id);
>> +	if (!peer_bus_dev)
>> +		return -EINVAL;
>> +
>> +	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
>> +	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>> +		if (peer_dev_port->port_index == port) {
>> +			nsim_dev_port->ns->peer = peer_dev_port->ns;
>> +			peer_dev_port->ns->peer = nsim_dev_port->ns;
>> +			return count;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct file_operations nsim_dev_link_fops = {
>> +	.open = simple_open,
>> +	.read = nsim_dev_link_read,
>> +	.write = nsim_dev_link_write,
>> +	.llseek = generic_file_llseek,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 				      struct nsim_dev_port *nsim_dev_port)
>> {
>> @@ -418,6 +512,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 	}
>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>
>> +	debugfs_create_file("link", 0600, nsim_dev_port->ddir,
>> +			    nsim_dev_port, &nsim_dev_link_fops);
>> +
>> 	return 0;
>> }
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index aecaf5f44374..1abdcd470f21 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> 	ns->nsim_dev = nsim_dev;
>> 	ns->nsim_dev_port = nsim_dev_port;
>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>> +	ns->peer = NULL;
>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>> 	nsim_ethtool_init(ns);
>> @@ -409,6 +410,10 @@ void nsim_destroy(struct netdevsim *ns)
>> 	struct net_device *dev = ns->netdev;
>>
>> 	rtnl_lock();
>> +	if (ns->peer) {
>> +		ns->peer->peer = NULL;
>> +		ns->peer = NULL;
> 
> What is this good for?

I want to make sure when a netdevsim is removed, its peer does not
forward skbs anymore.

> 
> 
>> +	}
>> 	unregister_netdevice(dev);
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>> 		nsim_macsec_teardown(ns);
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 028c825b86db..ac7b34a83585 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -125,6 +125,7 @@ struct netdevsim {
>> 	} udp_ports;
>>
>> 	struct nsim_ethtool ethtool;
>> +	struct netdevsim *peer;
>> };
>>
>> struct netdevsim *
>> @@ -417,3 +418,5 @@ struct nsim_bus_dev {
>>
>> int nsim_bus_init(void);
>> void nsim_bus_exit(void);
>> +
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>> -- 
>> 2.39.3
>>
>>

