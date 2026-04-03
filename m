Return-Path: <netdev+bounces-274823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HnhAXgUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B838FE64
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F4B03068A15
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F700277037;
	Fri,  3 Apr 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysl8pbGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C619221F0C;
	Fri,  3 Apr 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178751; cv=none; b=IHv0Ghn+4qqfpoGFAqwmuVpflGjYhVLzMAqkfDC/KsGcAPSFVYEUZPRUA+TFpw8YRVXgZVTPqyG0/9Y4ywcKOmAr5ItkcSbOlhnEW8RMP0Sh3E+3PpOkoF+KFZQf5777HI1PGpWQoS9fCCI2rpcA9PVinO/Ui1Xk+n37BaXLWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178751; c=relaxed/simple;
	bh=WF2Jj7sBQE7zHSj1Hk6o9abcLIimmZM7K0/w+ZvzQ+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlu06qyIBKMsdX4xzD0wsi/2oXwc+lPqWJy9pa8D8z1lRDgIo7HzK6aOEtTVyzYKrxNL273A9tVrH5iiQn+s0rLURyCcWPSwnhsXUU2/IQR3F4BL7uZXiJLBvXmpj0OE3ThZvqfn2IDC4b5g0/+2DYoeGKjM6g7sB3OuF7lBbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysl8pbGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D219C2BCAF;
	Fri,  3 Apr 2026 01:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178750;
	bh=WF2Jj7sBQE7zHSj1Hk6o9abcLIimmZM7K0/w+ZvzQ+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ysl8pbGKFB352iWEa5Z7utJUlFB5z1m+IJ8S6sltC47g5/nZGaOITOE+7r+C22mvw
	 3MGOk9U8IWwoBSg6T/bxHv0i6Oz4Pq6FOnKg2M7lg0oewE8hdM7ghY0kv+Uh98sbUb
	 V5dhuAKMgFe3GeiJHQV1fUKBFjdGi87IKqHEgZUuHFDVCq1GQnDMcWSFQW6QttIPHp
	 CYQQFS8gd64744F97B8MOMW7e0Fa+AmdCj8gppoW7E3ZNNf5+RmjAPRYlR6KnvskDj
	 w+ZW+pA10h3C/P1jzAX7RJPLlgIiTmmZ9FXuvZCRH67bw5CJoXBfFaemHQC0qoW6UU
	 d4dTwyiS4PTgg==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/11] net: airoha: Do not stop GDM port if it is shared
Date: Thu,  2 Apr 2026 18:12:29 -0700
Message-ID: <20260403011229.1785808-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-10-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-10-ac427ae4beeb@kernel.org>
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-274823-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B13B838FE64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: airoha: Do not stop GDM port if it is shared

This patch introduces a port->users reference counter to prevent setting
the GDM port forward configuration to FE_PSE_PORT_DROP if another net_device
is still using the shared GDM port.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 0780fb8aacfb..3f9bce8c5370 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
[ ... ]
> @@ -1681,9 +1682,6 @@ static int airoha_dev_stop(struct net_device *netdev)
>  	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
>  		netdev_tx_reset_subqueue(netdev, i);
>  
> -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> -				    FE_PSE_PORT_DROP);
> -
>  	if (atomic_dec_and_test(&qdma->users)) {
>  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
>  				  GLOBAL_CFG_TX_DMA_EN_MASK |

While this patch aims to support shared GDM ports, does the remaining
unconditional call to airoha_set_vip_for_gdm_port(dev, false) at the start
of airoha_dev_stop() break other active devices sharing the port?

static int airoha_dev_stop(struct net_device *netdev)
{
        ...
        err = airoha_set_vip_for_gdm_port(dev, false);
        ...
}

This appears to clear the REG_FE_VIP_PORT_EN and REG_FE_IFC_PORT_EN hardware
bits for the physical port, which might instantly kill traffic for any other
active interface using the shared port.

Similarly, in airoha_dev_open() and airoha_dev_change_mtu(), the
REG_GDM_LEN_CFG (MTU) is overwritten unconditionally. If a device with a
smaller MTU is brought up, will it overwrite the shared port's MTU limit
and cause the hardware to silently drop larger packets for the other device?

[ ... ]
> @@ -1697,6 +1695,11 @@ static int airoha_dev_stop(struct net_device *netdev)
>  		}
>  	}
>  
> +	if (atomic_dec_and_test(&port->users))
> +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_DROP);
> +
>  	return 0;
>  }

Does moving this FE_PSE_PORT_DROP configuration to the end of airoha_dev_stop()
cause a race condition when stopping the device?

In airoha_dev_open(), the driver correctly enables the QDMA engine before
configuring the GDM port to forward packets. A safe teardown typically
mirrors this by first stopping the packet source (setting FE_PSE_PORT_DROP)
and then disabling the destination DMA engine.

By moving airoha_set_gdm_port_fwd_cfg() after the airoha_qdma_clear() block,
when both qdma->users and port->users reach zero, the QDMA engine and its
queues are shut down while the GDM port is still actively forwarding packets.

Could incoming packets be forwarded to a disabled DMA engine during this
window, risking hardware lockups or buffer leaks?

