Return-Path: <netdev+bounces-286060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNyjAZ+I/mkBsgAAu9opvQ
	(envelope-from <netdev+bounces-286060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:06:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEAF4FD2CE
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F0A300F51B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773222CBE6;
	Sat,  9 May 2026 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkrXSGUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BC3B1B3;
	Sat,  9 May 2026 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288794; cv=none; b=SSxJ4f14yF83MSZBYgblRFl2CXkVhBEOK2EH1KYIdvQhyhgQFQpIY8ih6yHOElGPykaVvl6LGzrWeELHelA4KBZjkf95VH8KyPAQIOvbgn5g8fWlf734NvTrILBFbSegiajBqgYB+aV68Tcvq3jujmV/vCtAHUUN07Dhzenl3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288794; c=relaxed/simple;
	bh=BRJY3hCGhHkE9eZsaH0pZZGY3aJK+t/zzBy+6H675UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVmphUAxj3LMqywwElnHi2mkEmqZ8qRNChxkHEhAt7IN4n+Dsg8xmW25LiNi3ySt3f7gssbJUdGKO4ZyzenNpnFhkLwT3t05f069vJW4NyOWDEhFSiBVi/HagroMwvNmuj3WTV4sJT8aoPEH0ocB+C9Gqh3vqSkSHpEhEK0jpak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkrXSGUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49E2C2BCB0;
	Sat,  9 May 2026 01:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288794;
	bh=BRJY3hCGhHkE9eZsaH0pZZGY3aJK+t/zzBy+6H675UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkrXSGUUEPUgeNaPMsPmu3xuTOc6MHy/eJlF89nuWlzpS1ITG5IGJsQoK7J8FGSei
	 n1dbqvUa3Z4RWooASbLpf6B43K7vQxgm8NQcGKLOHXEku72j0wY62twelUgsKyvRQF
	 1y2DhOSZQm7By5m1xu4OdZKrih72206kOxZ//we/FRLygpQMnBLjzJycqUEAlI3j4B
	 FvEC8yCnhNKCFBB800Tkr5wwYRDhyzl40noNTXAFN8qiMosR3r02+rNK5A4lOnd6w+
	 4ut+elNDTQAgGZUwAQ3VhRFkz0woEumCxeTDvStBezPTKZ/69kSK6I6B7Omwp6CpZF
	 iM99ike6CdccQ==
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
Subject: Re: [PATCH net-next 1/2] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
Date: Fri,  8 May 2026 18:06:32 -0700
Message-ID: <20260509010632.3521323-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506190904.4029-2-mike.marciniszyn@gmail.com>
References: <20260506190904.4029-2-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5BEAF4FD2CE
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
	TAGGED_FROM(0.00)[bounces-286060-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: pcs: xpcs: Add hooks for xpcs configuration of rsfec

This commit adds hooks to configure the DW PCS vendor registers for RS-FEC
encoding when operating at speeds above 10Gbps. It introduces lane-specific
and vendor-specific configuration values for 25G, 50G, and 100G links.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
[ ... ]
> @@ -219,6 +219,12 @@ int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
>  	return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
>  }
>  
> +static int
> +xpcs_bus_write(struct dw_xpcs *xpcs, int prtad, int dev, u32 reg, u16 val)
> +{
> +	return mdiobus_c45_write(xpcs->mdiodev->bus, prtad, dev, reg, val);
> +}
> +
[ ... ]
> +static int
> +xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
> +{
> +	int ret = 0, i, pma_mmd;
> +
> +	pma_mmd = xpcs_get_pma_mmd(xpcs);
> +	if (pma_mmd < 1)
> +		return pma_mmd;
> +
> +	for (i = 0; ret >= 0 && i < v->lanes; i++) {
> +		ret = xpcs_bus_write(xpcs, i, pma_mmd, MDIO_PMA_RSFEC_CTRL,
> +				     v->rsfec_ctrl);

Could passing i as the port address directly overwrite unrelated PHYs on a 
shared MDIO bus?

Looking at how the write maps down to the bus:

xpcs_bus_write()
  mdiobus_c45_write(xpcs->mdiodev->bus, prtad, ...)

If the loop index i is passed directly as prtad, it starts at 0 and writes to
absolute physical port addresses 0, 1, etc., ignoring the device's actual base
MDIO address. Should this offset the lanes using the base address, like
xpcs->mdiodev->addr + i?

Additionally, is it safe to do an unconditional write to the standard
MDIO_PMA_RSFEC_CTRL register here? 

Using a direct write instead of a read-modify-write operation will wipe out
any other existing bits in this register. For instance, global RS-FEC enable
bits or bypass correction settings configured earlier by the networking stack,
bootloader, or phylink might be silently clobbered.
    
Would it be better to use a modify operation to safely update only the
specific vendor or lane-mode bits?

> +	}
> +	return ret;
> +}
-- 
pw-bot: cr

