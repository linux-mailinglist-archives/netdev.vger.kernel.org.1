Return-Path: <netdev+bounces-260726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF2rOixdnmmIUwQAu9opvQ
	(envelope-from <netdev+bounces-260726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9D190DAF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CA7F300B9C8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7E27F73A;
	Wed, 25 Feb 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlnTstp/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393027F01E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986214; cv=none; b=ObIgiE0DaESjCSCWgQoi7kc/p8m9bIct0LUKyCC76RAmJSg96riwlByDvKA2YWUlmHlR78g9dGv6uqjxlbvgloa4RHbkTmDDI8vdZaDQ3QV4Rf2hnzCYuXhx6yi7jtuUkoL1A+21kM84wZ1vD+FK06e9e/hc4S2wM2drx7PRZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986214; c=relaxed/simple;
	bh=S5m20bHqPix0g2sF5iZbm8YV4Ae9jx/0P1Cz2BHT5ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOVjTazcFW9d5fmIFA14WNuHZwuBUTYAFSvczBTI3babIiPj6zQMn2f9TNK0pbvF+vdXiJgVqcPXcgMa9CvMXBUzet31sjTgcE5YM/YIrDKbpboOiilfdyMHEhxSVswuvTzK03oRATwI6OkcY6CE9UqA6u0Te8+K2YOltZPSuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlnTstp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A45C116D0;
	Wed, 25 Feb 2026 02:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986214;
	bh=S5m20bHqPix0g2sF5iZbm8YV4Ae9jx/0P1Cz2BHT5ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlnTstp/WFWwOyfKq7Dm4MUCb18Z93fIn7wdNPkwydVWofZaS4vPq2A3ApyXrg0w5
	 +mkx7ip2ygR9UhcLi69rGecPr3hi6C0Qb9QBoxxRTia+PYuxmFHSF5GkaBTrWtMPxY
	 6Z1X2s9YrlO0MIsAGbYRoUm+OhDEN6vtv/GE9Ju7HbIkmjYo5tLitUkpuKchB6W7EN
	 +mv5wWJknCZn6nxtoVggLqWlfk7ALj4vPS4hHqEPrZkcKsevDYwqR4a/VEc0f5294h
	 i/NFWeL/kaUqnSBSd/QzFwCGtNxxT8TGHmrbhcyVi5jDNZPdd6GakKoUrNFkdh0ji1
	 kE7r+9AUzkYqA==
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
Subject: Re: [net-next,06/10] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Tue, 24 Feb 2026 18:23:32 -0800
Message-ID: <20260225022332.998040-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223145557.248679-7-jiri@resnulli.us>
References: <20260223145557.248679-7-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260726-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lunn.ch,gmail.com,linuxfoundation.org,redhat.com,oracle.com,vger.kernel.org,intel.com,davemloft.net,lwn.net,google.com,goodmis.org,efficios.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 21A9D190DAF
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "FYI"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
devlink: add devlink_dev_driver_name() helper and use it in trace events

In preparation to dev-less devlinks, this patch adds
devlink_dev_driver_name() that safely returns the driver name or NULL,
and uses it in all trace events.

> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 0afb0958b910..45dec7067a8e 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1613,6 +1613,7 @@ struct devlink *priv_to_devlink(void *priv);
>  struct device *devlink_to_dev(const struct devlink *devlink);
>  const char *devlink_bus_name(const struct devlink *devlink);
>  const char *devlink_dev_name(const struct devlink *devlink);
> +const char *devlink_dev_driver_name(const struct devlink *devlink);
>
>  /* Devlink instance explicit locking */
>  void devl_lock(struct devlink *devlink);

[ ... ]

> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 2dd6d45bec18..85e83a3b082a 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -260,6 +260,13 @@ const char *devlink_dev_name(const struct devlink *devlink)
>  }
>  EXPORT_SYMBOL_GPL(devlink_dev_name);
>
> +const char *devlink_dev_driver_name(const struct devlink *devlink)
> +{
> +	struct device *dev = devlink->dev;
> +
> +	return dev ? dev->driver->name : NULL;
                      ^^^^^^^^^^^^
> +}

Does this safely handle the case when dev->driver is NULL? The function
checks whether dev is NULL but does not check whether dev->driver is
NULL before dereferencing it.

In the kernel device model, struct device.driver is a pointer that is
NULL when no driver is bound. While devlink instances are typically
created during driver probe (so dev->driver should be non-NULL during
the devlink lifetime), the commit message describes this as a function
that "safely returns the driver name or NULL."

For full safety, especially as this prepares for dev-less devlinks where
lifecycle assumptions may change, should the function also guard against
dev->driver being NULL?

The same codebase already handles this condition in
devlink_nl_driver_info_get():

net/devlink/dev.c:857:
    struct device_driver *drv = dev->driver;

    if (!drv)
        return 0;

Should this be:

    return (dev && dev->driver) ? dev->driver->name : NULL;


Is devlink_dev_driver_name() missing EXPORT_SYMBOL_GPL? All sibling
accessor functions (devlink_to_dev, devlink_bus_name, devlink_dev_name)
are exported with EXPORT_SYMBOL_GPL.

The new function is declared in the public header include/net/devlink.h
and is called from trace event definitions in
include/trace/events/devlink.h. The mlxsw driver
(drivers/net/ethernet/mellanox/mlxsw/core.c) includes this trace header
and invokes trace_devlink_hwmsg() and trace_devlink_hwerr(), which
evaluate devlink_dev_driver_name() at the call site.

Since MLXSW_CORE is tristate (can be built as a module), this will cause
a link failure for modular builds.

