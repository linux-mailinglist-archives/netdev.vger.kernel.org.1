Return-Path: <netdev+bounces-278252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G7hM5OJ3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:25:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A653F4738
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769A8303F04D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9B1DDA18;
	Tue, 14 Apr 2026 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLUcmUnB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6E175A61;
	Tue, 14 Apr 2026 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126145; cv=none; b=PJE0X2rG83K1vGT9CDSg54AcaW50tq2TvIGjg023n1ZaU3za6ZKRFqKSvsHvhUHfgJtwMAm6scKj0X6L8R0G5KTIlCCON6kdM8iWmAgW8QxUl3ZiFHX++iZ3q0/7mZhnSrMsX8bq/2yEJKKuY+eMioeDyMcnRvTHzcNMkOuxmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126145; c=relaxed/simple;
	bh=UCGmYC7JyksK1JOVll9gQuDsB1qy77Euypc81Scg9JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRLliSmL5MKVV1I9p5UkUMcOAZNoUTmeoD0STRQEP+PHoZar8H0cIOJQdoObPqkGAuW67J6919N0DIcjSzYYgzrFWQcViWWK2qdbwgUoxR8K58YUJeigxCPWy+cmBwCl30f2PdhwiXun5nDvzEHrSboFFAcC4l1DnWX5Rxu+v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLUcmUnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3A8C2BCAF;
	Tue, 14 Apr 2026 00:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126144;
	bh=UCGmYC7JyksK1JOVll9gQuDsB1qy77Euypc81Scg9JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLUcmUnBUUsZ+pRrXr2mPuTiuZ6EzJDF/54FNKO+RkN+Mkrwd9dV9g4zaaOUJhJHa
	 1ClJy0SkK/8qNKLTwqBwJNnM6R47vrQkFLMTeYZbu7LC+w2LYJ1zqIBx8PcNIFspWu
	 WNh27yHgSNHFbFmDMatul/qxeb1jUZkmIUyQMfEPKlr+JmACFERfce+UmUPRnyds+V
	 WybhJaFBJNbBGRtOioHLbSm3dVXbFjja/yn317GRD7fdAi3ZA0c0yupnJ/oTyD9ZYF
	 zrYK8eYQjQjymQm9zqpBuTgZRC8+nKkOiOQJ9DqMpktyzGJ9RqAcINKel6QSVch9KJ
	 JKT2+2RjaJApg==
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
Subject: Re: [PATCH net-next v4 07/10] enic: add MBOX PF handlers for VF register and capability
Date: Mon, 13 Apr 2026 17:21:54 -0700
Message-ID: <20260414002154.3734634-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-7-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-7-f052326c2a57@cisco.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278252-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 36A653F4738
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add MBOX PF handlers for VF register and capability

Implement PF-side mailbox message processing for SR-IOV V2 admin channel
communication. It processes capability, register, and unregister requests
from VFs.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index d144c86d9ef84..f5784624ebbdf 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
[ ... ]
> @@ -124,10 +124,168 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
[ ... ]
> +static int enic_mbox_pf_handle_unregister(struct enic *enic, void *msg,
> +					  u16 vf_id, u64 msg_num)
> +{
> +	struct enic_mbox_vf_register_reply_msg reply = {};
> +	int err;
> +
> +	if (!enic->vf_state || vf_id >= enic->num_vfs) {
> +		netdev_warn(enic->netdev,
> +			    "MBOX: unregister from invalid VF %u\n", vf_id);
> +		return -EINVAL;
> +	}
> +
> +	reply.reply.ret_major = cpu_to_le16(0);
> +	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
> +				 &reply, sizeof(reply));
> +	if (err)
> +		return err;
> +
> +	enic->vf_state[vf_id].registered = false;

If enic_mbox_send_msg() fails (for example, due to a full admin WQ or channel
timeout), the function returns early and the PF misses setting the registered
state to false.

Since an unregister request indicates the VF driver is unloading or shutting
down, should the PF unconditionally clear the registration state regardless of
whether the acknowledgment successfully reaches the defunct VF?

If the local state is not cleared, could the PF assume the VF is still active
and continue attempting to send it unnecessary link state notifications?

[ ... ]
> +static void enic_mbox_pf_process_msg(struct enic *enic,
> +				     struct enic_mbox_hdr *hdr, void *payload)
> +{
> +	u16 vf_id = le16_to_cpu(hdr->src_vnic_id);
> +	u16 msg_len = le16_to_cpu(hdr->msg_len);
> +	int err = 0;
> +
> +	if (!enic->vf_state) {
> +		netdev_dbg(enic->netdev,
> +			   "MBOX: PF received msg but SRIOV not active\n");
> +		return;
> +	}
> +
> +	if (vf_id >= enic->num_vfs) {
> +		netdev_warn(enic->netdev,
> +			    "MBOX: PF received msg from invalid VF %u\n",
> +			    vf_id);
> +		return;
> +	}

Could a malicious or buggy guest VM use this untrusted VF input to cause a
host denial of service through log spamming?

Because this warning is not rate-limited, an untrusted VF could continuously
flood the PF's admin channel with malformed requests. This might exhaust host
CPU cycles and cause dmesg lock contention.

Should these logging calls in the message parsing path use
netdev_warn_ratelimited() instead?

[ ... ]
> @@ -142,10 +300,22 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
>  		return;
>  	}
>  
> +	msg_len = le16_to_cpu(hdr->msg_len);
> +	if (msg_len < sizeof(*hdr) || msg_len > len) {
> +		netdev_warn(enic->netdev,
> +			    "MBOX: invalid msg_len %u (buf len %u)\n",
> +			    msg_len, len);
> +		return;
> +	}

Similarly here, does this log also need rate limiting to protect the host
from being spammed by malformed headers sent from a VF?

