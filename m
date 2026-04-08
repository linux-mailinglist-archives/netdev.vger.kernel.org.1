Return-Path: <netdev+bounces-276466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM+jHi9E1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F893BBB4D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC17D305711F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7321258EDB;
	Wed,  8 Apr 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw0LKOPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7B332601
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649465; cv=none; b=WbG34lgN7DfhmzvCsyfcCyAggC1kEXJk1lt+FMCm31e91tL4WtwtPHYDL83CfPIDdAhk7Zep+oa8lRz6hQMNmcSkmBHNDb05eJYwrT6SZnQDFo225V/Bus/TGIIUXrsmfTSGlkg6YSShR9aY9lnNTC/OdhKcvwMOdQjvanyozuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649465; c=relaxed/simple;
	bh=XscSiaVsdQ3yMiKaqacmUk9OOVbjAySHjfpWMwLEhAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IaMFXLUvGsoaswmTLge7vpcOH4YmxfiMkG/1mZtaZyO3bHrZyerrbQZt7XcEShyTns+4xBzmODZMp5v05b6hYA3KDyaDZalSlcu5/+wfGDNeA9WkMDWzoD4jbZOJ+wG1iRGAlLIul/3BFrUIcYHI5RUUio+UAWsGrYyBoilkeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw0LKOPl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfce3a195so3806148f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649462; x=1776254262; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk8abfXKp5V/ymFxu7aEKc03z2CI5xbGt87jpjsDHFc=;
        b=bw0LKOPlP3iUW7HcLMEFKoZW6jG3Rp8reDFgxv9wFcq0IcMcIfZSIomu0bQ1jBwYYV
         eVOitN0roRc1Uq2I2OX/qJv8OqTXq8WjBrn3ahFTbXjJ1ss2pz3NK5laUlo4P0W9QG10
         Z9YO2KlEVT4GYWtwK/cYyFZHdx4aTLUcFJHfz8sU6X4xr7ZBDdmTljPfZLJy5ogJPVHg
         1OkJd1izUDS1zihSEHBPBmpAIWIQdcMsi8GnoENLniWj3/otivkeOsWEdsyrKKKTbNv2
         hj6Ztn3+Lk3aEYbU3Mkuj6xyxJtBuOEz0nIPgiZrEEtz7PFec4p7owRvWZBJZsv4bvKa
         mSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649462; x=1776254262;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk8abfXKp5V/ymFxu7aEKc03z2CI5xbGt87jpjsDHFc=;
        b=S0ifwpbdjbypEQw2jWGBbInlWgOtbpzQnz6J9mNrUX3dcW/FY93n/p8IJ7IvP35QjC
         euBc4tehK4+R7kVrmfOQkkK/f0Ji8DTodSeGwPxzHYC5KVv39oXccAjqFrvkZ+RV7+bq
         MRxcdxFKjKnA3ddEDL+n5ZitDv/LnPQD/v4krLofHVM7U37s3QJsMLmEZwcsxQEKEfbm
         AkeqQUxfcN1HESc79PjjSUCzZWWL+4qX8KQ1WHAkLz2s4eexte85iZq4oW1+GwTo51JM
         ynqiLvlTIbZabe53P/7Bfj/CtZ8LtlBG5FdGGNge9mud/TGwTHw+PGXSKa3X/h7r7K4k
         FYAw==
X-Forwarded-Encrypted: i=1; AJvYcCU592a8ZBcGA4FReiwby6v/3Zj5LWldicqWPyVGyf08D605AIgvujJFrHjipN+XG8rde+0aVwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/ZVuHrgp4o6jzW2m6H+5U3txixjyld7AYuZ7nda688J33yIr
	e30YzcaXjMkS+/W+s0H8N4EiB3p69OKdxYToY2yfmx+K7Gqa+2tvnkYd
