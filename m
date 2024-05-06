Return-Path: <netdev+bounces-93688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C08BCBFF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD89AB226A2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968514264C;
	Mon,  6 May 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02xXyv63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3743AA5
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991299; cv=none; b=C0nggcS23Qrn9/wOld/XVYCc/rLXlLIldIN4tn/8w7dN/hI7QIidxazOmWNbf122kyCENUfm/pASCGYiNpIVtEQiyGJSBXn+EBbcSjjjOpijhG3ADr7UUvBWFRbtzbx+zqrdO1flYmAkehbJ45pJgRt1jQtI48a5OPcsf1q2L3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991299; c=relaxed/simple;
	bh=G+T4+yqEvOFqFTupuZDMTiXmACO0EP36lYaFi8w4J5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d+RPwev1slNgTpbyG3PNUFKRuXbAJBYlUpY8CSEloJnkCMLkl3rN/Z3MrXPQFO6oqqagMSIss8XfQUnoryFzlHMrD7uTXcpWMCjG1fJtTdDGGJMlzKfTryR+HyR0lOeDVbt60VJHj88IrDUD9mx7/nQv++MZTLadccPdpesEyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02xXyv63; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de57643041bso3073219276.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714991294; x=1715596094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TGxNcSWuBwIHEct8DUiRz+yZmhz7YOBOhfYrZ9gyaLk=;
        b=02xXyv638SPaGWgajar9swZMURVrBcugsmtX1Ks0jkd18/7qj7H9JX+85SLJAJqJrx
         bKCBUVvvqaelJl2ME7GqRcPVDx4ViOn1VrApn1gcxXthq6qWTJkdNOOlIIvf7zRl1y2d
         tL2AJH30jQAzeHi5AMWZrYl+FApgIacpWqHRCgpfF4J/3ymyvihoSqe6l+74AvA7gPYo
         sG396tiMJuHxhZgMjTrxvA4o4OdnCFxm2BQuAL3wxKnqYxnaCO69bmLxzSDFfVbYNAMI
         krS4bsTdDiQzNcKDM0iDuNFaxy9rEmK0D2WvLLRMlecA9HTmDLagc/+MXFTZMBPDSPEz
         uOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714991294; x=1715596094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGxNcSWuBwIHEct8DUiRz+yZmhz7YOBOhfYrZ9gyaLk=;
        b=nxQ3dghZrNjH7MaBRD4HTiLZhVDeffXzn5Skbfyv0J4hKP5GjXEzVNJ+WLVp48k1l1
         Iw0BYjeBF/v5OFDVko6+r/az59dFGcBvfhh4LQE9h1jLksGg58F4FZkGmGQIbtl1OaJe
         UXn+eX/LO8x1/OxTxLXdhyJV2WvkFBdIiiaqvJHNuj7bwI4UMkAAoVveDMV7BZR2EXzX
         Mp84/tbEnu0Fc3xcOSOOCn8deGqODjrQxA1ryLtJR9pHM4tsMWzj6Dfg2b+2MV9bc4SG
         P6ZL737iUQ6+jCeMMc5XLqnTbOkIaJehddQ6KjzaLzeDXgvoDungEDZsYU70RA8JTO/X
         ePbw==
X-Gm-Message-State: AOJu0YwcZxjKy18NamYNEvVWIJ4CPxGyZaTOP0p6+kbimPQDxS5tIwXD
	xQMP7EA8f4P0axYDn2YYZ6O/hWvSbQzlHde9mBGcYvwg9T6cAHLt4Z0C7zn2G629vbciIrkklpV
	ijjoP6xXJDw==
X-Google-Smtp-Source: AGHT+IF4mvAEuD6QXpoDAdNSieUj8mMH9tH7l2xHMT60GJVOXt9TEH8iQZzMM4x2yXljEb7uFd4CDnVpVbN9Ww==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:de4:7be7:1c2d with SMTP
 id w4-20020a056902100400b00de47be71c2dmr3393771ybt.11.1714991294499; Mon, 06
 May 2024 03:28:14 -0700 (PDT)
Date: Mon,  6 May 2024 10:28:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506102812.3025432-1-edumazet@google.com>
Subject: [PATCH net-next] net: annotate writes on dev->mtu from ndo_change_mtu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Simon reported that ndo_change_mtu() methods were never
updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
in commit 501a90c94510 ("inet: protect against too small
mtu values.")

We read dev->mtu without holding RTNL in many places,
with READ_ONCE() annotations.

It is time to take care of ndo_change_mtu() methods
to use corresponding WRITE_ONCE()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20240505144608.GB67882@kernel.org/
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c                 | 4 ++--
 drivers/net/bonding/bond_main.c                           | 2 +-
 drivers/net/can/dev/dev.c                                 | 2 +-
 drivers/net/can/vcan.c                                    | 2 +-
 drivers/net/can/vxcan.c                                   | 2 +-
 drivers/net/ethernet/agere/et131x.c                       | 2 +-
 drivers/net/ethernet/alteon/acenic.c                      | 2 +-
 drivers/net/ethernet/altera/altera_tse_main.c             | 2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c              | 2 +-
 drivers/net/ethernet/amd/amd8111e.c                       | 6 +++---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                  | 2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c          | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c          | 2 +-
 drivers/net/ethernet/atheros/ag71xx.c                     | 2 +-
 drivers/net/ethernet/atheros/alx/main.c                   | 2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c           | 2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c           | 2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c                  | 2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c                  | 2 +-
 drivers/net/ethernet/broadcom/b44.c                       | 4 ++--
 drivers/net/ethernet/broadcom/bcm63xx_enet.c              | 2 +-
 drivers/net/ethernet/broadcom/bnx2.c                      | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c           | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 | 2 +-
 drivers/net/ethernet/broadcom/tg3.c                       | 2 +-
 drivers/net/ethernet/brocade/bna/bnad.c                   | 2 +-
 drivers/net/ethernet/cadence/macb_main.c                  | 2 +-
 drivers/net/ethernet/calxeda/xgmac.c                      | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c           | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c         | 2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c          | 2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c          | 2 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c                 | 2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c           | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c           | 2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c       | 2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c               | 2 +-
 drivers/net/ethernet/cortina/gemini.c                     | 2 +-
 drivers/net/ethernet/dlink/sundance.c                     | 2 +-
 drivers/net/ethernet/faraday/ftmac100.c                   | 2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c            | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c          | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c       | 2 +-
 drivers/net/ethernet/freescale/gianfar.c                  | 2 +-
 drivers/net/ethernet/fungible/funeth/funeth_main.c        | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c             | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           | 2 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c            | 2 +-
 drivers/net/ethernet/ibm/emac/core.c                      | 4 ++--
 drivers/net/ethernet/ibm/ibmveth.c                        | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c             | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c                | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c               | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c               | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                 | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c                | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c                 | 2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c                 | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c                 | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c             | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c         | 2 +-
 drivers/net/ethernet/jme.c                                | 2 +-
 drivers/net/ethernet/lantiq_etop.c                        | 2 +-
 drivers/net/ethernet/lantiq_xrx200.c                      | 4 ++--
 drivers/net/ethernet/marvell/mv643xx_eth.c                | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                     | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c           | 2 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c       | 2 +-
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c      | 2 +-
 drivers/net/ethernet/marvell/prestera/prestera_main.c     | 2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c                 | 2 +-
 drivers/net/ethernet/marvell/skge.c                       | 4 ++--
 drivers/net/ethernet/marvell/sky2.c                       | 4 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c               | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c            | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c     | 2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c    | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c            | 2 +-
 drivers/net/ethernet/micrel/ksz884x.c                     | 2 +-
 drivers/net/ethernet/microchip/lan743x_main.c             | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c     | 2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c             | 4 ++--
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c          | 8 ++++----
 drivers/net/ethernet/natsemi/natsemi.c                    | 2 +-
 drivers/net/ethernet/neterion/s2io.c                      | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c       | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c         | 2 +-
 drivers/net/ethernet/ni/nixge.c                           | 2 +-
 drivers/net/ethernet/nvidia/forcedeth.c                   | 2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c      | 2 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c                  | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c           | 4 ++--
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c        | 2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c           | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c            | 2 +-
 drivers/net/ethernet/qualcomm/emac/emac.c                 | 2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c           | 2 +-
 drivers/net/ethernet/realtek/8139cp.c                     | 4 ++--
 drivers/net/ethernet/realtek/r8169_main.c                 | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c                  | 2 +-
 drivers/net/ethernet/renesas/sh_eth.c                     | 2 +-
 drivers/net/ethernet/rocker/rocker_main.c                 | 2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c           | 2 +-
 drivers/net/ethernet/sfc/efx_common.c                     | 2 +-
 drivers/net/ethernet/sfc/falcon/efx.c                     | 2 +-
 drivers/net/ethernet/sfc/siena/efx_common.c               | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c         | 2 +-
 drivers/net/ethernet/sun/cassini.c                        | 2 +-
 drivers/net/ethernet/sun/niu.c                            | 2 +-
 drivers/net/ethernet/sun/sungem.c                         | 2 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c            | 2 +-
 drivers/net/ethernet/tehuti/tehuti.c                      | 2 +-
 drivers/net/ethernet/via/via-velocity.c                   | 4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                | 2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c         | 2 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c                  | 2 +-
 drivers/net/fjes/fjes_main.c                              | 2 +-
 drivers/net/geneve.c                                      | 2 +-
 drivers/net/hyperv/netvsc_drv.c                           | 4 ++--
 drivers/net/macsec.c                                      | 2 +-
 drivers/net/macvlan.c                                     | 2 +-
 drivers/net/net_failover.c                                | 2 +-
 drivers/net/netdevsim/netdev.c                            | 2 +-
 drivers/net/ntb_netdev.c                                  | 4 ++--
 drivers/net/slip/slip.c                                   | 2 +-
 drivers/net/team/team_core.c                              | 2 +-
 drivers/net/usb/aqc111.c                                  | 2 +-
 drivers/net/usb/asix_devices.c                            | 2 +-
 drivers/net/usb/ax88179_178a.c                            | 2 +-
 drivers/net/usb/cdc_ncm.c                                 | 2 +-
 drivers/net/usb/lan78xx.c                                 | 2 +-
 drivers/net/usb/r8152.c                                   | 4 ++--
 drivers/net/usb/usbnet.c                                  | 2 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                         | 2 +-
 drivers/net/vsockmon.c                                    | 2 +-
 drivers/net/vxlan/vxlan_core.c                            | 2 +-
 drivers/net/xen-netback/interface.c                       | 2 +-
 drivers/net/xen-netfront.c                                | 2 +-
 drivers/s390/net/ctcm_main.c                              | 2 +-
 net/8021q/vlan_dev.c                                      | 2 +-
 net/batman-adv/soft-interface.c                           | 2 +-
 net/bridge/br_device.c                                    | 2 +-
 net/dsa/user.c                                            | 2 +-
 net/hsr/hsr_device.c                                      | 2 +-
 net/hsr/hsr_main.c                                        | 2 +-
 net/ipv4/ip_gre.c                                         | 2 +-
 net/ipv4/ip_tunnel.c                                      | 4 ++--
 net/ipv6/ip6_tunnel.c                                     | 2 +-
 net/ipv6/ip6_vti.c                                        | 3 ++-
 net/sched/sch_teql.c                                      | 2 +-
 153 files changed, 174 insertions(+), 173 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 6f2a688fccbfb02ae7bdf3d55cca0e77fa9b56b4..32f6a28b02b1e15730f7c334c5bc19f646c198f0 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -238,7 +238,7 @@ static int ipoib_change_mtu(struct net_device *dev, int new_mtu)
 			ipoib_warn(priv, "mtu > %d will cause multicast packet drops.\n",
 				   priv->mcast_mtu);
 
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		return 0;
 	}
 
