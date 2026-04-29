Return-Path: <netdev+bounces-282166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BvYBf5a8Wn/gAEAu9opvQ
	(envelope-from <netdev+bounces-282166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9063848DE53
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D3830075E6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA821FF30;
	Wed, 29 Apr 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX8uG/m9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E861CEAC2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425146; cv=none; b=GX8HWRbSuZU8HBBK9nW3Q20QaQ6KB4ixtWZDWbmGOFcn+ynNJhzNmv8ukuAk48GSSf67geEwXcQeO1ypohKdlJ12iZ7oCjMPyUm6+h+ia1mX8gS4SXqx2Fry1PNsIkofvFh9PdeZUTHw48fsVKezUt2bdcP1W1HILQMfnak7FNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425146; c=relaxed/simple;
	bh=OFJo4z3bnGZpqSa8wpBlPZPbEkdYD11GRj+TXA2K9tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSw4dMAv333ZjVTV2D/pFXk/Oza520t1sCmmZo79vI85MaYOM/V7iKQtLyVJ7SyPpu8tsWqzzRSvBSXEtnkwdqQ2KnIcnopaLQsK7fE20Gd4tHziMnJVdamkwRKPKbdhDCRDpIvC4rF3sVHbDNIhSu80MVvvePxqSE8YWGqzhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX8uG/m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE43C2BCB7;
	Wed, 29 Apr 2026 01:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777425146;
	bh=OFJo4z3bnGZpqSa8wpBlPZPbEkdYD11GRj+TXA2K9tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX8uG/m93nC8Yu5RPKLUYjmoIbtFD0jpVDWMzcaKnv+4i8uV7RDXgLhBqPS11vSw2
	 B2OE9IQBwG/qVe8dSX3Mk2Seu9A6uUwQdYwJgaCUlhnnVxq8sES9CgkzQKhd3Y8CKy
	 kLUtT3ZrAO8+YWnKdI0pSo1EYYb8PcuSP8y59meH+DVg6Y6sP6ryMq/vih9+mCpnSO
	 sSqiO6luWfODrJG6EkZRhsZ8NhpK6ssEMxEByJbELOIevDY1cKNIBCk1bbAudTbosV
	 WYjd8lRKdLo10dyLg6MBJ+cbTtycDQ0nkByrevRfSHMW7ypKji5G6tfNusGO27x8l3
	 vzvAh4A34MGMg==
From: Jakub Kicinski <kuba@kernel.org>
To: mika.westerberg@linux.intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: thunderbolt: Call tbnet_stop() upon shutdown
Date: Tue, 28 Apr 2026 18:12:24 -0700
Message-ID: <20260429011224.1505785-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9063848DE53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282166-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: thunderbolt: Call tbnet_stop() upon shutdown
    
This commit updates the shutdown callback for the Thunderbolt network service
driver to call tbnet_stop() if the interface is running. This ensures the
service drivers release the rings upon shutdown.

> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 7aae5d915a1e..631af237998d 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -1417,7 +1417,10 @@ static void tbnet_remove(struct tb_service *svc)
>  
>  static void tbnet_shutdown(struct tb_service *svc)
>  {
> -	tbnet_tear_down(tb_service_get_drvdata(svc), true);
> +	struct tbnet *net = tb_service_get_drvdata(svc);
> +
> +	if (netif_running(net->dev))
> +		tbnet_stop(net->dev);

Does calling tbnet_stop() directly bypass the network stack teardown sequence?

tbnet_stop() appears to be the driver's ndo_stop callback. By bypassing
dev_close(), netif_tx_disable() is not called and the device's transmit queues
remain active.

tbnet_stop() destroys the DMA rings and explicitly sets net->tx_ring.ring
to NULL:

drivers/net/thunderbolt/main.c:tbnet_stop() {
    ...
    tb_ring_free(net->tx_ring.ring);
    net->tx_ring.ring = NULL;
    ...
}

If a concurrent transmission occurs, will tbnet_start_xmit() access the null
pointer and cause a crash?

Additionally, since this does not hold the rtnl_lock(), could this race
with concurrent administrative state changes (like 'ip link set dev down')
and lead to a double-execution of tbnet_stop()?

>  }
>  
>  static int tbnet_suspend(struct device *dev)
-- 
pw-bot: cr

