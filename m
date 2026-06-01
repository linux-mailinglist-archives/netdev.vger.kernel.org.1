Return-Path: <netdev+bounces-293809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8nCaChaoHWp+cwkAu9opvQ
	(envelope-from <netdev+bounces-293809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F68621EA0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F443145346
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1953DB629;
	Mon,  1 Jun 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keyqpuzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDB3DB30E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327508; cv=none; b=N3r5SeEr8nnjrJABvH30mAAu9nDKF0WlP47eZPGykT3EPY8orW8Bo2AYvgpDhPuCJPhH7IHexZieQ+mEcUDJoEcxntMhfvJAwEakdSh+bEBGc+BVC7gORqPyGLR8O1l63hTU9vORUlg8hvpW9P2G95/KmUOvwVYCFV9k7yhxlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327508; c=relaxed/simple;
	bh=RyWdLidg/XOQcb4wB0R2/8V8/6srcztorIKYiP2JGoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uzqlkiT2+/A/DWMcBWDtquz7uVTT4+Poi9/xOguNcrySBErD8KfKkTQNZD6iEyncqZjCxuosXB2MsGoidurGGrmck6WbRkAT9S1+yILUMEwHneFtkKnc/Ue33f+iqiSUdxLMDgBQiON+L37vzbrfaXbKCguwCwKrR6zJIKkMoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keyqpuzp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so105850055e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327502; x=1780932302; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogf7Kjz3cOXtVe1gSiUA6j28CQTIVmLtv95/EHOxlXE=;
        b=keyqpuzprMu9q9Uu+oCTg5GuehBWz8ecspFaIumsCO6IABM1yVeGQwNzwwJIrqgLhr
         fEmSefmQnv1YIZJVgG4Kjs08fGmS0yHhsEKtUOs15kbjN/lpC2lvh8uGpQbZzrT8rg5C
         OPnMtvlKoJYEvwOG8JzSbcE1dIbhILp7tq3Aew6ccK8EJvp2xai5tt4xKYRJS2pLi9CB
         gN4leqqJ3lo/mOhKSQ0nOGiYM3dOHAkQTb/oopklzPyWxXALMkUMXkJbH7P6zhoK5DYE
         WghIXCC1gk23fntOLUdeSwjXoq80zhLLavFlkSI+o8+d5NONQyWD0/EftnLxscqLjUKZ
         GsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327502; x=1780932302;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogf7Kjz3cOXtVe1gSiUA6j28CQTIVmLtv95/EHOxlXE=;
        b=HtOkEGULVsEjWQbpG/H20VWjGP/d6ZxGeceIdSbI/D+WCaOv3K7yqRZ4eSYWGK0B4X
         TmI1LGwy8oXA6WvEjPK5HoruZ1Gjh6kaR5I38Q36pO+YElsr60GrEF5WGJicf4bDqzPc
         WnkFhkeDYOKrnXWqKUyqzRjM/zTTqHqkomN/9p7ceux3YVNm5SwlZbvOvWUB1KDzuTlR
         ebbFfqkMemjUxJI1pdXv0ref+vU5dvUVJ2XkSNpkVc/ilGsTQueGETr9Uw/lfKe4K3gD
         Fj+qOI7pgg/aBoC68J1ZbBz0gVxKPLOnK3V0xbbrpdVw2/2hcr1eZQFJT5OmjGjm3ftp
         nrvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H3kWjz+0J9hcNPHVPgmm+J9gLcGR7RIllfhAnMrqu3T/5NjxteNXhji6/tNynCZFdsFRrv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKu3O5hAkTzIun2dmM2VuX4ocofZfmq2LVUDcU7c6uoFBTPfLR
	Ehxb5YsRXHUEU+Zl/1nFtTKUo39zeSglUe07VIp6EuHyDZqXYM6CxMAHV2zGFBAP
X-Gm-Gg: Acq92OHe6VTQ90snq610s71hLps/SFdXMwS5q1i1wA4rcFU33HjnE742KGA/Qwtt6dg
	l6D2+VkiAyfQWl2W57NIaFoR4k2s4ditQry8qroJ+XssGAE4+9EmxLDDzZhvjcVriWaGjxBeqOW
	EifRO5u0kRA7EJjGlXnz4bm5I1CICzGio2Omt1fDGABRZ5xrPu3k+omjmXQ1fOJXG7hdjq0vaDy
	OLHWD/5GuKQRRmGQE1ufW+VI5PTJqaaLbaIHSLLrjjFpXuwz9nv2bKRI44PIra/bsGq4apmRV+Y
	Cg8puYCwfek6Tufo6hED1AJ9FQk0RfqEGUbAf8xv47ve4QjlQ7hlJlKCTxTbAT8YVzFohLJRxLx
	U9yD5PJ435eGqM8YUWAiG5XnqqYFZLHvp/X3yE1wziJ6m4YMTCUZgj+aJ/whapJ5c2yq7UsbIEP
	HvfkUDsiK5BSxJdvitSSKlhslkzgtS/7uqqKj8akZqAbOjGJJiPOCb79Lf/pcvqVmzCD1zY2la9
	PM50RgJh0xqbh/oXSvaxNFEBq8uSuk=
X-Received: by 2002:a05:600d:6445:20b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-490a2958db9mr155956515e9.18.1780327501467;
        Mon, 01 Jun 2026 08:25:01 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e26050sm26035e9.9.2026.06.01.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:25:00 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH net-next v9 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Date: Mon, 01 Jun 2026 17:19:54 +0200
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABqjHWoC/43R207EIBAG4FfZcC1mOJSDV76HMQ2lg1sPrSm1V
 jf77s5Wk63pDRdcTGC+f4ATyzh2mNnd4cRGnLvcDT0V/ubA4jH0T8i7lmomQRpQUvGX/O3sstQ
 4jmEK9evwSSvnOg59j3Gi9swbU6E1KBsNipH0PmLqljXlgfU48R6XiT3+7uSP5pkaLyGXs8cuT
 8P4tQ40i7XjL9sUZc+CA7c+GO+SVkaae1yGCeNtHN7WyFleUQ2uDJVccB8TKme8sELtULVBhS5
 DFU0KRCoXg3fR71C9RW0Zqgk10YLWGOn++0mrK1pBVYZWhLZBA8hGiqjlDjUbVEIZagjVKinV6
 hASpB1qt2jhm1pCRWw1fVaQOsEOdVfUgChDHaHkCZAxGRn/o+fz+Qd6plKlRgMAAA==
X-Change-ID: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780327500; l=6384;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=RyWdLidg/XOQcb4wB0R2/8V8/6srcztorIKYiP2JGoc=;
 b=xsx41x3tjbH3cSnd9aekLHxGhHYBmgFmxvzObJznMQUd3qRtfAohhsrcIuFmhveOGuSwMT+lq
 YwFMPyQGb0jAi0vbdNIJmNOXx8OEccajaYO6+zhZo8DLAsfIpq5GkdC
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293809-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77F68621EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This patch implements the KSZ87xx short cable erratum
described in Microchip document DS80000687C for KSZ87xx switches
and the following support article:

Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

According to the erratum, the embedded PHY receiver in KSZ87xx switches is
tuned by default for long, high-loss Ethernet cables. When operating with
short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer may
over-amplify the incoming signal, leading to internal distortion and link
establishment failures.

Microchip documents two independent mechanisms to mitigate this issue:
adjusting the receiver low‑pass filter bandwidth and reducing the DSP
equalizer initial value. These registers are located in the switch’s
internal LinkMD table and cannot be accessed directly through a
stand‑alone PHY driver.

To keep the PHY‑facing API clean, this series models the erratum handling
as vendor‑specific Clause 22 PHY registers, virtualized by the KSZ8 DSA
driver. Accesses are intercepted by ksz8_r_phy() / ksz8_w_phy() and
translated into the appropriate indirect LinkMD register writes. The
erratum affects the shared PHY analog front‑end and therefore applies
globally to the switch.

Based on review feedback, the user‑visible interface is kept deliberately
simple and predictable:

- A boolean “short‑cable” PHY tunable applies a documented and
  conservative preset (LPF bandwidth 62MHz, DSP EQ initial value 0).
  This is the recommended KISS interface for the common short‑cable
  scenario.

- Two additional integer PHY tunables allow advanced or experimental
  tuning of the LPF bandwidth and the DSP EQ initial value. These
  controls are orthogonal, have no ordering requirements, and simply
  override the corresponding setting when written.

The tunables act as simple setters with no implicit state machine or
invalid combinations, avoiding surprises for userspace and not relying
on extended error reporting or netlink ethtool support.

This series contains:

  1. Support for the KSZ87xx low‑loss cable erratum in the KSZ8 DSA driver,
     including the short‑cable preset and orthogonal tuning controls.

  2. Addition of vendor‑specific PHY tunable identifiers for the
     short‑cable preset, LPF bandwidth, and DSP EQ initial value.

  3. Exposure of these tunables through the Micrel PHY driver via
     get_tunable / set_tunable callbacks.

This version follows the design agreed upon during v3 review and
reworks the interface accordingly.

This series is based on net-next.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
Changes in v9:
- Drop incorrect Fixes tag
- Fix typo in comment
- Link to v8: https://patch.msgid.link/20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com

Changes in v8:
- Clarify LPF/DSP EQ register definitions based on Microchip support article
- Make short-cable preset reversible by restoring default settings when disabled
- Link to v7: https://patch.msgid.link/20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com

Changes in v7:
- Rebased on net-next/main
- Link to v6: https://patch.msgid.link/20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com

Changes in v6:
- Nitpicks corrections
- Link to v5: https://patch.msgid.link/20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com

Changes in v5:
- Added Fixes tag
- Added validation to ensure that only the documented bitfields are accepted before writing the registers
- Link to v4: https://patch.msgid.link/20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com

Changes in v4:
- Reworked the user‑visible API to a boolean short‑cable preset plus
  orthogonal advanced tunables, following the KISS principle.
- Dropped the previous mode‑selector semantics in favor of simple
  setters with no ordering requirements
- Added persistent tracking of LPF bandwidth and EQ initial value.
- Clarified defaults and preset values to match Microchip documentation.
- Link to v3: https://patch.msgid.link/20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com

Changes in v3:
- Exposed all LPF bandwidth values supported by the hardware.
- Added phy tunable.
- Link to v2: https://patch.msgid.link/20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com

Changes in v2:
- Dropped the device tree approach based on review feedback
- Modeled the errata control as a vendor-specific Clause 22 PHY register
- Added KSZ87xx-specific guards and replaced magic values with named macros
- Rebased on Linux v7.0-rc1
- Link to v1: https://patch.msgid.link/20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com

To: Woojung Huh <woojung.huh@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Marek Vasut <marex@denx.de>
To: Tristram Ha <Tristram.Ha@microchip.com>
To: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

 drivers/net/dsa/microchip/ksz8.c       | 89 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 ++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 54 +++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  3 ++
 7 files changed, 178 insertions(+), 1 deletion(-)
---
base-commit: c2c0486c56800ce276e79c40a6e576ffd672f2a9
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


