Return-Path: <netdev+bounces-288549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GHqB7TFB2pyIAMAu9opvQ
	(envelope-from <netdev+bounces-288549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5051559B7F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 363BD300E029
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2E24676D;
	Sat, 16 May 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS6P9twR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCA1E5724;
	Sat, 16 May 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894245; cv=none; b=EeR7zv0IAqBWbNpdiAczZsH5NI1i4TmK7eU+24kDMeZ0KbMjNZZ+uJbz5Ijxckx9p7vZNfMhK/HAN2dmrdR58RlOZlyp2w5VXVWk3kMNYAbFoYqGqo06OSpLA3V8dIuy2D+aYQVLiEPtFgpjpkEhEfsU0M+MOaiVO6jrD/CDTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894245; c=relaxed/simple;
	bh=VDLgZ9qYf5MToJ9kx5H+huLMvETkYu6EHW4zksLDWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNVyjZU0Rvlo5n/WVb/2NfBfChYc1T/eCil/zRSAFLVWAT01Y5dbzV+nkcQICFbroSkeR/fDM8y8BAqdkGVdzTfOyNFqdL01ih1ijDIfmniU9PXgffOJZh2IlGToy/chpR8O7ro0CQWgT90UHtoWNHU3xabbpkevVv/nBR05fMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS6P9twR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561B4C2BCC9;
	Sat, 16 May 2026 01:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894243;
	bh=VDLgZ9qYf5MToJ9kx5H+huLMvETkYu6EHW4zksLDWi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS6P9twRkyY0z0a3em2n08yTm3PQMCA8gzanR9leXckzZ0fojPUcR208U8CyN7Dl6
	 iLx1Wh5YiktZqfR9YaNDXhoFARAhI5K2YfGgr9IIn/UQllYmEX/hegL7CR2dJhwgCp
	 ifdJ2V/l7P3L6yivPasm98mRCKrtUJT8ooGM+RX6LvkmLh4vZc9lzaJJqvk5pv1CQ7
	 E7nhvza7aAu0frLEzcjJcBST9cofitzQrSLQh/pqQVwrSSQC+SdjUoqv6tIXoVzIhO
	 1HF748q2h9bu71292fcZFmWhWmvgY6aKCBJO8hNcsfUyVzxkvwbS+QrpaoH2eDqM1+
	 ljutGEPMqvGDg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 09/11] net/nebula-matrix: add Dispatch layer implementation
Date: Fri, 15 May 2026 18:17:20 -0700
Message-ID: <20260516011721.1864053-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-10-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-10-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5051559B7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add Dispatch layer implementation

This patch introduces a control-level routing mechanism for the Dispatch layer.
Routing is controlled by interface-declared levels and upper-layer configured
control levels.

> Current state:
> - Regular PF: configures NET_LVL at Dispatch layer.
>   Since NBL_DISP_CTRL_LVL_NET is not yet wired in nbl_disp_init(),
>   all operations currently fall through to the CTRL_LVL_MGT branch
>   and use the channel path. The direct path for NET_LVL is a
>   framework extension point reserved for future use.
>
> - Management PF: configures both NET_LVL and CTRL_LVL.
>   Same as above — currently all ops use channel path.
>
> Future work:
> Implement the has_net / NBL_DISP_CTRL_LVL_NET branch in nbl_disp_init()
> to enable direct path routing for network operations.

The commit message states that NBL_DISP_CTRL_LVL_NET is not yet wired in
nbl_disp_init(), and lists implementing the has_net branch as future work.

However, the patch includes this exact logic in nbl_disp_init() below.

Could the commit message be updated to match the implemented code?

[ ... ]
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
[ ... ]
> +static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{
[ ... ]
> +	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VSI_ID, msg_id, err,
> +		     &result, sizeof(result));
> +	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);

Could this lead to a self-deadlock on txq_lock during mailbox polling?

If a message is sent while polling, nbl_chan_send_msg() acquires txq_lock
and processes incoming messages in its polling loop:

nbl_chan_send_msg() [acquires txq_lock]
  -> nbl_chan_clean_queue()
    -> nbl_chan_recv_msg()
      -> nbl_disp_chan_get_vsi_id_resp()

If nbl_disp_chan_get_vsi_id_resp() processes a request and calls
chan_ops->send_ack(), this will eventually call back into nbl_chan_send_msg():

nbl_disp_chan_get_vsi_id_resp()
  -> chan_ops->send_ack()
    -> nbl_chan_send_ack()
      -> nbl_chan_send_msg() [attempts to acquire txq_lock again]

Will this cause an immediate deadlock since the non-recursive txq_lock is
already held by the outer nbl_chan_send_msg() call?

[ ... ]
> @@ -71,9 +477,24 @@ int nbl_disp_init(struct nbl_adapter *adapter)
[ ... ]
> +	if (common->has_ctrl)
> +		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
> +
> +	if (common->has_net)
> +		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);

This appears to wire up the NBL_DISP_CTRL_LVL_NET branch, which contradicts the
commit message stating it is not yet wired.

> +
> +	nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
> +
> +	return ret;
>  }

