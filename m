Return-Path: <netdev+bounces-282543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PY+MdiS8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911B49B58A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDD9301F335
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649839DBCD;
	Wed, 29 Apr 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kka1gDw5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382039D6ED
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504954; cv=none; b=tuiaGnWIeID4zgzAK4IV1/m1i1NB1d//G1TCNARi691QNS29vAIZdKK5Lz1Ly4lJsLGaxb5bOpvG6JU6GgqQuhgYeFlpuZwYZkkK00LiD/ioRpkmfw7e5tpzlbd2nY9N8Vrw63h3k6KACWEmdSh74GC4Yl/pLR+t4AgjQlgG9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504954; c=relaxed/simple;
	bh=XSu+XI/RprwQLolR5flfTjJ7lkxxVZmHd7394zjgYxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy+9Vmo2eWCwHH62tSlC2TBc8Oj93hH2q4NUma2iaznhga6oR8+JYk4WRBdM6khTGKY4/ZLi7OXrC6O8g0FyFi0yrbFEnToTfKx7W7/3U/t94URVzQHlo58pDD/nXXEcWadMGGCc2Tnii5x8eP8wt5iuNWhiqysoPv0XfkuS6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kka1gDw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B15C19425;
	Wed, 29 Apr 2026 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504954;
	bh=XSu+XI/RprwQLolR5flfTjJ7lkxxVZmHd7394zjgYxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kka1gDw5gF3qUBhdJlyszrbYIIFy/VSIBrN8Zcn2mPIKs8hLs6ll4STB8ShFpsUNL
	 9RfiaXHDOxMUbwbUp0GowkV2EnNV9nui2zmm0Q/+0mg1olHucgthDUPQxS+8IxfMy4
	 adiXMTf75OOPcASrBAfaBSPNPFU4UUMlhIWwZtcpZ6cr5dv+f+aQ6qvPW6KGV3sVnY
	 nnDrxPuyDva7QGuf0D/ybcG5cvCX81qCxp5gNbwLBSGHrguCPKKjjhfuo81Zr0jRmg
	 X4yuSJXuvD/De1mPb3TOmxXSjTUfI69/sdSMrltHSU/ntKkuXZvT6HwyNAd1UCFerl
	 XtFf/Gh/Latww==
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: broadcom: Save PHY counters during suspend
Date: Wed, 29 Apr 2026 16:22:31 -0700
Message-ID: <20260429232231.2193106-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428212424.1828999-1-justin.chen@broadcom.com>
References: <20260428212424.1828999-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3911B49B58A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282543-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: broadcom: Save PHY counters during suspend

The PHY counters can be lost if the PHY is reset during suspend. We
need to save the values into the shadow counters or the accounting
will be incorrect over multiple suspend and resume cycles.

> diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
> --- a/drivers/net/phy/bcm7xxx.c
> +++ b/drivers/net/phy/bcm7xxx.c
> @@ -733,6 +733,7 @@ static int bcm7xxx_config_init(struct phy_device *phydev)
>   */
>  static int bcm7xxx_suspend(struct phy_device *phydev)
>  {
> +	struct bcm7xxx_phy_priv *priv = phydev->priv;
>  	int ret;

[ ... ]

>  	unsigned int i;
>  
> +	mutex_lock(&phydev->lock);
> +	bcm_phy_update_stats_shadow(phydev, priv->stats);

Does this cause a NULL pointer dereference for 40nm PHYs?

The bcm7xxx_suspend() function is used as the suspend callback for PHY
models defined by the BCM7XXX_40NM_EPHY() macro (like BCM7346, BCM7362,
and BCM7425).

Unlike the 28nm and 16nm PHY macros which assign a probe callback to
allocate phydev->priv, the BCM7XXX_40NM_EPHY() macro does not appear to
define a probe callback. This would leave phydev->priv as NULL and cause a
crash when trying to access priv->stats here.

> +	mutex_unlock(&phydev->lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(bcm7xxx_suspend_cfg); i++) {
>  		ret = phy_write(phydev,
-- 
pw-bot: cr

