Return-Path: <netdev+bounces-292833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLk2DNeaGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287795F7453
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFB653004D2E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02733A9FC;
	Thu, 28 May 2026 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOoY7UHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B203382CD
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997340; cv=none; b=D0kuxIjbLJkZAS3YyvTIlIyWv7EleAM35EYizMSNn47BObU7QNoiaVRGVm31TJoVMsOJlpQZIo13D7w3IspBrjIMFWrzIlm8IqFpoznu0pySckJwB0bQs3G/Utlwx5UEgV7UKB7ahbRxZqZk6bUc51L38bpfNxGNoe6U6DYW8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997340; c=relaxed/simple;
	bh=Rs3iDXyNPjzIj8+Go08ryVuMRbA8PkG+FiuixgqowGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/TZCkx5K8VD3FqTF1w5gwJ2D/wilAD9/4IANxx8YGKFRZqB14C8A3CWlIJpNBFvH0RAP+2DW20Iqpkl0zcJ5/9YTk57G/r0R278K/vty8d2pGdMYbUmTVlfC0kKQAGQZxX7Ei3Byqmuo1J96JJg/CEWfWFN75gZhF63e9KMt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOoY7UHE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA821F000E9;
	Thu, 28 May 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779997339;
	bh=RJoq9qarIskm7VxbTKa/s0TS8lTezHfWJfg2CZckn00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UOoY7UHE1yxsDOFVhWQOlUEAkT+5tjCT/dmbw3EAFx1URNCAtIlHs8rumQeG1WTW4
	 /UajF5TmeSYjQKWZulyRD3kdcMSXAPGJux6zeX/2cvOZZ6UZsGpcII9VcMbCNl25qQ
	 TUncapfB+NwSRd2pT9usID+ZfaWR82gTZND0KbKv9LWzew567d8yfcVJXlIcmzbbvp
	 D5Kora/2sQ1pw6PGdYT6buw8lL6wZuxyrAcNFJCXFyH/f0raFOphhwrDTsMlXBQE4k
	 49J+qP7rcqFovQarHfv/i+wxIz0ZpQRqHMXcxVQXGYGXKO1POOj8SyVBWHcj+mGQSQ
	 u+axHDUebb7DQ==
From: Simon Horman <horms@kernel.org>
To: kipreyyy@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] appletalk: fix use-after-free in atalk_sendmsg due to route lookup race
Date: Thu, 28 May 2026 20:37:09 +0100
Message-ID: <20260528193707.2711621-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526085735.61445-1-kipreyyy@gmail.com>
References: <20260526085735.61445-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292833-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 287795F7453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: appletalk: fix use-after-free in atalk_sendmsg due to route lookup race

This patch attempts to fix a use-after-free in atalk_sendmsg() by deferring 
route deletion with kfree_rcu() and caching required route fields under 
rcu_read_lock(). It also takes a reference on the route devices using 
dev_hold() to prevent them from disappearing during the sleeping allocation.

> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 30a6dc06291c3..2c754378fa088 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -603,7 +603,7 @@ static int atrtr_delete(struct atalk_addr *addr)
>  		     tmp->target.s_node == addr->s_node)) {
>  			*r = tmp->next;
>  			dev_put(tmp->dev);
> -			kfree(tmp);
> +			kfree_rcu(tmp, rcu);

Simon says: while the issue below is flagged as not being introduced by
            this patch, I think that if it is problem then it prevents
	    this patch from working as intended.

	    So if it is an issue I suggest addressing it in the context of
	    this patch, perhaps by adding another patch to this patch-set.

[Severity: High]
This isn't a bug introduced by this patch, but does the synchronous
dev_put() allow the network device reference count to drop to zero while
RCU readers are active?

While kfree_rcu() defers freeing the route, dev_put(tmp->dev) is still
called synchronously here. If a device is being unregistered and this
synchronous dev_put() removes the last reference, the device's refcount
could drop to zero before the RCU grace period ends.

When a concurrent atalk_sendmsg() holding rcu_read_lock() then calls
dev_hold() on this device, could it increment a zero refcount and cause a
refcount saturation warning or use-after-free?

[ ... ]

> @@ -628,7 +628,7 @@ static void atrtr_device_down(struct net_device *dev)
>  		if (tmp->dev == dev) {
>  			*r = tmp->next;
>  			dev_put(dev);
> -			kfree(tmp);
> +			kfree_rcu(tmp, rcu);

Simon says: likewise for the issue below.

[Severity: High]
This is a pre-existing issue, but this appears to have the same synchronous
dev_put() problem as atrtr_delete() above.

[ ... ]

> @@ -1600,6 +1603,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	/* For headers */
>  	size = sizeof(struct ddpehdr) + len + ddp_dl->header_length;
>  
> +	rcu_read_lock();
>  	if (usat->sat_addr.s_net || usat->sat_addr.s_node == ATADDR_ANYNODE) {
>  		rt = atrtr_find(&usat->sat_addr);

Simon says: and the issue below too.

[Severity: High]
This isn't a bug introduced by this patch, but are there other callers
of atrtr_find() that are now missing rcu_read_lock() protection?

atrtr_get_dev() calls atrtr_find(), which temporarily takes
atalk_routes_lock and then returns a raw pointer:

net/appletalk/ddp.c:atrtr_get_dev() {
	struct atalk_route *atr = atrtr_find(sa);
	return atr ? atr->dev : NULL;
}

Since atrtr_get_dev() does not hold rcu_read_lock() when dereferencing
atr->dev, and this patch uses kfree_rcu() to defer route deletion, could
a concurrent route deletion free the route before the read occurs?

>  	} else {
> @@ -1610,29 +1614,38 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  
>  		rt = atrtr_find(&at_hint);
>  	}
> -	err = -ENETUNREACH;
> -	if (!rt)
> +	if (!rt) {
> +		rcu_read_unlock();
> +		err = -ENETUNREACH;
>  		goto out;
> +	}
>  
>  	dev = rt->dev;
> -
> -	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
> -			sk, size, dev->name);
> +	dev_hold(dev);

Simon says: on the other hand, this one looks like it is orthogonal to
            this patch and should be considered in the context of possible
	    follow-up.

[Severity: Critical]
This is a pre-existing issue, but is there a data race on atrtr_default.dev
that causes a NULL pointer dereference here?

atrtr_device_down() sets the static atrtr_default.dev locklessly to NULL:

net/appletalk/ddp.c:atrtr_device_down() {
...
	if (atrtr_default.dev == dev)
		atrtr_set_default(NULL);
}

If atrtr_find() locklessly returns &atrtr_default, and atrtr_device_down()
clears the default route between the lookup and dev = rt->dev, could this
read a NULL pointer?

Since dev_hold(dev) does not check for NULL, wouldn't it attempt to
increment the refcount at a NULL offset and cause a kernel crash?

Simon says: While this one seems to warrant further investigation in
            the context of this patch.

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of reference
counting on the default route break the newly added RCU assumptions?

The static atrtr_default route does not hold a reference count on its
network device (no dev_hold() is performed when atrtr_set_default()
sets it). Consequently, when the device is unregistered, its refcount
can drop to zero immediately.

If atalk_sendmsg() retrieves this route and calls dev_hold() inside its
RCU critical section, could it increment a zero refcount? This would trigger
the same refcount saturation and use-after-free issues as the synchronous
dev_put() described earlier.

> +	rt_flags = rt->flags;
> +	rt_gateway = rt->gateway;
>  
>  	hard_header_len = dev->hard_header_len;