X-Gm-Gg: AeBDieuFCI6HW0URGnXVUzqQwYEEZtpYzK5/jxt+1PitnLIqnjQGyZbdNzGxFc3zAkQ
	TOjejy46lfird9zA8vHyGeC5igK22dCPgf4LrVKYok0ecTjfEbd9VxqKn71AjV9iGp5EuLctiQi
	XQ4srjqgXMnqFXahPV0XpEDZxx3WvFxjq55OVGfGGbgu8SGIhe2R9OSX6m6tQE7xc/ro6230el3
	0ZsDfyddwQO+wR8PLWq1GV9bxtofdSVxswoxxIsnWDZJr3D4fEyL+tmQoFlJXjnjvdKeKkpCbg/
	utzJBsYVX85gLjNHmN+MCRh26jkWG/gwRPRyqXnhWQ16U1o9WDPREt+Bt/odTdymRAGJKgyYnQT
	0XyJ72k8XttFrS9RGu/GfPsaY9gxSSU9CDNXe6mJgKqdWvdtxG+W6rHgDff3l+PTLflWdZjnXYM
	aaUaoFpVAA1DRcqspgkMsTO9UguSoXmfkZriRKKgrAn3Qr5CA7UTxDlhRWLf4t87DACIc3+KWhB
	S6RApWeaQ==
X-Received: by 2002:a05:6000:238a:b0:43b:3bed:f34 with SMTP id ffacd0b85a97d-43d292e70a9mr30931441f8f.30.1775649462287;
        Wed, 08 Apr 2026 04:57:42 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm58725449f8f.16.2026.04.08.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:57:42 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Wed, 08 Apr 2026 13:57:14 +0200
Subject: [PATCH v2] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
X-B4-Tracking: v=1; b=H4sIAJlC1mkC/42Oyw7CIBBFf8WwFkOh0taV/2GahuLU4gMMgxVt+
 u/SGvcuZnGSe++ZkSB4A0h2q5F4GAwaZxPw9YroXtkTUHNMTDjjkgku6AXfZRFjA96roJqre6Z
 DbLSzFnRIdaSt3EIhgbc5EyQt3T10Ji6WQ/1lfLTnFJ+n50RvMDj/Wt4Ysjn3M8q/jENGGS0qJ
 auyy4Xkcg/RBdAb7W6knqbpA+S6QkHpAAAA
X-Change-ID: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775649461; l=8279;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=XscSiaVsdQ3yMiKaqacmUk9OOVbjAySHjfpWMwLEhAc=;
 b=Rw92b+YLQ9gSnS0Y38tU/Ek6tWP8M5BVekkDAcvvEwsevqsJb+KnGjhS9YPSJ6qDt0p5voWYD
 Hw4wnvjXZOvD3rzuSi1vXDABpcwKiwMiWBX9hWvYv8PSunDFkmsj1lQ
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276466-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E5F893BBB4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the "Module 3: Equalizer fix for short cables" erratum from
Microchip document DS80000687C for KSZ87xx switches.

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

KSZ87xx devices require a workaround for the Module 3 low-loss cable
condition, controlled through the switch TABLE_LINK_MD_V indirect
registers.

The affected registers are part of the switch address space and are not
directly accessible from the PHY driver. To keep the PHY-facing API
clean and avoid leaking switch-specific details, model this errata
control as vendor-specific Clause 22 PHY registers.

Two vendor-defined bits are introduced in PHY_REG_LOW_LOSS_CTRL,
and ksz8_r_phy() / ksz8_w_phy() translate accesses to these bits
into the appropriate indirect TABLE_LINK_MD_V accesses.

The control register defines the following modes:
  bits [1:0]:
    00 = workaround disabled
    01 = workaround 1 (DSP EQ training adjustment, LinkMD reg 0x3c)
    10 = workaround 2 (receiver LPF bandwidth, LinkMD reg 0x4c)

Workaround 1: Adjusts the DSP EQ training behavior via LinkMD register
0x3C. Widens and optimizes the DSP EQ compensation range,
and is expected to solve most short/low-loss cable issues.

