Return-Path: <netdev+bounces-141119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24689B9A04
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F9E2820AF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162241E2828;
	Fri,  1 Nov 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HMCGKJ1h"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937DD1547DC;
	Fri,  1 Nov 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495892; cv=none; b=sMLEENyeflBre1FwD+jCDOOXMwljpi136MYG0KWuZPoxCz2cc6Wk6auxioBXJoZMJLgNNK3aXE/kF0G5sWNO1MwA2qcJdrQqwQHVuAJG0qOahHxyByXYWbUnLUnfKI8HM5isZjL8WGHMfTUVQ6eJf/NexYrgwwYbecnZ8/Bw6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495892; c=relaxed/simple;
	bh=66Ei27eT+JrfjmeRi9X6QMMDpHjXuetf/JuMi8MPyQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=psN0t3iAU+1IMFaaD++qA+IhhuTJsCud2ebKDPnOVIvZr0gP44Oj2ukujtGhy/84pHmTINVflwx0G82TTWNLUEifGdW9gQv6Y9IV35p9KYgwvIrPI0LLycrRwCVXj7oyqLynL6GqA2uKPuWBJVonaz+xx0wnOp03+/bjjLvhYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HMCGKJ1h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730495886;
	bh=66Ei27eT+JrfjmeRi9X6QMMDpHjXuetf/JuMi8MPyQE=;
	h=From:Date:Subject:To:Cc:From;
	b=HMCGKJ1haZqHGDbHpHOmcQo1NoHvtFO+fE66drSQMSf6rIi7bf8m/mmsTsAuwNXmj
	 xMdvU4bJxCe+CNJZvWbv8xvu/gW0cN0dUWpavk8NKpBzIrn3iD+WKMYAkJNeWlnjkt
	 zvUnIo/WDBC4cjSHLjmMNs6QVoSTEZ524W0XcTuPysprng3MJOYAGnD/fgUwG4SHSj
	 0MWywKJP+T0YfqwQ+0golLziJkgrcSmSBMTfUIpZ0N6BHIRJkE0sCbg0cqExtm0+04
	 7YO5NXMaT4hhF/N/g67qZlzNtrhlIUqmEFFPVhHEGx74hrkKfKU+ExBVtSduu/7YXB
	 lQOYDmIDywC7w==
Received: from [192.168.1.230] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF7FD17E0F9B;
	Fri,  1 Nov 2024 22:18:03 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 01 Nov 2024 17:17:29 -0400
Subject: [PATCH] net: stmmac: Fix unbalanced IRQ wake disable warning on
 single irq case
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-stmmac-unbalanced-wake-single-fix-v1-1-5952524c97f0@collabora.com>
X-B4-Tracking: v=1; b=H4sIAGhFJWcC/x2NsQ7CMAwFf6XyjKWmqRj4FcTgJI9i0RoUU0Cq+
 u9EjHfD3UaOqnA6dRtVvNX1YQ3CoaN8E5vAWhrT0A9jCH1gfy2LZF4tySyWUfgjd7CrTTP4ql+
 ORVKMo6QjErXOs6Lp/+N82fcfkBbL9XMAAAA=
X-Change-ID: 20241101-stmmac-unbalanced-wake-single-fix-3dab334ab6eb
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Simon Horman <horms@kernel.org>, Qiang Ma <maqianga@uniontech.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Commit a23aa0404218 ("net: stmmac: ethtool: Fixed calltrace caused by
unbalanced disable_irq_wake calls") introduced checks to prevent
unbalanced enable and disable IRQ wake calls. However it only
initialized the auxiliary variable on one of the paths,
stmmac_request_irq_multi_msi(), missing the other,
stmmac_request_irq_single().

Add the same initialization on stmmac_request_irq_single() to prevent
"Unbalanced IRQ <x> wake disable" warnings from being printed the first
time disable_irq_wake() is called on platforms that run on that code
path.

Fixes: a23aa0404218 ("net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 208dbc68aaf9d4a650f167a76d1ef223d5eb6aec..7bf275f127c9d750418db8b4fdb6e650a53dc644 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3780,6 +3780,7 @@ static int stmmac_request_irq_single(struct net_device *dev)
 	/* Request the Wake IRQ in case of another line
 	 * is used for WoL
 	 */
+	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
 		ret = request_irq(priv->wol_irq, stmmac_interrupt,
 				  IRQF_SHARED, dev->name, dev);

---
base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
change-id: 20241101-stmmac-unbalanced-wake-single-fix-3dab334ab6eb

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


