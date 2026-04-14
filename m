Return-Path: <netdev+bounces-278442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPGbChs43mnbpQkAu9opvQ
	(envelope-from <netdev+bounces-278442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39E3FA2CE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858D1303525C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487CF34EF08;
	Tue, 14 Apr 2026 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+lll3ap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5B22FE0E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170810; cv=none; b=J/B1fh3ZRGWyjHTISyOhbQdbTnQD36Qy/hgrXGJKnv7JjTaPzB+Si/Mo7bkIZe08i9JAnsIIgc5oOEsYgf2HJCMnK1e6QeGuBmKDowdY0DHOQXMuotKmFPKgT0hd0aqE7bQUOCi3k5U1kpf6hGDEphk7DnkbN9ikAQ4P8vRn6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170810; c=relaxed/simple;
	bh=0xrsRx8+fhBqILy3gChyEPRzzf8cZshNTlrUxsv7RZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhf1+svmwWMHl4WtNBbTfptej3fls/PXImWE5vHnpCLM8FfueglAZmDIKLOJTAC6/kCJ4aU6s7Ye3wK0xuJCrdDWtrTS/IYaOiCEOEmzqaDCThRiZgO4SVMrhpw2AEJeIHjNu75eDqS8L6lVXmds0TaGi9r4OKZ7b0Zwe8MZZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+lll3ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10DFC19425;
	Tue, 14 Apr 2026 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776170809;
	bh=0xrsRx8+fhBqILy3gChyEPRzzf8cZshNTlrUxsv7RZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+lll3apOXZ6lUCDqv5yjMnIzo9yurD/78YpGTKuGiu5ceEmxt38X8F6eUAOQb4lK
	 w4cTDQgA1U9R+Zsn6xepiteJzeFNVxVhUQrfs1GEnM2NYOBBJuHuTm1wPE/TMigTCc
	 ciSfADwOeRtZqqQ+4iTr2y9FjwfaComoC1tgU8qG8cfdNzhsO+D/OcMwogPbSQYyLz
	 o/FLEeGhEE6EQ93hNdu3eZHQjmWjh5hXMwpL3nP6PFgaHzPO2N6XLXQBC58GHG+v0c
	 e7ceZE86pS8SNSIwm3GGq+/5WrnHoo4qlX5KX8OGUgO7rp8l+eLEYtcUVa3LWLBsIP
	 4dmVU0sH6dU9w==
From: Simon Horman <horms@kernel.org>
To: lorenzo@kernel.org
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()
Date: Tue, 14 Apr 2026 13:46:41 +0100
Message-ID: <20260414124641.754059-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412-airoha-wait-for-npu-config-offload-setup-v1-1-f4e0aa2a5d85@kernel.org>
References: <20260412-airoha-wait-for-npu-config-offload-setup-v1-1-f4e0aa2a5d85@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278442-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 7F39E3FA2CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
    net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()

This commit adds a poll loop in airoha_ppe_offload_setup() to wait for the NPU
PPE configuration to complete before running airoha_ppe_hw_init().

> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index c2c32b6833df9..52199f6b39f9b 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
[ ... ]
> @@ -1340,6 +1341,13 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
>  	if (err)
>  		goto error_npu_put;
>  
> +	/* Wait for NPU PPE configuration to complete */
> +	err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
> +				100 * USEC_PER_MSEC, false, eth,
> +				REG_PPE_PPE_FLOW_CFG(0));

If the SoC has multiple PPE instances, is it sufficient to only wait for
REG_PPE_PPE_FLOW_CFG(0)?

Later in airoha_ppe_hw_init(), the code iterates up to eth->soc->num_ppe,
initializing all available instances:

drivers/net/ethernet/airoha/airoha_ppe.c:airoha_ppe_hw_init() {
    ...
	for (i = 0; i < eth->soc->num_ppe; i++) {
		...
		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
			     ppe->foe_dma + sram_tb_size);
    ...
}

If we only poll PPE 0, could the driver race with the NPU firmware's
initialization of subsequent PPEs?

Additionally, does this poll condition properly ensure the hardware is ready?
Since the break condition is simply `val`, it exits immediately if the register
contains any non-zero value.

If the register retains a non-zero value from a previous session (like across
driver reloads), or if an unclocked domain returns 0xFFFFFFFF, this poll might
succeed immediately and bypass the wait.

Could we clear the register before polling, or wait for a specific bit instead?

> +	if (err)
> +		goto error_npu_put;
> +
>  	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);

