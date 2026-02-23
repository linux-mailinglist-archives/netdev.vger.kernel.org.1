Return-Path: <netdev+bounces-260049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdGNjFenGkUFQQAu9opvQ
	(envelope-from <netdev+bounces-260049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:03:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9634177A85
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA2230AD8B7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDD274B2B;
	Mon, 23 Feb 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIuPjcJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8626B755;
	Mon, 23 Feb 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855095; cv=none; b=nXMgNb7PoRQBIqT2hcmRZmjATekcgrg7uzlo7T6kFsrGd2gBdQoit/7juP5EyBVVbDKkLrH1ReaBqGfwXiru1glzZU8s7BxJO4PgkPwZXsCT0hTsP0PbtBrnSg9QNDGOLWFFtayw2hmHx7QdOt1TQXp9olNgjAfNY63+/5hfjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855095; c=relaxed/simple;
	bh=NWu25ePSA9QcgdrFAqYIS8vaWQtv0PHPjTD9T4fKIpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S5ySpNpSg5IYarlaA9wOAKemdfdzA4/gLKrl7P3qnTRYX1zCXF2/Omh2APdvM1Zz3H5iGW310kdhcXpIu9RgcrpMFnil6kJETLxZDlCgWcHkM10Gom4YJMvALkf6tm8GvUTC9k0bHqEWUvp1Ij5gWFBjwWbxmZAWv7QZXGXs9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIuPjcJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C61C116C6;
	Mon, 23 Feb 2026 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771855094;
	bh=NWu25ePSA9QcgdrFAqYIS8vaWQtv0PHPjTD9T4fKIpQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oIuPjcJ/2aujwT0Bsu10Kn6pU8scyDZ8KkT0BpcoNTR6tDY9TAjVWviG5KbV7MQ+J
	 9Dr94BbS2/UzAfztB+vIEYXN1kXYPDwkSDv8IOO85xKfsNmjAHdF8Vz8UQZo7EFo6M
	 RTiNF3yk5NpPHZGgC/4oG8aGbRZyGH0LU+NUKn0/fzRW84XrJbInXa/T9tieYVF79Q
	 CKO98OvcIQvVIGmHbUADoMvwVoFixqf5TNBtHCKsl5/njAq5SUsUsHm207xgHMKxJu
	 KtlDBeG+xHEPRnQyQzd++iLcaUUJZxI50vxqFfMHI3ERiNVeqMVfhpsZfKBdTlmhRx
	 UAA1LoyaaJ1GA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062EEA4FA7;
	Mon, 23 Feb 2026 13:58:14 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Subject: [PATCH v5 0/4] Support multi-channel IRQs in stmmac platform
 drivers
Date: Mon, 23 Feb 2026 14:58:03 +0100
Message-Id: <20260223-dwmac_multi_irq-v5-0-8fc699a5fac4@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtcnGkC/23N3wrCIBTH8VcZXmfo0Zl21XtEjM1pE9qfdK0i9
 u65KCjs8vuD8zkPFIx3JqBt9kDeTC64vouRrzKkm7I7Guzq2AgI5BSIwvW1LXXRXk6jK5w/Y1V
 LKwgXoDVF8WrwxrrbS9wfYjcujL2/vx5MdFnfFuWJNVFMMBO5gLIiRtnNrg9h3d2Gte5btGgTf
 ARBIpEKsAiVBAWM1GRDU4F9CywVWBS0zpmFykgl/gj8W5CpwKMgwZaMW23Bwq8wz/MTxOL+GXY
 BAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771855093; l=3163;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=NWu25ePSA9QcgdrFAqYIS8vaWQtv0PHPjTD9T4fKIpQ=;
 b=ggA/D4uhdh2cz3CK46Wsz6e4BGn7m9ixXSJy22LIR6S0OgBpSSlBw/JpcdMu1EjiTHSdIxcr+
 PwyGrS8RSrPD/AUuZmkQQEQoXHECYjFSWEcDaZICM7TopiRac1bYQCs
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260049-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	URIBL_MULTI_FAIL(0.00)[oss.nxp.com:server fail,sea.lore.kernel.org:server fail,nxp.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid,oss.nxp.com:replyto]
X-Rspamd-Queue-Id: A9634177A85
X-Rspamd-Action: no action

The stmmac core supports two interrupt modes, controlled by the
flag STMMAC_FLAG_MULTI_MSI_EN:

- When the flag is set, the driver uses multi-channel IRQ mode (Multi-IRQ).
- Otherwise, a single IRQ line is requested (aka MAC-IRQ):

static int stmmac_request_irq(struct net_device *dev)
{
        /* Request the IRQ lines */
        if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
                ret = stmmac_request_irq_multi_msi(dev);
        else
                ret = stmmac_request_irq_single(dev);
}

At present, only PCI drivers (Intel and Loongson) make use of the Multi-IRQ
mode. This concept can be extended to DT-based embedded glue drivers
(dwmac-xxx.c).

This series adds support for reading per-channel IRQs from the DT node and
reuses the existing STMMAC_FLAG_MULTI_MSI_EN flag to enable multi-IRQ
operation in platform drivers.

The final decision if Multi-IRQ gets enabled remains on glue driver
to allow implementing any reguirements/limitions the focused platform
needs.

NXP S32G2/S32G3/S32R SoCs integrate the DWMAC IP with multi-channel
interrupt support. The dwmac-s32.c driver change is provided as an example of
enabling multi-IRQ mode for non-PCI drivers.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
Changes in v5:
- fixed typo in "symetrical"
- cleaned negative return value on platform_get_irq_byname_optional()
  in stmmac_get_platform_resources()
- rebased on v7.0-rc1
- Link to v4: https://lore.kernel.org/r/20260128-dwmac_multi_irq-v4-0-82fa34fcf2f2@oss.nxp.com

Changes in v4:
- Fixed IRQ reading check
- Made cleaner the IRQ validity (to get AI reviewer happy)
- Fixed minItems of interrupts property in yaml
- Link to v3: https://lore.kernel.org/r/20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com

Changes in v3:
- removed RFC prefix
- rebased on v6.19-rc6
- fixed forgotten extra line setting to Multi-IRQ unconditionally
- fixed yaml
- Link to v2: https://lore.kernel.org/r/20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com

Changes in v2:
- Fixed incorrect buffer len for 'rx-queue-%d' property check
- Added backward compatibility to not break old settings
- Fixed DT example in yaml
- Link to v1: https://lore.kernel.org/r/20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com

---
Jan Petrous (OSS) (4):
      net: stmmac: platform: read channels irq
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      arm64: dts: s32: set Ethernet channel irqs
      stmmac: s32: enable support for Multi-IRQ mode

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 44 +++++++++++++++++++---
 arch/arm64/boot/dts/freescale/s32g2.dtsi           | 26 +++++++++++--
 arch/arm64/boot/dts/freescale/s32g3.dtsi           | 26 +++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 12 +++++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 40 +++++++++++++++++++-
 5 files changed, 135 insertions(+), 13 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251209-dwmac_multi_irq-9d8f60462cc1

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



