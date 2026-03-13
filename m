Return-Path: <netdev+bounces-267304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC0dG1K5s2lXaQAAu9opvQ
	(envelope-from <netdev+bounces-267304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:14:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E0327EA6B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A477D302513D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17173367F4B;
	Fri, 13 Mar 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW22/AjN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5819366836;
	Fri, 13 Mar 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386023; cv=none; b=Adt/IgJv1PsV+YE9nhp6FzXn5NTF1UtG9fsXC9Hf9ScHpTe7ErSEeH9tYs0iY3OnMycWhuUhZJvH5fzrkpzNCG95qlf0w/JexTvyibprmSwr3KkW1vo0PIYV6Cbf321XrPXIftbbDZUzRe63P83N6SQeL3I0hhJHIcEWGM4Zin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386023; c=relaxed/simple;
	bh=bwdkh3U0py07YJ4k5KES5ZDIHas3hmYsAk9jQ0VOEvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CbuE0fT8R6PY93vM8U+MVxfmSdzBB3SlYIJmZkKlL45j1T3UkXMSVJ+9iobio+QN0v8yVIhKk2Tohwvsfqu/gFzunep8RZMZ/UWBLtHiIqlgJzDb1J8WfEDBbJ/vo/m+Dab39zmzpJoIqbgvKQ/hhezGyjCMpclm4Pj0WzgCF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW22/AjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1454C2BC86;
	Fri, 13 Mar 2026 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773386022;
	bh=bwdkh3U0py07YJ4k5KES5ZDIHas3hmYsAk9jQ0VOEvQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XW22/AjNOQTg0WU8O6FmvLXcaZ+ZQl5KcGpIg5hIeRoP5J3hRQlzbTD9KsA+cMdg/
	 1y4J1LEVL+2wl6vLHRBfzkCr/zIGeFKBtzPTaH9e+qXAInaOfZo1sw7ylm23Nb3LLB
	 IbTD8+gW+wzRdXvtCRzsFZRrcySCLFoMpE8cMviliyHqVQikZ3WnNKIkijsAMJfpCk
	 uWUVLYf1pp3dCarCg24T39xXpL20SiAKv0puEKi03G6z4Fde1LuswRTU01fzqYNnPF
	 FQoKjkR/2DWP75sVWrrrjWkIWGbhMBKPdBzIUbOW1Mx8ih6mWJWnvTAma7cUUQZB4G
	 5hCTO7jnQ1mbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F7106FD8A;
	Fri, 13 Mar 2026 07:13:42 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Subject: [PATCH net-next v12 0/4] Support multi-channel IRQs in stmmac
 platform drivers
Date: Fri, 13 Mar 2026 08:13:31 +0100
Message-Id: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABu5s2kC/4XSzWrDMAwA4FcZPi9Fkn9i77T3GKPYjr0G1qRLs
 qyj9N3npIxm2LCjJfRZSLqwMQxtGNnTw4UNYW7Htu/SA+nxgfmD7d5C1TYpwAhIIoGpmq+j9fv
 j5/vU7tvhozKNjgqEIu+RparTEGJ7XskX1oWp6sJ5Yq8pc2jHqR++179mXPM3FUWmzlhBxZVUZ
 B0EE+vnfhx33fm08/1x1Wb6FRQkIhdoEZwmQxwaqDEX+FbgucCT4L3kkVzQRhUEsRV0LogkaIq
 Wi+gjRcoFeReo1INchOiVMVZG60UuqK0gc0ElgYR0EZsaEXwu1FtB5UKdhKhj4M4kxxV60HeBF
 25k1osAaZbOa0Rb2KbZCFjYprkJwEPUDWDMBYR/CIRk1NahUqaWxsmCgVuDCsZyl2AUofcOBLi
 /xvV6/QG0geHqUwMAAA==
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
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773386021; l=4854;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=bwdkh3U0py07YJ4k5KES5ZDIHas3hmYsAk9jQ0VOEvQ=;
 b=Xl5KhIZlc2NvKM83WjmJFwyvvTSHkTlOobMAL1xT1rbl/rG54SSFepNHWjPbHu5LNHf0SOalY
 bzxOl5qriZbALKutEULmlw2evjRFW1jCKio9HACkGYHZahf9SFDOOJ+
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267304-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:replyto,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 75E0327EA6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v12:
- rebased on net-next
- Link to v11: https://lore.kernel.org/r/20260312-dwmac_multi_irq-v11-0-09621ccb040b@oss.nxp.com

Changes in v11:
- Dropped not benefical patch 1 with FOREACH_MTL_QUEUE macro
- Link to v10: https://lore.kernel.org/r/20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com

Changes in v10:
- Fixed yaml issue
- Link to v9: https://lore.kernel.org/r/20260311-dwmac_multi_irq-v9-0-f0c03ef8d01f@oss.nxp.com

Changes in v9:
- Changed interrupt minItems from 11 to 1 to support backward compatibility
  and removed the 'Reviewed-by' accordingly for patch 4
- Link to v8: https://lore.kernel.org/r/20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com

Changes in v8:
- Rewritten queue irq getter, based on Russell's (ready-to-use) hint
- Renamed s32_gmac_validate_multi_irq() to s32_gmac_setup_multi_irq() to
  better describe the functionality
- Fixed typo in commit message for patch 5
- Renamed label in patch 5 to make it more descriptive
- Link to v7: https://lore.kernel.org/r/20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com

Changes in v7:
- Optimized 2 similar loops on queue rx/tx irq reading
- Swap the yaml and dts patches with hope it fix dt_binding_check failing
- Link to v6: https://lore.kernel.org/r/20260225-dwmac_multi_irq-v6-0-245bf1d7110c@oss.nxp.com

Changes in v6:
- Added 2 mintainers which were not covered by 'b4 prep --auto-to-cc'
  but complained on patchwork check
- Added helper macro for loop over queue-based arrays (inspired by AI
  review)
- Added full validation on all channel IRQs
- Link to v5: https://lore.kernel.org/r/20260223-dwmac_multi_irq-v5-0-8fc699a5fac4@oss.nxp.com

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
      arm64: dts: s32: set Ethernet channel irqs
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      stmmac: s32: enable support for Multi-IRQ mode

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 47 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/s32g2.dtsi           | 26 ++++++++--
 arch/arm64/boot/dts/freescale/s32g3.dtsi           | 26 ++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 36 +++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 57 +++++++++++++++++++++-
 5 files changed, 179 insertions(+), 13 deletions(-)
---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20251209-dwmac_multi_irq-9d8f60462cc1

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



