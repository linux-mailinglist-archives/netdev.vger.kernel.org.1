Return-Path: <netdev+bounces-262258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBI6GN14o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894791C9A90
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC74E302268C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085830B52B;
	Sat, 28 Feb 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue83GOIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608B2C15B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320985; cv=none; b=dtScRx+3MVKkgFHZfPW7j8BuO3d4MCmbl9PuHWhBDZXCsO3SIaduSSjedI7I+F2Xwi/pQLHJrTX5D8q2pg5kl2xIJiAk+IrMhwRiIdrkFIwTNpoQItjz+ASxd68woUJqD/7Oo5MqY3RH1423P0HDsyQ7lJKHdLVVZz2sJXXrLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320985; c=relaxed/simple;
	bh=HtipnwZKLnUK0x1kI7ml/XGP7yxeVEVDo2xSQh6ZcAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgXIBjG3WpulaoBBSHmr0z4k6vqDpu/c9faeHrqFKPNOwMJQngY9/sZkU5qhQH2o7CRJLAoilOILU9uLogaykfz4jhuxypocNDRtLhL0ASfIA95HnJI+Ht4LIdJ1h0laAP6UHtD0PaXDKbtsDjV7JkCEMgYrJH+RFw/ETeOWAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue83GOIn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso39246755e9.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320982; x=1772925782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84eJNEp6vvN1olc1qLpAO0h3fBelQAr4Y3eg29KdRtM=;
        b=Ue83GOInNsrX8gtQxbPtc2Mlpa2RMRBsfwO9P2YEg/HU0FjyRIka+dKfL5x2dvvikb
         te2fsfV8eZIYhzUT0DH0gZl4OLI4HaZpMQjwTck8/bkNMUR3TW1bx1O9lqmv6bGRkzaf
         7Vv/qp7sRkJco6BqYAmrYNqOmSr+RD0Qw5I0+Wn3ND5vKb108RmUQyDVCSfJHvDoyu2u
         VaquBR6p29Ph9E9WdKzL/AosES3uBFL0tYiUujGrqI294XmcKKKQi/XQYfP9NpO6dcvR
         JK91YEuFoC+4y2KQytnAFLl0t6nI9ZgWSTZadClX1Eio0wDLXpSOpfh2gCfEH2LEjCFc
         VD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320982; x=1772925782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84eJNEp6vvN1olc1qLpAO0h3fBelQAr4Y3eg29KdRtM=;
        b=am6Xy+1jc26O0wH957D2Pknp5FAegMtjs25UtrYNCDvnUtnr/yuRNKxdlnv0efhdYu
         5QnIixXgQK3TB4K8j6UCmONGLVaLfTVg3j9assrhMIELp0qfR9xlGdSwT77GEXKCOZVt
         +XpVF/V52EYZSq5ReYeetqlBc3KiWvIbiEz5aJtcLPIr04LQ+SykE6cjTRx9kKQO/BkI
         lG71I7NAOi3oDKTI7wLfVIB0BQREycUPCX8P/xqJtuFb6UVolYbDekmt2WhRVmTrmp+j
         /CCTAmr04Z1V2Qgo8bxQSsVR1G9NH+ZRrpuuDd2PGIYNvwCHWpEvz+2NUto0Hbb3fo6O
         Z+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXxlW2WLGspons9jYyD3+C0ZiFzvFv57ypWlv1A+ZNtW99hJlkbpzoC31hUZJMt6+prnq6+ZJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZuPV0RXEU7C8uBfK7ZMgIh6uU8ikQg85tU/vgUaQQu5/K/3q
	ljFNOv41WxfphtXRjahcbJGSQFpmvfowApIbEK5wXDcLiouXraXwAuJR
X-Gm-Gg: ATEYQzx1g2HXi4yU5Dl5II60Lfa6YPthpDkFGGNxX5I9OXUKNrHuRxMtz45S6trOQ5y
	rQISqMVWYNhw7ni2Y+DjCqlHZFKbTOa2+1+lrXY05WLSB2xIAY20+vZPor4nMB4ZyaopxmBYVZ9
	q0CSZcXxFeHJMPBzs1TyNoncd6RwSmeLkj0W55mk4+NAbJUNKfbQrWX3AhnYRtcCJun3n2aXwxJ
	tEokkDlWpDtyMO72tYtA+PVbuBzD9uot7Tai4op6uyPwOJH1sEAaIfWx0mMsxbs7gviPi9tSnMT
	P6GI/MVW+gTdFDe9bpj/dQqx53TUxTo19O/YTAN6Si11enEF8Grql15D0JCEZzq7j8GYlWt5udg
	6BYtQwFjd7s0V1Xmb9J2RIvcOcBmKsrv03+TpfCWWg52e3B3liwGeMXLWahtsz6TUw7GQh8O0Yn
	UmXxUZv6G/NwRIvej9qFKCRDs6dBDabqrAXEx/VVWZE/ERyJwUD0yZVbpz4WBZ0AZdeGHrJWjxD
	FtJhZg=
