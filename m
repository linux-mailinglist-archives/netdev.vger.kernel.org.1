Return-Path: <netdev+bounces-279311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI3xE1Ir4mns2QAAu9opvQ
	(envelope-from <netdev+bounces-279311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59441B491
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB6E3304E50A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71A39A04B;
	Fri, 17 Apr 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRSfa+j1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD903976A2
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776429894; cv=none; b=p+CmBe7sLTrdSCsJexe7+vNtgnPGrZxSQi+EGTe5S6c6u2C4F9Rb/M8pnzacInTZcZ+DcjF6s1X/UsM+XLuYaRF+V9Dh+vmsVebk8pdA0mOL3RmCrsg4yY6AsiJEcl0tfO9zBI/JbHk2JMfXrXAE25zB5vf4RwNVkQsUUBqvP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776429894; c=relaxed/simple;
	bh=DdQkDUdOP83Q9qSdlJ+hl4HkmaRr0TpUkznWA3NdV8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A1F+wM9VetF6LUW+QOj2/fEQcO9tiL20wqi2YOfH20L+S8A6Z+0pOiNjMjaoc/KfJnNfJamRjIDWWVlRnsSjWOAkHHkszPdAzyGPKQ0X3aeTLWZr5y+VrilrumvWAXxNVoRGAaF//7Zl2eW55nVq1TMjjNPuc9F19W4uCKZid0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRSfa+j1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d70c30767so1017541f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776429892; x=1777034692; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQcFdXIVu4hZX7tjeTznsKiwgdz5D1HsN8Q9K2m9IOk=;
        b=rRSfa+j1RXWC7LEkKatu7ny/pqjXqAleo6mTDQ2J0eFu4zqYQqd4pGR8YfQ0bQkbIp
         RU2h2fwH+dOy/5ivkO+axN/hHMDk0kKtrzXmhuIXSN+vKP+3JvMlDlru7TeOgfKe58oA
         IYJf6fdcCTegbe4nGVvDi3Kcfo/l7F1xP1VBOQ3ptAiEpVTXj1C0LgNNLXyHUvbLI32Y
         uHCRJUPhxK/P1hAHDSlEl6JrUNe/4jDQ458cz72o0mqJ8Ug6DG9Mp4ZYqYWhNEkLk+HO
         sH3L2QuNh5srvx02v/PN26kQkwYRluXMM25SkAh/sFVsP/70YBOBMOcqB4ww9oGvxVRz
         x97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776429892; x=1777034692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQcFdXIVu4hZX7tjeTznsKiwgdz5D1HsN8Q9K2m9IOk=;
        b=AUXde+B063z3Ti0fLy3Do6PQ73Aq9O45GZvlxn2whRUIsrJ8vKSfRSaecC5VyyffNl
         0L7Pxn/aFiRq75zcMb45XOasQF5jrzbKkxdqr7B9nU1vl7dagKFWzpxTIMO3zEx1MKQA
         fHlXnfAwn/DygYmjaIGwS8acsmIiG4rITK8BlYOItNY8tGUf4YqCnSVwMJjDlTQ60/yK
         aBcR7dOIShXBwcFyRRHApOfDczWNb7uJA029yqyi+L52SKsfnguypN3mHGnB1gJKSAQk
         48d/jidUwwUxAPLIPrHKgGjQLNq3VrFDUEvWc6VSYMIP+rFARjr3IiR6vciDut5NHnGM
         bIMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/64KtgB1sk1pMU5tUcgMDU9S7mnqyVdF+5/ADGuSi0y9y3fekrC3uGRqktzfPsdOsaM07yzoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0EQyuL9xY20OYLWrWZxxJSAeN0P65zpE56Xq1bMVGCZ8nWxs
	p3UV7GQ56akqrVsyk4oq6/Lkg8mQjM+5Idtxcn2cuijh41m+ts7BDhe6
X-Gm-Gg: AeBDies/XqhsQouivCosaCygtoef5RGh0JXRZDqKuQ6/EVFNOWghNOHEBiwbP0WFni2
	+o5GLFL/ARxBGVhjcX+yh+itskosx26R5HIWW2bNyEMV+jOSW62T5lEnpkdJL7HfMNzoZPgFtEE
	YkSrxWqEiUbUH4M5O4ixYmYVrsZeJ8qZUb8efSOtIVlrFmfYNERvX0OU73Fx2qsWLZ+s3UzYbpj
	ARUhhidRzYqP6jD6BhLV1MD4ZzyXG5ZolTGUDtKLhgxYAto2xDTisVeKDvZPQW+cXqWQ6owRV3r
	0Oxw1al/nYMfG0R3pQcKQMUlPk7dEXPLMI/96sToIqMr41ZP8wtfPCefpmY9XqYtWQ3GZ75lew4
	3IAUu5WQuhgKMdoAc3lI+aJVm1qGJRDbt0/eYe/ych9S8wjV7OdaNqSckrW6fkdYbK2MQN4KNvQ
	j+X/KxaS/LKZ+vfNzDIu1Ey2HKcIuX2DtBWLm0toAitFn2UyXi192nUYrQnjx3CRwvDFr287sy/
	aZ/uhRFCMGf7X1+9Qs3
X-Received: by 2002:a05:600c:c09c:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-488fb88c647mr26201985e9.6.1776429891474;
        Fri, 17 Apr 2026 05:44:51 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm47416315e9.5.2026.04.17.05.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:44:50 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH v4 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
Date: Fri, 17 Apr 2026 14:44:26 +0200
Message-Id: <20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACor4mkC/43OQW7DIBAF0KtErEMFDMXQVe8RRRam44QkNRXju
 m4t3704VdVG2XjB4kuf92dihDkisafNxDIOkWLqStDbDQtH3x2Qx5eSmRLKCFDAz/Rlq3GsMWf
 f+/qSPsojqkPqOgx9+U68MY9YGVSNFsCK9JaxjeN1Zbf/yfTenEp9oZfGMVKf8uf1jEEuvd9Fs
 2pxkFzwynnjbKvBKPOMY+oxPIT0ypbJQf2hWth1qOKSu9AiWONkJeEOhX+o1OtQKJeKQoIN3tn
 gbtB5nr8Bo/sZd5MBAAA=
X-Change-ID: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776429890; l=4673;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=DdQkDUdOP83Q9qSdlJ+hl4HkmaRr0TpUkznWA3NdV8M=;
 b=Y7uUk+guA8Jg+6lP785NYhGBmu8wrHqHKSu3e7tD02RCdWVBTcDI8gagTKbSAGSmxwDCxw1UQ
 3hk7PuzyeoWASd723glAvEZarVYbNEYdLxNaGxPNzyLzAemrI2fyVue
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279311-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,exotec.com:mid,exotec.com:email,msgid.link:url]
X-Rspamd-Queue-Id: CE59441B491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This patch implements the “Module 3: Equalizer fix for short cables” erratum
described in Microchip document DS80000687C for KSZ87xx switches.

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

This series is based on Linux v7.0-rc1.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
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

---
Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

 drivers/net/dsa/microchip/ksz8.c       | 67 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 21 ++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 54 +++++++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  3 ++
 8 files changed, 155 insertions(+), 1 deletion(-)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


