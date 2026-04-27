Return-Path: <netdev+bounces-281408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNndBFmS72nRCwEAu9opvQ
	(envelope-from <netdev+bounces-281408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:44:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A94769DE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4583005599
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675A3D6683;
	Mon, 27 Apr 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGSOJSFZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D13D6673
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308244; cv=none; b=KM3EeqrdF/nbI0nPutq8vlQdobfnKWmVnwD6ZFwFrpU1xwOzw8qLxiC15CxS8H2GtnTcrZhHbLmzq92r86mID/+m8U29yVhErzR1hkeflrHW3/durCnQjbOHR3rT/wb9rjt2OnicszENj+YGJWgOH0EG4qGkNcNVypC6Q+RGn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308244; c=relaxed/simple;
	bh=wKIY3PMnej7pArpikhLOSs8krStKOs1qix0SOQmNecA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3hzLuBH3aHa3Y3ZAMEKOI5NzRkXUFroEd7WqAYTTKD6tXpL//JgorRowO0Z5pV+VEy4bF7+rnnsSXiEKKKKpODmZzRYiN1WRXynfytQgfXPXan5M82AVroMBNnV5FKn6iLMj45huOTPR4elFLZD1ygd0Xeavrymym4gT4S9SUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGSOJSFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0CEC19425;
	Mon, 27 Apr 2026 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777308244;
	bh=wKIY3PMnej7pArpikhLOSs8krStKOs1qix0SOQmNecA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGSOJSFZK7W2BeZeFd0/3P9QJ0274sr8/HSIOVmOy4Li3fTQhVIiJ39Dq/nNoXPNL
	 gZz98ZPZaIqvddoAANT3I1/qEfDO379sOVfmvXQ5vJZc1a0FghNpEDmPTAtM3x4Gf8
	 ghiAtIgaCwlnEv0aSoZCLl9G7tM4/5mvKe3tqnE5Bp4w3Pa+ZhPWHyJRtECbqVkcfU
	 PccYEqgWhdzcqDTzlhGFBhqbPrW7Rwg/MGf4zF/mRwbRU/ytZSKhDqw8unENe6IRYM
	 /b4BkMVAAWMjx5+J9bJrpxEZicfhfiM1bWX1YfGxZar1xKrr2zSVevEqohjgUa5ldM
	 UGFfh1BoeN+kg==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 3/4] iavf: send MAC change request synchronously
Date: Mon, 27 Apr 2026 17:43:57 +0100
Message-ID: <20260427164357.1227583-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423130405.139568-4-jtornosm@redhat.com>
References: <20260423130405.139568-4-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A58A94769DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281408-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: send MAC change request synchronously

This commit updates the MAC address setting in the iavf driver to be
synchronous. It sends the virtchnl message directly and polls the admin
queue for the response, rather than relying on the watchdog task, to avoid
deadlocks when holding the netdev instance lock.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 67aa14350b1b01..bc5994bf2cd99d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

[ ... ]

> @@ -1067,25 +1109,20 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
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
>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}

Does the manual rollback in iavf_set_mac() need to restore adapter->hw.mac.addr?

Before calling iavf_set_mac_sync(), iavf_replace_primary_mac() optimistically
updates adapter->hw.mac.addr to the new MAC address and unsets the is_primary
flag on the old MAC filter. If iavf_set_mac_sync() fails locally,
iavf_mac_add_reject() deletes the pending new MAC filter but doesn't restore
adapter->hw.mac.addr back to netdev->dev_addr.

By contrast, the PF-rejection path in iavf_virtchnl_completion() explicitly
restores it:

	iavf_mac_add_reject(adapter);
	/* restore administratively set MAC address */
	ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);

If the local failure was a timeout and a delayed success response arrives from
the PF later, could iavf_virtchnl_completion() blindly copy the corrupted
adapter->hw.mac.addr into netdev->dev_addr? This seems like it would silently
change the interface MAC to an address already deleted from the internal list.

Additionally, on subsequent MAC change attempts, wouldn't
iavf_replace_primary_mac() search for the old filter using the corrupted
adapter->hw.mac.addr, fail to find it, and permanently leak the old filter in
the PF's hardware tables?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a52c100dcbc56d..d1afb8261c2412 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -2956,3 +2966,76 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  	} /* switch v_opcode */
>  	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  }
> +
> +/**
> + * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
> + * @adapter: adapter structure
> + * @condition: callback to check if desired response received
> + * @cond_data: context data passed to condition callback
> + * @timeout_ms: maximum time to wait in milliseconds
> + *
> + * Polls the admin queue and processes all incoming virtchnl messages.
> + * After processing each valid message, calls the condition callback to check
> + * if the expected response has been received. The callback receives the opcode
> + * of the processed message to identify which response was received. Continues
> + * polling until the callback returns true or timeout expires.
> + * Clear current_op on timeout to prevent permanent -EBUSY state.
> + * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
> + * polling hardware.
> + *
> + * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
> + **/
> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> +				bool (*condition)(struct iavf_adapter *adapter,
> +						  const void *data,
> +						  enum virtchnl_ops v_op),
> +				const void *cond_data,
> +				unsigned int timeout_ms)
> +{

[ ... ]

> +		if (iavf_clean_arq_element(hw, &event, &pending) == IAVF_SUCCESS) {
> +			received_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +			if (received_op != VIRTCHNL_OP_UNKNOWN) {
> +				v_retval = le32_to_cpu(event.desc.cookie_low);
> +
> +				iavf_virtchnl_completion(adapter, received_op,
> +							 (enum iavf_status)v_retval,
> +							 event.msg_buf, event.msg_len);
> +
> +				if (condition(adapter, cond_data, received_op)) {
> +					ret = 0;
> +					break;
> +				}
> +			}
> +
> +			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
> +
> +			if (pending)
> +				continue;
> +		}
> +
> +		usleep_range(50, 75);
> +	} while (time_before(jiffies, timeout));
> +
> +	if (ret == -EAGAIN && adapter->current_op != VIRTCHNL_OP_UNKNOWN)
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;

Could clearing adapter->current_op on timeout cause overlapping virtchnl
commands and state corruption?

If the timeout expires and adapter->current_op is forced to
VIRTCHNL_OP_UNKNOWN, the VF watchdog might consider the admin queue free
and send a new command while the PF is still actively processing the
timed-out request.

If the PF eventually completes the timed-out request and sends a late response,
iavf_virtchnl_completion() will process it. At the end of
iavf_virtchnl_completion(), the driver unconditionally clears the state:

	adapter->current_op = VIRTCHNL_OP_UNKNOWN;

Would this prematurely clear the tracking state for the newly in-flight
overlapping command, compounding the state machine corruption and allowing
even more commands to be sent concurrently?

> +
> +	kfree(event.msg_buf);
> +	return ret;
> +}

