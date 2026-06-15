Return-Path: <netdev+bounces-299670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QG+RKXyRMGouUgUAu9opvQ
	(envelope-from <netdev+bounces-299670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:57:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50468ABA8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:57:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gvzUN6Uk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299670-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D303044F13
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249736DA10;
	Mon, 15 Jun 2026 23:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D736D9E0;
	Mon, 15 Jun 2026 23:56:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567819; cv=none; b=JEHcF4L2DHlVtz8L+F4Mqo2SVthqFuB3l5zfBvlWSqSDpCSxRsFGXcbDYWrkpydM5nbNzi6JirFIK77H15RJQ2sYZLNvAFZfl6ALKTXeMSXR8fp0N0JEN5LugLgRFN3ZHlTqlKAroU5kAYu4f8TSgfivuqHuAEIvPgQD98zo47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567819; c=relaxed/simple;
	bh=0AsEAFA5lJjz7FdeiEMVNVvbXdyDUj8zi8KTe/UV9hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYF2wa5U7zJWD2BWO08kts1lfF4ik95cNCpLvc47ff662pF3Yuf07V6HIPaXDTqWhM4HQ6cbXIxJskTvq+ft/14Xd4qSH3+g1P4iFQWv45JBchjehhCs80JmCCNpz+UmGgYbrW5GZR/+CHFkyYGQNNZm9iottmVzUmJsYAsO59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvzUN6Uk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194FF1F000E9;
	Mon, 15 Jun 2026 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567817;
	bh=VQgiXnjJ6fSj+/sElJMxxr5OpH6R2crt7tDdnsh7rI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvzUN6UkkcOJaUBdPDm3nKWxTFho1m+/20zbBjR8odVbv83K582lvyFUALDDb7dU5
	 XFfEFL4+H5S9MxiBjIEXJv+ko6ZhNS1TPhYpTUqD7nhumLCoNpx/bRPX27GnvAiu5u
	 pFcB2ENBnL5kDYQd3AtUHIwC37JJADPl/8pJSwDhPKz3FBYR53j+sDzB1CHna+rK1Y
	 anlZp4/IvaHysWSmtGyWdxJGzsStMO5SX0AfwVZeLkFpC1GpPg3mTIW36J+DvCbXbG
	 g8beq7HTCjMBsc9kkeu2E6KgBe1qgNvgzlHPsBohG/IeB7LST883G1wX5jKKKZNYq0
	 8A7kw7kjejPgA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	chester.a.unal@arinc9.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/8] net: dsa: mt7530: convert to use field accessor macros
Date: Mon, 15 Jun 2026 16:56:52 -0700
Message-ID: <20260615235652.1060768-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <62e0a7e96bcadba0ec1a0f090c2fd2990c6ae0f1.1781312667.git.daniel@makrotopia.org>
References: <62e0a7e96bcadba0ec1a0f090c2fd2990c6ae0f1.1781312667.git.daniel@makrotopia.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:kuba@kernel.org,m:chester.a.unal@arinc9.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A50468ABA8

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: mt7530: convert to use field accessor macros

This patch converts the mt7530 DSA driver to use FIELD_GET and FIELD_PREP
instead of open-coded shift/mask constructs, and replaces a 0x1f literal
in the PHY address helper with (PHY_MAX_ADDR - 1).

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 4168adca949f..dcf72ab0cd66 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -1555,7 +1555,7 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
>  	u32 val;
>  	int ret;
>  
> -	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
> +	val = VTCR_BUSY | VTCR_FUNC(cmd) | VTCR_VID(vid);

[Low]
The commit message describes this change as a refactor:
"Use FIELD_GET and FIELD_PREP instead of open-coding register fields."

The mt7530_vlan_cmd() hunk is not quite a pure conversion though.  The
previous code OR'd in vid directly:

    val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;

while the new code applies a GENMASK(11, 0) truncation through VTCR_VID():

    val = VTCR_BUSY | VTCR_FUNC(cmd) | VTCR_VID(vid);

Spec-conformant VIDs always fit in 12 bits, so the runtime result is the
same, but the value is now masked where it previously was not.

A related observation is that the prior VTCR_VID and ATC_HASH macros
referenced an undeclared x:

    #define  ATC_HASH                       (((x) & 0xfff) << 16)
    #define  VTCR_VID                       ((x) & 0xfff)

so they could not have been used by any caller before this patch.  Adding
the (x) parameter and a GENMASK is effectively a fix for those macros.

Would it be worth calling out the VTCR_VID() truncation and the macro
parameter fix in the commit message, or splitting them into a separate
patch so the conversion remains a no-op refactor?

> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h

[ ... ]

> @@ -171,32 +176,29 @@ enum mt7530_fdb_cmd {
>  
>  /* Registers for table search read address */
>  #define MT7530_TSRA1			0x84

[ ... ]

>  #define MT7530_ATRD			0x8C
> -#define	 AGE_TIMER			24
> -#define  AGE_TIMER_MASK			0xff
> -#define  PORT_MAP			4
> -#define  PORT_MAP_MASK			0xff
> -#define  ENT_STATUS			2
> -#define  ENT_STATUS_MASK		0x3
> +#define  AGE_TIMER_RD_MASK		GENMASK(31, 24)
> +#define  PORT_MAP_MASK			GENMASK(11, 4)
> +#define  ENT_STATUS_MASK		GENMASK(3, 2)

[Low]
The mask formerly named AGE_TIMER_MASK is renamed to AGE_TIMER_RD_MASK,
but the same mask is consumed on both the read and write paths
(mt7530_fdb_read() and mt7530_fdb_write()), so the _RD_ infix reads as
"read-side only".

Its sibling fields in the same MT7530_ATRD register keep plain names
(PORT_MAP_MASK, ENT_STATUS_MASK), and the related ageing counters in
MT7530_AAC use AGE_CNT_MASK / AGE_UNIT_MASK rather than an _RD_
disambiguation.

Was the _RD_ infix intentional, and if so, what does it disambiguate
from?

[ ... ]

> @@ -731,38 +745,48 @@ enum mt7531_xtal_fsel {
>  #define  MT7531_PHY_PLL_OFF		BIT(5)
>  #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
>  
> -#define MT753X_CTRL_PHY_ADDR(addr)	((addr + 1) & 0x1f)
> +#define MT753X_CTRL_PHY_ADDR(addr)	(((addr) + 1) & (PHY_MAX_ADDR - 1))

[Low]
The replacement evaluates to the same value today, since PHY_MAX_ADDR is
32 in include/linux/phy.h and PHY_MAX_ADDR - 1 is 0x1f, and both forms
ultimately derive from the IEEE 802.3 5-bit MDIO PHY-address field.

The original 0x1f represented the width of the hardware register field,
while PHY_MAX_ADDR - 1 represents the maximum software PHY address minus
one and additionally relies on PHY_MAX_ADDR being a power of two, which
phy.h does not formally guarantee.

Given the rest of the patch introduces explicit GENMASK based field
masks, would something like:

    #define MT753X_CTRL_PHY_ADDR_MASK GENMASK(4, 0)
    #define MT753X_CTRL_PHY_ADDR(addr) FIELD_PREP(MT753X_CTRL_PHY_ADDR_MASK, (addr) + 1)

be more consistent and make the hardware-field intent clearer?

