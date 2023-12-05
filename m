Return-Path: <netdev+bounces-53833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F48804C98
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FF028170B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C443DF6E;
	Tue,  5 Dec 2023 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsUmtru+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9C10CB
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:36:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54cae99a48aso4106045a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765408; x=1702370208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VY0/mtm7gAeXOQh2N9ZoTaOLPJn+ytFRtPnmXW3E1o=;
        b=WsUmtru+sIlHapmz0e1nwfCSylM/McvhvPwzoPIBVqgsgwGP4nX1SX9trqWycQZV8N
         mjddpC81yuYOeUGTmALq487ZsbpVRMOUD5KKXVuwtitV9ciSNIXnXEeJLYb2uxAx/nmQ
         bgKfoR204XzoqGfrmL4/aWmSpgUhvF/EZnvs/+/zL1v4sHCvKCKXWd9HqTKO2wl+Ecgj
         Uuvm02zl6WXWlmEOo7zYMACGn37wHzPl1Fz5q9oEmWijXaL9JtQmqJXG+UMVrS6j9nEH
         jGSoY1yoaJ08w5A4dg5jV+6Xzi78MoGqq0Whl5S7uoWZNhQfww2W/ZqVgrpZTRYFteIJ
         866g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765408; x=1702370208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VY0/mtm7gAeXOQh2N9ZoTaOLPJn+ytFRtPnmXW3E1o=;
        b=MF8zgDkKk6vSP0TNVVS4BWzIa5dOwLy2IwnzCZiu+3halJ1Pv4ELRxIaT4FSPwhbdE
         Td2zZSVYv/1J5MdmHEW6qjoW6fPVDEWlXjMdynuXy5rml5VW7gr9UCtXlEOkUznyIUVE
         nXUT/kPMQJzHtro3kTGatojz+M88S9Jx8ESbaE3y/XtK0BFdrW2MmVfZayI6HU/YaWm9
         rZz4fMwETcj+emP8msw/aGbp60MiHbgQ2KkdTKFEpzph3J//Qt8+k9+0LuLUSZVvf2tU
         08Zv4nXRL08WEr6DJMeSC//JC7rhKM5HB1tD6bmp4pc2csBmnbugOWlO3296urjs2oKJ
         wWRg==
X-Gm-Message-State: AOJu0YwZBpJBqL2MXbPa86Va/uE9D1EpdHNhBhjK7ucZHIRgUcaWQ9Wt
	eSQvfQ64xHVB98NxrORvADA=
X-Google-Smtp-Source: AGHT+IH3CuaXPSNW3/aOqLDDuRLw9CgRk7zmkn6YIlxMGo8bIoA4BiUIXw5uwMX1ZtqasdpabM+aMQ==
X-Received: by 2002:aa7:cd5a:0:b0:54b:3599:dc4a with SMTP id v26-20020aa7cd5a000000b0054b3599dc4amr1191734edw.9.1701765408121;
        Tue, 05 Dec 2023 00:36:48 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7da8d000000b0054cfb16de51sm772267eds.3.2023.12.05.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:36:47 -0800 (PST)
Date: Tue, 5 Dec 2023 10:36:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205083646.h2tqkwourtdyzdee@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>

