Return-Path: <netdev+bounces-55550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB07880B3C5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6ED21C2093E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69B134C6;
	Sat,  9 Dec 2023 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bB3EaFZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B98E
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:46:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so2669447a12.2
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702118804; x=1702723604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=157rbMrGQgRIguUVAo+XmIFnqBJwIHeC96opy/QSWmk=;
        b=bB3EaFZN6VebiKBfOLc2GgyIUeyYvZDtDU3FQ3m9Bk65quNUkKrH+Rcl4s9AikaArx
         MkyYArse3nq1YDHlk6FbCJltGtmKZaEdVACMLml4xmZETW7eH4tJ+aD9E9EnvZfKNFqO
         aFD7ijTYfeQpHLmzIgx13CxyaN0kmkvs4oKJZI6dJOUfj19xxo4gjThsmYpPK0kmXCfk
         fR0RX/F3RukAQfjY7ela+Qz/330HbzKUmP4O8MHRt9cAwS79ibTNUKirIL9S3d9UpV5o
         lmTLDvcEBF8QpASrsSetOuzBYlVGC3NzQB93sYad6dE4ewi1Z0RZlyaET96CB6jzNK5i
         1+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118804; x=1702723604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=157rbMrGQgRIguUVAo+XmIFnqBJwIHeC96opy/QSWmk=;
        b=A2k78UNu/+m2a2lBnk0oBqsC9kJslr6ke9a2bGrkLj6BDDEazFwAmV152Hunh3pmWW
         96AIidLL+rYGJfsPIh5a+ky9CRydeQdUs6dGyNMZDuWUyWmf/m6rvP3Bkusnw6hSGoG7
         J7OyOEqI27DQnGg1pkyphSVcXjnE449tUFhIaYUzBkCERcXvS4P2G2NoUZqMijZb9mjo
         eTInVg+VLjvx0MKva1mNYGxoxOsv65Jdg8He3GSiR6aP8/QStCgn4/sL2D+Wx9M4whw4
         Mw7OxZsyn8vVO4uf3tiNgxu9WTi5h7+Y9g4P8XqB/xz3RDV2eryLV59ZZoe9Wr09OYni
         NoOQ==
X-Gm-Message-State: AOJu0Yxo2B/4aJABsN79ZnoUTqvvQIXiCjFxkzJChbWqDNotwQXLv+4l
	THadf1YEsS42byp3rkJBHbSufQ==
X-Google-Smtp-Source: AGHT+IGeOT6Ub3rZwNOyV7PlzUD6a7jP5gP1HcDH2gFXBLKY8+ig7lUQML2QL3IApNkHpFDKFvTQ5g==
X-Received: by 2002:a17:907:7344:b0:a19:1afc:a16b with SMTP id dq4-20020a170907734400b00a191afca16bmr662104ejc.21.1702118804067;
        Sat, 09 Dec 2023 02:46:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ps1-20020a170906bf4100b00a1de8f69dabsm2070599ejb.5.2023.12.09.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:46:43 -0800 (PST)
Date: Sat, 9 Dec 2023 11:46:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] netdevsim: allow two netdevsim ports to be
Message-ID: <ZXRFkhF0ZxOG30+f@nanopsycho>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <20231207172117.3671183-2-dw@davidwei.uk>
 <ZXL3L38i8RIFo+nh@nanopsycho>
 <0fc35c10-e35b-4bdc-9b9f-22b256921637@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc35c10-e35b-4bdc-9b9f-22b256921637@davidwei.uk>

