Return-Path: <netdev+bounces-126672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6989722F8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530E5B228F9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394E189B97;
	Mon,  9 Sep 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZTAc49N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF05189903
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911136; cv=none; b=nZKQ0IhiXADCQk6/tTJYI21xlfT/qdMN5jz7kHPxDy246b4zUmwjKFwA6+g56JsKXkZVoK9o7yo/N6Nlf830Ggk6hpQtC3IOMyYfM1I2yfkiw6VMczK2rppmKQxjsZn5tLQsQeeGnt1oKwRpzyKlGFQRG8T20qRxFhwO3daVYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911136; c=relaxed/simple;
	bh=940Ke2OEcilTBElrUVpc2V2sdch3evVqcaAppj1rznc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UftwOAzrO1QH3C/pP1m3OKjgO90Jd8pC2RDcjdOI1tvUzD3ym6NufBN/GXp8BQ5a6qoGJ/ByUsxyFf22ej05EjelVeazEagoR2Ivs6sav3LWdROM1/eTeTzqg8sINCXPJbm1yFOPbQbgvcBuyY41fDgjIdkztTDOHWTt2QFravA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZTAc49N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FA4C4CEC8;
	Mon,  9 Sep 2024 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911135;
	bh=940Ke2OEcilTBElrUVpc2V2sdch3evVqcaAppj1rznc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZTAc49Np1OodPlJDc5crcdRLJK2LLVoc4IpX08nObB9WLOGf0PlhznPVNaLwnzUt
	 YMoT0ffaQ4Lk5Nx0T1sD4mhk+WuPahS6HKZRmzxCIgSEYQnjGD/RzX6hsou/tgnUMG
	 7kULc7KEA25f14OUOcqiNh6mOdWgv53KMTVjhx6GDt5TSbET6toUkvhW6zi/HaN6hA
	 MaoohoHf2hqDxBuTbYbz3S/jTnih/05njHEmfT6JnOC1UGzovEQah2HNr3Hhigba5q
	 6P4pTjExSFvMCfkky2Hhnpy4On+akTIFXXbmHsvUyRYl2QJNflV7yB4UUyNl1ROsvz
	 Xe7CMdy2q8K1w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [net 1/7] net/mlx5: Update the list of the PCI supported devices
Date: Mon,  9 Sep 2024 12:44:59 -0700
Message-ID: <20240909194505.69715-2-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Add the upcoming ConnectX-9 device ID to the table of supported
PCI device IDs.

Fixes: f908a35b2218 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5b7e6f4b5c7e..2ec33c4a2a3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2217,6 +2217,7 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x101f) },			/* ConnectX-6 LX */
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
+	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
-- 
2.46.0


