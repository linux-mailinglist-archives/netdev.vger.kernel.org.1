Return-Path: <netdev+bounces-253215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O9TE/OKdmkxRwEAu9opvQ
	(envelope-from <netdev+bounces-253215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:28:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265E82812
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B7C93001182
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3630C62E;
	Sun, 25 Jan 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1pq3GN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98543009C3;
	Sun, 25 Jan 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376493; cv=none; b=QMDZBWXamVuTYPiFmklw3ZrP1run/U9h26naoc1FouVD3JJPrGxpspH25srs2Rhjb098SFJHUpUS8Bb4mF7iWiZWVddg2cSVW1LQkWu3c6RvfYcGJjqym0odQxjpBij2cy93W0r5zRPKMWycbI5dkR9+yNvO7NbSPynvJh7jCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376493; c=relaxed/simple;
	bh=uVMCMyvfZ4s9lS2txgigny86OJMSLMjE2gP+cqhj00c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POpcGva2n/YSrPb2XLmeh1T+oOsvEWaJIbhGrMem3c6IwXHdR8gh2RGlMndL2WBZPU4yeZUnGMKb5tVrNm7DQz+11qLTMnFY95UrbpZXQWq2HdRK916axJEMiy/JQ2yzZjf6390LlKuOKNJP6kXKaHE2gq50sTrl8LesWGDYftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1pq3GN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D110AC4CEF1;
	Sun, 25 Jan 2026 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376493;
	bh=uVMCMyvfZ4s9lS2txgigny86OJMSLMjE2gP+cqhj00c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1pq3GN6k3TjxjrXyfJ5SbFrdJy+8dWn7dNf97tdLKx9L4Or+d4TQMG8yZn62iS++
	 hqYJPu45/ukXIuVqOnFmedqx1R+mwpjOCeDsQHgptMv8S/cHZ4iwHVVya/sWSKtOaZ
	 g5bhOSaxgze/EAqu3mSytqDTxl3pSr6z91HRyWzWqwpgdS9z7im1liYaY8AfZlY0WG
	 S0eGbVOVpemE6s8EMI1lR9XE43e0R5tBqVaFPHvmq/bv9fc+ZVFPvMBkQtjLjHBMQX
	 FKp67dFV0Zk1nIUXWzwZ4xG1Xyf/hm/cOYO8Hn2mMut4zkd4nYkbWXSdcMpLJFLTqA
	 p6swMaUAabx1w==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next] net: airoha: Use u64_stats_t with u64_stats_sync properly
Date: Sun, 25 Jan 2026 13:28:05 -0800
Message-ID: <20260125212805.3374863-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122185255.2761568-1-mmyangfl@gmail.com>
References: <20260122185255.2761568-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253215-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4265E82812
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: airoha: Use u64_stats_t with u64_stats_sync properly

This commit converts statistics fields from u64 to u64_stats_t and changes
direct arithmetic operations to u64_stats_add()/u64_stats_read() calls
to ensure atomic operations on 64-bit architectures.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 62bcbbbe2a95..6ed220e5a094 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1472,131 +1472,131 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
>
>  	/* TX */
>  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	port->stats.tx_ok_pkts += ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_ok_pkts, (u64)val << 32);

On 32-bit systems (ARCH_AIROHA is supported on ARM32 per
arch/arm/Kconfig.platforms), does this lose the upper 32 bits of the
counter?

The u64_stats_add() signature is:

  static inline void u64_stats_add(u64_stats_t *p, unsigned long val)

On 32-bit architectures, unsigned long is 32 bits. When (u64)val << 32
is passed, the resulting 64-bit value is truncated to unsigned long.
Since all the non-zero bits are in the upper half, the truncation yields
zero.

The original code worked because the destination was u64:

  port->stats.tx_ok_pkts += ((u64)val << 32);

This pattern appears 16 times in airoha_update_hw_stats() for all the
_CNT_H registers (tx_ok_pkts, tx_ok_bytes, tx_len[], rx_ok_pkts,
rx_ok_bytes, rx_len[]). On 32-bit builds, these counters would only
accumulate the low 32 bits from the hardware.

[ ... ]
-- 
pw-bot: cr

