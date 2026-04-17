Return-Path: <netdev+bounces-279288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNtaDO3/4Wna0QAAu9opvQ
	(envelope-from <netdev+bounces-279288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C890B419698
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EDB730D5BE8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136983B47C6;
	Fri, 17 Apr 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+SaMp0D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477D3B3BEB
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418287; cv=none; b=LxUkmmsxxZhX//rftLZbAn7EcpuXrwjGWY1JWzfrSMsKYpeYWVvK0USySu5NP66QRM6RdWkw5syAbEOxtYwqfKHd+qFLqyuzZaSkwkI5OmGKuejzud3cYDAke6ItDA5H0QUD8cJhsEZnNrAZVEuUxx67phllhpDjdPUfa3aEwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418287; c=relaxed/simple;
	bh=wHJYU1iKI6iAbC5ISchoRkeWmMX7820CTrVZUNdaN4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyUFHKyoBTCU8gDxDiYhRSwu8fwARdjoM4qzIUng1Q1yC3XBWedXLqcFTyfLSYIebBbMxe1zWwYKTpoSues0VVtm7aEXhi+OpFOmETdOg7/XfYGgRmOEOggaw6iNVd0ezfqBjetubJLr/szRaE48/rH8/pO5G4hqTE3M7RUKka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+SaMp0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E438FC19425;
	Fri, 17 Apr 2026 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776418286;
	bh=wHJYU1iKI6iAbC5ISchoRkeWmMX7820CTrVZUNdaN4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+SaMp0D3QmY5OFztuvoXob/+d3M6isW2YfhVXDigP0FPISULl39HyMK12gdeCzwG
	 8vOjhlickEeBiRsQtl0J5ov+z+BpH4L49F13k4gO5E3yzNeUtADtbPEvZcBiYRZeJQ
	 GuY3VQUrwJk3noHDinPfuUN60xvMz5FjuDqZZwk5Dh9vA+VYas5wuyWAnoQVGhUldS
	 a3rZTC8ZaE5OXQ5mjj7fFgQ+xt3iGQ42ZTurl+5AF3KcHEjsbISssDWeFesc4pgueW
	 HmieKLMjrc1SPfz6fcF2reakS5Bajq9A7My83yqYuAd6U+Rbsfud5jNrlZcP6/jsVa
	 oqyL/86S+mCZA==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net v3 3/5] iavf: send MAC change request synchronously
Date: Fri, 17 Apr 2026 10:31:05 +0100
Message-ID: <20260417093104.51561-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414110006.124286-4-jtornosm@redhat.com>
References: <20260414110006.124286-4-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279288-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C890B419698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: send MAC change request synchronously

This commit attempts to fix a deadlock scenario during MAC address
changes by sending the ADD_ETH_ADDR message directly and polling the
admin queue synchronously, avoiding reliance on the watchdog task.

> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
[ ... ]
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter)
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  {
[ ... ]
>  	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
>  
>  	len = virtchnl_struct_size(veal, list, count);
[ ... ]
>  	veal = kzalloc(len, GFP_ATOMIC);
>  	if (!veal) {
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
> -		return;
> +		return -ENOMEM;
>  	}

If kzalloc() fails here, the function returns -ENOMEM but leaves 
adapter->current_op set to VIRTCHNL_OP_ADD_ETH_ADDR. Does this permanently
prevent any future virtchnl operations from running, as they will all
immediately fail with -EBUSY checks?

> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
[ ... ]
> +	do {
[ ... ]
> +		ret = iavf_clean_arq_element(hw, &event, &pending);
> +		if (!ret) {
> +			v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +			v_ret = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
> +
> +			iavf_virtchnl_completion(adapter, v_op, v_ret,
> +						 event.msg_buf, event.msg_len);

Unlike the legacy iavf_adminq_task() which explicitly checked for v_op == 0
before processing, this code appears to pass a 0 opcode directly to
iavf_virtchnl_completion() when fetching non-virtchnl admin queue events.

When v_op is 0, the completion handler hits the default switch case and
unconditionally clears adapter->current_op. Could this corrupt the state
machine by clearing the current operation state while a valid operation is
still pending?

[ ... ]
> +		usleep_range(50, 75);
> +	} while (time_before(jiffies, timeout));
> +
> +	if (iavf_virtchnl_done(adapter, condition, cond_data, v_opcode))
> +		ret = 0;
> +	else
> +		ret = -EAGAIN;
> +
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}

Similarly, if this polling loop times out, it returns -EAGAIN but does not
clear adapter->current_op. Will this also permanently block the control path
for the VF?

> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1047,6 +1047,46 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
[ ... ]
> +static bool iavf_mac_change_done(struct iavf_adapter *adapter, const void *data)
> +{
> +	const u8 *addr = data;
> +
> +	return iavf_is_mac_set_handled(adapter->netdev, addr);
> +}

When promoting an existing secondary MAC to be the primary MAC,
iavf_replace_primary_mac() retrieves the existing filter which already has
f->add_handled set to true.

iavf_add_ether_addrs() sets f->add = false before dispatching. Because
iavf_is_mac_set_handled() checks (!f->add && f->add_handled), will this
cause iavf_mac_change_done() to immediately return true before the hardware
actually responds?

If so, this would cause iavf_set_mac() to prematurely evaluate the 
ether_addr_equal() check and fail with -EACCES.

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
> +	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done, addr,
> +					   VIRTCHNL_OP_UNKNOWN, 2500);
> +}

If the MAC filter list has many pending filters, iavf_add_ether_addrs()
stops at IAVF_MAX_AQ_BUF_SIZE and sets "more = true", meaning the newly
requested MAC at the tail of the list might not be sent in the first chunk.

Since this function holds the netdev lock, the watchdog task cannot run to
send the remaining chunks. Does this cause the polling loop to wait
2.5 seconds and time out waiting for a MAC address that was never sent?

Additionally, this function exclusively dispatches iavf_add_ether_addrs().
If changing the MAC requires deleting the old one first, such as in
environments with a strict 1-MAC limit, the deletion is left for the
asynchronous watchdog. Does this cause the synchronous addition to fail
because the hardware rejects the new MAC before the old one is deleted?

> @@ -1067,26 +1107,13 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
[ ... ]
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
[ ... ]
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret)
>  		return ret;

If a background watchdog operation is active, iavf_set_mac_sync() will
immediately return -EBUSY because current_op is not VIRTCHNL_OP_UNKNOWN.

This causes iavf_set_mac() to return -EBUSY to the user. However,
iavf_replace_primary_mac() already successfully updated the software filter
lists. Won't the watchdog task eventually wake up and asynchronously change
the MAC address on the hardware, leaving the system in an inconsistent state
where a failed syscall still executes in the background?

