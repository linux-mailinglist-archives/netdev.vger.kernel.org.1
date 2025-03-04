Return-Path: <netdev+bounces-171539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CFA4D6F1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84C43AAD92
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBA1FAC59;
	Tue,  4 Mar 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNeax/tl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273281FA164
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078247; cv=none; b=fcUaHB+jpbyBE63hFh/8vGSEd4RVpCdG4CFTWjx4nzNDQEv5Ji9eznV2ScdmfsHdGLVkCbbRxEDIemB15xLclotMiTpZeRiRrPqmkgAvGiBDwWJrI5xJNG/MopCZgGnV9T7n04NvMjaiN30v7NJk3RZNlGBE2Bb2s6lZG9wrB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078247; c=relaxed/simple;
	bh=kkHSMzZ1ZcS1cudL1bP14kHyWFdsefXdMRo3MFkzg1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CaXYy4oSdT11drroyRfqXeX/leR2b2i9Xl0atGUsXczZP3QBYYgmZelB5tr3UTev3rPSt6SHQPHlcXacRMum+jL5ISOHwOyBdqUStmT9zjxKTI7ptVoMzbXFJHXtyhDGLEYe/kk6dABTJ7BILNRdMm3R2fOx5kA4/txMdqWTzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNeax/tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78631C4CEE5;
	Tue,  4 Mar 2025 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741078247;
	bh=kkHSMzZ1ZcS1cudL1bP14kHyWFdsefXdMRo3MFkzg1U=;
	h=From:Date:Subject:To:Cc:From;
	b=lNeax/tl/orxOms3UbNSo41u7p1ypGGS4KOLfO7ul8s8r11P7fDCSD3SgLx7NOTtd
	 6IBHKVVRlGC6MV/19/6Qa0Qf6qXVGIfBq8f18qEEDO3uhqhwebkCEvdVXLS1EUryJp
	 vuZh/1V0qjRin55p2NxW9iS4GJyZLApNGFJFZU/h59J1WH/U9O93RO6ivh+8AmhVSj
	 NiGUw6o+vlqJ0Nj8CfWH7bfRIPJ64gGtWSyg6ydG8ucvzQqHoZxApaitCBm/t+8z+k
	 5/5TbDF/eXkYyNd48AVQutDqGQCJeipVL/rTE5hMMpXHTzH9nax0i4F3dd+3VW+4ke
	 hgE3UaHjq60GQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 09:50:23 +0100
Subject: [PATCH net] net: dsa: mt7530: Fix traffic flooding for MMIO
 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mt7988-flooding-fix-v1-1-905523ae83e9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM6+xmcC/x2MSQqAMAwAvyI5G4hbXb4iHqRNNaCttCKC+HeLx
 xmYeSByEI4wZA8EviSKdwmKPAO9zm5hFJMYSiobqqjG/Wz7rkO7eW/ELWjlRm0sa6VmUjVBKo/
 ASf/XcXrfD/KhVsRlAAAA
X-Change-ID: 20250304-mt7988-flooding-fix-cdfec66a0640
To: "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

On MMIO devices (e.g. MT7988 or EN7581) unicast traffic received on lanX
port is flooded on all other user ports if the DSA switch is configured
without VLAN support since PORT_MATRIX in PCR regs contains all user
ports. Similar to MDIO devices (e.g. MT7530 and MT7531) fix the issue
defining default VLAN-ID 0 for MT7530 MMIO devices.

Fixes: 110c18bfed414 ("net: dsa: mt7530: introduce driver for MT7988 built-in switch")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/dsa/mt7530.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1c83af805209cae40c56138fa8f72261e396f58c..5883eb93efb11423bec260a11ff8b60cfff1fd2c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2591,7 +2591,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	/* Setup VLAN ID 0 for VLAN-unaware bridges */
+	return mt7530_setup_vlan0(priv);
 }
 
 static int
@@ -2687,11 +2688,6 @@ mt7531_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Setup VLAN ID 0 for VLAN-unaware bridges */
-	ret = mt7530_setup_vlan0(priv);
-	if (ret)
-		return ret;
-
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 

---
base-commit: 64e6a754d33d31aa844b3ee66fb93ac84ca1565e
change-id: 20250304-mt7988-flooding-fix-cdfec66a0640

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