On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > Is this all that's necessary for instantiating the ksz driver through
> > ds->dev->platform_data? I suppose not, so can you post it all, please?
> Yes, that NULL pointer was the only issue I encountered.
> 
> Here is the module I use to instantiate the switch, which works fine so far in our
> linux v6.1 x86_64 builds:
> --
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/i2c.h>
> #include <linux/netdevice.h>
> #include <net/dsa.h>
> 
> static struct i2c_client *i2cdev;
> 
> static struct dsa_chip_data ksz9477_dsa = {
> 	.port_names = {
> 		"cpu",
> 		"lan1",
> 		"lan2",
> 		"lan3",
> 		"lan4"
> 	}
> };
> 
> static struct i2c_board_info t2t_ngr421_i2c_board_info = {
> 	I2C_BOARD_INFO("ksz9477-switch", 0x5f),
> 	.platform_data	= &ksz9477_dsa,
> };
> 
> static int __init t2t_ngr421_platform_init(void)
> {
> 	struct i2c_adapter *adapter = i2c_get_adapter(11);
> 	struct net_device *netdev_cpu = NULL, *nd;
> 
> 	if (adapter == NULL) {
> 		pr_err("t2t-ngr421: Missing FT260 I2C Adapter");
> 		return -ENODEV;
> 	}
> 
> 	read_lock(&dev_base_lock);
> 	for_each_netdev(&init_net, nd) {
> 		if (!strcmp(nd->name, "eth0")) {
> 			netdev_cpu = nd;
> 			break;
> 		}
> 	}
> 	read_unlock(&dev_base_lock);
> 
> 	if (netdev_cpu == NULL) {
> 		pr_err("t2t-ngr421: Missing netdev eth0");
> 		return -ENODEV;
> 	}
> 		
> 	ksz9477_dsa.netdev[0] = &netdev_cpu->dev;
> 	i2cdev = i2c_new_client_device(adapter, &t2t_ngr421_i2c_board_info);
> 	return i2cdev ? 0 : -ENODEV;
> }
> 
> static void t2t_ngr421_platform_deinit(void)
> {
> 	if (i2cdev)
> 		i2c_unregister_device(i2cdev);
> }
> 
> module_init(t2t_ngr421_platform_init);
> module_exit(t2t_ngr421_platform_deinit);
> 
> MODULE_AUTHOR("Daniel Danzberger <dd@embedd.com>");
> MODULE_DESCRIPTION("T2T NGR421 platform driver");
> MODULE_LICENSE("GPL v2");
> --

Pfff, I hate that "eth0" search. If you have a udev naming rule and the
driver is built as a module, you break it. Although you don't even need
that. Insert a USB to Ethernet adapter and all bets are off regarding
which one is eth0 and which one is eth1. It's good as prototyping code
and not much more.

Admittedly, that's the only thing that DSA offers currently when there's
no firmware description of the switch, but I think it wouldn't even be
that hard to do better. Someone needs to take a close look at Marcin
Wojtas' work of converting DSA to fwnode APIs
https://lore.kernel.org/netdev/20230116173420.1278704-1-mw@semihalf.com/
then we could replace the platform_data with software nodes and references.
That should actually be in our own best interest as maintainers, since
it should unify the handling of the 2 probing cases in the DSA core.
I might be able to find some time to do that early next year.

Except for dsa_loop_bdinfo.c which is easy to test by anyone, I don't
see any other board init code physically present in mainline. So please
do _not_ submit the board code, so I can pretend I didn't see it, and
for the responsibility of converting it to the new API to fall on you :)

(or, of course, you may want to take on the bigger task yourself ahead
of me, case in which your board code, edited to use fwnode_create_software_node(),
would be perfectly welcome in mainline)

But let's do something about the ksz driver's use of the platform_data
structures, since it wasn't even on my radar of something that might be
able to support that use case. More below.

> > Looking at dsa_switch_probe() -> dsa_switch_parse(), it expects
> > ds->dev->platform_data to contain a struct dsa_chip_data. This is in
> > contrast with ksz_spi.c, ksz9477_i2c.c and ksz8863_smi.c, which expect
> > the dev->platform_data to have the struct ksz_platform_data type.
> > But struct ksz_platform_data does not contain struct dsa_chip_data as
> > first element.
> 
> Noticed that as well.
> But hence the 'struct ksz_platform_data' isn't used anywhere, I passed (see module above) 'struct
> dsa_chip_data' directly.

What do you mean struct ksz_platform_data isn't used anywhere? What about this?

int ksz_switch_register(struct ksz_device *dev)
{
	const struct ksz_chip_data *info;
	struct device_node *port, *ports;
	phy_interface_t interface;
	unsigned int port_num;
	int ret;
	int i;

	if (dev->pdata)
		dev->chip_id = dev->pdata->chip_id;

with dev->pdata assigned like this:

static int ksz9477_i2c_probe(struct i2c_client *i2c)
{
	struct ksz_device *dev;

	dev = ksz_switch_alloc(&i2c->dev, i2c);
	if (!dev)
		return -ENOMEM;

	if (i2c->dev.platform_data)
		dev->pdata = i2c->dev.platform_data;

What is your dev->chip_id before and after this? The code dereferences
the first 4 bytes of struct dsa_chip_data as if it was the chip_id field
of struct ksz_platform_data. There is a bunch of code that depends on
dev->chip_id at runtime.

