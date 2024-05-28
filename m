Return-Path: <netdev+bounces-98670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71F8D204E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3591C22BF0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026D16F260;
	Tue, 28 May 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnWFw6U0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1890D1E507;
	Tue, 28 May 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909934; cv=none; b=JqciKMx+LbN4tESplFZHvpErHh4L3jC7/7GtU+vT1gU5bqY1q+C/gWbHrjmOQmWDvCRX12X+tdBAoR8Xj1zSj7/gD9OF/LL0OO/o61bd7AfGlQ1R3T9qy+H0xSu9ko+/A/aHfnFqw8UMrfAoW4wirJQaWL7g+7fSdRNlKzRxLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909934; c=relaxed/simple;
	bh=rV0FQQkoN6OTfyaN7zr8uhjf73DI7J/djMv8xhRNln8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ny0H32COgkYQY5fV7PiTv671d9jzwBiQs0aPLPy0sGygDGqOTNjDUs2zkkRUnb0Qe5qaxniikRXhVWiT8Smj6pqjePlPvPAMkkMg3BkdWXBtQKaO7kx4tZ62qK/y3acmysUgTbfFRLm0x8SHupOpj0pg++ZwT3viYfqfrqmABJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnWFw6U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B0AC3277B;
	Tue, 28 May 2024 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716909933;
	bh=rV0FQQkoN6OTfyaN7zr8uhjf73DI7J/djMv8xhRNln8=;
	h=From:To:Cc:Subject:Date:From;
	b=RnWFw6U0WV/NV7iDJUiO6eBWhe0qig7B7ILDW0iK7MoBBMxioQ2cHEnauXhbqID4Z
	 3IrtKOvjlYGRyLH0q9056W4dNAwIDRlqgR1Ys6eI5A5b9Jsq41Rm8p6eH1LyWpeVYn
	 MxluOtPorgwryg15U/muYS46kU1nzCX/xVsxcpMFzHsvt2zXo529g81LAIl4sQxzUb
	 HKP+4NT1IOB32fnM7HJ0PJJGkA47d667+8+UuyA3psLx+NaDDhJ7OoXIT265Twqx8l
	 1waphiJmjw6uuEBYcWKvNuh4fB6rA24MQv8ntOgOpIjTosXlU+YU48TtYaYbt0+7Pw
	 LhAssghVg+uvQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Suman Ghosh <sumang@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: octeontx2: avoid linking objects into multiple modules
Date: Tue, 28 May 2024 17:25:05 +0200
Message-Id: <20240528152527.2148092-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Each object file contains information about which module it gets linked
into, so linking the same file into multiple modules now causes a warning:

scripts/Makefile.build:254: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf

Change the way that octeontx2 ethernet is built by moving the common
file into a separate module with exported symbols instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../net/ethernet/marvell/octeontx2/nic/Makefile    | 14 ++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    | 11 +++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |  6 ++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 5664f768cb0c..e4c5dc46dd42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -3,16 +3,18 @@
 # Makefile for Marvell's RVU Ethernet device drivers
 #
 
-obj-$(CONFIG_OCTEONTX2_PF) += rvu_nicpf.o otx2_ptp.o
-obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
+obj-$(CONFIG_OCTEONTX2_PF) += rvu_nicpf.o otx2_ptp.o otx2_devlink.o
+obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o otx2_devlink.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o
-rvu_nicvf-y := otx2_vf.o otx2_devlink.o
+               qos_sq.o qos.o
+rvu_nicvf-y := otx2_vf.o
 
-rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
-rvu_nicvf-$(CONFIG_DCB) += otx2_dcbnl.o
+ifdef CONFIG_DCB
+obj-$(CONFIG_OCTEONTX2_PF) += otx2_dcbnl.o
+obj-$(CONFIG_OCTEONTX2_VF) += otx2_dcbnl.o
+endif
 rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 28fb643d2917..0d7e611d9a05 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -54,6 +54,7 @@ int otx2_pfc_txschq_config(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(otx2_pfc_txschq_config);
 
 static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -122,6 +123,7 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(otx2_pfc_txschq_alloc);
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
@@ -260,6 +262,7 @@ int otx2_pfc_txschq_update(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(otx2_pfc_txschq_update);
 
 int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 {
@@ -282,6 +285,7 @@ int otx2_pfc_txschq_stop(struct otx2_nic *pfvf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(otx2_pfc_txschq_stop);
 
 int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 {
@@ -321,6 +325,7 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(otx2_config_priority_flow_ctrl);
 
 void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			       bool pfc_enable)
@@ -385,6 +390,7 @@ void otx2_update_bpid_in_rqctx(struct otx2_nic *pfvf, int vlan_prio, int qidx,
 			 "Updating BPIDs in CQ and Aura contexts of RQ%d failed with err %d\n",
 			 qidx, err);
 }
+EXPORT_SYMBOL_GPL(otx2_update_bpid_in_rqctx);
 
 static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
@@ -472,3 +478,8 @@ int otx2_dcbnl_set_ops(struct net_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(otx2_dcbnl_set_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell RVU dcbnl");
+MODULE_AUTHOR("Sunil Goutham <sgoutham@marvell.com>");
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 99ddf31269d9..440f574d1195 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -113,6 +113,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
 	devlink_free(dl);
 	return err;
 }
+EXPORT_SYMBOL_GPL(otx2_register_dl);
 
 void otx2_unregister_dl(struct otx2_nic *pfvf)
 {
@@ -124,3 +125,8 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
 				  ARRAY_SIZE(otx2_dl_params));
 	devlink_free(dl);
 }
+EXPORT_SYMBOL_GPL(otx2_unregister_dl);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell RVU PF/VF Netdev Devlink");
+MODULE_AUTHOR("Sunil Goutham <sgoutham@marvell.com>");
-- 
2.39.2