Fri, Dec 08, 2023 at 10:57:04PM CET, dw@davidwei.uk wrote:
>On 2023-12-08 02:59, Jiri Pirko wrote:
>> Thu, Dec 07, 2023 at 06:21:15PM CET, dw@davidwei.uk wrote:
>>> Add a debugfs file in
>>> /sys/kernel/debug/netdevsim/netdevsimN/ports/B/link
>> 
>> "peer" perhaps?
>
>Sounds good.
>
>> 
>>>
>>> Writing "M B" to this file will link port A of netdevsim N with port B of
>>> netdevsim M.
>>>
>>> Reading this file will return the linked netdevsim id and port, if any.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/bus.c       | 10 ++++
>>> drivers/net/netdevsim/dev.c       | 97 +++++++++++++++++++++++++++++++
>>> drivers/net/netdevsim/netdev.c    |  5 ++
>>> drivers/net/netdevsim/netdevsim.h |  3 +
>>> 4 files changed, 115 insertions(+)
>>>
>>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>>> index bcbc1e19edde..3e4378e9dbee 100644
>>> --- a/drivers/net/netdevsim/bus.c
>>> +++ b/drivers/net/netdevsim/bus.c
>>> @@ -364,3 +364,13 @@ void nsim_bus_exit(void)
>>> 	driver_unregister(&nsim_driver);
>>> 	bus_unregister(&nsim_bus);
>>> }
>>> +
>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
>>> +{
>>> +	struct nsim_bus_dev *nsim_bus_dev;
>>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>>> +		if (nsim_bus_dev->dev.id == id)
>>> +			return nsim_bus_dev;
>>> +	}
>>> +	return NULL;
>>> +}
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index b4d3b9cde8bd..72ad61f141a2 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -25,6 +25,7 @@
>>> #include <linux/mutex.h>
>>> #include <linux/random.h>
>>> #include <linux/rtnetlink.h>
>>> +#include <linux/string.h>
>>> #include <linux/workqueue.h>
>>> #include <net/devlink.h>
>>> #include <net/ip.h>
>>> @@ -388,6 +389,99 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>>> 	.owner = THIS_MODULE,
>>> };
>>>
>>> +static ssize_t nsim_dev_link_read(struct file *file, char __user *data,
>>> +				  size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port;
>>> +	struct netdevsim *peer;
>>> +	unsigned int id, port;
>>> +	char buf[11];
>> 
>> See below.
>> 
>> 
>>> +	ssize_t len;
>>> +
>>> +	nsim_dev_port = file->private_data;
>>> +	peer = nsim_dev_port->ns->peer;
>>> +	if (!peer) {
>>> +		len = scnprintf(buf, sizeof(buf), "\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	id = peer->nsim_bus_dev->dev.id;
>>> +	port = peer->nsim_dev_port->port_index;
>>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>>> +
>>> +out:
>>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>>> +}
>>> +
>>> +static ssize_t nsim_dev_link_write(struct file *file,
>>> +					  const char __user *data,
>>> +					  size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>>> +	struct nsim_bus_dev *peer_bus_dev;
>>> +	struct nsim_dev *peer_dev;
>>> +	unsigned int id, port;
>>> +	char *token, *cur;
>>> +	char buf[10];
>> 
>> # echo "889879797" >/sys/bus/netdevsim/new_device
>> # devlink dev
>> netdevsim/netdevsim889879797
>> 
>> I don't think that 10/11 is enough.
>
>I took char[10] from nsim_bus_dev_max_vfs_write() which seemed like a
>reasonable amount for 4 digit id and ports. How much space is okay to
>allocate on the stack for this? Can you please point me to where
>new_device_store() is called from? I couldn't find it so I don't know
>how big its char *buf arg is.

sysfs:
static BUS_ATTR_WO(new_device);

I see no problem in allocate this buffer using count size


>
>> 
>> 
>> 
>> 
>>> +	ssize_t ret;
>>> +
>>> +	if (count >= sizeof(buf))
>>> +		return -ENOSPC;
>>> +
>>> +	ret = copy_from_user(buf, data, count);
>>> +	if (ret)
>>> +		return -EFAULT;
>>> +	buf[count] = '\0';
>>> +
>>> +	cur = buf;
>>> +	token = strsep(&cur, " ");
>> 
>> Why you implement this differently, comparing to new_device_store()?
>> Just use sscanf(), no?
>
>I went with strstep() instead of sscanf() because sscanf("%u %u", ...)
>does not fail with echo "1 2 3 4". I'm happy to use sscanf() though if
>this is not an issue.

Up to you, but please maintain some consistency with existing code. If
you want to do this differently, please adjust the existing code first.


>
>> 
>> 
>>> +	if (!token)
>>> +		return -EINVAL;
>> 
>> In general, in case of user putting in invalid input, please hint him
>> the correct format. Again, see new_device_store().
>
>Got it, I'll add an error message.
>
>> 
>> 
>>> +	ret = kstrtouint(token, 10, &id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	token = strsep(&cur, " ");
>>> +	if (!token)
>>> +		return -EINVAL;
>>> +	ret = kstrtouint(token, 10, &port);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* too many args */
>>> +	if (strsep(&cur, " "))
>>> +		return -E2BIG;
>>> +
>>> +	/* cannot link to self */
>>> +	nsim_dev_port = file->private_data;
>>> +	if (nsim_dev_port->ns->nsim_bus_dev->dev.id == id)
>> 
>> Why not? Loopback between 2 ports of same device seems like completely
>> valid scenario.
>
>I'm imagining physical ports which cannot be connected back to itself. When
>would this physical loopback be valid?

I'm talking about 2 ports of the same netdevsim instance. The instance
can have multiple ports.


>
>> 
>> 
>>> +		return -EINVAL;
>>> +
>>> +	/* invalid netdevsim id */
>>> +	peer_bus_dev = nsim_bus_dev_get(id);
>>> +	if (!peer_bus_dev)
>>> +		return -EINVAL;
>>> +
>>> +	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
>>> +	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>>> +		if (peer_dev_port->port_index == port) {
>>> +			nsim_dev_port->ns->peer = peer_dev_port->ns;
>>> +			peer_dev_port->ns->peer = nsim_dev_port->ns;
>>> +			return count;
>>> +		}
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static const struct file_operations nsim_dev_link_fops = {
>>> +	.open = simple_open,
>>> +	.read = nsim_dev_link_read,
>>> +	.write = nsim_dev_link_write,
>>> +	.llseek = generic_file_llseek,
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +
>>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 				      struct nsim_dev_port *nsim_dev_port)
>>> {
>>> @@ -418,6 +512,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 	}
>>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>>
>>> +	debugfs_create_file("link", 0600, nsim_dev_port->ddir,
>>> +			    nsim_dev_port, &nsim_dev_link_fops);
>>> +
>>> 	return 0;
>>> }
>>>
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index aecaf5f44374..1abdcd470f21 100644
>>> --- a/drivers/net/netdevsim/netdev.c
>>> +++ b/drivers/net/netdevsim/netdev.c
>>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>> 	ns->nsim_dev = nsim_dev;
>>> 	ns->nsim_dev_port = nsim_dev_port;
>>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>>> +	ns->peer = NULL;
>>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>>> 	nsim_ethtool_init(ns);
>>> @@ -409,6 +410,10 @@ void nsim_destroy(struct netdevsim *ns)
>>> 	struct net_device *dev = ns->netdev;
>>>
>>> 	rtnl_lock();
>>> +	if (ns->peer) {
>>> +		ns->peer->peer = NULL;
>>> +		ns->peer = NULL;
>> 
>> What is this good for?
>
>I want to make sure when a netdevsim is removed, its peer does not
>forward skbs anymore.

I mean "ns->peer = NULL;"


>
>> 
>> 
>>> +	}
>>> 	unregister_netdevice(dev);
>>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>>> 		nsim_macsec_teardown(ns);
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index 028c825b86db..ac7b34a83585 100644
>>> --- a/drivers/net/netdevsim/netdevsim.h
>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>> @@ -125,6 +125,7 @@ struct netdevsim {
>>> 	} udp_ports;
>>>
>>> 	struct nsim_ethtool ethtool;
>>> +	struct netdevsim *peer;
>>> };
>>>
>>> struct netdevsim *
>>> @@ -417,3 +418,5 @@ struct nsim_bus_dev {
>>>
>>> int nsim_bus_init(void);
>>> void nsim_bus_exit(void);
>>> +
>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>>> -- 
>>> 2.39.3
>>>
>>>