@@ -265,7 +265,7 @@ static int ipoib_change_mtu(struct net_device *dev, int new_mtu)
 		if (carrier_status)
 			netif_carrier_on(dev);
 	} else {
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 	}
 
 	return ret;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b3a7d60c3a5ca60be1d9eed184ec1dad593a182b..3b0c7758ea4f4a06f847bbff32655a6dd0a605bb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4710,7 +4710,7 @@ static int bond_change_mtu(struct net_device *bond_dev, int new_mtu)
 		}
 	}
 
-	bond_dev->mtu = new_mtu;
+	WRITE_ONCE(bond_dev->mtu, new_mtu);
 
 	return 0;
 
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3a3be5cdfc1f8da5c98017e1e5dd92f4591d85f9..83e724e0ab871c91e3460bfcab55595ea2f62f4a 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -338,7 +338,7 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 285635c234432ba92fb5d7233426c35ab799942e..f67e858071007acd5f34fa00a76212f1a77997a6 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -140,7 +140,7 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index f7fabba707ea640cab8863e63bb19294e333ba2c..9e1b7d41005f8de12854b865bbad34a20877cbc7 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -135,7 +135,7 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
 	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 3d9220f9c9fe74310edf08c5f258bbecbc9cd1fd..b325e0cef120fd3126af96aeabdf214767a5f726 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -3852,7 +3852,7 @@ static int et131x_change_mtu(struct net_device *netdev, int new_mtu)
 
 	et131x_disable_txrx(netdev);
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	et131x_adapter_memory_free(adapter);
 
diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index eafef84fe3be5f747fc6b5a31bce3fec23f929be..3d8ac63132fb2158e9fbc966ed875e3852d0c40f 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -2539,7 +2539,7 @@ static int ace_change_mtu(struct net_device *dev, int new_mtu)
 	struct ace_regs __iomem *regs = ap->regs;
 
 	writel(new_mtu + ETH_HLEN + 4, &regs->IfMtu);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (new_mtu > ACE_STD_MTU) {
 		if (!(ap->jumbo)) {
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 1c8763be0e4b37027d66c4284396909de1f8fbb8..3c112c18ae6ae028eb78be2f715d5be07ee510e8 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -788,7 +788,7 @@ static int tse_change_mtu(struct net_device *dev, int new_mtu)
 		return -EBUSY;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	netdev_update_features(dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index be5acfa41ee0ce4d80605e0bcdc6dc743c421f42..28eaedaf713d5a997486b909c8af137e1e0c0f36 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -104,7 +104,7 @@ static int ena_change_mtu(struct net_device *dev, int new_mtu)
 	if (!ret) {
 		netif_dbg(adapter, drv, dev, "Set MTU to %d\n", new_mtu);
 		update_rx_ring_mtu(adapter, new_mtu);
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 	} else {
 		netif_err(adapter, drv, dev, "Failed to set MTU to %d\n",
 			  new_mtu);
diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index c1b5e9a94308cf6c36168a255d0f776baf4d6f6b..f64f96fa17cfebf5867b203a0608e540288e66a8 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -1520,9 +1520,9 @@ static int amd8111e_change_mtu(struct net_device *dev, int new_mtu)
 
 	if (!netif_running(dev)) {
 		/* new_mtu will be used
-		 * when device starts netxt time
+		 * when device starts next time
 		 */
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		return 0;
 	}
 
@@ -1531,7 +1531,7 @@ static int amd8111e_change_mtu(struct net_device *dev, int new_mtu)
 	/* stop the chip */
 	writel(RUN, lp->mmio + CMD0);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	err = amd8111e_restart(dev);
 	spin_unlock_irq(&lp->lock);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 6b73648b3779368f8a01cbc95f8afb88bc07786d..c4a4e316683fa854168f260e70cdafed73321ece 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2070,7 +2070,7 @@ static int xgbe_change_mtu(struct net_device *netdev, int mtu)
 		return ret;
 
 	pdata->rx_buf_size = ret;
-	netdev->mtu = mtu;
+	WRITE_ONCE(netdev->mtu, mtu);
 
 	xgbe_restart_dev(pdata);
 
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 44900026d11b5d22602af09889f445385560ad70..4af9d89d5f88b111339e4d62a02ea26b8afe945f 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1530,7 +1530,7 @@ static int xgene_change_mtu(struct net_device *ndev, int new_mtu)
 	frame_size = (new_mtu > ETH_DATA_LEN) ? (new_mtu + 18) : 0x600;
 
 	xgene_enet_close(ndev);
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 	pdata->mac_ops->set_framesize(pdata, frame_size);
 	xgene_enet_open(ndev);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 0b2a52199914b718d6091b53a9494e3466cc5786..c1d1673c5749d6c53ee1779702a37e1bb8664f2f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -146,7 +146,7 @@ static int aq_ndev_change_mtu(struct net_device *ndev, int new_mtu)
 
 	if (err < 0)
 		goto err_exit;
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 err_exit:
 	return err;
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 0f2f400b5bc490b728bc3641dbbefc2727c690b9..a38be924cdaa0dd6864ba7afdb207a4196638be0 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1788,7 +1788,7 @@ static int ag71xx_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ag71xx *ag = netdev_priv(ndev);
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 	ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
 		  ag71xx_max_frame_len(ndev->mtu));
 
diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 49bb9a8f00e64f5ce23acf4a26f044e7aa205751..3d28654e5df77c2c1fdc776b4dc2061df50626b6 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1176,7 +1176,7 @@ static int alx_change_mtu(struct net_device *netdev, int mtu)
 	struct alx_priv *alx = netdev_priv(netdev);
 	int max_frame = ALX_MAX_FRAME_LEN(mtu);
 
-	netdev->mtu = mtu;
+	WRITE_ONCE(netdev->mtu, mtu);
 	alx->hw.mtu = mtu;
 	alx->rxbuf_size = max(max_frame, ALX_DEF_RXBUF_SIZE);
 	netdev_update_features(netdev);
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 46cdc32b4e317dcac59e6f121fdcbcfdd08e3daa..c571614b1d50193cf355d93f1e5c8a7445591fce 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -561,7 +561,7 @@ static int atl1c_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev)) {
 		while (test_and_set_bit(__AT_RESETTING, &adapter->flags))
 			msleep(1);
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		adapter->hw.max_frame_size = new_mtu;
 		atl1c_set_rxbufsize(adapter, netdev);
 		atl1c_down(adapter);
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 5f2a6fcba96708958f75b9575e8c02950dce7586..9b778b34b67ef96baaebdbd311573a2df820df70 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -428,7 +428,7 @@ static int atl1e_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev)) {
 		while (test_and_set_bit(__AT_RESETTING, &adapter->flags))
 			msleep(1);
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		adapter->hw.max_frame_size = new_mtu;
 		adapter->hw.rx_jumbo_th = (max_frame + 7) >> 3;
 		atl1e_down(adapter);
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index a9014d7932dbf1e5f32171d9a6bdef04683059bc..3afd3627ce485bd1eb3e2d7f7597a11bd668c402 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2687,7 +2687,7 @@ static int atl1_change_mtu(struct net_device *netdev, int new_mtu)
 	adapter->rx_buffer_len = (max_frame + 7) & ~7;
 	adapter->hw.rx_jumbo_th = adapter->rx_buffer_len / 8;
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	if (netif_running(netdev)) {
 		atl1_down(adapter);
 		atl1_up(adapter);
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index bcfc9488125b15c1dc11ec251584a9490364faa9..fa9a4919f25d41df419c3c43eb71410cca9b4122 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -905,7 +905,7 @@ static int atl2_change_mtu(struct net_device *netdev, int new_mtu)
 	struct atl2_hw *hw = &adapter->hw;
 
 	/* set MTU */
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	hw->max_frame_size = new_mtu;
 	ATL2_WRITE_REG(hw, REG_MTU, new_mtu + ETH_HLEN +
 		       VLAN_HLEN + ETH_FCS_LEN);
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 1be6d14030bcffc0fd149b6be0af819964284a4e..e5809ad5eb8272ceb28d7efaf7cd477cdd679244 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1042,13 +1042,13 @@ static int b44_change_mtu(struct net_device *dev, int new_mtu)
 		/* We'll just catch it later when the
 		 * device is up'd.
 		 */
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		return 0;
 	}
 
 	spin_lock_irq(&bp->lock);
 	b44_halt(bp);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	b44_init_rings(bp);
 	b44_init_hw(bp, B44_FULL_RESET);
 	spin_unlock_irq(&bp->lock);
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 3196c4dea076953923be817e5ee83f89009b52a9..3c0e3b9828be9f7bbf77b63cac1013a128ba586d 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1652,7 +1652,7 @@ static int bcm_enet_change_mtu(struct net_device *dev, int new_mtu)
 	priv->rx_frag_size = SKB_DATA_ALIGN(priv->rx_buf_offset + priv->rx_buf_size) +
 					    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index b65b8592ad759b9ab3133f0d806a7d268f48c7ed..6ec773e61182d264b466153f85d735e5a2d83b03 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -7912,7 +7912,7 @@ bnx2_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct bnx2 *bp = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return bnx2_change_ring_size(bp, bp->rx_ring_size, bp->tx_ring_size,
 				     false);
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index c9b6acd8c892d8f39fafffdf908c510b19aaa51c..a8e07e51418fd9f4bb8e2e162c08c49267efed57 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4902,7 +4902,7 @@ int bnx2x_change_mtu(struct net_device *dev, int new_mtu)
 	 * because the actual alloc size is
 	 * only updated as part of load
 	 */
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (!bnx2x_mtu_allows_gro(new_mtu))
 		dev->features &= ~NETIF_F_GRO_HW;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0d1ed6e5dfbd286499c0d74cf571e2d77fbe767b..c437ca1c0fd3996ad6447de5dd7747b0e16bf978 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14280,7 +14280,7 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6ff3c9bd7e5007de2f5df880a033d500525841e..1589a49b876c96132f57704b2aed3980c6fbac21 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14295,7 +14295,7 @@ static void tg3_set_rx_mode(struct net_device *dev)
 static inline void tg3_set_mtu(struct net_device *dev, struct tg3 *tp,
 			       int new_mtu)
 {
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (new_mtu > ETH_DATA_LEN) {
 		if (tg3_flag(tp, 5780_CLASS)) {
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index c32174484a967ae4cf49f6025bf0892333d1fd89..fe121d36112d5bcdb7f450be2622d174bf8b1ebe 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3276,7 +3276,7 @@ bnad_change_mtu(struct net_device *netdev, int new_mtu)
 	mutex_lock(&bnad->conf_mutex);
 
 	mtu = netdev->mtu;
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	frame = BNAD_FRAME_SIZE(mtu);
 	new_frame = BNAD_FRAME_SIZE(new_mtu);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db36ac7792cef5db9e5436ea348c320..241ce9a2fa9916eaadf1596d9f8e79ef17d128c3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3022,7 +3022,7 @@ static int macb_change_mtu(struct net_device *dev, int new_mtu)
 	if (netif_running(dev))
 		return -EBUSY;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index 5e97f1e4e38e8fa4d74a92587832ecd5afafb779..a71b320fd0308b2a956e5f32d15a4a7262a92ce2 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1358,7 +1358,7 @@ static int xgmac_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* Bring interface down, change mtu and bring interface back up */
 	xgmac_stop(dev);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return xgmac_open(dev);
 }
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index f38d31bfab1bbcecafacaa4adf2e1ee67bd332b6..674c548318750e50f2b95f78c6d52556c4bc54ed 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -1262,7 +1262,7 @@ int liquidio_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	lio->mtu = new_mtu;
 
 	WRITE_ONCE(sc->caller_is_done, true);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index aa6c0dfb6f1ca2d607210a3e5d2f1666fd18f4e9..96c6ea12279f8b1956c7256bc01f6c83bf0ab1a5 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -218,7 +218,7 @@ lio_vf_rep_change_mtu(struct net_device *ndev, int new_mtu)
 		return -EIO;
 	}
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 007d4b06819ef2290ecaafc3bd2cf151a7a75ae0..744f2434f7fa54eca97a472725577fa3819e37b4 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -649,7 +649,7 @@ static int octeon_mgmt_change_mtu(struct net_device *netdev, int new_mtu)
 	struct octeon_mgmt *p = netdev_priv(netdev);
 	int max_packet = new_mtu + ETH_HLEN + ETH_FCS_LEN;
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	/* HW lifts the limit if the frame is VLAN tagged
 	 * (+4 bytes per each tag, up to two tags)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index eff350e0bc2a8ec7d1f3584028d21762afecfe3d..aebb9fef3f6eb1ff78ae5478ec670e1000a7eb63 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1589,7 +1589,7 @@ static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (!netif_running(netdev))
 		return 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index d2286adf09fed53aea21534179a1f4cfce421a09..7d7d3e0098df2e3114e8c8cc5ecb02b8327f4755 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -844,7 +844,7 @@ static int t1_change_mtu(struct net_device *dev, int new_mtu)
 		return -EOPNOTSUPP;
 	if ((ret = mac->ops->set_mtu(mac, new_mtu)))
 		return ret;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2236f1d35f2b81189580a53303cb4b0bb630bc48..f92a3550e48000fa4f7ecc573d047db58e8321e1 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2559,7 +2559,7 @@ static int cxgb_change_mtu(struct net_device *dev, int new_mtu)
 
 	if ((ret = t3_mac_set_mtu(&pi->mac, new_mtu)))
 		return ret;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	init_port_mtus(adapter);
 	if (adapter->params.rev == 0 && offload_running(adapter))
 		t3_load_mtus(adapter, adapter->params.mtus,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2eb33a727bba3b6e6db281c4db508f5b46df4a9c..2418645c882373624aca0fb84d9a9bdad1047804 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3180,7 +3180,7 @@ static int cxgb_change_mtu(struct net_device *dev, int new_mtu)
 	ret = t4_set_rxmode(pi->adapter, pi->adapter->mbox, pi->viid,
 			    pi->viid_mirror, new_mtu, -1, -1, -1, -1, true);
 	if (!ret)
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 9ba0864592e850dfea58cba44c2c5182fc9a8145..2fbe0f059a0bffffe36324c859c46d639c6766f4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1169,7 +1169,7 @@ static int cxgb4vf_change_mtu(struct net_device *dev, int new_mtu)
 	ret = t4vf_set_rxmode(pi->adapter, pi->viid, new_mtu,
 			      -1, -1, -1, -1, true);
 	if (!ret)
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d266a87297a5e3a5281acda9243a024fc2f7d742..f604119efc8098d511258679e48bbcc633611cba 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2027,7 +2027,7 @@ static int _enic_change_mtu(struct net_device *netdev, int new_mtu)
 			return err;
 	}
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (running) {
 		err = enic_open(netdev);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 705c3eb19cd3f4a9af06b0e795e832a080ccac1b..2f98f644b9d7b5e48c4983dd2450a8c10fe04008 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1978,7 +1978,7 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
 
 	gmac_disable_tx_rx(netdev);
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	gmac_update_config0_reg(netdev, max_len << CONFIG0_MAXLEN_SHIFT,
 				CONFIG0_MAXLEN_MASK);
 
diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index aaf0eda96292221190fd52988724468c4f6788bf..8af5ecec7d6147cce04c6d0d9953c7c986d899e1 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -708,7 +708,7 @@ static int change_mtu(struct net_device *dev, int new_mtu)
 {
 	if (netif_running(dev))
 		return -EBUSY;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 003bc9a45c6597fdf2d299e966120ffa80fa8307..1047c805054eaebecc48dfd91ceba57a37b1e61a 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -1092,7 +1092,7 @@ static int ftmac100_change_mtu(struct net_device *netdev, int mtu)
 	}
 	iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
 
-	netdev->mtu = mtu;
+	WRITE_ONCE(netdev->mtu, mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6c836a0e2596548bd611d1c0fc945..baa0b3c2ce6ff8840afa4e7b8f23509187ae5de2 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2995,7 +2995,7 @@ static int dpaa_change_mtu(struct net_device *net_dev, int new_mtu)
 	if (priv->xdp_prog && !xdp_validate_mtu(priv, new_mtu))
 		return -EINVAL;
 
-	net_dev->mtu = new_mtu;
+	WRITE_ONCE(net_dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 40e8818295951988e24eaceca78e6fa8116c793a..6866807973daa1b68f846bd9cd53274135a51223 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2698,7 +2698,7 @@ static int dpaa2_eth_change_mtu(struct net_device *dev, int new_mtu)
 		return err;
 
 out:
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index f3543a2df68d542e8ee5df950e8927ae8d500489..a71f848adc0545f25e6bada7b274d0d7affbe66c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -590,7 +590,7 @@ static int dpaa2_switch_port_change_mtu(struct net_device *netdev, int mtu)
 		return err;
 	}
 
-	netdev->mtu = mtu;
+	WRITE_ONCE(netdev->mtu, mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index a811238c018deedb812e23390d785006f1ed2268..2baef59f741dda43c27e382de7395dc9a5e485e9 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2026,7 +2026,7 @@ static int gfar_change_mtu(struct net_device *dev, int new_mtu)
 	if (dev->flags & IFF_UP)
 		stop_gfar(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (dev->flags & IFF_UP)
 		startup_gfar(dev);
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_main.c b/drivers/net/ethernet/fungible/funeth/funeth_main.c
index df86770731ad5207eac12579c19e6d1aa98cf6e5..ac86179a0a817b4c3af4aae225d1e9863da1dcbd 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_main.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_main.c
@@ -927,7 +927,7 @@ static int fun_change_mtu(struct net_device *netdev, int new_mtu)
 
 	rc = fun_port_write_cmd(fp, FUN_ADMIN_PORT_KEY_MTU, new_mtu);
 	if (!rc)
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 8a713eed446582f87916c71586a19542dec79252..fd32e15cadcb413bc96534a88c8514304e2bffed 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1777,7 +1777,7 @@ static int hns_nic_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* finally, set new mtu to netdevice */
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 out:
 	if (if_running) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 19668a8d22f76ac06259b18c27177bc2f1c7405e..dfdc0e032c078b2d93c53c8ea5ffed10d1085e3f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2761,7 +2761,7 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 		netdev_err(netdev, "failed to change MTU in hardware %d\n",
 			   ret);
 	else
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 499c657d37a96e7a5666dc8d8aa24d1734cd0859..890f213da8d18000ccfc27fe5dbccf0fdcde090d 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -581,7 +581,7 @@ static int hinic_change_mtu(struct net_device *netdev, int new_mtu)
 	if (err)
 		netif_err(nic_dev, drv, netdev, "Failed to set port mtu\n");
 	else
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index e6e47b1842ea71dfc7d51f0cc8d46e058b1a9797..a19d098f2e2bf9ad0ea028eb2974a4114d9552ae 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1098,7 +1098,7 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 		/* This is to prevent starting RX channel in emac_rx_enable() */
 		set_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags);
 
-		dev->ndev->mtu = new_mtu;
+		WRITE_ONCE(dev->ndev->mtu, new_mtu);
 		emac_full_tx_reset(dev);
 	}
 
