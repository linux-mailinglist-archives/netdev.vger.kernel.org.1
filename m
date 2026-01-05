Return-Path: <netdev+bounces-247090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A13CF46D7
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A8F3041A49
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AE33ADB8;
	Mon,  5 Jan 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nqSIBpme"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7C33AD8D;
	Mon,  5 Jan 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626710; cv=none; b=Q9eomvPZ7iKSM4Ff0GRIjQzU7SaiAs5mHBiYX91c8zirHMLJbzqT/3jIG1jg2JWNO0hlUh5xncrXFe9YUl5xBItecgCQIPH0v0tEqaBvahlCrt9655huL/BiMg/DdU8mWCO7Uv8Wt7KgM6mAPg11UrDo7AfXr3z592lBVd5Q4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626710; c=relaxed/simple;
	bh=df+vpKVNbG7uoYXdXK9POjV75vqryJ2sQJL/8ZwMSpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXYj+n9yXXUSpGtVl2aS+OkfZn7p4x2zZBt1CELAQzZ5oL1FzjvylNkFhKnzvuT8w8wDp/qtpHpKb3oWDeK7A+M0u4uWSgftiuf7FbB2GUYnCTYUtBbV+yrj03XfzG4Ji+AAEMCs0cQb/qO4Ek7Q+8e3eI8jTKXdn1Cw7JZ/mbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nqSIBpme; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 9836521F9A;
	Mon,  5 Jan 2026 16:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1767626697;
	bh=IEZCdhEXupf8wrgZv5DH2P9cDiJf0VfvZ1g5XE5O7go=; h=From:To:Subject;
	b=nqSIBpmeS9HC9XMfbQH2cMU4CvIcd/UDBZuxGFh7W7fZKFtda+bi2UwJIPgnAS3Ln
	 UOfsdy9zqj5CTc9w4Tyc2B1s1BhjZGJ+/eYwGiTSRWn7B71oiDCf9cG7BcLnQFPi8r
	 Dd0nT2ht5hKcQYUwvCs2O5gTi8WEdJjlE2wuYTJRN7WWtzQfAF/G81xVpPLy6rF/Qa
	 sJkHAw92aGHU1Y/ochLJrvQYpoSypWnxP8TCcS0NfWl8aFn9Ks96mgjzL+o4AqgwL+
	 ra67E2LEN22JVlX8defrbrl+hcl0PakPT4ondkw+Ipry5YRl6YbpSrtZXB6h4Q4OPC
	 DOinL2GO7gY/Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: fec: Add stop mode support on i.MX8DX/i.MX8QP
Date: Mon,  5 Jan 2026 16:24:50 +0100
Message-ID: <20260105152452.84338-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add additional machines that requires communication to the SC firmware
to set the GPR bit required for stop mode support.

NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
(fsl,imx8qm).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fix i.MX8QM compatible in the commit message
v1: https://lore.kernel.org/all/20251223163328.139734-1-francesco@dolcini.it/
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c685a5c0cc51..2eacc35e0b8a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1334,7 +1334,9 @@ fec_restart(struct net_device *ndev)
 static int fec_enet_ipc_handle_init(struct fec_enet_private *fep)
 {
 	if (!(of_machine_is_compatible("fsl,imx8qm") ||
+	      of_machine_is_compatible("fsl,imx8qp") ||
 	      of_machine_is_compatible("fsl,imx8qxp") ||
+	      of_machine_is_compatible("fsl,imx8dx") ||
 	      of_machine_is_compatible("fsl,imx8dxl")))
 		return 0;
 
-- 
2.47.3


