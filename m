Return-Path: <netdev+bounces-28240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9EE77EB55
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804061C21250
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2B1DA37;
	Wed, 16 Aug 2023 21:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD41DA22
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1ECC433B8;
	Wed, 16 Aug 2023 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219670;
	bh=CySDSdfDw7w2Tbb5PpQvc1Q/b8XW42jtSNH4pyxFN+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaWATlvbxbbUt8c5pdID030fG4h37h/Olg/xUYhocpQXnCV4b0KoNytXxTzyKeZZ6
	 ZP4mXop8ipw8O4bjqk4+WxDz4v6Qf+OP06yZNJkbG+JeP6RnPBkOmUfIcrwXuc0Taf
	 xjrwVIclLEEU8j0xoB+XruKp5siXW6WGAKF/fSgOPZ/MblFLLmzNFpUXx8W6TiK0qc
	 7a2TjOHpVx6TblCMiKfDMXnDQqnfZbWE8eOMKR9719VJ4Q7T+YwJJV5jwMsqpcqR+j
	 kh59FUKjOmrNdt/DUFgXbc3RfTnYonl8p+qnku8b4ffZ2f/qOUoKd+B1+/W8CX7QPK
	 wHPUPdumvvFZg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [net-next 14/15] net/mlx5: Convert PCI error values to generic errnos
Date: Wed, 16 Aug 2023 14:00:48 -0700
Message-ID: <20230816210049.54733-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
errnos.

Convert the PCI specific error values to generic errno using
pcibios_err_to_errno() before returning them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index e87766f91150..f69d9bdf898a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -398,7 +398,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	err = mlx5_check_dev_ids(dev, dev_id);
 	if (err)
 		return err;
@@ -413,16 +413,16 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	/* PCI link toggle */
 	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	reg16 |= PCI_EXP_LNKCTL_LD;
 	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	msleep(500);
 	reg16 &= ~PCI_EXP_LNKCTL_LD;
 	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	/* Check link */
 	if (!bridge->link_active_reporting) {
@@ -435,7 +435,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(bridge, cap + PCI_EXP_LNKSTA, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 & PCI_EXP_LNKSTA_DLLLA)
 			break;
 		msleep(20);
@@ -453,7 +453,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 == dev_id)
 			break;
 		msleep(20);
-- 
2.41.0


