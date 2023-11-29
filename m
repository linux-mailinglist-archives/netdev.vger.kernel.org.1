Return-Path: <netdev+bounces-51940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F947FCC6B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54710282E9F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF901C10;
	Wed, 29 Nov 2023 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8l/5MtN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888EF5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:46:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so21034285e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701222399; x=1701827199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ2z3pGciakTQjJqBAZU1TopphOvMpeMz2DgGH+vYJw=;
        b=K8l/5MtNsyYLlsauCqVVcl/k1gyTObuxM9X8gvCXwI5hJUErvUICntyhYy9LyzqFgs
         chZuLMM7iMkOE8s953WLJ5Mt+XyPfqFtN5wXEoCMa2v6Bl+cMOqfWu0NMFQ8QvjZsLhP
         lbM2RKUBhupie1ubku0yQg1XOxLuffKrUfMqRk/FucPBRFlDeTOnGhjBybOaPCy4/A63
         RoIqvWFWsSK/XCDI8Y8L/w6wqP6Pm52EVX1vJzxeOvDGMd6JaT6B00QSgfdzQidyURQZ
         kv+fbim4ZsRt9H9O02EriWQkYsRRsyW69lxjVqFQ9onGgikqSEN1LUlRfdbR38+cFQZQ
         BmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701222399; x=1701827199;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ2z3pGciakTQjJqBAZU1TopphOvMpeMz2DgGH+vYJw=;
        b=j4LIX5CM1NDfVWy8RyvVtfgvrLxslRQvhbiJZL7Y81rsG9rGs/Ok1weF7X/Yl17n2d
         yXFhuD2UsDbenX3065eono+5N6qvm9alz6ddcXVYbTrAHskVQ7w6xUdcHX4JD3VtLGRh
         fIdOtWCFD8/ClVckujCWaB0dX/IVBlIIYhhvqJXIor0CdVrSYIZVtqQATKiu+1olgDRw
         67ZUTYk+16XqWW9pssmjxBkBYQ4nD3Y3n9uEo0R8M9H8xvHUcEd349sDhZiVKgLKVHD5
         9c0E0HqNLdhJHmqI+iCgYW5PwVODrs30OmzJuBkUbOENlhrzC5sIpqGPtvVIezwgyqWR
         rVbQ==
X-Gm-Message-State: AOJu0YwBY86Fr1IUl8QUYHYI41SyKiZUN5Ws/schlkX/baDlBsas/5/K
	MRx48Z23LNnGiBOFLFqQYDc=
X-Google-Smtp-Source: AGHT+IGCmRxb5Wi1JzeQVc4tUTkozdM19JKFK9W1CDV1Hy7Ur4U6F1yR5MX6pSrPXeR1hGFMkKwoxA==
X-Received: by 2002:a05:600c:4f90:b0:40a:4c7e:6f3e with SMTP id n16-20020a05600c4f9000b0040a4c7e6f3emr13605725wmq.21.1701222398989;
        Tue, 28 Nov 2023 17:46:38 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040b349c91acsm283742wmq.16.2023.11.28.17.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:46:38 -0800 (PST)
Message-ID: <656697fe.050a0220.18692.0d42@mx.google.com>
X-Google-Original-Message-ID: <ZWaX_B-rzInbrhDU@Ansuel-xps.>
Date: Wed, 29 Nov 2023 02:46:36 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 4/8] dsa: Create port LEDs based on DT
 binding
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-5-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128232135.358638-5-andrew@lunn.ch>

