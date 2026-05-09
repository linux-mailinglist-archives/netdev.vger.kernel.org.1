Return-Path: <netdev+bounces-286061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDX3Er2I/mkBsgAAu9opvQ
	(envelope-from <netdev+bounces-286061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DE4FD2E3
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E78302C5CF
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C72673AA;
	Sat,  9 May 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKbQQmqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37D1925BC;
	Sat,  9 May 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288796; cv=none; b=cC71XbnuYIHMH7BJHQFA9OpXVXshN2yYvOBj7t4/K4Wq9zkilEBeD799bBxSBH399ttEf0iX00QdB46F0meQ0AKtXWFSYOtmUBEF7EcDmcpBpOAUVoOhB1JTn9i97tnjEdzMrvl4SZcMafkdVWajI00d/d9YSKmgcmn+KTOaAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288796; c=relaxed/simple;
	bh=uWxlfnE8t0eUIzgRkKj5GSFIq9fEHyKjTsPJc9epZ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAyKlCYDHxjlEuHEQY3HTM6qB45kVAGOVEWXzQD3o1g4ys9YZJs63PE9LZQH2GEwSpWUsCIeDSiyfgNE9KryyQ1hHLu+B3UXoldpQuwA7igtLS9iu6dZ9N9sJEwp2u/EwaCetgKAtgL9QZ/IxXh8YHUqxGYuwYSEx3qtLcOzRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKbQQmqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC8EC2BCB0;
	Sat,  9 May 2026 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288796;
	bh=uWxlfnE8t0eUIzgRkKj5GSFIq9fEHyKjTsPJc9epZ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKbQQmqn1XO95t1+jSTRjRkVPsYRnZOIIxLppRvDRtyqFKBV8sAQljXLmSaqLuDhp
	 rPSO5eC//wp4D+VEIEyaFlImugFWzB5syCe57ymtKeUKD7pijAnskeOljT6FrXBrNk
	 hGKt7g/iKxl8TlYA6HMftDCMumgXgOltTCIKF5nekF5P7cd8QfAFmxROXxiFPIYTVd
	 uR3vMFE/sBCorqoYMpXjDhI0BodlZwmvKgDTicySFFpVz4uno4J5d8ZMwbGhWr6AHE
	 PGCn4zeSFd1TNIyo0G88z8hWmyEjG3NDLvlmZcXuUho0x9AO9jkQ1pFxnZKj2vxCgx
	 9+w85iBycE2Pw==
From: Jakub Kicinski <kuba@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	kees@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: Add handling for 4 channel rsfec device
Date: Fri,  8 May 2026 18:06:34 -0700
Message-ID: <20260509010634.3521341-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506190904.4029-3-mike.marciniszyn@gmail.com>
References: <20260506190904.4029-3-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F6DE4FD2E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: pcs: xpcs: Add handling for 4 channel rsfec device

This commit introduces the configuration of vendor-specific registers for
alignment encoding, PCS Mode, and VL_INTVL over one or two instances. It
derives encoding tables from the IEEE 8023-2022 specification and handles
register conflicts for DW_PCS IP.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0987621632a70..c42eacafad91e 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
[ ... ]
> @@ -1429,21 +1429,94 @@ static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
[ ... ]
>  static int
>  xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
>  {
> -	int ret = 0, i, pma_mmd;
> +	int ret = 0, i, vl, pma_mmd;
>  
>  	pma_mmd = xpcs_get_pma_mmd(xpcs);
>  	if (pma_mmd < 1)
>  		return pma_mmd;
>  
>  	for (i = 0; ret >= 0 && i < v->lanes; i++) {
> +		/* code word markings */
> +		for (vl = 0; ret >= 0 && vl < 4; vl++)
> +			ret = xpcs_config_vl_markers(xpcs, vl, i,
> +						     !vl ? &v->vl0_markers[0] :
> +						     &v->vl123_markers[vl - 1]);
> +		if (ret < 0)
> +			break;
> +		/* vendor registers */
> +		ret = xpcs_write_pcs_prtad(xpcs, i, DW_VR_MII_PCS_VL_INTVL,
> +					   v->vl_intvl);

Does passing the loop index i directly as the prtad (MDIO port address) here
overwrite registers of unrelated PHY devices on the shared MDIO bus?

Looking at xpcs_write_pcs_prtad() and xpcs_bus_write(), the address is passed
directly to mdiobus_c45_write():

xpcs_bus_write(struct dw_xpcs *xpcs, int prtad, int dev, u32 reg, u16 val) {
    return mdiobus_c45_write(xpcs->mdiodev->bus, prtad, dev, reg, val);
}

Since i is just the lane index (0 to v->lanes - 1), it appears to disregard
the actual base address of the device.

Could this be offset by the base address (xpcs->mdiodev->addr) to ensure the
writes hit the correct XPCS block instead of unrelated PHYs that might happen
to reside at addresses 0-3 on the bus?

> +		if (ret < 0)
> +			break;
> +		ret = xpcs_write_pcs_prtad(xpcs, i, DW_VR_MII_PCS_PCS_MODE,
> +					   v->pcs_mode);
> +		if (ret < 0)
> +			break;
> +		/* rsfec register */
>  		ret = xpcs_bus_write(xpcs, i, pma_mmd, MDIO_PMA_RSFEC_CTRL,
>  				     v->rsfec_ctrl);
>  	}
>  	return ret;
>  }

