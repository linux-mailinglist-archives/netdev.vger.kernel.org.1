Return-Path: <netdev+bounces-289246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPC7KybAC2olMAUAu9opvQ
	(envelope-from <netdev+bounces-289246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:43:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B7576269
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DBCF3015CAB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B12F6160;
	Tue, 19 May 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErDh9iPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E71A704B;
	Tue, 19 May 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154930; cv=none; b=jFWb+h/u6JlP7aCrod/vWQ7WtQMG1zBWFGIMqCkNTn6XZg/TSb4ISfP3OxRbi+xkCrtemNzLnnwWTNF39UIKCYLPKrrPe52VV8QX4GU1C8D+vurjBgXHLfcDfLwPIAv9NhbFKMMU8IT//lIIWuMCI7V0hnWohej0f5h8fVB92yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154930; c=relaxed/simple;
	bh=zYzxQIEHamL1p1jrJX42pVc71PpqD9Nqjv09W6XlY6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE3cX+W6YExB/QCLS6zPhUSPNMND14kDlq2SBYow680jO6N6Lnxf6AhLYv0f5F84QQ9zFOAxYdbv2C6G5pTn20wf5qHE5cp/Cuoq12mzKg4y8YLeYT2iEs3tJ41dZDPr4A/zSJyNDg0wWn7SzgRHZDpQ1BmlbFBBB8db+P51XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErDh9iPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0804C2BCB7;
	Tue, 19 May 2026 01:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779154930;
	bh=zYzxQIEHamL1p1jrJX42pVc71PpqD9Nqjv09W6XlY6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErDh9iPEJWFQ04jeqTcmtoAKSzdWoGZg29LmJcqR9LP3R22ZVuHMX11S/TQhS8v9m
	 KmUwkYFQiGo/N4kAFMQioGomfG6sgp2xdb8Gp4hg76DK0t+sdQwIvciGWKqbDq12Ht
	 UMioPwZDIHKCMNiOBRnIjFTi6QLYXqOxSRlFVqsPN+GYY5SRGCJrFPqXPeo0wkG0mM
	 0VTgUrUEpRD+TyGfxypPONWBKz8ExO05ky9LvIVRAP1E0/GNQg4Ntli0tkXeeKRDA5
	 tALl32gfIO6keyeUK+Sx4wU3ZWcNeEvdj4Tq/pveLuIZwiG/+AQcbkEd0knHSwIobE
	 x93rFGRh+Vz6g==
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
Subject: Re: [PATCH net-next v7 07/10] enic: add MBOX PF handlers for VF register and capability
Date: Mon, 18 May 2026 18:42:08 -0700
Message-ID: <20260519014208.3395879-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-7-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-7-68b9f4141f4c@cisco.com>
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
	TAGGED_FROM(0.00)[bounces-289246-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1E2B7576269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add MBOX PF handlers for VF register and capability

This commit implements PF-side mailbox message processing for SR-IOV V2
admin channel communication. It routes messages from VFs to type-specific
handlers and tracks per-VF state.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 3f95247b8f6ba..0f7f9d2d091f7 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -135,10 +135,177 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,

[ ... ]

> +static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
> +					u16 vf_id, u64 msg_num)
> +{

[ ... ]

> +	err = enic_mbox_send_link_state(enic, vf_id,
> +					ENIC_MBOX_LINK_STATE_ENABLE);
> +	if (err)
> +		netdev_warn(enic->netdev,
> +			    "VF %u: failed to send initial link state: %d\n",
> +			    vf_id, err);

Could a malicious or misbehaving VF flood the host kernel log here?

Other VF-triggered warnings in this file use net_ratelimit() to prevent a
host-side denial-of-service condition where unbounded kernel logging degrades
system performance. Does this netdev_warn() need a net_ratelimit() check as
well?

> +	/* Registration succeeded; link state will be (re-)sent on next
> +	 * enic_link_check() event.
> +	 */
> +	return 0;
> +}

[ ... ]

> +static void enic_mbox_pf_process_msg(struct enic *enic,
> +				     struct enic_mbox_hdr *hdr, void *payload)
> +{

[ ... ]

> +	switch (hdr->msg_type) {

[ ... ]

> +	case ENIC_MBOX_PF_LINK_STATE_ACK: {
> +		struct enic_mbox_pf_link_state_ack_msg *ack = payload;
> +
> +		if (msg_len < sizeof(*hdr) + sizeof(*ack))
> +			break;
> +		if (le16_to_cpu(ack->ack.ret_major))
> +			netdev_warn(enic->netdev,
> +				    "MBOX: VF %u link state ACK error %u/%u\n",
> +				    vf_id, le16_to_cpu(ack->ack.ret_major),
> +				    le16_to_cpu(ack->ack.ret_minor));

Similarly, if a VF sends continuous ENIC_MBOX_PF_LINK_STATE_ACK messages with
a non-zero ret_major error, could it spam the host logs?

Should this netdev_warn() also be guarded by if (net_ratelimit())?

> +		break;
> +	}

[ ... ]
-- 
pw-bot: cr

