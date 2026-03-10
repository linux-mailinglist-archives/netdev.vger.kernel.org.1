Return-Path: <netdev+bounces-265869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHVhFxWIr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:55:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7622447E5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A61305E319
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458273B3BFE;
	Tue, 10 Mar 2026 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnGUTqsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A93A6411;
	Tue, 10 Mar 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111092; cv=none; b=BCYAzzioW6NxFFh2+9jZxsgO/5Za4QLIWpSQlMvfbjIiBrcOYzU//Lh00epGRxYcnoqF5xUMLMMT6fmXrHbkBLmych4a8dNUoILquBNkFwR/az9jUbs0FrT1027vSb7MA/VizHghe7IX1axtVQ+DfX3iUAQb9U9aSJ679ANKx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111092; c=relaxed/simple;
	bh=QE8oSiIig2ZBt5EyS5zX1hfXhBg0DDje2u0pf2P1jq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyGCwo0M9+1MOEKOQglK6LHyS0HHZuoEiPB7LsdmnAklbYWxpiDbfKjIEzOUTaWIpSJaNQcV6A/5TJYKAhI3BE0QzhmTezXKW3FC7r+gCatCSojS86OyYShM2Mk7QTsNfzhm3Ts7ivQMElO3eDBjDETzn/4JugtGPB70wnXckrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnGUTqsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A947C4CEF7;
	Tue, 10 Mar 2026 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111091;
	bh=QE8oSiIig2ZBt5EyS5zX1hfXhBg0DDje2u0pf2P1jq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnGUTqsQQnSMButRD3adlkw0yCDl+ZoBL3Nj6a10VsC5q9dt1CDmvFjIpNi74bmWu
	 +YPt8tkBDZqMGIuoM58l58MZLVDLWX8C8MCBhrPZM+iDLXegZiYvZ6AOxV321vDK9R
	 U4P7w0bDAQ8Y3eadEkG9g1MiGc8BwEvUcFBffc5JhZ/rXrtar1xSJWIdAUmMo3NRnQ
	 djMxMR7bJm/1kHEgG4VXFcL6UVH8XRAYj+mZlg87THcWrbGh91N/iLFUUMVt1hCNep
	 2Un2K33S0mW5DC7Kp6wZXPm6zGWANdlCDibRs0timM/kaWtBNKF7BvDRxvSPSfjt8s
	 PqdqfkxtBPmGw==
From: Jakub Kicinski <kuba@kernel.org>
To: rosenp@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Raju.Rangoju@amd.com,
	linux-kernel@vger.kernel.org (open list),
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [PATCHv2,net-next] net: xgbe: use device_get_mac_addr
Date: Mon,  9 Mar 2026 19:51:27 -0700
Message-ID: <20260310025127.3751023-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307032227.640904-1-rosenp@gmail.com>
References: <20260307032227.640904-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE7622447E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: xgbe: use device_get_mac_addr

This commit refactors the MAC address retrieval code to use
device_get_mac_address() instead of device_property_read_u8_array() with
an explicit is_valid_ether_addr() check. It also removes the
XGBE_MAC_ADDR_PROPERTY definition since the new function supports multiple
MAC address properties.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
> index 47d53e59ccf6..f2db920fbaec 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
> @@ -252,11 +252,9 @@ static int xgbe_platform_probe(struct platform_device *pdev)
>  		dev_dbg(dev, "sir1_regs  = %p\n", pdata->sir1_regs);
>
>  	/* Retrieve the MAC address */
> -	ret = device_property_read_u8_array(dev, XGBE_MAC_ADDR_PROPERTY,
> -					    pdata->mac_addr,
> -					    sizeof(pdata->mac_addr));
> -	if (ret || !is_valid_ether_addr(pdata->mac_addr)) {
> -		dev_err(dev, "invalid %s property\n", XGBE_MAC_ADDR_PROPERTY);
> +	ret = device_get_mac_address(dev, pdata->mac_addr);
> +	if (ret) {
> +		dev_err(dev, "invalid MAC address property\n");
>  		if (!ret)
                     ^^^^^^^^

Is this check reachable? When execution enters the 'if (ret)' block above,
ret is guaranteed to be non-zero, so the nested 'if (!ret)' condition can
never be true.

The old code needed 'if (!ret) ret = -EINVAL;' because
device_property_read_u8_array() could return 0 with an invalid MAC address
(checked by the !is_valid_ether_addr() part of the condition).

The new device_get_mac_address() already returns an error when the MAC
address is invalid, so this conversion is no longer needed and the
condition can never execute.

>  			ret = -EINVAL;
>  		goto err_io;

[ ... ]
-- 
pw-bot: cr

