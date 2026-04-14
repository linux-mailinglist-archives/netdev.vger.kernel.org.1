Return-Path: <netdev+bounces-278253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPQIJsOJ3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AF3F4747
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757493066A3E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558B1A6812;
	Tue, 14 Apr 2026 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3wJaWnn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526BD3D561;
	Tue, 14 Apr 2026 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126152; cv=none; b=e+/ATAAvJhQcOl7PIFaVzR7Z90ePpns17+RlInh3p2Huy7yxhYG+uXwwRgCjstMo4ZaFRaKW9MQv66z27ZySHr6cdpQnrwHheywfZDprAPa2VwMcLHMYEMN8VXbpCBc84QUyQF4DQCLchnI5lMD9LqIEuzODKtgoP7JzXMqP0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126152; c=relaxed/simple;
	bh=l63ZVVcSuv7R/sWCVUcisera2Y165YnhT9GLwDtQxNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNuCrAjAk9PmQqgGyWLWU+mqvSC2dmmeWK7l/lvEG7jBm7fMT9dDLaQHRITOtpqvO9o2kRcQwEuYlMV9xjdBqpjWOix6KNHxEEJPYmHGGjK951qztgQqDTyavwJUfspBayW7pGzmo9o+6m7+xofHvXeQoCdWBcUuNfXMaSfvKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3wJaWnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991DAC2BCAF;
	Tue, 14 Apr 2026 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126152;
	bh=l63ZVVcSuv7R/sWCVUcisera2Y165YnhT9GLwDtQxNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3wJaWnnymknelfTmG9HI2l5FeR3Dqeg3dWdCco3chFKfo7Ln+cMLcP574qZh1vBc
	 qWcbwPVtSQvBba+Y+pb7O3Y79MmvVu2XE7WVqiJ76dHT4U9dk6KpGo7VT4Z9nx5VlV
	 w3grLEofnHwDB4X2ygcXhwLs2nMjO5gpx/XWemZB0iRk+kTTnvfd29HhbApVxkYtM7
	 yyxVTE/XRhwDMhXjjTqUnuiGxaxB4WAR0zqkciMunKQ3EIf2lVVWj00Kwe51zyLzV+
	 Rp4ftwKaJUKMr+gIk2dbQUOrJrV1raacmk/3h5LxSgJ09XiKFp+ZCWGMdS0RakQUmx
	 q8hq0Hq1oZ08Q==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 08/10] enic: add MBOX VF handlers for capability, register and link state
Date: Mon, 13 Apr 2026 17:22:25 -0700
Message-ID: <20260414002225.3735182-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-8-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-8-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278253-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 015AF3F4747
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add MBOX VF handlers for capability, register and link state

This commit implements VF-side mailbox message processing for SR-IOV V2
admin channel communication, including handlers for capability checks,
registration, and link state notifications.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index f5784624ebbdf..b5ed31450ee76 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -280,6 +291,136 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
>  			    hdr->msg_type, vf_id, err);
>  }
>  
> +static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
> +						 void *payload)
> +{
> +	struct enic_mbox_vf_capability_reply_msg *reply = payload;
> +
> +	if (le16_to_cpu(reply->reply.ret_major) == 0)
> +		enic->pf_cap_version = le32_to_cpu(reply->version);
> +	complete(&enic->mbox_comp);
> +}

Does this code handle delayed replies safely? 

If a capability request times out and the VF proceeds to send a register
request, could a delayed capability reply call complete() here and prematurely
wake up the register request? 

Since there is only a single shared completion and no validation of the
currently expected reply type, the new request might wake up, evaluate unmatched
state, and fail incorrectly.

[ ... ]

> +static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
> +						 void *payload)
> +{
> +	struct enic_mbox_vf_register_reply_msg *reply = payload;

This isn't a bug, but is it intentional to use the register_reply_msg structure
here for an unregister reply? While they currently have the same layout, this
could be brittle if the structures diverge in the future.

> +
> +	if (le16_to_cpu(reply->reply.ret_major)) {
> +		netdev_warn(enic->netdev,
> +			    "MBOX: VF unregister rejected by PF: %u/%u\n",
> +			    le16_to_cpu(reply->reply.ret_major),
> +			    le16_to_cpu(reply->reply.ret_minor));
> +	} else {
> +		enic->vf_registered = false;
> +	}
> +	complete(&enic->mbox_comp);
> +}

[ ... ]

> +	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
> +		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);

Similarly here, the register_reply_msg size is being used for the unregister
reply validation check.

> +
> +		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
> +					     payload_len, exp))
> +			return;
> +		enic_mbox_vf_handle_unregister_reply(enic, payload);
> +		break;
> +	}

[ ... ]

> +int enic_mbox_vf_unregister(struct enic *enic)
> +{
> +	int err;
> +
> +	if (!enic->vf_registered)
> +		return 0;
> +
> +	reinit_completion(&enic->mbox_comp);
> +
> +	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
> +				 ENIC_MBOX_DST_PF, NULL, 0);
> +	if (err)
> +		return err;
> +
> +	err = enic_mbox_wait_reply(enic, 3000);
> +
> +	return enic->vf_registered ? -ETIMEDOUT : 0;
>  }

Is the err value from enic_mbox_wait_reply() intentionally ignored here?

If the PF successfully receives the request but explicitly rejects it,
enic_mbox_wait_reply() returns 0, but enic->vf_registered remains true. This
causes a protocol-level rejection to be conflated with a channel timeout by
returning -ETIMEDOUT.

