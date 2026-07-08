Return-Path: <netdev+bounces-306014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DU2oMzvfTmqAVwIAu9opvQ
	(envelope-from <netdev+bounces-306014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:37:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6962F72B361
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:37:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fMRK5P8x;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306014-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306014-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A994303FBAD
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13B3998BE;
	Wed,  8 Jul 2026 23:34:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245253769F4
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 23:34:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553662; cv=none; b=cASXoFzGcehenUBeiL7hd80tmzwFBgtRGyyN8oWj233S3pgNIAOm++JwDUl06XJKdnUGbcs9GvtGp6VKEzqsf88XWOi7QxndvpSGewkIbR+L7DWraF7FjIhI8t5Uzen1+EIz3nBi/2/SbM23axHG/7J2oHEwKDF8RCH4BMk8Bw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553662; c=relaxed/simple;
	bh=SEEDZkOUfd25t3/q5fUjUFSgpg1480t5VP3MGXxMgiM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=i/DJON5SjZBQN/00SIlXbk3fm8ihP/5DYvjrYWMm1pBYFWlJMGEzGQqdqHbwNslciLUSXHCr+4kM7OxigZlBMOckPIHVb0Ax512NH0xUB/sgKk05nEt3ySrWexZys8v+T4X31oODGpx+E2JDpbh7qoYEH2rE06wQjrJ2XXx1+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMRK5P8x; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cac59f8b64so14777365ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 16:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783553660; x=1784158460; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBxe0wZEJGIu1kkVYecVy6uNbnIpdD9XRHlLQPSVa+E=;
        b=fMRK5P8xqWkcIGx2pUUwEt0dN666xAzxXzRvt28MykgHBHLG3XFqBDToVwbsZVXdop
         T6mre5X+5OBLuSfd/OaieU/1y76nbUyq18x8JnPfM0BCv2/kgS3iyBMZoHKyRav/VLSq
         mAZkrskCUeN4/coGB+nHkvlw6OyS96ySRF8ZBWyaHMmpwPKEzxz6QtCtj2r2ouEC4KVY
         vgqPhjUkYPOICLeWUZiIaglcNevuuQam7eI4VVHSsCCGQ1AQw6Pg6UJ+iVWDMbAm+PJz
         uJ0dBImc8uLxCql4ynOzTfhpn2WkxZCL/In0rhJoUdEIgIZh1Z6hsbXFhealBWzBQ4kq
         qKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783553660; x=1784158460;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBxe0wZEJGIu1kkVYecVy6uNbnIpdD9XRHlLQPSVa+E=;
        b=kpberIwe9wLWDSVoxOm2wTacw8E+IkrY6Cv6OJmY56YNENLmGb6HVn9U3HKi8noog6
         coSH6EIvLR7+kijHzqbibdagG7uD3iKRISPrnY+BGxLXJ06PZLdi7L3NHaXghErJXPUb
         8I7iGYlJmtGXg4lLih6YeYc6E6h4Sdcy0eDUzwCVxS5HwGDZ0+ap4GvL6g+m9ngw1hRM
         52V6pgyfXicLTvv7JZq6Bdpgnzek+ywrn6SfSX0ymhgakqkIH4voLvV7XjNgULUUuxJS
         l+eVxyPatoWsyCFevYQwh/Mye1ski6bZ0tP0VxqzTj183YoJOF2OUYWiBtpbuhjJWFK3
         UQRg==
X-Gm-Message-State: AOJu0YxsziOes6Vc1WeP8OQt6mwRHQc0PiOta2EnEdvQiTgfiqHE+7VX
	S5daFKAepmNvQIs6+EkfT7kcoPpPwfME5phY9Du6FXllL5xA0UnfjfoBCfxOdxyG9QQ=
X-Gm-Gg: AfdE7cnugJ3AREalHvRc+tsuTdvZZy7rK24LVlhRnF5HbbTALh7DCaoYQ9VXA4/3ASq
	lpwawtiGS/U4KRWa0XwLGZ0lM11+rZPuTrwSNgUF10EqYTqoUthIX5O+Wsh7r84wqBq2/bOM9UW
	3wvULK6heg7dUxf9SoE4e4GZBK+sxZ0G94tWdCOYUlUe8qvFLOSDpXvLIfuzAlj+G/KhxajZTMk
	iP26LkA56bgq2z5+tQboLAZ4z+zCjVdkDZLqwxL1RyL8QoufCyWZJ6zYrFDk2mx1Rmz/W1OW1gg
	ty3xrFgPxBy4v4EGHenj10IxM7KVfcnrWmg6KkaqoRAtrV19r4nZtSLkhAjjnHghNKsEIwNoQuC
	wbaJx8XstxZZP3bA1jh37KkUiofIjxKNMFoK6m8T4KjlnZu2i2WouOJXPS8YtaOl+ZyBTib/u1u
	5u/JxRIA==
X-Received: by 2002:a17:902:fc84:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2ccea2d7691mr53663815ad.4.1783553660562;
        Wed, 08 Jul 2026 16:34:20 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm33898515ad.53.2026.07.08.16.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:34:20 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: phy: mediatek: add calibration logic for AN7583
Date: Thu, 09 Jul 2026 00:31:00 +0800
Message-ID: <178355365385.113886.4040120167909619643@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260708102341.53919-6-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com> <20260708102341.53919-6-ansuelsmth@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306014-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6962F72B361

Hi Christian,

A few issues in an7583_phy_config_init():

1) Redundant double assignment of mdi_resister_type

    shared->mdi_resister_type = MDI_5R;

    shared->mdi_resister_type = MDI_5R;   /* duplicate */
    if (shared->mdi_resister_type == MDI_0R)
        shared->r50_cal_tbl = an7583_zcal_to_r50ohm_0R;
    if (shared->mdi_resister_type == MDI_5R)
        shared->r50_cal_tbl = an7583_zcal_to_r50ohm_5R;

The first assignment is immediately overwritten by the second
identical one. Also the two `if` blocks should be `else if` --
currently both conditions are checked independently and the
MDI_0R branch is dead code (since the value is hardcoded to
MDI_5R).

If the intent is to default to MDI_5R and later read from SoC,
the structure should be:

    shared->mdi_resister_type = MDI_5R;  /* FIXME: read from SCU */
    if (shared->mdi_resister_type == MDI_0R)
        shared->r50_cal_tbl = an7583_zcal_to_r50ohm_0R;
    else
        shared->r50_cal_tbl = an7583_zcal_to_r50ohm_5R;

2) Typo: mdi_resister_type -> mdi_resistor_type (same as patch 4/5)

Also the FIXME comment says "MDI Resister Type" -- should be
"Resistor Type".

3) Dependency on patch 4/5 probe fix

an7583_phy_config_init() uses shared->phydev_p0 which is set in
an7581_phy_probe(). If the probe function from patch 4/5 is not
fixed (missing shared = phy_package_get_priv(phydev)), this will
deref NULL/garbage:

    phydev_p0 = shared->phydev_p0;
    phy_offset = phydev->mdio.addr - phydev_p0->mdio.addr;

This highlights that patch 4/5's probe fix is a blocker for both
AN7581 and AN7583.

Best,
Wayen


