Return-Path: <netdev+bounces-17940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA72753A28
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63901C2090A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B81373E;
	Fri, 14 Jul 2023 11:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1F13727
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:42:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02523A93;
	Fri, 14 Jul 2023 04:42:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 62AEA1FD8A;
	Fri, 14 Jul 2023 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1689334920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bI4L209gcDMOttkb6gYEjAaK8FSpSt87+9I+YqlkJ8=;
	b=m6ec5be5POm77rzxsDYwk+0dmMuE8FvcRsm6t3C1ePr+pO2lCq1fhNBINGy6JQwhIwWQpM
	HB5Iw2NAfUtInozjO+OcqNt6Xp48+7DnPLu8mDpEuj9Cl5Y5iQT6gYsNrjp79AWSHUoHxq
	Z9pliSVh0bvXHHEnANjN9vL+VsazVdY=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 92DE92C142;
	Fri, 14 Jul 2023 11:41:59 +0000 (UTC)
Date: Fri, 14 Jul 2023 13:41:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, sergey.senozhatsky@gmail.com,
	tj@kernel.org, stephen@networkplumber.org,
	Dave Jones <davej@codemonkey.org.uk>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <ZLE0g9NXYZvlGcyy@alley>
References: <20230707132911.2033870-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707132911.2033870-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri 2023-07-07 06:29:11, Breno Leitao wrote:
> Create a new netconsole runtime option that prepends the kernel version in
> the netconsole message. This is useful to map kernel messages to kernel
> version in a simple way, i.e., without checking somewhere which kernel
> version the host that sent the message is using.
> 
> If this option is selected, then the "<release>," is prepended before the
> netconsole message. This is an example of a netconsole output, with
> release feature enabled:
> 
> 	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test
> 
> Calvin Owens send a RFC about this problem in 2016[1], but his
> approach was a bit more intrusive, changing the printk subsystem. This
> approach is lighter, and just append the information in the last mile,
> just before netconsole push the message to netpoll.

Thanks a lot for solving this on the netconsole level. The extended
console format is used also for /dev/kmsg. Which is then used by
systemd journal, dmesg, and maybe other userspace tools. Any format
changes might break these tools.

I have glanced over the patch and have two comments.


> @@ -254,6 +267,11 @@ static ssize_t extended_show(struct config_item *item, char *buf)
>  	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->extended);
>  }
>  
> +static ssize_t release_show(struct config_item *item, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->release);

I have learned recently that sysfs_emit() was preferred over snprintf() in the
_show() callbacks.

> +}
> +
>  static ssize_t dev_name_show(struct config_item *item, char *buf)
>  {
>  	return snprintf(buf, PAGE_SIZE, "%s\n", to_target(item)->np.dev_name);
> @@ -366,6 +389,38 @@ static ssize_t enabled_store(struct config_item *item,
>  	return err;
>  }
>  
> +static ssize_t release_store(struct config_item *item, const char *buf,
> +			     size_t count)
> +{
> +	struct netconsole_target *nt = to_target(item);
> +	int release;
> +	int err;
> +
> +	mutex_lock(&dynamic_netconsole_mutex);
> +	if (nt->enabled) {
> +		pr_err("target (%s) is enabled, disable to update parameters\n",
> +		       config_item_name(&nt->item));
> +		err = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	err = kstrtoint(buf, 10, &release);
> +	if (err < 0)
> +		goto out_unlock;
> +	if (release < 0 || release > 1) {
> +		err = -EINVAL;
> +		goto out_unlock;
> +	}

You might consider using:

	bool enabled;

	err = kstrtobool(buf, &enabled);
	if (err)
		goto unlock;


It accepts more input values, for example, 1/0, y/n, Y/N, ...

Well, I see that kstrtoint() is used also in enabled_store().
It might be confusing when "/enabled" supports only "1/0"
and "/release" supports more variants.

> +
> +	nt->release = release;
> +
> +	mutex_unlock(&dynamic_netconsole_mutex);
> +	return strnlen(buf, count);
> +out_unlock:
> +	mutex_unlock(&dynamic_netconsole_mutex);
> +	return err;
> +}
> +

Best Regards,
Petr

