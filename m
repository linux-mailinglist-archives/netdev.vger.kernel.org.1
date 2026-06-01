Return-Path: <netdev+bounces-293710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L5lAFpzHWp8bAkAu9opvQ
	(envelope-from <netdev+bounces-293710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0261EAFD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DD60302A50F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82D370D6E;
	Mon,  1 Jun 2026 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MneBhV/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A83644C6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314882; cv=none; b=N0D55szCGuaH62T/0UlYpvBY3el8u+NcL6zOuCqRM+O82h8mgcJMEqbS3k50qUSq5K+hxDrPQH17OLbhsCDWd8KXILb7H5NimQD7nqck9s4aN25iq9NViyqryZcBp1iVRcTAeutb1FFJMFQWhswla34sIT2SWGvkA6hLb9y0dI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314882; c=relaxed/simple;
	bh=xhjkWwl6w2gFZeDRIPpPrGVzOJvf2HRT3ID5KHAB7Cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bW0sbZMzanmsz+1Y8nGNg4eXAzD9cwmlMqaLOmCoXGX40jepI6yQ51GSFMF5C3KI1SRRcE98y6X5ujosCcjuVYmzbtxTTicAdndsFm63jOjCo7cKtWV05MCVYyL1/+V87BrGKklt3adC75c3Zu+0uI1x/PxjR+hiBH9ywVsjia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MneBhV/V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49050bfe053so68785305e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314880; x=1780919680; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yt6fk0C99nZMC9cvDK0r0w6/frKjntGIwQ1r/XA5CM=;
        b=MneBhV/VsLv7OeMdMkrqRjp1O+8G5wqh8dIbtd5RLrUB4GWwvoOlX/ZE6xF4kuHkXn
         NYDe81veFKp+CvGaZC0CHsM6ajcWb/B63180eHDjKF1UljwWqkbZ88jDNCA7QAF9+i81
         vIY6bp9Rj58xAYbWUC2AfKtE0WOiWgdfmamntcNuNN74/M72OGc3BghR1GLUM7gGFuVZ
         B5Tv5i0Gd9B7lNYHLcx2cD/iqf6v8JgJ8+e2jrHidIl9favl+aVkqRsKhas3AnN7N95b
         UZj1c/queMwX4gA538MbwO1fxxmIPi4QmGAcrUpCLNMVOjcI+rOfXog6pmBsXtQamxVh
         JY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314880; x=1780919680;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yt6fk0C99nZMC9cvDK0r0w6/frKjntGIwQ1r/XA5CM=;
        b=rM84yduAK/Kyy1juS67uSiS+KvZSpn1IkMXT6k6aIuUc9h8eQQSIbbx9QRf8ltMAMc
         y1K1SYvrgKvpMIMStdrhJlXNf7oaClYwIz44wb21AEs5NZkiXDA0ISKnvYGhfyW9hJQB
         g1cwgdvmpZbc5Msd8LHaZ3KbgVa0Ds1UTY0jZXO0l6i1ynUezxGT5FRD+8NtB8BszJ9K
         CeBv/hT0oPxm3QICWRLXW9a7MouNlQynLZzSIZ2ibW1QdDzZpntrqcqq2OVEIumBMSFz
         yNeoL2cDXwdoGXoPF3J1yAl/nuSO6YVTD4OH42xDCEb1oFjpP9Bylyao6Es0kXHouE6H
         iZvg==
X-Forwarded-Encrypted: i=1; AFNElJ/BWps1WvJLWQKKwrjaqWTm+Jvcs6/UEPdqyNAmWWEI7GbJ96BTZR4Doc4AZPyTmCxtri8CCnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpc4EYlbVhUD2XzJ7odMHDBK4qhcslRLqgv0CiCCiuiMBwhWPV
	IsXswk90tsZ9WHewTw/DjpnsNfIkpNuOzMwVT2n5xRclJi9zeaUlmzAh
X-Gm-Gg: Acq92OFReIULy+gaqRLGmfCusrdjK54Auxa1RSWy9oxDiu4JMI+R5CNdAvPwJ06Czgr
	k2kLJR+JJyw9Mv33/hpF1laDi96DnVexyDYUmz+qnsEuZyPkfW03BrHo0IoPB73Rob3q0fcTecw
	/cjYhFG/kzj1mBaa6zbnmxymv64Hv54p3XiGqBN/lpv+4zIkz2nM0Jsded6I6w3xGuihpqSNn72
	VzAXjs3ywnGx2X/r5KHBUiF+X413mn+gl7C2erDnvzL+gJQCr6AWDAa+ZPwx8qoFw4MhBoQuOOh
	YZy2vV2BeEdcJ+N1yqWgbKeqVLhzyp9v38ybZsYTSAzD8v4vQ+J9mQ8uokwkGw2tWomkFPk/J3w
	sZf6GR0f1+23CaiE5mX25cjRORn60WGGGNJ8zZAm76M47OmMAQxfogxefAznLx2nvpfS8qEHEQq
	iiPX2tscjlPWuNWGl6EkpC+c49T7fz/I7C3Zi/tEJJ6b2QWifWL+9/Iu6PllzVDjY+V09V23T8y
	cNKZEroi0mcu5wfTphu
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490a28d390emr195880755e9.0.1780314879483;
        Mon, 01 Jun 2026 04:54:39 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c121d63sm74376765e9.29.2026.06.01.04.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:54:38 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH net-next v8 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Date: Mon, 01 Jun 2026 13:54:11 +0200
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAONyHWoC/43RzU7EIBAH8FfZcBbDxxSoJ9/DmIbSwa0f1JRaq
 5t9d2erydb0woHDBOb3H+DEMo49ZnZ3OLER5z73Q6LC3RxYOPr0hLzvqGZKKCO00vwlfzu7LA2
 Oo5988zp80sq5CUNKGCZqz7w1FVqDqgWhGUnvI8Z+WVMeWMKJJ1wm9vi7kz/aZ2q8hFzOHvs8D
 ePXOtAs146/bFOUPUsuuK29qV0EbZS5x2WYMNyG4W2NnNUVBeHKUMUlr0NE7UwtrdQ7VG9QCWW
 opkkFkdoFX7tQ71DYorYMBUJNsAIAA91/P2l1RStRlaEVoZ0HIVSrZAC1Q80GVaIMNYSCjlp34
 H0UcYfaLVr4ppZQGTqgz/IKoviHns/nHz6ZzlbxAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314877; l=6201;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=xhjkWwl6w2gFZeDRIPpPrGVzOJvf2HRT3ID5KHAB7Cg=;
 b=VKZOPi7sGqWtV0JAaaXYfIiBfOYNlM3i/zTqUUJf+v5d9ea7nm9qLWB5W4QdVCbYUwhLMOyXw
 pgBbtiynkeNCCb/wquRcn8RHYTf91uYQRnDZ7Kd+nbqFebcwYrVN5O5
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293710-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 4EE0261EAFD
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
base-commit: c0aa5f13826dcb035bec3d6b252e6b2020fa5f88
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


