Return-Path: <netdev+bounces-257695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGEwCzejhmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:28:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC40104A4C
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D29308D6F9
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E82533123C;
	Sat,  7 Feb 2026 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuja61Yp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6533031B;
	Sat,  7 Feb 2026 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431100; cv=none; b=TEYghbLQAIaYke2pNgeNwhsDJQI5sCya+fgVswXK77WOdLii/JWQSZbYvvCYxfSdy02tSM6I6GXOEORh2Hbc60roij9ZLOb0sl6/sZQQAqy2fKZ6QQ9DEYcSCJosRCMcO6/cQvrAe1by2EvmRLKsvR1wNSbRbJSIg8qoBVtS1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431100; c=relaxed/simple;
	bh=UWyz92SM9j8GKc8i9gyancApaVWtLnLFmPnadTcYtL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHGuIouZGD6/P7VfWf9kUE6Ktnhj6FAlKgcvKVJ6BLfqmtmxHsTekg7Z+1gVDbPsWlagyB/P+bJelNVlD13iMGzTiFBcqTTFllRTZcnFwqw1O29Lc2LK39bh4CbhSyuTuRiBwrvVSwLPW2Fh91D2P+Rihfj+blYqH/YM1HYIPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuja61Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07DBC116C6;
	Sat,  7 Feb 2026 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431099;
	bh=UWyz92SM9j8GKc8i9gyancApaVWtLnLFmPnadTcYtL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuja61YpActlL7SYOeuN4bRX06K/wprRCPDNSitcuvhFi6EEanxTcuXihjT3VaKPE
	 k2ul1quwphaQYud6k8ncZm4gQ0mr+zsg5izH9EhhL0vqaWbbR31Q+/PwLjKlnULT/7
	 WSiPFvffSwv6RTbW3gllHo45K53g3LyZiHXTsHxdB+4dmrpLh+QbcE7GneXXcwStvV
	 v+UJkM/9jZ5FirbsOJF2ay5OOAU0gA1uRolp/BIE0lbwrYbVrmo2UI40hhTarV7Int
	 fjA92Da5lTN+ns1Q3GYVhsKXgkR6trGuoHPPyb8QLFAIh6wQDedjoC/JDeJWdpB0nQ
	 t99Isd+a1pDNg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,07/11] net/nebula-matrix: add intr resource implementation
Date: Fri,  6 Feb 2026 18:24:57 -0800
Message-ID: <20260207022457.4017922-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-8-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-8-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAC40104A4C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add intr resource implementation

This commit adds MSI-X interrupt resource management for the Nebula Matrix
network driver, including interrupt vector allocation, mapping table
maintenance, and hardware interrupt enable/disable operations.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c

[ ... ]

> +static int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id, u16 num_net_msix,
> +					   u16 num_others_msix,
> +					   bool net_msix_mask_en)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct nbl_msix_map_table *msix_map_table;
> +	struct nbl_msix_map *msix_map_entries;
> +	struct device *dev = common->dev;
> +	u16 requested, intr_index;
> +	u8 bus, devid, function;
> +	bool msix_mask_en;
> +	u16 *interrupts;
> +	int ret = 0;
> +	u16 i;
> +
> +	if (intr_mgt->func_intr_res[func_id].interrupts)
> +		nbl_res_intr_destroy_msix_map(res_mgt, func_id);
> +
> +	nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);

Should the return value of nbl_res_func_id_to_bdf() be checked here?

Looking at nbl_res_func_id_to_bdf(), it returns U32_MAX when func_id is invalid:

    if (func_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt) + ...)
        return U32_MAX;

When that happens, the output parameters bus, devid, and function are not
written, leaving them uninitialized. These values are then passed to
hw_ops->configure_msix_info() further down in the function.

> +
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;

[ ... ]

