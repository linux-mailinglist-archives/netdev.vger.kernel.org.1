Return-Path: <netdev+bounces-282169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nnDtB6Zd8WmFgQEAu9opvQ
	(envelope-from <netdev+bounces-282169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F4148DF03
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 120243012B7E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1772309AA;
	Wed, 29 Apr 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1dRGI04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AE1F4C96;
	Wed, 29 Apr 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425823; cv=none; b=iKbOqvOLj9gp8MDRxb2N8uIFovctkDQ2qiPd7HigoaBFViBIn1Dvgxk0M+sS3qfuyOoZYiivrk7GmLVjYlvdUoNxgTVvPF/pb7VK5yJiFVtHFgimicF91vbvlvsFG1WnxI1i+4kgDbtlF8icWbEFCWMd3MATfvqR3vMJ8mHwhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425823; c=relaxed/simple;
	bh=TVXv517hG0o8VMLsbF3hizVokoU4Cp6BtNgQ41l2NLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmwssrFkjWOLEQT+KqV1OpYOXk1Tax3QDlWY1Tu1fdVZif4IHml4v9IFA0rDdi9h/urdPq832fNry9bF3GeNcLRBYr7pcv8HkfKRKt5moAB6up/9yBXDnPIc04JVRgfJ2xJlB2VWE21vsVnC2C/n6vXT+K53nirRbZOVTJHMCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1dRGI04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11423C2BCB7;
	Wed, 29 Apr 2026 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777425823;
	bh=TVXv517hG0o8VMLsbF3hizVokoU4Cp6BtNgQ41l2NLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1dRGI04mz5EMue+Lr6yoH1yoVxj1oigZF0/wBHQFHnNJSTwUsLHbjVqfN73Ph8J1
	 1gCd2dCrtt0r8qbiRzfpUhlxy54dDZgr3JRg7YxxAjJ4bQBapnve3RYNo88HaoLW8O
	 C14DFB4yEI5bi/jg1JYfcQi0oD8KXuBxcrc9P7CWb9PToJQFFWKLDY4IA7e9fjFc1E
	 sNHMkr8QYp+m5XfD8x0JX1vuqHgULMTCS36eSI6X3WSHO/pLqkUmGr8T9qiL4hEFat
	 SnUpEkAe7RPVsgixUeR4nHtPSgE5sgjWS2jQVICqXJWqXpf8RNU66zt/2OXSKCeyii
	 2Z2nUmauN/FjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: faicker.mo@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: net_failover: Fix the deadlock in slave register
Date: Tue, 28 Apr 2026 18:19:54 -0700
Message-ID: <20260429011954.1519021-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427092923.93901-1-faicker.mo@gmail.com>
References: <20260427092923.93901-1-faicker.mo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8F4148DF03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282169-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: net_failover: Fix the deadlock in slave register

This patch replaces dev_set_mtu(), dev_open() and dev_close() in
net_failover_slave_register() with their non-locking netif_* counterparts
to avoid a deadlock when the slave is registered from the NETDEV_REGISTER
notifier, where register_netdevice() already holds the per-device ops
lock.

> diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
> index d0361aaf25ef..3f7d31033bae 100644
> --- a/drivers/net/net_failover.c
> +++ b/drivers/net/net_failover.c
> @@ -502,7 +502,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
>  
>  	/* Align MTU of slave with failover dev */
>  	orig_mtu = slave_dev->mtu;
> -	err = dev_set_mtu(slave_dev, failover_dev->mtu);
> +	err = netif_set_mtu(slave_dev, failover_dev->mtu);

Is net_failover_slave_register() only reachable from the NETDEV_REGISTER
notifier path?

Looking at net/core/failover.c, the fops->slave_register callback is
invoked from two places.  One is failover_event() on NETDEV_REGISTER,
which matches the call trace in the commit message and where
register_netdevice() has already taken the ops lock via
netdev_lock_ops().

The other is failover_register() -> failover_existing_slave_register(),
which walks existing netdevs under rtnl_lock only:

net/core/failover.c:failover_existing_slave_register() {
	rtnl_lock();
	for_each_netdev(net, dev) {
		if (netif_is_failover(dev))
			continue;
		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
			failover_slave_register(dev);
	}
	rtnl_unlock();
}

On that path, the slave's dev->lock is not held by the caller.

netif_set_mtu() -> netif_set_mtu_ext() calls netdev_ops_assert_locked(dev)
for devices with request_ops_lock (for example mlx5e, the driver in the
commit's own call trace).

> @@ -512,11 +512,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
>  	dev_hold(slave_dev);
>  
>  	if (netif_running(failover_dev)) {
> -		err = dev_open(slave_dev, NULL);
> +		err = netif_open(slave_dev, NULL);

Same question for this call.  netif_open() -> __dev_open() also does
netdev_ops_assert_locked(dev), and on the failover_existing_slave_register()
path the slave's ops lock is not held.

Before this change, dev_set_mtu()/dev_open()/dev_close() acquired the ops
lock internally via netdev_lock_ops(), so the pre-existing-slave path was
covered.  Does switching unconditionally to the non-locking variants
regress that path for slaves whose drivers use the per-device ops lock,
both as a lockdep splat when CONFIG_PROVE_LOCKING is set and as a loss of
ops-lock serialization against concurrent ethtool, queue and netdev-genl
operations on the slave?

> @@ -562,10 +562,10 @@ static int net_failover_slave_register(struct net_device *slave_dev,
>  err_vlan_add:
>  	dev_uc_unsync(slave_dev, failover_dev);
>  	dev_mc_unsync(slave_dev, failover_dev);
> -	dev_close(slave_dev);
> -err_dev_open:
> +	netif_close(slave_dev);
> +err_netif_open:
>  	dev_put(slave_dev);
> -	dev_set_mtu(slave_dev, orig_mtu);
> +	netif_set_mtu(slave_dev, orig_mtu);

Would it be more appropriate to acquire netdev_lock_ops(slave_dev) in
net_failover_slave_register() when the caller is not the NETDEV_REGISTER
notifier (where the ops lock is already held), instead of dropping the
locking unconditionally?

The commit message explains the NETDEV_REGISTER caller but does not
mention the failover_existing_slave_register() caller; could that
rationale be extended, or the other caller handled explicitly?
-- 
pw-bot: cr

