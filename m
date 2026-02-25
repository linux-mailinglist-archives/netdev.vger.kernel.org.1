Return-Path: <netdev+bounces-260727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE/dITddnmmIUwQAu9opvQ
	(envelope-from <netdev+bounces-260727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BEC190DBE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89319300D0C0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7FA27FD72;
	Wed, 25 Feb 2026 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YonWr2US"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C727F01E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986217; cv=none; b=roigfw+DpKgAB8/wZGQKxgQreO673A7vItHi8vVggxVPfR6yo08bo4xm54lEP3gVAmq20yQwQyLNdwRxO2yJAi5KQmFtq/QB/IqN0VrK4fyN6qmnztPRndvQUo2uL9x0NCFB3GapseWSOj3KA7UC880hSq3IEJqLaCOxS8oruwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986217; c=relaxed/simple;
	bh=LZra/L96+i8hLEJVaeWR94LAq89NCLPXcCChtZWNRpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NigbCqeXA9YqmsSt5ogLBvCvDn/auv3ozj+1R37N/Dziq2NdDR+73chsd6gbjSu6zqzUMPbOPH0y/XAXxC9vfDjYq0SoNUXeEzE4x2beyBulJp/eR6RhvH9aa6u94o2p2n98KhOI9KrW9Uta8w7tVFeD/97lSt3n0QDYU/dsuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YonWr2US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA06DC19424;
	Wed, 25 Feb 2026 02:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986216;
	bh=LZra/L96+i8hLEJVaeWR94LAq89NCLPXcCChtZWNRpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YonWr2USm1e8Tz/VqHI9j7WCaaa1Ke+XVLBwQZPhDPZnMGzwlAqmKox7p9MqcoNOl
	 Bn8iv1+608N387VsG7lwDl2u/RpT6wIAYc7Mqba7XAqf7dMRfV6L6gFdXWHKfSdXdZ
	 746+cKOZsi8G1+O84+tyPmecX5Wou6u/t8GUF6ZgmN2aDsHGWSJBzwu6fXynkW8DjK
	 udW6pGzqUjII/7hkssHKSgQKUG6Ucu8pPjnE47ab5cVhX8nQy9Vflpet4d8O4SkcRt
	 FhDRbB0k8euhJ8FSnR1GS9jhSgGn6R2y+V/Z7HAhUau07eGRBtL27wNNX3hbjXA+bb
	 EdAPVPEbwR60g==
From: Jakub Kicinski <kuba@kernel.org>
To: jiri@resnulli.us
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@nvidia.com,
	andrew+netdev@lunn.ch,
	tariqt@nvidia.com,
	matttbe@kernel.org,
	leon@kernel.org,
	daniel.zahka@gmail.com,
	mhiramat@kernel.org,
	skhan@linuxfoundation.org,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	horms@kernel.org,
	donald.hunter@gmail.com,
	mschmidt@redhat.com,
	corbet@lwn.net,
	saeedm@nvidia.com,
	edumazet@google.com,
	cjubran@nvidia.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [net-next,07/10] devlink: allow devlink instance allocation without a backing device
Date: Tue, 24 Feb 2026 18:23:34 -0800
Message-ID: <20260225022334.998075-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223145557.248679-8-jiri@resnulli.us>
References: <20260223145557.248679-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260727-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lunn.ch,gmail.com,linuxfoundation.org,redhat.com,oracle.com,vger.kernel.org,intel.com,davemloft.net,lwn.net,google.com,goodmis.org,efficios.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0BEC190DBE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "FYI"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
devlink: allow devlink instance allocation without a backing device

Allow devlink_alloc_ns() to be called with dev=NULL to support
device-less devlink instances. When dev is NULL, the instance is
identified over netlink using "devlink_index" as bus_name and
the decimal index value as dev_name.

> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index 1ba3436db4ae..7de2d8cc862f 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -19,6 +19,8 @@
>  #define DEVLINK_GENL_VERSION 0x1
>  #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
>
> +#define DEVLINK_INDEX_BUS_NAME "devlink_index"
> +
>  enum devlink_command {
>  	/* don't change the order or add anything between, this is ABI! */
>  	DEVLINK_CMD_UNSPEC,
> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 85e83a3b082a..9cdda570e584 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c

[ ... ]

> @@ -445,7 +448,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	static u32 last_id;
>  	int ret;
>
> -	WARN_ON(!ops || !dev);
> +	WARN_ON(!ops);

The kdoc comment for devlink_alloc_ns() describes @dev as 'parent device'
but doesn't document that dev can now be NULL to create a device-less
devlink instance. Could the kdoc be updated to describe the new behavior
when dev is NULL?

>  	if (!devlink_reload_actions_valid(ops))
>  		return NULL;
>
> @@ -453,14 +456,22 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	if (!devlink)
>  		return NULL;
>
> +	if (dev) {
> +		devlink->dev = get_device(dev);
> +		devlink->bus_name = dev->bus->name;
> +		devlink->dev_name = dev_name(dev);
> +	} else {
> +		devlink->bus_name = DEVLINK_INDEX_BUS_NAME;
> +		devlink->dev_name = kasprintf(GFP_KERNEL, "%u", devlink->index);
> +		if (!devlink->dev_name)
> +			goto err_kasprintf;
> +	}
> +
>  	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
>  			      &last_id, GFP_KERNEL);
>  	if (ret < 0)
>  		goto err_xa_alloc;

Does the kasprintf() call format devlink->index correctly? The devlink
struct is allocated with kvzalloc() which zero-fills it, so devlink->index
is still 0 when kasprintf() reads it. The xa_alloc_cyclic() that assigns
the real index happens afterward.

This means dev_name will always be "0" for device-less devlink instances,
regardless of the actual index assigned by xa_alloc_cyclic(). This breaks
the index-based lookup in devlink_get_from_attrs_lock(), which parses
dev_name back to an index with kstrtoul() and looks it up in the xarray.

The commit message states the instance should be "identified over netlink
using devlink_index as bus_name and the decimal index value as dev_name",
but with dev_name always being "0", all device-less instances would have
the same identifier.

Should the kasprintf() call be moved after xa_alloc_cyclic() succeeds?

>
> -	devlink->dev = get_device(dev);
> -	devlink->bus_name = dev->bus->name;
> -	devlink->dev_name = dev_name(dev);
>  	devlink->ops = ops;

[ ... ]

> @@ -486,6 +497,11 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	return devlink;
>
>  err_xa_alloc:
> +	if (devlink->dev)
> +		put_device(devlink->dev);
> +	else
> +		kfree(devlink->dev_name);
> +err_kasprintf:
>  	kvfree(devlink);
>  	return NULL;
>  }

[ ... ]