X-Received: by 2002:a05:600c:46d5:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483c9bb7c16mr121675285e9.3.1772320981923;
        Sat, 28 Feb 2026 15:23:01 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:01 -0800 (PST)
From: =?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net-next v2 0/5] net: phy: Disable MDIO broadcast address on YT8821
Date: Sun,  1 Mar 2026 00:22:36 +0100
Message-ID: <20260228232241.1274236-1-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262258-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cudy.com:url]
X-Rspamd-Queue-Id: 894791C9A90
X-Rspamd-Action: no action

Hello,

this series is a rewrite of patch [1], which attempted to make the
Motorcomm YT8821 PHY operate reliably in the Cudy M3000 WiFi router.

Background
==========

The issue on the Cudy M3000 is an MDIO address collision at address 0:

 * The MediaTek MT7981B internal Gigabit PHY appears to be hardwired
   to respond only at MDIO address 0.

 * The Motorcomm YT8821 external PHY responds, by default, at address 0
   in addition to address 1 selected by its strapping pins.

At a minimum, this means that MDIO transactions intended for the
MT7981B PHY are also interpreted by the YT8821, which causes the
YT8821 to not work reliably.

The YT8821 is not unique in this regard. At least two other vendors
ship PHYs with similar behavior:

 * Realtek RTL8221B-VB-CG
 * Micrel KSZ8081

It appears to me that multiple vendors may have interpreted IEEE 802.3
Clause 22.2.4.5.5 to mean that MDIO address 0 is a reserved broadcast
address ("A PHY [...] shall always respond to transactions addressed
to PHY Address zero"). However, the omitted part of that sentence
limits the scope, and it does not apply to many PHY types.

What this series does
=====================

The goal of this series is to reconfigure the YT8821 early enough so
that it stops responding on address 0 before the kernel performs the
first access to MDIO address 0.

The approach is as follows:

 1. Patches 1 and 2 modify the MDIO bus probing order so that address 0
    is scanned last. This allows PHY fixups to reconfigure PHYs found
    at addresses 1-31 before address 0 is probed. The core idea was
    suggested by @dangowrt on OpenWrt GitHub [2].

 2. Patches 3-5 implement the required PHY fixup for the YT8821.
    They introduce infrastructure for an "address 0 fixup" that can
    be reused by other affected PHYs.

I initially attempted to use the driver .probe() callback. However,
testing showed that this is insufficient: if the YT8821 driver is
built as a module, the .probe() callback does not run early
enough (i.e. before the MT7981B PHY is initialized).

Why this is done in the kernel
==============================

In the v1 discussion [1], the conclusion was that this should ideally
be handled in the bootloader. However, this is not always practical
for OpenWrt deployments:

 * On the Cudy M3000, replacing the stock U-Boot is possible, but
   doing so removes the ability to easily revert to the vendor
   firmware using the procedure described in [3].

 * On other platforms, replacing the bootloader may not be possible, and
   so OpenWrt may need to have a kernel-based workaround for them [2].

Testing
=======

The series was tested against the v6.12 kernel currently used by
OpenWrt main. It resolves the PHY issues on the Cudy M3000 with the
Motorcomm PHY and does not break networking on the Cudy WR3000H,
which uses a different Realtek PHY.

I also verified that no MDIO access to address 0 occurs before the
YT8821 is reconfigured to stop responding on that address.

The series is rebased on top of v7.0-rc1 and build-tested there.

[1]: https://lore.kernel.org/all/d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com/#t
[2]: https://github.com/openwrt/openwrt/pull/21584#issuecomment-3941868545
[3]: https://www.cudy.com/en-eu/blogs/faq/how-to-recovery-the-cudy-router-from-openwrt-firmware-to-cudy-official-firmware

Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
Changes in v2:
- Introduce changes into the PHY core that allow the broadcast
  addresses to be disabled before the first address collision
  occurs.
- Move the early disabling of the broadcast address from the
  YT8821 .probe() callback into a PHY fixup.
- In motorcomm.c, use ytphy_read_ext_with_lock() for the disabling
  as it takes the MDIO bus lock.

Jakub Vaněk (5):
  net: mdio_bus: Scan buses in reverse order (31 -> 0)
  of: mdio: Scan PHY address 0 last
  net: phy: Support PHY fixups on Clause 45 PHYs
  net: phy: Add infrastructure for PHY address 0 fixups
  net: phy: motorcomm: yt8821: Disable MDIO broadcast

 drivers/net/mdio/of_mdio.c          | 35 +++++++++++++++--
 drivers/net/phy/Makefile            |  3 +-
 drivers/net/phy/mdio_bus_provider.c | 14 ++++++-
 drivers/net/phy/motorcomm.c         | 29 ++++++++++++++
 drivers/net/phy/phy_common_fixups.c | 59 ++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c        | 60 ++++++++++++++++++++---------
 drivers/net/phy/phylib-internal.h   |  2 +
 7 files changed, 176 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/phy/phy_common_fixups.c

-- 
2.43.0