Workaround 2: for the cases where Workaround 1 is not sufficient.
This one adjusts the receiver low-pass filter bandwidth, effectively
reducing the high-frequency component of the received signal

The register is accessible through standard PHY read/write operations
(e.g. phytool), without requiring any switch-specific userspace
interface. This allows robust link establishment on short or
low-loss cabling without requiring DTS properties and without
constraining hardware design choices.

The erratum affects the shared PHY analog front-end and therefore
applies globally to the switch.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
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

The register defines three modes:
  - 0x0: workaround disabled
  - 0x1: workaround 1 (DSP EQ training adjustment)
  - 0x2: workaround 2 (receiver low-pass filter bandwidth reduction)

The register can be read and written from userspace via standard Clause 22 PHY
accesses (for example using phytool) on DSA user ports.

This series is based on Linux v7.0-rc1.
---
Changes in v2:
- Dropped the device tree approache based on review feedback
- Modeled the errata control as a vendor-specific Clause 22 PHY register
- Added KSZ87xx-specific guards and replaced magic values with named macros
- Rebased on Linux v7.0-rc1
- Link to v1: https://patch.msgid.link/20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com
---
 drivers/net/dsa/microchip/ksz8.c       | 33 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 20 +++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b..d11da6e9ff54 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1058,6 +1058,11 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 		if (ret)
 			return ret;
 
+		break;
+	case PHY_REG_KSZ87XX_LOW_LOSS:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->low_loss_wa_mode;
 		break;
 	default:
 		processed = false;
@@ -1271,6 +1276,34 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_LOW_LOSS:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+
+		switch (val & PHY_KSZ87XX_LOW_LOSS_MASK) {
+		case PHY_LOW_LOSS_ERRATA_DISABLED:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
+					      KSZ87XX_EQ_TRAIN_DEFAULT);
+			if (!ret)
+				ret = ksz8_ind_write8(dev, TABLE_LINK_MD,
+						      KSZ87XX_REG_PHY_LPF,
+						      KSZ87XX_PHY_LPF_DEFAULT);
+			break;
+		case KSZ87XX_LOW_LOSS_WA_EQ:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_EQ_TRAIN,
+					      KSZ87XX_EQ_TRAIN_LOW_LOSS);
+			break;
+		case KSZ87XX_LOW_LOSS_WA_LPF:
+			ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF,
+					      KSZ87XX_PHY_LPF_62MHZ);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (!ret)
+			dev->low_loss_wa_mode = val & PHY_KSZ87XX_LOW_LOSS_MASK;
+		return ret;
 	default:
 		break;
 	}
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..cd1092aa0eaf 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,10 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_EQ_TRAIN		0x3C
+#define KSZ87XX_REG_PHY_LPF		0x4C
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +346,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +733,20 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Equalizer low-loss workaround */
+/* bits [1:0]: 00 = disabled, 01 = workaround 1, 10 = workaround 2 */
+#define PHY_REG_KSZ87XX_LOW_LOSS       0x1C
+#define PHY_KSZ87XX_LOW_LOSS_MASK      GENMASK(1, 0)
+
+#define PHY_LOW_LOSS_ERRATA_DISABLED		0
+#define KSZ87XX_LOW_LOSS_WA_EQ				1
+#define KSZ87XX_LOW_LOSS_WA_LPF			2
+
+#define KSZ87XX_EQ_TRAIN_DEFAULT       0x0A
+#define KSZ87XX_EQ_TRAIN_LOW_LOSS      0x15
+#define KSZ87XX_PHY_LPF_DEFAULT        0x00
+#define KSZ87XX_PHY_LPF_62MHZ          0x40
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..729996c7160c 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -219,6 +219,9 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	/* Equalizer low-loss workaround tunable */
+	u8 low_loss_wa_mode; /* bits [1:0]: 00 = disabled, 01 = workaround 1, 10 = workaround 2 */
 };
 
 /* List of supported models */

---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


