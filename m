Return-Path: <netdev+bounces-290966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALCTL97xEGp7fwYAu9opvQ
	(envelope-from <netdev+bounces-290966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263345BBB7B
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3D0301348A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54449194C95;
	Sat, 23 May 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS00q66s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E41548C
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495365; cv=none; b=BuqFOzY77dC3TAYPBKk+RhBeJPG4n3k5BS4DGbAZQsGyoomKVNNoVHsq+a4BB3iYF0bzHID5qlbexgId42MJZQKcRxdkWR2NI9U73YWziU/hR5cnijgTO9cc/MDvP4eOIka+wrwyo1fqaMT12Jc26S8XjUsQwnbv+g9qUYXcdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495365; c=relaxed/simple;
	bh=meoBoq3GBai1FHT2zQwsxT2CsuD7jTLWVPbq8KP60+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNo9xINJ6ZfR4SvX4KUzPuumjtXfX6HonbPuH8H93C+vmZiCjMsfF38Rptdx4J/rsqCj6VsX/rj3SlxXIk48a94/z5m2lq5xtZivSukJhCJz9wa0nKE+D5Mcdf4fbVzc04aLvinaNQd1CaE7+yNGxmrUdmzwQ3SPqEpWSPzgZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS00q66s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915241F00A3D;
	Sat, 23 May 2026 00:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495364;
	bh=ENId3wCqybuujbqtAWCsMT2uHkyUos9MYd5rg0yoU20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GS00q66sVqf3VAivqjCU3bUSCBkXg4ZW0QtRfzg9X1iu56fl0nuTPMhemwFYd0xjx
	 8F+dGgTEvzC0hJsQWxo9DSLY+O4W/d2yyvNXXbJQpBDMLeRE6j2k9fAxvPOgC7jsIf
	 PZPqhIqolp5FkEWhiV9KuAkdNWflgGJzIGtMQGTgPtWZkj6bYiayqjrnwYeFt50Km7
	 3i/TgztEMY8qYXKr683b+lUTjZBUGsRB/5qchLPvt8wunlYvsUJQcOHRyKqJDXbW6q
	 cVpmDKw/2A6xg0gMictfvgVOKqiczh+St2VtmSqk1oK6Go7Dh2vR5J5HMxLytUWU7n
	 0nNw9idrIFzXA==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	vinschen@redhat.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 5/8] iavf: send MAC change request synchronously
Date: Fri, 22 May 2026 17:16:02 -0700
Message-ID: <20260523001602.1756968-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-6-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290966-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 263345BBB7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
iavf: send MAC change request synchronously

This patch reworks iavf_set_mac() to send the ADD_ETH_ADDR virtchnl
message directly and poll the admin queue for the response, instead of
relying on the watchdog and adminq tasks (which now block on the netdev
instance lock held by iavf_set_mac()). It also exports
iavf_mac_add_reject() so the new path can roll back local failures, and
removes vc_waitqueue.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 78c59a58e0b2..ed790dc3de6b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1029,6 +1029,48 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
>  	return ret;
>  }
>  

[ ... ]

> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	ret = iavf_add_ether_addrs(adapter);
> +	if (ret)
> +		return ret;
> +
> +	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done,
> +					   addr, 2500);
> +}

[Medium]
Can this path mishandle the multi-batch case in iavf_add_ether_addrs()?

When the number of filters with f->add=true exceeds what fits in one
IAVF_MAX_AQ_BUF_SIZE message, iavf_add_ether_addrs() trims the batch and
sets more=true:

	len = virtchnl_struct_size(veal, list, count);
	if (len > IAVF_MAX_AQ_BUF_SIZE) {
		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
		while (len > IAVF_MAX_AQ_BUF_SIZE)
			len = virtchnl_struct_size(veal, list, --count);
		more = true;
	}
	...
	if (!more)
		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;

Only the first batch is sent synchronously here; the remainder is left
for the watchdog. iavf_replace_primary_mac() calls iavf_add_filter()
which uses list_add_tail(), so the new primary MAC is at the end of
mac_filter_list and ends up in the last batch.

In that scenario, iavf_poll_virtchnl_response() polls
iavf_is_mac_set_handled() for the new MAC, which never completes within
2.5 seconds because the message that would change it has not been sent
yet. iavf_set_mac() then returns -EAGAIN and the rollback below removes
the new filter via iavf_mac_add_reject() because is_new_mac is true.

Pre-patch the wait_event() on vc_waitqueue would eventually be satisfied
because the watchdog drained subsequent batches and the PF response for
the new MAC arrived. Should iavf_set_mac_sync() loop while
IAVF_FLAG_AQ_ADD_MAC_FILTER (or more) is still set, so the new MAC is
actually transmitted before the timeout?

> @@ -1049,25 +1091,21 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback for local failures (timeout, send error, -EBUSY).
> +		 * Note: If PF rejects the request (sends error response),
> +		 * iavf_virtchnl_completion() automatically calls
> +		 * iavf_mac_add_reject(), ret=0, and this is not executed.
> +		 * Only local failures (no PF response received) need manual rollback.
> +		 */
> +		iavf_mac_add_reject(adapter);
> +		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}

[Medium]
Is iavf_mac_add_reject() safe to call when the AQ message never reached
the PF?

iavf_add_ether_addrs() clears f->add=false on every filter that it packs
into the batch, before iavf_send_pf_msg() is invoked:

	list_for_each_entry(f, &adapter->mac_filter_list, list) {
		if (f->add) {
			ether_addr_copy(veal->list[i].addr, f->macaddr);
			iavf_set_mac_addr_type(&veal->list[i], f);
			i++;
			f->add = false;
			...
		}
	}
	...
	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);

iavf_mac_add_reject() then walks the entire mac_filter_list and marks
every filter with !f->add && !f->add_handled as add_handled=true:

	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
		...
		if (!f->add && !f->add_handled)
			f->add_handled = true;
		...
	}

On a local failure (iavf_send_pf_msg() error, IAVF_FLAG_PF_COMMS_FAILED,
-EBUSY, -ENOMEM or polling timeout) any unrelated filters that were in
the batch (e.g., entries added by a prior ndo_set_rx_mode() that the
watchdog had not yet drained) get add_handled=true even though the PF
never received them. They are not retried since f->add was cleared.

Pre-patch iavf_mac_add_reject() was only called from
iavf_virtchnl_completion() after the PF actually rejected an
ADD_ETH_ADDR, so marking these filters as handled was correct because
the PF had seen them. Should the new local-failure rollback be scoped to
only the new primary MAC filter, rather than reusing the PF-reject
helper unchanged?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 4f2defd2331b..cd5211b9a798 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
>   * @adapter: adapter structure
>   *
>   * Request that the PF add one or more addresses to our filters.
> - **/
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter)
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_ether_addr_list *veal;
>  	struct iavf_mac_filter *f;
>  	int i = 0, count = 0;
>  	bool more = false;

[ ... ]

