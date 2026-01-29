Return-Path: <netdev+bounces-254565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCf2JQXsemmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:11:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E656ABD82
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05F1E3019FD4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ABF2D94BA;
	Thu, 29 Jan 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc4twbEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83C2D46B3
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663473; cv=none; b=D+O3gWyllgQpN2aKaciH2ByvXD2RcZIDk4CoNlgMACNuJvWl3Mwv1F7MkmksHaBHXxABf8Qos/JcmgBvinwyhQPQG+RutlLo450JxKN5S09/tbxVvSOgLquVPxsy82eB4LL7aNBgnUPPGq0o3PhcFu/0/PriwYufRMUPN0Rxx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663473; c=relaxed/simple;
	bh=W9fqYP+KrfTCzJpFa0BishbYUbcgHmATKHrdr0OacMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0I6uiO1ISgZB96tYfRr8qTh2TrJcrxDjhYDhJ/33cK1Aij5fdI6Qxsz7+2ePkyuyO1b9U820xnXeRdKN+YEnrJy/KWWhnvxDGwHNUsdMBoTToTHIceYILuVAI+pkgxhgiLsdnE3U/YckHrd0JHKAIlmsn4ZPhV6IwMnQTCCdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc4twbEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63C2C116D0;
	Thu, 29 Jan 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663473;
	bh=W9fqYP+KrfTCzJpFa0BishbYUbcgHmATKHrdr0OacMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc4twbEyR/Ek9EGD44bFFn8wehzl7xdWkRlHTpu7ultX5sb7hWcpEeU8dw1yb/ehM
	 tCJ3q7MbisSj8UJHrougdG2wLdVvcs3fNglCUI1jQ7JJbgmdGOwB6EthH7CFX/85+o
	 6pO2uK0ETY6PSQTuztN7loH0sR7dnJiezcmvNMgTohLUTUUfq/8M/xEGqaycXvhtfV
	 m+oRaBXeow3dYuVn7BWkEID4VDBOQPojeGIGqu+LvFkmfiBwfSUaBCGehUQN2Wwvb1
	 n/CtRuuqW6gCfqcisD9awCA/h9MRbTKT9SyUmhin0igXpqoQhSzGM8jHeaycAAbNEZ
	 ce8WN5xCGptXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: Raju.Rangoju@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	Shyam-sundar.S-k@amd.com
Subject: Re: [net-next] amd-xgbe: add support rx alignment and length errors
Date: Wed, 28 Jan 2026 21:11:11 -0800
Message-ID: <20260129051111.376038-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128075843.696961-1-Raju.Rangoju@amd.com>
References: <20260128075843.696961-1-Raju.Rangoju@amd.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254565-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 2E656ABD82
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
amd-xgbe: add support rx alignment and length errors

This patch adds support for reading rx alignment errors from the hardware
MMC registers and updates the rtnl_link_stats64 structure.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index b5a60a048896..ebc5fe8324ea 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1838,6 +1838,8 @@ static void xgbe_get_stats64(struct net_device *netdev,
>  	s->rx_length_errors = pstats->rxlengtherror;
>  	s->rx_crc_errors = pstats->rxcrcerror;
>  	s->rx_over_errors = pstats->rxfifooverflow;
> +	s->rx_frame_errors = pstats->rxalignmenterror;
> +	s->rx_length_errors = pstats->rxlengtherror;

Is this line a duplicate? The assignment to s->rx_length_errors already
appears three lines above. Perhaps this was intended to be a different
assignment?
-- 
pw-bot: cr

