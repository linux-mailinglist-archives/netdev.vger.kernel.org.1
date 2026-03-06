Return-Path: <netdev+bounces-264628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOEXJaQ/qmnGNwEAu9opvQ
	(envelope-from <netdev+bounces-264628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:44:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4121AAF2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FFE9303A255
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2A342C9E;
	Fri,  6 Mar 2026 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjaGfGKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF42C0F91
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765089; cv=none; b=mPqVQSI38kvsat6pvy3tJKQ0HwzmfH4x2ja9J8kqHM/aveRQqOX5mJWVKNQrnTdUT6FhLwSZVpIFvqErCUBQthwRoHFP6W2FwD9tSspt9sVMA6vaGwI7fmeo2WU7vHlbzHRjMtAMpmg4rZToHK35Xgel00+00ae+snNxcDQEQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765089; c=relaxed/simple;
	bh=Fc9ezonwCTxJPjUscOnEtyKgvULm+zhxG25nu9qt/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJC8FghhNK0DstZBqH6pc/WWP359I+QBBnBfScZM1P7/GNnAbJHfV0/0V7ru6D2cc+pDaL7Qzgf3+LnMuZH+SQWLlTrQaASuaFJJ8Q+3N7qfpLBKaQWdnHdkuc9vbE6TGH/v7XHe31PCpzN+PVyl8Y1F5nYKJo2v9PbuXbjzhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjaGfGKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35326C116C6;
	Fri,  6 Mar 2026 02:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772765088;
	bh=Fc9ezonwCTxJPjUscOnEtyKgvULm+zhxG25nu9qt/Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjaGfGKoSp1eYNz8QsfsQsAVJFwQpUievS57qMDhZvMgOoZ21W0xlC41PZga4LyUb
	 4j4+ZZCoyt+EyjLAG3qeQ4TvQvtJLf8xJlztWBiuPJoNL3XISZz1PRPLCpXIBIvEPD
	 KYTvA7kM13nb3Hv0oKHyzHQLWv/5ZHXXL68K3XmMUMzepnPgmZdFfkZMCEzwm2hYw8
	 WOk1N8r+ltcUYhiISeWo3eEQhxDGs4RLgFCIcU4p19KNldRxN7NmMpX6ryZKpR9xCC
	 Scg1GYyLcEea/KBUzvT8C4YASc1K85OeVU2KiGsYLTaRaRTrV+WIsrystxOVZPnMec
	 Q6GUhS2tSB7AA==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	dong100@mucse.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew@lunn.ch,
	guwen@linux.alibaba.com,
	vadim.fedorenko@linux.dev,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	dust.li@linux.alibaba.com
Subject: Re: [net-next,v28,3/8] eea: probe the netdevice and create adminq
Date: Thu,  5 Mar 2026 18:44:46 -0800
Message-ID: <20260306024447.566091-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302024604.25354-4-xuanzhuo@linux.alibaba.com>
References: <20260302024604.25354-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7A4121AAF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,mucse.com,vger.kernel.org,davemloft.net,lunn.ch,linux.alibaba.com,linux.dev,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-264628-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: probe the netdevice and create adminq

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
This commit creates and registers the netdevice after PCI probe, and
initializes the admin queue to send commands to the device.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> new file mode 100644
> index 000000000000..31cb9ca5b408
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> @@ -0,0 +1,202 @@

[ ... ]

> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{

[ ... ]

> +	netif_carrier_on(netdev);
> +
> +err_free:
> +	kfree(cfg);
> +	return err;
> +}

[ ... ]

> +int eea_net_probe(struct eea_device *edev)
> +{
> +	struct eea_net *enet;
> +	int err = -ENOMEM;
> +
> +	enet = eea_netdev_alloc(edev, edev->rx_num);
> +	if (!enet)
> +		return -ENOMEM;
> +
> +	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +	if (err)
> +		goto err_free_netdev;
> +
> +	err = eea_adminq_config_host_info(enet);
> +	if (err)
> +		goto err_reset_dev;
> +
> +	err = eea_netdev_init_features(enet->netdev, enet, edev);
> +	if (err)
> +		goto err_reset_dev;
> +
> +	err = register_netdev(enet->netdev);
> +	if (err)
> +		goto err_reset_dev;
> +
> +	netif_carrier_off(enet->netdev);

Looking at the initialization sequence, eea_netdev_init_features() calls
netif_carrier_on() before the device is registered, then eea_net_probe()
calls netif_carrier_off() immediately after register_netdev().

This creates a brief window after registration where userspace can observe
the carrier as UP before it's set to OFF. Is the netif_carrier_on() call
in eea_netdev_init_features() necessary? The standard driver pattern is to
call netif_carrier_off() before or immediately after register_netdev(), not
to set carrier on first and then override it.
-- 
pw-bot: cr

