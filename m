Return-Path: <netdev+bounces-252415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALQvCOBWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:57:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFE6A7B1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E605F33C80EA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756E4963C4;
	Thu, 22 Jan 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ3UAPyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C649553A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096765; cv=none; b=g2vlGJUjAZ1u0IGf4LNfXzSUV+xUpy7H2Cey5O30CH7RZ+1GBw/W5ZnEDR6HQJjOSYIsyllAQuLcjJKfAwGBkUW6tqAj6wEIMIJSlMzaZCE9muQ4hMdC3SfY6O3HRo4ln7Yry3C4e1gfAevQXou07j0fMWXaa06qciciavEQQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096765; c=relaxed/simple;
	bh=x9Vnk5AH5eYbAK+w2FfGW/LALlW6GK9FxuBcw2uDnm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwEVusl485cFdosuM8X5pE0NE4b1MDJfcAgl4LP3ddI4pQ1phqD92E/2wMrmCjNQj5MzJno9vMqMv7DBZ+9uOhT/szAZWS9s9q5At8eKpBiJGBhIZMF7OD7aCtje8C32v/eNwhdib7eDF1GYzgvZIvfxJ4Du6gM1e9fGBTMKaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ3UAPyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67F1C19423;
	Thu, 22 Jan 2026 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096764;
	bh=x9Vnk5AH5eYbAK+w2FfGW/LALlW6GK9FxuBcw2uDnm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZ3UAPyg5qVeXhRVHJEnPfzRJO+2YbHdfdlMIhFcnsZ4Eqlma9ip8yNxfV1q1LXer
	 tfLr9VC90B4u3YXrHUu3DDBdrVs8tqkG5hipEc14Bn0bZcdfsmJO86RvMWw5YI9MUs
	 88jw9VaTl6g6fnsrX2Ce8rMcj0PSIZr6jULdhKeT6qg4sub6rqtQqSOnF3eyu+1UKn
	 Z9RHXRi/ua2QR16vV1MrhBAW3NFmHBcpG36h0zXrEJAT/VUUTP3urYg6QtmEbV3bIN
	 Tb/0PSESr/ZJAfSV6lzuRehszHSn0sFKhcVWppK6Y5QKaj8VrBMb//vUHKCtgImIA1
	 wpnTLes/0MXqg==
Date: Thu, 22 Jan 2026 07:46:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, sdf@fomichev.me, almasrymina@google.com,
 asml.silence@gmail.com, dw@davidwei.uk, daniel@iogearbox.net
Subject: Re: [PATCH net-next 4/6] net: use netdev_queue_config() for mp
 restart
Message-ID: <20260122074602.3c41e8c1@kernel.org>
In-Reply-To: <bb985b09-fe29-4fc9-9c06-310ff3abfad1@nvidia.com>
References: <20260122005113.2476634-1-kuba@kernel.org>
	<20260122005113.2476634-5-kuba@kernel.org>
	<bb985b09-fe29-4fc9-9c06-310ff3abfad1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252415-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,gmail.com,davidwei.uk,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73AFE6A7B1
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 16:06:40 +0100 Dragos Tatulea wrote:
> > @@ -195,8 +199,11 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
> >  			 rxq->mp_params.mp_priv != old_p->mp_priv))
> >  		return;
> >  
> > +	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
> >  	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
> > -	err = netdev_rx_queue_restart(dev, ifq_idx);
> > +	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
> > +  
> Is it ok to assume that on close we always resume to the default?
> For now yes but maybe in the future we might want to save qcfg to the
> state before mp_open.

When we add the ability to configure the params via Netlink we should
insert another chunk into [__]netdev_queue_config().
netdev_queue_config() should evaluate the config in reverse order of
priority, so:
 - get defaults
 - get device-level config
 - get per-queue config
 - get MP overrides

On close we are clearing the MP overrides, since we don't have
per-queue config we revert to defaults (as you say). But once there's
some overlap with device or per-queue configs we'll go back to the next
level of config in order of priority.

Did I understand the question right?

FWIW I think something that'd be a major usability win would be to make
MP presence imply per-queue HDS threshold of 0 automatically. So that'd
probably be first on my list of knobs to extend the "priority" model to.

> With the very first rx-buf-len series it was possible to set a
> rx-buf-len via YNL for a normal queue, switch to a MP queue and then
> on MP queue close the configuration got switched to the default value
> of rx-buf-len instead of what the user had configured. This was
> not convenient.

Yes, not sure IIUC, but the fact that clearing the MP didn't
automatically delete the MP-related setting was the main reason
we ditched the full qcfg for this use case.

