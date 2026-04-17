Return-Path: <netdev+bounces-279302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBIdLe4d4mlX1wAAu9opvQ
	(envelope-from <netdev+bounces-279302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFF41AEC4
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAF39300406D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65604374722;
	Fri, 17 Apr 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUiC5yRg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C86282F25
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426472; cv=none; b=hWBGFk1Dh1nEVS0aQKEZngwS7Xk3kanUNgAk0cGHzES9QL5UttHHk4dovo03UYjOSGO7kxCMApFMm9scLtaFtxI7Ct3cX+7mYFqeibi4hDmkrbRv8CNYyu40W5R4zxVrn8G184ikou6SKBD3yE8c3jfhhIgQbw5XkmyecFnxdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426472; c=relaxed/simple;
	bh=AtVtjGo9WOREHNaDjSoboeKkxL/Kp+QHhxeYdDR6xfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOnNBy0qiJgdimr9Xi0P2eEQ7pHM3hHMVE5mtUlnvMw2UVPiE3p70vLxpgnXHWm3qa3i+m+wDj3y92HoNLP4MLCqA11QhuuPrA0l70cKK7rhs0S2SdNUYXAWLUicd6JaDwR4M8JuN2MXa08YK4m9XywJVgA1m4ejUiOsosd1NZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUiC5yRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955BC19425;
	Fri, 17 Apr 2026 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776426471;
	bh=AtVtjGo9WOREHNaDjSoboeKkxL/Kp+QHhxeYdDR6xfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUiC5yRgmyP7P9p95Zt3Q+pWNdJX9HnmB+keAuM7rQElcJyXk3dXvH/n+mWl+iFkb
	 Qg12aL0yWXxjBNd8fP/+PjgaLDHQrFoyjL7+dqRn7heCK/Ykwkqx668hACQ/kB1TEM
	 plGrtNWcrq9lRMiKAz2Y8TF+EA2xWyg40xyLsgLyKtk8k+HILvJpatUlmp5qi8DGRS
	 CX3vOT9uGkl9tQbg+7dbWIzV1mhrVMQBEydndmc+LiUTGwOC7i/pbHQ/Tz6TbiSLbF
	 FYVmPt8aQgnkQhq5FBWoreBkrDHeMqZtQWxY4zcIF7+KCA0tJjvIe4uq/D8apdJ7K2
	 xzpOqj9UYRwtQ==
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
Subject: Re: [PATCH net v3 5/5] iavf: refactor virtchnl polling into single function
Date: Fri, 17 Apr 2026 12:45:04 +0100
Message-ID: <20260417114503.95952-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414110006.124286-6-jtornosm@redhat.com>
References: <20260414110006.124286-6-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279302-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: BBEFF41AEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
iavf: refactor virtchnl polling into single function

This commit consolidates the init-time and runtime virtchnl message polling
logic into a single enhanced iavf_poll_virtchnl_msg() function.

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
[ ... ]
> +int iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
> +			   enum virtchnl_ops op_to_poll, unsigned int timeout_ms,
> +			   bool (*condition)(struct iavf_adapter *, const void *),
> +			   const void *cond_data)
>  {
[ ... ]
> +	do {
> +		if (timeout_ms && iavf_virtchnl_completion_done(adapter, condition,
> +								cond_data, op_to_poll))
> +			return 0;
>  
> +		status = iavf_clean_arq_element(hw, event, &pending);
> +		if (status == IAVF_SUCCESS) {
> +			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
>  
> +			/* Handle reset events specially */
> +			if (received_op == VIRTCHNL_OP_EVENT) {
> +				struct virtchnl_pf_event *vpe =
> +					(struct virtchnl_pf_event *)event->msg_buf;
>  
> +				if (vpe->event != VIRTCHNL_EVENT_RESET_IMPENDING)
> +					continue;

If received_op is VIRTCHNL_OP_EVENT but not VIRTCHNL_EVENT_RESET_IMPENDING,
the loop executes continue. Does this mean that during runtime polling (when
timeout_ms > 0), other asynchronous events like VIRTCHNL_EVENT_LINK_CHANGE
bypass iavf_virtchnl_completion() entirely and get discarded?

> +
> +				dev_info(&adapter->pdev->dev,
> +					 "Reset indication received from the PF\n");
> +				if (!(adapter->flags & IAVF_FLAG_RESET_PENDING))
> +					iavf_schedule_reset(adapter,
> +							    IAVF_FLAG_RESET_PENDING);
> +
> +				return -EIO;
> +			}
> +
> +			v_retval = le32_to_cpu(event->desc.cookie_low);
> +
> +			if (!timeout_ms) {
> +				if (received_op == op_to_poll)
> +					return virtchnl_status_to_errno((enum virtchnl_status_code)
> +							v_retval);
> +			} else {
> +				iavf_virtchnl_completion(adapter, received_op,
> +							 (enum iavf_status)v_retval,
> +							 event->msg_buf, event->msg_len);
> +			}
> +
> +			if (pending)
> +				continue;

When pending is true, the loop proceeds to the next iteration before executing
the memset buffer clearing code below. Might this leave stale data in
event->msg_buf for the next iavf_clean_arq_element() call if the subsequent
message is smaller than the previous one? The original implementation zeroed
the buffer before checking pending.

> +		} else if (!timeout_ms) {
> +			return iavf_status_to_errno(status);
> +		}
>  
> +		if (timeout_ms) {
> +			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);

The size passed to memset is hardcoded to IAVF_MAX_AQ_BUF_SIZE. If a caller
ever provides a timeout but passes a smaller buffer in the event structure,
could this write out of bounds?

For example, other callers like iavf_get_vf_supported_rxdids() use an 8-byte
stack variable for event->msg_buf with event->buf_len set to 8. Would it be
safer to use event->buf_len here instead of the hardcoded macro?

> +			usleep_range(50, 75);
>  		}
>  
> +	} while (!timeout_ms || time_before(jiffies, timeout));

