Return-Path: <netdev+bounces-278357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO5mMB8F3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96A3F7B24
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822CD301DB8C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5F3B9DAC;
	Tue, 14 Apr 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9YNrc4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8A13635C
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157980; cv=none; b=HjM60nZBjxqKlrekGiVumfTvrIAWPdbCvt6mD1XaO7l4UVpWItv4MN9UPRHhj65Dv0kYE3ocNIn7l7SPxhWXzag2etffZsiQxJpRpS0tVdt2BehIFwEHRR4ATbq25CeSGpCceEX7DEzZoQhtH8tGA7YAemzvMFgFiTUjZBbMguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157980; c=relaxed/simple;
	bh=U6zwG99hw985545cJNtTNsDusgPzyPeUkX9br2IJj5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jIbnM1J1G3Mi/cZeWDD+MKXNJIhSTZurm9Q5V852/L6ewOPOFlJ/lO1I+g5wCZNhRtxVFRWfJifdh+beJhK16A+N+a0UD0P1gXgha1cr8ByF5XdIHsSXBUcfqWxAhRkpf4XSWl0fno+c3ZpVkSjCcJ8RXELEB4rJbiAYdjt6qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9YNrc4r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a041eae5so39265155e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157978; x=1776762778; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4t1G4+4JmAZQxqNkrkh1AxLVx0ioJOhQlGcd0wan2yw=;
        b=N9YNrc4rllVd9a69NKnC533c1dJGjfEosVBa+vMcOpjuyxtBrLtLZA4gcO6WoJ+dF4
         d9XiO3xxW/roVmxMJcKJINJXuuROp0Sn4aeiHWDRDw1URf6Zgzy0IprP4j5ac27DW6qv
         88Z7CHxgjmruYBYlLh2CN9oWckZluFnPxj+YZs+tCTT+vLyI9yomuhNMFaV2D3FjTzJj
         GlCs9Da93S7cG1/uhXOoGvoyEyFZKm4eSiohWo8Bre+GIu/JJoScF4f/AzkDARiWQNXx
         4Ya3Ek5J6F2ynInrhXP9v2BH8KJwWJP6JWyV6kXx7+cdK2MhP5OvmkgHsEG2lv5qP888
         8a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157978; x=1776762778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t1G4+4JmAZQxqNkrkh1AxLVx0ioJOhQlGcd0wan2yw=;
        b=M4NQiLH07/e/oBZ/6Wjh9RMPSDIqIh2JziVAPDMVxJJ+P3SX5VX/tGwANAi2GXQ1Nu
         xBd2pIHd2ov9lBw+dL+2cnPMtG+WwWen1R9u4TDG+x02Eokge90a2CFvJvwpKrVthH+N
         QFNSua3vC6v4JXo1C6TXvn5WoJf2YAa3MtX+dExOo68pyz7ggumex/ozyPN+2/uUNdH2
         LRlPRH/JwE5NmlB/EQw62BRR0fcGQjGSYdMxa/HnRaOh4uxcemLrkJEynmcO/r6gj1n+
         tzM+6ew68AA9EI8zaE0eGTbUIYTbjqeOMZbGC+w3fbvy3V9+4tcXitScXKkuUHML3FUz
         YkYg==
X-Forwarded-Encrypted: i=1; AFNElJ/YD95K+nkzMDX61/rIqhmzp4oBPoNiGB2ci6KLWHLkBItrE8dpVv8/vkQZ9bNpph/LGht0BLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXa27/ZVNgugwUUTJrU0mjgJV163ztRPxri6OJMntuDH55kUC
	YkxURFd2fnVHp+hOPsHh/dYPvVZFNc5V5TDI+WANhDkiuFA4A5ys/6jx
