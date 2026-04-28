Return-Path: <netdev+bounces-281892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUUL6TP8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EB487AB9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50650301DA58
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CE3FB7CD;
	Tue, 28 Apr 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSOCxBK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1823E330;
	Tue, 28 Apr 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383944; cv=none; b=ldBDHu23VsZR0nh1yzCkW0r5DBHZ28hBUZ9Q2gSa/zSDnl6mHx1yHAwvMoEMNfl3fe2pPvB1X+9QQm7w7iCrOXpx466Uwlm/LT/tD+2h3+J/bwaF+dUu+Q3MQJdjuiCXY2Ol1pRmHVueiPkYjkWUwwsv6Cjs9iCL9uYiJKLyg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383944; c=relaxed/simple;
	bh=7Z4DUSAzjKnQFC3db5+406Wsh0eK5Lv3sUWFjsYoz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfMwcuNlFpb/cTXAgEVsBGe82ELzMb3W5EEVlVTgP2ddlqAs3n5i8/Jln80JaOXCbhwhsmnEJKoDUhpeQezzjE7n69AjwKYfLfOYyijK6njL6pYOndyZL2tlQraWaV+1JSqwL9AD/zE3WEuIO5hvPOIOLLYdRbWgYQLX07RfKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSOCxBK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EB2C2BCB5;
	Tue, 28 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383943;
	bh=7Z4DUSAzjKnQFC3db5+406Wsh0eK5Lv3sUWFjsYoz1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSOCxBK6cr2zcP/vLNtGnBMTgoTuisz6HduX2VurT8AIfh9Ikahnvx1MBwXmp/UXA
	 QYfAjzJeht9O+fAkr46QhQAYREmeWN3snFvnurInmjegLEHUXOjfMTQvqELpmzXufz
	 ZHPGkR4kRisFJDX90fS9aHlCsC5Evmn7VG+etLfmyZuGj0T7+18ARnYv5EBZ7Iy743
	 rU2kLIuR+FNJh301gvCPhEPqd+jVymI70StxZtHxcg7TuDF0DWyrg9O8CY09WSV85q
	 Bi27TXpok+xASJMYs0B+h1N2BJfebJVavhDWTODo5x4h6G6teG2DZR0OUf7QkQj24E
	 p6qtjwEHX+0hQ==
From: Simon Horman <horms@kernel.org>
To: mhun512@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ae878000@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan966x: avoid unregistering netdev on register failure
Date: Tue, 28 Apr 2026 14:45:16 +0100
Message-ID: <20260428134516.1323541-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426142806.36028-1-mhun512@gmail.com>
References: <20260426142806.36028-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB1EB487AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: lan966x: avoid unregistering netdev on register failure

lan966x_probe_port() stores the newly allocated net_device in the
port before calling register_netdev(). If register_netdev() fails,
the probe error path calls lan966x_cleanup_ports(), which sees
port->dev and calls unregister_netdev() for a device that was never
registered.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 47752d3fde0b..22c496f5882a 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -873,6 +873,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
>  	err = register_netdev(dev);
>  	if (err) {
>  		dev_err(lan966x->dev, "register_netdev failed\n");
> +		phylink_destroy(phylink);
> +		port->phylink = NULL;
> +		port->dev = NULL;

By setting port->dev = NULL on registration failure, does this patch
inadvertently cause a null pointer dereference regression during error
handling?

If lan966x_probe_port() fails at register_netdev(), it now sets
port->dev = NULL and returns an error, leading to lan966x_cleanup_ports():

lan966x_main.c:lan966x_cleanup_ports() {
...
		if (port->dev)
			unregister_netdev(port->dev);

		lan966x_xdp_port_deinit(port);
		if (lan966x->fdma && lan966x->fdma_ndev == port->dev)
			lan966x_fdma_netdev_deinit(lan966x, port->dev);
...
}

If fdma is enabled but lan966x->fdma_ndev was never initialized (which is
true if the first port fails, as lan966x_fdma_netdev_init() is called after
lan966x_probe_port()), both lan966x->fdma_ndev and port->dev will be NULL.

This makes the condition NULL == NULL evaluate to true, unconditionally
passing port->dev (NULL) to lan966x_fdma_netdev_deinit():

lan966x_fdma.c:lan966x_fdma_netdev_deinit() {
	if (lan966x->fdma_ndev == dev) {
		netif_napi_del(&lan966x->napi);
		lan966x->fdma_ndev = NULL;
	}
}

The check lan966x->fdma_ndev == dev again passes (NULL == NULL). It will then
call netif_napi_del(&lan966x->napi).

Because the fdma napi was never initialized via netif_napi_add(), its fields
are zeroed. When netif_napi_del() is called on this uninitialized napi struct,
it will attempt to lock the device:

include/linux/netdevice.h:__netif_napi_del() {
	netdev_lock(napi->dev);
	__netif_napi_del_locked(napi);
	netdev_unlock(napi->dev);
}

Since napi->dev is NULL, netdev_lock() will dereference a null pointer.

A similar regression will occur if a subsequent port fails after the first
port was successfully cleaned up, as lan966x->fdma_ndev is reset to NULL
during the first port's cleanup.

>  		return err;
>  	}
-- 
pw-bot: changes-requested

