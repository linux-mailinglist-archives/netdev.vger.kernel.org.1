Return-Path: <netdev+bounces-260725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOqKOCZdnmmIUwQAu9opvQ
	(envelope-from <netdev+bounces-260725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF4190DA7
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47FFC3019FD0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8F27FD72;
	Wed, 25 Feb 2026 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaolC7xO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4B27F01E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986212; cv=none; b=bY1IZKbw4aLMCwjfyLP8Fl53OGqGu+dOV0NR+cqcxNYEFpo7M1P2uYSyCR5zFsWYz1sUePUmlKw2nMMZOUi3d4lZUiZEADZbV3Lgxt/Xf8RJtHQ1wEJABJG+KxEBJgJ/97Dduc82gehnxzlAcQfBYybz127CdF4fCFyBm4e1BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986212; c=relaxed/simple;
	bh=wna3NMLI5vX2jF4mWq+64sL6bPgPh4cOk23j4IwY9d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI2gxdG7mri5/nrNKg5CSLLvKkHkLYH023brmEOXkSqn5TxwT45Di+NHYlfahMLJhsi1QYitsWoe6FmNCv04/4/43nJ4+wgAob+gnDl0zS3wFQweGzB3CmIzvoBu1zlcSLm4NEmc2Bv2touSiBmnp3vHhcVcDHrPjjE2pS4+eX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaolC7xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1004CC116D0;
	Wed, 25 Feb 2026 02:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986212;
	bh=wna3NMLI5vX2jF4mWq+64sL6bPgPh4cOk23j4IwY9d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaolC7xOqG7iefL80y2gOwa2O+aNVb8O8rJTWtEl5ICvLsF65JPbd7ViZ4VpQz8J+
	 JRwhCyG3AO3T7A3Rq0dLwyOHyXaGK6r0yA/qvyJLBthlbFXKs0lezLh4NPMGaI0Kaa
	 6I6ytftLtPWsflUNulV5ZNxSr4QVDZ9rq829vBFnj3WyC2DPjoooGZwFOeGWLkKXud
	 Nh/HFoAs+3YPoOz7h025siXEFE/w2Yt0b4aCAIkjx3qsNBZzJlAkPIqTZAqxvbV+Cu
	 IP+Do0ECIqhSJ2M8QKdoDJjAPuAe/WP89CNfv+4KwvJVHntRUv+ZTrY77ybah52gKy
	 1e3oC33Kb4T/w==
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
Subject: Re: [net-next,05/10] devlink: support index-based lookup via bus_name/dev_name handle
Date: Tue, 24 Feb 2026 18:23:17 -0800
Message-ID: <20260225022317.997901-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223145557.248679-6-jiri@resnulli.us>
References: <20260223145557.248679-6-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260725-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,lunn.ch,gmail.com,linuxfoundation.org,redhat.com,oracle.com,vger.kernel.org,intel.com,davemloft.net,lwn.net,google.com,goodmis.org,efficios.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5DFF4190DA7
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "FYI"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
devlink: support index-based lookup via bus_name/dev_name handle

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
> index b73cec31089f..127f337489c0 100644
> --- a/net/devlink/netlink.c
> +++ b/net/devlink/netlink.c
> @@ -200,6 +200,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
>  	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
>  	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
>
> +	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
                                  ^^^^^^^^^^^^^^^^^^^^^^^^

Where is DEVLINK_INDEX_BUS_NAME defined? This constant is referenced
here but doesn't appear to be defined anywhere in the codebase.

I searched include/net/, include/uapi/, and net/devlink/ directories and
couldn't find this symbol defined. This will cause a compilation failure.

Based on the commit message mentioning 'devlink_index' as the bus_name
pattern, should this constant be defined somewhere like:

    #define DEVLINK_INDEX_BUS_NAME "devlink_index"

or was it intended to be defined in a previous commit in the series?

> +		if (kstrtoul(devname, 10, &index))
> +			return ERR_PTR(-EINVAL);
> +		devlink = devlinks_xa_lookup_get(net, index);
> +		if (!devlink)
> +			return ERR_PTR(-ENODEV);
> +		goto found;
> +	}
> +
>  	devlinks_xa_for_each_registered_get(net, index, devlink) {
>  		if (strcmp(devlink->bus_name, busname) == 0 &&
>  		    strcmp(devlink->dev_name, devname) == 0)