X-Gm-Gg: AeBDieu5ehRXyCCcBNgEyVW22OpznkAChPxHPUCBuC+/So0ZVTM/kiN+6itdBR1JSMv
	FzdMj4w2lQMs7MaaUAOpCJ0GC6dOwFSEKgq85lKA3f28vbSrGwdpgxsUz059LDPCCi7b55O+R1s
	Gda1Idq4f9Py+BASUlGGqNgcQwwskEa50x41dhh2bkK0xyAo/STyYZFFiugVtCP6hjh1G4O5HVh
	Vr5Ein6GcUDhGzlUSMGbLuQBrT9I5NQj7w/g+0EqXS8HXLfudwzLyslZbuk28rdxZqIu3nLBzKj
	XOlyyPOogekPZYqpPIQu1yomNM5ZlfFzMFc5z1dR1qYo82m5oh5tw+4gpzSuFjmlAN4a9FLrltL
	gOhjnj09RP8gprwV90jVSmKGba0od6GYXTcC8FvkGI8S8onETm3d9uzTARMSwrcjuXBfcp2pQtt
	zzmeXkQNUWUgg1e56NfEJHE0Hzlq1YTyGqmzDYPyiU0xGj5bLVPxMDTPKKfv/lfvQ4/5eY06zwz
	ckCjHUhSA==
X-Received: by 2002:a05:600c:8709:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488d6655adfmr230520435e9.0.1776157977530;
        Tue, 14 Apr 2026 02:12:57 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddba112sm37720175e9.0.2026.04.14.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:12:57 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH v3 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
Date: Tue, 14 Apr 2026 11:12:33 +0200
Message-Id: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAEF3mkC/42Oyw6CMBBFf8V0bU0fWMCV/2EMgTpIfVDTQawS/
 t0WY4w7FrO4yb3nzEAQnAEkm8VAHPQGjW1DkMsF0U3ZHoGaQ8hEMKGYFJKe8ZWl3hfgXNmVxcU
 +wiEW2rYt6C7MkVZqDakCUSVMkkC6OaiNnyy7/SfjvTqFekTHRmOws+45vdHz2Psa1Sxjzymja
 V6qPKsTqYTagrcd6JW2VxKVvfhBE5bNgwrKaa5rkJnKecrlH3Qcxzd1XamTPgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776157976; l=3261;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=U6zwG99hw985545cJNtTNsDusgPzyPeUkX9br2IJj5I=;
 b=pmTViQdFeg77t3R0Cp4veQ9ddDJs2seEPNd8Pph8Uizosm5tTe91N+RPLvWIHe6xp/TUuhR+K
 Z0LTBWsmeWoC4zJ/y5GRsIstNPBqo26REw9JtAgYTDoOUxxt5aJXhzE
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
	TAGGED_FROM(0.00)[bounces-278357-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D96A3F7B24
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

Microchip provides two workarounds, each requiring a write to a different
indirect PHY register access mechanism.

The workaround requires programming internal PHY/DSP registers located in the
LinkMD table, accessed through the KSZ8 indirect register mechanism. Since these
registers belong to the switch address space and are not directly accessible
from a standalone PHY driver, the erratum control is modeled as a vendor-specific
Clause 22 PHY register, virtualized by the KSZ8 DSA driver.

Reads and writes to this register are intercepted by ksz8_r_phy() /
ksz8_w_phy() and translated into the required TABLE_LINK_MD_V indirect accesses.
The erratum affects the shared PHY analog front-end and therefore applies
globally to the switch.

The control register defines the following modes:
0: disabled (default behavior)
1: EQ training workaround
2: LPF 90 MHz
3: LPF 62 MHz
4: LPF 55 MHz
5: LPF 44 MHz

The register can be read and written from userspace via a phy tunable.
Note that current ethtool userspace only supports a fixed set of PHY tunables;
vendor-specific tunables may require either phytool or a newer userspace extension.

This series is based on Linux v7.0-rc1.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
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
      net: ethtool: add KSZ87xx low-loss PHY tunable
      net: phy: micrel: expose KSZ87xx low-loss erratum via PHY tunable

 drivers/net/dsa/microchip/ksz8.c       | 45 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 36 ++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 drivers/net/phy/micrel.c               | 39 +++++++++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  1 +
 net/ethtool/common.c                   |  1 +
 net/ethtool/ioctl.c                    |  1 +
 7 files changed, 125 insertions(+), 1 deletion(-)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


