Return-Path: <netdev+bounces-270051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ETNHjulvWm4/wIAu9opvQ
	(envelope-from <netdev+bounces-270051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:51:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB672E07FD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8251B315511C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED7352C22;
	Fri, 20 Mar 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9HVPIHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E7282F22
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035750; cv=none; b=ni62Rsb57v9bIJTw7T/UswPFWKvtpQpdRFPqL6oDXpk97FnNz0zoiyWvnbL2np4frPGdaxVt14OfWu5uzpFpv2ScOPr9tMTprgOmf/+tt72CBiI+ucMA8zqMH7NtNFNmh+okZnIk+Hp9YpXeFM2yvi7E63FcbWT2cMvlHxEPP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035750; c=relaxed/simple;
	bh=/lgrBaf4Lu3BSJzE5WFisPoWxzCA+1LAaAJ4lkMWWY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcaRBcCVq/5rn5tqb64BoMPrZs510+AaxTlvZSneDNNhWGsyCfXpmKwU6ocTqioHUaoSGDqUR4FGz9HI8+VC5aSXksN8cNVIxfEvvm4EZieojb2iXt2iqseIs/GRBfj8BjLIt4GyQd7BUNkD/YRh0Avm9XA1ML6dNUkzQMOqS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9HVPIHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597F4C4CEF7;
	Fri, 20 Mar 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035750;
	bh=/lgrBaf4Lu3BSJzE5WFisPoWxzCA+1LAaAJ4lkMWWY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9HVPIHVL7LzsCHeLvM0C7u6qH4sU6KNGLw5qUDfnjogm4hHGaG1lH6xOGOJ8ejOz
	 ouh3VH3tjxUtYjt0oV2zCxqJMJ3xJgXUd7yzXtrAQ4DkMr4QBX8/FplPch3stDba14
	 jPFBzJn0X5+a9W6uIV9wgnJaV39i/xZ3MQOyGqzHyy5aBKQyd2F8lZqgZXUR3HWPOd
	 HSbMttKB+KOsxQ7JFxNd2XUtLD4fySPrbyLv+Tjf+/hc4T0Ldrly8bCPux6DrMraLL
	 0UNrcs42GyYoZK17feRlfBnYXPzB5B0fIxbmhaJwAA5T4fdxefFsulQHHWdLDjGixA
	 qDzUG5okmTILA==
From: Simon Horman <horms@kernel.org>
To: rjethwani@purestorage.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	mbloch@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	sd@queasysnail.net,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	borisp@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH v8 5/6] tls: add hardware offload key update support
Date: Fri, 20 Mar 2026 19:42:24 +0000
Message-ID: <20260320194224.175550-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319213323.235559-6-rjethwani@purestorage.com>
References: <20260319213323.235559-6-rjethwani@purestorage.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,gmail.com,vger.kernel.org,davemloft.net,queasysnail.net,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-270051-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 2AB672E07FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
tls: add hardware offload key update support

Add TLS KeyUpdate (rekey) support for hardware offload connections.
When hardware rekey fails, the connection gracefully degrades to
software encryption/decryption while maintaining TLS_HW configuration.
Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 key update cycles.

> tls: add hardware offload key update support
>
> Add TLS KeyUpdate (rekey) support for hardware offload connections.
>
> When hardware rekey fails, the connection gracefully degrades to
> software encryption/decryption while maintaining TLS_HW configuration.

This commit message claims the connection "gracefully degrades to
software encryption/decryption" when hardware rekey fails. However,
the implementation appears inconsistent with this description.

Looking at the actual code behavior in net/tls/tls_main.c:

> @@ -711,64 +713,68 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>  	}
>
>  	if (tx) {
[ ... ]
> +		} else if (update && ctx->tx_conf == TLS_HW) {
> +			/* HW rekey failed - return the actual error.
> +			 * Cannot fall back to SW for an existing HW connection.
> +			 */
>  			goto err_crypto_info;

When hardware rekey fails on an existing TLS_HW TX connection, the code
returns an error rather than degrading to software mode. The same pattern
appears for RX:

[ ... ]
> +		} else if (update && ctx->rx_conf == TLS_HW) {
> +			/* HW rekey failed - return the actual error.
> +			 * Cannot fall back to SW for an existing HW connection.
> +			 */
>  			goto err_crypto_info;

The comments explicitly state "Cannot fall back to SW for an existing HW
connection." This contradicts the commit message's claim of graceful
degradation.

Could the commit message be updated to accurately describe the error
handling behavior? This inconsistency was noted by Sabrina Dubroca during
review of v7, and remains in v8:
https://lore.kernel.org/netdev/aZxm8hSrVMkEIc2O@krikkit/

Additionally, the commit message style may be worth reviewing. Sabrina
suggested looking through git log for net/ to match the typical commit
message format used in the networking subsystem.