@@ -1130,7 +1130,7 @@ static int emac_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	if (!ret) {
-		ndev->mtu = new_mtu;
+		WRITE_ONCE(ndev->mtu, new_mtu);
 		dev->rx_skb_size = emac_rx_skb_size(new_mtu);
 		dev->rx_sync_size = emac_rx_sync_size(new_mtu);
 	}
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b5aef0b29efea9a76e0798520b1fa415c83fe0ab..4c9d9badd69867b51579b4186d514d4eca1bc229 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1537,7 +1537,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 		adapter->rx_buff_pool[i].active = 1;
 
 		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
-			dev->mtu = new_mtu;
+			WRITE_ONCE(dev->mtu, new_mtu);
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
 						(viodev));
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 5b43f9b194fc2e658fc80cafd784207a29ed97cd..60fff9a6c53e3e5e4ca280bcb77a536e22e11897 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3569,7 +3569,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		e1000_up(adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index bef65ee4c549a5c7256667dd5e5150994c118eaa..220d62fca55d1b2ba405003773f79396a9dcdb42 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6038,7 +6038,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	adapter->max_frame_size = max_frame;
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	pm_runtime_get_sync(netdev->dev.parent);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2cc7bec0557b31b9984c5206c203a484961add7c..143e37ae88efdc30814615a79a489fe8d5b7ebf0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2961,7 +2961,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	if (netif_running(netdev))
 		i40e_vsi_reinit_locked(vsi);
 	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d4f4fd6a100168577764592fe406ad2e4bb679df..d4699c4c535d431f3690eabb22439e88763d95f7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4296,7 +4296,7 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev)) {
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 06549dae4cca6fd17c17e6e7629712af5da90ed4..125c53c51898439cbf5a7734019599532784bbf2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7770,7 +7770,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EBUSY;
 	}
 
-	netdev->mtu = (unsigned int)new_mtu;
+	WRITE_ONCE(netdev->mtu, (unsigned int)new_mtu);
 	err = ice_down_up(vsi);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d3532c27d57f9d49175dd8bf24ae95aae8b2584..52ceda6306a3d0317044234f6798fe0f6c8e5f83 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2234,7 +2234,7 @@ static int idpf_change_mtu(struct net_device *netdev, int new_mtu)
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	err = idpf_initiate_soft_reset(vport, IDPF_SR_MTU_CHANGE);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 74a998fcaa6f3b9f6b067d73d0189f774c4069c7..7d9389040e404b76dec40e8d7e080752868052b5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6641,7 +6641,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		igb_up(adapter);
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 40ccd24ffc5395fc079312a9f446340cb95adb00..7661edd7d0f2c721ccfc6c7e4f9a563a3875aedd 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2434,7 +2434,7 @@ static int igbvf_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		igbvf_up(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 34c257a51ed1ff9215b02eb6b9f0b1e2068f296b..c30f0f5726007057c97f1b2809c0d806b3d509c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5275,7 +5275,7 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
 		igc_down(adapter);
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n", netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		igc_up(adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 43e7e75ae18c0ae082fdfd6afc2983ee89371084..094653e81b97aee6f5b9ce7ff24c6b5f0dfd27dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6847,7 +6847,7 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 		   netdev->mtu, new_mtu);
 
 	/* must set new MTU before calling down or up */
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3161a13079fe65f09d336bca49ccc5d3e6bd9ec7..b938dc06045d0028c16342a7f4f00c10ad659445 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4292,7 +4292,7 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	       netdev->mtu, new_mtu);
 
 	/* must set new MTU before calling down or up */
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		ixgbevf_reinit_locked(adapter);
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 1732ec3c3dbdc4767a6e48296f9219f588f9e643..b06e245629739f6f16005a51e181ce057d3e8857 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -2301,7 +2301,7 @@ jme_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct jme_adapter *jme = netdev_priv(netdev);
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	netdev_update_features(netdev);
 
 	jme_restart_rx_engine(jme);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 1d5b7bb6380f9cf689fd49bc06b8d71744e2c731..5352fee62d2b8f1db58996bd01041c570e8e3d0c 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -519,7 +519,7 @@ ltq_etop_change_mtu(struct net_device *dev, int new_mtu)
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	unsigned long flags;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	spin_lock_irqsave(&priv->lock, flags);
 	ltq_etop_w32((ETOP_PLEN_UNDER << 16) | new_mtu, LTQ_ETOP_IGPLEN);
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index 8bd4def3622e16d4b4e0b47155609d030ed0dc74..07904a528f21513153f16fab695caa7647ca8dd0 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -419,7 +419,7 @@ xrx200_change_mtu(struct net_device *net_dev, int new_mtu)
 	int curr_desc;
 	int ret = 0;
 
-	net_dev->mtu = new_mtu;
+	WRITE_ONCE(net_dev->mtu, new_mtu);
 	priv->rx_buf_size = xrx200_buffer_size(new_mtu);
 	priv->rx_skb_size = xrx200_skb_size(priv->rx_buf_size);
 
