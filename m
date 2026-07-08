Return-Path: <netdev+bounces-306013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MsIAMTrfTmp/VwIAu9opvQ
	(envelope-from <netdev+bounces-306013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:37:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B548772B35E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KQJNoQxB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306013-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306013-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33C9302350F
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FB390229;
	Wed,  8 Jul 2026 23:34:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E3F39E191
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 23:34:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553662; cv=none; b=gslwUs5hglMRzxrHzq1HV0SsF4aiyOBXcrsvUEhi0eDWmJeQGbg04YFuorpqM4cunNVXEz2iXCQo9lCie/XcDpI4jxxHVrM6lBbyDkIIQfPBU+0TnhiGySPzE5ajUDCK65Rp3xJ99ecYoKoPx6YpW4S4vV6UQlcVtEF2vPD8MRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553662; c=relaxed/simple;
	bh=A0Dxdory9hMsY0U9BoiMisGXGz0kh03T5faevW7vQE4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=WZ5dKeSwL/zC12dpB33hg3h6NAZKk610Aer6/guEVK4SfEvRKaH3wiLVZzj+FArELhM3NaKN0KYAFpBtgvK22nwtzbrwfNSJteBbB6NoUJd/jSEJJLNYIPWCUwMQz3og/oBQMS/mW2D/HAhSNxPSYrgZy/5eTRKBHhxz7k9QZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQJNoQxB; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacd69a9c0so15960615ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783553650; x=1784158450; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkrEjWV2T4kZn9l/EN1RfmTfNtrV7m8I3DpucB/PUhw=;
        b=KQJNoQxBrxfXJXO6sJR+8MwqE/GJhF/vYt35S1hbX4okELC/saJ/WDT1wkDRgKmbQq
         Ed2Uf47R+IOXMg84QluT7lcOOFfiQhaqAVPnHo6Ssg1rbN7BJhxjnVWpzSF41Tk3wzBx
         hwSNbDBewU+jrXAl75ZviEwlIwb6VNEV3SXnRaCbnYZTINkdijEIqOK114syqBaR/+Zn
         8rkSdjWFzocfbymIbxk5hwDvF3lBmPSuzPZVlxotIruFMLgz3mPdqOoamKOO2HVayoSy
         olyEOLnIsqszXDH5AXBpD63JaKbaAVAfpJA2O9/d84JPNpeX99o+MbXLM7n5laMC1TYR
         g4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783553650; x=1784158450;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tkrEjWV2T4kZn9l/EN1RfmTfNtrV7m8I3DpucB/PUhw=;
        b=qAcInY9qwhvfGCfmSh9/zANbrgbVvlw35jPsLVCthqpj00j5TgiFME1APj54Q/S5PQ
         bJV6fjvFjQGLfUAvOpgf7bCiDSDBnTC30Zzb9a6WY1n9H9JmTTTsAqJ8mA8tN6mU8CNi
         IsLZPeEaPp8DUQqlUsiy+kBzSqcNYNeNeCqATf6/49uovF0+ng3dVPH5Bj2tOY+307vy
         p95ChN6pIjcXtFlknHH/VJ9IMlEHGnWTx1v45FPlxXLDbb8PTO72DXdnVQE47w9Pv2Si
         89DD2cR9k6AO8AyOpRmowdRRwFOZfNm+uy03aWjNHrWn0y9MA7YCGvkTFyTidipZTPp0
         vXsw==
X-Gm-Message-State: AOJu0YzDO5hMtS8ykDCv5B+PQ6MbzA6VvBY0nG2ANayRJyIUy0PVSsxd
	A9hlCvz5j74WJ5oieKgdBzrfYYsTAhJ4QxC8zXuzzBCWj+NFYFbdCYmgzBcWNGrEnZs=
X-Gm-Gg: AfdE7clZHA4WxSLHfWrFAxzIlBJAioimmEcePgFIUMyEWcKl3k4+egcyKIU7gHHLwDQ
	zSoMnDRzOm913+kMZKVS74Cr6efgwvTJ7jg7S3ix/k0Dx8Tureb+as9Cy69ebMGXyWhPQOLW0ab
	XoYkV+qhpSJ54E5QutJzti1fOPaR1iScfAMadImVmlJgKXZaUKEquDJbOmxqFCfzxpWP1TzSXCb
	aO9383WL4FVy4jyq4j7IpKGnxUw5vUIwY8Tsp/ppEaXArZttwHROMZzflHoiLlGknhf9DRccifW
	U2ks+AiecbAkZothmlJiS+HxyEIbJwlQKTyW/MkTywYeqkGMJRgNHIBbx+45aQKi/Os1GTITL+I
	y0gdgNM1kdkedtAJAlShNijQW9IrDylo9RTiAlUrCg8ZNN9DHoVFBMaVzRK+K93y1ZuruVwJ4kw
	CQCmUhWg==
X-Received: by 2002:a17:902:d58b:b0:2ca:cb8a:f26b with SMTP id d9443c01a7336-2ccea348afamr45697605ad.10.1783553650075;
        Wed, 08 Jul 2026 16:34:10 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm34840455ad.15.2026.07.08.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:34:09 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: phy: mediatek: add calibration logic for AN7581
Date: Thu, 09 Jul 2026 00:30:00 +0800
Message-ID: <178355364330.113879.7307879640095189809@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260708102341.53919-5-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com> <20260708102341.53919-5-ansuelsmth@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:linux-kernel@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org,armlinux.org.uk,davemloft.net,makrotopia.org,mediatek.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B548772B35E

Hi Christian,

Thanks for working on this. One critical bug found that will crash
on probe, plus a couple of minor issues.

1) Uninitialized shared pointer in an7581_phy_probe()

The local variable `shared` is declared but never assigned before
use:

    static int an7581_phy_probe(struct phy_device *phydev)
    {
        struct airoha_socphy_shared *shared;   /* not initialized */
        ...
        ret = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
                                    sizeof(struct airoha_socphy_shared));
        if (ret)
            return ret;

        ...
        if (phydev->mdio.addr == AIROHA_DEFAULT_PORT0_ADDR)
            shared->phydev_p0 = phydev;   /* writing to uninitialized pointer */

devm_phy_package_join() allocates the shared priv data internally
(accessible via phydev->shared->priv), but the local variable
`shared` itself is never populated. You need to call
phy_package_get_priv(phydev) after the join succeeds before
accessing any shared fields.

Fix:

    shared = phy_package_get_priv(phydev);

should be added right after devm_phy_package_join() succeeds.

Without this fix, the first PHY to probe (addr == 0x9) will crash,
and all subsequent PHYs' config_init will dereference an
uninitialized phydev_p0 in every calibration function.

2) Typo: mdi_resister_type -> mdi_resistor_type

The field name "resister" appears in multiple places (enum, struct
field, config_init, FIXME comments). It should be "resistor".
This will be baked into the ABI once merged so worth fixing now:

- enum airoha_mdi_resister_type -> airoha_mdi_resistor_type
- shared->mdi_resister_type -> shared->mdi_resistor_type
- FIXME comment: "MDI Resister Type" -> "MDI Resistor Type"

3) Observation: mdi_resister_type is always MDI_5R but tables have
   MDI_0R data

Currently the code hardcodes mdi_resister_type = MDI_5R, so the
MDI_0R entries in an7581_tx_amp_compensation_tbl[] are dead data.
The FIXME suggests this should be read from SCU registers
eventually. Consider adding the MDI_0R branch now (or at minimum
an else) so the code structure is ready when the SCU read is
implemented, and avoid shipping dead table data.

Best,
Wayen


