Return-Path: <netdev+bounces-242880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCDC95A03
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1500A3418FC
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7619E97F;
	Mon,  1 Dec 2025 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eLum1Sys"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA221885A5
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557833; cv=none; b=SCocefmPrH2XcXGJ2UTbsaDuH2MsTXMYOVRXMZ4bOdj+YIVyHyAYGNUvGiTR+FcVIhay2hD0qfTAVWfmD1bEl77tGnaLeqEXbTpx3NmVvHjIbySzBi4UW5zWTvsosmY6Pbdq7RHFhOC1aeMUxXgCMQzkeaYtlL+JeYPBy4eHfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557833; c=relaxed/simple;
	bh=tbe1UpgQWOX4QJj3OSyk2spATTcO63b4zAdneq5D1n8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=EQjixURlcZ038COHyEvcNiL8ILrVLu4i88PiMgJ+54rhug9QscKLD/ZgYx4HecS7IZJmSyGtGspGGtEaXSSh9U9+TEl7FnOkeia64PSLmUujZPPukpmue4KnnpsB6G6kpKG0hyPJTbO2U2mp+DvRcjN0MRNLBxq/Z/6RPsNOTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eLum1Sys; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764557825; bh=9HG5vIZeG6DjcNDNCfRzCXn+GiaKTQ413V1uAk2ip2E=;
	h=From:To:Cc:Subject:Date;
	b=eLum1SysUyevzkZNTmmEMOovuTPPzDfFc5UZ90E08r2Of1AmBaMYCwSSHeVxjDhqF
	 DRRhGxBwAYrGtOqJmPkm7eiwgW0ZXW7ZpYAK+CX96xnMpLIKwiM1hA40fvYwsnxQ1V
	 ng0B9ZhlW1Z2F3K4vzb9U/FrYa8x8+7jlzPUfxnQ=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E4322249; Mon, 01 Dec 2025 10:57:03 +0800
X-QQ-mid: xmsmtpt1764557823tgzuvzj06
Message-ID: <tencent_22959DC8315158E23D77C14B9B33C97EA60A@qq.com>
X-QQ-XMAILINFO: Na23fxG1dahlIHagbvu0S9yGh7KvCtlJ+jcO/sOXy3vdAOPN2yFS719FrteZgF
	 L9diDzWuXJWqZExU1tGfwGTKoKbsQPd96/dhd0X3ALf6++rAzohULa9kz10xikHQGUm6Zpp66kWv
	 EndmwTpJ8176XDKHY1VAOHYbrUfwparkH+uDFkbXszQ/mGkfGX6OwaOolMEeOQbfZdEo6nUdXERA
	 qgfyqsGWSOePTr0hKC9QobH5+OhwOjqqpCoDKKhLZ6bdqdQnbit7pe13ow92TD0b5RBcsn28o8eE
	 2yBClEfCtCYb1acj+6km3ATA4kvFqOZrmhY918y0MjHCcfWJpz3QNw4rN7AQ4Snovfxruj/pMU0f
	 9Z1T2Nxo4L20WvWv7R9Tyqw+vtbJO8/Ok0MP/ZpZJACbt0pO4lZjGfipAmEGt2vzw9SDEX3v9ZVg
	 /99UFmu9HuQGV9kmVdZSxQ/Nc1CijR4geosETVN37f8SjA0Pg+fBEvkCuU2nfZLLtV8THT6RMs8/
	 N5nBmKRq9W/2jeCANQ4GgmW6XtHxSlcKEiPJNZzDELEBU/v679NxGXtlG6GN/PXbuZxDD7hw02VA
	 f6Y/VPu2sVpBQrwsXQTwy1FH8rxbbCYbXgQO/InaNpsIVECYkCFtPcbUhEJJc9yhVcI52We3KR21
	 cwYL3gyXWs5Z3i1X10ykvfajeF3xQrVXbwE/DVvy18DuiONWy54hx9SREU6piKdV7gTEfpbVUqwm
	 JaRNBXmM4hKyz0nNlSzU2vBnh+Fyxke/VJrjd03Zbm6T9SLasLq9mLkRKL0sQJYmOCLBfJARz3Bk
	 pWKaI43RIDyXVY3QX1vlACYHKwRDm+rCP0EtVrJixx+m2VuwAq/NrPSbXC0ZAjPn6xrQBWphlfXP
	 +PfxuWaq7ShJwjhnXYBIWq9SjEoWpEC4TxjzDKj2gFASzfya1n3jPu7nzjyhs4csv+LFVEg8Ygs0
	 BOJVKB9qmkGx5qRg2CZSisgMNL9p72YCL/YV3jp5n3k71Rr6ArCHz8aa/NPUC8znOV2Ie8OlFPVS
	 Y82Q+woOejaL6Bcw4h
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: 2694439648@qq.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hailong.fan@siengine.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Modify the judgment condition of "tx_avail" from 1 to 2
Date: Mon,  1 Dec 2025 10:57:01 +0800
X-OQ-MSGID: <20251201025701.16345-1-2694439648@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "hailong.fan" <hailong.fan@siengine.com>

    Under certain conditions, a WARN_ON will be triggered
    if avail equals 1.

    For example, when a VLAN packet is to send,
    stmmac_vlan_insert consumes one unit of space,
    and the data itself consumes another.
    actually requiring 2 units of space in total.

Signed-off-by: hailong.fan <hailong.fan@siengine.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a..b575384cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4529,7 +4529,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
+	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 2)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
 								queue));
-- 
2.34.1