@@ -440,7 +440,7 @@ xrx200_change_mtu(struct net_device *net_dev, int new_mtu)
 		buff = ch_rx->rx_buff[ch_rx->dma.desc];
 		ret = xrx200_alloc_buf(ch_rx, netdev_alloc_frag);
 		if (ret) {
-			net_dev->mtu = old_mtu;
+			WRITE_ONCE(net_dev->mtu, old_mtu);
 			priv->rx_buf_size = xrx200_buffer_size(old_mtu);
 			priv->rx_skb_size = xrx200_skb_size(priv->rx_buf_size);
 			break;
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f0bdc06d253d5b9a1f40f502b9843e0f4b743a83..f35ae2c88091d54442f6fa18fce69cf77a61a794 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2562,7 +2562,7 @@ static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct mv643xx_eth_private *mp = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	mv643xx_eth_recalc_skb_size(mp);
 	tx_set_rate(mp, 1000000000, 16777216);
 
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 26bf5d47ba0276cab5de0fcff5aae847e9b67e00..41894834fb53c59bbce674771d3feef6fc11c565 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3861,7 +3861,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		return -EINVAL;
 	}
 
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 
 	if (!netif_running(dev)) {
 		if (pp->bm_priv)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 19253a0fb4fef8b6e6e316231fab8ecc93b1f11c..e91486c48de382b3b99b6e9ab29cb7632247543a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1375,7 +1375,7 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 	}
 
 out_set:
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	dev->wanted_features = dev->features;
 
 	netdev_update_features(dev);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 7c9faa714a10a93d95aa3b1167601a9c8aacfa0f..549436efc20488a3ab2d0ae978ba498d050ffbbf 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1096,7 +1096,7 @@ static int octep_change_mtu(struct net_device *netdev, int new_mtu)
 				     true);
 	if (!err) {
 		oct->link_info.mtu = new_mtu;
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	}
 
 	return err;
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index dd49d0b8b49491020124efb4f63ad872aa95c5e6..7e6771c9cdbbab7c9c847cb38d013e5315ca0b02 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -881,7 +881,7 @@ static int octep_vf_change_mtu(struct net_device *netdev, int new_mtu)
 	err = octep_vf_mbox_set_mtu(oct, new_mtu);
 	if (!err) {
 		oct->link_info.mtu = new_mtu;
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	}
 	return err;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6a44dacff508d307dfa707654cf083a8238f8c19..8eecd9f26550e2e9d3d631d7e854bc0b0230353a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -67,7 +67,7 @@ static int otx2_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_info(netdev, "Changing MTU from %d to %d\n",
 		    netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (if_up)
 		err = otx2_open(netdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index cf0aa16d754070ebf2d9e05e7146b604674bcbfd..99fcc5661674bebf20f2f9ac0c6ef74e085b6d6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -456,7 +456,7 @@ static int otx2vf_change_mtu(struct net_device *netdev, int new_mtu)
 
 	netdev_info(netdev, "Changing MTU from %d to %d\n",
 		    netdev->mtu, new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (if_up)
 		err = otx2vf_open(netdev);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index ba6d53ac7f55206d66241d1c09ed88741abcd775..63ae01954dfc5e049615b7322322699cb166ff0f 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -489,7 +489,7 @@ static int prestera_port_change_mtu(struct net_device *dev, int mtu)
 	if (err)
 		return err;
 
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index dd6ca2e4fd517be87bb62f5794345a24317ba0a8..1a59c952aa01c157a95a46d9325e448b8b7dc942 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1188,7 +1188,7 @@ static int pxa168_eth_change_mtu(struct net_device *dev, int mtu)
 {
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	set_port_config_ext(pep);
 
 	if (!netif_running(dev))
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 1b43704baceb5284a20ed323a06ec81d5e9318c7..fcfb34561882b0804206504cc03619228b5ffa20 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -2905,13 +2905,13 @@ static int skge_change_mtu(struct net_device *dev, int new_mtu)
 	int err;
 
 	if (!netif_running(dev)) {
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		return 0;
 	}
 
 	skge_down(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	err = skge_up(dev);
 	if (err)
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index f3f7f4cc27b3af58b855c0c1ed72c1214c470f2a..a7a16eac189134e3822c346b7bb741096f8945ae 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2384,7 +2384,7 @@ static int sky2_change_mtu(struct net_device *dev, int new_mtu)
 	u32 imask;
 
 	if (!netif_running(dev)) {
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		netdev_update_features(dev);
 		return 0;
 	}
@@ -2407,7 +2407,7 @@ static int sky2_change_mtu(struct net_device *dev, int new_mtu)
 	sky2_rx_stop(sky2);
 	sky2_rx_clean(sky2);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	netdev_update_features(dev);
 
 	mode = DATA_BLIND_VAL(DATA_BLIND_DEF) |	GM_SMOD_VLAN_ENA;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d7a96dc11c079f4cd2317325ae6fa9235fc8cb41..179c0230655a8e77a0950b6baed41994e914ec5a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4055,7 +4055,7 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	}
 
 	mtk_set_mcr_max_rx(mac, length);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 5d3fde63b273922f52f2466c7b339f3c9908e705..4c089cfa027af969e5511f94bafa4e5553bd93ff 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1649,7 +1649,7 @@ int mlx4_en_start_port(struct net_device *dev)
 	       sizeof(struct ethtool_flow_id) * MAX_NUM_OF_FS_RULES);
 
 	/* Calculate Rx buf size */
-	dev->mtu = min(dev->mtu, priv->max_mtu);
+	WRITE_ONCE(dev->mtu, min(dev->mtu, priv->max_mtu));
 	mlx4_en_calc_rx_buf(dev);
 	en_dbg(DRV, priv, "Rx buf size:%d\n", priv->rx_skb_size);
 
@@ -2394,7 +2394,7 @@ static int mlx4_en_change_mtu(struct net_device *dev, int new_mtu)
 	    !mlx4_en_check_xdp_mtu(dev, new_mtu))
 		return -EOPNOTSUPP;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (netif_running(dev)) {
 		mutex_lock(&mdev->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3bd0695845c7d0d597aca104f19773f506027a06..ffe8919494d55a1c054ca1a706c7dbb0f47486f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4525,7 +4525,7 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, reset);
 
 out:
-	netdev->mtu = params->sw_mtu;
+	WRITE_ONCE(netdev->mtu, params->sw_mtu);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index d77be1b4dd9c557b70ba74e3ebb37ac7994a4486..8e0404c0d1ca8df69a9098678e082c5f715e18bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -531,7 +531,7 @@ static int mlx5i_change_mtu(struct net_device *netdev, int new_mtu)
 	if (err)
 		goto out;
 
-	netdev->mtu = new_params.sw_mtu;
+	WRITE_ONCE(netdev->mtu, new_params.sw_mtu);
 
 out:
 	mutex_unlock(&priv->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index f87471306f6b540b20a1706a3171738532e46cd4..028a76944d82d950b5aa839fdc2bfe38c71891ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -280,7 +280,7 @@ static int mlx5i_pkey_change_mtu(struct net_device *netdev, int new_mtu)
 	struct mlx5e_priv *priv = mlx5i_epriv(netdev);
 
 	mutex_lock(&priv->state_lock);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	mutex_unlock(&priv->state_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index bb642e9bb6cf8be5e532b2664e06f037c459d8ec..030ed71f945d6cc0e183c0ad0248127c131978de 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -825,7 +825,7 @@ static int mlxsw_sp_port_change_mtu(struct net_device *dev, int mtu)
 	err = mlxsw_sp_port_mtu_set(mlxsw_sp_port, mtu);
 	if (err)
 		goto err_port_mtu_set;
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	return 0;
 
 err_port_mtu_set:
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index c5aeeb964c17a85b8af12e00afa3391c6049c9b2..dc1d9f7745658ec03d1b1dcae300c6cf7df85265 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -5427,7 +5427,7 @@ static int netdev_change_mtu(struct net_device *dev, int new_mtu)
 	}
 	hw_mtu = (hw_mtu + 3) & ~3;
 	hw_priv->mtu = hw_mtu;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index cee47729d022f02332bec68f1991f77052be1d55..6be8a43c908a8d08d303b36845c8260d70aa1ad3 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3184,7 +3184,7 @@ static int lan743x_netdev_change_mtu(struct net_device *netdev, int new_mtu)
 
 	ret = lan743x_mac_set_mtu(adapter, new_mtu);
 	if (!ret)
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index b7e75da658340403b6645d465b31f562ca44d75f..b12d3b8a64fd3f655f5a4462351f0e360d9e9055 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -402,7 +402,7 @@ static int lan966x_port_change_mtu(struct net_device *dev, int new_mtu)
 
 	lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(LAN966X_HW_MTU(new_mtu)),
 	       lan966x, DEV_MAC_MAXLEN_CFG(port->chip_port));
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (!lan966x->fdma)
 		return 0;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f2fae659bf3b27afef19170aaadd0066817ac0f0..d087cf954f7552170d6d81dccc43b08bf5b20ba8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -690,12 +690,12 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 		goto out;
 	}
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	err = mana_attach(ndev);
 	if (err) {
 		netdev_err(ndev, "mana_attach failed: %d\n", err);
-		ndev->mtu = old_mtu;
+		WRITE_ONCE(ndev->mtu, old_mtu);
 	}
 
 out:
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 7b7e1c5b00f4728cccfb693e2ab4e32b9613616e..b7d9657a7af3d168ea6fa6acd205d690fc79db06 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -3036,11 +3036,11 @@ static int myri10ge_change_mtu(struct net_device *dev, int new_mtu)
 		/* if we change the mtu on an active device, we must
 		 * reset the device so the firmware sees the change */
 		myri10ge_close(dev);
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		myri10ge_open(dev);
-	} else
-		dev->mtu = new_mtu;
-
+	} else {
+		WRITE_ONCE(dev->mtu, new_mtu);
+	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index 650a5a16607012b832c678a0e7417e93770c0c97..ad0c14849115dd051fe1bf4ace2938ae65b2951f 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -2526,7 +2526,7 @@ static void __set_rx_mode(struct net_device *dev)
 
 static int natsemi_change_mtu(struct net_device *dev, int new_mtu)
 {
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	/* synchronized against open : rtnl_lock() held by caller */
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 55408f16fbbc4d4f50e57a0bb43de030dbd7d3f9..f235e76e4ce9a0ca7946ea5218775fdc7dbdeb01 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -6637,7 +6637,7 @@ static int s2io_change_mtu(struct net_device *dev, int new_mtu)
 	struct s2io_nic *sp = netdev_priv(dev);
 	int ret = 0;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	if (netif_running(dev)) {
 		s2io_stop_all_tx_queue(sp);
 		s2io_card_down(sp);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 997cc4fcffdbfd4ea8727351b45593dbb679609f..182ba0a8b095bc2294663dc9d77f7942f0367fb7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1526,7 +1526,7 @@ static void nfp_net_dp_swap(struct nfp_net *nn, struct nfp_net_dp *dp)
 	*dp = nn->dp;
 	nn->dp = new_dp;
 
-	nn->dp.netdev->mtu = new_dp.mtu;
+	WRITE_ONCE(nn->dp.netdev->mtu, new_dp.mtu);
 
 	if (!netif_is_rxfh_configured(nn->dp.netdev))
 		nfp_net_rss_init_itbl(nn);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 3af1229a3f08d244fac1001409bb9e5fb71ca54e..eee0bfc41074ee9af6dd0efd0bcc0998c0c2c43c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -177,7 +177,7 @@ static int nfp_repr_change_mtu(struct net_device *netdev, int new_mtu)
 	if (err)
 		return err;
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index fa1f78b03cb2b94543cc34d96eb0ddf6a4b91a88..2aa4ad9cf96e8920a92d2099fbfab7b612b7a31e 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -946,7 +946,7 @@ static int nixge_change_mtu(struct net_device *ndev, int new_mtu)
 	     NIXGE_MAX_JUMBO_FRAME_SIZE)
 		return -EINVAL;
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 31f896c4aa266032cbabdd3c0086eae5969d203a..720f577929dbf0a3386f84bf324e535e8e62b4c9 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -3098,7 +3098,7 @@ static int nv_change_mtu(struct net_device *dev, int new_mtu)
 	int old_mtu;
 
 	old_mtu = dev->mtu;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	/* return early if the buffer sizes will not change */
 	if (old_mtu <= ETH_DATA_LEN && new_mtu <= ETH_DATA_LEN)
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 28b7cec485ef0ee9ce23e972ac91e122bbdfae34..4ac29cd59f2bfcc83caf83fa8b26718465557d99 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2184,7 +2184,7 @@ static int pch_gbe_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	} else {
 		pch_gbe_reset(adapter);
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		adapter->hw.mac.max_frame_size = max_frame;
 	}
 
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index ed7dd0a042355b274fb03f26cf702d9bd3397a74..62ba269da90265f8aef27e1de757c49193e5a680 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1639,7 +1639,7 @@ static int pasemi_mac_change_mtu(struct net_device *dev, int new_mtu)
 	reg |= PAS_MAC_CFG_MACCFG_MAXF(new_mtu + ETH_HLEN + 4);
 	write_mac_reg(mac, PAS_MAC_CFG_MACCFG, reg);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	/* MTU + ETH_HLEN + VLAN_HLEN + 2 64B cachelines */
 	mac->bufsz = new_mtu + ETH_HLEN + ETH_FCS_LEN + LOCAL_SKB_ALIGN + 128;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7f0c6cdc375e3686fb870739067b7faa712ed565..24870da3f4848857d2d6012ed82c78d2f031f7a1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1761,13 +1761,13 @@ static int ionic_change_mtu(struct net_device *netdev, int new_mtu)
 
 	/* if we're not running, nothing more to do */
 	if (!netif_running(netdev)) {
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		return 0;
 	}
 
 	mutex_lock(&lif->queue_lock);
 	ionic_stop_queues_reconfig(lif);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	err = ionic_start_queues_reconfig(lif);
 	mutex_unlock(&lif->queue_lock);
 
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index 6e12cd21ac906b091ae0c1e545f031866461033b..89c8b234969429798bbf8e81f90ac9f8cff86a65 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -960,7 +960,7 @@ int netxen_nic_change_mtu(struct net_device *netdev, int mtu)
 		rc = adapter->set_mtu(adapter, mtu);
 
 	if (!rc)
-		netdev->mtu = mtu;
+		WRITE_ONCE(netdev->mtu, mtu);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index ae3ebf0cf9990d5d5e2bd861f5d6539a5ee7775c..f497f6ca101887aff04681669b2af20e03b0bb33 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1026,7 +1026,7 @@ static int qede_get_regs_len(struct net_device *ndev)
 static void qede_update_mtu(struct qede_dev *edev,
 			    struct qede_reload_args *args)
 {
-	edev->ndev->mtu = args->u.mtu;
+	WRITE_ONCE(edev->ndev->mtu, args->u.mtu);
 }
 
 /* Netdevice NDOs */
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index 4b8bc46f55c29439952ad89706aea3d7b4e2bc4e..ae4ee0326ee15218f5e728ff9d0e4baf86e10a71 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -1015,7 +1015,7 @@ int qlcnic_change_mtu(struct net_device *netdev, int mtu)
 	rc = qlcnic_fw_cmd_set_mtu(adapter, mtu);
 
 	if (!rc)
-		netdev->mtu = mtu;
+		WRITE_ONCE(netdev->mtu, mtu);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 4c06f55878de9ab41a9c2346f05869c5ad80249e..99d4647bf245dfef84371b6f51970c9c2e3b8be1 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -216,7 +216,7 @@ static int emac_change_mtu(struct net_device *netdev, int new_mtu)
 	netif_dbg(adpt, hw, adpt->netdev,
 		  "changing MTU from %d to %d\n", netdev->mtu,
 		  new_mtu);
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev))
 		return emac_reinit_locked(adpt);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 9d2a9562c96ff4937da7a389c773acce01508ca3..f1e40aade127bf1033c06128049c558e72d9474b 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -90,7 +90,7 @@ static int rmnet_vnd_change_mtu(struct net_device *rmnet_dev, int new_mtu)
 	    new_mtu > (priv->real_dev->mtu - headroom))
 		return -EINVAL;
 
