Return-Path: <netdev+bounces-289247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pm4GV3AC2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7F576271
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79939303AF2B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AC2FFF89;
	Tue, 19 May 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGlUWrw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8C2FF641;
	Tue, 19 May 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154932; cv=none; b=t1LaRqS1l0DLXB0zV7+R/tnZTMv81XOYEHsv8Vw+c0Db2RSh7sfNOKPRCt8udDLX//4HoATjiTRvrTfQ0cvnwv/SM/25vEtd/neV2ss2jjxmjY+HYbOJ89J/lKKQbWW300CHYy7Tej6xQvBno0f8oDJ1D4uOTBoLZnlMkeFYgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154932; c=relaxed/simple;
	bh=1sbt/fMBJouIL20m34pSsLUDGuFAbWCrTrDr5mVr0wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+ehKq96MYBIEnDdB9TjWggJhhfb8tDhr9oi0PedeRwsZzf2PbuxHFxsFBSSCJ6D7igf715bD7ZW4UqFhpj0ZL3klFPmCyGps6PxJdSf2ETeXFYar8f9ewf3mF8qNM2NJQdoAxwx+IcWiy9jaDjaFw9af60bslDhPwshD9V28Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGlUWrw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E16C2BCC7;
	Tue, 19 May 2026 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779154932;
	bh=1sbt/fMBJouIL20m34pSsLUDGuFAbWCrTrDr5mVr0wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGlUWrw3wYyqyQ/3pXWGgblDIidolYgRi5n5N6ErCgLrUdOjbGP3m8fNDLaGVWgTK
	 so1/wmzrEHMJGXYEwTaqCXAokVN4/LV8Z+U6YteKir1SnWXvB4l+7t6elhiv1Vyza2
	 3H9v77mfDG+cOzl4Y5AGHujzOkO7lRxFAByjpbYF73B3KbjhzMIEwh22xm3Hs2Rj+d
	 stzkRYCfY4NzQVwlL0/jz7pC3xlScF8Kf8EShJ0J9TlJivYr7GpPpLL1Ud+AWBeoVv
	 lX6MXk482lF2fXNDD0n+1OAM/4+JJuDc4vodwT/HRDUkYaavoDmoJFPO5EWaFWIa4u
	 63n9hIJFBL3Fw==
From: Jakub Kicinski <kuba@kernel.org>
To: satishkh@cisco.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebaddel@cisco.com
Subject: Re: [PATCH net-next v7 08/10] enic: add MBOX VF handlers for capability, register and link state
Date: Mon, 18 May 2026 18:42:10 -0700
Message-ID: <20260519014210.3395909-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-8-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-8-68b9f4141f4c@cisco.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289247-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CBE7F576271
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add MBOX VF handlers for capability, register and link state

This commit implements VF-side mailbox message processing for SR-IOV V2
admin channel communication, adding receive handlers for capability, register,
unregister replies, and link state notifications, along with initiation
functions for the probe-time handshake.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 9b1fa3857df5a..483053c781df7 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
[ ... ]
> @@ -305,9 +307,22 @@ struct enic {
>  	void (*admin_rq_handler)(struct enic *enic, void *buf,
>  				 unsigned int len);
>  
> -	/* MBOX protocol state */
> +	/* MBOX protocol state -- single-flight: on the VF, all callers
> +	 * that wait on mbox_comp run under RTNL or during probe/remove,
> +	 * so only one completion is outstanding at a time. mbox_lock
> +	 * protects the shared admin WQ from concurrent senders.
> +	 */
>  	struct mutex mbox_lock;
>  	u64 mbox_msg_num;
> +	struct completion mbox_comp;
> +	/* Type of reply the current waiter on mbox_comp expects.  Set
> +	 * under mbox_lock before reinit_completion(); cleared after
> +	 * wait_reply returns.  Reply handlers compare against the
> +	 * incoming reply type and drop stale replies from previously
> +	 * timed-out requests instead of waking the unrelated current
> +	 * waiter.
> +	 */
> +	u8 mbox_expected_reply;

[ ... ]
> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 0f7f9d2d091f7..b555362379b35 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
[ ... ]
> +static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
> +{
> +	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
> +	struct enic_mbox_pf_link_state_ack_msg ack = {};
> +
> +	switch (le32_to_cpu(notif->link_state)) {
[ ... ]
> +	default:
> +		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
> +			    le32_to_cpu(notif->link_state));
> +		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
> +		break;
> +	}
> +
> +	enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK, ENIC_MBOX_DST_PF,
> +			   &ack, sizeof(ack));
> +}

Could sending this ENIC_MBOX_PF_LINK_STATE_ACK with a non-zero ret_major error
code allow an unprivileged guest VM to flood the host kernel log?

Looking at the existing PF message handler enic_mbox_pf_process_msg(), when it
receives an ENIC_MBOX_PF_LINK_STATE_ACK with an error, it logs it like this:

    if (le16_to_cpu(ack->ack.ret_major))
        netdev_warn(enic->netdev,
                    "MBOX: VF %u link state ACK error %u/%u\n",
                    vf_id, le16_to_cpu(ack->ack.ret_major),
                    le16_to_cpu(ack->ack.ret_minor));

Since there is no rate limiting (like net_ratelimit()) on this specific
warning, a malicious guest could potentially craft and continuously send
invalid ACK messages to the PF's admin channel, spamming the hypervisor's log
and causing a denial of service.

[ ... ]
> +int enic_mbox_vf_capability_check(struct enic *enic)
> +{
> +	struct enic_mbox_vf_capability_msg req = {};
> +	int err;
> +
> +	enic->pf_cap_version = 0;
> +	enic->mbox_expected_reply = ENIC_MBOX_VF_CAPABILITY_REPLY;
> +	reinit_completion(&enic->mbox_comp);
> +	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);

Does this code miss acquiring mbox_lock before modifying mbox_expected_reply
and calling reinit_completion()?

The comment in enic.h dictates that mbox_expected_reply must be set under
mbox_lock before reinit_completion(), but here it seems they are updated
without holding the lock.

When a request times out, the waiter clears mbox_expected_reply = 0 without
locks. A concurrent RX handler processing a delayed reply might read the
expected type before it is cleared and proceed to call
complete(&enic->mbox_comp).

If the probe path proceeds to a cleanup step and calls
enic_mbox_vf_unregister(), could this delayed complete() race with the new
reinit_completion(), leading to a TOCTOU race where the completion is
spuriously signaled?

> +
> +	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
> +				 ENIC_MBOX_DST_PF, &req, sizeof(req));
> +	if (err) {
> +		enic->mbox_expected_reply = 0;
> +		return err;
> +	}
[ ... ]
> +int enic_mbox_vf_register(struct enic *enic)
> +{
> +	int err;
> +
> +	enic->vf_registered = false;
> +	enic->mbox_expected_reply = ENIC_MBOX_VF_REGISTER_REPLY;
> +	reinit_completion(&enic->mbox_comp);

Is the same mbox_lock missing here as well?

> +
> +	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
> +				 ENIC_MBOX_DST_PF, NULL, 0);
[ ... ]
> +int enic_mbox_vf_unregister(struct enic *enic)
> +{
> +	int err;
> +
> +	if (!enic->vf_registered)
> +		return 0;
> +
> +	enic->mbox_expected_reply = ENIC_MBOX_VF_UNREGISTER_REPLY;
> +	reinit_completion(&enic->mbox_comp);

And is it also missing here?

> +
> +	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
> +				 ENIC_MBOX_DST_PF, NULL, 0);

