Return-Path: <netdev+bounces-233350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4BEC1230B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06DF94FA849
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A3214A97;
	Tue, 28 Oct 2025 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyLj3jlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090E221F34
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611960; cv=none; b=YTkTzI8lA+GutJ/RLHkkrLbOWwX8OrrsBrx4f8bBNsNHrsyZc4lc2+mfbiyjSyDzIk/IqdCs7LIcJTAhzqMY2idqepWJ2MAi+HB9jI9gYz+PfTtfqKYhvVoNAdEbQUxyZ9fjz6uETmQwstNGaULNFDiU1/Vo902lN6Eyb3UWEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611960; c=relaxed/simple;
	bh=P2La+FoJZ35MJzEo8yVcVLSFzhQhJljTmUai3XD3wr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYtIAiK+lhq+k308RIZ8SFzULwlJZBA9s0k0DuwTyMKSJW+NlUp61SIsIDimHOmgUTTT8Z+0HDvR3OCcoT5TV6vcDpbfO2KDTWpEdX8dOsLYbeZ0AvswILNktbi87kIL5PseJSxVgVLUu1F9B0S3nvRyBt0SqrW7NMM/mL3a1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyLj3jlO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29470bc80ceso58873275ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611958; x=1762216758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=kyLj3jlOXnyy+JK+pViciZ6OEQLzjc5aQXaTggD/u7s/4upxNm1YBBkEDpel0IUENC
         CsqKfBdlsIpvCNI7oklzKeImxuWjcB+TK9k8c8rl5VZpeZZNyiLtVIf/8MI8NYRqz7Rl
         fp/eL0lDfXXydXlsaM94g2XGwWgxmiWMSlJcLAdhKoR+4MvUVwwbhTMOqTDX4wmB3w8m
         GPgB0vp5hX3swmXuyonnYnvVsfXLyNxLM4ptt+L5+ukorSARSDoSySZ1Wbc+DAasiHaC
         QNStNfszdjt3bfrsynGehySUs4gUQE89JPNAm78p6MGar6FCXDNpWzSC/p+uPOvjE6/N
         eyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611958; x=1762216758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=B3dNMCC2MP8RqRNgYxMWrGm8dbqOVViPkX02XTH8qCYbDwUn76zvvJVAvjoJbNqsIg
         5j4SH2DkC0vtoGddxxS0fnKQaj+A6zJp6eb25fJtxvEHdJ4rpFBggUq/zvEhj9YicZkB
         7EbdNgQLs+hI9egfyv5rw8GkEiJEGTKbNcvHCfULDVCdWXBJ1TXBqS7gyZS86GQxo86p
         /8d74a+9JkBlgxHv/a73ruG6itmtvIgGCR2XfNtViIJNmasXSqG8Wxd/PET06y6SRDfG
         ZquGhmWK2CQfjWY46CRDRmZxhCaN6KQG3U030iF8r47w20uokFce++fi7p+ecvLo0NTF
         WYJg==
X-Gm-Message-State: AOJu0YxVqokfLiWSv0lWCn9cs4MMsReUEj9MrpLvr6+UzeKVO4tT3buO
	ipUzx0ahL4lK0udQUGxyTdHrATG6T5uQG7kxklrsIKUc4tG0akuQ8e28ShPEjItL
X-Gm-Gg: ASbGncvOuY0s4YfDyndJIjlRtbSHdJNj0ClLN3HKk65Af1SARA+d8J+CJ6q9DsrNImN
	AVm7+Gz6qy9kHlQOC69+PN6qs5kvjfupfejSplUjaaG5+LTx9WWlTPLdS+8ON7HagxlWCxYNNCP
	vUUKwjZoRAWgx+9hsfzoTuZpliRiSJgPbHmovIE7aDbVA9+UkuvAfsK0fKD718ejUjUcQV7jB+S
	g3F0KY/0VSDQYRZHdGddHyNwgm8h4P98oUFFZunuoFfcJF79lW4vCpKF2s9+ITSV8AoF5Per/Dm
	sFFTOrzRfKEJGTDXESwj99XY0WzYDxzl6WTZK+SrOA12e5JQ7MLVkop5f77s6mW/ZwnU5RhhFZV
	i8Yr70iZ+IRGOh2V3u0snHxYz4rNSUhEoCWwOkViDu6aqaVOhQOJwLVqM9Kw2K9g60Yf9lVCIop
	b50Pcp/cB5hw==
X-Google-Smtp-Source: AGHT+IGvU4zqUoctToOTJAwyDs9+4diulCuRP+v5NnW7F2ld07v4djcWl4rSSI6JXslPZV+bpZFdZA==
X-Received: by 2002:a17:902:ea0a:b0:271:fa2d:534c with SMTP id d9443c01a7336-294cc74e4dfmr14030645ad.22.1761611956679;
        Mon, 27 Oct 2025 17:39:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm94917065ad.15.2025.10.27.17.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:16 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Tue, 28 Oct 2025 08:38:58 +0800
Message-ID: <20251028003858.267040-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028003858.267040-1-inochiama@gmail.com>
References: <20251028003858.267040-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..7f0ca4249a13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,11 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "stmmac_platform.h"
 
+struct sophgo_dwmac_data {
+	bool has_internal_rx_delay;
+};
+
 static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 				    struct plat_stmmacenet_data *plat_dat,
 				    struct stmmac_resources *stmmac_res)
@@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sophgo_dwmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay) {
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return -EINVAL;
+	}
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
+static struct sophgo_dwmac_data sg2042_dwmac_data = {
+	.has_internal_rx_delay = true,
+};
+
 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
-- 
2.51.1