-	rmnet_dev->mtu = new_mtu;
+	WRITE_ONCE(rmnet_dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index f5786d78ed2306a735e78f8a2c925d2170e93232..5652da8a178c0885920439217031b58c6ea9f41d 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1277,14 +1277,14 @@ static int cp_change_mtu(struct net_device *dev, int new_mtu)
 
 	/* if network interface not up, no need for complexity */
 	if (!netif_running(dev)) {
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		cp_set_rxbufsize(cp);	/* set new rx buf size */
 		return 0;
 	}
 
 	/* network IS up, close it, reset MTU, and come up again. */
 	cp_close(dev);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	cp_set_rxbufsize(cp);
 	return cp_open(dev);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fab21d2bc4ffa1f01c611382dfa790b9c7b1565c..5abbea91bc07e55e265dd04d98f34d831cc5995d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3924,7 +3924,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	netdev_update_features(dev);
 	rtl_jumbo_config(tp);
 	rtl_set_eee_txidle_timer(tp);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 384ddad65aaf641a30a0c73f2278521021925b35..4d100283c30fb4958feeb23f5686bdd70be4cf25 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2423,7 +2423,7 @@ static int ravb_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	if (netif_running(ndev)) {
 		synchronize_irq(priv->emac_irq);
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 0786eb0da39143da2ba2a550e3b936fc2669ec5f..7a25903e35c305bdb9b899431244e2e102767402 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2624,7 +2624,7 @@ static int sh_eth_change_mtu(struct net_device *ndev, int new_mtu)
 	if (netif_running(ndev))
 		return -EBUSY;
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 	netdev_update_features(ndev);
 
 	return 0;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 755db89db90998158e32be08890d1bb19e925bd4..e097ce3e69ea3b40b4a529b42c97a7915968f77e 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1967,7 +1967,7 @@ static int rocker_port_change_mtu(struct net_device *dev, int new_mtu)
 		rocker_port_stop(dev);
 
 	netdev_info(dev, "MTU change from %d to %d\n", dev->mtu, new_mtu);
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	err = rocker_cmd_set_port_settings_mtu(rocker_port, new_mtu);
 	if (err)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index ecbe3994f2b1b9987b4be6be5ed2fc6b026ef4fe..12c8396b6942dd716ecff7f329d6a2f4f71d431f 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1804,7 +1804,7 @@ static int sxgbe_set_features(struct net_device *dev,
  */
 static int sxgbe_change_mtu(struct net_device *dev, int new_mtu)
 {
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (!netif_running(dev))
 		return 0;
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 551f890db90a609319dca95af9b464bddb252121..4ebd5ae23ecaeca55a4d51de2896aac0e6f3d55e 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -302,7 +302,7 @@ int efx_change_mtu(struct net_device *net_dev, int new_mtu)
 	efx_stop_all(efx);
 
 	mutex_lock(&efx->mac_lock);
-	net_dev->mtu = new_mtu;
+	WRITE_ONCE(net_dev->mtu, new_mtu);
 	efx_mac_reconfigure(efx, true);
 	mutex_unlock(&efx->mac_lock);
 
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 1cb32aedd89c7393c7881efb11963cf334bca3ae..8925745f1c17f7d2ddf2e175508aede8e519d351 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2125,7 +2125,7 @@ static int ef4_change_mtu(struct net_device *net_dev, int new_mtu)
 	ef4_stop_all(efx);
 
 	mutex_lock(&efx->mac_lock);
-	net_dev->mtu = new_mtu;
+	WRITE_ONCE(net_dev->mtu, new_mtu);
 	ef4_mac_reconfigure(efx);
 	mutex_unlock(&efx->mac_lock);
 
diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
index 88e5bc347a44cea66e36dcc6afe10ef10c1383fa..cf195162e27087422cef9670b9e206e1d7a513be 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -306,7 +306,7 @@ int efx_siena_change_mtu(struct net_device *net_dev, int new_mtu)
 	efx_siena_stop_all(efx);
 
 	mutex_lock(&efx->mac_lock);
-	net_dev->mtu = new_mtu;
+	WRITE_ONCE(net_dev->mtu, new_mtu);
 	efx_siena_mac_reconfigure(efx, true);
 	mutex_unlock(&efx->mac_lock);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59bf83904b62d8317286e8555cc1cc98b52aaae0..3d828904db0d38ad73c5274ce7c32d51a6940267 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5909,7 +5909,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		stmmac_set_rx_mode(dev);
 	}
 
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	netdev_update_features(dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 8f1f43dbb76dc3ecdb14baf80b3a3de72b7ceb45..b8948d5b779afa4a6d01302e9ddcebb5a54bb36d 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -3804,7 +3804,7 @@ static int cas_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct cas *cp = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	if (!netif_running(dev) || !netif_device_present(dev))
 		return 0;
 
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index f68aa813d4fb1099aaaecc72b6c6b2b840ad2029..41a27ae58cedf68587b84214ef1663f1efac3ade 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6751,7 +6751,7 @@ static int niu_change_mtu(struct net_device *dev, int new_mtu)
 	orig_jumbo = (dev->mtu > ETH_DATA_LEN);
 	new_jumbo = (new_mtu > ETH_DATA_LEN);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (!netif_running(dev) ||
 	    (orig_jumbo == new_jumbo))
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 9bd1df8308d24a750eed693efc2aedb5c42e470f..4aa356e2f29933f1c36dc043e0b47660a4b0a2d0 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2499,7 +2499,7 @@ static int gem_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct gem *gp = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	/* We'll just catch it later when the device is up'd or resumed */
 	if (!netif_running(dev) || !netif_device_present(dev))
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
index 36b948820c1e56bc338a6317bf3da5b9010b270a..d1793b6154c75fe7b1cbda521cbb18b08a14c0ec 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
@@ -823,7 +823,7 @@ static int xlgmac_change_mtu(struct net_device *netdev, int mtu)
 		return ret;
 
 	pdata->rx_buf_size = ret;
-	netdev->mtu = mtu;
+	WRITE_ONCE(netdev->mtu, mtu);
 
 	xlgmac_restart_dev(pdata);
 
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index ca409515ead5a43adcfd5bc84bea70bb21cd470d..ede5f7890fb4b001c0fa714511124a75012c168a 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -756,7 +756,7 @@ static int bdx_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	ENTER;
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 	if (netif_running(ndev)) {
 		bdx_close(ndev);
 		bdx_open(ndev);
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 1c6b2a9bba081159d506b0ea24476cf6f8456d5d..55fff4d0d380128a143d884d645569f62304c231 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -2294,7 +2294,7 @@ static int velocity_change_mtu(struct net_device *dev, int new_mtu)
 	int ret = 0;
 
 	if (!netif_running(dev)) {
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		goto out_0;
 	}
 
@@ -2336,7 +2336,7 @@ static int velocity_change_mtu(struct net_device *dev, int new_mtu)
 		tmp_vptr->rx = rx;
 		tmp_vptr->tx = tx;
 
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 
 		velocity_init_registers(vptr, VELOCITY_INIT_COLD);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 945c13d1a98292afc73126430273f178c6e24965..3662483bfe2e782953cb895830c772af43a7c4f2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1408,7 +1408,7 @@ int wx_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 	wx_set_rx_buffer_len(wx);
 
 	return 0;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index aaf780fd4f5e750a904217737294ef92081197a6..c29809cd92015a2b9d9bc936f3592b6165505d9e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1641,7 +1641,7 @@ static int axienet_change_mtu(struct net_device *ndev, int new_mtu)
 		XAE_TRL_SIZE) > lp->rxmem)
 		return -EINVAL;
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e0d26148dfd95cf5eace5027cc06a43ecc737cb5..8aff6a73ca0a24da96a8715fb7445c7e473d30a9 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1233,7 +1233,7 @@ static int ixp4xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 			return ret;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 5fbe33a09bb0b8b13225d2152f6788e586af7bd1..6411da359e5aa2d7fda907da7fdb9b011391fe0b 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -811,7 +811,7 @@ static int fjes_change_mtu(struct net_device *netdev, int new_mtu)
 		netif_tx_stop_all_queues(netdev);
 	}
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (running) {
 		for (epidx = 0; epidx < hw->max_epid; epidx++) {
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index f918ca6146c82d65e055bc642e78a518a9519354..51495cb4b9be49d654255fcb31159ed36a1c44e6 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1059,7 +1059,7 @@ static int geneve_change_mtu(struct net_device *dev, int new_mtu)
 	else if (new_mtu < dev->min_mtu)
 		new_mtu = dev->min_mtu;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 11831a1c97623985401317e690b66f6985abb750..44142245343d95c753fe6c8b211cfdff0e606c9d 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1233,14 +1233,14 @@ static int netvsc_change_mtu(struct net_device *ndev, int mtu)
 	if (ret)
 		goto rollback_vf;
 
-	ndev->mtu = mtu;
+	WRITE_ONCE(ndev->mtu, mtu);
 
 	ret = netvsc_attach(ndev, device_info);
 	if (!ret)
 		goto out;
 
 	/* Attempt rollback to original MTU */
-	ndev->mtu = orig_mtu;
+	WRITE_ONCE(ndev->mtu, orig_mtu);
 
 	if (netvsc_attach(ndev, device_info))
 		netdev_err(ndev, "restoring mtu failed\n");
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ff016c11b4a0383b6653a37ef4bc6344fff3f703..2da70bc3dd8695b7eee1be90df4d1f6e11f21d08 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3753,7 +3753,7 @@ static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 	if (macsec->real_dev->mtu - extra < new_mtu)
 		return -ERANGE;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0cec2783a3e712b7769572482bf59aa336b9ca15..67b7ef2d463faae1f13c48b7917d9b5269293b2b 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -865,7 +865,7 @@ static int macvlan_change_mtu(struct net_device *dev, int new_mtu)
 
 	if (vlan->lowerdev->mtu < new_mtu)
 		return -EINVAL;
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0c916a53d7ce4689e51eeffdfdaa5dd997ae529..963d8b4af28d797652c776a74c670697f3db3515 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -231,7 +231,7 @@ static int net_failover_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d127856f8f366311391ef2f1f7a70745748ac5b5..e3a385a322695fc79693a8fb134c37142e769cde 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -74,7 +74,7 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 	if (ns->xdp.prog && new_mtu > NSIM_XDP_MAX_MTU)
 		return -EBUSY;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 536bd6564f8b8a44993b50b63e3e175cf5d0c22c..ffe7f463e16ee1ba1055b98c7ce887f7bf2ab81e 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -306,7 +306,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
-		ndev->mtu = new_mtu;
+		WRITE_ONCE(ndev->mtu, new_mtu);
 		return 0;
 	}
 
@@ -335,7 +335,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 		}
 	}
 
-	ndev->mtu = new_mtu;
+	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	ntb_transport_link_up(dev->qp);
 
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 0aba3569ccc0d4a19baa9b5b1f05cb03d47b20b9..fb362ee248ff26278e64e98e11caaecbf3d11432 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -286,7 +286,7 @@ static int sl_realloc_bufs(struct slip *sl, int mtu)
 		}
 	}
 	sl->mtu      = mtu;