On Wed, Nov 29, 2023 at 12:21:31AM +0100, Andrew Lunn wrote:
> Allow LEDs to be described in each ports DT subnode. Parse these when
> setting up the ports, currently supporting brightness and link.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/net/dsa.h |   3 +
>  net/dsa/dsa.c     | 138 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index ae73765cd71c..2e05e4fd0b76 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -325,6 +325,9 @@ struct dsa_port {
>  		 */
>  		struct list_head	user_vlans;
>  	};
> +
> +	/* List of LEDs associated to this port */
> +	struct list_head leds;
>  };
>  
>  /* TODO: ideally DSA ports would have a single dp->link_dp member,
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index ac7be864e80d..b13748f9b519 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -34,6 +34,15 @@
>  static DEFINE_MUTEX(dsa2_mutex);
>  LIST_HEAD(dsa_tree_list);
>  
> +struct dsa_led {
> +	struct list_head led_list;
> +	struct dsa_port *dp;
> +	struct led_classdev led_cdev;
> +	u8 index;
> +};
> +
> +#define to_dsa_led(d) container_of(d, struct dsa_led, led_cdev)
> +
>  static struct workqueue_struct *dsa_owq;
>  
>  /* Track the bridges with forwarding offload enabled */
> @@ -461,6 +470,116 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
>  			dp->cpu_dp = NULL;
>  }
>  
> +static int dsa_led_brightness_set(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
> +	struct dsa_port *dp = dsa_led->dp;
> +	struct dsa_switch *ds = dp->ds;
> +
> +	return ds->ops->led_brightness_set(ds, dp->index, dsa_led->index,
> +					   value);
> +}
> +
> +static int dsa_led_blink_set(struct led_classdev *led_cdev,
> +			     unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
> +	struct dsa_port *dp = dsa_led->dp;
> +	struct dsa_switch *ds = dp->ds;
> +
> +	return ds->ops->led_blink_set(ds, dp->index, dsa_led->index,
> +				      delay_on, delay_off);
> +}
> +
> +static int dsa_port_led_setup(struct dsa_port *dp,
> +			      struct device_node *led)
> +{
> +	struct led_init_data init_data = {};
> +	struct dsa_switch *ds = dp->ds;
> +	struct led_classdev *cdev;
> +	struct dsa_led *dsa_led;
> +	u32 index;
> +	int err;
> +
> +	dsa_led = devm_kzalloc(ds->dev, sizeof(*dsa_led), GFP_KERNEL);
> +	if (!dsa_led)
> +		return -ENOMEM;
> +
> +	dsa_led->dp = dp;
> +	cdev = &dsa_led->led_cdev;
> +
> +	err = of_property_read_u32(led, "reg", &index);
> +	if (err)
> +		return err;
> +	if (index > 255)
> +		return -EINVAL;
> +
> +	dsa_led->index = index;
> +
> +	if (ds->ops->led_brightness_set)
> +		cdev->brightness_set_blocking = dsa_led_brightness_set;
> +	if (ds->ops->led_blink_set)
> +		cdev->blink_set = dsa_led_blink_set;
> +
> +	cdev->max_brightness = 1;
> +
> +	init_data.fwnode = of_fwnode_handle(led);

Please add

init_data.devname_mandatory = true;

cled will derive the name based on color action and won't include the
devname resulting in LEDs having the same name.

> +	if (dp->user) {
> +		init_data.devicename = dev_name(&dp->user->dev);
> +		err = devm_led_classdev_register_ext(&dp->user->dev, cdev,
> +						     &init_data);
> +	} else {
> +		init_data.devicename = kasprintf(GFP_KERNEL, "%s:%d",
> +						 dev_name(ds->dev), dp->index);
> +		err = devm_led_classdev_register_ext(ds->dev, cdev, &init_data);
> +	}
> +	if (err)
> +		return err;
> +
> +	INIT_LIST_HEAD(&dsa_led->led_list);
> +	list_add(&dsa_led->led_list, &dp->leds);
> +
> +	if (!dp->user)
> +		kfree(init_data.devicename);
> +
> +	return 0;
> +}
> +
> +static int dsa_port_leds_setup(struct dsa_port *dp)
> +{
> +	struct device_node *leds, *led;
> +	int err;
> +
> +	if (!dp->dn)
> +		return 0;
> +
> +	leds = of_get_child_by_name(dp->dn, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node(leds, led) {
> +		err = dsa_port_led_setup(dp, led);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dsa_port_leds_teardown(struct dsa_port *dp)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +	struct device *dev = ds->dev;
> +	struct led_classdev *cdev;
> +	struct dsa_led *dsa_led;
> +
> +	list_for_each_entry(dsa_led, &dp->leds, led_list) {
> +		cdev = &dsa_led->led_cdev;
> +		devm_led_classdev_unregister(dev, cdev);
> +	}
> +}
> +
>  static int dsa_port_setup(struct dsa_port *dp)
>  {
>  	bool dsa_port_link_registered = false;
> @@ -494,6 +613,11 @@ static int dsa_port_setup(struct dsa_port *dp)
>  		err = dsa_port_enable(dp, NULL);
>  		if (err)
>  			break;
> +
> +		err = dsa_port_leds_setup(dp);
> +		if (err)
> +			break;
> +
>  		dsa_port_enabled = true;
>  
>  		break;
> @@ -512,12 +636,22 @@ static int dsa_port_setup(struct dsa_port *dp)
>  		err = dsa_port_enable(dp, NULL);
>  		if (err)
>  			break;
> +
> +		err = dsa_port_leds_setup(dp);
> +		if (err)
> +			break;
> +
>  		dsa_port_enabled = true;
>  
>  		break;
>  	case DSA_PORT_TYPE_USER:
>  		of_get_mac_address(dp->dn, dp->mac);
>  		err = dsa_user_create(dp);
> +		if (err)
> +			break;
> +
> +		err = dsa_port_leds_setup(dp);
> +
>  		break;
>  	}
>  
> @@ -544,11 +678,13 @@ static void dsa_port_teardown(struct dsa_port *dp)
>  	case DSA_PORT_TYPE_UNUSED:
>  		break;
>  	case DSA_PORT_TYPE_CPU:
> +		dsa_port_leds_teardown(dp);
>  		dsa_port_disable(dp);
>  		if (dp->dn)
>  			dsa_shared_port_link_unregister_of(dp);
>  		break;
>  	case DSA_PORT_TYPE_DSA:
> +		dsa_port_leds_teardown(dp);
>  		dsa_port_disable(dp);
>  		if (dp->dn)
>  			dsa_shared_port_link_unregister_of(dp);
> @@ -556,6 +692,7 @@ static void dsa_port_teardown(struct dsa_port *dp)
>  	case DSA_PORT_TYPE_USER:
>  		if (dp->user) {
>  			dsa_user_destroy(dp->user);
> +			dsa_port_leds_teardown(dp);
>  			dp->user = NULL;
>  		}
>  		break;
> @@ -1108,6 +1245,7 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
>  	INIT_LIST_HEAD(&dp->mdbs);
>  	INIT_LIST_HEAD(&dp->vlans); /* also initializes &dp->user_vlans */
>  	INIT_LIST_HEAD(&dp->list);
> +	INIT_LIST_HEAD(&dp->leds);
>  	list_add_tail(&dp->list, &dst->ports);
>  
>  	return dp;
> -- 
> 2.42.0
> 

-- 
	Ansuel

