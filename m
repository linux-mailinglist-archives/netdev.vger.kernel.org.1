Return-Path: <netdev+bounces-198596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E1ADCD2E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB7C1887F5B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620C28BAB1;
	Tue, 17 Jun 2025 13:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61428ECE8
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166734; cv=none; b=WYvCnxthFPeTXMt9gpFIWgJ+SgfW4qpqgZo+XZh9g7KZ+Yaoz5OnbRkj4l6q1ll8BADCGEH4OCvTcSHAOdgmebQjQa6jPPFfTT1SVLLYqP2oRE0eIstW/XVTNtunzVUlancy/UJHpKBejPEF6M9UI5NATztXpe4tcnbWP09Nx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166734; c=relaxed/simple;
	bh=2DChwJFYikH/07jGw7d3t5KjvqkP/EqHG30EfbD5ef0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cQD9i2yrIAagAB+U4jNGgqj/kWll8o95smAOi83i8FUHWb8wWKm+2bmQbiGyKNGwUH1tvz+7U/fOQ74ZIN1838tz+PIF/g7dgyr+UFApZsC6Nf0vhVHOSxP1Y+wmmassZQwQ6kBqRcaQ2ltbxDoYHEvFNYmq7RgVEABgjjoie+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 7331B66ECEF
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 40A0242A7F2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2A31542A79E;
	Tue, 17 Jun 2025 13:25:21 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5d19cc46;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next v3 00/10] net: fec: general + VLAN cleanups
Date: Tue, 17 Jun 2025 15:24:50 +0200
Message-Id: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKJsUWgC/2XNQQ6DIBQE0KsY1qUBBNSueo+mC4SvkjRoAImN8
 e6lJF20XU4m82ZHAbyFgC7VjjwkG+zscqhPFdKTciNga3JGjDBOOibwABrrByi3LgHrrheC816
 3gqM8WTwMdivcDTmI2MEW0T03kw1x9s/yk2jp3yQlVH6TiWKCDTRt3RsqQKrrAm5co5+d3c4Gi
 pbYRxBEUvYjsCwoaHQtzUBbAX/CcRwvJPezA/kAAAA=
X-Change-ID: 20240925-fec-cleanups-c9b5544bc854
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=2DChwJFYikH/07jGw7d3t5KjvqkP/EqHG30EfbD5ef0=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUWyrOA3Zy0e+kLu6+SzkZZmo+ILuiWnblGw3i
 Sd0UZ8MFpmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFFsqwAKCRAMdGXf+ZCR
 nA5nCACqKEEwBR+FtBxoXQrmJKfHeduIAEadklduJFKdqKDR+55S0e8caeI5xjHklNDUIRHPyjk
 IX8O3T1xYs+e+z0YAPfWS7yuzb14hDE80IxEw1laOpNyQmQK5kCvszLtp6A5tNHrZtNb8C5Hzyu
 XUDqbRm3KSmHaMlaxP7pHHpRgQUIkjXSHy5tmgB8jF/PrC14hrEyrTR4X2N2ovEU5MJafjhmWdT
 EM/xpeEsylNJUygq9a9gtznZpeJJR4+d4qNuo3jn/8LiMgaOETzCob+bRuTiCT6VOpriOthWSm7
 PvWkKIeII3q3o3SvV+ltFbqI13iqBwmqNrGaUrpJWfSba5g1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This series first cleans up the fec driver a bit (typos, obsolete
comments, add missing header files, rename struct, replace magic
number by defines).

The last 5 patches clean up the fec_enet_rx_queue() function,
including VLAN handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- update cover letter and subject
- 1: fix another typo (thanks Bence Csókás)
- 7: clarify patch description (thanks Andrew Lunn)
- collected Wei Fang's, Bence Csókás's and Andrew Lunn's Reviewed-by
- Link to v2: https://patch.msgid.link/20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de

Changes in v2:
- removed patches 7, 8 for now
- rebased to recent net-next/main:
  dropped patch 6
- 2, 3: wrap patch description at 75 chars:
  (thanks Frank Li)
- 4, 5, 6, 7, 9: updated wording of patch description
  (thanks Frank Li)
- 10: move VLAN_header into the if statement (thanks Wei Fang)
- 10: mark several variables const
- collected Wei Fang's and Frank Li's Reviewed-by
- Link to v1: https://patch.msgid.link/20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de

---
Marc Kleine-Budde (10):
      net: fec: fix typos found by codespell
      net: fec: struct fec_enet_private: remove obsolete comment
      net: fec: add missing header files
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
      net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
      net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
      net: fec: fec_enet_rx_queue(): replace manual VLAN header calculation with skb_vlan_eth_hdr()
      net: fec: fec_enet_rx_queue(): reduce scope of data
      net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
      net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()

 drivers/net/ethernet/freescale/fec.h         | 11 +++---
 drivers/net/ethernet/freescale/fec_main.c    | 56 ++++++++++++++--------------
 drivers/net/ethernet/freescale/fec_mpc52xx.c |  2 +-
 drivers/net/ethernet/freescale/fec_ptp.c     |  4 +-
 4 files changed, 36 insertions(+), 37 deletions(-)
---
base-commit: 170e4e3944aa39accf64d869b27c187f8c08abc7
change-id: 20240925-fec-cleanups-c9b5544bc854

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



