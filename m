Return-Path: <netdev+bounces-288141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN0vGJd2BmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-288141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:27:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FE54866E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F033020128
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53236A030;
	Fri, 15 May 2026 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX0xqlxY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4636998B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808468; cv=none; b=uMHBfXqRUsnxZsN7QAsASroBDcRGlTFbuPdfEVr/L7JQ+dwKNRdhWtCFCtjLVyOQTM4Pyn/c/ZKVQXS/QcABtr87vKi548lJR3h5hNqTEvdtyhaU+YKadSli4I1WJZlNhUVpaupHuwRLgAs3UoURGKQWS+8O9n6OsVn9pUEw1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808468; c=relaxed/simple;
	bh=laAiDd+4bIuBswpD5YLWOIs2SKZzZdoLOUYi+ya4M94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVYAYq7KKn/wa8i1kGOJsAd06qYp7pgdPT25UE4avY2Whz5jOJ7AENQ62ykdfS/rK1zpBZIdAlZlQn1KnZUT9Dtms9UqVVq6nqvx5FwW4ZIh7wzLpv1694wXQtPlaPxSiHfizHyW57nlfq8lahXPXJ144LsfH2c8nmHOyt6pWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX0xqlxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D137C2BCC6;
	Fri, 15 May 2026 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808468;
	bh=laAiDd+4bIuBswpD5YLWOIs2SKZzZdoLOUYi+ya4M94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pX0xqlxYBHWcVYxMerVSLVqgLQik2cJodVp95nLN9lMmDMrXAtXh+A2HDVb1OM0da
	 6kFCMCsfOEqeUD10pDZeb0HBrHPXbaOaJgGVnR+8emZ14KeUNIxYggwueeyHnP43HN
	 Bg/dZshCqFkWRqnGhZrxjxFPcxygVYHEUqZYoRKiqdh+2EQxCVbc+DVnlr/w5pRI71
	 tflGzprJ725lcV+x937IPBRrtCZuDtztlgnjWwleztpReIYIl1maz6N9ILTGYhcJTI
	 cPcIERNcr4oSEUYTk2XBNNS3L2SiUxRY8TBsXRxdjhzp0E9CM/mLh5W7G0Kxhif4FW
	 bUWp3B7pB/a0A==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link stat from firmware
Date: Thu, 14 May 2026 18:27:47 -0700
Message-ID: <20260515012747.1292575-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512224421.25236-3-eric.joyner@amd.com>
References: <20260512224421.25236-3-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C53FE54866E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288141-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: Get "link_down_count" ext link stat from firmware

This patch replaces the driver-side link_down_count counter on
struct ionic_lif with a value read directly from the firmware's
DMA-updated struct ionic_port_status.link_down_count, exposed via
ethtool_link_ext_stats.link_down_events in ionic_get_link_ext_stats().

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 78a802eb159f..cc2b294910f6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -115,9 +115,16 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
>  				     struct ethtool_link_ext_stats *stats)
>  {
>  	struct ionic_lif *lif = netdev_priv(netdev);
> +	struct ionic *ionic = lif->ionic;
> +
> +	if (!ionic->idev.port_info) {
> +		netdev_err(netdev, "port_info not initialized\n");
> +		return;
> +	}

[Low]
Should this NULL check sit inside the is_physfn branch below? The
port_info pointer is only dereferenced on the PF path, so a VF calling
ethtool on link ext stats will now log a netdev_err even though the VF
path never reads port_info.

The message is also unrate-limited and reachable from userspace via
ethtool. port_info is freed and set to NULL in ionic_port_reset() and
reallocated in ionic_port_init() on FW reset / FLR / PCI error recovery
paths (ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c, and
ionic_restart_lif() in ionic_lif.c), so any ethtool query during that
transient window will emit a kernel log line where the previous code
silently did nothing.

>  
> -	if (lif->ionic->pdev->is_physfn)
> -		stats->link_down_events = lif->link_down_count;
> +	if (ionic->pdev->is_physfn)
> +		stats->link_down_events =
> +		    le16_to_cpu(ionic->idev.port_info->status.link_down_count);
>  }

[Medium]
The firmware-supplied link_down_count is a __le16 in struct
ionic_port_status (ionic_if.h), so the value saturates at 65,535. The
previous lif->link_down_count was an unsigned int (32-bit), and the
ethtool field stats->link_down_events is u64 and treated as monotonic
by userspace consumers (per the comment on struct
ethtool_link_ext_stats in include/linux/ethtool.h).

Without driver-side rollover detection that accumulates the carry into
a wider counter, after 65,536 link bounces the reported value will
appear to go backward to a small number. Should the driver detect a
firmware value smaller than the previously-read value and fold the
delta into a 32/64-bit running tally before assigning to
stats->link_down_events?

[Medium]
Does this change make link_down_events non-persistent across firmware
resets? port_info lives in DMA-coherent memory that
ionic_port_reset() frees and clears:

drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_reset() {
    ...
    dma_free_coherent(...);
    idev->port_info = NULL;
    ...
}

and ionic_port_init() reallocates a fresh zeroed page. These are
called from the FLR / PCI error recovery path
(ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c) and from
ionic_restart_lif() in ionic_lif.c, so FW-reset events that previously
left the driver-resident counter untouched will now zero this stat.

The commit message does not mention this behavioral change. Should the
driver snapshot the firmware value before each reset and accumulate it
across reset boundaries to keep the ethtool counter monotonic?

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 637e635bbf03..eb7e552bc12e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -179,7 +179,6 @@ static void ionic_link_status_check(struct ionic_lif *lif)
>  		}
>  	} else {
>  		if (netif_carrier_ok(netdev)) {
> -			lif->link_down_count++;
>  			netdev_info(netdev, "Link down\n");
>  			netif_carrier_off(netdev);
>  		}
-- 
pw-bot: cr

