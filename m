Return-Path: <netdev+bounces-297775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fJQ1B1CSKWpaZwMAu9opvQ
	(envelope-from <netdev+bounces-297775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600266B873
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EMnPLIma;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297775-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BCAF31DB6A8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A31337BA4;
	Wed, 10 Jun 2026 16:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84232BF41;
	Wed, 10 Jun 2026 16:26:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108785; cv=none; b=jQYp71XDqFcy+1Zl0qMPFIalUdsyqWvMber2HHQFGCT9mYfC70sCZS5Si89YDTcNPaOy8lAZD86WJCjX/pRsxEmf3nah7dNUtVXBASLg3FEXErwKU+OokoYf9k6DEWEY9XynHsdwoVLJEIsV4+YPrU2vesoIS6Q0SNr853P3IBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108785; c=relaxed/simple;
	bh=ZcepPjZzXmPo5llndBRdnOlkJo8/84/+3Et7YrRWxaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8pkqo4Rv3chHb5zD3YxkANUP5c1UnFu89VDtnNXgoG7pw9pOfoTXeOjibfA7H9RYI3zK6PDeBONB1hSnpRiEMBGAwc6rQ1XzKhZF+F53XyAkidsg4uLyhPxWZ24W4DLiXKFfJxyVaaGFbbo2emR8xawbKbcJHh6PAf9SoaZJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMnPLIma; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804551F00893;
	Wed, 10 Jun 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108784;
	bh=JZsSs6WI9LT8JgnoKs4MmZfKVy7zjjQ2j3cFXReen8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMnPLImalv7o3a3YIxCRbqp9hcrmjljDm2lYTFeaJyOnxR2QcD/Nfde3/cr1gPT48
	 GcRULDcQkeiPCa/zVa4aSJ+CNZbzBhpof6jailfqmovAM9P2nv7cks72WMhPEmm8Hc
	 +YQqG4VO29QOW0OQlscVtr5PFWjVR7DWzutfXYn9HBMQUpLMuZoMVfrfQ6ncglBvVW
	 yBp6Sn8et0zIb7bdK9aQ1dUQFNqONHSA0zzC3zQdorvfFR+VuemPY8jfbq9oMlBzaP
	 tFlErGVgAyY4/+rV4UG198qFWyueLWbpUQnRm81pRfA5tU8BNK+DPPqPlpAltEr9tj
	 of0OIraPAf22A==
From: Simon Horman <horms@kernel.org>
To: thangaraj.s@microchip.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: lan743x: add support for RMII interface
Date: Wed, 10 Jun 2026 17:26:04 +0100
Message-ID: <20260610162603.470355-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608100435.11214-3-thangaraj.s@microchip.com>
References: <20260608100435.11214-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297775-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thangaraj.s@microchip.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8600266B873

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: lan743x: add support for RMII interface

This commit adds RMII interface support to the lan743x driver, wiring
up phy_interface selection, phylink supported_interfaces and MAC
capabilities, and enabling the RMII front-end via a new RMII_CTL
register write in lan743x_hardware_init().

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 0798f3f1f435..ad3f833c8d86 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

[ ... ]

> @@ -3562,6 +3574,11 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>  			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
>  		}
>  		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
> +		if (adapter->is_rmii_en) {
> +			rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
> +			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
> +			lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
> +		}

[Medium]
Should the RMII_CTL programming mirror the symmetric pattern used for
SGMII_CTL just above it?

The SGMII block sets or clears the enable/power-down bits in both
directions:

	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
	if (adapter->is_sgmii_en) {
		sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
		sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
	} else {
		sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
		sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
	}
	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);

The new RMII block only sets RMII_CTL_RMII_ENABLE_ when is_rmii_en is
true and never clears it on the other paths.

If RMII_CTL_RMII_ENABLE_ is left set by a previous agent (for example,
a prior driver instance with a different strap, board firmware, or
state preserved across a warm reset where the driver itself sets
HW_CFG_RST_PROTECT_ during PM suspend, and pci11x1x_strap_get_status()
already accounts for cfg_load/HW_CFG_RST_PROTECT_), can the RMII
front-end remain enabled while the driver is configured for RGMII or
SGMII?

Would adding an explicit clear in the !is_rmii_en path, mirroring the
SGMII handling, give the register a known state on every probe?