-	dev->mtu      = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	sl->buffsize = len;
 	err = 0;
 
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 8c7dbaf7c22ebb720f81ac087e8ec51e59803915..ab1935a4aa2cd68459af8f3af2fcfb8345b437b9 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1831,7 +1831,7 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	team->port_mtu_change_allowed = false;
 	mutex_unlock(&team->lock);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 7b8afa589a53c457ef07878f207ddbaafa668c54..74571c8e7691983874af10e4fb187e0eed292b47 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -424,7 +424,7 @@ static int aqc111_change_mtu(struct net_device *net, int new_mtu)
 	u16 reg16 = 0;
 	u8 buf[5];
 
-	net->mtu = new_mtu;
+	WRITE_ONCE(net->mtu, new_mtu);
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 
 	aqc111_read16_cmd(dev, AQ_ACCESS_MAC, SFR_MEDIUM_STATUS_MODE,
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index f7cff58fe0449313748237d53ff69191b85e5e5e..57d6e5abc30e88555308ec18aa5d7dce1cf8f9f3 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1230,7 +1230,7 @@ static int ax88178_change_mtu(struct net_device *net, int new_mtu)
 	if ((ll_mtu % dev->maxpacket) == 0)
 		return -EDOM;
 
-	net->mtu = new_mtu;
+	WRITE_ONCE(net->mtu, new_mtu);
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	ax88178_set_mfb(dev);
 
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b25535aa15ae33c84fa3fdfa46b6e4d3c4980e4c..c5196b5313c0bd9141521c289959a38cf070bd2c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -943,7 +943,7 @@ static int ax88179_change_mtu(struct net_device *net, int new_mtu)
 	struct usbnet *dev = netdev_priv(net);
 	u16 tmp16;
 
-	net->mtu = new_mtu;
+	WRITE_ONCE(net->mtu, new_mtu);
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 
 	if (net->mtu > 1500) {
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index db05622f1f703ec6fc147935c296640c55499a4b..bf76ecccc2e6aed74473f85b372949e4c5708f0b 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -798,7 +798,7 @@ int cdc_ncm_change_mtu(struct net_device *net, int new_mtu)
 {
 	struct usbnet *dev = netdev_priv(net);
 
-	net->mtu = new_mtu;
+	WRITE_ONCE(net->mtu, new_mtu);
 	cdc_ncm_set_dgram_size(dev, new_mtu + cdc_ncm_eth_hlen(dev));
 
 	return 0;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 0030be502daa495a585974787d515d8565510d49..5a2c38b63012ceb6a1f3be523ff0f643c9eec914 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2528,7 +2528,7 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 
 	ret = lan78xx_set_rx_max_frame_length(dev, max_frame_len);
 	if (!ret)
-		netdev->mtu = new_mtu;
+		WRITE_ONCE(netdev->mtu, new_mtu);
 
 	usb_autopm_put_interface(dev->intf);
 
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 51e9f5b2dccff42119ba79c385ea87732eaa3709..19df1cd9f07243c06ab742fbda00c19c73593d55 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9365,7 +9365,7 @@ static int rtl8152_change_mtu(struct net_device *dev, int new_mtu)
 	case RTL_VER_01:
 	case RTL_VER_02:
 	case RTL_VER_07:
-		dev->mtu = new_mtu;
+		WRITE_ONCE(dev->mtu, new_mtu);
 		return 0;
 	default:
 		break;
@@ -9377,7 +9377,7 @@ static int rtl8152_change_mtu(struct net_device *dev, int new_mtu)
 
 	mutex_lock(&tp->control);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (netif_running(dev)) {
 		if (tp->rtl_ops.change_mtu)
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index f3f7f686fe9ce04fe998a44664d878fe6e51ae7c..9fd516e8bb107be4acd01fdef8ca3e19fb604b5b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -398,7 +398,7 @@ int usbnet_change_mtu (struct net_device *net, int new_mtu)
 	// no second zero-length packet read wanted after mtu-sized packets
 	if ((ll_mtu % dev->maxpacket) == 0)
 		return -EDOM;
-	net->mtu = new_mtu;
+	WRITE_ONCE(net->mtu, new_mtu);
 
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	if (dev->rx_urb_size == old_hard_mtu) {
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0578864792b60e6ab384af7f107b618df8e50b53..89ca6e75fcc6b066bad0cb3c2b18734df3a0dec3 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3457,7 +3457,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index a1ba5169ed5dbbe216cddc824f7f1d6405c0bf08..4c260074c091f167ee92b0bfda90175533695910 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -58,7 +58,7 @@ static int vsockmon_change_mtu(struct net_device *dev, int new_mtu)
 	if (!vsockmon_is_valid_mtu(new_mtu))
 		return -EINVAL;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8884913e04738b32848b951c671ae3ede9a828e7..086c90a43fc37879f651743618e81898ca94567e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3181,7 +3181,7 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 65db5f14465f3e1526c42ec0dffbf64d0160d46c..325fcb3d107591ae0eac5fa6687e04cad35d41e0 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -358,7 +358,7 @@ static int xenvif_change_mtu(struct net_device *dev, int mtu)
 
 	if (mtu > max)
 		return -EINVAL;
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	return 0;
 }
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 8d2aee88526c69cace53949a94d5f8040d32bbe7..4265c1cd0ff716c2825b15f4e546792082958ded 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1376,7 +1376,7 @@ static int xennet_change_mtu(struct net_device *dev, int mtu)
 
 	if (mtu > max)
 		return -EINVAL;
-	dev->mtu = mtu;
+	WRITE_ONCE(dev->mtu, mtu);
 	return 0;
 }
 
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 878fe3ce53ada11f1a70e2ec6be74eb84d0cef5e..b93c2eb45916de3b948a10fd57306688c82047cc 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -996,7 +996,7 @@ static int ctcm_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 		dev->hard_header_len = LL_HEADER_LENGTH + 2;
 	}
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 39876eff51d21f830c3bde1682e07aac698c633e..3efba4f857ac67ad4a13d612a06c33c706354332 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -149,7 +149,7 @@ static int vlan_dev_change_mtu(struct net_device *dev, int new_mtu)
 	if (max_mtu < new_mtu)
 		return -ERANGE;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 89c51b3cf43076e0f7cc5f851cf00a8059168f12..30ecbc2ef1fd9cb9d06674d039f65a4c4b53ec56 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -159,7 +159,7 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 	if (new_mtu < ETH_MIN_MTU || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ab4d33e0201424231bd11f06740a174bf8b8831d..71b50001ca588b815eed7e2e40eb8dfd68ea72d2 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -197,7 +197,7 @@ static int br_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	/* this flag will be cleared if the MTU was automatically adjusted */
 	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, true);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c94b868855aa1bcc163505553ecedee3cc21a5cb..1f7b8f21db9e4ff5aa6f1870c16882af86fa9aab 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2120,7 +2120,7 @@ int dsa_user_change_mtu(struct net_device *dev, int new_mtu)
 	if (err)
 		goto out_port_failed;
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	dsa_bridge_mtu_normalization(dp);
 
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 86127300b102fe06eaced32a979e1c8da99339a7..26d5282a649603a83648b93252be5ddf3ada3f03 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -123,7 +123,7 @@ static int hsr_dev_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
 }
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 9756e657bab97e95407b8907157b138159d68253..d7ae32473c41a641bff1c0783ca5867d8acae052 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -96,7 +96,7 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			break; /* Handled in ndo_change_mtu() */
 		mtu_max = hsr_get_max_mtu(port->hsr);
 		master = hsr_port_get_hsr(port->hsr, HSR_PT_MASTER);
-		master->dev->mtu = mtu_max;
+		WRITE_ONCE(master->dev->mtu, mtu_max);
 		break;
 	case NETDEV_UNREGISTER:
 		if (!is_hsr_master(dev)) {
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index c3af965dc40787f6a7cb11b2fcf6d34269a367af..ba205473522e4e6ca8eed831726b1fd48791638e 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -793,7 +793,7 @@ static void ipgre_link_update(struct net_device *dev, bool set_mtu)
 		dev->needed_headroom += len;
 
 	if (set_mtu)
-		dev->mtu = max_t(int, dev->mtu - len, 68);
+		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
 	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index ba46cf7612f4fc2cba33c098933b6578dd885587..bbc590f4a7c3602d7894bad0c5b039c724e38072 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -897,7 +897,7 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 		t->fwmark = fwmark;
 		mtu = ip_tunnel_bind_dev(dev);
 		if (set_mtu)
-			dev->mtu = mtu;
+			WRITE_ONCE(dev->mtu, mtu);
 	}
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(dev);
@@ -1082,7 +1082,7 @@ int __ip_tunnel_change_mtu(struct net_device *dev, int new_mtu, bool strict)
 		new_mtu = max_mtu;
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__ip_tunnel_change_mtu);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 57bb3b3ea0c5a463f0c90659fcffe9358a4084b2..3482c444dbaf9322af598cf4cf08b7ec6880daf2 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1746,7 +1746,7 @@ int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
 			return -EINVAL;
 	}
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 EXPORT_SYMBOL(ip6_tnl_change_mtu);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 78344cf3867eac74cdaff5eda5d603ba68db3828..590737c275379851f7bbd8c44e08c2d75ce7c375 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -666,7 +666,8 @@ static void vti6_link_config(struct ip6_tnl *t, bool keep_mtu)
 		dev->flags &= ~IFF_POINTOPOINT;
 
 	if (keep_mtu && dev->mtu) {
-		dev->mtu = clamp(dev->mtu, dev->min_mtu, dev->max_mtu);
+		WRITE_ONCE(dev->mtu,
+			   clamp(dev->mtu, dev->min_mtu, dev->max_mtu));
 		return;
 	}
 
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 59304611dc0050e525de5f45b2a3b8628b684ff3..bde4cc2d0a48ef027b9227d1d48611ae1a2c1e3f 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -424,7 +424,7 @@ static int teql_master_mtu(struct net_device *dev, int new_mtu)
 		} while ((q = NEXT_SLAVE(q)) != m->slaves);
 	}
 
-	dev->mtu = new_mtu;
+	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


